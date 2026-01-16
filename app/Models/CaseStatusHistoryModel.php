<?php

namespace App\Models;

use CodeIgniter\Model;

class CaseStatusHistoryModel extends Model
{
    protected $table = 'case_status_history';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'case_id', 'previous_status', 'new_status', 
        'old_court_status', 'new_court_status',
        'changed_by', 'reason'
    ];
    
    protected $useTimestamps = true;
    protected $createdField = 'changed_at';
    protected $updatedField = false;
    
    /**
     * Log a status change
     */
    public function logStatusChange(array $data)
    {
        $record = [
            'case_id' => (int)$data['case_id'],
            'previous_status' => isset($data['previous_status']) ? (string)$data['previous_status'] : (isset($data['old_status']) ? (string)$data['old_status'] : null),
            'new_status' => (string)$data['new_status'],
            'old_court_status' => isset($data['old_court_status']) ? (string)$data['old_court_status'] : 'not_sent',
            'new_court_status' => (string)$data['new_court_status'],
            'changed_by' => (int)$data['changed_by'],
            'reason' => isset($data['reason']) ? (string)$data['reason'] : (isset($data['change_reason']) ? (string)$data['change_reason'] : null)
        ];
        
        try {
            $result = $this->insert($record);
            return $result ? $this->getInsertID() : false;
        } catch (\Exception $e) {
            log_message('error', 'Status history logging failed: ' . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Get status history for a case
     */
    public function getCaseHistory(int $caseId)
    {
        return $this->select('case_status_history.*, users.full_name as changed_by_name')
                    ->join('users', 'users.id = case_status_history.changed_by')
                    ->where('case_id', $caseId)
                    ->orderBy('changed_at', 'DESC')
                    ->findAll();
    }
}
