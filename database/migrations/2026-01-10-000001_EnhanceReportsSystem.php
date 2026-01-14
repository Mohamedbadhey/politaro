<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class EnhanceReportsSystem extends Migration
{
    public function up()
    {
        // Enhance investigation_reports table
        $fields = [
            'report_subtype' => [
                'type' => 'VARCHAR',
                'constraint' => 50,
                'null' => true,
                'after' => 'report_type'
            ],
            'period_covered_from' => [
                'type' => 'DATE',
                'null' => true,
                'after' => 'report_subtype'
            ],
            'period_covered_to' => [
                'type' => 'DATE',
                'null' => true,
                'after' => 'period_covered_from'
            ],
            'court_reference_number' => [
                'type' => 'VARCHAR',
                'constraint' => 100,
                'null' => true,
                'after' => 'period_covered_to'
            ],
            'charges_preferred' => [
                'type' => 'JSON',
                'null' => true,
                'after' => 'court_reference_number'
            ],
            'case_strength' => [
                'type' => 'ENUM',
                'constraint' => ['weak', 'moderate', 'strong', 'conclusive'],
                'null' => true,
                'after' => 'charges_preferred'
            ],
            'recommended_action' => [
                'type' => 'VARCHAR',
                'constraint' => 100,
                'null' => true,
                'after' => 'case_strength'
            ],
            'approval_status' => [
                'type' => 'ENUM',
                'constraint' => ['draft', 'pending_approval', 'approved', 'rejected'],
                'default' => 'draft',
                'after' => 'recommended_action'
            ],
            'approved_by' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true,
                'null' => true,
                'after' => 'approval_status'
            ],
            'approved_at' => [
                'type' => 'DATETIME',
                'null' => true,
                'after' => 'approved_by'
            ],
            'court_order_reference' => [
                'type' => 'VARCHAR',
                'constraint' => 100,
                'null' => true,
                'after' => 'approved_at'
            ],
            'metadata' => [
                'type' => 'JSON',
                'null' => true,
                'comment' => 'Additional structured data for specific report types',
                'after' => 'court_order_reference'
            ],
            'updated_at' => [
                'type' => 'DATETIME',
                'null' => true,
                'after' => 'metadata'
            ]
        ];
        
        $this->forge->addColumn('investigation_reports', $fields);
        
        // Create report_approvals table
        $this->forge->addField([
            'id' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true,
                'auto_increment' => true
            ],
            'report_id' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true
            ],
            'approver_id' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true
            ],
            'approval_level' => [
                'type' => 'ENUM',
                'constraint' => ['investigator', 'supervisor', 'commander', 'prosecutor'],
                'default' => 'supervisor'
            ],
            'status' => [
                'type' => 'ENUM',
                'constraint' => ['pending', 'approved', 'rejected', 'revision_requested'],
                'default' => 'pending'
            ],
            'comments' => [
                'type' => 'TEXT',
                'null' => true
            ],
            'created_at' => [
                'type' => 'DATETIME',
                'null' => false
            ],
            'updated_at' => [
                'type' => 'DATETIME',
                'null' => true
            ]
        ]);
        
        $this->forge->addKey('id', true);
        $this->forge->addForeignKey('report_id', 'investigation_reports', 'id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('approver_id', 'users', 'id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('report_approvals');
        
        // Create court_communications table
        $this->forge->addField([
            'id' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true,
                'auto_increment' => true
            ],
            'case_id' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true
            ],
            'report_id' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true,
                'null' => true
            ],
            'communication_type' => [
                'type' => 'ENUM',
                'constraint' => ['submission', 'response', 'hearing_notice', 'directive', 'verdict', 'adjournment', 'order'],
                'default' => 'submission'
            ],
            'court_reference' => [
                'type' => 'VARCHAR',
                'constraint' => 100,
                'null' => true
            ],
            'communication_date' => [
                'type' => 'DATE',
                'null' => false
            ],
            'received_from' => [
                'type' => 'VARCHAR',
                'constraint' => 100,
                'null' => true
            ],
            'sent_to' => [
                'type' => 'VARCHAR',
                'constraint' => 100,
                'null' => true
            ],
            'subject' => [
                'type' => 'VARCHAR',
                'constraint' => 255,
                'null' => false
            ],
            'summary' => [
                'type' => 'TEXT',
                'null' => true
            ],
            'document_path' => [
                'type' => 'VARCHAR',
                'constraint' => 255,
                'null' => true
            ],
            'created_by' => [
                'type' => 'INT',
                'constraint' => 10,
                'unsigned' => true,
                'null' => true
            ],
            'created_at' => [
                'type' => 'DATETIME',
                'null' => false
            ],
            'updated_at' => [
                'type' => 'DATETIME',
                'null' => true
            ]
        ]);
        
        $this->forge->addKey('id', true);
        $this->forge->addForeignKey('case_id', 'cases', 'id', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('report_id', 'investigation_reports', 'id', 'SET NULL', 'CASCADE');
        $this->forge->createTable('court_communications');
        
        // Enhance document_templates table
        $templateFields = [
            'report_category' => [
                'type' => 'VARCHAR',
                'constraint' => 50,
                'null' => true,
                'after' => 'template_type'
            ],
            'required_sections' => [
                'type' => 'JSON',
                'null' => true,
                'after' => 'variables'
            ],
            'optional_sections' => [
                'type' => 'JSON',
                'null' => true,
                'after' => 'required_sections'
            ]
        ];
        
        $this->forge->addColumn('document_templates', $templateFields);
    }

    public function down()
    {
        // Drop new tables
        $this->forge->dropTable('court_communications', true);
        $this->forge->dropTable('report_approvals', true);
        
        // Remove added columns from investigation_reports
        $this->forge->dropColumn('investigation_reports', [
            'report_subtype', 'period_covered_from', 'period_covered_to',
            'court_reference_number', 'charges_preferred', 'case_strength',
            'recommended_action', 'approval_status', 'approved_by',
            'approved_at', 'court_order_reference', 'metadata', 'updated_at'
        ]);
        
        // Remove added columns from document_templates
        $this->forge->dropColumn('document_templates', [
            'report_category', 'required_sections', 'optional_sections'
        ]);
    }
}
