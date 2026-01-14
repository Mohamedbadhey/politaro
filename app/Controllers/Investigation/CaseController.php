<?php

namespace App\Controllers\Investigation;

use CodeIgniter\RESTful\ResourceController;

class CaseController extends ResourceController
{
    protected $format = 'json';
    
    /**
     * Get cases assigned to investigator
     */
    public function assignedCases()
    {
        $investigatorId = $GLOBALS['current_user']['userId'] ?? $this->request->userId ?? null;
        
        if (!$investigatorId) {
            return $this->fail('User ID not found. Please login again.', 401);
        }
        
        $caseModel = model('App\Models\CaseModel');
        
        $cases = $caseModel->getInvestigatorCases($investigatorId);
        
        return $this->respond([
            'status' => 'success',
            'data' => $cases
        ]);
    }
    
    /**
     * Get cases solved by investigators (closed without sending to court)
     */
    public function solvedByInvestigator()
    {
        $investigatorId = $GLOBALS['current_user']['userId'] ?? $this->request->userId ?? null;
        $role = $this->request->userRole;
        
        if (!$investigatorId) {
            return $this->fail('User ID not found. Please login again.', 401);
        }
        
        $caseModel = model('App\Models\CaseModel');
        
        // Admin/Super Admin can see all investigator-solved cases
        // Investigators see only their own solved cases
        $cases = $caseModel->getCasesSolvedByInvestigator($investigatorId, $role);
        
        return $this->respond([
            'status' => 'success',
            'data' => $cases
        ]);
    }
    
    /**
     * Get cases solved by court
     */
    public function solvedByCourt()
    {
        $userId = $GLOBALS['current_user']['userId'] ?? $this->request->userId ?? null;
        $role = $this->request->userRole;
        
        if (!$userId) {
            return $this->fail('User ID not found. Please login again.', 401);
        }
        
        $caseModel = model('App\Models\CaseModel');
        
        // Get all cases that were sent to court and closed by court
        $cases = $caseModel->getCasesSolvedByCourt($userId, $role);
        
        return $this->respond([
            'status' => 'success',
            'data' => $cases
        ]);
    }
    
    /**
     * Get case details
     */
    public function show($id = null)
    {
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->getFullCaseDetails($id);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Check if user is assigned to this case
        $investigatorId = $this->request->userId;
        $role = $this->request->userRole;
        
        if (!in_array($role, ['admin', 'super_admin'])) {
            $db = \Config\Database::connect();
            $assignment = $db->table('case_assignments')
                ->where('case_id', $id)
                ->where('investigator_id', $investigatorId)
                ->where('status', 'active')
                ->get()
                ->getRowArray();
            
            if (!$assignment) {
                return $this->failForbidden('You are not assigned to this case');
            }
        }
        
        return $this->respond([
            'status' => 'success',
            'data' => $case
        ]);
    }
    
    /**
     * Close case (internal resolution)
     */
    public function closeCase($id = null)
    {
        $rules = [
            'closure_reason' => 'required|min_length[20]'
        ];
        
        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors(), 400);
        }
        
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($id);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Verify investigator is assigned
        $db = \Config\Database::connect();
        $assignment = $db->table('case_assignments')
            ->where('case_id', $id)
            ->where('investigator_id', $this->request->userId)
            ->where('is_lead_investigator', 1)
            ->where('status', 'active')
            ->get()
            ->getRowArray();
        
        if (!$assignment && !in_array($this->request->userRole, ['admin', 'super_admin'])) {
            return $this->failForbidden('Only lead investigator can close the case');
        }
        
        $input = $this->request->getJSON(true) ?? $this->request->getPost();
        $userId = $GLOBALS['current_user']['userId'] ?? $this->request->userId ?? null;
        
        if (!$userId) {
            return $this->fail('User ID not found. Please login again.', 401);
        }
        
        try {
            $db->transStart();
            
            // Update case
            $caseModel->update($id, [
                'status' => 'closed',
                'court_status' => $case['court_status'] === 'court_assigned_back' ? 'court_assigned_back' : 'not_sent',
                'closed_date' => date('Y-m-d H:i:s'),
                'closed_by' => $userId,
                'closure_reason' => $input['closure_reason'],
                'investigation_completed_at' => date('Y-m-d H:i:s')
            ]);
            
            // Log status change
            $historyModel = model('App\Models\CaseStatusHistoryModel');
            $historyModel->logStatusChange([
                'case_id' => $id,
                'old_status' => $case['status'],
                'new_status' => 'closed',
                'old_court_status' => $case['court_status'] ?? 'not_sent',
                'new_court_status' => $case['court_status'] ?? 'not_sent',
                'changed_by' => $userId,
                'change_reason' => 'Case closed by investigator'
            ]);
            
            // Mark assignments as completed
            $db->table('case_assignments')
                ->where('case_id', $id)
                ->where('status', 'active')
                ->update([
                    'status' => 'completed',
                    'completed_at' => date('Y-m-d H:i:s')
                ]);
            
            // Complete court assignment if exists
            $courtAssignmentModel = model('App\Models\CourtAssignmentModel');
            $courtAssignment = $db->table('court_assignments')
                ->where('case_id', $id)
                ->where('status', 'active')
                ->get()
                ->getRowArray();
            
            if ($courtAssignment) {
                $courtAssignmentModel->completeAssignment($courtAssignment['id']);
                
                // Notify court user
                $notificationModel = model('App\Models\NotificationModel');
                $notificationModel->createNotification([
                    'user_id' => $courtAssignment['assigned_by'],
                    'case_id' => $id,
                    'type' => 'case_closed',
                    'title' => 'Case Closed',
                    'message' => "Case #{$case['case_number']} has been closed by the investigator.",
                    'link' => "/court/cases/view/{$id}"
                ]);
            }
            
            $db->transComplete();
            
            if ($db->transStatus() === false) {
                return $this->fail('Failed to close case', 500);
            }
            
            return $this->respond([
                'status' => 'success',
                'message' => 'Case closed successfully'
            ]);
        } catch (\Exception $e) {
            log_message('error', 'Case closure failed: ' . $e->getMessage());
            return $this->fail('Failed to close case', 500);
        }
    }
    
    /**
     * Send case to court
     */
    public function sendToCourt($id = null)
    {
        $rules = [
            'court_notes' => 'permit_empty|max_length[1000]'
        ];
        
        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors(), 400);
        }
        
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($id);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Verify investigator is assigned
        $db = \Config\Database::connect();
        $assignment = $db->table('case_assignments')
            ->where('case_id', $id)
            ->where('investigator_id', $this->request->userId)
            ->where('is_lead_investigator', 1)
            ->where('status', 'active')
            ->get()
            ->getRowArray();
        
        if (!$assignment && !in_array($this->request->userRole, ['admin', 'super_admin'])) {
            return $this->failForbidden('Only lead investigator can send case to court');
        }
        
        // Check if already sent to court
        if ($case['court_status'] && in_array($case['court_status'], ['sent_to_court', 'court_review', 'court_assigned_back', 'court_closed'])) {
            return $this->fail('Case is already in court process or has been closed by court', 400);
        }
        
        $input = $this->request->getJSON(true) ?? $this->request->getPost();
        $userId = $GLOBALS['current_user']['userId'] ?? $this->request->userId ?? null;
        
        log_message('debug', '=== SEND TO COURT DEBUG START ===');
        log_message('debug', 'Case ID: ' . $id . ' (type: ' . gettype($id) . ')');
        log_message('debug', 'User ID: ' . $userId . ' (type: ' . gettype($userId) . ')');
        log_message('debug', 'Input: ' . json_encode($input));
        log_message('debug', 'Case status: ' . ($case['status'] ?? 'NULL'));
        log_message('debug', 'Case court_status: ' . ($case['court_status'] ?? 'NULL'));
        
        if (!$userId) {
            return $this->fail('User ID not found. Please login again.', 401);
        }
        
        try {
            log_message('debug', 'Starting transaction...');
            $db->transStart();
            
            // Update case with explicit type casting
            $updateData = [
                'status' => 'pending_court',
                'court_status' => 'sent_to_court',
                'sent_to_court_date' => date('Y-m-d H:i:s'),
                'sent_to_court_by' => (int)$userId,
                'court_notes' => isset($input['court_notes']) && !empty($input['court_notes']) ? (string)$input['court_notes'] : null
            ];
            
            log_message('debug', 'Update data: ' . json_encode($updateData));
            log_message('debug', 'Updating case...');
            
            // Use raw query to avoid query builder issues
            $sql = "UPDATE cases SET 
                    status = ?, 
                    court_status = ?, 
                    sent_to_court_date = ?, 
                    sent_to_court_by = ?, 
                    court_notes = ? 
                    WHERE id = ?";
            $db->query($sql, [
                'pending_court',
                'sent_to_court',
                date('Y-m-d H:i:s'),
                (int)$userId,
                $updateData['court_notes'],
                (int)$id
            ]);
            
            log_message('debug', 'Case updated successfully');
            
            // Log status change
            log_message('debug', 'Logging status change...');
            
            // Use existing table structure: previous_status, new_status, changed_by, changed_at, reason
            $sql = "INSERT INTO case_status_history 
                    (case_id, previous_status, new_status, changed_by, changed_at, reason) 
                    VALUES (?, ?, ?, ?, ?, ?)";
            $db->query($sql, [
                (int)$id,
                (string)$case['status'],
                'pending_court',
                (int)$userId,
                date('Y-m-d H:i:s'),
                'Case sent to court by investigator. Court status changed from ' . ($case['court_status'] ?? 'not_sent') . ' to sent_to_court'
            ]);
            
            log_message('debug', 'Status change logged successfully');
            
            // Notify all court users
            log_message('debug', 'Fetching court users...');
            // Use raw query to avoid query builder issues
            $sql = "SELECT * FROM users WHERE role = ? AND is_active = ?";
            $courtUsers = $db->query($sql, ['court_user', '1'])->getResultArray();
            
            log_message('debug', 'Found ' . count($courtUsers) . ' court users');
            
            // Create notifications using raw query (matching existing table structure)
            foreach ($courtUsers as $courtUser) {
                log_message('debug', 'Notifying user ID: ' . $courtUser['id']);
                try {
                    $sql = "INSERT INTO notifications 
                            (user_id, notification_type, title, message, link_entity_type, link_entity_id, link_url, is_read, priority, created_at) 
                            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    $db->query($sql, [
                        (int)$courtUser['id'],
                        'status_changed',  // Use existing enum value
                        'New Case for Court',
                        "Case #{$case['case_number']} has been sent to court for review.",
                        'case',
                        (int)$id,
                        "/court/cases/view/{$id}",
                        0,
                        'high',
                        date('Y-m-d H:i:s')
                    ]);
                } catch (\Exception $e) {
                    log_message('error', 'Failed to create notification for user ' . $courtUser['id'] . ': ' . $e->getMessage());
                    // Continue with other notifications even if one fails
                }
            }
            
            log_message('debug', 'Completing transaction...');
            $db->transComplete();
            
            if ($db->transStatus() === false) {
                log_message('error', 'Transaction failed!');
                return $this->fail('Failed to send case to court', 500);
            }
            
            log_message('debug', 'Transaction completed successfully');
            log_message('debug', '=== SEND TO COURT SUCCESS ===');
            
            return $this->respond([
                'status' => 'success',
                'message' => 'Case sent to court successfully'
            ]);
        } catch (\Exception $e) {
            log_message('error', '=== SEND TO COURT EXCEPTION ===');
            log_message('error', 'Message: ' . $e->getMessage());
            log_message('error', 'File: ' . $e->getFile() . ' Line: ' . $e->getLine());
            log_message('error', 'Trace: ' . $e->getTraceAsString());
            return $this->fail('Failed to send case to court: ' . $e->getMessage(), 500);
        }
    }
    
    /**
     * Prepare case for court escalation
     */
    public function escalateToCourtPrep($id = null)
    {
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($id);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Verify investigator is assigned
        $db = \Config\Database::connect();
        $assignment = $db->table('case_assignments')
            ->where('case_id', $id)
            ->where('investigator_id', $this->request->userId)
            ->where('is_lead_investigator', 1)
            ->where('status', 'active')
            ->get()
            ->getRowArray();
        
        if (!$assignment && !in_array($this->request->userRole, ['admin', 'super_admin'])) {
            return $this->failForbidden('Only lead investigator can escalate the case');
        }
        
        // Verify final report exists
        $finalReport = $db->table('investigation_reports')
            ->where('case_id', $id)
            ->where('report_type', 'final')
            ->where('is_signed', 1)
            ->get()
            ->getRowArray();
        
        if (!$finalReport) {
            return $this->fail('A signed final investigation report is required before court escalation', 400);
        }
        
        $caseModel->update($id, [
            'outcome' => 'escalated_to_court',
            'investigation_completed_at' => date('Y-m-d H:i:s')
        ]);
        
        $caseModel->updateStatus($id, 'escalated', $this->request->userId);
        
        return $this->respond([
            'status' => 'success',
            'message' => 'Case prepared for court submission'
        ]);
    }
    
    /**
     * Add a new party (accused/accuser) to a case
     */
    public function addParty($caseId = null)
    {
        // Verify case exists
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($caseId);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Verify investigator is assigned to this case
        $db = \Config\Database::connect();
        $assignment = $db->table('case_assignments')
            ->where('case_id', $caseId)
            ->where('investigator_id', $this->request->userId)
            ->where('status', 'active')
            ->get()
            ->getRowArray();
        
        if (!$assignment && !in_array($this->request->userRole, ['admin', 'super_admin'])) {
            return $this->failForbidden('You are not assigned to this case');
        }
        
        // Validate input
        $rules = [
            'person_type' => 'required|in_list[accused,accuser,witness]',
            'first_name' => 'required|max_length[100]',
            'last_name' => 'required|max_length[100]'
        ];
        
        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors(), 400);
        }
        
        // Get input data (works for both JSON and form-data)
        $input = $this->request->getPost();
        if (empty($input)) {
            $input = $this->request->getJSON(true);
        }
        
        $personData = [
            'person_type' => $input['person_type'] ?? null,
            'first_name' => $input['first_name'] ?? null,
            'middle_name' => $input['middle_name'] ?? null,
            'last_name' => $input['last_name'] ?? null,
            'date_of_birth' => $input['date_of_birth'] ?? null,
            'gender' => $input['gender'] ?? null,
            'national_id' => $input['national_id'] ?? null,
            'phone' => $input['phone'] ?? null,
            'email' => $input['email'] ?? null,
            'address' => $input['address'] ?? null,
            'gps_latitude' => $input['gps_latitude'] ?? null,
            'gps_longitude' => $input['gps_longitude'] ?? null,
            'created_by' => $this->request->userId
        ];
        
        // Handle photo upload
        $photoFile = $this->request->getFile('photo');
        if ($photoFile && $photoFile->isValid() && !$photoFile->hasMoved()) {
            // Validate file - check if it's an image
            $mimeType = $photoFile->getMimeType();
            $allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
            
            if (!in_array($mimeType, $allowedTypes)) {
                return $this->fail('Uploaded file must be an image (JPEG, PNG, GIF, or WebP)', 400);
            }
            
            // Check file size (5MB max)
            if ($photoFile->getSize() > 5 * 1024 * 1024) {
                return $this->fail('Image file size must be less than 5MB', 400);
            }
            
            // Generate unique filename
            $newName = $photoFile->getRandomName();
            
            // Move file to uploads directory
            $uploadPath = WRITEPATH . 'uploads/persons/';
            
            // Create directory if it doesn't exist
            if (!is_dir($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }
            
            if ($photoFile->move($uploadPath, $newName)) {
                // Copy to public folder so it's web-accessible
                $publicPath = FCPATH . 'uploads/persons/';
                if (!is_dir($publicPath)) {
                    mkdir($publicPath, 0755, true);
                }
                copy($uploadPath . $newName, $publicPath . $newName);
                
                // Store web-accessible path
                $personData['photo_path'] = 'uploads/persons/' . $newName;
                log_message('info', 'Photo uploaded successfully: ' . $personData['photo_path']);
            } else {
                log_message('error', 'Failed to move uploaded photo');
            }
        }
        
        $personModel = model('App\Models\PersonModel');
        
        try {
            // Create person
            $personId = $personModel->insert($personData);
            
            if (!$personId) {
                $errors = $personModel->errors();
                return $this->fail(['error' => 'Failed to create person record', 'validation_errors' => $errors], 500);
            }
            
            // Link person to case
            $partyRole = $input['person_type']; // accused, accuser, witness
            
            // Check if already linked
            $existing = $db->table('case_parties')
                ->where('case_id', $caseId)
                ->where('person_id', $personId)
                ->where('party_role', $partyRole)
                ->get()
                ->getRowArray();
            
            if (!$existing) {
                $partyData = [
                    'case_id' => $caseId,
                    'person_id' => $personId,
                    'party_role' => $partyRole,
                    'is_primary' => 0 // Not primary since it's added later
                ];
                
                // Add witness affiliation if it's a witness
                if ($partyRole === 'witness' && isset($input['witness_affiliation'])) {
                    $partyData['witness_affiliation'] = $input['witness_affiliation'];
                    
                    // Add affiliated person ID if witness supports specific person
                    if (isset($input['affiliated_person_id']) && !empty($input['affiliated_person_id'])) {
                        $partyData['affiliated_person_id'] = $input['affiliated_person_id'];
                    }
                }
                
                $db->table('case_parties')->insert($partyData);
            }
            
            // Update repeat offender status if accused
            if ($partyRole === 'accused') {
                $personModel->updateRepeatOffenderStatus($personId);
            }
            
            // Get full person details
            $person = $personModel->find($personId);
            
            return $this->respondCreated([
                'status' => 'success',
                'message' => ucfirst($partyRole) . ' added to case successfully',
                'data' => $person
            ]);
            
        } catch (\Exception $e) {
            log_message('error', 'Add party exception: ' . $e->getMessage());
            log_message('error', 'Add party trace: ' . $e->getTraceAsString());
            return $this->fail([
                'error' => 'Failed to add party to case', 
                'message' => $e->getMessage(),
                'trace' => ENVIRONMENT === 'development' ? $e->getTraceAsString() : null
            ], 500);
        }
    }
    
    /**
     * Get party/person details
     */
    public function getParty($caseId = null, $personId = null)
    {
        // Verify case exists
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($caseId);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Verify person exists
        $personModel = model('App\Models\PersonModel');
        $person = $personModel->find($personId);
        
        if (!$person) {
            return $this->failNotFound('Person not found');
        }
        
        // Verify investigator is assigned to this case
        $db = \Config\Database::connect();
        $assignment = $db->table('case_assignments')
            ->where('case_id', $caseId)
            ->where('investigator_id', $this->request->userId)
            ->where('status', 'active')
            ->get()
            ->getRowArray();
        
        if (!$assignment && !in_array($this->request->userRole, ['admin', 'super_admin'])) {
            return $this->failForbidden('You are not assigned to this case');
        }
        
        // Verify person is linked to this case
        $caseParty = $db->table('case_parties')
            ->where('case_id', $caseId)
            ->where('person_id', $personId)
            ->get()
            ->getRowArray();
        
        if (!$caseParty) {
            return $this->failNotFound('Person is not linked to this case');
        }
        
        // Add case party info (including witness affiliation) to person data
        $person['party_role'] = $caseParty['party_role'];
        $person['witness_affiliation'] = $caseParty['witness_affiliation'] ?? null;
        $person['affiliated_person_id'] = $caseParty['affiliated_person_id'] ?? null;
        
        // Get affiliated person name if exists
        if ($person['affiliated_person_id']) {
            $affiliatedPerson = $personModel->find($person['affiliated_person_id']);
            if ($affiliatedPerson) {
                $person['affiliated_person_name'] = trim($affiliatedPerson['first_name'] . ' ' . ($affiliatedPerson['middle_name'] ?? '') . ' ' . $affiliatedPerson['last_name']);
            }
        }
        
        return $this->respond([
            'status' => 'success',
            'data' => $person
        ]);
    }
    
    /**
     * Update party information
     */
    public function updateParty($caseId = null, $personId = null)
    {
        // Verify case exists
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($caseId);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Verify person exists
        $personModel = model('App\Models\PersonModel');
        $person = $personModel->find($personId);
        
        if (!$person) {
            return $this->failNotFound('Person not found');
        }
        
        // Verify investigator is assigned to this case
        $db = \Config\Database::connect();
        $assignment = $db->table('case_assignments')
            ->where('case_id', $caseId)
            ->where('investigator_id', $this->request->userId)
            ->where('status', 'active')
            ->get()
            ->getRowArray();
        
        if (!$assignment && !in_array($this->request->userRole, ['admin', 'super_admin'])) {
            return $this->failForbidden('You are not assigned to this case');
        }
        
        // Get input data (works for both JSON and form-data)
        $input = $this->request->getPost();
        if (empty($input)) {
            $input = $this->request->getJSON(true);
        }
        
        $updateData = [];
        
        // Only update fields that are provided
        if (isset($input['first_name'])) $updateData['first_name'] = $input['first_name'];
        if (isset($input['middle_name'])) $updateData['middle_name'] = $input['middle_name'];
        if (isset($input['last_name'])) $updateData['last_name'] = $input['last_name'];
        if (isset($input['date_of_birth'])) $updateData['date_of_birth'] = $input['date_of_birth'];
        if (isset($input['gender'])) $updateData['gender'] = $input['gender'];
        if (isset($input['national_id'])) $updateData['national_id'] = $input['national_id'];
        if (isset($input['phone'])) $updateData['phone'] = $input['phone'];
        if (isset($input['email'])) $updateData['email'] = $input['email'];
        if (isset($input['address'])) $updateData['address'] = $input['address'];
        
        // Handle photo upload
        $photoFile = $this->request->getFile('photo');
        if ($photoFile && $photoFile->isValid() && !$photoFile->hasMoved()) {
            // Validate file - check if it's an image
            $mimeType = $photoFile->getMimeType();
            $allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
            
            if (!in_array($mimeType, $allowedTypes)) {
                return $this->fail('Uploaded file must be an image (JPEG, PNG, GIF, or WebP)', 400);
            }
            
            // Check file size (5MB max)
            if ($photoFile->getSize() > 5 * 1024 * 1024) {
                return $this->fail('Image file size must be less than 5MB', 400);
            }
            
            // Delete old photo if exists
            if (!empty($person['photo_path'])) {
                $oldPhotoPath = FCPATH . $person['photo_path'];
                if (file_exists($oldPhotoPath)) {
                    @unlink($oldPhotoPath);
                }
                $oldWritablePath = WRITEPATH . 'uploads/persons/' . basename($person['photo_path']);
                if (file_exists($oldWritablePath)) {
                    @unlink($oldWritablePath);
                }
            }
            
            // Generate unique filename
            $newName = $photoFile->getRandomName();
            
            // Move file to uploads directory
            $uploadPath = WRITEPATH . 'uploads/persons/';
            
            // Create directory if it doesn't exist
            if (!is_dir($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }
            
            if ($photoFile->move($uploadPath, $newName)) {
                // Copy to public folder so it's web-accessible
                $publicPath = FCPATH . 'uploads/persons/';
                if (!is_dir($publicPath)) {
                    mkdir($publicPath, 0755, true);
                }
                copy($uploadPath . $newName, $publicPath . $newName);
                
                // Store web-accessible path
                $updateData['photo_path'] = 'uploads/persons/' . $newName;
                log_message('info', 'Photo updated successfully: ' . $updateData['photo_path']);
            } else {
                log_message('error', 'Failed to move uploaded photo');
            }
        }
        
        try {
            // Update person
            if (!empty($updateData)) {
                $personModel->update($personId, $updateData);
            }
            
            // Update witness affiliation if provided
            if (isset($input['witness_affiliation'])) {
                $updateCasePartyData = ['witness_affiliation' => $input['witness_affiliation']];
                
                // Update affiliated person ID
                if (isset($input['affiliated_person_id'])) {
                    $updateCasePartyData['affiliated_person_id'] = !empty($input['affiliated_person_id']) ? $input['affiliated_person_id'] : null;
                }
                
                $db->table('case_parties')
                    ->where('case_id', $caseId)
                    ->where('person_id', $personId)
                    ->where('party_role', 'witness')
                    ->update($updateCasePartyData);
            }
            
            // Get updated person details
            $updatedPerson = $personModel->find($personId);
            
            return $this->respond([
                'status' => 'success',
                'message' => 'Person information updated successfully',
                'data' => $updatedPerson
            ]);
            
        } catch (\Exception $e) {
            log_message('error', 'Update party exception: ' . $e->getMessage());
            return $this->fail(['error' => 'Failed to update person information', 'message' => $e->getMessage()], 500);
        }
    }
    
    /**
     * Search for existing persons to add to case
     */
    public function searchPersons()
    {
        $keyword = $this->request->getGet('keyword');
        $personType = $this->request->getGet('person_type');
        
        if (!$keyword || strlen($keyword) < 2) {
            return $this->fail('Search keyword must be at least 2 characters', 400);
        }
        
        $personModel = model('App\Models\PersonModel');
        $persons = $personModel->searchPersons($keyword, $personType, 20);
        
        return $this->respond([
            'status' => 'success',
            'data' => $persons
        ]);
    }
    
    /**
     * Link existing person to case
     */
    public function linkExistingPerson($caseId = null)
    {
        // Verify case exists
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($caseId);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Verify investigator is assigned to this case
        $db = \Config\Database::connect();
        $assignment = $db->table('case_assignments')
            ->where('case_id', $caseId)
            ->where('investigator_id', $this->request->userId)
            ->where('status', 'active')
            ->get()
            ->getRowArray();
        
        if (!$assignment && !in_array($this->request->userRole, ['admin', 'super_admin'])) {
            return $this->failForbidden('You are not assigned to this case');
        }
        
        // Get input
        $input = $this->request->getJSON(true) ?? $this->request->getPost();
        
        $personId = $input['person_id'] ?? null;
        $partyRole = $input['party_role'] ?? null;
        
        if (!$personId || !$partyRole) {
            return $this->fail('person_id and party_role are required', 400);
        }
        
        if (!in_array($partyRole, ['accused', 'accuser', 'witness'])) {
            return $this->fail('Invalid party_role. Must be: accused, accuser, or witness', 400);
        }
        
        // Verify person exists
        $personModel = model('App\Models\PersonModel');
        $person = $personModel->find($personId);
        
        if (!$person) {
            return $this->failNotFound('Person not found');
        }
        
        try {
            // Check if already linked
            $existing = $db->table('case_parties')
                ->where('case_id', $caseId)
                ->where('person_id', $personId)
                ->where('party_role', $partyRole)
                ->get()
                ->getRowArray();
            
            if ($existing) {
                return $this->fail('This person is already linked to this case with the same role', 400);
            }
            
            // Link person to case
            $db->table('case_parties')->insert([
                'case_id' => $caseId,
                'person_id' => $personId,
                'party_role' => $partyRole,
                'is_primary' => 0
            ]);
            
            // Update repeat offender status if accused
            if ($partyRole === 'accused') {
                $personModel->updateRepeatOffenderStatus($personId);
            }
            
            return $this->respondCreated([
                'status' => 'success',
                'message' => 'Person linked to case successfully',
                'data' => $person
            ]);
            
        } catch (\Exception $e) {
            log_message('error', 'Link person exception: ' . $e->getMessage());
            return $this->fail(['error' => 'Failed to link person to case', 'message' => $e->getMessage()], 500);
        }
    }

public function getCourtAcknowledgment($caseId)
    {
        $db = \Config\Database::connect();
        $acknowledgment = $db->table('court_acknowledgments')
            ->where('case_id', $caseId)
            ->orderBy('uploaded_at', 'DESC')
            ->get()
            ->getRowArray();
        
        return $this->respond(['status' => 'success', 'data' => $acknowledgment]);
    }
    
    /**
     * Upload court acknowledgment
     */
    public function uploadCourtAcknowledgment($caseId)
    {
        $input = $this->request->getPost();
        $isUpdate = isset($input['update_only']) && $input['update_only'] == '1';
        
        // If update_only, just update notes without file
        if ($isUpdate && !isset($_FILES['court_acknowledgment'])) {
            $db = \Config\Database::connect();
            $db->table('court_acknowledgments')
                ->where('case_id', $caseId)
                ->update([
                    'notes' => $input['notes'] ?? null,
                    'uploaded_at' => date('Y-m-d H:i:s')
                ]);
            
            return $this->respond(['status' => 'success', 'message' => 'Updated']);
        }
        
        // Handle file upload
        if (!isset($_FILES['court_acknowledgment']) || $_FILES['court_acknowledgment']['error'] !== UPLOAD_ERR_OK) {
            return $this->fail('No file uploaded or upload error', 400);
        }
        
        $uploadedFile = $_FILES['court_acknowledgment'];
        
        // Validate extension
        $originalName = $uploadedFile['name'];
        $ext = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
        $allowedExts = ['jpg', 'jpeg', 'png', 'pdf'];
        
        if (!in_array($ext, $allowedExts)) {
            return $this->fail('Invalid file type. Only JPG, PNG, PDF allowed', 400);
        }
        
        // Check file size
        if ($uploadedFile['size'] > 10 * 1024 * 1024) {
            return $this->fail('File exceeds 10MB', 400);
        }
        
        // Generate new name
        $newName = uniqid() . '_' . time() . '.' . $ext;
        
        // Get temp file path
        $tmpPath = $uploadedFile['tmp_name'];
            
            // Move to writable folder
            $uploadPath = WRITEPATH . 'uploads/court-acknowledgments/';
            if (!is_dir($uploadPath)) {
                mkdir($uploadPath, 0755, true);
            }
            
            // Move uploaded file
            if (move_uploaded_file($tmpPath, $uploadPath . $newName)) {
                // Copy to public folder so it's web-accessible
                $publicPath = FCPATH . 'uploads/court-acknowledgments/';
                if (!is_dir($publicPath)) {
                    mkdir($publicPath, 0755, true);
                }
                copy($uploadPath . $newName, $publicPath . $newName);
                
                $db = \Config\Database::connect();
                $oldAck = $db->table('court_acknowledgments')->where('case_id', $caseId)->get()->getRowArray();
                
                // Delete old files if exists
                if ($oldAck) {
                    $oldPublicPath = FCPATH . $oldAck['file_path'];
                    if (file_exists($oldPublicPath)) @unlink($oldPublicPath);
                    $db->table('court_acknowledgments')->delete(['case_id' => $caseId]);
                }
                
                // Store web-accessible path
                $db->table('court_acknowledgments')->insert([
                    'case_id' => $caseId,
                    'file_path' => 'uploads/court-acknowledgments/' . $newName,
                    'file_name' => $originalName,
                    'file_type' => $ext,
                    'uploaded_at' => date('Y-m-d H:i:s'),
                    'uploaded_by' => $this->request->userId,
                    'notes' => $input['notes'] ?? null
                ]);
                
                log_message('info', 'Court acknowledgment uploaded: uploads/court-acknowledgments/' . $newName);
                
                return $this->respond(['status' => 'success', 'message' => 'Uploaded']);
            } else {
                return $this->fail('Failed to move uploaded file', 500);
            }
    }
    
    /**
     * Delete court acknowledgment
     */
    public function deleteCourtAcknowledgment($caseId)
    {
        $db = \Config\Database::connect();
        $ack = $db->table('court_acknowledgments')->where('case_id', $caseId)->get()->getRowArray();
        if ($ack) {
            // Delete from public folder
            $publicPath = FCPATH . $ack['file_path'];
            if (file_exists($publicPath)) {
                @unlink($publicPath);
            }
            $db->table('court_acknowledgments')->delete(['case_id' => $caseId]);
            return $this->respond(['status' => 'success', 'message' => 'Deleted']);
        }
        return $this->fail('Not found', 404);
    }
    
    /**
     * Get custody documentation
     */
    public function getCustodyDocumentation($caseId)
    {
        $db = \Config\Database::connect();
        $docs = $db->table('custody_documentation cd')
            ->select('cd.*, p.first_name, p.last_name')
            ->join('persons p', 'p.id = cd.accused_person_id')
            ->where('cd.case_id', $caseId)
            ->orderBy('cd.custody_start', 'DESC')
            ->get()
            ->getResultArray();
        return $this->respond(['status' => 'success', 'data' => $docs]);
    }
    
    /**
     * Save custody documentation
     */
    public function saveCustodyDocumentation($caseId)
    {
        $input = $this->request->getPost();
        $accusedPhoto = null;
        $courtOrderImage = null;
        
        if ($file = $this->request->getFile('accused_photo')) {
            if ($file->isValid() && !$file->hasMoved()) {
                $newName = $file->getRandomName();
                $uploadPath = WRITEPATH . 'uploads/custody-photos/';
                if (!is_dir($uploadPath)) mkdir($uploadPath, 0755, true);
                
                if ($file->move($uploadPath, $newName)) {
                    // Copy to public folder
                    $publicPath = FCPATH . 'uploads/custody-photos/';
                    if (!is_dir($publicPath)) mkdir($publicPath, 0755, true);
                    copy($uploadPath . $newName, $publicPath . $newName);
                    $accusedPhoto = 'uploads/custody-photos/' . $newName;
                }
            }
        }
        
        if ($file = $this->request->getFile('court_order_image')) {
            if ($file->isValid() && !$file->hasMoved()) {
                $newName = $file->getRandomName();
                $uploadPath = WRITEPATH . 'uploads/court-orders/';
                if (!is_dir($uploadPath)) mkdir($uploadPath, 0755, true);
                
                if ($file->move($uploadPath, $newName)) {
                    // Copy to public folder
                    $publicPath = FCPATH . 'uploads/court-orders/';
                    if (!is_dir($publicPath)) mkdir($publicPath, 0755, true);
                    copy($uploadPath . $newName, $publicPath . $newName);
                    $courtOrderImage = 'uploads/court-orders/' . $newName;
                }
            }
        }
        
        // Calculate custody end date
        $custodyEnd = null;
        $custodyDuration = null;
        if (isset($input['custody_duration_value']) && isset($input['custody_duration_unit'])) {
            $durationValue = (int)$input['custody_duration_value'];
            $durationUnit = $input['custody_duration_unit'];
            $custodyDuration = $durationValue . ' ' . $durationUnit;
            
            $startDate = new \DateTime($input['custody_start']);
            
            if ($durationUnit === 'days') {
                $startDate->add(new \DateInterval('P' . $durationValue . 'D'));
            } elseif ($durationUnit === 'months') {
                $startDate->add(new \DateInterval('P' . $durationValue . 'M'));
            } elseif ($durationUnit === 'years') {
                $startDate->add(new \DateInterval('P' . $durationValue . 'Y'));
            }
            
            $custodyEnd = $startDate->format('Y-m-d H:i:s');
        }
        
        $db = \Config\Database::connect();
        $db->table('custody_documentation')->insert([
            'case_id' => $caseId,
            'accused_person_id' => $input['accused_person_id'],
            'custody_start' => $input['custody_start'],
            'custody_end' => $custodyEnd,
            'custody_duration' => $custodyDuration,
            'custody_location' => $input['custody_location'],
            'accused_photo' => $accusedPhoto,
            'court_order_image' => $courtOrderImage,
            'notes' => $input['notes'] ?? null,
            'custody_status' => 'in_custody',
            'created_at' => date('Y-m-d H:i:s'),
            'created_by' => $this->request->userId
        ]);
        
        return $this->respond(['status' => 'success', 'message' => 'Saved']);
    }

/**
     * Update custody documentation
     */
    public function updateCustodyDocumentation($caseId, $custodyId)
    {
        $input = $this->request->getPost();
        $accusedPhoto = null;
        $courtOrderImage = null;
        
        $db = \Config\Database::connect();
        
        // Get existing record
        $existing = $db->table('custody_documentation')->where('id', $custodyId)->get()->getRowArray();
        if (!$existing) {
            return $this->fail('Custody record not found', 404);
        }
        
        // Handle photo uploads
        if ($file = $this->request->getFile('accused_photo')) {
            if ($file->isValid() && !$file->hasMoved()) {
                $newName = $file->getRandomName();
                $uploadPath = WRITEPATH . 'uploads/custody-photos/';
                if (!is_dir($uploadPath)) mkdir($uploadPath, 0755, true);
                
                if ($file->move($uploadPath, $newName)) {
                    $publicPath = FCPATH . 'uploads/custody-photos/';
                    if (!is_dir($publicPath)) mkdir($publicPath, 0755, true);
                    copy($uploadPath . $newName, $publicPath . $newName);
                    $accusedPhoto = 'uploads/custody-photos/' . $newName;
                    
                    if ($existing['accused_photo']) {
                        $oldPath = FCPATH . $existing['accused_photo'];
                        if (file_exists($oldPath)) @unlink($oldPath);
                    }
                }
            }
        }
        
        if ($file = $this->request->getFile('court_order_image')) {
            if ($file->isValid() && !$file->hasMoved()) {
                $newName = $file->getRandomName();
                $uploadPath = WRITEPATH . 'uploads/court-orders/';
                if (!is_dir($uploadPath)) mkdir($uploadPath, 0755, true);
                
                if ($file->move($uploadPath, $newName)) {
                    $publicPath = FCPATH . 'uploads/court-orders/';
                    if (!is_dir($publicPath)) mkdir($publicPath, 0755, true);
                    copy($uploadPath . $newName, $publicPath . $newName);
                    $courtOrderImage = 'uploads/court-orders/' . $newName;
                    
                    if ($existing['court_order_image']) {
                        $oldPath = FCPATH . $existing['court_order_image'];
                        if (file_exists($oldPath)) @unlink($oldPath);
                    }
                }
            }
        }
        
        // Calculate custody end date
        $custodyEnd = null;
        $custodyDuration = null;
        if (isset($input['custody_duration_value']) && isset($input['custody_duration_unit'])) {
            $durationValue = (int)$input['custody_duration_value'];
            $durationUnit = $input['custody_duration_unit'];
            $custodyDuration = $durationValue . ' ' . $durationUnit;
            
            $startDate = new \DateTime($input['custody_start']);
            
            if ($durationUnit === 'days') {
                $startDate->add(new \DateInterval('P' . $durationValue . 'D'));
            } elseif ($durationUnit === 'months') {
                $startDate->add(new \DateInterval('P' . $durationValue . 'M'));
            } elseif ($durationUnit === 'years') {
                $startDate->add(new \DateInterval('P' . $durationValue . 'Y'));
            }
            
            $custodyEnd = $startDate->format('Y-m-d H:i:s');
        }
        
        // Prepare update data
        $updateData = [
            'custody_start' => $input['custody_start'],
            'custody_end' => $custodyEnd,
            'custody_duration' => $custodyDuration,
            'custody_location' => $input['custody_location'],
            'notes' => $input['notes'] ?? null,
            'updated_at' => date('Y-m-d H:i:s'),
            'updated_by' => $this->request->userId
        ];
        
        if ($accusedPhoto) $updateData['accused_photo'] = $accusedPhoto;
        if ($courtOrderImage) $updateData['court_order_image'] = $courtOrderImage;
        
        $db->table('custody_documentation')->where('id', $custodyId)->update($updateData);
        
        return $this->respond(['status' => 'success', 'message' => 'Updated successfully']);
    }
}
