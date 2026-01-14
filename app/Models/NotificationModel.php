<?php

namespace App\Models;

use CodeIgniter\Model;

class NotificationModel extends Model
{
    protected $table = 'notifications';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'user_id', 'case_id', 'type', 'title', 'message', 
        'link', 'is_read', 'read_at'
    ];
    
    protected $useTimestamps = true;
    protected $createdField = 'created_at';
    protected $updatedField = false;
    
    /**
     * Create a notification
     */
    public function createNotification(array $data)
    {
        $notification = [
            'user_id' => (int)$data['user_id'],
            'case_id' => isset($data['case_id']) ? (int)$data['case_id'] : null,
            'type' => (string)$data['type'],
            'title' => (string)$data['title'],
            'message' => (string)$data['message'],
            'link' => isset($data['link']) ? (string)$data['link'] : null,
            'is_read' => 0
        ];
        
        try {
            $result = $this->insert($notification);
            return $result ? $this->getInsertID() : false;
        } catch (\Exception $e) {
            log_message('error', 'Notification creation failed: ' . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Get unread notifications for a user
     */
    public function getUnreadNotifications(int $userId)
    {
        return $this->where('user_id', $userId)
                    ->where('is_read', 0)
                    ->orderBy('created_at', 'DESC')
                    ->findAll();
    }
    
    /**
     * Get all notifications for a user
     */
    public function getUserNotifications(int $userId, int $limit = 50)
    {
        return $this->where('user_id', $userId)
                    ->orderBy('created_at', 'DESC')
                    ->limit($limit)
                    ->findAll();
    }
    
    /**
     * Mark notification as read
     */
    public function markAsRead(int $notificationId): bool
    {
        return $this->update($notificationId, [
            'is_read' => 1,
            'read_at' => date('Y-m-d H:i:s')
        ]);
    }
    
    /**
     * Mark all notifications as read for a user
     */
    public function markAllAsRead(int $userId): bool
    {
        return $this->where('user_id', $userId)
                    ->where('is_read', 0)
                    ->set([
                        'is_read' => 1,
                        'read_at' => date('Y-m-d H:i:s')
                    ])
                    ->update();
    }
    
    /**
     * Get unread count for a user
     */
    public function getUnreadCount(int $userId): int
    {
        return $this->where('user_id', $userId)
                    ->where('is_read', 0)
                    ->countAllResults();
    }
}
