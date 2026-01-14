-- Migration: Add Court Acknowledgment and Custody Documentation Tables
-- Date: 2026-01-14

-- Court Acknowledgments Table (without foreign keys initially)
DROP TABLE IF EXISTS `court_acknowledgments`;
CREATE TABLE `court_acknowledgments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `uploaded_at` datetime NOT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `uploaded_by` (`uploaded_by`),
  KEY `idx_uploaded_at` (`uploaded_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Custody Documentation Table (without foreign keys initially)
DROP TABLE IF EXISTS `custody_documentation`;
CREATE TABLE `custody_documentation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `accused_person_id` int(11) NOT NULL,
  `custody_start` datetime NOT NULL,
  `custody_end` datetime DEFAULT NULL,
  `custody_duration` varchar(50) DEFAULT NULL,
  `custody_location` varchar(255) NOT NULL,
  `accused_photo` varchar(255) DEFAULT NULL,
  `court_order_image` varchar(255) DEFAULT NULL,
  `court_order_reference` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `custody_status` enum('in_custody','released','transferred') DEFAULT 'in_custody',
  `release_reason` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `accused_person_id` (`accused_person_id`),
  KEY `custody_status` (`custody_status`),
  KEY `created_by` (`created_by`),
  KEY `idx_custody_start` (`custody_start`),
  KEY `idx_custody_end` (`custody_end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
