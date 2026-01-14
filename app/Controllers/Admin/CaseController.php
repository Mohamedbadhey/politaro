<?php

namespace App\Controllers\Admin;

use CodeIgniter\RESTful\ResourceController;

class CaseController extends ResourceController
{
    protected $format = 'json';
    
    /**
     * Get case details (admin can access any case from any center)
     * GET /admin/cases/:id
     */
    public function show($caseId = null)
    {
        if (!$caseId) {
            return $this->failNotFound('Case ID required');
        }
        
        $db = \Config\Database::connect();
        
        // Get case with all related data
        $case = $db->table('cases')
            ->select('cases.*, police_centers.center_name, users.full_name as created_by_name')
            ->join('police_centers', 'police_centers.id = cases.center_id', 'left')
            ->join('users', 'users.id = cases.created_by', 'left')
            ->where('cases.id', $caseId)
            ->get()
            ->getRow();
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        // Convert to array
        $caseData = (array) $case;
        
        return $this->respond([
            'status' => 'success',
            'data' => $caseData
        ]);
    }
    
    /**
     * Get all cases (admin can see all cases from all centers)
     * GET /admin/cases
     */
    public function index()
    {
        $db = \Config\Database::connect();
        
        // Get all cases
        $cases = $db->table('cases')
            ->select('cases.*, police_centers.center_name, users.full_name as created_by_name')
            ->join('police_centers', 'police_centers.id = cases.center_id', 'left')
            ->join('users', 'users.id = cases.created_by', 'left')
            ->orderBy('cases.created_at', 'DESC')
            ->get()
            ->getResultArray();
        
        return $this->respond([
            'status' => 'success',
            'data' => $cases
        ]);
    }
}
