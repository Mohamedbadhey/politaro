<?php

namespace App\Controllers\Investigation;

use CodeIgniter\RESTful\ResourceController;

class ReportController extends ResourceController
{
    protected $format = 'json';
    
    /**
     * Create investigation report
     */
    public function createReport($caseId = null)
    {
        $caseModel = model('App\Models\CaseModel');
        $case = $caseModel->find($caseId);
        
        if (!$case) {
            return $this->failNotFound('Case not found');
        }
        
        $rules = [
            'report_type' => 'required|in_list[preliminary,interim,final,court_submission]',
            'report_title' => 'required|max_length[255]',
            'report_content' => 'required|min_length[50]'
        ];
        
        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors(), 400);
        }
        
        $reportData = [
            'case_id' => $caseId,
            'report_type' => $this->request->getPost('report_type'),
            'report_title' => $this->request->getPost('report_title'),
            'report_content' => $this->request->getPost('report_content'),
            'created_by' => $this->request->userId
        ];
        
        $db = \Config\Database::connect();
        $reportId = $db->table('investigation_reports')->insert($reportData);
        
        if (!$reportId) {
            return $this->fail('Failed to create report', 500);
        }
        
        // Generate PDF
        $this->generateReportPDF($reportId, $case, $reportData);
        
        return $this->respondCreated([
            'status' => 'success',
            'message' => 'Report created successfully',
            'data' => ['id' => $reportId]
        ]);
    }
    
    /**
     * Sign report digitally
     */
    public function signReport($id = null)
    {
        $db = \Config\Database::connect();
        $report = $db->table('investigation_reports')->where('id', $id)->get()->getRowArray();
        
        if (!$report) {
            return $this->failNotFound('Report not found');
        }
        
        if ($report['created_by'] != $this->request->userId) {
            return $this->failForbidden('You can only sign your own reports');
        }
        
        if ($report['is_signed']) {
            return $this->fail('Report is already signed', 400);
        }
        
        // Generate digital signature
        $signatureData = $report['report_content'] . $report['case_id'] . $this->request->userId . time();
        $signatureHash = hash('sha256', $signatureData);
        
        // Update report
        $db->table('investigation_reports')->where('id', $id)->update([
            'is_signed' => 1,
            'signature_hash' => $signatureHash,
            'signed_by' => $this->request->userId,
            'signed_at' => date('Y-m-d H:i:s')
        ]);
        
        // Store in digital signatures registry
        $db->table('digital_signatures')->insert([
            'entity_type' => 'investigation_reports',
            'entity_id' => $id,
            'signature_hash' => $signatureHash,
            'signature_algorithm' => 'SHA256',
            'signature_data' => base64_encode($signatureHash),
            'signed_by' => $this->request->userId
        ]);
        
        return $this->respond([
            'status' => 'success',
            'message' => 'Report signed successfully'
        ]);
    }
    
    /**
     * Get report details
     */
    public function show($id = null)
    {
        $db = \Config\Database::connect();
        $report = $db->table('investigation_reports')
            ->select('investigation_reports.*, users.full_name as created_by_name, 
                      cases.case_number, cases.ob_number')
            ->join('users', 'users.id = investigation_reports.created_by')
            ->join('cases', 'cases.id = investigation_reports.case_id')
            ->where('investigation_reports.id', $id)
            ->get()
            ->getRowArray();
        
        if (!$report) {
            return $this->failNotFound('Report not found');
        }
        
        return $this->respond([
            'status' => 'success',
            'data' => $report
        ]);
    }
    
    /**
     * Generate report PDF
     */
    private function generateReportPDF(int $reportId, array $case, array $reportData)
    {
        // This is a placeholder - in production, use libraries like TCPDF or mPDF
        $year = date('Y');
        $pdfPath = WRITEPATH . "uploads/reports/{$case['id']}/";
        
        if (!is_dir($pdfPath)) {
            mkdir($pdfPath, 0755, true);
        }
        
        $fileName = "report_{$reportId}.pdf";
        
        // For now, just store the path
        $db = \Config\Database::connect();
        $db->table('investigation_reports')
            ->where('id', $reportId)
            ->update(['report_file_path' => "reports/{$case['id']}/{$fileName}"]);
        
        // In production, generate actual PDF here
        return true;
    }
}
