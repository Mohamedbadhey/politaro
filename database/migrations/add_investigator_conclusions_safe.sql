-- Migration: Add Investigator Conclusions Table (SAFE VERSION)
-- This table stores investigator's findings and conclusions for cases

-- First, let's create the table WITHOUT foreign keys
CREATE TABLE IF NOT EXISTS investigator_conclusions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    case_id INT NOT NULL,
    investigator_id INT NOT NULL,
    conclusion_title VARCHAR(255) NOT NULL,
    findings TEXT NOT NULL,
    recommendations TEXT,
    conclusion_summary TEXT NOT NULL,
    status ENUM('draft', 'submitted', 'reviewed') DEFAULT 'draft',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    submitted_at DATETIME NULL,
    reviewed_by INT NULL,
    reviewed_at DATETIME NULL,
    review_notes TEXT NULL,
    
    INDEX idx_case_id (case_id),
    INDEX idx_investigator_id (investigator_id),
    INDEX idx_status (status),
    INDEX idx_reviewed_by (reviewed_by)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Now let's try to add foreign keys one by one
-- If any fail, the table will still work, just without that constraint

-- Try to add foreign key for case_id
SET @query = '
ALTER TABLE investigator_conclusions 
ADD CONSTRAINT fk_conclusion_case 
FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE CASCADE';

-- Execute or skip if it fails
SET @fk_case_exists = (
    SELECT COUNT(*) 
    FROM information_schema.TABLE_CONSTRAINTS 
    WHERE CONSTRAINT_SCHEMA = 'pcms_db' 
    AND TABLE_NAME = 'investigator_conclusions' 
    AND CONSTRAINT_NAME = 'fk_conclusion_case'
);

-- Try to add foreign key for investigator_id
SET @query2 = '
ALTER TABLE investigator_conclusions 
ADD CONSTRAINT fk_conclusion_investigator 
FOREIGN KEY (investigator_id) REFERENCES users(id) ON DELETE CASCADE';

-- Try to add foreign key for reviewed_by
SET @query3 = '
ALTER TABLE investigator_conclusions 
ADD CONSTRAINT fk_conclusion_reviewer 
FOREIGN KEY (reviewed_by) REFERENCES users(id) ON DELETE SET NULL';
