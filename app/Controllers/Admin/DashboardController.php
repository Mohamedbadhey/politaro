<?php

namespace App\Controllers\Admin;

use CodeIgniter\RESTful\ResourceController;

class DashboardController extends ResourceController
{
    protected $format = 'json';
    
    public function index()
    {
        $db = \Config\Database::connect();
        
        // System-wide statistics
        $stats = [
            'total_centers' => $db->table('police_centers')->where('is_active', 1)->countAllResults(),
            'total_users' => $db->table('users')->where('is_active', 1)->countAllResults(),
            'total_cases' => $db->table('cases')->countAllResults(),
            'active_cases' => $db->table('cases')
                ->whereIn('status', ['investigating', 'assigned', 'approved', 'court_pending'])
                ->countAllResults(),
            'closed_cases' => $db->table('cases')->where('status', 'closed')->countAllResults(),
            'persons_in_custody' => $db->table('custody_records')
                ->where('custody_status', 'in_custody')
                ->countAllResults(),
            'total_evidence' => $db->table('evidence')->countAllResults()
        ];
        
        // Cases by status
        $casesByStatus = $db->table('cases')
            ->select('status, COUNT(*) as count')
            ->groupBy('status')
            ->get()
            ->getResultArray();
        
        // Cases by priority
        $casesByPriority = $db->table('cases')
            ->select('priority, COUNT(*) as count')
            ->whereNotIn('status', ['closed'])
            ->groupBy('priority')
            ->get()
            ->getResultArray();
        
        // Cases by crime category
        $casesByCategory = $db->table('cases')
            ->select('crime_category, COUNT(*) as count')
            ->groupBy('crime_category')
            ->orderBy('count', 'DESC')
            ->limit(10)
            ->get()
            ->getResultArray();
        
        // Recent activity
        $recentActivity = $db->table('audit_logs')
            ->select('audit_logs.*, users.full_name')
            ->join('users', 'users.id = audit_logs.user_id', 'left')
            ->orderBy('audit_logs.created_at', 'DESC')
            ->limit(20)
            ->get()
            ->getResultArray();
        
        // Center performance
        $centerStats = $db->table('cases')
            ->select('police_centers.center_name, COUNT(*) as total_cases, 
                      SUM(CASE WHEN cases.status = "closed" THEN 1 ELSE 0 END) as closed_cases')
            ->join('police_centers', 'police_centers.id = cases.center_id')
            ->groupBy('cases.center_id')
            ->get()
            ->getResultArray();
        
        return $this->respond([
            'status' => 'success',
            'data' => [
                'stats' => $stats,
                'cases_by_status' => $casesByStatus,
                'cases_by_priority' => $casesByPriority,
                'cases_by_category' => $casesByCategory,
                'recent_activity' => $recentActivity,
                'center_stats' => $centerStats
            ]
        ]);
    }
}
