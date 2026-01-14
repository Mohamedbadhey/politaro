<?php

namespace App\Models;

class CaseModel extends BaseModel
{
    protected $table = 'cases';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'case_number', 'ob_number', 'center_id', 'incident_date',
        'report_date', 'incident_location', 'incident_gps_latitude',
        'incident_gps_longitude', 'incident_description', 'crime_type',
        'crime_category', 'priority', 'is_sensitive', 'status',
        'status_changed_at', 'submitted_at', 'approved_at', 'assigned_at',
        'closed_at', 'investigation_deadline', 'investigation_started_at',
        'investigation_completed_at', 'outcome', 'outcome_description',
        'court_submitted_at', 'court_decision_received_at',
        'court_decision_file', 'created_by', 'approved_by'
    ];
    
    protected $validationRules = [
        'case_number' => 'permit_empty|max_length[50]|is_unique[cases.case_number,id,{id}]',
        'ob_number' => 'permit_empty|max_length[50]|is_unique[cases.ob_number,id,{id}]',
        'center_id' => 'required|integer',
        'incident_date' => 'required|valid_date',
        'incident_location' => 'required',
        'incident_description' => 'required|min_length[10]',
        'crime_type' => 'required|max_length[100]',
        'crime_category' => 'required|in_list[violent,property,drug,cybercrime,sexual,juvenile,other]',
        'priority' => 'permit_empty|in_list[low,medium,high,critical]',
        'is_sensitive' => 'permit_empty|in_list[0,1]'
    ];
    
    protected $beforeInsert = ['generateCaseNumbers'];
    
    /**
     * Generate unique case and OB numbers
     */
    protected function generateCaseNumbers(array $data)
    {
        if (empty($data['data']['case_number'])) {
            $data['data']['case_number'] = $this->generateCaseNumber($data['data']['center_id']);
        }
        
        if (empty($data['data']['ob_number'])) {
            $data['data']['ob_number'] = $this->generateOBNumber($data['data']['center_id']);
        }
        
        return $data;
    }
    
    /**
     * Generate case number: CASE/{CENTER_CODE}/{YEAR}/{SEQUENCE}
     */
    private function generateCaseNumber(int $centerId): string
    {
        $centerModel = model('App\Models\PoliceCenterModel');
        $center = $centerModel->find($centerId);
        $centerCode = $center['center_code'] ?? 'UNKNOWN';
        $year = date('Y');
        
        // Get last sequence number for this center and year
        $lastCase = $this->where('center_id', $centerId)
            ->where('YEAR(created_at)', $year)
            ->orderBy('id', 'DESC')
            ->first();
        
        $sequence = 1;
        if ($lastCase && preg_match('/\/(\d+)$/', $lastCase['case_number'], $matches)) {
            $sequence = (int)$matches[1] + 1;
        }
        
        return sprintf('CASE/%s/%s/%04d', $centerCode, $year, $sequence);
    }
    
    /**
     * Generate OB number: OB/{CENTER_CODE}/{YEAR}/{SEQUENCE}
     */
    private function generateOBNumber(int $centerId): string
    {
        $centerModel = model('App\Models\PoliceCenterModel');
        $center = $centerModel->find($centerId);
        $centerCode = $center['center_code'] ?? 'UNKNOWN';
        $year = date('Y');
        
        // Get last sequence number for this center and year
        $lastCase = $this->where('center_id', $centerId)
            ->where('YEAR(created_at)', $year)
            ->orderBy('id', 'DESC')
            ->first();
        
        $sequence = 1;
        if ($lastCase && preg_match('/\/(\d+)$/', $lastCase['ob_number'], $matches)) {
            $sequence = (int)$matches[1] + 1;
        }
        
        return sprintf('OB/%s/%s/%04d', $centerCode, $year, $sequence);
    }
    
    /**
     * Update case status with history tracking
     */
    public function updateStatus(int $caseId, string $newStatus, int $userId, ?string $reason = null): bool
    {
        $case = $this->find($caseId);
        if (!$case) {
            return false;
        }
        
        $previousStatus = $case['status'];
        
        // Update case status
        $updateData = [
            'status' => $newStatus,
            'status_changed_at' => date('Y-m-d H:i:s')
        ];
        
        // Update specific timestamp fields
        switch ($newStatus) {
            case 'submitted':
                $updateData['submitted_at'] = date('Y-m-d H:i:s');
                break;
            case 'approved':
                $updateData['approved_at'] = date('Y-m-d H:i:s');
                $updateData['approved_by'] = $userId;
                break;
            case 'assigned':
                $updateData['assigned_at'] = date('Y-m-d H:i:s');
                break;
            case 'investigating':
                $updateData['investigation_started_at'] = date('Y-m-d H:i:s');
                break;
            case 'closed':
                $updateData['closed_at'] = date('Y-m-d H:i:s');
                break;
        }
        
        $this->update($caseId, $updateData);
        
        // Log status change
        $historyModel = model('App\Models\CaseStatusHistoryModel');
        $historyModel->insert([
            'case_id' => $caseId,
            'old_status' => $previousStatus,
            'new_status' => $newStatus,
            'changed_by' => $userId,
            'change_reason' => $reason
        ]);
        
        return true;
    }
    
    /**
     * Get cases by status
     */
    public function getCasesByStatus(int $centerId, string $status, ?int $limit = null)
    {
        $builder = $this->where('center_id', $centerId)
                        ->where('status', $status)
                        ->orderBy('created_at', 'DESC');
        
        if ($limit) {
            $builder->limit($limit);
        }
        
        return $builder->findAll();
    }
    
    /**
     * Get cases assigned to investigator
     */
    public function getInvestigatorCases(int $investigatorId)
    {
        $db = \Config\Database::connect();
        
        return $db->table('cases')
            ->select('cases.*, case_assignments.assigned_at, case_assignments.deadline, case_assignments.is_lead_investigator')
            ->join('case_assignments', 'case_assignments.case_id = cases.id')
            ->where('case_assignments.investigator_id', $investigatorId)
            ->where('case_assignments.status', 'active')
            ->orderBy('case_assignments.deadline', 'ASC')
            ->get()
            ->getResultArray();
    }
    
    /**
     * Get cases solved by investigator (closed without sending to court)
     */
    public function getCasesSolvedByInvestigator(int $investigatorId, string $role)
    {
        $db = \Config\Database::connect();
        
        $builder = $db->table('cases')
            ->select('cases.*, police_centers.center_name, police_centers.center_code, 
                     users.full_name as closed_by_name, users.badge_number,
                     case_assignments.assigned_at')
            ->join('police_centers', 'police_centers.id = cases.center_id', 'left')
            ->join('users', 'users.id = cases.closed_by', 'left')
            ->join('case_assignments', 'case_assignments.case_id = cases.id', 'left')
            ->where('cases.status', 'closed')
            ->where('cases.court_status', 'not_sent')
            ->orderBy('cases.closed_date', 'DESC');
        
        // If investigator role, only show their solved cases
        if (!in_array($role, ['admin', 'super_admin'])) {
            $builder->where('case_assignments.investigator_id', $investigatorId);
        }
        
        return $builder->get()->getResultArray();
    }
    
    /**
     * Get cases solved by court (sent to court and closed by court)
     */
    public function getCasesSolvedByCourt(int $userId, string $role)
    {
        $db = \Config\Database::connect();
        
        $builder = $db->table('cases')
            ->select('cases.*, police_centers.center_name, police_centers.center_code,
                     sender.full_name as sent_by_name, sender.badge_number as sent_by_badge,
                     case_assignments.investigator_id')
            ->join('police_centers', 'police_centers.id = cases.center_id', 'left')
            ->join('users as sender', 'sender.id = cases.sent_to_court_by', 'left')
            ->join('case_assignments', 'case_assignments.case_id = cases.id', 'left')
            ->where('cases.court_status', 'court_closed')
            ->orderBy('cases.closed_date', 'DESC');
        
        // If investigator role, only show cases they were involved with
        if (!in_array($role, ['admin', 'super_admin', 'court_user'])) {
            $builder->where('case_assignments.investigator_id', $userId);
        }
        
        return $builder->get()->getResultArray();
    }
    
    /**
     * Get full case details with parties
     */
    public function getFullCaseDetails(int $caseId)
    {
        $case = $this->find($caseId);
        if (!$case) {
            return null;
        }
        
        $db = \Config\Database::connect();
        
        // Get center details
        $case['center'] = $db->table('police_centers')
            ->where('id', $case['center_id'])
            ->get()
            ->getRowArray();
        
        // Get case parties
        $case['parties'] = $db->table('case_parties')
            ->select('case_parties.*, persons.*')
            ->join('persons', 'persons.id = case_parties.person_id')
            ->where('case_parties.case_id', $caseId)
            ->get()
            ->getResultArray();
        
        // Get assigned investigators
        $case['investigators'] = $db->table('case_assignments')
            ->select('case_assignments.*, users.full_name, users.badge_number, users.email')
            ->join('users', 'users.id = case_assignments.investigator_id')
            ->where('case_assignments.case_id', $caseId)
            ->where('case_assignments.status', 'active')
            ->get()
            ->getResultArray();
        
        // Get evidence count
        $case['evidence_count'] = $db->table('evidence')
            ->where('case_id', $caseId)
            ->countAllResults();
        
        return $case;
    }
}
