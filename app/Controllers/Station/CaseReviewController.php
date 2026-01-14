<?php

namespace App\Controllers\Station;

use CodeIgniter\RESTful\ResourceController;

class CaseReviewController extends ResourceController
{
    public function index()
    {
        $centerId = $this->request->centerId;
        $userId = $this->request->userId;
        $userRole = $this->request->userRole;
        
        $caseModel = model('App\Models\CaseModel');
        
        // Admin can see cases they created + cases created by OB officers in their center
        if ($userRole === 'admin') {
            $db = \Config\Database::connect();
            
            $cases = $db->table('cases')
                ->select('cases.*')
                ->join('users', 'users.id = cases.created_by', 'left')
                ->where('cases.center_id', $centerId)
                ->groupStart()
                    ->where('cases.created_by', $userId) // Cases created by admin themselves
                    ->orWhere('users.role', 'ob_officer') // Cases created by OB officers
                ->groupEnd()
                ->orderBy('cases.created_at', 'DESC')
                ->get()
                ->getResultArray();
        } else {
            // Super admin can see all cases
            $cases = $caseModel->where('center_id', $centerId)
                              ->orderBy('created_at', 'DESC')
                              ->findAll();
        }
        
        // Add parties and investigators for each case
        foreach ($cases as &$case) {
            $caseWithDetails = $caseModel->getFullCaseDetails($case['id']);
            $case['parties'] = $caseWithDetails['parties'] ?? [];
            $case['investigators'] = $caseWithDetails['investigators'] ?? [];
        }
        
        return $this->respond([
            'status' => 'success',
            'data' => $cases
        ]);
    }
    
    public function show($id = null)
    {
        $centerId = $this->request->centerId;
        
        $caseModel = model('App\Models\CaseModel');
        
        // Get case with full details
        $case = $caseModel->getFullCaseDetails($id);
        
        if (!$case || $case['center_id'] != $centerId) {
            return $this->failNotFound('Case not found or not in your center');
        }
        
        return $this->respond([
            'status' => 'success',
            'data' => $case
        ]);
    }

    protected $format = 'json';
    
    /**
     * Get pending cases for review
     */
    public function pending()
    {
        return $this->pendingCases();
    }
    
    public function pendingCases()
    {
        $caseModel = model('App\Models\CaseModel');
        // Get user data from global (set by AuthFilter)
        $centerId = $GLOBALS['current_user']['centerId'] ?? $this->request->centerId ?? null;
        $userId = $GLOBALS['current_user']['userId'] ?? $this->request->userId ?? null;
        $userRole = $GLOBALS['current_user']['userRole'] ?? $this->request->userRole ?? null;
        
        $db = \Config\Database::connect();
        $builder = $db->table('cases')
            ->select('cases.*, users.full_name as created_by_name, users.role as creator_role')
            ->join('users', 'users.id = cases.created_by')
            ->where('cases.center_id', $centerId)
            ->where('cases.status', 'submitted');
        
        // Admin can only see pending cases they created or created by OB officers
        if ($userRole === 'admin') {
            $builder->groupStart()
                ->where('cases.created_by', $userId)
                ->orWhere('users.role', 'ob_officer')
                ->groupEnd();
        }
        
        $cases = $builder->orderBy('cases.submitted_at', 'ASC')
            ->get()
            ->getResultArray();
        
        return $this->respond([
            'status' => 'success',
            'data' => $cases
        ]);
    }
    
    /**
     * Approve case
     */
    public function approve($id = null)
    {
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($id);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        if ($case['center_id'] != $this->request->centerId) {
            return $this->failForbidden('You do not have permission to approve this case');
        }
        
        if ($case['status'] != 'submitted') {
            return $this->fail('Case is not in submitted status', 400);
        }
        
        $caseModel->updateStatus($id, 'approved', $this->request->userId);
        
        // Notify case creator
        $notificationModel = model('App\Models\NotificationModel');
        $notificationModel->insert([
            'user_id' => $case['created_by'],
            'case_id' => $id,
            'type' => 'status_changed',
            'title' => 'Case Approved',
            'message' => "Your case {$case['case_number']} has been approved",
            'link' => '/cases/' . $id
        ]);
        
        return $this->respond([
            'status' => 'success',
            'message' => 'Case approved successfully'
        ]);
    }
    
    /**
     * Return case for revision
     */
    public function returnCase($id = null)
    {
        $rules = [
            'reason' => 'required|min_length[10]'
        ];
        
        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors(), 400);
        }
        
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($id);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        if ($case['center_id'] != $this->request->centerId) {
            return $this->failForbidden('You do not have permission to return this case');
        }
        
        if ($case['status'] != 'submitted') {
            return $this->fail('Case is not in submitted status', 400);
        }
        
        $reason = $this->request->getPost('reason');
        $caseModel->updateStatus($id, 'returned', $this->request->userId, $reason);
        
        // Notify case creator
        $notificationModel = model('App\Models\NotificationModel');
        $notificationModel->insert([
            'user_id' => $case['created_by'],
            'case_id' => $id,
            'type' => 'status_changed',
            'title' => 'Case Returned for Revision',
            'message' => "Your case {$case['case_number']} has been returned. Reason: {$reason}",
            'link' => '/cases/' . $id
        ]);
        
        return $this->respond([
            'status' => 'success',
            'message' => 'Case returned for revision'
        ]);
    }
}
