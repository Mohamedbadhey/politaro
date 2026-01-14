<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddLanguageToUsers extends Migration
{
    public function up()
    {
        $fields = [
            'language' => [
                'type' => 'VARCHAR',
                'constraint' => 10,
                'default' => 'en',
                'null' => false,
                'after' => 'badge_number'
            ]
        ];
        
        $this->forge->addColumn('users', $fields);
    }

    public function down()
    {
        $this->forge->dropColumn('users', 'language');
    }
}
