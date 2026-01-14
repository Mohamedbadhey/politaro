-- Migration: Add Investigator Conclusions Table
-- This table stores investigator's findings and conclusions for cases

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
    
    CONSTRAINT fk_conclusion_case FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE CASCADE,
    CONSTRAINT fk_conclusion_investigator FOREIGN KEY (investigator_id) REFERENCES users(id) ON DELETE CASCADE,
    
    INDEX idx_case_id (case_id),
    INDEX idx_investigator_id (investigator_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add audit trail
ALTER TABLE investigator_conclusions 
ADD COLUMN reviewed_by INT NULL,
ADD COLUMN reviewed_at DATETIME NULL,
ADD COLUMN review_notes TEXT NULL,
ADD CONSTRAINT fk_conclusion_reviewer FOREIGN KEY (reviewed_by) REFERENCES users(id) ON DELETE SET NULL;
