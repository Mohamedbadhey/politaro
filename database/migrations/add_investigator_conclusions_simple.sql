-- Migration: Add Investigator Conclusions Table (SIMPLE VERSION - NO FOREIGN KEYS)
-- This table stores investigator's findings and conclusions for cases
-- Foreign keys are optional and can be added later if needed

DROP TABLE IF EXISTS investigator_conclusions;

CREATE TABLE investigator_conclusions (
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

-- Verify table was created
SELECT 'investigator_conclusions table created successfully!' AS Status;
