<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateReportSettings extends Migration
{
    public function up()
    {
        // Create report_settings table
        $this->forge->addField([
            'id' => [
                'type' => 'INT',
                'constraint' => 11,
                'unsigned' => true,
                'auto_increment' => true,
            ],
            'center_id' => [
                'type' => 'INT',
                'constraint' => 11,
                'unsigned' => true,
                'null' => true,
                'comment' => 'If NULL, applies to all centers (system-wide)',
            ],
            'setting_key' => [
                'type' => 'VARCHAR',
                'constraint' => 100,
                'comment' => 'e.g., header_image, full_report_sections, basic_report_sections',
            ],
            'setting_value' => [
                'type' => 'TEXT',
                'null' => true,
                'comment' => 'JSON or text value',
            ],
            'setting_type' => [
                'type' => 'ENUM',
                'constraint' => ['text', 'json', 'image', 'file'],
                'default' => 'text',
            ],
            'description' => [
                'type' => 'TEXT',
                'null' => true,
            ],
            'is_active' => [
                'type' => 'TINYINT',
                'constraint' => 1,
                'default' => 1,
            ],
            'created_by' => [
                'type' => 'INT',
                'constraint' => 11,
                'unsigned' => true,
                'null' => true,
            ],
            'updated_by' => [
                'type' => 'INT',
                'constraint' => 11,
                'unsigned' => true,
                'null' => true,
            ],
            'created_at' => [
                'type' => 'TIMESTAMP',
                'null' => true,
            ],
            'updated_at' => [
                'type' => 'TIMESTAMP',
                'null' => true,
            ],
        ]);

        $this->forge->addKey('id', true);
        $this->forge->addKey(['center_id', 'setting_key']);
        $this->forge->addForeignKey('center_id', 'police_centers', 'id', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('created_by', 'users', 'id', 'NO ACTION', 'SET NULL');
        $this->forge->addForeignKey('updated_by', 'users', 'id', 'NO ACTION', 'SET NULL');
        $this->forge->createTable('report_settings');

        // Insert default settings
        $this->db->table('report_settings')->insertBatch([
            [
                'center_id' => null,
                'setting_key' => 'header_image',
                'setting_value' => null,
                'setting_type' => 'image',
                'description' => 'Report header image/logo (shared by all reports)',
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'center_id' => null,
                'setting_key' => 'statement1',
                'setting_value' => 'This is to certify that the information contained in this report is true and accurate to the best of my knowledge.',
                'setting_type' => 'text',
                'description' => 'Statement 1 - Appears after case numbers',
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'center_id' => null,
                'setting_key' => 'statement2',
                'setting_value' => 'This report has been prepared in accordance with standard police procedures and protocols.',
                'setting_type' => 'text',
                'description' => 'Statement 2 - Appears below statement 1',
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'center_id' => null,
                'setting_key' => 'statement3',
                'setting_value' => 'The following sections contain detailed information regarding this investigation.',
                'setting_type' => 'text',
                'description' => 'Statement 3 - Appears before report sections',
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'center_id' => null,
                'setting_key' => 'footer_text',
                'setting_value' => "Prepared By:\nName: _______________________________\nSignature: __________________________\nDate: _______________\n\nReviewed By:\nName: _______________________________\nSignature: __________________________\nDate: _______________",
                'setting_type' => 'text',
                'description' => 'Footer text with signature section',
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'center_id' => null,
                'setting_key' => 'full_report_sections',
                'setting_value' => json_encode([
                    'case_overview' => [
                        'title' => 'Case Overview',
                        'enabled' => true,
                        'order' => 1,
                        'template' => 'This section provides a comprehensive overview of the case including all relevant details.'
                    ],
                    'parties_involved' => [
                        'title' => 'Parties Involved',
                        'enabled' => true,
                        'order' => 2,
                        'template' => 'Detailed information about all parties involved including accusers, accused, and witnesses.'
                    ],
                    'evidence_summary' => [
                        'title' => 'Evidence Summary',
                        'enabled' => true,
                        'order' => 3,
                        'template' => 'Complete catalog of all evidence collected during the investigation.'
                    ],
                    'investigation_details' => [
                        'title' => 'Investigation Details',
                        'enabled' => true,
                        'order' => 4,
                        'template' => 'Detailed account of investigation activities, interviews, and findings.'
                    ],
                    'investigator_conclusions' => [
                        'title' => 'Investigator Conclusions',
                        'enabled' => true,
                        'order' => 5,
                        'template' => 'Professional conclusions and recommendations based on investigation findings.'
                    ],
                    'recommendations' => [
                        'title' => 'Recommendations',
                        'enabled' => true,
                        'order' => 6,
                        'template' => 'Recommended next steps and actions for case resolution.'
                    ],
                ]),
                'setting_type' => 'json',
                'description' => 'Text sections configuration for Full Investigation Report',
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
            ],
            [
                'center_id' => null,
                'setting_key' => 'basic_report_sections',
                'setting_value' => json_encode([
                    'case_overview' => [
                        'title' => 'Case Overview',
                        'enabled' => true,
                        'order' => 1,
                        'template' => 'Brief overview of the case and key details.'
                    ],
                    'summary' => [
                        'title' => 'Summary',
                        'enabled' => true,
                        'order' => 2,
                        'template' => 'Summary of the investigation and key findings.'
                    ],
                    'conclusion' => [
                        'title' => 'Conclusion',
                        'enabled' => true,
                        'order' => 3,
                        'template' => 'Brief conclusion and recommendation.'
                    ],
                ]),
                'setting_type' => 'json',
                'description' => 'Text sections configuration for Basic Investigation Report',
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
            ],
        ]);
    }

    public function down()
    {
        $this->forge->dropTable('report_settings');
    }
}
