-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2026 at 08:06 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pcms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `activity_description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(50) NOT NULL COMMENT 'Table name or entity type',
  `entity_id` int(10) UNSIGNED DEFAULT NULL,
  `description` text NOT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `request_method` varchar(10) DEFAULT NULL,
  `request_url` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_number` varchar(50) NOT NULL,
  `ob_number` varchar(50) NOT NULL,
  `center_id` int(10) UNSIGNED NOT NULL,
  `incident_date` datetime NOT NULL,
  `report_date` datetime DEFAULT current_timestamp(),
  `incident_location` text NOT NULL,
  `incident_gps_latitude` decimal(10,8) DEFAULT NULL,
  `incident_gps_longitude` decimal(11,8) DEFAULT NULL,
  `incident_description` text NOT NULL,
  `crime_type` varchar(100) NOT NULL,
  `crime_category` enum('violent','property','drug','cybercrime','sexual','juvenile','other') NOT NULL,
  `priority` enum('low','medium','high','critical') DEFAULT 'medium',
  `is_sensitive` tinyint(1) DEFAULT 0,
  `status` enum('draft','submitted','approved','assigned','investigating','evidence_collected','suspect_identified','under_review','closed','returned','pending_court','archived') DEFAULT 'draft',
  `court_status` enum('not_sent','sent_to_court','court_review','court_assigned_back','court_closed') DEFAULT 'not_sent',
  `sent_to_court_date` datetime DEFAULT NULL,
  `sent_to_court_by` int(10) UNSIGNED DEFAULT NULL,
  `court_assigned_date` datetime DEFAULT NULL,
  `court_assigned_by` int(10) UNSIGNED DEFAULT NULL,
  `court_deadline` date DEFAULT NULL,
  `court_notes` text DEFAULT NULL,
  `closed_date` datetime DEFAULT NULL,
  `closed_by` int(10) UNSIGNED DEFAULT NULL,
  `closure_reason` text DEFAULT NULL,
  `status_changed_at` datetime DEFAULT current_timestamp(),
  `submitted_at` datetime DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `assigned_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `investigation_deadline` datetime DEFAULT NULL,
  `investigation_started_at` datetime DEFAULT NULL,
  `investigation_completed_at` datetime DEFAULT NULL,
  `outcome` enum('solved_internal','escalated_to_court','withdrawn','merged') DEFAULT NULL,
  `outcome_description` text DEFAULT NULL,
  `court_submitted_at` datetime DEFAULT NULL,
  `court_decision_received_at` datetime DEFAULT NULL,
  `court_decision_file` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(10) UNSIGNED NOT NULL,
  `approved_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`id`, `case_number`, `ob_number`, `center_id`, `incident_date`, `report_date`, `incident_location`, `incident_gps_latitude`, `incident_gps_longitude`, `incident_description`, `crime_type`, `crime_category`, `priority`, `is_sensitive`, `status`, `court_status`, `sent_to_court_date`, `sent_to_court_by`, `court_assigned_date`, `court_assigned_by`, `court_deadline`, `court_notes`, `closed_date`, `closed_by`, `closure_reason`, `status_changed_at`, `submitted_at`, `approved_at`, `assigned_at`, `closed_at`, `investigation_deadline`, `investigation_started_at`, `investigation_completed_at`, `outcome`, `outcome_description`, `court_submitted_at`, `court_decision_received_at`, `court_decision_file`, `created_at`, `updated_at`, `created_by`, `approved_by`) VALUES
(1, 'CASE/HQ001/2025/0001', 'OB/HQ001/2025/0001', 1, '2025-12-29 14:58:00', '2025-12-29 14:59:52', 'fgsdfgsdf', NULL, NULL, 'fyetyerdfsdfgsd', 'tuugnimo', 'property', 'critical', 1, 'draft', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 14:59:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 11:59:52', '2025-12-29 11:59:52', 5, NULL),
(2, 'CASE/HQ001/2025/0002', 'OB/HQ001/2025/0002', 1, '2025-12-29 15:00:00', '2025-12-29 15:01:02', 'kismayo', NULL, NULL, 'fghjddgvchjsdc', 'tuugnimo', 'violent', 'high', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 15:01:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 12:01:02', '2025-12-29 12:01:02', 5, NULL),
(3, 'CASE/HQ001/2025/0003', 'OB/HQ001/2025/0003', 1, '2025-12-29 15:07:00', '2025-12-29 15:08:14', 'shaqaalaha', NULL, NULL, 'gabad ayaa la afduubtay oo la dubtay oo  hala baaaro', 'kufsi', 'sexual', 'critical', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 15:08:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 12:08:14', '2025-12-29 12:08:14', 5, NULL),
(4, 'CASE/HQ001/2025/0004', 'OB/HQ001/2025/0004', 1, '2025-12-29 15:10:00', '2025-12-29 15:10:54', 'kismayo', NULL, NULL, 'gabadh la cunay shsssj', 'tuugnimo', 'property', 'medium', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 15:10:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 12:10:54', '2025-12-29 12:10:54', 5, NULL),
(5, 'CASE/HQ001/2025/0005', 'OB/HQ001/2025/0005', 1, '2025-12-29 15:10:00', '2025-12-29 15:12:02', 'kismayo', NULL, NULL, 'gabadh la cunay shsssj', 'tuugnimo', 'property', 'medium', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 15:12:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 12:12:02', '2025-12-29 12:12:02', 5, NULL),
(6, 'CASE/HQ001/2025/0006', 'OB/HQ001/2025/0006', 1, '2025-12-29 15:31:00', '2025-12-29 15:33:51', 'degmada', NULL, NULL, 'meesha nin ayaa lagu toogta isagoo wadada marayaayo', 'toogasho', 'violent', 'critical', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 15:33:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 12:33:51', '2025-12-29 12:33:51', 5, NULL),
(7, 'CASE/HQ001/2025/0007', 'OB/HQ001/2025/0007', 1, '2025-12-29 15:31:00', '2025-12-29 15:35:03', 'degmada', NULL, NULL, 'meesha nin ayaa lagu toogta isagoo wadada marayaayo', 'toogasho', 'violent', 'critical', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 15:35:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-29 12:35:03', '2025-12-29 12:35:03', 5, NULL),
(8, 'CASE/KSM-003/2025/0001', 'OB/KSM-003/2025/0001', 6, '2025-12-01 01:54:00', '2025-12-31 00:55:54', 'degmada', NULL, NULL, 'wala isku dilay meesha oo sfcn bee eheed', 'dil', 'violent', 'medium', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-31 00:55:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-30 21:55:54', '2025-12-30 21:55:54', 24, NULL),
(9, 'CASE/KSM-003/2025/0002', 'OB/KSM-003/2025/0002', 6, '2025-12-01 01:54:00', '2025-12-31 00:57:14', 'degmada', NULL, NULL, 'wala isku dilay meesha oo sfcn bee eheed', 'dil', 'violent', 'medium', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-31 00:57:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-30 21:57:14', '2025-12-30 21:57:14', 24, NULL),
(10, 'CASE/kcjd-r/2025/0001', 'OB/kcjd-r/2025/0001', 7, '2025-12-01 01:33:00', '2025-12-31 01:32:42', 'degmada', NULL, NULL, 'Koox hubeysan oo watay mooto yar ayaa xalay fiidkii dhibane ku dhacay degmada Hodan, gaar ahaan agagaarka isgoyska Tarabuunka. Raggan hubeysan ayaa dhibanaha ka qaatay telefoonkii gacanta iyo lacag qaddarkeeda lagu sheegay boqol doollar, iyagoo adeegsaday hanjabaad hub ah ka hor intaysan goobta ka baxsan. Dadka deegaanka ayaa sheegay in falkan uu qayb ka yahay dhacdooyin isdaba joog ah oo ay geystaan kooxo hubeysan oo inta badan bartilmaameedsada dadka lugeynaya xilliyada habeenkii ah.', 'dhac', 'violent', 'critical', 0, 'investigating', 'court_assigned_back', '2026-01-02 20:26:29', 26, '2026-01-03 12:04:48', NULL, '2026-01-10', 'xddfsdfsdf', NULL, NULL, NULL, '2025-12-30 22:37:13', NULL, '2025-12-30 22:37:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-30 22:32:42', '2026-01-03 12:12:25', 25, 23),
(11, 'CASE/kcjd-r/2026/0001', 'OB/kcjd-r/2026/0001', 7, '2025-12-17 22:31:00', '2026-01-03 22:34:07', 'shaqaalaha', NULL, NULL, 'daroogo ayaa lagu qabtay', 'daroogoo', 'drug', 'medium', 1, 'submitted', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-03 22:34:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-03 19:34:07', '2026-01-03 19:34:07', 25, NULL),
(12, 'CASE/kcjd-r/2026/0002', 'OB/kcjd-r/2026/0002', 7, '2026-01-10 12:58:00', '2026-01-08 10:59:59', 'agagaarka  badar', NULL, NULL, 'wiil iyo gabadh ayaa tumasho sameeeye ', 'tumasho', 'sexual', 'medium', 1, 'approved', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-08 08:06:00', NULL, '2026-01-08 08:06:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-08 07:59:59', '2026-01-08 08:06:00', 25, 23),
(13, 'CASE/XGD-01/2026/0001', 'OB/XGD-01/2026/0001', 8, '2026-01-02 19:54:00', '2026-01-12 17:55:37', 'suuqa yare kismayo', NULL, NULL, 'ninkaan ayaa wuxuu usoo dhacay dukaan  suuq yare ku yaalo isaga oo lagu eedeeye dhac', 'Tuugnimo', 'property', 'medium', 1, 'approved', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 14:59:33', NULL, '2026-01-12 14:59:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 14:55:37', '2026-01-12 14:59:33', 29, 28);

-- --------------------------------------------------------

--
-- Table structure for table `case_assignments`
--

CREATE TABLE `case_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `investigator_id` int(10) UNSIGNED NOT NULL,
  `assigned_by` int(10) UNSIGNED NOT NULL,
  `assigned_at` datetime DEFAULT current_timestamp(),
  `deadline` datetime DEFAULT NULL,
  `is_lead_investigator` tinyint(1) DEFAULT 0,
  `status` enum('active','completed','reassigned') DEFAULT 'active',
  `completed_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `case_assignments`
--

INSERT INTO `case_assignments` (`id`, `case_id`, `investigator_id`, `assigned_by`, `assigned_at`, `deadline`, `is_lead_investigator`, `status`, `completed_at`, `notes`) VALUES
(1, 10, 26, 23, '2025-12-31 11:21:36', '2026-01-10 00:00:00', 1, 'active', NULL, 'fghj'),
(7, 12, 26, 23, '2026-01-08 08:19:05', NULL, 1, 'active', NULL, NULL),
(8, 13, 30, 28, '2026-01-12 15:02:52', NULL, 1, 'reassigned', '2026-01-12 15:04:40', NULL),
(9, 13, 30, 28, '2026-01-12 15:04:40', NULL, 1, 'active', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `case_comments`
--

CREATE TABLE `case_comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `comment_text` text NOT NULL,
  `is_internal` tinyint(1) DEFAULT 1 COMMENT 'Internal notes vs official comments',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `case_parties`
--

CREATE TABLE `case_parties` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `person_id` int(10) UNSIGNED NOT NULL,
  `party_role` enum('accuser','accused','witness','informant') NOT NULL,
  `statement` text DEFAULT NULL,
  `statement_date` datetime DEFAULT NULL,
  `statement_audio_path` varchar(255) DEFAULT NULL,
  `statement_signed_document` varchar(255) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `witness_affiliation` enum('accuser','accused','neutral') DEFAULT 'neutral',
  `affiliated_person_id` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `case_parties`
--

INSERT INTO `case_parties` (`id`, `case_id`, `person_id`, `party_role`, `statement`, `statement_date`, `statement_audio_path`, `statement_signed_document`, `is_primary`, `created_at`, `witness_affiliation`, `affiliated_person_id`) VALUES
(1, 5, 1, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:12:03', 'neutral', NULL),
(2, 5, 2, 'accused', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:12:03', 'neutral', NULL),
(3, 6, 3, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:33:51', 'neutral', NULL),
(4, 6, 4, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:33:52', 'neutral', NULL),
(5, 7, 5, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:35:03', 'neutral', NULL),
(6, 7, 6, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:35:04', 'neutral', NULL),
(7, 7, 7, 'accused', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:35:04', 'neutral', NULL),
(8, 7, 8, 'accused', NULL, NULL, NULL, NULL, 1, '2025-12-29 15:35:05', 'neutral', NULL),
(9, 8, 9, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-31 00:55:54', 'neutral', NULL),
(10, 9, 10, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-31 00:57:15', 'neutral', NULL),
(11, 9, 11, 'accused', NULL, NULL, NULL, NULL, 1, '2025-12-31 00:57:15', 'neutral', NULL),
(12, 10, 12, 'accuser', NULL, NULL, NULL, NULL, 1, '2025-12-31 01:32:42', 'neutral', NULL),
(13, 10, 13, 'accused', NULL, NULL, NULL, NULL, 1, '2025-12-31 01:32:43', 'neutral', NULL),
(14, 10, 14, 'accused', NULL, NULL, NULL, NULL, 0, '2025-12-31 22:46:06', 'neutral', NULL),
(15, 10, 15, 'accuser', NULL, NULL, NULL, NULL, 0, '2025-12-31 22:50:50', 'neutral', NULL),
(16, 10, 18, 'witness', NULL, NULL, NULL, NULL, 0, '2025-12-31 23:26:07', 'accuser', 12),
(17, 10, 19, 'witness', NULL, NULL, NULL, NULL, 0, '2025-12-31 23:40:46', 'neutral', NULL),
(18, 11, 20, 'accuser', NULL, NULL, NULL, NULL, 1, '2026-01-03 22:34:08', 'neutral', NULL),
(19, 11, 21, 'accused', NULL, NULL, NULL, NULL, 1, '2026-01-03 22:34:08', 'neutral', NULL),
(20, 11, 22, 'accused', NULL, NULL, NULL, NULL, 1, '2026-01-03 22:34:09', 'neutral', NULL),
(21, 11, 23, 'accused', NULL, NULL, NULL, NULL, 1, '2026-01-03 22:34:10', 'neutral', NULL),
(22, 11, 24, '', NULL, NULL, NULL, NULL, 1, '2026-01-03 22:34:11', 'neutral', NULL),
(23, 12, 25, 'accuser', NULL, NULL, NULL, NULL, 1, '2026-01-08 11:00:00', 'neutral', NULL),
(24, 12, 26, 'accused', NULL, NULL, NULL, NULL, 1, '2026-01-08 11:00:00', 'neutral', NULL),
(25, 13, 27, 'accuser', NULL, NULL, NULL, NULL, 1, '2026-01-12 17:55:38', 'neutral', NULL),
(26, 13, 28, 'accused', NULL, NULL, NULL, NULL, 1, '2026-01-12 17:55:38', 'neutral', NULL),
(27, 13, 29, 'witness', NULL, NULL, NULL, NULL, 0, '2026-01-12 18:12:31', 'accuser', 27);

-- --------------------------------------------------------

--
-- Table structure for table `case_relationships`
--

CREATE TABLE `case_relationships` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `related_case_id` int(10) UNSIGNED NOT NULL,
  `relationship_type` varchar(50) DEFAULT 'related' COMMENT 'related, duplicate, continuation, series',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `case_status_history`
--

CREATE TABLE `case_status_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `previous_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) NOT NULL,
  `changed_by` int(10) UNSIGNED NOT NULL,
  `changed_at` datetime DEFAULT current_timestamp(),
  `reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `case_status_history`
--

INSERT INTO `case_status_history` (`id`, `case_id`, `previous_status`, `new_status`, `changed_by`, `changed_at`, `reason`) VALUES
(1, 10, 'approved', 'pending_court', 26, '2026-01-02 20:26:29', 'Case sent to court by investigator. Court status changed from not_sent to sent_to_court'),
(3, 10, 'pending_court', 'investigating', 27, '2026-01-03 09:04:48', 'Assigned back to investigator by court with deadline: 2026-01-10. Notes: gdhhddhd'),
(4, 10, 'investigating', 'investigating', 27, '2026-01-03 09:06:01', 'Assigned back to investigator by court with deadline: 2026-01-10. Notes: fghj');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(7) DEFAULT '#3498db',
  `icon` varchar(50) DEFAULT 'fa-folder',
  `is_active` tinyint(1) DEFAULT 1,
  `display_order` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `color`, `icon`, `is_active`, `display_order`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 'Violent Crimes', 'Cases involving violence against persons', '#e74c3c', 'fa-hand-fist', 1, 1, '2026-01-02 12:18:50', '2026-01-02 10:13:20', NULL),
(2, 'Property Crimes', 'Cases involving theft, burglary, vandalism', '#f39c12', 'fa-home', 1, 2, '2026-01-02 12:18:50', '2026-01-02 09:55:37', NULL),
(3, 'Drug Related', 'Cases involving drug possession, trafficking', '#9b59b6', 'fa-pills', 1, 3, '2026-01-02 12:18:50', '2026-01-02 12:18:50', NULL),
(4, 'Cybercrime', 'Cases involving computer and internet crimes', '#3498db', 'fa-laptop', 1, 4, '2026-01-02 12:18:50', '2026-01-02 12:18:50', NULL),
(5, 'Sexual Offenses', 'Cases involving sexual assault and harassment', '#e91e63', 'fa-user-shield', 1, 5, '2026-01-02 12:18:50', '2026-01-02 12:18:50', NULL),
(6, 'Juvenile Cases', 'Cases involving minors', '#00bcd4', 'fa-child', 1, 6, '2026-01-02 12:18:50', '2026-01-02 12:18:50', NULL),
(7, 'Other', 'Miscellaneous cases', '#95a5a6', 'fa-folder', 1, 7, '2026-01-02 12:18:50', '2026-01-02 12:18:50', NULL),
(9, 'Waaxda Tacadiyada', '', '#3498db', 'fa-hand-fist', 1, 0, '2026-01-11 07:21:37', '2026-01-11 07:21:37', 1),
(10, 'waaxda Dilalka', '', '#3498db', 'fa-folder', 1, 0, '2026-01-11 07:21:52', '2026-01-11 07:21:52', 1),
(11, 'Waaxda Danbiyada Abaabulan', '', '#3498db', 'fa-skull', 1, 0, '2026-01-11 07:22:21', '2026-01-11 07:22:21', 1),
(12, 'Waaxda Caafimaadka', '', '#3498db', 'fa-pills', 1, 0, '2026-01-11 07:22:42', '2026-01-11 07:22:42', 1),
(13, 'Waaxda Human Trafficking', '', '#3498db', 'fa-child', 1, 0, '2026-01-11 07:23:08', '2026-01-11 07:23:08', 1);

-- --------------------------------------------------------

--
-- Table structure for table `court_assignments`
--

CREATE TABLE `court_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `assigned_to` int(10) UNSIGNED NOT NULL,
  `assigned_by` int(10) UNSIGNED NOT NULL,
  `assigned_date` datetime DEFAULT current_timestamp(),
  `deadline` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('active','completed','cancelled') DEFAULT 'active',
  `completed_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `court_assignments`
--

INSERT INTO `court_assignments` (`id`, `case_id`, `assigned_to`, `assigned_by`, `assigned_date`, `deadline`, `notes`, `status`, `completed_date`, `created_at`, `updated_at`) VALUES
(3, 10, 26, 27, '2026-01-03 12:04:48', '2026-01-10', 'gdhhddhd', 'active', NULL, '2026-01-03 12:04:48', '2026-01-03 12:04:48');

-- --------------------------------------------------------

--
-- Table structure for table `court_communications`
--

CREATE TABLE `court_communications` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `report_id` int(10) UNSIGNED DEFAULT NULL,
  `communication_type` enum('submission','response','hearing_notice','directive','verdict','adjournment','order') DEFAULT 'submission',
  `court_reference` varchar(100) DEFAULT NULL,
  `communication_date` date NOT NULL,
  `received_from` varchar(100) DEFAULT NULL,
  `sent_to` varchar(100) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `summary` text DEFAULT NULL,
  `document_path` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custody_alerts`
--

CREATE TABLE `custody_alerts` (
  `id` int(10) UNSIGNED NOT NULL,
  `custody_record_id` int(10) UNSIGNED NOT NULL,
  `alert_type` enum('time_limit_warning','time_limit_exceeded','health_critical','escape_attempt','behavior_incident','other') NOT NULL,
  `alert_severity` enum('low','medium','high','critical') NOT NULL,
  `alert_message` text NOT NULL,
  `is_acknowledged` tinyint(1) DEFAULT 0,
  `acknowledged_by` int(10) UNSIGNED DEFAULT NULL,
  `acknowledged_at` datetime DEFAULT NULL,
  `is_resolved` tinyint(1) DEFAULT 0,
  `resolved_by` int(10) UNSIGNED DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `resolution_notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custody_daily_logs`
--

CREATE TABLE `custody_daily_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `custody_record_id` int(10) UNSIGNED NOT NULL,
  `log_date` date NOT NULL,
  `log_time` time NOT NULL,
  `custody_status` enum('in_custody','released','transferred','escaped','hospitalized','court_appearance') NOT NULL,
  `location` varchar(255) NOT NULL,
  `health_check_done` tinyint(1) DEFAULT 0,
  `health_status` enum('good','fair','poor','critical') DEFAULT 'good',
  `health_notes` text DEFAULT NULL,
  `meal_provided` tinyint(1) DEFAULT 0,
  `exercise_allowed` tinyint(1) DEFAULT 0,
  `visitor_allowed` tinyint(1) DEFAULT 0,
  `visitor_names` text DEFAULT NULL,
  `behavior_notes` text DEFAULT NULL,
  `incident_notes` text DEFAULT NULL,
  `logged_by` int(10) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custody_daily_logs`
--

INSERT INTO `custody_daily_logs` (`id`, `custody_record_id`, `log_date`, `log_time`, `custody_status`, `location`, `health_check_done`, `health_status`, `health_notes`, `meal_provided`, `exercise_allowed`, `visitor_allowed`, `visitor_names`, `behavior_notes`, `incident_notes`, `logged_by`, `created_at`) VALUES
(1, 1, '2026-01-03', '20:34:58', 'in_custody', 'Station Lock-up', 0, 'good', 'Initial custody intake', 0, 0, 0, NULL, NULL, NULL, 25, '2026-01-03 23:34:58'),
(2, 2, '2026-01-03', '20:35:33', 'in_custody', 'Station Lock-up', 0, 'good', 'Initial custody intake', 0, 0, 0, NULL, NULL, NULL, 25, '2026-01-03 23:35:33'),
(3, 3, '2026-01-08', '08:03:32', 'in_custody', 'xabsiga kismayo', 0, 'good', 'Initial custody intake', 0, 0, 0, NULL, NULL, NULL, 25, '2026-01-08 11:03:32');

-- --------------------------------------------------------

--
-- Table structure for table `custody_movement_log`
--

CREATE TABLE `custody_movement_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `custody_record_id` int(10) UNSIGNED NOT NULL,
  `movement_type` enum('transfer','court_appearance','hospital_visit','interrogation','lineup','release') NOT NULL,
  `from_location` varchar(255) NOT NULL,
  `to_location` varchar(255) NOT NULL,
  `movement_start` datetime NOT NULL,
  `movement_end` datetime DEFAULT NULL,
  `authorized_by` int(10) UNSIGNED NOT NULL,
  `authorization_document` varchar(255) DEFAULT NULL,
  `escorted_by` text DEFAULT NULL COMMENT 'Names of escorting officers',
  `vehicle_details` varchar(255) DEFAULT NULL,
  `purpose` text NOT NULL,
  `outcome` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custody_records`
--

CREATE TABLE `custody_records` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `person_id` int(10) UNSIGNED NOT NULL,
  `center_id` int(10) UNSIGNED NOT NULL,
  `custody_status` enum('in_custody','released','transferred','escaped','hospitalized','court_appearance') NOT NULL,
  `presence_status` enum('not_present','present') DEFAULT 'not_present',
  `arrival_date` datetime DEFAULT NULL COMMENT 'When the accused actually arrived',
  `bail_status` enum('not_bailed','bailed') DEFAULT 'not_bailed' COMMENT 'Whether accused is bailed or in custody',
  `bail_granted_date` datetime DEFAULT NULL,
  `bail_conditions` text DEFAULT NULL COMMENT 'Conditions of bail if granted',
  `custody_location` varchar(255) NOT NULL,
  `cell_number` varchar(50) DEFAULT NULL,
  `custody_start` datetime NOT NULL,
  `custody_end` datetime DEFAULT NULL,
  `expected_release_date` datetime DEFAULT NULL,
  `arrest_warrant_number` varchar(100) DEFAULT NULL,
  `detention_order_path` varchar(255) DEFAULT NULL,
  `legal_time_limit` int(10) UNSIGNED DEFAULT NULL COMMENT 'Hours allowed by law',
  `health_status` enum('good','fair','poor','critical') DEFAULT 'good',
  `medical_conditions` text DEFAULT NULL,
  `medications` text DEFAULT NULL,
  `last_health_check` datetime DEFAULT NULL,
  `custody_notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custody_records`
--

INSERT INTO `custody_records` (`id`, `case_id`, `person_id`, `center_id`, `custody_status`, `presence_status`, `arrival_date`, `bail_status`, `bail_granted_date`, `bail_conditions`, `custody_location`, `cell_number`, `custody_start`, `custody_end`, `expected_release_date`, `arrest_warrant_number`, `detention_order_path`, `legal_time_limit`, `health_status`, `medical_conditions`, `medications`, `last_health_check`, `custody_notes`, `created_at`, `created_by`, `updated_at`) VALUES
(1, 11, 24, 7, 'in_custody', 'not_present', NULL, 'not_bailed', NULL, NULL, 'Station Lock-up', 'cell 3', '2026-01-03 20:34:57', NULL, NULL, NULL, NULL, 48, 'good', NULL, NULL, NULL, 'vegdvd', '2026-01-03 20:34:58', 25, '2026-01-03 20:34:58'),
(2, 11, 23, 7, 'in_custody', 'not_present', NULL, 'not_bailed', NULL, NULL, 'Station Lock-up', 'cell 3', '2026-01-03 20:35:33', NULL, NULL, NULL, NULL, 48, 'good', NULL, NULL, NULL, 'rtyu', '2026-01-03 20:35:33', 25, '2026-01-03 20:35:33'),
(3, 12, 26, 7, 'in_custody', 'not_present', NULL, 'not_bailed', NULL, NULL, 'xabsiga kismayo', 'cell 4', '2026-01-08 08:03:32', NULL, NULL, NULL, NULL, 48, 'good', NULL, NULL, NULL, 'ninkaan gaari iyo xoog ayaa soo qabashadiisa nagu qaadatay', '2026-01-08 08:03:32', 25, '2026-01-08 08:03:32');

-- --------------------------------------------------------

--
-- Table structure for table `digital_signatures`
--

CREATE TABLE `digital_signatures` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_type` varchar(50) NOT NULL COMMENT 'cases, investigation_reports, evidence, etc',
  `entity_id` int(10) UNSIGNED NOT NULL,
  `signature_hash` varchar(64) NOT NULL,
  `signature_algorithm` varchar(50) DEFAULT 'SHA256-RSA',
  `signature_data` text NOT NULL COMMENT 'Base64 encoded signature',
  `signed_by` int(10) UNSIGNED NOT NULL,
  `signed_at` datetime DEFAULT current_timestamp(),
  `certificate_data` text DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 1,
  `verified_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_templates`
--

CREATE TABLE `document_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `template_name` varchar(100) NOT NULL,
  `template_type` enum('investigation_report','court_submission','letter','form','other') NOT NULL,
  `report_category` varchar(50) DEFAULT NULL,
  `template_content` longtext NOT NULL,
  `variables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Template variables for replacement' CHECK (json_valid(`variables`)),
  `required_sections` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`required_sections`)),
  `optional_sections` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`optional_sections`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `document_templates`
--

INSERT INTO `document_templates` (`id`, `template_name`, `template_type`, `report_category`, `template_content`, `variables`, `required_sections`, `optional_sections`, `is_active`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 'Investigation Report', 'investigation_report', NULL, 'INVESTIGATION REPORT\n\nCase Number: {{case_number}}\nOB Number: {{ob_number}}\nDate: {{report_date}}\n\nINVESTIGATOR DETAILS:\nName: {{investigator_name}}\nBadge Number: {{investigator_badge}}\n\nCASE SUMMARY:\n{{case_summary}}\n\nFINDINGS:\n{{findings}}\n\nEVIDENCE COLLECTED:\n{{evidence_list}}\n\nCONCLUSION:\n{{conclusion}}\n\nRECOMMENDATION:\n{{recommendation}}\n\nSigned:\n{{investigator_signature}}\nDate: {{signature_date}}', '[\"case_number\", \"ob_number\", \"report_date\", \"investigator_name\", \"investigator_badge\", \"case_summary\", \"findings\", \"evidence_list\", \"conclusion\", \"recommendation\", \"investigator_signature\", \"signature_date\"]', NULL, NULL, 1, '2025-12-29 10:58:10', '2025-12-29 10:58:10', NULL),
(2, 'Court Submission Letter', 'court_submission', NULL, 'COURT SUBMISSION\n\nTo: The Honorable Court\nFrom: {{police_center_name}}\nDate: {{submission_date}}\n\nRe: Case Number {{case_number}} - {{crime_type}}\n\nDear Sir/Madam,\n\nWe hereby submit the investigation file for the above-mentioned case for your kind consideration.\n\nACCUSED: {{accused_names}}\nCRIME: {{crime_type}}\nINCIDENT DATE: {{incident_date}}\n\nAll evidence and investigation reports are attached herewith.\n\nYours faithfully,\n{{admin_name}}\n{{admin_title}}\n{{police_center_name}}', '[\"police_center_name\", \"submission_date\", \"case_number\", \"crime_type\", \"accused_names\", \"incident_date\", \"admin_name\", \"admin_title\"]', NULL, NULL, 1, '2025-12-29 10:58:10', '2025-12-29 10:58:10', NULL),
(3, 'Preliminary Investigation Report (PIR)', '', 'investigation', 'PRELIMINARY INVESTIGATION REPORT (PIR)\r\n\r\nCASE IDENTIFICATION\r\nCase Number: {{case_number}}\r\nOB Number: {{ob_number}}\r\nReport Date: {{report_date}}\r\n\r\nINVESTIGATING OFFICER\r\nName: {{investigator_name}}\r\nBadge Number: {{investigator_badge}}\r\nContact: {{investigator_phone}}\r\nStation: {{police_center_name}}\r\n\r\nCASE OVERVIEW\r\nCrime Type: {{crime_type}}\r\nCrime Category: {{crime_category}}\r\nIncident Date: {{incident_date}}\r\nIncident Time: {{incident_time}}\r\nLocation: {{incident_location}}\r\nPriority Level: {{priority}}\r\nSensitive Case: {{is_sensitive}}\r\n\r\nINCIDENT DESCRIPTION\r\n{{incident_description}}\r\n\r\nINITIAL ASSESSMENT\r\n\r\nParties Involved:\r\n- Accused: {{total_accused}}\r\n{{accused_list}}\r\n\r\n- Victims/Complainants: {{total_accusers}}\r\n{{accuser_list}}\r\n\r\n- Witnesses: {{total_witnesses}}\r\n{{witness_list}}\r\n\r\nInitial Evidence Collected:\r\nTotal Items: {{total_evidence}}\r\n{{evidence_list}}\r\n\r\nPRELIMINARY FINDINGS\r\n[To be completed by investigator - Initial observations and assessment]\r\n\r\nINVESTIGATIVE PLAN\r\n[To be completed by investigator - Planned activities and timeline]\r\n\r\n1. Planned Interviews:\r\n2. Evidence to Collect:\r\n3. Scene Examination:\r\n4. Forensic Analysis Required:\r\n\r\nRESOURCE REQUIREMENTS\r\n[Equipment, personnel, budget needs]\r\n\r\nRISK ASSESSMENT\r\nFlight Risk: [Assessment]\r\nPublic Safety Risk: [Assessment]\r\nEvidence Degradation Risk: [Assessment]\r\n\r\nNEXT STEPS\r\n[Immediate actions to be taken]\r\n\r\nTimeline Estimate: [Days/Weeks]\r\n\r\n___________________________\r\n{{investigator_name}}\r\n{{investigator_badge}}\r\nDate: {{report_date}}\r\n\r\nSUPERVISOR APPROVAL\r\n___________________________\r\nName: \r\nDate:', '[\"case_number\", \"ob_number\", \"crime_type\", \"incident_date\", \"incident_location\", \"accused_names\", \"accuser_names\", \"witness_names\", \"investigator_name\", \"investigator_badge\", \"police_center_name\", \"report_date\", \"total_evidence\"]', '[\"case_overview\", \"initial_assessment\", \"investigative_plan\"]', '[\"resource_requirements\", \"risk_assessment\"]', 1, '2026-01-10 11:45:48', '2026-01-10 11:45:48', NULL),
(4, 'Interim Progress Report', '', 'investigation', 'INTERIM PROGRESS REPORT\r\n\r\nCASE IDENTIFICATION\r\nCase Number: {{case_number}}\r\nOB Number: {{ob_number}}\r\nReport Date: {{report_date}}\r\nReporting Period: [Start Date] to [End Date]\r\n\r\nINVESTIGATING OFFICER\r\nName: {{investigator_name}}\r\nBadge Number: {{investigator_badge}}\r\nStation: {{police_center_name}}\r\n\r\nINVESTIGATION PROGRESS SUMMARY\r\nCurrent Status: {{case_status}}\r\nProgress Percentage: [%]\r\n\r\nACTIVITIES COMPLETED DURING PERIOD\r\n\r\n1. Interviews Conducted:\r\n   [Details]\r\n\r\n2. Evidence Collected:\r\n   New Items: [Number]\r\n   {{evidence_list}}\r\n\r\n3. Scene Visits:\r\n   [Details]\r\n\r\n4. Forensic Analysis:\r\n   [Details]\r\n\r\n5. Follow-up Actions:\r\n   [Details]\r\n\r\nLEADS FOLLOWED AND OUTCOMES\r\n[Details of investigative leads]\r\n\r\nCHALLENGES ENCOUNTERED\r\n[Any obstacles or difficulties]\r\n\r\nWITNESS STATEMENTS STATUS\r\nTotal Witnesses: {{total_witnesses}}\r\nStatements Obtained: [Number]\r\nPending: [Number]\r\n\r\nCUSTODY STATUS (if applicable)\r\n[Details of accused in custody]\r\n\r\nNEXT INVESTIGATIVE STEPS\r\n1.\r\n2.\r\n3.\r\n\r\nTIMELINE UPDATE\r\nOriginal Deadline: [Date]\r\nRevised Estimate: [Date if changed]\r\nReason for Change: [If applicable]\r\n\r\nBUDGET STATUS (if applicable)\r\nAllocated: [Amount]\r\nSpent: [Amount]\r\nRemaining: [Amount]\r\n\r\n___________________________\r\n{{investigator_name}}\r\n{{investigator_badge}}\r\nDate: {{report_date}}', '[\"case_number\", \"ob_number\", \"crime_type\", \"incident_date\", \"incident_location\", \"accused_names\", \"accuser_names\", \"witness_names\", \"investigator_name\", \"investigator_badge\", \"police_center_name\", \"report_date\", \"total_evidence\"]', '[\"progress_summary\", \"activities_completed\", \"next_steps\"]', '[\"challenges\", \"budget_status\"]', 1, '2026-01-10 11:45:48', '2026-01-10 11:45:48', NULL),
(5, 'Final Investigation Report (FIR)', '', 'investigation', 'FINAL INVESTIGATION REPORT (FIR)\r\n\r\nCASE IDENTIFICATION\r\nCase Number: {{case_number}}\r\nOB Number: {{ob_number}}\r\nReport Date: {{report_date}}\r\n\r\nINVESTIGATING OFFICER\r\nName: {{investigator_name}}\r\nBadge Number: {{investigator_badge}}\r\nStation: {{police_center_name}}\r\nContact: {{investigator_phone}}\r\n\r\nEXECUTIVE SUMMARY\r\n[Brief overview of the investigation and key findings]\r\n\r\nCASE BACKGROUND\r\nCrime: {{crime_type}} ({{crime_category}})\r\nIncident Date: {{incident_date}}\r\nLocation: {{incident_location}}\r\nPriority: {{priority}}\r\nSensitive: {{is_sensitive}}\r\n\r\nINCIDENT DESCRIPTION\r\n{{incident_description}}\r\n\r\nPARTIES INVOLVED\r\n\r\nTHE ACCUSED:\r\n{{accused_list}}\r\n\r\nTHE VICTIMS/COMPLAINANTS:\r\n{{accuser_list}}\r\n\r\nWITNESSES:\r\n{{witness_list}}\r\n\r\nINVESTIGATION ACTIVITIES CONDUCTED\r\n[Chronological summary of investigation]\r\n\r\n1. Initial Response:\r\n2. Scene Examination:\r\n3. Interviews:\r\n4. Evidence Collection:\r\n5. Forensic Analysis:\r\n\r\nEVIDENCE SUMMARY\r\nTotal Evidence Items: {{total_evidence}}\r\nCritical Evidence: {{critical_evidence_count}}\r\n\r\nDetailed Evidence List:\r\n{{evidence_list}}\r\n\r\nEvidence Analysis:\r\n[Analysis of key evidence and its significance]\r\n\r\nWITNESS TESTIMONIES\r\n[Summary of witness statements and credibility assessment]\r\n\r\nSUSPECT ANALYSIS\r\n[Detailed analysis of accused involvement]\r\n\r\nMotive: [Analysis]\r\nMeans: [Analysis]\r\nOpportunity: [Analysis]\r\nAlibi Verification: [Results]\r\n\r\nFINDINGS AND CONCLUSIONS\r\n\r\nKey Findings:\r\n1.\r\n2.\r\n3.\r\n\r\nEvidence Links Suspect to Crime:\r\n[Details]\r\n\r\nConclusion:\r\n[Professional assessment of the case]\r\n\r\nINVESTIGATOR OPINION\r\nCase Strength: [Weak/Moderate/Strong/Conclusive]\r\nRecommendation: [Prosecute/Dismiss/Further Investigation]\r\n\r\nRECOMMENDATIONS\r\n\r\nRecommended Charges:\r\n1.\r\n2.\r\n\r\nProsecution Strategy:\r\n[Suggestions for prosecution]\r\n\r\nAdditional Actions Required:\r\n[If any]\r\n\r\nAPPENDICES\r\nA. Evidence List with Photos\r\nB. Witness Statement Summaries\r\nC. Forensic Reports\r\nD. Scene Diagrams/Maps\r\nE. Timeline of Events\r\n\r\nInvestigation Duration: [Days]\r\nTotal Evidence Collected: {{total_evidence}}\r\nTotal Witnesses: {{total_witnesses}}\r\n\r\nCERTIFICATION\r\nI hereby certify that this report is a true and accurate account of the investigation conducted.\r\n\r\n___________________________\r\n{{investigator_name}}\r\nInvestigating Officer\r\nBadge: {{investigator_badge}}\r\nDate: {{report_date}}\r\n\r\nSIGNATURE: _________________\r\n\r\nCOMMANDER APPROVAL\r\n___________________________\r\nName:\r\nRank:\r\nDate:\r\nSignature: _________________', '[\"case_number\", \"ob_number\", \"crime_type\", \"incident_date\", \"incident_location\", \"accused_names\", \"accuser_names\", \"witness_names\", \"investigator_name\", \"investigator_badge\", \"police_center_name\", \"report_date\", \"total_evidence\"]', '[\"executive_summary\", \"findings\", \"evidence_summary\", \"conclusions\", \"recommendations\"]', '[\"timeline\", \"costs\"]', 1, '2026-01-10 11:45:48', '2026-01-10 11:45:48', NULL),
(6, 'Court Submission Docket', 'court_submission', 'court', 'COURT SUBMISSION DOCKET\r\n\r\nTO: THE HONORABLE COURT\r\nFROM: {{police_center_name}}\r\nDATE: {{report_date}}\r\n\r\nRE: CASE NUMBER {{case_number}} - {{crime_type}}\r\n\r\nCASE IDENTIFICATION\r\nPolice Case Number: {{case_number}}\r\nOB Number: {{ob_number}}\r\nCourt Reference: [To be assigned by court]\r\n\r\nCOMPLAINANT/VICTIM DETAILS\r\n{{accuser_list}}\r\n\r\nACCUSED PERSON(S) DETAILS\r\n{{accused_list}}\r\n\r\nCHARGES PREFERRED\r\n[List of specific criminal code sections violated]\r\n\r\n1. Charge: [Criminal Code Section]\r\n   Particulars: [Details]\r\n\r\n2. Charge: [If multiple charges]\r\n   Particulars: [Details]\r\n\r\nBRIEF FACTS OF THE CASE\r\nOn {{incident_date}} at approximately {{incident_time}}, at {{incident_location}}, the following incident occurred:\r\n\r\n{{incident_description}}\r\n\r\n[Narrative of events leading to the charges]\r\n\r\nDATE, TIME, AND PLACE OF OFFENSE\r\nDate: {{incident_date}}\r\nTime: {{incident_time}}\r\nPlace: {{incident_location}}\r\n\r\nINVESTIGATING OFFICER DETAILS\r\nName: {{investigator_name}}\r\nBadge Number: {{investigator_badge}}\r\nStation: {{police_center_name}}\r\nContact: {{investigator_phone}}\r\n\r\nEVIDENCE SUMMARY\r\nTotal Exhibits: {{total_evidence}}\r\nCritical Evidence: {{critical_evidence_count}}\r\n\r\nList of Exhibits to be Presented:\r\n{{evidence_list}}\r\n\r\nPROSECUTION WITNESSES\r\nTotal Witnesses: {{total_witnesses}}\r\n\r\nList of Witnesses:\r\n{{witness_list}}\r\n\r\nATTACHED DOCUMENTS\r\n1. Final Investigation Report\r\n2. Evidence List with Chain of Custody\r\n3. Witness Statements\r\n4. Forensic Reports (if any)\r\n5. Medical Reports (if applicable)\r\n6. Scene Photographs\r\n\r\nPRAYER FOR COURT ACTION\r\nWe hereby submit this case file for your kind consideration and request that:\r\n1. The accused be formally charged as per the charges preferred\r\n2. The case be set for hearing\r\n3. [Any other specific requests]\r\n\r\nSTATION COMMANDER APPROVAL\r\nThis submission is approved and forwarded to the Honorable Court.\r\n\r\n___________________________\r\nCommander Name:\r\nBadge Number:\r\nSignature:\r\nDate:\r\n\r\nOfficial Stamp:\r\n{{police_center_name}}', '[\"case_number\", \"ob_number\", \"crime_type\", \"incident_date\", \"incident_location\", \"accused_names\", \"accuser_names\", \"witness_names\", \"investigator_name\", \"investigator_badge\", \"police_center_name\", \"report_date\", \"total_evidence\"]', '[\"case_identification\", \"charges\", \"accused_details\", \"brief_facts\", \"evidence_list\", \"witness_list\"]', '[\"prayer_for_relief\"]', 1, '2026-01-10 11:45:48', '2026-01-10 11:45:48', NULL),
(7, 'Evidence Presentation Report (Exhibit List)', 'investigation_report', 'court', 'EVIDENCE PRESENTATION REPORT\r\nEXHIBIT LIST FOR COURT\r\n\r\nCASE IDENTIFICATION\r\nCase Number: {{case_number}}\r\nOB Number: {{ob_number}}\r\nCourt Reference: [Court assigned number]\r\nDate: {{report_date}}\r\n\r\nINVESTIGATING OFFICER\r\nName: {{investigator_name}}\r\nBadge Number: {{investigator_badge}}\r\nStation: {{police_center_name}}\r\n\r\nEVIDENCE SUMMARY\r\nTotal Exhibits: {{total_evidence}}\r\nPhysical Evidence: {{evidence_physical_count}}\r\nDigital Evidence: {{evidence_digital_count}}\r\nDocumentary Evidence: {{evidence_document_count}}\r\nCritical Evidence Items: {{critical_evidence_count}}\r\n\r\nCOMPLETE EXHIBIT LIST\r\n\r\n{{evidence_list}}\r\n\r\nCHAIN OF CUSTODY CERTIFICATION\r\nAll evidence items have been handled according to standard procedures.\r\nChain of custody has been maintained throughout.\r\n\r\nEvidence Storage Location: [Details]\r\nEvidence Custodian: [Name and Badge]\r\n\r\nEVIDENCE AUTHENTICATION\r\nAll digital evidence has been authenticated and verified.\r\nAll physical evidence has been properly tagged and secured.\r\nAll documents have been verified for authenticity.\r\n\r\nFORENSIC ANALYSIS SUMMARY\r\n[Summary of any forensic examinations performed]\r\n\r\nEXPERT WITNESS RECOMMENDATIONS\r\nThe following expert witnesses may be required to authenticate evidence:\r\n1. [Expert name and field - if applicable]\r\n2. [Expert name and field - if applicable]\r\n\r\nEVIDENCE HANDLING INSTRUCTIONS FOR COURT\r\n[Special handling requirements for sensitive evidence]\r\n\r\nCERTIFICATION\r\nI certify that the evidence listed above has been collected, preserved, and documented according to proper procedures and is ready for presentation to the court.\r\n\r\n___________________________\r\n{{investigator_name}}\r\nEvidence Officer\r\nBadge: {{investigator_badge}}\r\nDate: {{report_date}}\r\n\r\nSignature: _________________', '[\"case_number\", \"ob_number\", \"crime_type\", \"incident_date\", \"incident_location\", \"accused_names\", \"accuser_names\", \"witness_names\", \"investigator_name\", \"investigator_badge\", \"police_center_name\", \"report_date\", \"total_evidence\"]', '[\"exhibit_list\", \"chain_of_custody\", \"authentication\"]', '[\"expert_opinions\"]', 1, '2026-01-10 11:45:48', '2026-01-10 11:45:48', NULL),
(8, 'Supplementary Investigation Report', 'investigation_report', 'investigation', 'SUPPLEMENTARY INVESTIGATION REPORT\r\n\r\nCASE IDENTIFICATION\r\nCase Number: {{case_number}}\r\nOB Number: {{ob_number}}\r\nCourt Reference: [Court number]\r\nReport Date: {{report_date}}\r\n\r\nCOURT DIRECTIVE REFERENCE\r\nCourt Order Date: [Date]\r\nOrder Number: [If applicable]\r\nAssigned Back Date: [Date]\r\nDeadline: [Date]\r\n\r\nINVESTIGATING OFFICER\r\nName: {{investigator_name}}\r\nBadge Number: {{investigator_badge}}\r\nStation: {{police_center_name}}\r\n\r\nCOURT\'S SPECIFIC QUERIES/DIRECTIVES\r\n[List of specific issues court raised or requested investigation on]\r\n\r\n1.\r\n2.\r\n3.\r\n\r\nADDITIONAL INVESTIGATION CONDUCTED\r\n\r\nPeriod: [Start Date] to [End Date]\r\n\r\nActivities:\r\n1. [Activity and date]\r\n2. [Activity and date]\r\n\r\nNEW EVIDENCE OBTAINED\r\n[Details of new evidence collected]\r\n\r\n{{evidence_list}}\r\n\r\nNEW WITNESS STATEMENTS\r\n[Details of additional witnesses interviewed]\r\n\r\nANALYSIS OF NEW FINDINGS\r\n[How new information relates to court\'s queries]\r\n\r\nResponse to Court Query #1:\r\n[Detailed response]\r\n\r\nResponse to Court Query #2:\r\n[Detailed response]\r\n\r\nUPDATED CONCLUSIONS\r\n[Any changes to original conclusions based on new information]\r\n\r\nCOMPLIANCE STATEMENT\r\nAll directives from the Honorable Court have been fully complied with.\r\nAll requested investigations have been completed.\r\nAll questions raised have been addressed.\r\n\r\nATTACHMENTS\r\n1. New evidence items\r\n2. Additional witness statements\r\n3. Updated exhibits list\r\n4. Any additional documentation\r\n\r\nCHALLENGES ENCOUNTERED (if any)\r\n[Any difficulties in completing court\'s directives]\r\n\r\nRECOMMENDATIONS\r\n[Any new recommendations based on supplementary investigation]\r\n\r\n___________________________\r\n{{investigator_name}}\r\nInvestigating Officer\r\nBadge: {{investigator_badge}}\r\nDate: {{report_date}}\r\n\r\nSignature: _________________\r\n\r\nCOMMANDER APPROVAL\r\n___________________________\r\nName:\r\nDate:\r\nSignature: _________________', '[\"case_number\", \"ob_number\", \"crime_type\", \"incident_date\", \"incident_location\", \"accused_names\", \"accuser_names\", \"witness_names\", \"investigator_name\", \"investigator_badge\", \"police_center_name\", \"report_date\", \"total_evidence\"]', '[\"court_directive\", \"additional_investigation\", \"new_findings\", \"compliance_statement\"]', '[\"challenges_encountered\"]', 1, '2026-01-10 11:45:48', '2026-01-10 11:45:48', NULL),
(9, 'Case Closure Report', 'other', 'closure', 'CASE CLOSURE REPORT\r\n\r\nCASE IDENTIFICATION\r\nCase Number: {{case_number}}\r\nOB Number: {{ob_number}}\r\nClosure Date: {{report_date}}\r\n\r\nINVESTIGATING OFFICER\r\nName: {{investigator_name}}\r\nBadge Number: {{investigator_badge}}\r\nStation: {{police_center_name}}\r\n\r\nCASE SUMMARY\r\nCrime: {{crime_type}} ({{crime_category}})\r\nIncident Date: {{incident_date}}\r\nReport Date: [Original date]\r\nClosure Date: {{report_date}}\r\n\r\nCASE OUTCOME\r\nOutcome: [Convicted/Acquitted/Dismissed/Withdrawn/Settled]\r\nCourt Verdict Date: [Date]\r\nCase Number: [Final court case number]\r\n\r\nVERDICT DETAILS\r\n[Summary of court verdict or closure reason]\r\n\r\nAccused: {{accused_names}}\r\nVerdict: [Details for each accused]\r\nSentence: [If conviction - details of sentence]\r\n\r\nCASE TIMELINE\r\nInvestigation Duration: [Total days from report to closure]\r\n\r\nKey Milestones:\r\n- Case Reported: [Date]\r\n- Investigation Started: [Date]\r\n- Investigation Completed: [Date]\r\n- Submitted to Court: [Date]\r\n- Trial Commenced: [Date]\r\n- Verdict: [Date]\r\n- Case Closed: [Date]\r\n\r\nINVESTIGATION STATISTICS\r\nTotal Evidence Items: {{total_evidence}}\r\nTotal Witnesses: {{total_witnesses}}\r\nNumber of Accused: {{total_accused}}\r\nInvestigation Duration: [Days]\r\nCourt Duration: [Days]\r\n\r\nEVIDENCE DISPOSITION\r\nTotal Evidence Items: {{total_evidence}}\r\n\r\nEvidence Status:\r\n- Returned to Owner: [Number]\r\n- Retained for Appeals: [Number]\r\n- Destroyed: [Number]\r\n- Archived: [Number]\r\n\r\nEvidence Disposal Plan:\r\n[Details of how evidence will be handled]\r\n\r\nCOSTS INCURRED (if tracked)\r\nInvestigation Costs: [Amount]\r\nCourt Costs: [Amount]\r\nTotal: [Amount]\r\n\r\nAPPEALS STATUS\r\nAppeal Filed: [Yes/No]\r\nAppeal Details: [If applicable]\r\n\r\nLESSONS LEARNED\r\n[Key takeaways from this case]\r\n\r\n1.\r\n2.\r\n3.\r\n\r\nINVESTIGATION QUALITY ASSESSMENT\r\nCase Strength: [Assessment]\r\nEvidence Quality: [Assessment]\r\nInvestigation Efficiency: [Assessment]\r\n\r\nAreas of Excellence:\r\n[What went well]\r\n\r\nAreas for Improvement:\r\n[What could be improved]\r\n\r\nFOLLOW-UP ACTIONS REQUIRED\r\n[Any pending actions]\r\n\r\n1.\r\n2.\r\n\r\nCASE ARCHIVAL INFORMATION\r\nArchive Location: [Physical/Digital location]\r\nRetention Period: [Years - typically 7 years]\r\nArchive Date: {{report_date}}\r\nDestruction Date: [Date after retention period]\r\n\r\nFINAL NOTES\r\n[Any additional information for record]\r\n\r\nCERTIFICATION\r\nThis case is hereby officially closed and archived.\r\n\r\n___________________________\r\n{{investigator_name}}\r\nInvestigating Officer\r\nBadge: {{investigator_badge}}\r\nDate: {{report_date}}\r\n\r\nSignature: _________________\r\n\r\nSTATION COMMANDER APPROVAL\r\n___________________________\r\nName:\r\nRank:\r\nDate:\r\nSignature: _________________\r\n\r\nOfficial Stamp:\r\n{{police_center_name}}', '[\"case_number\", \"ob_number\", \"crime_type\", \"incident_date\", \"incident_location\", \"accused_names\", \"accuser_names\", \"witness_names\", \"investigator_name\", \"investigator_badge\", \"police_center_name\", \"report_date\", \"total_evidence\"]', '[\"outcome\", \"verdict_details\", \"duration\", \"lessons_learned\", \"evidence_disposal\"]', '[\"costs\", \"appeals_status\"]', 1, '2026-01-10 11:45:49', '2026-01-10 11:45:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `evidence`
--

CREATE TABLE `evidence` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `evidence_number` varchar(50) NOT NULL,
  `evidence_type` enum('photo','video','audio','document','physical','digital') NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `file_size` int(10) UNSIGNED DEFAULT NULL,
  `is_encrypted` tinyint(1) DEFAULT 1,
  `encryption_key_hash` varchar(64) DEFAULT NULL,
  `collected_by` int(10) UNSIGNED DEFAULT NULL,
  `collected_from` enum('crime_scene','accuser','accused','witness','other') DEFAULT NULL,
  `collected_from_person_id` int(10) UNSIGNED DEFAULT NULL,
  `collected_at` datetime DEFAULT NULL,
  `location_collected` text DEFAULT NULL,
  `is_critical` tinyint(1) DEFAULT 0,
  `is_digital_signed` tinyint(1) DEFAULT 0,
  `signature_hash` varchar(64) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `is_edited` tinyint(1) DEFAULT 0,
  `last_edited_at` timestamp NULL DEFAULT NULL,
  `last_edited_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `evidence`
--

INSERT INTO `evidence` (`id`, `case_id`, `evidence_number`, `evidence_type`, `title`, `description`, `file_path`, `file_name`, `file_type`, `file_size`, `is_encrypted`, `encryption_key_hash`, `collected_by`, `collected_from`, `collected_from_person_id`, `collected_at`, `location_collected`, `is_critical`, `is_digital_signed`, `signature_hash`, `tags`, `is_edited`, `last_edited_at`, `last_edited_by`, `created_at`, `created_by`) VALUES
(1, 10, 'CASE/kcjd-r/2025/0001-E001', 'photo', 'sawirka dhaca', 'sawirka', 'evidence/2025/10/1767190362_2d8c3c9eef92b8ac7374.jpeg.enc', 'WhatsApp Image 2025-11-12 at 00.09.15 (1).jpeg', 'image/jpeg', 50455, 1, NULL, 26, NULL, 13, '2025-12-31 09:54:33', 'meesha daca', 1, 0, NULL, NULL, 1, '2025-12-31 11:12:42', 26, '2025-12-31 12:54:33', 26),
(2, 10, 'CASE/kcjd-r/2025/0001-E002', 'video', 'cadeenta', 'cadeenta la haaye waaaye', 'evidence/2025/10/1767175844_eaaef8e9a8d93f9cf591.mp4.enc', 'WhatsApp Video 2025-12-08 at 23.02.23.mp4', 'video/mp4', 7000044, 1, NULL, 26, NULL, 13, '2025-12-31 10:10:44', 'gabadhaan ayaa cadeen ah', 1, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 13:10:44', 26),
(3, 10, 'CASE/kcjd-r/2025/0001-E003', 'document', 'documents cadeen', 'aaab', 'evidence/2025/10/1767176412_bcb8a6d4326b5457a314.docx.enc', 'General Project Defense Presentation Structure.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 18662, 1, NULL, 26, NULL, 13, '2025-12-31 10:20:12', 'kii a keene', 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 13:20:12', 26),
(4, 10, 'CASE/kcjd-r/2025/0001-E004', 'audio', 'codka surta', 'cod kii waaye oo laga haaye', 'evidence/2025/10/1767192210_53c6e33a6a9c9c0e11c5.mp4.enc', 'Recording_15.m4a', 'audio/x-m4a', 440854, 1, NULL, 26, NULL, 13, '2025-12-31 14:43:30', 'gabadhaan ayaa cadeen ah', 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 17:43:30', 26),
(5, 10, 'CASE/kcjd-r/2025/0001-E005', 'photo', 'cadeenta', 'ggg', 'evidence/2025/10/1767210583_bca5c3caa75ab4ac9301.jpeg.enc', 'WhatsApp Image 2025-11-12 at 00.04.40.jpeg', 'image/jpeg', 198479, 1, NULL, 26, NULL, 14, '2025-12-31 19:49:43', 'hdhhdd', 1, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 22:49:43', 26),
(6, 10, 'CASE/kcjd-r/2025/0001-E006', 'audio', 'Audio Statement - 12/31/2025, 11:35:49 PM', 'Recorded audio statement', 'evidence/2025/10/1767213349_32ffef38e50105b5fa4a.webm.enc', 'audio_statement_1767213349451.webm', 'audio/webm', 147128, 1, NULL, 26, NULL, 18, '2025-12-31 20:35:49', NULL, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 23:35:49', 26),
(7, 10, 'CASE/kcjd-r/2025/0001-E007', 'audio', 'Audio Statement - 12/31/2025, 11:38:15 PM', 'Recorded audio statement', 'evidence/2025/10/1767213496_5cbb85ff42adf5e04ce6.webm.enc', 'audio_statement_1767213495759.webm', 'audio/webm', 201224, 1, NULL, 26, NULL, 18, '2025-12-31 20:38:16', NULL, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 23:38:16', 26),
(8, 10, 'CASE/kcjd-r/2025/0001-E008', 'audio', 'Audio Statement - 12/31/2025, 11:39:47 PM', 'Recorded audio statement', 'evidence/2025/10/1767213587_71206a2c5b95da7bc73f.webm.enc', 'audio_statement_1767213587446.webm', 'audio/webm', 469772, 1, NULL, 26, NULL, 18, '2025-12-31 20:39:47', NULL, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 23:39:47', 26),
(9, 10, 'CASE/kcjd-r/2025/0001-E009', 'photo', 'sawirka dhaca', 'DGGDGD', 'evidence/2025/10/1767213851_7d655ebcd65d3d5aba10.jpg.enc', 'v3_licensed-image.jpg', 'image/jpeg', 274167, 1, NULL, 26, NULL, 19, '2025-12-31 20:44:11', 'DGDGDGD', 1, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 23:44:11', 26),
(10, 10, 'CASE/kcjd-r/2025/0001-E010', 'audio', 'Audio Statement - 12/31/2025, 11:45:08 PM', 'Recorded audio statement', 'evidence/2025/10/1767213908_8805ad176eb4081da6f6.webm.enc', 'audio_statement_1767213908128.webm', 'audio/webm', 128774, 1, NULL, 26, NULL, 19, '2025-12-31 20:45:08', NULL, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-31 23:45:08', 26),
(11, 13, 'CASE/XGD-01/2026/0001-E001', 'photo', 'sawirka cadeenta', 'waa sawirka aan magalada kale ku jooga, waaxaana ahay qofka shaatiga cad', 'evidence/2026/13/1768230653_a1ae8b8e9eb580ec0087.jpg.enc', 'download (7).jpg', 'image/jpeg', 13598, 1, NULL, 30, NULL, 28, '2026-01-12 15:10:53', 'talephone kiisa whatsppka , waana xeybta liido ee kismayo', 1, 0, NULL, NULL, 0, NULL, NULL, '2026-01-12 18:10:53', 30);

-- --------------------------------------------------------

--
-- Table structure for table `evidence_custody_log`
--

CREATE TABLE `evidence_custody_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `evidence_id` int(10) UNSIGNED NOT NULL,
  `action` enum('collected','stored','transferred','analyzed','returned','disposed') NOT NULL,
  `performed_by` int(10) UNSIGNED NOT NULL,
  `performed_at` datetime DEFAULT current_timestamp(),
  `location` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `witness_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `evidence_custody_log`
--

INSERT INTO `evidence_custody_log` (`id`, `evidence_id`, `action`, `performed_by`, `performed_at`, `location`, `notes`, `witness_id`) VALUES
(1, 1, 'collected', 26, '2025-12-31 12:54:33', NULL, 'Evidence collected and uploaded to system', NULL),
(2, 1, '', 26, '2025-12-31 13:09:37', NULL, 'Evidence file downloaded by user', NULL),
(3, 1, '', 26, '2025-12-31 13:09:42', NULL, 'Evidence file downloaded by user', NULL),
(4, 1, '', 26, '2025-12-31 13:09:55', NULL, 'Evidence file downloaded by user', NULL),
(5, 2, 'collected', 26, '2025-12-31 13:10:44', NULL, 'Evidence collected and uploaded to system', NULL),
(6, 1, '', 26, '2025-12-31 13:10:47', NULL, 'Evidence file downloaded by user', NULL),
(7, 1, '', 26, '2025-12-31 13:10:59', NULL, 'Evidence file downloaded by user', NULL),
(8, 2, '', 26, '2025-12-31 13:11:23', NULL, 'Evidence file downloaded by user', NULL),
(9, 1, '', 26, '2025-12-31 13:12:49', NULL, 'Evidence file downloaded by user', NULL),
(10, 2, '', 26, '2025-12-31 13:12:53', NULL, 'Evidence file downloaded by user', NULL),
(11, 1, '', 26, '2025-12-31 13:14:44', NULL, 'Evidence file downloaded by user', NULL),
(12, 2, '', 26, '2025-12-31 13:14:48', NULL, 'Evidence file downloaded by user', NULL),
(13, 2, '', 26, '2025-12-31 13:14:53', NULL, 'Evidence file downloaded by user', NULL),
(14, 2, '', 26, '2025-12-31 13:15:14', NULL, 'Evidence file downloaded by user', NULL),
(15, 1, '', 26, '2025-12-31 13:19:31', NULL, 'Evidence file downloaded by user', NULL),
(16, 1, '', 26, '2025-12-31 13:19:33', NULL, 'Evidence file downloaded by user', NULL),
(17, 3, 'collected', 26, '2025-12-31 13:20:12', NULL, 'Evidence collected and uploaded to system', NULL),
(18, 1, '', 26, '2025-12-31 13:20:16', NULL, 'Evidence file downloaded by user', NULL),
(19, 1, '', 26, '2025-12-31 13:22:25', NULL, 'Evidence file downloaded by user', NULL),
(20, 3, '', 26, '2025-12-31 13:22:32', NULL, 'Evidence file downloaded by user', NULL),
(21, 1, '', 26, '2025-12-31 13:24:39', NULL, 'Evidence file downloaded by user', NULL),
(22, 3, '', 26, '2025-12-31 13:24:43', NULL, 'Evidence file downloaded by user', NULL),
(23, 1, '', 26, '2025-12-31 13:27:50', NULL, 'Evidence file downloaded by user', NULL),
(24, 3, '', 26, '2025-12-31 13:27:53', NULL, 'Evidence file downloaded by user', NULL),
(25, 1, '', 26, '2025-12-31 13:30:08', NULL, 'Evidence file downloaded by user', NULL),
(26, 3, '', 26, '2025-12-31 13:30:11', NULL, 'Evidence file downloaded by user', NULL),
(27, 1, '', 26, '2025-12-31 13:31:31', NULL, 'Evidence file downloaded by user', NULL),
(28, 3, '', 26, '2025-12-31 13:31:33', NULL, 'Evidence file downloaded by user', NULL),
(29, 1, '', 26, '2025-12-31 13:56:43', NULL, 'Evidence file downloaded by user', NULL),
(30, 3, '', 26, '2025-12-31 13:56:51', NULL, 'Evidence file downloaded by user', NULL),
(31, 2, '', 26, '2025-12-31 13:57:01', NULL, 'Evidence file downloaded by user', NULL),
(32, 1, '', 26, '2025-12-31 14:02:24', NULL, 'Evidence file downloaded by user', NULL),
(33, 1, '', 26, '2025-12-31 14:02:36', NULL, 'Evidence file downloaded by user', NULL),
(34, 1, '', 26, '2025-12-31 14:07:32', NULL, 'Evidence file downloaded by user', NULL),
(35, 1, '', 26, '2025-12-31 14:09:23', NULL, 'Evidence file downloaded by user', NULL),
(36, 1, '', 26, '2025-12-31 14:13:44', NULL, 'Evidence file downloaded by user', NULL),
(37, 1, '', 26, '2025-12-31 14:16:31', NULL, 'Evidence file downloaded by user', NULL),
(38, 1, '', 26, '2025-12-31 14:16:59', NULL, 'Evidence file downloaded by user', NULL),
(39, 1, 'analyzed', 26, '2025-12-31 14:17:23', NULL, 'File replaced: WhatsApp Image 2025-11-12 at 00.25.23 (1).jpeg → WhatsApp Image 2025-11-12 at 00.30.13.jpeg', NULL),
(40, 1, '', 26, '2025-12-31 14:17:30', NULL, 'Evidence file downloaded by user', NULL),
(41, 1, '', 26, '2025-12-31 14:24:04', NULL, 'Evidence file downloaded by user', NULL),
(42, 1, '', 26, '2025-12-31 14:24:11', NULL, 'Evidence file downloaded by user', NULL),
(43, 1, '', 26, '2025-12-31 14:24:42', NULL, 'Evidence file downloaded by user', NULL),
(44, 1, '', 26, '2025-12-31 14:27:13', NULL, 'Evidence file downloaded by user', NULL),
(45, 1, '', 26, '2025-12-31 14:29:29', NULL, 'Evidence file downloaded by user', NULL),
(46, 1, '', 26, '2025-12-31 14:32:31', NULL, 'Evidence file downloaded by user', NULL),
(47, 1, '', 26, '2025-12-31 16:59:51', NULL, 'Evidence file downloaded by user', NULL),
(48, 1, '', 26, '2025-12-31 17:00:25', NULL, 'Evidence file downloaded by user', NULL),
(49, 1, '', 26, '2025-12-31 17:07:16', NULL, 'Evidence file downloaded by user', NULL),
(50, 1, 'analyzed', 26, '2025-12-31 17:07:31', NULL, 'File replaced: WhatsApp Image 2025-11-12 at 00.30.13.jpeg → sidebar-logo-20251218120613.jpeg', NULL),
(51, 1, '', 26, '2025-12-31 17:09:19', NULL, 'Evidence file downloaded by user', NULL),
(52, 1, '', 26, '2025-12-31 17:09:25', NULL, 'Evidence file downloaded by user', NULL),
(53, 1, 'analyzed', 26, '2025-12-31 17:09:36', NULL, 'File replaced: sidebar-logo-20251218120613.jpeg → licensed-image.jpg', NULL),
(54, 1, '', 26, '2025-12-31 17:10:13', NULL, 'Evidence file downloaded by user', NULL),
(55, 1, '', 26, '2025-12-31 17:12:11', NULL, 'Evidence file downloaded by user', NULL),
(56, 1, '', 26, '2025-12-31 17:12:25', NULL, 'Evidence file downloaded by user', NULL),
(57, 1, 'analyzed', 26, '2025-12-31 17:12:42', NULL, 'File replaced: licensed-image.jpg → WhatsApp Image 2025-11-12 at 00.09.15 (1).jpeg', NULL),
(58, 1, '', 26, '2025-12-31 17:12:53', NULL, 'Evidence file downloaded by user', NULL),
(59, 1, '', 26, '2025-12-31 17:13:13', NULL, 'Evidence file downloaded by user', NULL),
(60, 1, '', 26, '2025-12-31 17:13:29', NULL, 'Evidence file downloaded by user', NULL),
(61, 1, '', 26, '2025-12-31 17:17:52', NULL, 'Evidence file downloaded by user', NULL),
(62, 1, '', 26, '2025-12-31 17:20:13', NULL, 'Evidence file downloaded by user', NULL),
(63, 1, '', 26, '2025-12-31 17:20:50', NULL, 'Evidence file downloaded by user', NULL),
(64, 1, '', 26, '2025-12-31 17:24:35', NULL, 'Evidence file downloaded by user', NULL),
(65, 1, '', 26, '2025-12-31 17:24:44', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(66, 2, '', 26, '2025-12-31 17:26:27', NULL, 'Evidence file downloaded by user', NULL),
(67, 1, '', 26, '2025-12-31 17:27:44', NULL, 'Evidence file downloaded by user', NULL),
(68, 1, '', 26, '2025-12-31 17:28:29', NULL, 'Evidence file downloaded by user', NULL),
(69, 1, '', 26, '2025-12-31 17:29:53', NULL, 'Evidence file downloaded by user', NULL),
(70, 1, '', 26, '2025-12-31 17:31:24', NULL, 'Evidence file downloaded by user', NULL),
(71, 1, '', 26, '2025-12-31 17:31:31', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(72, 1, '', 26, '2025-12-31 17:31:31', NULL, 'Evidence file downloaded by user', NULL),
(73, 1, '', 26, '2025-12-31 17:31:31', NULL, 'Downloaded old version (v2): sidebar-logo-20251218120613.jpeg', NULL),
(74, 1, '', 26, '2025-12-31 17:31:32', NULL, 'Downloaded old version (v1): WhatsApp Image 2025-11-12 at 00.30.13.jpeg', NULL),
(75, 1, '', 26, '2025-12-31 17:31:32', NULL, 'Evidence file downloaded by user', NULL),
(76, 1, '', 26, '2025-12-31 17:31:32', NULL, 'Evidence file downloaded by user', NULL),
(77, 1, '', 26, '2025-12-31 17:31:33', NULL, 'Evidence file downloaded by user', NULL),
(78, 1, '', 26, '2025-12-31 17:31:38', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(79, 1, '', 26, '2025-12-31 17:31:49', NULL, 'Evidence file downloaded by user', NULL),
(80, 1, '', 26, '2025-12-31 17:31:53', NULL, 'Evidence file downloaded by user', NULL),
(81, 1, '', 26, '2025-12-31 17:33:39', NULL, 'Evidence file downloaded by user', NULL),
(82, 1, '', 26, '2025-12-31 17:33:46', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(83, 1, '', 26, '2025-12-31 17:33:46', NULL, 'Evidence file downloaded by user', NULL),
(84, 1, '', 26, '2025-12-31 17:33:46', NULL, 'Downloaded old version (v2): sidebar-logo-20251218120613.jpeg', NULL),
(85, 1, '', 26, '2025-12-31 17:33:47', NULL, 'Downloaded old version (v1): WhatsApp Image 2025-11-12 at 00.30.13.jpeg', NULL),
(86, 1, '', 26, '2025-12-31 17:33:47', NULL, 'Evidence file downloaded by user', NULL),
(87, 1, '', 26, '2025-12-31 17:33:48', NULL, 'Evidence file downloaded by user', NULL),
(88, 1, '', 26, '2025-12-31 17:33:48', NULL, 'Evidence file downloaded by user', NULL),
(89, 1, '', 26, '2025-12-31 17:33:48', NULL, 'Evidence file downloaded by user', NULL),
(90, 1, '', 26, '2025-12-31 17:33:51', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(91, 1, '', 26, '2025-12-31 17:35:15', NULL, 'Evidence file downloaded by user', NULL),
(92, 1, '', 26, '2025-12-31 17:35:24', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(93, 1, '', 26, '2025-12-31 17:35:25', NULL, 'Evidence file downloaded by user', NULL),
(94, 1, '', 26, '2025-12-31 17:35:25', NULL, 'Downloaded old version (v2): sidebar-logo-20251218120613.jpeg', NULL),
(95, 1, '', 26, '2025-12-31 17:35:26', NULL, 'Downloaded old version (v1): WhatsApp Image 2025-11-12 at 00.30.13.jpeg', NULL),
(96, 1, '', 26, '2025-12-31 17:35:26', NULL, 'Evidence file downloaded by user', NULL),
(97, 1, '', 26, '2025-12-31 17:35:26', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(98, 1, '', 26, '2025-12-31 17:35:27', NULL, 'Evidence file downloaded by user', NULL),
(99, 1, '', 26, '2025-12-31 17:35:27', NULL, 'Evidence file downloaded by user', NULL),
(100, 1, '', 26, '2025-12-31 17:35:29', NULL, 'Evidence file downloaded by user', NULL),
(101, 1, '', 26, '2025-12-31 17:35:40', NULL, 'Evidence file downloaded by user', NULL),
(102, 1, '', 26, '2025-12-31 17:38:02', NULL, 'Evidence file downloaded by user', NULL),
(103, 1, '', 26, '2025-12-31 17:38:10', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(104, 1, '', 26, '2025-12-31 17:38:11', NULL, 'Evidence file downloaded by user', NULL),
(105, 1, '', 26, '2025-12-31 17:38:11', NULL, 'Downloaded old version (v2): sidebar-logo-20251218120613.jpeg', NULL),
(106, 1, '', 26, '2025-12-31 17:38:11', NULL, 'Downloaded old version (v1): WhatsApp Image 2025-11-12 at 00.30.13.jpeg', NULL),
(107, 1, '', 26, '2025-12-31 17:38:12', NULL, 'Evidence file downloaded by user', NULL),
(108, 1, '', 26, '2025-12-31 17:38:12', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(109, 1, '', 26, '2025-12-31 17:38:12', NULL, 'Evidence file downloaded by user', NULL),
(110, 1, '', 26, '2025-12-31 17:38:13', NULL, 'Evidence file downloaded by user', NULL),
(111, 1, '', 26, '2025-12-31 17:38:15', NULL, 'Evidence file downloaded by user', NULL),
(112, 1, '', 26, '2025-12-31 17:38:34', NULL, 'Evidence file downloaded by user', NULL),
(113, 1, '', 26, '2025-12-31 17:38:36', NULL, 'Evidence file downloaded by user', NULL),
(114, 1, '', 26, '2025-12-31 17:40:54', NULL, 'Evidence file downloaded by user', NULL),
(115, 1, '', 26, '2025-12-31 17:41:01', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(116, 1, '', 26, '2025-12-31 17:41:01', NULL, 'Evidence file downloaded by user', NULL),
(117, 1, '', 26, '2025-12-31 17:41:01', NULL, 'Downloaded old version (v2): sidebar-logo-20251218120613.jpeg', NULL),
(118, 1, '', 26, '2025-12-31 17:41:01', NULL, 'Downloaded old version (v1): WhatsApp Image 2025-11-12 at 00.30.13.jpeg', NULL),
(119, 1, '', 26, '2025-12-31 17:41:02', NULL, 'Evidence file downloaded by user', NULL),
(120, 1, '', 26, '2025-12-31 17:41:02', NULL, 'Evidence file downloaded by user', NULL),
(121, 1, '', 26, '2025-12-31 17:41:02', NULL, 'Evidence file downloaded by user', NULL),
(122, 1, '', 26, '2025-12-31 17:41:03', NULL, 'Evidence file downloaded by user', NULL),
(123, 1, '', 26, '2025-12-31 17:41:06', NULL, 'Downloaded old version (v3): licensed-image.jpg', NULL),
(124, 4, 'collected', 26, '2025-12-31 17:43:30', NULL, 'Evidence collected and uploaded to system', NULL),
(125, 1, '', 26, '2025-12-31 17:43:33', NULL, 'Evidence file downloaded by user', NULL),
(126, 4, '', 26, '2025-12-31 17:43:45', NULL, 'Evidence file downloaded by user', NULL),
(127, 1, '', 26, '2025-12-31 17:51:38', NULL, 'Evidence file downloaded by user', NULL),
(128, 4, '', 26, '2025-12-31 17:51:44', NULL, 'Evidence file downloaded by user', NULL),
(129, 4, '', 26, '2025-12-31 17:52:00', NULL, 'Evidence file downloaded by user', NULL),
(130, 1, '', 26, '2025-12-31 22:30:09', NULL, 'Evidence file downloaded by user', NULL),
(131, 1, '', 26, '2025-12-31 22:36:54', NULL, 'Evidence file downloaded by user', NULL),
(132, 1, '', 26, '2025-12-31 22:42:20', NULL, 'Evidence file downloaded by user', NULL),
(133, 1, '', 26, '2025-12-31 22:45:44', NULL, 'Evidence file downloaded by user', NULL),
(134, 1, '', 26, '2025-12-31 22:46:10', NULL, 'Evidence file downloaded by user', NULL),
(135, 5, 'collected', 26, '2025-12-31 22:49:43', NULL, 'Evidence collected and uploaded to system', NULL),
(136, 5, '', 26, '2025-12-31 22:49:46', NULL, 'Evidence file downloaded by user', NULL),
(137, 5, '', 26, '2025-12-31 22:49:49', NULL, 'Evidence file downloaded by user', NULL),
(138, 1, '', 26, '2025-12-31 22:50:54', NULL, 'Evidence file downloaded by user', NULL),
(139, 5, '', 26, '2025-12-31 22:50:55', NULL, 'Evidence file downloaded by user', NULL),
(140, 1, '', 26, '2025-12-31 22:55:15', NULL, 'Evidence file downloaded by user', NULL),
(141, 5, '', 26, '2025-12-31 22:55:15', NULL, 'Evidence file downloaded by user', NULL),
(142, 1, '', 26, '2025-12-31 22:56:49', NULL, 'Evidence file downloaded by user', NULL),
(143, 5, '', 26, '2025-12-31 22:56:49', NULL, 'Evidence file downloaded by user', NULL),
(144, 1, '', 26, '2025-12-31 22:57:15', NULL, 'Evidence file downloaded by user', NULL),
(145, 5, '', 26, '2025-12-31 22:57:15', NULL, 'Evidence file downloaded by user', NULL),
(146, 1, '', 26, '2025-12-31 22:58:30', NULL, 'Evidence file downloaded by user', NULL),
(147, 5, '', 26, '2025-12-31 22:58:30', NULL, 'Evidence file downloaded by user', NULL),
(148, 1, '', 26, '2025-12-31 22:59:54', NULL, 'Evidence file downloaded by user', NULL),
(149, 5, '', 26, '2025-12-31 22:59:54', NULL, 'Evidence file downloaded by user', NULL),
(150, 1, '', 26, '2025-12-31 23:00:07', NULL, 'Evidence file downloaded by user', NULL),
(151, 5, '', 26, '2025-12-31 23:00:08', NULL, 'Evidence file downloaded by user', NULL),
(152, 5, '', 26, '2025-12-31 23:01:04', NULL, 'Evidence file downloaded by user', NULL),
(153, 1, '', 26, '2025-12-31 23:11:24', NULL, 'Evidence file downloaded by user', NULL),
(154, 5, '', 26, '2025-12-31 23:11:25', NULL, 'Evidence file downloaded by user', NULL),
(155, 1, '', 26, '2025-12-31 23:16:25', NULL, 'Evidence file downloaded by user', NULL),
(156, 5, '', 26, '2025-12-31 23:16:26', NULL, 'Evidence file downloaded by user', NULL),
(157, 1, '', 26, '2025-12-31 23:19:57', NULL, 'Evidence file downloaded by user', NULL),
(158, 5, '', 26, '2025-12-31 23:19:58', NULL, 'Evidence file downloaded by user', NULL),
(159, 1, '', 26, '2025-12-31 23:22:10', NULL, 'Evidence file downloaded by user', NULL),
(160, 5, '', 26, '2025-12-31 23:22:11', NULL, 'Evidence file downloaded by user', NULL),
(161, 1, '', 26, '2025-12-31 23:25:19', NULL, 'Evidence file downloaded by user', NULL),
(162, 5, '', 26, '2025-12-31 23:25:20', NULL, 'Evidence file downloaded by user', NULL),
(163, 1, '', 26, '2025-12-31 23:26:11', NULL, 'Evidence file downloaded by user', NULL),
(164, 5, '', 26, '2025-12-31 23:26:12', NULL, 'Evidence file downloaded by user', NULL),
(165, 1, '', 26, '2025-12-31 23:27:15', NULL, 'Evidence file downloaded by user', NULL),
(166, 5, '', 26, '2025-12-31 23:27:15', NULL, 'Evidence file downloaded by user', NULL),
(167, 1, '', 26, '2025-12-31 23:29:03', NULL, 'Evidence file downloaded by user', NULL),
(168, 5, '', 26, '2025-12-31 23:29:04', NULL, 'Evidence file downloaded by user', NULL),
(169, 1, '', 26, '2025-12-31 23:31:08', NULL, 'Evidence file downloaded by user', NULL),
(170, 5, '', 26, '2025-12-31 23:31:09', NULL, 'Evidence file downloaded by user', NULL),
(171, 1, '', 26, '2025-12-31 23:33:33', NULL, 'Evidence file downloaded by user', NULL),
(172, 5, '', 26, '2025-12-31 23:33:33', NULL, 'Evidence file downloaded by user', NULL),
(173, 1, '', 26, '2025-12-31 23:35:05', NULL, 'Evidence file downloaded by user', NULL),
(174, 5, '', 26, '2025-12-31 23:35:05', NULL, 'Evidence file downloaded by user', NULL),
(175, 6, 'collected', 26, '2025-12-31 23:35:49', NULL, 'Evidence collected and uploaded to system', NULL),
(176, 1, '', 26, '2025-12-31 23:36:09', NULL, 'Evidence file downloaded by user', NULL),
(177, 5, '', 26, '2025-12-31 23:36:10', NULL, 'Evidence file downloaded by user', NULL),
(178, 1, '', 26, '2025-12-31 23:37:58', NULL, 'Evidence file downloaded by user', NULL),
(179, 5, '', 26, '2025-12-31 23:37:59', NULL, 'Evidence file downloaded by user', NULL),
(180, 7, 'collected', 26, '2025-12-31 23:38:16', NULL, 'Evidence collected and uploaded to system', NULL),
(181, 7, '', 26, '2025-12-31 23:38:27', NULL, 'Evidence file downloaded by user', NULL),
(182, 8, 'collected', 26, '2025-12-31 23:39:47', NULL, 'Evidence collected and uploaded to system', NULL),
(183, 1, '', 26, '2025-12-31 23:40:51', NULL, 'Evidence file downloaded by user', NULL),
(184, 5, '', 26, '2025-12-31 23:40:51', NULL, 'Evidence file downloaded by user', NULL),
(185, 1, '', 26, '2025-12-31 23:40:59', NULL, 'Evidence file downloaded by user', NULL),
(186, 5, '', 26, '2025-12-31 23:41:00', NULL, 'Evidence file downloaded by user', NULL),
(187, 1, '', 26, '2025-12-31 23:42:55', NULL, 'Evidence file downloaded by user', NULL),
(188, 5, '', 26, '2025-12-31 23:42:55', NULL, 'Evidence file downloaded by user', NULL),
(189, 7, '', 26, '2025-12-31 23:43:31', NULL, 'Evidence file downloaded by user', NULL),
(190, 9, 'collected', 26, '2025-12-31 23:44:11', NULL, 'Evidence collected and uploaded to system', NULL),
(191, 9, '', 26, '2025-12-31 23:44:15', NULL, 'Evidence file downloaded by user', NULL),
(192, 9, '', 26, '2025-12-31 23:44:18', NULL, 'Evidence file downloaded by user', NULL),
(193, 9, '', 26, '2025-12-31 23:44:21', NULL, 'Evidence file downloaded by user', NULL),
(194, 10, 'collected', 26, '2025-12-31 23:45:08', NULL, 'Evidence collected and uploaded to system', NULL),
(195, 1, '', 26, '2025-12-31 23:45:20', NULL, 'Evidence file downloaded by user', NULL),
(196, 5, '', 26, '2025-12-31 23:45:20', NULL, 'Evidence file downloaded by user', NULL),
(197, 9, '', 26, '2025-12-31 23:45:22', NULL, 'Evidence file downloaded by user', NULL),
(198, 10, '', 26, '2025-12-31 23:46:05', NULL, 'Evidence file downloaded by user', NULL),
(199, 1, '', 26, '2026-01-02 11:43:27', NULL, 'Evidence file downloaded by user', NULL),
(200, 5, '', 26, '2026-01-02 11:43:27', NULL, 'Evidence file downloaded by user', NULL),
(201, 9, '', 26, '2026-01-02 11:43:29', NULL, 'Evidence file downloaded by user', NULL),
(202, 10, '', 26, '2026-01-02 11:43:58', NULL, 'Evidence file downloaded by user', NULL),
(203, 1, '', 26, '2026-01-02 22:58:21', NULL, 'Evidence file downloaded by user', NULL),
(204, 5, '', 26, '2026-01-02 22:58:22', NULL, 'Evidence file downloaded by user', NULL),
(205, 9, '', 26, '2026-01-02 22:58:23', NULL, 'Evidence file downloaded by user', NULL),
(206, 1, '', 26, '2026-01-02 22:58:47', NULL, 'Evidence file downloaded by user', NULL),
(207, 5, '', 26, '2026-01-02 22:58:47', NULL, 'Evidence file downloaded by user', NULL),
(208, 9, '', 26, '2026-01-02 22:58:49', NULL, 'Evidence file downloaded by user', NULL),
(209, 1, '', 26, '2026-01-02 23:03:03', NULL, 'Evidence file downloaded by user', NULL),
(210, 5, '', 26, '2026-01-02 23:03:04', NULL, 'Evidence file downloaded by user', NULL),
(211, 9, '', 26, '2026-01-02 23:03:05', NULL, 'Evidence file downloaded by user', NULL),
(212, 1, '', 26, '2026-01-02 23:06:24', NULL, 'Evidence file downloaded by user', NULL),
(213, 5, '', 26, '2026-01-02 23:06:25', NULL, 'Evidence file downloaded by user', NULL),
(214, 9, '', 26, '2026-01-02 23:06:26', NULL, 'Evidence file downloaded by user', NULL),
(215, 1, '', 26, '2026-01-02 23:10:32', NULL, 'Evidence file downloaded by user', NULL),
(216, 5, '', 26, '2026-01-02 23:10:33', NULL, 'Evidence file downloaded by user', NULL),
(217, 9, '', 26, '2026-01-02 23:10:34', NULL, 'Evidence file downloaded by user', NULL),
(218, 1, '', 26, '2026-01-02 23:12:19', NULL, 'Evidence file downloaded by user', NULL),
(219, 5, '', 26, '2026-01-02 23:12:19', NULL, 'Evidence file downloaded by user', NULL),
(220, 9, '', 26, '2026-01-02 23:12:21', NULL, 'Evidence file downloaded by user', NULL),
(221, 1, '', 26, '2026-01-02 23:13:34', NULL, 'Evidence file downloaded by user', NULL),
(222, 5, '', 26, '2026-01-02 23:13:34', NULL, 'Evidence file downloaded by user', NULL),
(223, 9, '', 26, '2026-01-02 23:13:35', NULL, 'Evidence file downloaded by user', NULL),
(224, 1, '', 26, '2026-01-02 23:14:32', NULL, 'Evidence file downloaded by user', NULL),
(225, 5, '', 26, '2026-01-02 23:14:32', NULL, 'Evidence file downloaded by user', NULL),
(226, 9, '', 26, '2026-01-02 23:14:33', NULL, 'Evidence file downloaded by user', NULL),
(227, 1, '', 26, '2026-01-02 23:15:52', NULL, 'Evidence file downloaded by user', NULL),
(228, 5, '', 26, '2026-01-02 23:15:53', NULL, 'Evidence file downloaded by user', NULL),
(229, 9, '', 26, '2026-01-02 23:15:53', NULL, 'Evidence file downloaded by user', NULL),
(230, 1, '', 26, '2026-01-02 23:18:30', NULL, 'Evidence file downloaded by user', NULL),
(231, 5, '', 26, '2026-01-02 23:18:31', NULL, 'Evidence file downloaded by user', NULL),
(232, 9, '', 26, '2026-01-02 23:18:32', NULL, 'Evidence file downloaded by user', NULL),
(233, 1, '', 26, '2026-01-02 23:19:30', NULL, 'Evidence file downloaded by user', NULL),
(234, 5, '', 26, '2026-01-02 23:19:31', NULL, 'Evidence file downloaded by user', NULL),
(235, 9, '', 26, '2026-01-02 23:19:31', NULL, 'Evidence file downloaded by user', NULL),
(236, 1, '', 26, '2026-01-02 23:21:51', NULL, 'Evidence file downloaded by user', NULL),
(237, 5, '', 26, '2026-01-02 23:21:52', NULL, 'Evidence file downloaded by user', NULL),
(238, 9, '', 26, '2026-01-02 23:21:53', NULL, 'Evidence file downloaded by user', NULL),
(239, 1, '', 26, '2026-01-02 23:22:32', NULL, 'Evidence file downloaded by user', NULL),
(240, 5, '', 26, '2026-01-02 23:22:32', NULL, 'Evidence file downloaded by user', NULL),
(241, 9, '', 26, '2026-01-02 23:22:33', NULL, 'Evidence file downloaded by user', NULL),
(242, 1, '', 26, '2026-01-02 23:26:28', NULL, 'Evidence file downloaded by user', NULL),
(243, 5, '', 26, '2026-01-02 23:26:28', NULL, 'Evidence file downloaded by user', NULL),
(244, 9, '', 26, '2026-01-02 23:26:29', NULL, 'Evidence file downloaded by user', NULL),
(245, 1, '', 26, '2026-01-02 23:26:43', NULL, 'Evidence file downloaded by user', NULL),
(246, 5, '', 26, '2026-01-02 23:26:43', NULL, 'Evidence file downloaded by user', NULL),
(247, 9, '', 26, '2026-01-02 23:26:45', NULL, 'Evidence file downloaded by user', NULL),
(248, 1, '', 26, '2026-01-02 23:36:01', NULL, 'Evidence file downloaded by user', NULL),
(249, 5, '', 26, '2026-01-02 23:36:01', NULL, 'Evidence file downloaded by user', NULL),
(250, 9, '', 26, '2026-01-02 23:36:03', NULL, 'Evidence file downloaded by user', NULL),
(251, 1, '', 26, '2026-01-02 23:36:42', NULL, 'Evidence file downloaded by user', NULL),
(252, 5, '', 26, '2026-01-02 23:36:43', NULL, 'Evidence file downloaded by user', NULL),
(253, 9, '', 26, '2026-01-02 23:36:44', NULL, 'Evidence file downloaded by user', NULL),
(254, 1, '', 26, '2026-01-02 23:37:05', NULL, 'Evidence file downloaded by user', NULL),
(255, 5, '', 26, '2026-01-02 23:37:06', NULL, 'Evidence file downloaded by user', NULL),
(256, 9, '', 26, '2026-01-02 23:37:07', NULL, 'Evidence file downloaded by user', NULL),
(257, 1, '', 26, '2026-01-02 23:39:21', NULL, 'Evidence file downloaded by user', NULL),
(258, 5, '', 26, '2026-01-02 23:39:22', NULL, 'Evidence file downloaded by user', NULL),
(259, 9, '', 26, '2026-01-02 23:39:23', NULL, 'Evidence file downloaded by user', NULL),
(260, 1, '', 26, '2026-01-02 23:46:21', NULL, 'Evidence file downloaded by user', NULL),
(261, 5, '', 26, '2026-01-02 23:46:21', NULL, 'Evidence file downloaded by user', NULL),
(262, 9, '', 26, '2026-01-02 23:46:23', NULL, 'Evidence file downloaded by user', NULL),
(263, 1, '', 26, '2026-01-02 23:46:48', NULL, 'Evidence file downloaded by user', NULL),
(264, 5, '', 26, '2026-01-02 23:46:49', NULL, 'Evidence file downloaded by user', NULL),
(265, 9, '', 26, '2026-01-02 23:46:50', NULL, 'Evidence file downloaded by user', NULL),
(266, 1, '', 26, '2026-01-02 23:48:04', NULL, 'Evidence file downloaded by user', NULL),
(267, 1, '', 26, '2026-01-02 23:51:32', NULL, 'Evidence file downloaded by user', NULL),
(268, 5, '', 26, '2026-01-02 23:51:33', NULL, 'Evidence file downloaded by user', NULL),
(269, 9, '', 26, '2026-01-02 23:51:35', NULL, 'Evidence file downloaded by user', NULL),
(270, 1, '', 26, '2026-01-02 23:53:54', NULL, 'Evidence file downloaded by user', NULL),
(271, 5, '', 26, '2026-01-02 23:53:54', NULL, 'Evidence file downloaded by user', NULL),
(272, 9, '', 26, '2026-01-02 23:53:56', NULL, 'Evidence file downloaded by user', NULL),
(273, 1, '', 26, '2026-01-02 23:56:31', NULL, 'Evidence file downloaded by user', NULL),
(274, 5, '', 26, '2026-01-02 23:56:32', NULL, 'Evidence file downloaded by user', NULL),
(275, 9, '', 26, '2026-01-02 23:56:33', NULL, 'Evidence file downloaded by user', NULL),
(276, 1, '', 26, '2026-01-03 00:01:04', NULL, 'Evidence file downloaded by user', NULL),
(277, 5, '', 26, '2026-01-03 00:01:05', NULL, 'Evidence file downloaded by user', NULL),
(278, 9, '', 26, '2026-01-03 00:01:07', NULL, 'Evidence file downloaded by user', NULL),
(279, 1, '', 26, '2026-01-03 00:05:08', NULL, 'Evidence file downloaded by user', NULL),
(280, 5, '', 26, '2026-01-03 00:05:09', NULL, 'Evidence file downloaded by user', NULL),
(281, 9, '', 26, '2026-01-03 00:05:11', NULL, 'Evidence file downloaded by user', NULL),
(282, 1, '', 26, '2026-01-03 00:08:47', NULL, 'Evidence file downloaded by user', NULL),
(283, 5, '', 26, '2026-01-03 00:08:48', NULL, 'Evidence file downloaded by user', NULL),
(284, 9, '', 26, '2026-01-03 00:08:49', NULL, 'Evidence file downloaded by user', NULL),
(285, 1, '', 26, '2026-01-03 00:12:29', NULL, 'Evidence file downloaded by user', NULL),
(286, 5, '', 26, '2026-01-03 00:12:30', NULL, 'Evidence file downloaded by user', NULL),
(287, 9, '', 26, '2026-01-03 00:12:31', NULL, 'Evidence file downloaded by user', NULL),
(288, 1, '', 26, '2026-01-03 00:18:39', NULL, 'Evidence file downloaded by user', NULL),
(289, 5, '', 26, '2026-01-03 00:18:40', NULL, 'Evidence file downloaded by user', NULL),
(290, 9, '', 26, '2026-01-03 00:18:42', NULL, 'Evidence file downloaded by user', NULL),
(291, 1, '', 26, '2026-01-03 00:21:48', NULL, 'Evidence file downloaded by user', NULL),
(292, 5, '', 26, '2026-01-03 00:21:48', NULL, 'Evidence file downloaded by user', NULL),
(293, 9, '', 26, '2026-01-03 00:21:50', NULL, 'Evidence file downloaded by user', NULL),
(294, 1, '', 26, '2026-01-03 00:26:54', NULL, 'Evidence file downloaded by user', NULL),
(295, 5, '', 26, '2026-01-03 00:26:55', NULL, 'Evidence file downloaded by user', NULL),
(296, 9, '', 26, '2026-01-03 00:26:57', NULL, 'Evidence file downloaded by user', NULL),
(297, 1, '', 26, '2026-01-03 00:35:37', NULL, 'Evidence file downloaded by user', NULL),
(298, 5, '', 26, '2026-01-03 00:35:38', NULL, 'Evidence file downloaded by user', NULL),
(299, 9, '', 26, '2026-01-03 00:35:39', NULL, 'Evidence file downloaded by user', NULL),
(300, 1, '', 26, '2026-01-03 00:38:58', NULL, 'Evidence file downloaded by user', NULL),
(301, 5, '', 26, '2026-01-03 00:38:58', NULL, 'Evidence file downloaded by user', NULL),
(302, 9, '', 26, '2026-01-03 00:38:59', NULL, 'Evidence file downloaded by user', NULL),
(303, 1, '', 26, '2026-01-03 00:39:47', NULL, 'Evidence file downloaded by user', NULL),
(304, 5, '', 26, '2026-01-03 00:39:47', NULL, 'Evidence file downloaded by user', NULL),
(305, 9, '', 26, '2026-01-03 00:39:48', NULL, 'Evidence file downloaded by user', NULL),
(306, 1, '', 26, '2026-01-03 00:45:33', NULL, 'Evidence file downloaded by user', NULL),
(307, 5, '', 26, '2026-01-03 00:45:34', NULL, 'Evidence file downloaded by user', NULL),
(308, 9, '', 26, '2026-01-03 00:45:37', NULL, 'Evidence file downloaded by user', NULL),
(309, 1, '', 26, '2026-01-03 00:48:39', NULL, 'Evidence file downloaded by user', NULL),
(310, 5, '', 26, '2026-01-03 00:48:41', NULL, 'Evidence file downloaded by user', NULL),
(311, 9, '', 26, '2026-01-03 00:48:43', NULL, 'Evidence file downloaded by user', NULL),
(312, 1, '', 26, '2026-01-03 00:49:32', NULL, 'Evidence file downloaded by user', NULL),
(313, 5, '', 26, '2026-01-03 00:49:33', NULL, 'Evidence file downloaded by user', NULL),
(314, 9, '', 26, '2026-01-03 00:49:36', NULL, 'Evidence file downloaded by user', NULL),
(315, 1, '', 26, '2026-01-03 00:50:13', NULL, 'Evidence file downloaded by user', NULL),
(316, 5, '', 26, '2026-01-03 00:50:15', NULL, 'Evidence file downloaded by user', NULL),
(317, 9, '', 26, '2026-01-03 00:50:17', NULL, 'Evidence file downloaded by user', NULL),
(318, 1, '', 26, '2026-01-03 00:54:48', NULL, 'Evidence file downloaded by user', NULL),
(319, 5, '', 26, '2026-01-03 00:54:49', NULL, 'Evidence file downloaded by user', NULL),
(320, 9, '', 26, '2026-01-03 00:54:51', NULL, 'Evidence file downloaded by user', NULL),
(321, 1, '', 26, '2026-01-03 01:04:14', NULL, 'Evidence file downloaded by user', NULL),
(322, 5, '', 26, '2026-01-03 01:04:16', NULL, 'Evidence file downloaded by user', NULL),
(323, 9, '', 26, '2026-01-03 01:04:18', NULL, 'Evidence file downloaded by user', NULL),
(324, 1, '', 26, '2026-01-03 01:05:25', NULL, 'Evidence file downloaded by user', NULL),
(325, 5, '', 26, '2026-01-03 01:05:27', NULL, 'Evidence file downloaded by user', NULL),
(326, 9, '', 26, '2026-01-03 01:05:29', NULL, 'Evidence file downloaded by user', NULL),
(327, 1, '', 26, '2026-01-03 01:07:18', NULL, 'Evidence file downloaded by user', NULL),
(328, 5, '', 26, '2026-01-03 01:07:19', NULL, 'Evidence file downloaded by user', NULL),
(329, 9, '', 26, '2026-01-03 01:07:21', NULL, 'Evidence file downloaded by user', NULL),
(330, 1, '', 26, '2026-01-03 01:08:30', NULL, 'Evidence file downloaded by user', NULL),
(331, 5, '', 26, '2026-01-03 01:08:30', NULL, 'Evidence file downloaded by user', NULL),
(332, 9, '', 26, '2026-01-03 01:08:32', NULL, 'Evidence file downloaded by user', NULL),
(333, 1, '', 26, '2026-01-03 01:12:17', NULL, 'Evidence file downloaded by user', NULL),
(334, 5, '', 26, '2026-01-03 01:12:18', NULL, 'Evidence file downloaded by user', NULL),
(335, 9, '', 26, '2026-01-03 01:12:21', NULL, 'Evidence file downloaded by user', NULL),
(336, 1, '', 26, '2026-01-03 01:14:38', NULL, 'Evidence file downloaded by user', NULL),
(337, 5, '', 26, '2026-01-03 01:14:39', NULL, 'Evidence file downloaded by user', NULL),
(338, 9, '', 26, '2026-01-03 01:14:41', NULL, 'Evidence file downloaded by user', NULL),
(339, 1, '', 26, '2026-01-03 01:16:12', NULL, 'Evidence file downloaded by user', NULL),
(340, 5, '', 26, '2026-01-03 01:16:13', NULL, 'Evidence file downloaded by user', NULL),
(341, 9, '', 26, '2026-01-03 01:16:15', NULL, 'Evidence file downloaded by user', NULL),
(342, 1, '', 26, '2026-01-03 01:19:00', NULL, 'Evidence file downloaded by user', NULL),
(343, 5, '', 26, '2026-01-03 01:19:01', NULL, 'Evidence file downloaded by user', NULL),
(344, 9, '', 26, '2026-01-03 01:19:03', NULL, 'Evidence file downloaded by user', NULL),
(345, 1, '', 26, '2026-01-03 11:58:13', NULL, 'Evidence file downloaded by user', NULL),
(346, 5, '', 26, '2026-01-03 11:58:13', NULL, 'Evidence file downloaded by user', NULL),
(347, 9, '', 26, '2026-01-03 11:58:14', NULL, 'Evidence file downloaded by user', NULL),
(348, 1, '', 26, '2026-01-04 12:59:49', NULL, 'Evidence file downloaded by user', NULL),
(349, 5, '', 26, '2026-01-04 12:59:49', NULL, 'Evidence file downloaded by user', NULL),
(350, 9, '', 26, '2026-01-04 12:59:51', NULL, 'Evidence file downloaded by user', NULL),
(351, 1, '', 26, '2026-01-04 13:01:29', NULL, 'Evidence file downloaded by user', NULL),
(352, 5, '', 26, '2026-01-04 13:01:29', NULL, 'Evidence file downloaded by user', NULL),
(353, 9, '', 26, '2026-01-04 13:01:31', NULL, 'Evidence file downloaded by user', NULL),
(354, 1, '', 26, '2026-01-05 00:00:37', NULL, 'Evidence file downloaded by user', NULL),
(355, 5, '', 26, '2026-01-05 00:00:38', NULL, 'Evidence file downloaded by user', NULL),
(356, 9, '', 26, '2026-01-05 00:00:39', NULL, 'Evidence file downloaded by user', NULL),
(357, 1, '', 26, '2026-01-05 00:05:43', NULL, 'Evidence file downloaded by user', NULL),
(358, 5, '', 26, '2026-01-05 00:05:44', NULL, 'Evidence file downloaded by user', NULL),
(359, 9, '', 26, '2026-01-05 00:05:45', NULL, 'Evidence file downloaded by user', NULL),
(360, 1, '', 26, '2026-01-05 00:16:27', NULL, 'Evidence file downloaded by user', NULL),
(361, 5, '', 26, '2026-01-05 00:16:28', NULL, 'Evidence file downloaded by user', NULL),
(362, 9, '', 26, '2026-01-05 00:16:29', NULL, 'Evidence file downloaded by user', NULL),
(363, 1, '', 26, '2026-01-05 00:17:04', NULL, 'Evidence file downloaded by user', NULL),
(364, 5, '', 26, '2026-01-05 00:17:04', NULL, 'Evidence file downloaded by user', NULL),
(365, 9, '', 26, '2026-01-05 00:17:06', NULL, 'Evidence file downloaded by user', NULL),
(366, 1, '', 26, '2026-01-05 00:17:33', NULL, 'Evidence file downloaded by user', NULL),
(367, 5, '', 26, '2026-01-05 00:17:33', NULL, 'Evidence file downloaded by user', NULL),
(368, 9, '', 26, '2026-01-05 00:17:35', NULL, 'Evidence file downloaded by user', NULL),
(369, 1, '', 26, '2026-01-05 00:18:40', NULL, 'Evidence file downloaded by user', NULL),
(370, 5, '', 26, '2026-01-05 00:18:41', NULL, 'Evidence file downloaded by user', NULL),
(371, 9, '', 26, '2026-01-05 00:18:42', NULL, 'Evidence file downloaded by user', NULL),
(372, 1, '', 26, '2026-01-05 00:20:47', NULL, 'Evidence file downloaded by user', NULL),
(373, 5, '', 26, '2026-01-05 00:20:48', NULL, 'Evidence file downloaded by user', NULL),
(374, 9, '', 26, '2026-01-05 00:20:49', NULL, 'Evidence file downloaded by user', NULL),
(375, 1, '', 26, '2026-01-05 00:26:11', NULL, 'Evidence file downloaded by user', NULL),
(376, 5, '', 26, '2026-01-05 00:26:12', NULL, 'Evidence file downloaded by user', NULL),
(377, 9, '', 26, '2026-01-05 00:26:13', NULL, 'Evidence file downloaded by user', NULL),
(378, 1, '', 26, '2026-01-05 00:34:03', NULL, 'Evidence file downloaded by user', NULL),
(379, 5, '', 26, '2026-01-05 00:34:03', NULL, 'Evidence file downloaded by user', NULL),
(380, 9, '', 26, '2026-01-05 00:34:04', NULL, 'Evidence file downloaded by user', NULL),
(381, 1, '', 26, '2026-01-05 00:34:49', NULL, 'Evidence file downloaded by user', NULL),
(382, 5, '', 26, '2026-01-05 00:34:49', NULL, 'Evidence file downloaded by user', NULL),
(383, 9, '', 26, '2026-01-05 00:34:51', NULL, 'Evidence file downloaded by user', NULL),
(384, 1, '', 26, '2026-01-05 00:37:29', NULL, 'Evidence file downloaded by user', NULL),
(385, 5, '', 26, '2026-01-05 00:37:30', NULL, 'Evidence file downloaded by user', NULL),
(386, 9, '', 26, '2026-01-05 00:37:31', NULL, 'Evidence file downloaded by user', NULL),
(387, 1, '', 26, '2026-01-05 00:40:55', NULL, 'Evidence file downloaded by user', NULL),
(388, 5, '', 26, '2026-01-05 00:40:55', NULL, 'Evidence file downloaded by user', NULL),
(389, 9, '', 26, '2026-01-05 00:41:10', NULL, 'Evidence file downloaded by user', NULL),
(390, 1, '', 26, '2026-01-05 00:45:40', NULL, 'Evidence file downloaded by user', NULL),
(391, 5, '', 26, '2026-01-05 00:45:41', NULL, 'Evidence file downloaded by user', NULL),
(392, 9, '', 26, '2026-01-05 00:45:43', NULL, 'Evidence file downloaded by user', NULL),
(393, 1, '', 26, '2026-01-05 00:51:22', NULL, 'Evidence file downloaded by user', NULL),
(394, 5, '', 26, '2026-01-05 00:51:23', NULL, 'Evidence file downloaded by user', NULL),
(395, 9, '', 26, '2026-01-05 00:51:24', NULL, 'Evidence file downloaded by user', NULL),
(396, 1, '', 26, '2026-01-05 00:55:18', NULL, 'Evidence file downloaded by user', NULL),
(397, 5, '', 26, '2026-01-05 00:55:18', NULL, 'Evidence file downloaded by user', NULL),
(398, 9, '', 26, '2026-01-05 00:55:19', NULL, 'Evidence file downloaded by user', NULL),
(399, 1, '', 26, '2026-01-05 00:55:32', NULL, 'Evidence file downloaded by user', NULL),
(400, 5, '', 26, '2026-01-05 00:55:33', NULL, 'Evidence file downloaded by user', NULL),
(401, 9, '', 26, '2026-01-05 00:55:34', NULL, 'Evidence file downloaded by user', NULL),
(402, 1, '', 26, '2026-01-05 00:57:58', NULL, 'Evidence file downloaded by user', NULL),
(403, 5, '', 26, '2026-01-05 00:57:58', NULL, 'Evidence file downloaded by user', NULL),
(404, 9, '', 26, '2026-01-05 00:58:00', NULL, 'Evidence file downloaded by user', NULL),
(405, 1, '', 26, '2026-01-05 00:59:37', NULL, 'Evidence file downloaded by user', NULL),
(406, 5, '', 26, '2026-01-05 00:59:37', NULL, 'Evidence file downloaded by user', NULL),
(407, 9, '', 26, '2026-01-05 00:59:39', NULL, 'Evidence file downloaded by user', NULL),
(408, 1, '', 26, '2026-01-05 01:13:51', NULL, 'Evidence file downloaded by user', NULL),
(409, 5, '', 26, '2026-01-05 01:13:52', NULL, 'Evidence file downloaded by user', NULL),
(410, 9, '', 26, '2026-01-05 01:13:53', NULL, 'Evidence file downloaded by user', NULL),
(411, 1, '', 26, '2026-01-05 01:16:15', NULL, 'Evidence file downloaded by user', NULL),
(412, 5, '', 26, '2026-01-05 01:16:15', NULL, 'Evidence file downloaded by user', NULL),
(413, 9, '', 26, '2026-01-05 01:16:16', NULL, 'Evidence file downloaded by user', NULL),
(414, 1, '', 26, '2026-01-05 01:20:13', NULL, 'Evidence file downloaded by user', NULL),
(415, 5, '', 26, '2026-01-05 01:20:13', NULL, 'Evidence file downloaded by user', NULL),
(416, 9, '', 26, '2026-01-05 01:20:13', NULL, 'Evidence file downloaded by user', NULL),
(417, 1, '', 26, '2026-01-05 01:23:48', NULL, 'Evidence file downloaded by user', NULL),
(418, 5, '', 26, '2026-01-05 01:23:48', NULL, 'Evidence file downloaded by user', NULL),
(419, 9, '', 26, '2026-01-05 01:23:50', NULL, 'Evidence file downloaded by user', NULL),
(420, 1, '', 26, '2026-01-05 01:29:57', NULL, 'Evidence file downloaded by user', NULL),
(421, 5, '', 26, '2026-01-05 01:29:58', NULL, 'Evidence file downloaded by user', NULL),
(422, 9, '', 26, '2026-01-05 01:30:00', NULL, 'Evidence file downloaded by user', NULL),
(423, 1, '', 26, '2026-01-05 01:36:42', NULL, 'Evidence file downloaded by user', NULL),
(424, 5, '', 26, '2026-01-05 01:36:42', NULL, 'Evidence file downloaded by user', NULL),
(425, 9, '', 26, '2026-01-05 01:36:43', NULL, 'Evidence file downloaded by user', NULL),
(426, 1, '', 26, '2026-01-05 01:46:39', NULL, 'Evidence file downloaded by user', NULL),
(427, 5, '', 26, '2026-01-05 01:46:40', NULL, 'Evidence file downloaded by user', NULL),
(428, 9, '', 26, '2026-01-05 01:46:42', NULL, 'Evidence file downloaded by user', NULL),
(429, 1, '', 26, '2026-01-05 01:47:00', NULL, 'Evidence file downloaded by user', NULL),
(430, 5, '', 26, '2026-01-05 01:47:01', NULL, 'Evidence file downloaded by user', NULL),
(431, 9, '', 26, '2026-01-05 01:47:03', NULL, 'Evidence file downloaded by user', NULL),
(432, 1, '', 26, '2026-01-05 01:49:14', NULL, 'Evidence file downloaded by user', NULL),
(433, 5, '', 26, '2026-01-05 01:49:14', NULL, 'Evidence file downloaded by user', NULL),
(434, 9, '', 26, '2026-01-05 01:49:16', NULL, 'Evidence file downloaded by user', NULL),
(435, 1, '', 26, '2026-01-05 01:49:57', NULL, 'Evidence file downloaded by user', NULL),
(436, 5, '', 26, '2026-01-05 01:49:58', NULL, 'Evidence file downloaded by user', NULL),
(437, 9, '', 26, '2026-01-05 01:49:59', NULL, 'Evidence file downloaded by user', NULL),
(438, 1, '', 26, '2026-01-05 01:52:28', NULL, 'Evidence file downloaded by user', NULL),
(439, 5, '', 26, '2026-01-05 01:52:28', NULL, 'Evidence file downloaded by user', NULL),
(440, 9, '', 26, '2026-01-05 01:52:30', NULL, 'Evidence file downloaded by user', NULL),
(441, 1, '', 26, '2026-01-05 01:53:56', NULL, 'Evidence file downloaded by user', NULL),
(442, 5, '', 26, '2026-01-05 01:53:56', NULL, 'Evidence file downloaded by user', NULL),
(443, 9, '', 26, '2026-01-05 01:53:57', NULL, 'Evidence file downloaded by user', NULL),
(444, 1, '', 26, '2026-01-07 12:19:34', NULL, 'Evidence file downloaded by user', NULL),
(445, 5, '', 26, '2026-01-07 12:19:34', NULL, 'Evidence file downloaded by user', NULL),
(446, 9, '', 26, '2026-01-07 12:19:36', NULL, 'Evidence file downloaded by user', NULL),
(447, 1, '', 26, '2026-01-07 12:37:34', NULL, 'Evidence file downloaded by user', NULL),
(448, 5, '', 26, '2026-01-07 12:37:35', NULL, 'Evidence file downloaded by user', NULL),
(449, 9, '', 26, '2026-01-07 12:37:37', NULL, 'Evidence file downloaded by user', NULL),
(450, 1, '', 26, '2026-01-07 12:40:02', NULL, 'Evidence file downloaded by user', NULL),
(451, 5, '', 26, '2026-01-07 12:40:03', NULL, 'Evidence file downloaded by user', NULL),
(452, 9, '', 26, '2026-01-07 12:40:04', NULL, 'Evidence file downloaded by user', NULL),
(453, 1, '', 26, '2026-01-07 12:44:33', NULL, 'Evidence file downloaded by user', NULL),
(454, 5, '', 26, '2026-01-07 12:44:34', NULL, 'Evidence file downloaded by user', NULL),
(455, 9, '', 26, '2026-01-07 12:44:36', NULL, 'Evidence file downloaded by user', NULL),
(456, 1, '', 26, '2026-01-07 12:49:43', NULL, 'Evidence file downloaded by user', NULL),
(457, 5, '', 26, '2026-01-07 12:49:43', NULL, 'Evidence file downloaded by user', NULL),
(458, 9, '', 26, '2026-01-07 12:49:46', NULL, 'Evidence file downloaded by user', NULL),
(459, 1, '', 26, '2026-01-07 12:50:55', NULL, 'Evidence file downloaded by user', NULL),
(460, 5, '', 26, '2026-01-07 12:50:56', NULL, 'Evidence file downloaded by user', NULL),
(461, 9, '', 26, '2026-01-07 12:50:58', NULL, 'Evidence file downloaded by user', NULL),
(462, 1, '', 26, '2026-01-07 12:52:56', NULL, 'Evidence file downloaded by user', NULL),
(463, 5, '', 26, '2026-01-07 12:52:57', NULL, 'Evidence file downloaded by user', NULL),
(464, 9, '', 26, '2026-01-07 12:52:58', NULL, 'Evidence file downloaded by user', NULL),
(465, 1, '', 26, '2026-01-07 12:54:01', NULL, 'Evidence file downloaded by user', NULL),
(466, 5, '', 26, '2026-01-07 12:54:02', NULL, 'Evidence file downloaded by user', NULL),
(467, 9, '', 26, '2026-01-07 12:54:04', NULL, 'Evidence file downloaded by user', NULL),
(468, 1, '', 26, '2026-01-07 12:56:02', NULL, 'Evidence file downloaded by user', NULL),
(469, 5, '', 26, '2026-01-07 12:56:03', NULL, 'Evidence file downloaded by user', NULL),
(470, 9, '', 26, '2026-01-07 12:56:04', NULL, 'Evidence file downloaded by user', NULL),
(471, 1, '', 26, '2026-01-07 13:08:42', NULL, 'Evidence file downloaded by user', NULL),
(472, 5, '', 26, '2026-01-07 13:08:43', NULL, 'Evidence file downloaded by user', NULL),
(473, 9, '', 26, '2026-01-07 13:08:45', NULL, 'Evidence file downloaded by user', NULL),
(474, 1, '', 26, '2026-01-07 13:13:35', NULL, 'Evidence file downloaded by user', NULL),
(475, 5, '', 26, '2026-01-07 13:13:36', NULL, 'Evidence file downloaded by user', NULL),
(476, 9, '', 26, '2026-01-07 13:13:38', NULL, 'Evidence file downloaded by user', NULL),
(477, 1, '', 26, '2026-01-07 13:16:42', NULL, 'Evidence file downloaded by user', NULL),
(478, 5, '', 26, '2026-01-07 13:16:43', NULL, 'Evidence file downloaded by user', NULL),
(479, 4, '', 26, '2026-01-07 13:16:44', NULL, 'Evidence file downloaded by user', NULL),
(480, 3, '', 26, '2026-01-07 13:16:44', NULL, 'Evidence file downloaded by user', NULL),
(481, 2, '', 26, '2026-01-07 13:16:45', NULL, 'Evidence file downloaded by user', NULL),
(482, 1, '', 26, '2026-01-07 13:16:45', NULL, 'Evidence file downloaded by user', NULL),
(483, 5, '', 26, '2026-01-07 13:16:45', NULL, 'Evidence file downloaded by user', NULL),
(484, 8, '', 26, '2026-01-07 13:16:46', NULL, 'Evidence file downloaded by user', NULL),
(485, 7, '', 26, '2026-01-07 13:16:46', NULL, 'Evidence file downloaded by user', NULL),
(486, 6, '', 26, '2026-01-07 13:16:46', NULL, 'Evidence file downloaded by user', NULL),
(487, 10, '', 26, '2026-01-07 13:16:47', NULL, 'Evidence file downloaded by user', NULL),
(488, 9, '', 26, '2026-01-07 13:16:47', NULL, 'Evidence file downloaded by user', NULL),
(489, 4, '', 26, '2026-01-07 13:16:48', NULL, 'Evidence file downloaded by user', NULL),
(490, 3, '', 26, '2026-01-07 13:16:48', NULL, 'Evidence file downloaded by user', NULL),
(491, 2, '', 26, '2026-01-07 13:16:48', NULL, 'Evidence file downloaded by user', NULL),
(492, 1, '', 26, '2026-01-07 13:16:49', NULL, 'Evidence file downloaded by user', NULL),
(493, 5, '', 26, '2026-01-07 13:16:49', NULL, 'Evidence file downloaded by user', NULL),
(494, 8, '', 26, '2026-01-07 13:16:49', NULL, 'Evidence file downloaded by user', NULL),
(495, 7, '', 26, '2026-01-07 13:16:50', NULL, 'Evidence file downloaded by user', NULL),
(496, 6, '', 26, '2026-01-07 13:16:50', NULL, 'Evidence file downloaded by user', NULL),
(497, 10, '', 26, '2026-01-07 13:16:50', NULL, 'Evidence file downloaded by user', NULL),
(498, 9, '', 26, '2026-01-07 13:16:50', NULL, 'Evidence file downloaded by user', NULL),
(499, 9, '', 26, '2026-01-07 13:16:51', NULL, 'Evidence file downloaded by user', NULL),
(500, 4, '', 26, '2026-01-07 13:17:04', NULL, 'Evidence file downloaded by user', NULL),
(501, 3, '', 26, '2026-01-07 13:17:04', NULL, 'Evidence file downloaded by user', NULL),
(502, 2, '', 26, '2026-01-07 13:17:05', NULL, 'Evidence file downloaded by user', NULL),
(503, 1, '', 26, '2026-01-07 13:17:05', NULL, 'Evidence file downloaded by user', NULL),
(504, 5, '', 26, '2026-01-07 13:17:05', NULL, 'Evidence file downloaded by user', NULL),
(505, 8, '', 26, '2026-01-07 13:17:06', NULL, 'Evidence file downloaded by user', NULL),
(506, 7, '', 26, '2026-01-07 13:17:06', NULL, 'Evidence file downloaded by user', NULL),
(507, 6, '', 26, '2026-01-07 13:17:06', NULL, 'Evidence file downloaded by user', NULL),
(508, 10, '', 26, '2026-01-07 13:17:07', NULL, 'Evidence file downloaded by user', NULL),
(509, 9, '', 26, '2026-01-07 13:17:07', NULL, 'Evidence file downloaded by user', NULL),
(510, 4, '', 26, '2026-01-07 13:17:07', NULL, 'Evidence file downloaded by user', NULL),
(511, 3, '', 26, '2026-01-07 13:17:07', NULL, 'Evidence file downloaded by user', NULL),
(512, 2, '', 26, '2026-01-07 13:17:08', NULL, 'Evidence file downloaded by user', NULL),
(513, 1, '', 26, '2026-01-07 13:17:08', NULL, 'Evidence file downloaded by user', NULL),
(514, 5, '', 26, '2026-01-07 13:17:08', NULL, 'Evidence file downloaded by user', NULL),
(515, 8, '', 26, '2026-01-07 13:17:09', NULL, 'Evidence file downloaded by user', NULL),
(516, 7, '', 26, '2026-01-07 13:17:09', NULL, 'Evidence file downloaded by user', NULL),
(517, 6, '', 26, '2026-01-07 13:17:09', NULL, 'Evidence file downloaded by user', NULL),
(518, 10, '', 26, '2026-01-07 13:17:10', NULL, 'Evidence file downloaded by user', NULL),
(519, 9, '', 26, '2026-01-07 13:17:10', NULL, 'Evidence file downloaded by user', NULL),
(520, 1, '', 26, '2026-01-07 13:22:01', NULL, 'Evidence file downloaded by user', NULL),
(521, 5, '', 26, '2026-01-07 13:22:02', NULL, 'Evidence file downloaded by user', NULL),
(522, 4, '', 26, '2026-01-07 13:22:02', NULL, 'Evidence file downloaded by user', NULL),
(523, 3, '', 26, '2026-01-07 13:22:03', NULL, 'Evidence file downloaded by user', NULL),
(524, 2, '', 26, '2026-01-07 13:22:03', NULL, 'Evidence file downloaded by user', NULL),
(525, 1, '', 26, '2026-01-07 13:22:03', NULL, 'Evidence file downloaded by user', NULL),
(526, 8, '', 26, '2026-01-07 13:22:03', NULL, 'Evidence file downloaded by user', NULL),
(527, 7, '', 26, '2026-01-07 13:22:04', NULL, 'Evidence file downloaded by user', NULL),
(528, 6, '', 26, '2026-01-07 13:22:04', NULL, 'Evidence file downloaded by user', NULL),
(529, 10, '', 26, '2026-01-07 13:22:04', NULL, 'Evidence file downloaded by user', NULL),
(530, 9, '', 26, '2026-01-07 13:22:05', NULL, 'Evidence file downloaded by user', NULL),
(531, 5, '', 26, '2026-01-07 13:22:05', NULL, 'Evidence file downloaded by user', NULL),
(532, 4, '', 26, '2026-01-07 13:22:06', NULL, 'Evidence file downloaded by user', NULL),
(533, 3, '', 26, '2026-01-07 13:22:06', NULL, 'Evidence file downloaded by user', NULL),
(534, 2, '', 26, '2026-01-07 13:22:06', NULL, 'Evidence file downloaded by user', NULL),
(535, 1, '', 26, '2026-01-07 13:22:07', NULL, 'Evidence file downloaded by user', NULL),
(536, 8, '', 26, '2026-01-07 13:22:07', NULL, 'Evidence file downloaded by user', NULL),
(537, 7, '', 26, '2026-01-07 13:22:07', NULL, 'Evidence file downloaded by user', NULL),
(538, 6, '', 26, '2026-01-07 13:22:08', NULL, 'Evidence file downloaded by user', NULL),
(539, 10, '', 26, '2026-01-07 13:22:08', NULL, 'Evidence file downloaded by user', NULL),
(540, 9, '', 26, '2026-01-07 13:22:08', NULL, 'Evidence file downloaded by user', NULL),
(541, 5, '', 26, '2026-01-07 13:22:09', NULL, 'Evidence file downloaded by user', NULL),
(542, 9, '', 26, '2026-01-07 13:22:09', NULL, 'Evidence file downloaded by user', NULL),
(543, 1, '', 26, '2026-01-07 13:25:13', NULL, 'Evidence file downloaded by user', NULL),
(544, 5, '', 26, '2026-01-07 13:25:14', NULL, 'Evidence file downloaded by user', NULL),
(545, 4, '', 26, '2026-01-07 13:25:15', NULL, 'Evidence file downloaded by user', NULL),
(546, 3, '', 26, '2026-01-07 13:25:15', NULL, 'Evidence file downloaded by user', NULL),
(547, 2, '', 26, '2026-01-07 13:25:15', NULL, 'Evidence file downloaded by user', NULL),
(548, 1, '', 26, '2026-01-07 13:25:16', NULL, 'Evidence file downloaded by user', NULL),
(549, 8, '', 26, '2026-01-07 13:25:16', NULL, 'Evidence file downloaded by user', NULL),
(550, 7, '', 26, '2026-01-07 13:25:16', NULL, 'Evidence file downloaded by user', NULL),
(551, 6, '', 26, '2026-01-07 13:25:17', NULL, 'Evidence file downloaded by user', NULL),
(552, 10, '', 26, '2026-01-07 13:25:17', NULL, 'Evidence file downloaded by user', NULL),
(553, 9, '', 26, '2026-01-07 13:25:17', NULL, 'Evidence file downloaded by user', NULL),
(554, 5, '', 26, '2026-01-07 13:25:18', NULL, 'Evidence file downloaded by user', NULL),
(555, 4, '', 26, '2026-01-07 13:25:18', NULL, 'Evidence file downloaded by user', NULL),
(556, 3, '', 26, '2026-01-07 13:25:18', NULL, 'Evidence file downloaded by user', NULL),
(557, 2, '', 26, '2026-01-07 13:25:19', NULL, 'Evidence file downloaded by user', NULL),
(558, 1, '', 26, '2026-01-07 13:25:19', NULL, 'Evidence file downloaded by user', NULL),
(559, 8, '', 26, '2026-01-07 13:25:19', NULL, 'Evidence file downloaded by user', NULL),
(560, 7, '', 26, '2026-01-07 13:25:20', NULL, 'Evidence file downloaded by user', NULL),
(561, 6, '', 26, '2026-01-07 13:25:20', NULL, 'Evidence file downloaded by user', NULL),
(562, 10, '', 26, '2026-01-07 13:25:20', NULL, 'Evidence file downloaded by user', NULL),
(563, 9, '', 26, '2026-01-07 13:25:21', NULL, 'Evidence file downloaded by user', NULL);
INSERT INTO `evidence_custody_log` (`id`, `evidence_id`, `action`, `performed_by`, `performed_at`, `location`, `notes`, `witness_id`) VALUES
(564, 5, '', 26, '2026-01-07 13:25:21', NULL, 'Evidence file downloaded by user', NULL),
(565, 9, '', 26, '2026-01-07 13:25:22', NULL, 'Evidence file downloaded by user', NULL),
(566, 1, '', 26, '2026-01-07 13:28:17', NULL, 'Evidence file downloaded by user', NULL),
(567, 5, '', 26, '2026-01-07 13:28:17', NULL, 'Evidence file downloaded by user', NULL),
(568, 4, '', 26, '2026-01-07 13:28:18', NULL, 'Evidence file downloaded by user', NULL),
(569, 3, '', 26, '2026-01-07 13:28:19', NULL, 'Evidence file downloaded by user', NULL),
(570, 2, '', 26, '2026-01-07 13:28:19', NULL, 'Evidence file downloaded by user', NULL),
(571, 1, '', 26, '2026-01-07 13:28:19', NULL, 'Evidence file downloaded by user', NULL),
(572, 5, '', 26, '2026-01-07 13:28:20', NULL, 'Evidence file downloaded by user', NULL),
(573, 8, '', 26, '2026-01-07 13:28:20', NULL, 'Evidence file downloaded by user', NULL),
(574, 7, '', 26, '2026-01-07 13:28:20', NULL, 'Evidence file downloaded by user', NULL),
(575, 6, '', 26, '2026-01-07 13:28:21', NULL, 'Evidence file downloaded by user', NULL),
(576, 10, '', 26, '2026-01-07 13:28:21', NULL, 'Evidence file downloaded by user', NULL),
(577, 9, '', 26, '2026-01-07 13:28:21', NULL, 'Evidence file downloaded by user', NULL),
(578, 4, '', 26, '2026-01-07 13:28:22', NULL, 'Evidence file downloaded by user', NULL),
(579, 3, '', 26, '2026-01-07 13:28:22', NULL, 'Evidence file downloaded by user', NULL),
(580, 2, '', 26, '2026-01-07 13:28:22', NULL, 'Evidence file downloaded by user', NULL),
(581, 1, '', 26, '2026-01-07 13:28:23', NULL, 'Evidence file downloaded by user', NULL),
(582, 5, '', 26, '2026-01-07 13:28:23', NULL, 'Evidence file downloaded by user', NULL),
(583, 8, '', 26, '2026-01-07 13:28:24', NULL, 'Evidence file downloaded by user', NULL),
(584, 7, '', 26, '2026-01-07 13:28:24', NULL, 'Evidence file downloaded by user', NULL),
(585, 6, '', 26, '2026-01-07 13:28:24', NULL, 'Evidence file downloaded by user', NULL),
(586, 10, '', 26, '2026-01-07 13:28:25', NULL, 'Evidence file downloaded by user', NULL),
(587, 9, '', 26, '2026-01-07 13:28:25', NULL, 'Evidence file downloaded by user', NULL),
(588, 9, '', 26, '2026-01-07 13:28:26', NULL, 'Evidence file downloaded by user', NULL),
(589, 1, '', 26, '2026-01-07 13:31:09', NULL, 'Evidence file downloaded by user', NULL),
(590, 5, '', 26, '2026-01-07 13:31:10', NULL, 'Evidence file downloaded by user', NULL),
(591, 4, '', 26, '2026-01-07 13:31:11', NULL, 'Evidence file downloaded by user', NULL),
(592, 3, '', 26, '2026-01-07 13:31:11', NULL, 'Evidence file downloaded by user', NULL),
(593, 2, '', 26, '2026-01-07 13:31:11', NULL, 'Evidence file downloaded by user', NULL),
(594, 1, '', 26, '2026-01-07 13:31:12', NULL, 'Evidence file downloaded by user', NULL),
(595, 5, '', 26, '2026-01-07 13:31:12', NULL, 'Evidence file downloaded by user', NULL),
(596, 8, '', 26, '2026-01-07 13:31:12', NULL, 'Evidence file downloaded by user', NULL),
(597, 7, '', 26, '2026-01-07 13:31:13', NULL, 'Evidence file downloaded by user', NULL),
(598, 6, '', 26, '2026-01-07 13:31:13', NULL, 'Evidence file downloaded by user', NULL),
(599, 10, '', 26, '2026-01-07 13:31:13', NULL, 'Evidence file downloaded by user', NULL),
(600, 9, '', 26, '2026-01-07 13:31:14', NULL, 'Evidence file downloaded by user', NULL),
(601, 4, '', 26, '2026-01-07 13:31:14', NULL, 'Evidence file downloaded by user', NULL),
(602, 3, '', 26, '2026-01-07 13:31:15', NULL, 'Evidence file downloaded by user', NULL),
(603, 2, '', 26, '2026-01-07 13:31:15', NULL, 'Evidence file downloaded by user', NULL),
(604, 1, '', 26, '2026-01-07 13:31:15', NULL, 'Evidence file downloaded by user', NULL),
(605, 5, '', 26, '2026-01-07 13:31:16', NULL, 'Evidence file downloaded by user', NULL),
(606, 8, '', 26, '2026-01-07 13:31:16', NULL, 'Evidence file downloaded by user', NULL),
(607, 7, '', 26, '2026-01-07 13:31:16', NULL, 'Evidence file downloaded by user', NULL),
(608, 6, '', 26, '2026-01-07 13:31:16', NULL, 'Evidence file downloaded by user', NULL),
(609, 10, '', 26, '2026-01-07 13:31:17', NULL, 'Evidence file downloaded by user', NULL),
(610, 9, '', 26, '2026-01-07 13:31:17', NULL, 'Evidence file downloaded by user', NULL),
(611, 9, '', 26, '2026-01-07 13:31:18', NULL, 'Evidence file downloaded by user', NULL),
(612, 1, '', 26, '2026-01-07 13:33:43', NULL, 'Evidence file downloaded by user', NULL),
(613, 5, '', 26, '2026-01-07 13:33:43', NULL, 'Evidence file downloaded by user', NULL),
(614, 9, '', 26, '2026-01-07 13:33:45', NULL, 'Evidence file downloaded by user', NULL),
(615, 4, '', 26, '2026-01-07 13:33:45', NULL, 'Evidence file downloaded by user', NULL),
(616, 3, '', 26, '2026-01-07 13:33:45', NULL, 'Evidence file downloaded by user', NULL),
(617, 2, '', 26, '2026-01-07 13:33:46', NULL, 'Evidence file downloaded by user', NULL),
(618, 1, '', 26, '2026-01-07 13:33:47', NULL, 'Evidence file downloaded by user', NULL),
(619, 5, '', 26, '2026-01-07 13:33:47', NULL, 'Evidence file downloaded by user', NULL),
(620, 8, '', 26, '2026-01-07 13:33:47', NULL, 'Evidence file downloaded by user', NULL),
(621, 7, '', 26, '2026-01-07 13:33:48', NULL, 'Evidence file downloaded by user', NULL),
(622, 6, '', 26, '2026-01-07 13:33:48', NULL, 'Evidence file downloaded by user', NULL),
(623, 10, '', 26, '2026-01-07 13:33:48', NULL, 'Evidence file downloaded by user', NULL),
(624, 9, '', 26, '2026-01-07 13:33:49', NULL, 'Evidence file downloaded by user', NULL),
(625, 4, '', 26, '2026-01-07 13:33:49', NULL, 'Evidence file downloaded by user', NULL),
(626, 3, '', 26, '2026-01-07 13:33:49', NULL, 'Evidence file downloaded by user', NULL),
(627, 2, '', 26, '2026-01-07 13:33:49', NULL, 'Evidence file downloaded by user', NULL),
(628, 1, '', 26, '2026-01-07 13:33:50', NULL, 'Evidence file downloaded by user', NULL),
(629, 5, '', 26, '2026-01-07 13:33:50', NULL, 'Evidence file downloaded by user', NULL),
(630, 8, '', 26, '2026-01-07 13:33:50', NULL, 'Evidence file downloaded by user', NULL),
(631, 7, '', 26, '2026-01-07 13:33:51', NULL, 'Evidence file downloaded by user', NULL),
(632, 6, '', 26, '2026-01-07 13:33:51', NULL, 'Evidence file downloaded by user', NULL),
(633, 10, '', 26, '2026-01-07 13:33:51', NULL, 'Evidence file downloaded by user', NULL),
(634, 9, '', 26, '2026-01-07 13:33:52', NULL, 'Evidence file downloaded by user', NULL),
(635, 1, '', 26, '2026-01-07 13:36:51', NULL, 'Evidence file downloaded by user', NULL),
(636, 5, '', 26, '2026-01-07 13:36:51', NULL, 'Evidence file downloaded by user', NULL),
(637, 4, '', 26, '2026-01-07 13:36:52', NULL, 'Evidence file downloaded by user', NULL),
(638, 3, '', 26, '2026-01-07 13:36:53', NULL, 'Evidence file downloaded by user', NULL),
(639, 2, '', 26, '2026-01-07 13:36:53', NULL, 'Evidence file downloaded by user', NULL),
(640, 1, '', 26, '2026-01-07 13:36:53', NULL, 'Evidence file downloaded by user', NULL),
(641, 5, '', 26, '2026-01-07 13:36:54', NULL, 'Evidence file downloaded by user', NULL),
(642, 8, '', 26, '2026-01-07 13:36:54', NULL, 'Evidence file downloaded by user', NULL),
(643, 7, '', 26, '2026-01-07 13:36:54', NULL, 'Evidence file downloaded by user', NULL),
(644, 6, '', 26, '2026-01-07 13:36:55', NULL, 'Evidence file downloaded by user', NULL),
(645, 10, '', 26, '2026-01-07 13:36:55', NULL, 'Evidence file downloaded by user', NULL),
(646, 9, '', 26, '2026-01-07 13:36:55', NULL, 'Evidence file downloaded by user', NULL),
(647, 4, '', 26, '2026-01-07 13:36:56', NULL, 'Evidence file downloaded by user', NULL),
(648, 3, '', 26, '2026-01-07 13:36:56', NULL, 'Evidence file downloaded by user', NULL),
(649, 2, '', 26, '2026-01-07 13:36:56', NULL, 'Evidence file downloaded by user', NULL),
(650, 1, '', 26, '2026-01-07 13:36:57', NULL, 'Evidence file downloaded by user', NULL),
(651, 5, '', 26, '2026-01-07 13:36:57', NULL, 'Evidence file downloaded by user', NULL),
(652, 8, '', 26, '2026-01-07 13:36:57', NULL, 'Evidence file downloaded by user', NULL),
(653, 7, '', 26, '2026-01-07 13:36:58', NULL, 'Evidence file downloaded by user', NULL),
(654, 6, '', 26, '2026-01-07 13:36:58', NULL, 'Evidence file downloaded by user', NULL),
(655, 10, '', 26, '2026-01-07 13:36:58', NULL, 'Evidence file downloaded by user', NULL),
(656, 9, '', 26, '2026-01-07 13:36:59', NULL, 'Evidence file downloaded by user', NULL),
(657, 9, '', 26, '2026-01-07 13:36:59', NULL, 'Evidence file downloaded by user', NULL),
(658, 1, '', 26, '2026-01-07 13:39:57', NULL, 'Evidence file downloaded by user', NULL),
(659, 5, '', 26, '2026-01-07 13:39:58', NULL, 'Evidence file downloaded by user', NULL),
(660, 4, '', 26, '2026-01-07 13:39:59', NULL, 'Evidence file downloaded by user', NULL),
(661, 3, '', 26, '2026-01-07 13:39:59', NULL, 'Evidence file downloaded by user', NULL),
(662, 2, '', 26, '2026-01-07 13:39:59', NULL, 'Evidence file downloaded by user', NULL),
(663, 1, '', 26, '2026-01-07 13:40:00', NULL, 'Evidence file downloaded by user', NULL),
(664, 5, '', 26, '2026-01-07 13:40:00', NULL, 'Evidence file downloaded by user', NULL),
(665, 8, '', 26, '2026-01-07 13:40:00', NULL, 'Evidence file downloaded by user', NULL),
(666, 7, '', 26, '2026-01-07 13:40:01', NULL, 'Evidence file downloaded by user', NULL),
(667, 6, '', 26, '2026-01-07 13:40:01', NULL, 'Evidence file downloaded by user', NULL),
(668, 10, '', 26, '2026-01-07 13:40:01', NULL, 'Evidence file downloaded by user', NULL),
(669, 9, '', 26, '2026-01-07 13:40:02', NULL, 'Evidence file downloaded by user', NULL),
(670, 4, '', 26, '2026-01-07 13:40:02', NULL, 'Evidence file downloaded by user', NULL),
(671, 3, '', 26, '2026-01-07 13:40:03', NULL, 'Evidence file downloaded by user', NULL),
(672, 2, '', 26, '2026-01-07 13:40:03', NULL, 'Evidence file downloaded by user', NULL),
(673, 1, '', 26, '2026-01-07 13:40:03', NULL, 'Evidence file downloaded by user', NULL),
(674, 5, '', 26, '2026-01-07 13:40:04', NULL, 'Evidence file downloaded by user', NULL),
(675, 8, '', 26, '2026-01-07 13:40:04', NULL, 'Evidence file downloaded by user', NULL),
(676, 7, '', 26, '2026-01-07 13:40:04', NULL, 'Evidence file downloaded by user', NULL),
(677, 6, '', 26, '2026-01-07 13:40:05', NULL, 'Evidence file downloaded by user', NULL),
(678, 10, '', 26, '2026-01-07 13:40:05', NULL, 'Evidence file downloaded by user', NULL),
(679, 9, '', 26, '2026-01-07 13:40:05', NULL, 'Evidence file downloaded by user', NULL),
(680, 9, '', 26, '2026-01-07 13:40:06', NULL, 'Evidence file downloaded by user', NULL),
(681, 1, '', 26, '2026-01-07 13:42:33', NULL, 'Evidence file downloaded by user', NULL),
(682, 5, '', 26, '2026-01-07 13:42:33', NULL, 'Evidence file downloaded by user', NULL),
(683, 4, '', 26, '2026-01-07 13:42:35', NULL, 'Evidence file downloaded by user', NULL),
(684, 3, '', 26, '2026-01-07 13:42:35', NULL, 'Evidence file downloaded by user', NULL),
(685, 2, '', 26, '2026-01-07 13:42:36', NULL, 'Evidence file downloaded by user', NULL),
(686, 1, '', 26, '2026-01-07 13:42:36', NULL, 'Evidence file downloaded by user', NULL),
(687, 5, '', 26, '2026-01-07 13:42:36', NULL, 'Evidence file downloaded by user', NULL),
(688, 8, '', 26, '2026-01-07 13:42:37', NULL, 'Evidence file downloaded by user', NULL),
(689, 7, '', 26, '2026-01-07 13:42:37', NULL, 'Evidence file downloaded by user', NULL),
(690, 6, '', 26, '2026-01-07 13:42:38', NULL, 'Evidence file downloaded by user', NULL),
(691, 10, '', 26, '2026-01-07 13:42:38', NULL, 'Evidence file downloaded by user', NULL),
(692, 9, '', 26, '2026-01-07 13:42:38', NULL, 'Evidence file downloaded by user', NULL),
(693, 4, '', 26, '2026-01-07 13:42:39', NULL, 'Evidence file downloaded by user', NULL),
(694, 3, '', 26, '2026-01-07 13:42:39', NULL, 'Evidence file downloaded by user', NULL),
(695, 2, '', 26, '2026-01-07 13:42:39', NULL, 'Evidence file downloaded by user', NULL),
(696, 1, '', 26, '2026-01-07 13:42:40', NULL, 'Evidence file downloaded by user', NULL),
(697, 5, '', 26, '2026-01-07 13:42:40', NULL, 'Evidence file downloaded by user', NULL),
(698, 8, '', 26, '2026-01-07 13:42:40', NULL, 'Evidence file downloaded by user', NULL),
(699, 7, '', 26, '2026-01-07 13:42:41', NULL, 'Evidence file downloaded by user', NULL),
(700, 6, '', 26, '2026-01-07 13:42:41', NULL, 'Evidence file downloaded by user', NULL),
(701, 10, '', 26, '2026-01-07 13:42:41', NULL, 'Evidence file downloaded by user', NULL),
(702, 9, '', 26, '2026-01-07 13:42:42', NULL, 'Evidence file downloaded by user', NULL),
(703, 9, '', 26, '2026-01-07 13:42:42', NULL, 'Evidence file downloaded by user', NULL),
(704, 1, '', 26, '2026-01-07 13:44:31', NULL, 'Evidence file downloaded by user', NULL),
(705, 5, '', 26, '2026-01-07 13:44:32', NULL, 'Evidence file downloaded by user', NULL),
(706, 9, '', 26, '2026-01-07 13:44:33', NULL, 'Evidence file downloaded by user', NULL),
(707, 4, '', 26, '2026-01-07 13:44:36', NULL, 'Evidence file downloaded by user', NULL),
(708, 3, '', 26, '2026-01-07 13:44:36', NULL, 'Evidence file downloaded by user', NULL),
(709, 2, '', 26, '2026-01-07 13:44:37', NULL, 'Evidence file downloaded by user', NULL),
(710, 1, '', 26, '2026-01-07 13:44:37', NULL, 'Evidence file downloaded by user', NULL),
(711, 5, '', 26, '2026-01-07 13:44:37', NULL, 'Evidence file downloaded by user', NULL),
(712, 8, '', 26, '2026-01-07 13:44:38', NULL, 'Evidence file downloaded by user', NULL),
(713, 7, '', 26, '2026-01-07 13:44:38', NULL, 'Evidence file downloaded by user', NULL),
(714, 6, '', 26, '2026-01-07 13:44:38', NULL, 'Evidence file downloaded by user', NULL),
(715, 10, '', 26, '2026-01-07 13:44:38', NULL, 'Evidence file downloaded by user', NULL),
(716, 9, '', 26, '2026-01-07 13:44:39', NULL, 'Evidence file downloaded by user', NULL),
(717, 4, '', 26, '2026-01-07 13:44:39', NULL, 'Evidence file downloaded by user', NULL),
(718, 3, '', 26, '2026-01-07 13:44:39', NULL, 'Evidence file downloaded by user', NULL),
(719, 2, '', 26, '2026-01-07 13:44:40', NULL, 'Evidence file downloaded by user', NULL),
(720, 1, '', 26, '2026-01-07 13:44:40', NULL, 'Evidence file downloaded by user', NULL),
(721, 5, '', 26, '2026-01-07 13:44:40', NULL, 'Evidence file downloaded by user', NULL),
(722, 8, '', 26, '2026-01-07 13:44:41', NULL, 'Evidence file downloaded by user', NULL),
(723, 7, '', 26, '2026-01-07 13:44:41', NULL, 'Evidence file downloaded by user', NULL),
(724, 6, '', 26, '2026-01-07 13:44:41', NULL, 'Evidence file downloaded by user', NULL),
(725, 10, '', 26, '2026-01-07 13:44:41', NULL, 'Evidence file downloaded by user', NULL),
(726, 9, '', 26, '2026-01-07 13:44:42', NULL, 'Evidence file downloaded by user', NULL),
(727, 1, '', 26, '2026-01-07 13:46:51', NULL, 'Evidence file downloaded by user', NULL),
(728, 5, '', 26, '2026-01-07 13:46:52', NULL, 'Evidence file downloaded by user', NULL),
(729, 4, '', 26, '2026-01-07 13:46:52', NULL, 'Evidence file downloaded by user', NULL),
(730, 3, '', 26, '2026-01-07 13:46:52', NULL, 'Evidence file downloaded by user', NULL),
(731, 2, '', 26, '2026-01-07 13:46:53', NULL, 'Evidence file downloaded by user', NULL),
(732, 1, '', 26, '2026-01-07 13:46:53', NULL, 'Evidence file downloaded by user', NULL),
(733, 8, '', 26, '2026-01-07 13:46:53', NULL, 'Evidence file downloaded by user', NULL),
(734, 7, '', 26, '2026-01-07 13:46:54', NULL, 'Evidence file downloaded by user', NULL),
(735, 6, '', 26, '2026-01-07 13:46:54', NULL, 'Evidence file downloaded by user', NULL),
(736, 10, '', 26, '2026-01-07 13:46:54', NULL, 'Evidence file downloaded by user', NULL),
(737, 9, '', 26, '2026-01-07 13:46:55', NULL, 'Evidence file downloaded by user', NULL),
(738, 5, '', 26, '2026-01-07 13:46:55', NULL, 'Evidence file downloaded by user', NULL),
(739, 4, '', 26, '2026-01-07 13:46:56', NULL, 'Evidence file downloaded by user', NULL),
(740, 3, '', 26, '2026-01-07 13:46:56', NULL, 'Evidence file downloaded by user', NULL),
(741, 2, '', 26, '2026-01-07 13:46:56', NULL, 'Evidence file downloaded by user', NULL),
(742, 1, '', 26, '2026-01-07 13:46:57', NULL, 'Evidence file downloaded by user', NULL),
(743, 8, '', 26, '2026-01-07 13:46:57', NULL, 'Evidence file downloaded by user', NULL),
(744, 7, '', 26, '2026-01-07 13:46:57', NULL, 'Evidence file downloaded by user', NULL),
(745, 6, '', 26, '2026-01-07 13:46:58', NULL, 'Evidence file downloaded by user', NULL),
(746, 10, '', 26, '2026-01-07 13:46:58', NULL, 'Evidence file downloaded by user', NULL),
(747, 9, '', 26, '2026-01-07 13:46:58', NULL, 'Evidence file downloaded by user', NULL),
(748, 5, '', 26, '2026-01-07 13:46:59', NULL, 'Evidence file downloaded by user', NULL),
(749, 9, '', 26, '2026-01-07 13:47:00', NULL, 'Evidence file downloaded by user', NULL),
(750, 1, '', 26, '2026-01-07 13:48:41', NULL, 'Evidence file downloaded by user', NULL),
(751, 5, '', 26, '2026-01-07 13:48:41', NULL, 'Evidence file downloaded by user', NULL),
(752, 9, '', 26, '2026-01-07 13:48:42', NULL, 'Evidence file downloaded by user', NULL),
(753, 1, '', 26, '2026-01-07 13:48:42', NULL, 'Evidence file downloaded by user', NULL),
(754, 5, '', 26, '2026-01-07 13:48:42', NULL, 'Evidence file downloaded by user', NULL),
(755, 9, '', 26, '2026-01-07 13:48:43', NULL, 'Evidence file downloaded by user', NULL),
(756, 4, '', 26, '2026-01-07 13:48:43', NULL, 'Evidence file downloaded by user', NULL),
(757, 3, '', 26, '2026-01-07 13:48:43', NULL, 'Evidence file downloaded by user', NULL),
(758, 2, '', 26, '2026-01-07 13:48:44', NULL, 'Evidence file downloaded by user', NULL),
(759, 1, '', 26, '2026-01-07 13:48:44', NULL, 'Evidence file downloaded by user', NULL),
(760, 5, '', 26, '2026-01-07 13:48:44', NULL, 'Evidence file downloaded by user', NULL),
(761, 8, '', 26, '2026-01-07 13:48:45', NULL, 'Evidence file downloaded by user', NULL),
(762, 7, '', 26, '2026-01-07 13:48:45', NULL, 'Evidence file downloaded by user', NULL),
(763, 6, '', 26, '2026-01-07 13:48:46', NULL, 'Evidence file downloaded by user', NULL),
(764, 10, '', 26, '2026-01-07 13:48:46', NULL, 'Evidence file downloaded by user', NULL),
(765, 9, '', 26, '2026-01-07 13:48:46', NULL, 'Evidence file downloaded by user', NULL),
(766, 4, '', 26, '2026-01-07 13:48:47', NULL, 'Evidence file downloaded by user', NULL),
(767, 3, '', 26, '2026-01-07 13:48:47', NULL, 'Evidence file downloaded by user', NULL),
(768, 2, '', 26, '2026-01-07 13:48:47', NULL, 'Evidence file downloaded by user', NULL),
(769, 8, '', 26, '2026-01-07 13:48:48', NULL, 'Evidence file downloaded by user', NULL),
(770, 7, '', 26, '2026-01-07 13:48:48', NULL, 'Evidence file downloaded by user', NULL),
(771, 6, '', 26, '2026-01-07 13:48:48', NULL, 'Evidence file downloaded by user', NULL),
(772, 10, '', 26, '2026-01-07 13:48:49', NULL, 'Evidence file downloaded by user', NULL),
(773, 1, '', 26, '2026-01-07 13:50:55', NULL, 'Evidence file downloaded by user', NULL),
(774, 5, '', 26, '2026-01-07 13:50:55', NULL, 'Evidence file downloaded by user', NULL),
(775, 4, '', 26, '2026-01-07 13:50:57', NULL, 'Evidence file downloaded by user', NULL),
(776, 3, '', 26, '2026-01-07 13:50:57', NULL, 'Evidence file downloaded by user', NULL),
(777, 2, '', 26, '2026-01-07 13:50:57', NULL, 'Evidence file downloaded by user', NULL),
(778, 1, '', 26, '2026-01-07 13:50:58', NULL, 'Evidence file downloaded by user', NULL),
(779, 5, '', 26, '2026-01-07 13:50:58', NULL, 'Evidence file downloaded by user', NULL),
(780, 8, '', 26, '2026-01-07 13:50:58', NULL, 'Evidence file downloaded by user', NULL),
(781, 7, '', 26, '2026-01-07 13:50:59', NULL, 'Evidence file downloaded by user', NULL),
(782, 6, '', 26, '2026-01-07 13:50:59', NULL, 'Evidence file downloaded by user', NULL),
(783, 10, '', 26, '2026-01-07 13:50:59', NULL, 'Evidence file downloaded by user', NULL),
(784, 9, '', 26, '2026-01-07 13:50:59', NULL, 'Evidence file downloaded by user', NULL),
(785, 4, '', 26, '2026-01-07 13:51:00', NULL, 'Evidence file downloaded by user', NULL),
(786, 3, '', 26, '2026-01-07 13:51:00', NULL, 'Evidence file downloaded by user', NULL),
(787, 2, '', 26, '2026-01-07 13:51:01', NULL, 'Evidence file downloaded by user', NULL),
(788, 1, '', 26, '2026-01-07 13:51:01', NULL, 'Evidence file downloaded by user', NULL),
(789, 5, '', 26, '2026-01-07 13:51:01', NULL, 'Evidence file downloaded by user', NULL),
(790, 8, '', 26, '2026-01-07 13:51:02', NULL, 'Evidence file downloaded by user', NULL),
(791, 7, '', 26, '2026-01-07 13:51:02', NULL, 'Evidence file downloaded by user', NULL),
(792, 6, '', 26, '2026-01-07 13:51:02', NULL, 'Evidence file downloaded by user', NULL),
(793, 10, '', 26, '2026-01-07 13:51:03', NULL, 'Evidence file downloaded by user', NULL),
(794, 9, '', 26, '2026-01-07 13:51:03', NULL, 'Evidence file downloaded by user', NULL),
(795, 9, '', 26, '2026-01-07 13:51:04', NULL, 'Evidence file downloaded by user', NULL),
(796, 1, '', 26, '2026-01-07 13:54:07', NULL, 'Evidence file downloaded by user', NULL),
(797, 5, '', 26, '2026-01-07 13:54:08', NULL, 'Evidence file downloaded by user', NULL),
(798, 4, '', 26, '2026-01-07 13:54:08', NULL, 'Evidence file downloaded by user', NULL),
(799, 3, '', 26, '2026-01-07 13:54:09', NULL, 'Evidence file downloaded by user', NULL),
(800, 2, '', 26, '2026-01-07 13:54:09', NULL, 'Evidence file downloaded by user', NULL),
(801, 1, '', 26, '2026-01-07 13:54:10', NULL, 'Evidence file downloaded by user', NULL),
(802, 8, '', 26, '2026-01-07 13:54:10', NULL, 'Evidence file downloaded by user', NULL),
(803, 7, '', 26, '2026-01-07 13:54:10', NULL, 'Evidence file downloaded by user', NULL),
(804, 6, '', 26, '2026-01-07 13:54:11', NULL, 'Evidence file downloaded by user', NULL),
(805, 10, '', 26, '2026-01-07 13:54:11', NULL, 'Evidence file downloaded by user', NULL),
(806, 9, '', 26, '2026-01-07 13:54:11', NULL, 'Evidence file downloaded by user', NULL),
(807, 5, '', 26, '2026-01-07 13:54:12', NULL, 'Evidence file downloaded by user', NULL),
(808, 4, '', 26, '2026-01-07 13:54:12', NULL, 'Evidence file downloaded by user', NULL),
(809, 3, '', 26, '2026-01-07 13:54:12', NULL, 'Evidence file downloaded by user', NULL),
(810, 2, '', 26, '2026-01-07 13:54:13', NULL, 'Evidence file downloaded by user', NULL),
(811, 1, '', 26, '2026-01-07 13:54:13', NULL, 'Evidence file downloaded by user', NULL),
(812, 8, '', 26, '2026-01-07 13:54:13', NULL, 'Evidence file downloaded by user', NULL),
(813, 7, '', 26, '2026-01-07 13:54:14', NULL, 'Evidence file downloaded by user', NULL),
(814, 6, '', 26, '2026-01-07 13:54:14', NULL, 'Evidence file downloaded by user', NULL),
(815, 10, '', 26, '2026-01-07 13:54:14', NULL, 'Evidence file downloaded by user', NULL),
(816, 9, '', 26, '2026-01-07 13:54:15', NULL, 'Evidence file downloaded by user', NULL),
(817, 5, '', 26, '2026-01-07 13:54:15', NULL, 'Evidence file downloaded by user', NULL),
(818, 9, '', 26, '2026-01-07 13:54:16', NULL, 'Evidence file downloaded by user', NULL),
(819, 1, '', 26, '2026-01-07 13:56:43', NULL, 'Evidence file downloaded by user', NULL),
(820, 5, '', 26, '2026-01-07 13:56:44', NULL, 'Evidence file downloaded by user', NULL),
(821, 4, '', 26, '2026-01-07 13:56:44', NULL, 'Evidence file downloaded by user', NULL),
(822, 3, '', 26, '2026-01-07 13:56:44', NULL, 'Evidence file downloaded by user', NULL),
(823, 2, '', 26, '2026-01-07 13:56:45', NULL, 'Evidence file downloaded by user', NULL),
(824, 1, '', 26, '2026-01-07 13:56:45', NULL, 'Evidence file downloaded by user', NULL),
(825, 8, '', 26, '2026-01-07 13:56:45', NULL, 'Evidence file downloaded by user', NULL),
(826, 7, '', 26, '2026-01-07 13:56:46', NULL, 'Evidence file downloaded by user', NULL),
(827, 6, '', 26, '2026-01-07 13:56:46', NULL, 'Evidence file downloaded by user', NULL),
(828, 10, '', 26, '2026-01-07 13:56:46', NULL, 'Evidence file downloaded by user', NULL),
(829, 9, '', 26, '2026-01-07 13:56:46', NULL, 'Evidence file downloaded by user', NULL),
(830, 5, '', 26, '2026-01-07 13:56:47', NULL, 'Evidence file downloaded by user', NULL),
(831, 4, '', 26, '2026-01-07 13:56:47', NULL, 'Evidence file downloaded by user', NULL),
(832, 3, '', 26, '2026-01-07 13:56:48', NULL, 'Evidence file downloaded by user', NULL),
(833, 2, '', 26, '2026-01-07 13:56:48', NULL, 'Evidence file downloaded by user', NULL),
(834, 1, '', 26, '2026-01-07 13:56:48', NULL, 'Evidence file downloaded by user', NULL),
(835, 8, '', 26, '2026-01-07 13:56:49', NULL, 'Evidence file downloaded by user', NULL),
(836, 7, '', 26, '2026-01-07 13:56:49', NULL, 'Evidence file downloaded by user', NULL),
(837, 6, '', 26, '2026-01-07 13:56:49', NULL, 'Evidence file downloaded by user', NULL),
(838, 10, '', 26, '2026-01-07 13:56:50', NULL, 'Evidence file downloaded by user', NULL),
(839, 9, '', 26, '2026-01-07 13:56:50', NULL, 'Evidence file downloaded by user', NULL),
(840, 5, '', 26, '2026-01-07 13:56:51', NULL, 'Evidence file downloaded by user', NULL),
(841, 9, '', 26, '2026-01-07 13:56:52', NULL, 'Evidence file downloaded by user', NULL),
(842, 1, '', 26, '2026-01-07 14:00:31', NULL, 'Evidence file downloaded by user', NULL),
(843, 5, '', 26, '2026-01-07 14:00:31', NULL, 'Evidence file downloaded by user', NULL),
(844, 4, '', 26, '2026-01-07 14:00:32', NULL, 'Evidence file downloaded by user', NULL),
(845, 3, '', 26, '2026-01-07 14:00:33', NULL, 'Evidence file downloaded by user', NULL),
(846, 2, '', 26, '2026-01-07 14:00:33', NULL, 'Evidence file downloaded by user', NULL),
(847, 1, '', 26, '2026-01-07 14:00:33', NULL, 'Evidence file downloaded by user', NULL),
(848, 5, '', 26, '2026-01-07 14:00:34', NULL, 'Evidence file downloaded by user', NULL),
(849, 8, '', 26, '2026-01-07 14:00:34', NULL, 'Evidence file downloaded by user', NULL),
(850, 7, '', 26, '2026-01-07 14:00:34', NULL, 'Evidence file downloaded by user', NULL),
(851, 6, '', 26, '2026-01-07 14:00:35', NULL, 'Evidence file downloaded by user', NULL),
(852, 10, '', 26, '2026-01-07 14:00:35', NULL, 'Evidence file downloaded by user', NULL),
(853, 9, '', 26, '2026-01-07 14:00:35', NULL, 'Evidence file downloaded by user', NULL),
(854, 4, '', 26, '2026-01-07 14:00:36', NULL, 'Evidence file downloaded by user', NULL),
(855, 3, '', 26, '2026-01-07 14:00:36', NULL, 'Evidence file downloaded by user', NULL),
(856, 2, '', 26, '2026-01-07 14:00:37', NULL, 'Evidence file downloaded by user', NULL),
(857, 1, '', 26, '2026-01-07 14:00:37', NULL, 'Evidence file downloaded by user', NULL),
(858, 5, '', 26, '2026-01-07 14:00:37', NULL, 'Evidence file downloaded by user', NULL),
(859, 8, '', 26, '2026-01-07 14:00:38', NULL, 'Evidence file downloaded by user', NULL),
(860, 7, '', 26, '2026-01-07 14:00:38', NULL, 'Evidence file downloaded by user', NULL),
(861, 6, '', 26, '2026-01-07 14:00:38', NULL, 'Evidence file downloaded by user', NULL),
(862, 10, '', 26, '2026-01-07 14:00:38', NULL, 'Evidence file downloaded by user', NULL),
(863, 9, '', 26, '2026-01-07 14:00:39', NULL, 'Evidence file downloaded by user', NULL),
(864, 9, '', 26, '2026-01-07 14:00:39', NULL, 'Evidence file downloaded by user', NULL),
(865, 1, '', 26, '2026-01-07 14:04:19', NULL, 'Evidence file downloaded by user', NULL),
(866, 5, '', 26, '2026-01-07 14:04:19', NULL, 'Evidence file downloaded by user', NULL),
(867, 4, '', 26, '2026-01-07 14:04:20', NULL, 'Evidence file downloaded by user', NULL),
(868, 3, '', 26, '2026-01-07 14:04:20', NULL, 'Evidence file downloaded by user', NULL),
(869, 1, '', 26, '2026-01-07 14:04:21', NULL, 'Evidence file downloaded by user', NULL),
(870, 2, '', 26, '2026-01-07 14:04:21', NULL, 'Evidence file downloaded by user', NULL),
(871, 5, '', 26, '2026-01-07 14:04:21', NULL, 'Evidence file downloaded by user', NULL),
(872, 8, '', 26, '2026-01-07 14:04:22', NULL, 'Evidence file downloaded by user', NULL),
(873, 7, '', 26, '2026-01-07 14:04:22', NULL, 'Evidence file downloaded by user', NULL),
(874, 6, '', 26, '2026-01-07 14:04:22', NULL, 'Evidence file downloaded by user', NULL),
(875, 10, '', 26, '2026-01-07 14:04:23', NULL, 'Evidence file downloaded by user', NULL),
(876, 9, '', 26, '2026-01-07 14:04:23', NULL, 'Evidence file downloaded by user', NULL),
(877, 4, '', 26, '2026-01-07 14:04:24', NULL, 'Evidence file downloaded by user', NULL),
(878, 3, '', 26, '2026-01-07 14:04:24', NULL, 'Evidence file downloaded by user', NULL),
(879, 1, '', 26, '2026-01-07 14:04:24', NULL, 'Evidence file downloaded by user', NULL),
(880, 2, '', 26, '2026-01-07 14:04:25', NULL, 'Evidence file downloaded by user', NULL),
(881, 5, '', 26, '2026-01-07 14:04:25', NULL, 'Evidence file downloaded by user', NULL),
(882, 8, '', 26, '2026-01-07 14:04:25', NULL, 'Evidence file downloaded by user', NULL),
(883, 7, '', 26, '2026-01-07 14:04:26', NULL, 'Evidence file downloaded by user', NULL),
(884, 6, '', 26, '2026-01-07 14:04:26', NULL, 'Evidence file downloaded by user', NULL),
(885, 10, '', 26, '2026-01-07 14:04:26', NULL, 'Evidence file downloaded by user', NULL),
(886, 9, '', 26, '2026-01-07 14:04:26', NULL, 'Evidence file downloaded by user', NULL),
(887, 9, '', 26, '2026-01-07 14:04:27', NULL, 'Evidence file downloaded by user', NULL),
(888, 1, '', 26, '2026-01-07 14:06:30', NULL, 'Evidence file downloaded by user', NULL),
(889, 5, '', 26, '2026-01-07 14:06:30', NULL, 'Evidence file downloaded by user', NULL),
(890, 4, '', 26, '2026-01-07 14:06:31', NULL, 'Evidence file downloaded by user', NULL),
(891, 3, '', 26, '2026-01-07 14:06:32', NULL, 'Evidence file downloaded by user', NULL),
(892, 2, '', 26, '2026-01-07 14:06:32', NULL, 'Evidence file downloaded by user', NULL),
(893, 1, '', 26, '2026-01-07 14:06:32', NULL, 'Evidence file downloaded by user', NULL),
(894, 5, '', 26, '2026-01-07 14:06:33', NULL, 'Evidence file downloaded by user', NULL),
(895, 8, '', 26, '2026-01-07 14:06:33', NULL, 'Evidence file downloaded by user', NULL),
(896, 7, '', 26, '2026-01-07 14:06:33', NULL, 'Evidence file downloaded by user', NULL),
(897, 6, '', 26, '2026-01-07 14:06:34', NULL, 'Evidence file downloaded by user', NULL),
(898, 10, '', 26, '2026-01-07 14:06:34', NULL, 'Evidence file downloaded by user', NULL),
(899, 9, '', 26, '2026-01-07 14:06:34', NULL, 'Evidence file downloaded by user', NULL),
(900, 4, '', 26, '2026-01-07 14:06:35', NULL, 'Evidence file downloaded by user', NULL),
(901, 3, '', 26, '2026-01-07 14:06:35', NULL, 'Evidence file downloaded by user', NULL),
(902, 2, '', 26, '2026-01-07 14:06:35', NULL, 'Evidence file downloaded by user', NULL),
(903, 1, '', 26, '2026-01-07 14:06:36', NULL, 'Evidence file downloaded by user', NULL),
(904, 5, '', 26, '2026-01-07 14:06:36', NULL, 'Evidence file downloaded by user', NULL),
(905, 8, '', 26, '2026-01-07 14:06:36', NULL, 'Evidence file downloaded by user', NULL),
(906, 7, '', 26, '2026-01-07 14:06:37', NULL, 'Evidence file downloaded by user', NULL),
(907, 6, '', 26, '2026-01-07 14:06:37', NULL, 'Evidence file downloaded by user', NULL),
(908, 10, '', 26, '2026-01-07 14:06:37', NULL, 'Evidence file downloaded by user', NULL),
(909, 9, '', 26, '2026-01-07 14:06:38', NULL, 'Evidence file downloaded by user', NULL),
(910, 9, '', 26, '2026-01-07 14:06:38', NULL, 'Evidence file downloaded by user', NULL),
(911, 1, '', 26, '2026-01-07 14:08:25', NULL, 'Evidence file downloaded by user', NULL),
(912, 4, '', 26, '2026-01-07 14:08:25', NULL, 'Evidence file downloaded by user', NULL),
(913, 3, '', 26, '2026-01-07 14:08:26', NULL, 'Evidence file downloaded by user', NULL),
(914, 2, '', 26, '2026-01-07 14:08:26', NULL, 'Evidence file downloaded by user', NULL),
(915, 5, '', 26, '2026-01-07 14:08:26', NULL, 'Evidence file downloaded by user', NULL),
(916, 8, '', 26, '2026-01-07 14:08:27', NULL, 'Evidence file downloaded by user', NULL),
(917, 7, '', 26, '2026-01-07 14:08:27', NULL, 'Evidence file downloaded by user', NULL),
(918, 6, '', 26, '2026-01-07 14:08:27', NULL, 'Evidence file downloaded by user', NULL),
(919, 10, '', 26, '2026-01-07 14:08:28', NULL, 'Evidence file downloaded by user', NULL),
(920, 9, '', 26, '2026-01-07 14:08:28', NULL, 'Evidence file downloaded by user', NULL),
(921, 1, '', 26, '2026-01-07 14:08:29', NULL, 'Evidence file downloaded by user', NULL),
(922, 4, '', 26, '2026-01-07 14:08:29', NULL, 'Evidence file downloaded by user', NULL),
(923, 3, '', 26, '2026-01-07 14:08:29', NULL, 'Evidence file downloaded by user', NULL),
(924, 2, '', 26, '2026-01-07 14:08:29', NULL, 'Evidence file downloaded by user', NULL),
(925, 5, '', 26, '2026-01-07 14:08:30', NULL, 'Evidence file downloaded by user', NULL),
(926, 8, '', 26, '2026-01-07 14:08:30', NULL, 'Evidence file downloaded by user', NULL),
(927, 7, '', 26, '2026-01-07 14:08:30', NULL, 'Evidence file downloaded by user', NULL),
(928, 6, '', 26, '2026-01-07 14:08:31', NULL, 'Evidence file downloaded by user', NULL),
(929, 10, '', 26, '2026-01-07 14:08:31', NULL, 'Evidence file downloaded by user', NULL),
(930, 9, '', 26, '2026-01-07 14:08:31', NULL, 'Evidence file downloaded by user', NULL),
(931, 1, '', 26, '2026-01-07 14:08:32', NULL, 'Evidence file downloaded by user', NULL),
(932, 5, '', 26, '2026-01-07 14:08:32', NULL, 'Evidence file downloaded by user', NULL),
(933, 9, '', 26, '2026-01-07 14:08:33', NULL, 'Evidence file downloaded by user', NULL),
(934, 1, '', 26, '2026-01-07 14:11:44', NULL, 'Evidence file downloaded by user', NULL),
(935, 5, '', 26, '2026-01-07 14:11:44', NULL, 'Evidence file downloaded by user', NULL),
(936, 9, '', 26, '2026-01-07 14:11:46', NULL, 'Evidence file downloaded by user', NULL),
(937, 4, '', 26, '2026-01-07 14:11:50', NULL, 'Evidence file downloaded by user', NULL),
(938, 3, '', 26, '2026-01-07 14:11:51', NULL, 'Evidence file downloaded by user', NULL),
(939, 2, '', 26, '2026-01-07 14:11:51', NULL, 'Evidence file downloaded by user', NULL),
(940, 1, '', 26, '2026-01-07 14:11:51', NULL, 'Evidence file downloaded by user', NULL),
(941, 5, '', 26, '2026-01-07 14:11:52', NULL, 'Evidence file downloaded by user', NULL),
(942, 8, '', 26, '2026-01-07 14:11:52', NULL, 'Evidence file downloaded by user', NULL),
(943, 7, '', 26, '2026-01-07 14:11:52', NULL, 'Evidence file downloaded by user', NULL),
(944, 6, '', 26, '2026-01-07 14:11:53', NULL, 'Evidence file downloaded by user', NULL),
(945, 10, '', 26, '2026-01-07 14:11:53', NULL, 'Evidence file downloaded by user', NULL),
(946, 9, '', 26, '2026-01-07 14:11:53', NULL, 'Evidence file downloaded by user', NULL),
(947, 4, '', 26, '2026-01-07 14:11:54', NULL, 'Evidence file downloaded by user', NULL),
(948, 3, '', 26, '2026-01-07 14:11:54', NULL, 'Evidence file downloaded by user', NULL),
(949, 2, '', 26, '2026-01-07 14:11:54', NULL, 'Evidence file downloaded by user', NULL),
(950, 1, '', 26, '2026-01-07 14:11:55', NULL, 'Evidence file downloaded by user', NULL),
(951, 5, '', 26, '2026-01-07 14:11:55', NULL, 'Evidence file downloaded by user', NULL),
(952, 8, '', 26, '2026-01-07 14:11:55', NULL, 'Evidence file downloaded by user', NULL),
(953, 7, '', 26, '2026-01-07 14:11:55', NULL, 'Evidence file downloaded by user', NULL),
(954, 6, '', 26, '2026-01-07 14:11:56', NULL, 'Evidence file downloaded by user', NULL),
(955, 10, '', 26, '2026-01-07 14:11:56', NULL, 'Evidence file downloaded by user', NULL),
(956, 9, '', 26, '2026-01-07 14:11:56', NULL, 'Evidence file downloaded by user', NULL),
(957, 1, '', 26, '2026-01-07 14:13:42', NULL, 'Evidence file downloaded by user', NULL),
(958, 5, '', 26, '2026-01-07 14:13:42', NULL, 'Evidence file downloaded by user', NULL),
(959, 4, '', 26, '2026-01-07 14:13:43', NULL, 'Evidence file downloaded by user', NULL),
(960, 3, '', 26, '2026-01-07 14:13:44', NULL, 'Evidence file downloaded by user', NULL),
(961, 2, '', 26, '2026-01-07 14:13:44', NULL, 'Evidence file downloaded by user', NULL),
(962, 1, '', 26, '2026-01-07 14:13:44', NULL, 'Evidence file downloaded by user', NULL),
(963, 5, '', 26, '2026-01-07 14:13:45', NULL, 'Evidence file downloaded by user', NULL),
(964, 8, '', 26, '2026-01-07 14:13:45', NULL, 'Evidence file downloaded by user', NULL),
(965, 7, '', 26, '2026-01-07 14:13:45', NULL, 'Evidence file downloaded by user', NULL),
(966, 6, '', 26, '2026-01-07 14:13:46', NULL, 'Evidence file downloaded by user', NULL),
(967, 10, '', 26, '2026-01-07 14:13:46', NULL, 'Evidence file downloaded by user', NULL),
(968, 9, '', 26, '2026-01-07 14:13:46', NULL, 'Evidence file downloaded by user', NULL),
(969, 4, '', 26, '2026-01-07 14:13:47', NULL, 'Evidence file downloaded by user', NULL),
(970, 3, '', 26, '2026-01-07 14:13:47', NULL, 'Evidence file downloaded by user', NULL),
(971, 2, '', 26, '2026-01-07 14:13:47', NULL, 'Evidence file downloaded by user', NULL),
(972, 1, '', 26, '2026-01-07 14:13:48', NULL, 'Evidence file downloaded by user', NULL),
(973, 5, '', 26, '2026-01-07 14:13:48', NULL, 'Evidence file downloaded by user', NULL),
(974, 8, '', 26, '2026-01-07 14:13:48', NULL, 'Evidence file downloaded by user', NULL),
(975, 7, '', 26, '2026-01-07 14:13:49', NULL, 'Evidence file downloaded by user', NULL),
(976, 6, '', 26, '2026-01-07 14:13:49', NULL, 'Evidence file downloaded by user', NULL),
(977, 10, '', 26, '2026-01-07 14:13:49', NULL, 'Evidence file downloaded by user', NULL),
(978, 9, '', 26, '2026-01-07 14:13:50', NULL, 'Evidence file downloaded by user', NULL),
(979, 9, '', 26, '2026-01-07 14:13:50', NULL, 'Evidence file downloaded by user', NULL),
(980, 1, '', 26, '2026-01-07 14:16:03', NULL, 'Evidence file downloaded by user', NULL),
(981, 4, '', 26, '2026-01-07 14:16:04', NULL, 'Evidence file downloaded by user', NULL),
(982, 3, '', 26, '2026-01-07 14:16:04', NULL, 'Evidence file downloaded by user', NULL),
(983, 2, '', 26, '2026-01-07 14:16:04', NULL, 'Evidence file downloaded by user', NULL),
(984, 5, '', 26, '2026-01-07 14:16:05', NULL, 'Evidence file downloaded by user', NULL),
(985, 8, '', 26, '2026-01-07 14:16:05', NULL, 'Evidence file downloaded by user', NULL),
(986, 7, '', 26, '2026-01-07 14:16:05', NULL, 'Evidence file downloaded by user', NULL),
(987, 6, '', 26, '2026-01-07 14:16:06', NULL, 'Evidence file downloaded by user', NULL),
(988, 10, '', 26, '2026-01-07 14:16:06', NULL, 'Evidence file downloaded by user', NULL),
(989, 9, '', 26, '2026-01-07 14:16:07', NULL, 'Evidence file downloaded by user', NULL),
(990, 1, '', 26, '2026-01-07 14:16:08', NULL, 'Evidence file downloaded by user', NULL),
(991, 4, '', 26, '2026-01-07 14:16:09', NULL, 'Evidence file downloaded by user', NULL),
(992, 3, '', 26, '2026-01-07 14:16:09', NULL, 'Evidence file downloaded by user', NULL),
(993, 2, '', 26, '2026-01-07 14:16:09', NULL, 'Evidence file downloaded by user', NULL),
(994, 5, '', 26, '2026-01-07 14:16:10', NULL, 'Evidence file downloaded by user', NULL),
(995, 8, '', 26, '2026-01-07 14:16:10', NULL, 'Evidence file downloaded by user', NULL),
(996, 7, '', 26, '2026-01-07 14:16:10', NULL, 'Evidence file downloaded by user', NULL),
(997, 6, '', 26, '2026-01-07 14:16:11', NULL, 'Evidence file downloaded by user', NULL),
(998, 10, '', 26, '2026-01-07 14:16:11', NULL, 'Evidence file downloaded by user', NULL),
(999, 9, '', 26, '2026-01-07 14:16:12', NULL, 'Evidence file downloaded by user', NULL),
(1000, 1, '', 26, '2026-01-07 14:16:13', NULL, 'Evidence file downloaded by user', NULL),
(1001, 5, '', 26, '2026-01-07 14:16:13', NULL, 'Evidence file downloaded by user', NULL),
(1002, 9, '', 26, '2026-01-07 14:16:15', NULL, 'Evidence file downloaded by user', NULL),
(1003, 4, '', 26, '2026-01-07 14:17:37', NULL, 'Evidence file downloaded by user', NULL),
(1004, 3, '', 26, '2026-01-07 14:17:37', NULL, 'Evidence file downloaded by user', NULL),
(1005, 2, '', 26, '2026-01-07 14:17:37', NULL, 'Evidence file downloaded by user', NULL),
(1006, 1, '', 26, '2026-01-07 14:17:38', NULL, 'Evidence file downloaded by user', NULL),
(1007, 5, '', 26, '2026-01-07 14:17:38', NULL, 'Evidence file downloaded by user', NULL),
(1008, 8, '', 26, '2026-01-07 14:17:39', NULL, 'Evidence file downloaded by user', NULL),
(1009, 7, '', 26, '2026-01-07 14:17:39', NULL, 'Evidence file downloaded by user', NULL),
(1010, 6, '', 26, '2026-01-07 14:17:40', NULL, 'Evidence file downloaded by user', NULL),
(1011, 10, '', 26, '2026-01-07 14:17:40', NULL, 'Evidence file downloaded by user', NULL),
(1012, 9, '', 26, '2026-01-07 14:17:41', NULL, 'Evidence file downloaded by user', NULL),
(1013, 4, '', 26, '2026-01-07 14:17:41', NULL, 'Evidence file downloaded by user', NULL),
(1014, 3, '', 26, '2026-01-07 14:17:42', NULL, 'Evidence file downloaded by user', NULL),
(1015, 2, '', 26, '2026-01-07 14:17:42', NULL, 'Evidence file downloaded by user', NULL),
(1016, 1, '', 26, '2026-01-07 14:17:43', NULL, 'Evidence file downloaded by user', NULL),
(1017, 5, '', 26, '2026-01-07 14:17:43', NULL, 'Evidence file downloaded by user', NULL),
(1018, 8, '', 26, '2026-01-07 14:17:44', NULL, 'Evidence file downloaded by user', NULL),
(1019, 7, '', 26, '2026-01-07 14:17:44', NULL, 'Evidence file downloaded by user', NULL),
(1020, 6, '', 26, '2026-01-07 14:17:45', NULL, 'Evidence file downloaded by user', NULL),
(1021, 10, '', 26, '2026-01-07 14:17:45', NULL, 'Evidence file downloaded by user', NULL),
(1022, 9, '', 26, '2026-01-07 14:17:45', NULL, 'Evidence file downloaded by user', NULL),
(1023, 1, '', 26, '2026-01-07 14:22:36', NULL, 'Evidence file downloaded by user', NULL),
(1024, 5, '', 26, '2026-01-07 14:22:37', NULL, 'Evidence file downloaded by user', NULL),
(1025, 4, '', 26, '2026-01-07 14:22:38', NULL, 'Evidence file downloaded by user', NULL),
(1026, 3, '', 26, '2026-01-07 14:22:38', NULL, 'Evidence file downloaded by user', NULL),
(1027, 2, '', 26, '2026-01-07 14:22:39', NULL, 'Evidence file downloaded by user', NULL),
(1028, 1, '', 26, '2026-01-07 14:22:40', NULL, 'Evidence file downloaded by user', NULL),
(1029, 5, '', 26, '2026-01-07 14:22:40', NULL, 'Evidence file downloaded by user', NULL),
(1030, 8, '', 26, '2026-01-07 14:22:40', NULL, 'Evidence file downloaded by user', NULL),
(1031, 7, '', 26, '2026-01-07 14:22:41', NULL, 'Evidence file downloaded by user', NULL),
(1032, 6, '', 26, '2026-01-07 14:22:41', NULL, 'Evidence file downloaded by user', NULL),
(1033, 10, '', 26, '2026-01-07 14:22:42', NULL, 'Evidence file downloaded by user', NULL),
(1034, 9, '', 26, '2026-01-07 14:22:43', NULL, 'Evidence file downloaded by user', NULL),
(1035, 4, '', 26, '2026-01-07 14:22:44', NULL, 'Evidence file downloaded by user', NULL),
(1036, 3, '', 26, '2026-01-07 14:22:45', NULL, 'Evidence file downloaded by user', NULL),
(1037, 2, '', 26, '2026-01-07 14:22:45', NULL, 'Evidence file downloaded by user', NULL),
(1038, 1, '', 26, '2026-01-07 14:22:46', NULL, 'Evidence file downloaded by user', NULL),
(1039, 5, '', 26, '2026-01-07 14:22:46', NULL, 'Evidence file downloaded by user', NULL),
(1040, 8, '', 26, '2026-01-07 14:22:47', NULL, 'Evidence file downloaded by user', NULL),
(1041, 7, '', 26, '2026-01-07 14:22:48', NULL, 'Evidence file downloaded by user', NULL),
(1042, 6, '', 26, '2026-01-07 14:22:48', NULL, 'Evidence file downloaded by user', NULL),
(1043, 10, '', 26, '2026-01-07 14:22:49', NULL, 'Evidence file downloaded by user', NULL),
(1044, 9, '', 26, '2026-01-07 14:22:50', NULL, 'Evidence file downloaded by user', NULL),
(1045, 9, '', 26, '2026-01-07 14:22:51', NULL, 'Evidence file downloaded by user', NULL),
(1046, 1, '', 26, '2026-01-07 14:26:31', NULL, 'Evidence file downloaded by user', NULL),
(1047, 5, '', 26, '2026-01-07 14:26:31', NULL, 'Evidence file downloaded by user', NULL),
(1048, 1, '', 26, '2026-01-07 14:27:39', NULL, 'Evidence file downloaded by user', NULL),
(1049, 4, '', 26, '2026-01-07 14:27:40', NULL, 'Evidence file downloaded by user', NULL),
(1050, 3, '', 26, '2026-01-07 14:27:41', NULL, 'Evidence file downloaded by user', NULL),
(1051, 2, '', 26, '2026-01-07 14:27:41', NULL, 'Evidence file downloaded by user', NULL),
(1052, 5, '', 26, '2026-01-07 14:27:42', NULL, 'Evidence file downloaded by user', NULL),
(1053, 8, '', 26, '2026-01-07 14:27:43', NULL, 'Evidence file downloaded by user', NULL),
(1054, 7, '', 26, '2026-01-07 14:27:43', NULL, 'Evidence file downloaded by user', NULL),
(1055, 6, '', 26, '2026-01-07 14:27:43', NULL, 'Evidence file downloaded by user', NULL),
(1056, 10, '', 26, '2026-01-07 14:27:44', NULL, 'Evidence file downloaded by user', NULL),
(1057, 9, '', 26, '2026-01-07 14:27:44', NULL, 'Evidence file downloaded by user', NULL),
(1058, 1, '', 26, '2026-01-07 14:27:45', NULL, 'Evidence file downloaded by user', NULL),
(1059, 4, '', 26, '2026-01-07 14:27:45', NULL, 'Evidence file downloaded by user', NULL),
(1060, 3, '', 26, '2026-01-07 14:27:45', NULL, 'Evidence file downloaded by user', NULL),
(1061, 2, '', 26, '2026-01-07 14:27:46', NULL, 'Evidence file downloaded by user', NULL),
(1062, 5, '', 26, '2026-01-07 14:27:46', NULL, 'Evidence file downloaded by user', NULL),
(1063, 8, '', 26, '2026-01-07 14:27:47', NULL, 'Evidence file downloaded by user', NULL),
(1064, 7, '', 26, '2026-01-07 14:27:47', NULL, 'Evidence file downloaded by user', NULL),
(1065, 6, '', 26, '2026-01-07 14:27:47', NULL, 'Evidence file downloaded by user', NULL),
(1066, 10, '', 26, '2026-01-07 14:27:48', NULL, 'Evidence file downloaded by user', NULL),
(1067, 9, '', 26, '2026-01-07 14:27:48', NULL, 'Evidence file downloaded by user', NULL),
(1068, 1, '', 26, '2026-01-07 14:27:49', NULL, 'Evidence file downloaded by user', NULL),
(1069, 5, '', 26, '2026-01-07 14:27:50', NULL, 'Evidence file downloaded by user', NULL),
(1070, 9, '', 26, '2026-01-07 14:27:52', NULL, 'Evidence file downloaded by user', NULL),
(1071, 1, '', 26, '2026-01-07 14:29:57', NULL, 'Evidence file downloaded by user', NULL),
(1072, 5, '', 26, '2026-01-07 14:29:58', NULL, 'Evidence file downloaded by user', NULL),
(1073, 4, '', 26, '2026-01-07 14:29:59', NULL, 'Evidence file downloaded by user', NULL),
(1074, 3, '', 26, '2026-01-07 14:29:59', NULL, 'Evidence file downloaded by user', NULL),
(1075, 2, '', 26, '2026-01-07 14:30:00', NULL, 'Evidence file downloaded by user', NULL),
(1076, 1, '', 26, '2026-01-07 14:30:01', NULL, 'Evidence file downloaded by user', NULL),
(1077, 5, '', 26, '2026-01-07 14:30:01', NULL, 'Evidence file downloaded by user', NULL),
(1078, 8, '', 26, '2026-01-07 14:30:02', NULL, 'Evidence file downloaded by user', NULL),
(1079, 7, '', 26, '2026-01-07 14:30:02', NULL, 'Evidence file downloaded by user', NULL),
(1080, 6, '', 26, '2026-01-07 14:30:03', NULL, 'Evidence file downloaded by user', NULL),
(1081, 10, '', 26, '2026-01-07 14:30:03', NULL, 'Evidence file downloaded by user', NULL),
(1082, 9, '', 26, '2026-01-07 14:30:04', NULL, 'Evidence file downloaded by user', NULL),
(1083, 4, '', 26, '2026-01-07 14:30:05', NULL, 'Evidence file downloaded by user', NULL),
(1084, 3, '', 26, '2026-01-07 14:30:05', NULL, 'Evidence file downloaded by user', NULL),
(1085, 2, '', 26, '2026-01-07 14:30:05', NULL, 'Evidence file downloaded by user', NULL),
(1086, 1, '', 26, '2026-01-07 14:30:06', NULL, 'Evidence file downloaded by user', NULL),
(1087, 5, '', 26, '2026-01-07 14:30:06', NULL, 'Evidence file downloaded by user', NULL),
(1088, 8, '', 26, '2026-01-07 14:30:07', NULL, 'Evidence file downloaded by user', NULL),
(1089, 7, '', 26, '2026-01-07 14:30:07', NULL, 'Evidence file downloaded by user', NULL),
(1090, 6, '', 26, '2026-01-07 14:30:08', NULL, 'Evidence file downloaded by user', NULL),
(1091, 10, '', 26, '2026-01-07 14:30:08', NULL, 'Evidence file downloaded by user', NULL),
(1092, 9, '', 26, '2026-01-07 14:30:08', NULL, 'Evidence file downloaded by user', NULL),
(1093, 9, '', 26, '2026-01-07 14:30:09', NULL, 'Evidence file downloaded by user', NULL),
(1094, 1, '', 26, '2026-01-07 14:31:24', NULL, 'Evidence file downloaded by user', NULL),
(1095, 5, '', 26, '2026-01-07 14:31:25', NULL, 'Evidence file downloaded by user', NULL),
(1096, 4, '', 26, '2026-01-07 14:31:26', NULL, 'Evidence file downloaded by user', NULL),
(1097, 3, '', 26, '2026-01-07 14:31:26', NULL, 'Evidence file downloaded by user', NULL),
(1098, 2, '', 26, '2026-01-07 14:31:27', NULL, 'Evidence file downloaded by user', NULL),
(1099, 1, '', 26, '2026-01-07 14:31:27', NULL, 'Evidence file downloaded by user', NULL),
(1100, 5, '', 26, '2026-01-07 14:31:28', NULL, 'Evidence file downloaded by user', NULL),
(1101, 8, '', 26, '2026-01-07 14:31:28', NULL, 'Evidence file downloaded by user', NULL),
(1102, 7, '', 26, '2026-01-07 14:31:29', NULL, 'Evidence file downloaded by user', NULL),
(1103, 6, '', 26, '2026-01-07 14:31:29', NULL, 'Evidence file downloaded by user', NULL),
(1104, 10, '', 26, '2026-01-07 14:31:29', NULL, 'Evidence file downloaded by user', NULL),
(1105, 9, '', 26, '2026-01-07 14:31:30', NULL, 'Evidence file downloaded by user', NULL),
(1106, 4, '', 26, '2026-01-07 14:31:31', NULL, 'Evidence file downloaded by user', NULL),
(1107, 3, '', 26, '2026-01-07 14:31:32', NULL, 'Evidence file downloaded by user', NULL),
(1108, 2, '', 26, '2026-01-07 14:31:32', NULL, 'Evidence file downloaded by user', NULL),
(1109, 1, '', 26, '2026-01-07 14:31:32', NULL, 'Evidence file downloaded by user', NULL),
(1110, 5, '', 26, '2026-01-07 14:31:33', NULL, 'Evidence file downloaded by user', NULL),
(1111, 8, '', 26, '2026-01-07 14:31:34', NULL, 'Evidence file downloaded by user', NULL),
(1112, 7, '', 26, '2026-01-07 14:31:34', NULL, 'Evidence file downloaded by user', NULL),
(1113, 6, '', 26, '2026-01-07 14:31:34', NULL, 'Evidence file downloaded by user', NULL),
(1114, 10, '', 26, '2026-01-07 14:31:35', NULL, 'Evidence file downloaded by user', NULL),
(1115, 9, '', 26, '2026-01-07 14:31:35', NULL, 'Evidence file downloaded by user', NULL),
(1116, 9, '', 26, '2026-01-07 14:31:37', NULL, 'Evidence file downloaded by user', NULL),
(1117, 1, '', 26, '2026-01-07 14:32:23', NULL, 'Evidence file downloaded by user', NULL),
(1118, 5, '', 26, '2026-01-07 14:32:24', NULL, 'Evidence file downloaded by user', NULL),
(1119, 9, '', 26, '2026-01-07 14:32:25', NULL, 'Evidence file downloaded by user', NULL),
(1120, 1, '', 26, '2026-01-07 14:32:49', NULL, 'Evidence file downloaded by user', NULL),
(1121, 5, '', 26, '2026-01-07 14:32:50', NULL, 'Evidence file downloaded by user', NULL),
(1122, 9, '', 26, '2026-01-07 14:32:51', NULL, 'Evidence file downloaded by user', NULL),
(1123, 1, '', 26, '2026-01-07 14:33:37', NULL, 'Evidence file downloaded by user', NULL),
(1124, 5, '', 26, '2026-01-07 14:33:38', NULL, 'Evidence file downloaded by user', NULL),
(1125, 9, '', 26, '2026-01-07 14:33:39', NULL, 'Evidence file downloaded by user', NULL),
(1126, 4, '', 26, '2026-01-07 14:34:27', NULL, 'Evidence file downloaded by user', NULL),
(1127, 3, '', 26, '2026-01-07 14:34:27', NULL, 'Evidence file downloaded by user', NULL),
(1128, 2, '', 26, '2026-01-07 14:34:28', NULL, 'Evidence file downloaded by user', NULL),
(1129, 8, '', 26, '2026-01-07 14:34:28', NULL, 'Evidence file downloaded by user', NULL),
(1130, 5, '', 26, '2026-01-07 14:34:28', NULL, 'Evidence file downloaded by user', NULL),
(1131, 1, '', 26, '2026-01-07 14:34:29', NULL, 'Evidence file downloaded by user', NULL),
(1132, 7, '', 26, '2026-01-07 14:34:29', NULL, 'Evidence file downloaded by user', NULL),
(1133, 6, '', 26, '2026-01-07 14:34:29', NULL, 'Evidence file downloaded by user', NULL);
INSERT INTO `evidence_custody_log` (`id`, `evidence_id`, `action`, `performed_by`, `performed_at`, `location`, `notes`, `witness_id`) VALUES
(1134, 10, '', 26, '2026-01-07 14:34:30', NULL, 'Evidence file downloaded by user', NULL),
(1135, 9, '', 26, '2026-01-07 14:34:30', NULL, 'Evidence file downloaded by user', NULL),
(1136, 4, '', 26, '2026-01-07 14:34:30', NULL, 'Evidence file downloaded by user', NULL),
(1137, 3, '', 26, '2026-01-07 14:34:31', NULL, 'Evidence file downloaded by user', NULL),
(1138, 2, '', 26, '2026-01-07 14:34:31', NULL, 'Evidence file downloaded by user', NULL),
(1139, 8, '', 26, '2026-01-07 14:34:31', NULL, 'Evidence file downloaded by user', NULL),
(1140, 5, '', 26, '2026-01-07 14:34:32', NULL, 'Evidence file downloaded by user', NULL),
(1141, 1, '', 26, '2026-01-07 14:34:32', NULL, 'Evidence file downloaded by user', NULL),
(1142, 7, '', 26, '2026-01-07 14:34:32', NULL, 'Evidence file downloaded by user', NULL),
(1143, 6, '', 26, '2026-01-07 14:34:33', NULL, 'Evidence file downloaded by user', NULL),
(1144, 10, '', 26, '2026-01-07 14:34:33', NULL, 'Evidence file downloaded by user', NULL),
(1145, 9, '', 26, '2026-01-07 14:34:33', NULL, 'Evidence file downloaded by user', NULL),
(1146, 1, '', 26, '2026-01-07 18:53:05', NULL, 'Evidence file downloaded by user', NULL),
(1147, 5, '', 26, '2026-01-07 18:53:06', NULL, 'Evidence file downloaded by user', NULL),
(1148, 9, '', 26, '2026-01-07 18:53:09', NULL, 'Evidence file downloaded by user', NULL),
(1149, 4, '', 26, '2026-01-07 18:56:20', NULL, 'Evidence file downloaded by user', NULL),
(1150, 3, '', 26, '2026-01-07 18:56:20', NULL, 'Evidence file downloaded by user', NULL),
(1151, 2, '', 26, '2026-01-07 18:56:21', NULL, 'Evidence file downloaded by user', NULL),
(1152, 1, '', 26, '2026-01-07 18:56:21', NULL, 'Evidence file downloaded by user', NULL),
(1153, 5, '', 26, '2026-01-07 18:56:22', NULL, 'Evidence file downloaded by user', NULL),
(1154, 8, '', 26, '2026-01-07 18:56:22', NULL, 'Evidence file downloaded by user', NULL),
(1155, 7, '', 26, '2026-01-07 18:56:22', NULL, 'Evidence file downloaded by user', NULL),
(1156, 6, '', 26, '2026-01-07 18:56:23', NULL, 'Evidence file downloaded by user', NULL),
(1157, 10, '', 26, '2026-01-07 18:56:23', NULL, 'Evidence file downloaded by user', NULL),
(1158, 9, '', 26, '2026-01-07 18:56:24', NULL, 'Evidence file downloaded by user', NULL),
(1159, 4, '', 26, '2026-01-07 18:56:24', NULL, 'Evidence file downloaded by user', NULL),
(1160, 3, '', 26, '2026-01-07 18:56:24', NULL, 'Evidence file downloaded by user', NULL),
(1161, 2, '', 26, '2026-01-07 18:56:25', NULL, 'Evidence file downloaded by user', NULL),
(1162, 1, '', 26, '2026-01-07 18:56:25', NULL, 'Evidence file downloaded by user', NULL),
(1163, 5, '', 26, '2026-01-07 18:56:26', NULL, 'Evidence file downloaded by user', NULL),
(1164, 8, '', 26, '2026-01-07 18:56:26', NULL, 'Evidence file downloaded by user', NULL),
(1165, 7, '', 26, '2026-01-07 18:56:27', NULL, 'Evidence file downloaded by user', NULL),
(1166, 6, '', 26, '2026-01-07 18:56:27', NULL, 'Evidence file downloaded by user', NULL),
(1167, 10, '', 26, '2026-01-07 18:56:27', NULL, 'Evidence file downloaded by user', NULL),
(1168, 9, '', 26, '2026-01-07 18:56:28', NULL, 'Evidence file downloaded by user', NULL),
(1169, 1, '', 26, '2026-01-07 18:57:06', NULL, 'Evidence file downloaded by user', NULL),
(1170, 5, '', 26, '2026-01-07 18:57:07', NULL, 'Evidence file downloaded by user', NULL),
(1171, 9, '', 26, '2026-01-07 18:57:08', NULL, 'Evidence file downloaded by user', NULL),
(1172, 4, '', 26, '2026-01-07 18:58:03', NULL, 'Evidence file downloaded by user', NULL),
(1173, 3, '', 26, '2026-01-07 18:58:03', NULL, 'Evidence file downloaded by user', NULL),
(1174, 2, '', 26, '2026-01-07 18:58:04', NULL, 'Evidence file downloaded by user', NULL),
(1175, 1, '', 26, '2026-01-07 18:58:04', NULL, 'Evidence file downloaded by user', NULL),
(1176, 5, '', 26, '2026-01-07 18:58:05', NULL, 'Evidence file downloaded by user', NULL),
(1177, 8, '', 26, '2026-01-07 18:58:05', NULL, 'Evidence file downloaded by user', NULL),
(1178, 7, '', 26, '2026-01-07 18:58:06', NULL, 'Evidence file downloaded by user', NULL),
(1179, 6, '', 26, '2026-01-07 18:58:06', NULL, 'Evidence file downloaded by user', NULL),
(1180, 10, '', 26, '2026-01-07 18:58:07', NULL, 'Evidence file downloaded by user', NULL),
(1181, 9, '', 26, '2026-01-07 18:58:07', NULL, 'Evidence file downloaded by user', NULL),
(1182, 4, '', 26, '2026-01-07 18:58:07', NULL, 'Evidence file downloaded by user', NULL),
(1183, 3, '', 26, '2026-01-07 18:58:08', NULL, 'Evidence file downloaded by user', NULL),
(1184, 2, '', 26, '2026-01-07 18:58:08', NULL, 'Evidence file downloaded by user', NULL),
(1185, 1, '', 26, '2026-01-07 18:58:09', NULL, 'Evidence file downloaded by user', NULL),
(1186, 5, '', 26, '2026-01-07 18:58:09', NULL, 'Evidence file downloaded by user', NULL),
(1187, 8, '', 26, '2026-01-07 18:58:10', NULL, 'Evidence file downloaded by user', NULL),
(1188, 7, '', 26, '2026-01-07 18:58:10', NULL, 'Evidence file downloaded by user', NULL),
(1189, 6, '', 26, '2026-01-07 18:58:11', NULL, 'Evidence file downloaded by user', NULL),
(1190, 10, '', 26, '2026-01-07 18:58:11', NULL, 'Evidence file downloaded by user', NULL),
(1191, 9, '', 26, '2026-01-07 18:58:11', NULL, 'Evidence file downloaded by user', NULL),
(1192, 1, '', 26, '2026-01-07 18:59:05', NULL, 'Evidence file downloaded by user', NULL),
(1193, 5, '', 26, '2026-01-07 18:59:06', NULL, 'Evidence file downloaded by user', NULL),
(1194, 4, '', 26, '2026-01-07 18:59:08', NULL, 'Evidence file downloaded by user', NULL),
(1195, 3, '', 26, '2026-01-07 18:59:09', NULL, 'Evidence file downloaded by user', NULL),
(1196, 2, '', 26, '2026-01-07 18:59:09', NULL, 'Evidence file downloaded by user', NULL),
(1197, 1, '', 26, '2026-01-07 18:59:10', NULL, 'Evidence file downloaded by user', NULL),
(1198, 5, '', 26, '2026-01-07 18:59:10', NULL, 'Evidence file downloaded by user', NULL),
(1199, 8, '', 26, '2026-01-07 18:59:10', NULL, 'Evidence file downloaded by user', NULL),
(1200, 7, '', 26, '2026-01-07 18:59:11', NULL, 'Evidence file downloaded by user', NULL),
(1201, 6, '', 26, '2026-01-07 18:59:11', NULL, 'Evidence file downloaded by user', NULL),
(1202, 10, '', 26, '2026-01-07 18:59:12', NULL, 'Evidence file downloaded by user', NULL),
(1203, 9, '', 26, '2026-01-07 18:59:12', NULL, 'Evidence file downloaded by user', NULL),
(1204, 4, '', 26, '2026-01-07 18:59:13', NULL, 'Evidence file downloaded by user', NULL),
(1205, 3, '', 26, '2026-01-07 18:59:13', NULL, 'Evidence file downloaded by user', NULL),
(1206, 2, '', 26, '2026-01-07 18:59:14', NULL, 'Evidence file downloaded by user', NULL),
(1207, 1, '', 26, '2026-01-07 18:59:14', NULL, 'Evidence file downloaded by user', NULL),
(1208, 5, '', 26, '2026-01-07 18:59:14', NULL, 'Evidence file downloaded by user', NULL),
(1209, 8, '', 26, '2026-01-07 18:59:15', NULL, 'Evidence file downloaded by user', NULL),
(1210, 7, '', 26, '2026-01-07 18:59:15', NULL, 'Evidence file downloaded by user', NULL),
(1211, 6, '', 26, '2026-01-07 18:59:16', NULL, 'Evidence file downloaded by user', NULL),
(1212, 10, '', 26, '2026-01-07 18:59:16', NULL, 'Evidence file downloaded by user', NULL),
(1213, 9, '', 26, '2026-01-07 18:59:17', NULL, 'Evidence file downloaded by user', NULL),
(1214, 9, '', 26, '2026-01-07 18:59:17', NULL, 'Evidence file downloaded by user', NULL),
(1215, 1, '', 26, '2026-01-10 11:48:22', NULL, 'Evidence file downloaded by user', NULL),
(1216, 5, '', 26, '2026-01-10 11:48:23', NULL, 'Evidence file downloaded by user', NULL),
(1217, 4, '', 26, '2026-01-10 11:48:25', NULL, 'Evidence file downloaded by user', NULL),
(1218, 3, '', 26, '2026-01-10 11:48:25', NULL, 'Evidence file downloaded by user', NULL),
(1219, 2, '', 26, '2026-01-10 11:48:25', NULL, 'Evidence file downloaded by user', NULL),
(1220, 1, '', 26, '2026-01-10 11:48:26', NULL, 'Evidence file downloaded by user', NULL),
(1221, 5, '', 26, '2026-01-10 11:48:26', NULL, 'Evidence file downloaded by user', NULL),
(1222, 8, '', 26, '2026-01-10 11:48:26', NULL, 'Evidence file downloaded by user', NULL),
(1223, 7, '', 26, '2026-01-10 11:48:27', NULL, 'Evidence file downloaded by user', NULL),
(1224, 6, '', 26, '2026-01-10 11:48:27', NULL, 'Evidence file downloaded by user', NULL),
(1225, 10, '', 26, '2026-01-10 11:48:27', NULL, 'Evidence file downloaded by user', NULL),
(1226, 9, '', 26, '2026-01-10 11:48:28', NULL, 'Evidence file downloaded by user', NULL),
(1227, 4, '', 26, '2026-01-10 11:48:28', NULL, 'Evidence file downloaded by user', NULL),
(1228, 3, '', 26, '2026-01-10 11:48:29', NULL, 'Evidence file downloaded by user', NULL),
(1229, 2, '', 26, '2026-01-10 11:48:29', NULL, 'Evidence file downloaded by user', NULL),
(1230, 1, '', 26, '2026-01-10 11:48:29', NULL, 'Evidence file downloaded by user', NULL),
(1231, 5, '', 26, '2026-01-10 11:48:30', NULL, 'Evidence file downloaded by user', NULL),
(1232, 8, '', 26, '2026-01-10 11:48:30', NULL, 'Evidence file downloaded by user', NULL),
(1233, 7, '', 26, '2026-01-10 11:48:30', NULL, 'Evidence file downloaded by user', NULL),
(1234, 6, '', 26, '2026-01-10 11:48:31', NULL, 'Evidence file downloaded by user', NULL),
(1235, 10, '', 26, '2026-01-10 11:48:31', NULL, 'Evidence file downloaded by user', NULL),
(1236, 9, '', 26, '2026-01-10 11:48:31', NULL, 'Evidence file downloaded by user', NULL),
(1237, 9, '', 26, '2026-01-10 11:48:32', NULL, 'Evidence file downloaded by user', NULL),
(1238, 1, '', 26, '2026-01-10 12:49:42', NULL, 'Evidence file downloaded by user', NULL),
(1239, 5, '', 26, '2026-01-10 12:49:43', NULL, 'Evidence file downloaded by user', NULL),
(1240, 9, '', 26, '2026-01-10 12:49:45', NULL, 'Evidence file downloaded by user', NULL),
(1241, 4, '', 26, '2026-01-10 12:49:46', NULL, 'Evidence file downloaded by user', NULL),
(1242, 3, '', 26, '2026-01-10 12:49:46', NULL, 'Evidence file downloaded by user', NULL),
(1243, 2, '', 26, '2026-01-10 12:49:47', NULL, 'Evidence file downloaded by user', NULL),
(1244, 1, '', 26, '2026-01-10 12:49:48', NULL, 'Evidence file downloaded by user', NULL),
(1245, 5, '', 26, '2026-01-10 12:49:48', NULL, 'Evidence file downloaded by user', NULL),
(1246, 8, '', 26, '2026-01-10 12:49:49', NULL, 'Evidence file downloaded by user', NULL),
(1247, 7, '', 26, '2026-01-10 12:49:49', NULL, 'Evidence file downloaded by user', NULL),
(1248, 6, '', 26, '2026-01-10 12:49:50', NULL, 'Evidence file downloaded by user', NULL),
(1249, 10, '', 26, '2026-01-10 12:49:51', NULL, 'Evidence file downloaded by user', NULL),
(1250, 9, '', 26, '2026-01-10 12:49:51', NULL, 'Evidence file downloaded by user', NULL),
(1251, 4, '', 26, '2026-01-10 12:49:52', NULL, 'Evidence file downloaded by user', NULL),
(1252, 3, '', 26, '2026-01-10 12:49:53', NULL, 'Evidence file downloaded by user', NULL),
(1253, 2, '', 26, '2026-01-10 12:49:53', NULL, 'Evidence file downloaded by user', NULL),
(1254, 1, '', 26, '2026-01-10 12:49:54', NULL, 'Evidence file downloaded by user', NULL),
(1255, 5, '', 26, '2026-01-10 12:49:54', NULL, 'Evidence file downloaded by user', NULL),
(1256, 8, '', 26, '2026-01-10 12:49:54', NULL, 'Evidence file downloaded by user', NULL),
(1257, 7, '', 26, '2026-01-10 12:49:55', NULL, 'Evidence file downloaded by user', NULL),
(1258, 6, '', 26, '2026-01-10 12:49:56', NULL, 'Evidence file downloaded by user', NULL),
(1259, 10, '', 26, '2026-01-10 12:49:56', NULL, 'Evidence file downloaded by user', NULL),
(1260, 9, '', 26, '2026-01-10 12:49:56', NULL, 'Evidence file downloaded by user', NULL),
(1261, 1, '', 26, '2026-01-10 13:26:23', NULL, 'Evidence file downloaded by user', NULL),
(1262, 5, '', 26, '2026-01-10 13:26:24', NULL, 'Evidence file downloaded by user', NULL),
(1263, 9, '', 26, '2026-01-10 13:26:25', NULL, 'Evidence file downloaded by user', NULL),
(1264, 1, '', 26, '2026-01-10 13:26:41', NULL, 'Evidence file downloaded by user', NULL),
(1265, 5, '', 26, '2026-01-10 13:26:42', NULL, 'Evidence file downloaded by user', NULL),
(1266, 9, '', 26, '2026-01-10 13:26:42', NULL, 'Evidence file downloaded by user', NULL),
(1267, 1, '', 26, '2026-01-10 13:28:20', NULL, 'Evidence file downloaded by user', NULL),
(1268, 5, '', 26, '2026-01-10 13:28:20', NULL, 'Evidence file downloaded by user', NULL),
(1269, 9, '', 26, '2026-01-10 13:28:21', NULL, 'Evidence file downloaded by user', NULL),
(1270, 1, '', 26, '2026-01-10 13:29:51', NULL, 'Evidence file downloaded by user', NULL),
(1271, 5, '', 26, '2026-01-10 13:29:51', NULL, 'Evidence file downloaded by user', NULL),
(1272, 9, '', 26, '2026-01-10 13:29:52', NULL, 'Evidence file downloaded by user', NULL),
(1273, 1, '', 26, '2026-01-10 13:30:58', NULL, 'Evidence file downloaded by user', NULL),
(1274, 5, '', 26, '2026-01-10 13:30:59', NULL, 'Evidence file downloaded by user', NULL),
(1275, 9, '', 26, '2026-01-10 13:30:59', NULL, 'Evidence file downloaded by user', NULL),
(1276, 1, '', 26, '2026-01-10 13:32:13', NULL, 'Evidence file downloaded by user', NULL),
(1277, 5, '', 26, '2026-01-10 13:32:13', NULL, 'Evidence file downloaded by user', NULL),
(1278, 9, '', 26, '2026-01-10 13:32:14', NULL, 'Evidence file downloaded by user', NULL),
(1279, 4, '', 26, '2026-01-10 13:32:15', NULL, 'Evidence file downloaded by user', NULL),
(1280, 3, '', 26, '2026-01-10 13:32:15', NULL, 'Evidence file downloaded by user', NULL),
(1281, 2, '', 26, '2026-01-10 13:32:15', NULL, 'Evidence file downloaded by user', NULL),
(1282, 1, '', 26, '2026-01-10 13:32:15', NULL, 'Evidence file downloaded by user', NULL),
(1283, 5, '', 26, '2026-01-10 13:32:15', NULL, 'Evidence file downloaded by user', NULL),
(1284, 8, '', 26, '2026-01-10 13:32:16', NULL, 'Evidence file downloaded by user', NULL),
(1285, 7, '', 26, '2026-01-10 13:32:16', NULL, 'Evidence file downloaded by user', NULL),
(1286, 6, '', 26, '2026-01-10 13:32:16', NULL, 'Evidence file downloaded by user', NULL),
(1287, 10, '', 26, '2026-01-10 13:32:16', NULL, 'Evidence file downloaded by user', NULL),
(1288, 9, '', 26, '2026-01-10 13:32:16', NULL, 'Evidence file downloaded by user', NULL),
(1289, 10, '', 26, '2026-01-10 13:32:17', NULL, 'Evidence file downloaded by user', NULL),
(1290, 9, '', 26, '2026-01-10 13:32:17', NULL, 'Evidence file downloaded by user', NULL),
(1291, 8, '', 26, '2026-01-10 13:32:17', NULL, 'Evidence file downloaded by user', NULL),
(1292, 7, '', 26, '2026-01-10 13:32:17', NULL, 'Evidence file downloaded by user', NULL),
(1293, 6, '', 26, '2026-01-10 13:32:18', NULL, 'Evidence file downloaded by user', NULL),
(1294, 5, '', 26, '2026-01-10 13:32:18', NULL, 'Evidence file downloaded by user', NULL),
(1295, 4, '', 26, '2026-01-10 13:32:18', NULL, 'Evidence file downloaded by user', NULL),
(1296, 3, '', 26, '2026-01-10 13:32:18', NULL, 'Evidence file downloaded by user', NULL),
(1297, 2, '', 26, '2026-01-10 13:32:19', NULL, 'Evidence file downloaded by user', NULL),
(1298, 1, '', 26, '2026-01-10 13:32:19', NULL, 'Evidence file downloaded by user', NULL),
(1299, 1, '', 26, '2026-01-10 13:36:33', NULL, 'Evidence file downloaded by user', NULL),
(1300, 5, '', 26, '2026-01-10 13:36:33', NULL, 'Evidence file downloaded by user', NULL),
(1301, 4, '', 26, '2026-01-10 13:36:34', NULL, 'Evidence file downloaded by user', NULL),
(1302, 3, '', 26, '2026-01-10 13:36:34', NULL, 'Evidence file downloaded by user', NULL),
(1303, 2, '', 26, '2026-01-10 13:36:34', NULL, 'Evidence file downloaded by user', NULL),
(1304, 1, '', 26, '2026-01-10 13:36:35', NULL, 'Evidence file downloaded by user', NULL),
(1305, 5, '', 26, '2026-01-10 13:36:35', NULL, 'Evidence file downloaded by user', NULL),
(1306, 8, '', 26, '2026-01-10 13:36:35', NULL, 'Evidence file downloaded by user', NULL),
(1307, 7, '', 26, '2026-01-10 13:36:35', NULL, 'Evidence file downloaded by user', NULL),
(1308, 6, '', 26, '2026-01-10 13:36:35', NULL, 'Evidence file downloaded by user', NULL),
(1309, 10, '', 26, '2026-01-10 13:36:35', NULL, 'Evidence file downloaded by user', NULL),
(1310, 9, '', 26, '2026-01-10 13:36:35', NULL, 'Evidence file downloaded by user', NULL),
(1311, 4, '', 26, '2026-01-10 13:36:36', NULL, 'Evidence file downloaded by user', NULL),
(1312, 3, '', 26, '2026-01-10 13:36:36', NULL, 'Evidence file downloaded by user', NULL),
(1313, 2, '', 26, '2026-01-10 13:36:36', NULL, 'Evidence file downloaded by user', NULL),
(1314, 1, '', 26, '2026-01-10 13:36:36', NULL, 'Evidence file downloaded by user', NULL),
(1315, 5, '', 26, '2026-01-10 13:36:36', NULL, 'Evidence file downloaded by user', NULL),
(1316, 8, '', 26, '2026-01-10 13:36:36', NULL, 'Evidence file downloaded by user', NULL),
(1317, 7, '', 26, '2026-01-10 13:36:37', NULL, 'Evidence file downloaded by user', NULL),
(1318, 6, '', 26, '2026-01-10 13:36:37', NULL, 'Evidence file downloaded by user', NULL),
(1319, 10, '', 26, '2026-01-10 13:36:37', NULL, 'Evidence file downloaded by user', NULL),
(1320, 9, '', 26, '2026-01-10 13:36:37', NULL, 'Evidence file downloaded by user', NULL),
(1321, 9, '', 26, '2026-01-10 13:36:37', NULL, 'Evidence file downloaded by user', NULL),
(1322, 1, '', 26, '2026-01-10 13:38:28', NULL, 'Evidence file downloaded by user', NULL),
(1323, 5, '', 26, '2026-01-10 13:38:28', NULL, 'Evidence file downloaded by user', NULL),
(1324, 9, '', 26, '2026-01-10 13:38:29', NULL, 'Evidence file downloaded by user', NULL),
(1325, 4, '', 26, '2026-01-10 13:38:30', NULL, 'Evidence file downloaded by user', NULL),
(1326, 3, '', 26, '2026-01-10 13:38:30', NULL, 'Evidence file downloaded by user', NULL),
(1327, 2, '', 26, '2026-01-10 13:38:30', NULL, 'Evidence file downloaded by user', NULL),
(1328, 1, '', 26, '2026-01-10 13:38:30', NULL, 'Evidence file downloaded by user', NULL),
(1329, 5, '', 26, '2026-01-10 13:38:31', NULL, 'Evidence file downloaded by user', NULL),
(1330, 8, '', 26, '2026-01-10 13:38:31', NULL, 'Evidence file downloaded by user', NULL),
(1331, 7, '', 26, '2026-01-10 13:38:31', NULL, 'Evidence file downloaded by user', NULL),
(1332, 6, '', 26, '2026-01-10 13:38:31', NULL, 'Evidence file downloaded by user', NULL),
(1333, 10, '', 26, '2026-01-10 13:38:31', NULL, 'Evidence file downloaded by user', NULL),
(1334, 9, '', 26, '2026-01-10 13:38:32', NULL, 'Evidence file downloaded by user', NULL),
(1335, 4, '', 26, '2026-01-10 13:38:32', NULL, 'Evidence file downloaded by user', NULL),
(1336, 3, '', 26, '2026-01-10 13:38:32', NULL, 'Evidence file downloaded by user', NULL),
(1337, 2, '', 26, '2026-01-10 13:38:32', NULL, 'Evidence file downloaded by user', NULL),
(1338, 1, '', 26, '2026-01-10 13:38:32', NULL, 'Evidence file downloaded by user', NULL),
(1339, 5, '', 26, '2026-01-10 13:38:33', NULL, 'Evidence file downloaded by user', NULL),
(1340, 8, '', 26, '2026-01-10 13:38:33', NULL, 'Evidence file downloaded by user', NULL),
(1341, 7, '', 26, '2026-01-10 13:38:33', NULL, 'Evidence file downloaded by user', NULL),
(1342, 6, '', 26, '2026-01-10 13:38:33', NULL, 'Evidence file downloaded by user', NULL),
(1343, 10, '', 26, '2026-01-10 13:38:33', NULL, 'Evidence file downloaded by user', NULL),
(1344, 9, '', 26, '2026-01-10 13:38:33', NULL, 'Evidence file downloaded by user', NULL),
(1345, 1, '', 26, '2026-01-10 13:39:55', NULL, 'Evidence file downloaded by user', NULL),
(1346, 4, '', 26, '2026-01-10 13:39:56', NULL, 'Evidence file downloaded by user', NULL),
(1347, 3, '', 26, '2026-01-10 13:39:56', NULL, 'Evidence file downloaded by user', NULL),
(1348, 2, '', 26, '2026-01-10 13:39:57', NULL, 'Evidence file downloaded by user', NULL),
(1349, 5, '', 26, '2026-01-10 13:39:57', NULL, 'Evidence file downloaded by user', NULL),
(1350, 8, '', 26, '2026-01-10 13:39:58', NULL, 'Evidence file downloaded by user', NULL),
(1351, 7, '', 26, '2026-01-10 13:39:59', NULL, 'Evidence file downloaded by user', NULL),
(1352, 6, '', 26, '2026-01-10 13:39:59', NULL, 'Evidence file downloaded by user', NULL),
(1353, 10, '', 26, '2026-01-10 13:40:00', NULL, 'Evidence file downloaded by user', NULL),
(1354, 9, '', 26, '2026-01-10 13:40:00', NULL, 'Evidence file downloaded by user', NULL),
(1355, 1, '', 26, '2026-01-10 13:40:01', NULL, 'Evidence file downloaded by user', NULL),
(1356, 4, '', 26, '2026-01-10 13:40:02', NULL, 'Evidence file downloaded by user', NULL),
(1357, 3, '', 26, '2026-01-10 13:40:02', NULL, 'Evidence file downloaded by user', NULL),
(1358, 2, '', 26, '2026-01-10 13:40:03', NULL, 'Evidence file downloaded by user', NULL),
(1359, 5, '', 26, '2026-01-10 13:40:04', NULL, 'Evidence file downloaded by user', NULL),
(1360, 8, '', 26, '2026-01-10 13:40:04', NULL, 'Evidence file downloaded by user', NULL),
(1361, 7, '', 26, '2026-01-10 13:40:05', NULL, 'Evidence file downloaded by user', NULL),
(1362, 6, '', 26, '2026-01-10 13:40:05', NULL, 'Evidence file downloaded by user', NULL),
(1363, 10, '', 26, '2026-01-10 13:40:06', NULL, 'Evidence file downloaded by user', NULL),
(1364, 9, '', 26, '2026-01-10 13:40:06', NULL, 'Evidence file downloaded by user', NULL),
(1365, 1, '', 26, '2026-01-10 13:40:08', NULL, 'Evidence file downloaded by user', NULL),
(1366, 5, '', 26, '2026-01-10 13:40:08', NULL, 'Evidence file downloaded by user', NULL),
(1367, 9, '', 26, '2026-01-10 13:40:10', NULL, 'Evidence file downloaded by user', NULL),
(1368, 1, '', 26, '2026-01-10 13:42:25', NULL, 'Evidence file downloaded by user', NULL),
(1369, 4, '', 26, '2026-01-10 13:42:26', NULL, 'Evidence file downloaded by user', NULL),
(1370, 3, '', 26, '2026-01-10 13:42:26', NULL, 'Evidence file downloaded by user', NULL),
(1371, 2, '', 26, '2026-01-10 13:42:27', NULL, 'Evidence file downloaded by user', NULL),
(1372, 5, '', 26, '2026-01-10 13:42:27', NULL, 'Evidence file downloaded by user', NULL),
(1373, 8, '', 26, '2026-01-10 13:42:28', NULL, 'Evidence file downloaded by user', NULL),
(1374, 7, '', 26, '2026-01-10 13:42:28', NULL, 'Evidence file downloaded by user', NULL),
(1375, 6, '', 26, '2026-01-10 13:42:28', NULL, 'Evidence file downloaded by user', NULL),
(1376, 10, '', 26, '2026-01-10 13:42:29', NULL, 'Evidence file downloaded by user', NULL),
(1377, 9, '', 26, '2026-01-10 13:42:29', NULL, 'Evidence file downloaded by user', NULL),
(1378, 1, '', 26, '2026-01-10 13:42:30', NULL, 'Evidence file downloaded by user', NULL),
(1379, 4, '', 26, '2026-01-10 13:42:30', NULL, 'Evidence file downloaded by user', NULL),
(1380, 3, '', 26, '2026-01-10 13:42:30', NULL, 'Evidence file downloaded by user', NULL),
(1381, 2, '', 26, '2026-01-10 13:42:31', NULL, 'Evidence file downloaded by user', NULL),
(1382, 5, '', 26, '2026-01-10 13:42:31', NULL, 'Evidence file downloaded by user', NULL),
(1383, 8, '', 26, '2026-01-10 13:42:32', NULL, 'Evidence file downloaded by user', NULL),
(1384, 7, '', 26, '2026-01-10 13:42:32', NULL, 'Evidence file downloaded by user', NULL),
(1385, 6, '', 26, '2026-01-10 13:42:32', NULL, 'Evidence file downloaded by user', NULL),
(1386, 10, '', 26, '2026-01-10 13:42:33', NULL, 'Evidence file downloaded by user', NULL),
(1387, 9, '', 26, '2026-01-10 13:42:33', NULL, 'Evidence file downloaded by user', NULL),
(1388, 1, '', 26, '2026-01-10 13:42:34', NULL, 'Evidence file downloaded by user', NULL),
(1389, 5, '', 26, '2026-01-10 13:42:34', NULL, 'Evidence file downloaded by user', NULL),
(1390, 9, '', 26, '2026-01-10 13:42:36', NULL, 'Evidence file downloaded by user', NULL),
(1391, 1, '', 26, '2026-01-10 13:43:55', NULL, 'Evidence file downloaded by user', NULL),
(1392, 4, '', 26, '2026-01-10 13:43:55', NULL, 'Evidence file downloaded by user', NULL),
(1393, 3, '', 26, '2026-01-10 13:43:55', NULL, 'Evidence file downloaded by user', NULL),
(1394, 2, '', 26, '2026-01-10 13:43:56', NULL, 'Evidence file downloaded by user', NULL),
(1395, 5, '', 26, '2026-01-10 13:43:56', NULL, 'Evidence file downloaded by user', NULL),
(1396, 8, '', 26, '2026-01-10 13:43:57', NULL, 'Evidence file downloaded by user', NULL),
(1397, 7, '', 26, '2026-01-10 13:43:57', NULL, 'Evidence file downloaded by user', NULL),
(1398, 6, '', 26, '2026-01-10 13:43:58', NULL, 'Evidence file downloaded by user', NULL),
(1399, 10, '', 26, '2026-01-10 13:43:58', NULL, 'Evidence file downloaded by user', NULL),
(1400, 9, '', 26, '2026-01-10 13:43:58', NULL, 'Evidence file downloaded by user', NULL),
(1401, 1, '', 26, '2026-01-10 13:43:59', NULL, 'Evidence file downloaded by user', NULL),
(1402, 4, '', 26, '2026-01-10 13:43:59', NULL, 'Evidence file downloaded by user', NULL),
(1403, 3, '', 26, '2026-01-10 13:44:00', NULL, 'Evidence file downloaded by user', NULL),
(1404, 2, '', 26, '2026-01-10 13:44:00', NULL, 'Evidence file downloaded by user', NULL),
(1405, 5, '', 26, '2026-01-10 13:44:00', NULL, 'Evidence file downloaded by user', NULL),
(1406, 8, '', 26, '2026-01-10 13:44:01', NULL, 'Evidence file downloaded by user', NULL),
(1407, 7, '', 26, '2026-01-10 13:44:01', NULL, 'Evidence file downloaded by user', NULL),
(1408, 6, '', 26, '2026-01-10 13:44:01', NULL, 'Evidence file downloaded by user', NULL),
(1409, 10, '', 26, '2026-01-10 13:44:02', NULL, 'Evidence file downloaded by user', NULL),
(1410, 9, '', 26, '2026-01-10 13:44:02', NULL, 'Evidence file downloaded by user', NULL),
(1411, 1, '', 26, '2026-01-10 13:44:03', NULL, 'Evidence file downloaded by user', NULL),
(1412, 5, '', 26, '2026-01-10 13:44:03', NULL, 'Evidence file downloaded by user', NULL),
(1413, 9, '', 26, '2026-01-10 13:44:05', NULL, 'Evidence file downloaded by user', NULL),
(1414, 1, '', 26, '2026-01-10 13:45:43', NULL, 'Evidence file downloaded by user', NULL),
(1415, 4, '', 26, '2026-01-10 13:45:44', NULL, 'Evidence file downloaded by user', NULL),
(1416, 3, '', 26, '2026-01-10 13:45:44', NULL, 'Evidence file downloaded by user', NULL),
(1417, 2, '', 26, '2026-01-10 13:45:45', NULL, 'Evidence file downloaded by user', NULL),
(1418, 5, '', 26, '2026-01-10 13:45:45', NULL, 'Evidence file downloaded by user', NULL),
(1419, 8, '', 26, '2026-01-10 13:45:46', NULL, 'Evidence file downloaded by user', NULL),
(1420, 7, '', 26, '2026-01-10 13:45:46', NULL, 'Evidence file downloaded by user', NULL),
(1421, 6, '', 26, '2026-01-10 13:45:46', NULL, 'Evidence file downloaded by user', NULL),
(1422, 10, '', 26, '2026-01-10 13:45:47', NULL, 'Evidence file downloaded by user', NULL),
(1423, 9, '', 26, '2026-01-10 13:45:47', NULL, 'Evidence file downloaded by user', NULL),
(1424, 1, '', 26, '2026-01-10 13:45:48', NULL, 'Evidence file downloaded by user', NULL),
(1425, 4, '', 26, '2026-01-10 13:45:48', NULL, 'Evidence file downloaded by user', NULL),
(1426, 3, '', 26, '2026-01-10 13:45:49', NULL, 'Evidence file downloaded by user', NULL),
(1427, 2, '', 26, '2026-01-10 13:45:49', NULL, 'Evidence file downloaded by user', NULL),
(1428, 5, '', 26, '2026-01-10 13:45:50', NULL, 'Evidence file downloaded by user', NULL),
(1429, 8, '', 26, '2026-01-10 13:45:50', NULL, 'Evidence file downloaded by user', NULL),
(1430, 7, '', 26, '2026-01-10 13:45:51', NULL, 'Evidence file downloaded by user', NULL),
(1431, 6, '', 26, '2026-01-10 13:45:51', NULL, 'Evidence file downloaded by user', NULL),
(1432, 10, '', 26, '2026-01-10 13:45:52', NULL, 'Evidence file downloaded by user', NULL),
(1433, 9, '', 26, '2026-01-10 13:45:52', NULL, 'Evidence file downloaded by user', NULL),
(1434, 1, '', 26, '2026-01-10 13:45:53', NULL, 'Evidence file downloaded by user', NULL),
(1435, 5, '', 26, '2026-01-10 13:45:53', NULL, 'Evidence file downloaded by user', NULL),
(1436, 9, '', 26, '2026-01-10 13:45:55', NULL, 'Evidence file downloaded by user', NULL),
(1437, 1, '', 26, '2026-01-10 13:48:06', NULL, 'Evidence file downloaded by user', NULL),
(1438, 4, '', 26, '2026-01-10 13:48:06', NULL, 'Evidence file downloaded by user', NULL),
(1439, 3, '', 26, '2026-01-10 13:48:07', NULL, 'Evidence file downloaded by user', NULL),
(1440, 2, '', 26, '2026-01-10 13:48:07', NULL, 'Evidence file downloaded by user', NULL),
(1441, 5, '', 26, '2026-01-10 13:48:08', NULL, 'Evidence file downloaded by user', NULL),
(1442, 8, '', 26, '2026-01-10 13:48:08', NULL, 'Evidence file downloaded by user', NULL),
(1443, 7, '', 26, '2026-01-10 13:48:08', NULL, 'Evidence file downloaded by user', NULL),
(1444, 6, '', 26, '2026-01-10 13:48:09', NULL, 'Evidence file downloaded by user', NULL),
(1445, 10, '', 26, '2026-01-10 13:48:09', NULL, 'Evidence file downloaded by user', NULL),
(1446, 9, '', 26, '2026-01-10 13:48:10', NULL, 'Evidence file downloaded by user', NULL),
(1447, 1, '', 26, '2026-01-10 13:48:11', NULL, 'Evidence file downloaded by user', NULL),
(1448, 4, '', 26, '2026-01-10 13:48:11', NULL, 'Evidence file downloaded by user', NULL),
(1449, 3, '', 26, '2026-01-10 13:48:11', NULL, 'Evidence file downloaded by user', NULL),
(1450, 2, '', 26, '2026-01-10 13:48:12', NULL, 'Evidence file downloaded by user', NULL),
(1451, 5, '', 26, '2026-01-10 13:48:12', NULL, 'Evidence file downloaded by user', NULL),
(1452, 8, '', 26, '2026-01-10 13:48:13', NULL, 'Evidence file downloaded by user', NULL),
(1453, 7, '', 26, '2026-01-10 13:48:13', NULL, 'Evidence file downloaded by user', NULL),
(1454, 6, '', 26, '2026-01-10 13:48:13', NULL, 'Evidence file downloaded by user', NULL),
(1455, 10, '', 26, '2026-01-10 13:48:14', NULL, 'Evidence file downloaded by user', NULL),
(1456, 9, '', 26, '2026-01-10 13:48:14', NULL, 'Evidence file downloaded by user', NULL),
(1457, 1, '', 26, '2026-01-10 13:48:15', NULL, 'Evidence file downloaded by user', NULL),
(1458, 5, '', 26, '2026-01-10 13:48:16', NULL, 'Evidence file downloaded by user', NULL),
(1459, 9, '', 26, '2026-01-10 13:48:17', NULL, 'Evidence file downloaded by user', NULL),
(1460, 1, '', 26, '2026-01-10 13:49:51', NULL, 'Evidence file downloaded by user', NULL),
(1461, 5, '', 26, '2026-01-10 13:49:52', NULL, 'Evidence file downloaded by user', NULL),
(1462, 4, '', 26, '2026-01-10 13:49:54', NULL, 'Evidence file downloaded by user', NULL),
(1463, 3, '', 26, '2026-01-10 13:49:54', NULL, 'Evidence file downloaded by user', NULL),
(1464, 2, '', 26, '2026-01-10 13:49:55', NULL, 'Evidence file downloaded by user', NULL),
(1465, 1, '', 26, '2026-01-10 13:49:55', NULL, 'Evidence file downloaded by user', NULL),
(1466, 5, '', 26, '2026-01-10 13:49:56', NULL, 'Evidence file downloaded by user', NULL),
(1467, 8, '', 26, '2026-01-10 13:49:56', NULL, 'Evidence file downloaded by user', NULL),
(1468, 7, '', 26, '2026-01-10 13:49:57', NULL, 'Evidence file downloaded by user', NULL),
(1469, 6, '', 26, '2026-01-10 13:49:57', NULL, 'Evidence file downloaded by user', NULL),
(1470, 10, '', 26, '2026-01-10 13:49:58', NULL, 'Evidence file downloaded by user', NULL),
(1471, 9, '', 26, '2026-01-10 13:49:58', NULL, 'Evidence file downloaded by user', NULL),
(1472, 4, '', 26, '2026-01-10 13:49:59', NULL, 'Evidence file downloaded by user', NULL),
(1473, 3, '', 26, '2026-01-10 13:49:59', NULL, 'Evidence file downloaded by user', NULL),
(1474, 2, '', 26, '2026-01-10 13:50:00', NULL, 'Evidence file downloaded by user', NULL),
(1475, 1, '', 26, '2026-01-10 13:50:00', NULL, 'Evidence file downloaded by user', NULL),
(1476, 5, '', 26, '2026-01-10 13:50:01', NULL, 'Evidence file downloaded by user', NULL),
(1477, 8, '', 26, '2026-01-10 13:50:01', NULL, 'Evidence file downloaded by user', NULL),
(1478, 7, '', 26, '2026-01-10 13:50:01', NULL, 'Evidence file downloaded by user', NULL),
(1479, 6, '', 26, '2026-01-10 13:50:02', NULL, 'Evidence file downloaded by user', NULL),
(1480, 10, '', 26, '2026-01-10 13:50:02', NULL, 'Evidence file downloaded by user', NULL),
(1481, 9, '', 26, '2026-01-10 13:50:02', NULL, 'Evidence file downloaded by user', NULL),
(1482, 9, '', 26, '2026-01-10 13:50:03', NULL, 'Evidence file downloaded by user', NULL),
(1483, 1, '', 26, '2026-01-10 13:52:10', NULL, 'Evidence file downloaded by user', NULL),
(1484, 5, '', 26, '2026-01-10 13:52:11', NULL, 'Evidence file downloaded by user', NULL),
(1485, 4, '', 26, '2026-01-10 13:52:11', NULL, 'Evidence file downloaded by user', NULL),
(1486, 3, '', 26, '2026-01-10 13:52:12', NULL, 'Evidence file downloaded by user', NULL),
(1487, 2, '', 26, '2026-01-10 13:52:12', NULL, 'Evidence file downloaded by user', NULL),
(1488, 1, '', 26, '2026-01-10 13:52:12', NULL, 'Evidence file downloaded by user', NULL),
(1489, 8, '', 26, '2026-01-10 13:52:13', NULL, 'Evidence file downloaded by user', NULL),
(1490, 7, '', 26, '2026-01-10 13:52:13', NULL, 'Evidence file downloaded by user', NULL),
(1491, 6, '', 26, '2026-01-10 13:52:13', NULL, 'Evidence file downloaded by user', NULL),
(1492, 10, '', 26, '2026-01-10 13:52:14', NULL, 'Evidence file downloaded by user', NULL),
(1493, 9, '', 26, '2026-01-10 13:52:14', NULL, 'Evidence file downloaded by user', NULL),
(1494, 5, '', 26, '2026-01-10 13:52:15', NULL, 'Evidence file downloaded by user', NULL),
(1495, 4, '', 26, '2026-01-10 13:52:16', NULL, 'Evidence file downloaded by user', NULL),
(1496, 3, '', 26, '2026-01-10 13:52:16', NULL, 'Evidence file downloaded by user', NULL),
(1497, 2, '', 26, '2026-01-10 13:52:17', NULL, 'Evidence file downloaded by user', NULL),
(1498, 1, '', 26, '2026-01-10 13:52:17', NULL, 'Evidence file downloaded by user', NULL),
(1499, 8, '', 26, '2026-01-10 13:52:18', NULL, 'Evidence file downloaded by user', NULL),
(1500, 7, '', 26, '2026-01-10 13:52:18', NULL, 'Evidence file downloaded by user', NULL),
(1501, 6, '', 26, '2026-01-10 13:52:18', NULL, 'Evidence file downloaded by user', NULL),
(1502, 10, '', 26, '2026-01-10 13:52:19', NULL, 'Evidence file downloaded by user', NULL),
(1503, 9, '', 26, '2026-01-10 13:52:19', NULL, 'Evidence file downloaded by user', NULL),
(1504, 5, '', 26, '2026-01-10 13:52:20', NULL, 'Evidence file downloaded by user', NULL),
(1505, 9, '', 26, '2026-01-10 13:52:21', NULL, 'Evidence file downloaded by user', NULL),
(1506, 1, '', 26, '2026-01-10 15:11:25', NULL, 'Evidence file downloaded by user', NULL),
(1507, 5, '', 26, '2026-01-10 15:11:26', NULL, 'Evidence file downloaded by user', NULL),
(1508, 9, '', 26, '2026-01-10 15:11:27', NULL, 'Evidence file downloaded by user', NULL),
(1509, 1, '', 26, '2026-01-10 15:14:31', NULL, 'Evidence file downloaded by user', NULL),
(1510, 5, '', 26, '2026-01-10 15:14:32', NULL, 'Evidence file downloaded by user', NULL),
(1511, 9, '', 26, '2026-01-10 15:14:33', NULL, 'Evidence file downloaded by user', NULL),
(1512, 1, '', 26, '2026-01-10 15:16:35', NULL, 'Evidence file downloaded by user', NULL),
(1513, 5, '', 26, '2026-01-10 15:16:36', NULL, 'Evidence file downloaded by user', NULL),
(1514, 9, '', 26, '2026-01-10 15:16:36', NULL, 'Evidence file downloaded by user', NULL),
(1515, 1, '', 26, '2026-01-10 15:17:11', NULL, 'Evidence file downloaded by user', NULL),
(1516, 5, '', 26, '2026-01-10 15:17:12', NULL, 'Evidence file downloaded by user', NULL),
(1517, 9, '', 26, '2026-01-10 15:17:14', NULL, 'Evidence file downloaded by user', NULL),
(1518, 1, '', 26, '2026-01-10 15:19:34', NULL, 'Evidence file downloaded by user', NULL),
(1519, 5, '', 26, '2026-01-10 15:19:35', NULL, 'Evidence file downloaded by user', NULL),
(1520, 9, '', 26, '2026-01-10 15:19:37', NULL, 'Evidence file downloaded by user', NULL),
(1521, 1, '', 26, '2026-01-10 15:23:53', NULL, 'Evidence file downloaded by user', NULL),
(1522, 5, '', 26, '2026-01-10 15:23:55', NULL, 'Evidence file downloaded by user', NULL),
(1523, 9, '', 26, '2026-01-10 15:23:56', NULL, 'Evidence file downloaded by user', NULL),
(1524, 1, '', 26, '2026-01-10 15:24:24', NULL, 'Evidence file downloaded by user', NULL),
(1525, 5, '', 26, '2026-01-10 15:24:24', NULL, 'Evidence file downloaded by user', NULL),
(1526, 9, '', 26, '2026-01-10 15:24:27', NULL, 'Evidence file downloaded by user', NULL),
(1527, 4, '', 26, '2026-01-10 15:24:40', NULL, 'Evidence file downloaded by user', NULL),
(1528, 3, '', 26, '2026-01-10 15:24:40', NULL, 'Evidence file downloaded by user', NULL),
(1529, 2, '', 26, '2026-01-10 15:24:41', NULL, 'Evidence file downloaded by user', NULL),
(1530, 1, '', 26, '2026-01-10 15:24:41', NULL, 'Evidence file downloaded by user', NULL),
(1531, 5, '', 26, '2026-01-10 15:24:42', NULL, 'Evidence file downloaded by user', NULL),
(1532, 8, '', 26, '2026-01-10 15:24:42', NULL, 'Evidence file downloaded by user', NULL),
(1533, 7, '', 26, '2026-01-10 15:24:42', NULL, 'Evidence file downloaded by user', NULL),
(1534, 6, '', 26, '2026-01-10 15:24:43', NULL, 'Evidence file downloaded by user', NULL),
(1535, 10, '', 26, '2026-01-10 15:24:43', NULL, 'Evidence file downloaded by user', NULL),
(1536, 9, '', 26, '2026-01-10 15:24:43', NULL, 'Evidence file downloaded by user', NULL),
(1537, 4, '', 26, '2026-01-10 15:24:43', NULL, 'Evidence file downloaded by user', NULL),
(1538, 3, '', 26, '2026-01-10 15:24:44', NULL, 'Evidence file downloaded by user', NULL),
(1539, 2, '', 26, '2026-01-10 15:24:44', NULL, 'Evidence file downloaded by user', NULL),
(1540, 1, '', 26, '2026-01-10 15:24:45', NULL, 'Evidence file downloaded by user', NULL),
(1541, 5, '', 26, '2026-01-10 15:24:45', NULL, 'Evidence file downloaded by user', NULL),
(1542, 8, '', 26, '2026-01-10 15:24:45', NULL, 'Evidence file downloaded by user', NULL),
(1543, 7, '', 26, '2026-01-10 15:24:45', NULL, 'Evidence file downloaded by user', NULL),
(1544, 6, '', 26, '2026-01-10 15:24:46', NULL, 'Evidence file downloaded by user', NULL),
(1545, 10, '', 26, '2026-01-10 15:24:46', NULL, 'Evidence file downloaded by user', NULL),
(1546, 9, '', 26, '2026-01-10 15:24:46', NULL, 'Evidence file downloaded by user', NULL),
(1547, 1, '', 26, '2026-01-10 15:27:59', NULL, 'Evidence file downloaded by user', NULL),
(1548, 5, '', 26, '2026-01-10 15:28:00', NULL, 'Evidence file downloaded by user', NULL),
(1549, 9, '', 26, '2026-01-10 15:28:02', NULL, 'Evidence file downloaded by user', NULL),
(1550, 4, '', 26, '2026-01-10 15:28:18', NULL, 'Evidence file downloaded by user', NULL),
(1551, 3, '', 26, '2026-01-10 15:28:19', NULL, 'Evidence file downloaded by user', NULL),
(1552, 2, '', 26, '2026-01-10 15:28:19', NULL, 'Evidence file downloaded by user', NULL),
(1553, 1, '', 26, '2026-01-10 15:28:19', NULL, 'Evidence file downloaded by user', NULL),
(1554, 5, '', 26, '2026-01-10 15:28:20', NULL, 'Evidence file downloaded by user', NULL),
(1555, 8, '', 26, '2026-01-10 15:28:20', NULL, 'Evidence file downloaded by user', NULL),
(1556, 7, '', 26, '2026-01-10 15:28:20', NULL, 'Evidence file downloaded by user', NULL),
(1557, 6, '', 26, '2026-01-10 15:28:21', NULL, 'Evidence file downloaded by user', NULL),
(1558, 10, '', 26, '2026-01-10 15:28:21', NULL, 'Evidence file downloaded by user', NULL),
(1559, 9, '', 26, '2026-01-10 15:28:21', NULL, 'Evidence file downloaded by user', NULL),
(1560, 4, '', 26, '2026-01-10 15:28:22', NULL, 'Evidence file downloaded by user', NULL),
(1561, 3, '', 26, '2026-01-10 15:28:22', NULL, 'Evidence file downloaded by user', NULL),
(1562, 2, '', 26, '2026-01-10 15:28:22', NULL, 'Evidence file downloaded by user', NULL),
(1563, 1, '', 26, '2026-01-10 15:28:23', NULL, 'Evidence file downloaded by user', NULL),
(1564, 5, '', 26, '2026-01-10 15:28:23', NULL, 'Evidence file downloaded by user', NULL),
(1565, 8, '', 26, '2026-01-10 15:28:24', NULL, 'Evidence file downloaded by user', NULL),
(1566, 7, '', 26, '2026-01-10 15:28:24', NULL, 'Evidence file downloaded by user', NULL),
(1567, 6, '', 26, '2026-01-10 15:28:24', NULL, 'Evidence file downloaded by user', NULL),
(1568, 10, '', 26, '2026-01-10 15:28:25', NULL, 'Evidence file downloaded by user', NULL),
(1569, 9, '', 26, '2026-01-10 15:28:25', NULL, 'Evidence file downloaded by user', NULL),
(1570, 1, '', 26, '2026-01-10 15:32:08', NULL, 'Evidence file downloaded by user', NULL),
(1571, 5, '', 26, '2026-01-10 15:32:09', NULL, 'Evidence file downloaded by user', NULL),
(1572, 9, '', 26, '2026-01-10 15:32:11', NULL, 'Evidence file downloaded by user', NULL),
(1573, 4, '', 26, '2026-01-10 15:32:38', NULL, 'Evidence file downloaded by user', NULL),
(1574, 3, '', 26, '2026-01-10 15:32:38', NULL, 'Evidence file downloaded by user', NULL),
(1575, 2, '', 26, '2026-01-10 15:32:39', NULL, 'Evidence file downloaded by user', NULL),
(1576, 1, '', 26, '2026-01-10 15:32:39', NULL, 'Evidence file downloaded by user', NULL),
(1577, 5, '', 26, '2026-01-10 15:32:39', NULL, 'Evidence file downloaded by user', NULL),
(1578, 8, '', 26, '2026-01-10 15:32:40', NULL, 'Evidence file downloaded by user', NULL),
(1579, 7, '', 26, '2026-01-10 15:32:40', NULL, 'Evidence file downloaded by user', NULL),
(1580, 6, '', 26, '2026-01-10 15:32:41', NULL, 'Evidence file downloaded by user', NULL),
(1581, 10, '', 26, '2026-01-10 15:32:41', NULL, 'Evidence file downloaded by user', NULL),
(1582, 9, '', 26, '2026-01-10 15:32:41', NULL, 'Evidence file downloaded by user', NULL),
(1583, 4, '', 26, '2026-01-10 15:32:42', NULL, 'Evidence file downloaded by user', NULL),
(1584, 3, '', 26, '2026-01-10 15:32:42', NULL, 'Evidence file downloaded by user', NULL),
(1585, 2, '', 26, '2026-01-10 15:32:42', NULL, 'Evidence file downloaded by user', NULL),
(1586, 1, '', 26, '2026-01-10 15:32:43', NULL, 'Evidence file downloaded by user', NULL),
(1587, 5, '', 26, '2026-01-10 15:32:43', NULL, 'Evidence file downloaded by user', NULL),
(1588, 8, '', 26, '2026-01-10 15:32:43', NULL, 'Evidence file downloaded by user', NULL),
(1589, 7, '', 26, '2026-01-10 15:32:44', NULL, 'Evidence file downloaded by user', NULL),
(1590, 6, '', 26, '2026-01-10 15:32:44', NULL, 'Evidence file downloaded by user', NULL),
(1591, 10, '', 26, '2026-01-10 15:32:44', NULL, 'Evidence file downloaded by user', NULL),
(1592, 9, '', 26, '2026-01-10 15:32:45', NULL, 'Evidence file downloaded by user', NULL),
(1593, 4, '', 26, '2026-01-10 15:35:28', NULL, 'Evidence file downloaded by user', NULL),
(1594, 3, '', 26, '2026-01-10 15:35:28', NULL, 'Evidence file downloaded by user', NULL),
(1595, 2, '', 26, '2026-01-10 15:35:29', NULL, 'Evidence file downloaded by user', NULL),
(1596, 1, '', 26, '2026-01-10 15:35:29', NULL, 'Evidence file downloaded by user', NULL),
(1597, 5, '', 26, '2026-01-10 15:35:29', NULL, 'Evidence file downloaded by user', NULL),
(1598, 8, '', 26, '2026-01-10 15:35:30', NULL, 'Evidence file downloaded by user', NULL),
(1599, 7, '', 26, '2026-01-10 15:35:30', NULL, 'Evidence file downloaded by user', NULL),
(1600, 6, '', 26, '2026-01-10 15:35:31', NULL, 'Evidence file downloaded by user', NULL),
(1601, 10, '', 26, '2026-01-10 15:35:31', NULL, 'Evidence file downloaded by user', NULL),
(1602, 9, '', 26, '2026-01-10 15:35:31', NULL, 'Evidence file downloaded by user', NULL),
(1603, 4, '', 26, '2026-01-10 15:35:31', NULL, 'Evidence file downloaded by user', NULL),
(1604, 3, '', 26, '2026-01-10 15:35:32', NULL, 'Evidence file downloaded by user', NULL),
(1605, 2, '', 26, '2026-01-10 15:35:32', NULL, 'Evidence file downloaded by user', NULL),
(1606, 1, '', 26, '2026-01-10 15:35:33', NULL, 'Evidence file downloaded by user', NULL),
(1607, 5, '', 26, '2026-01-10 15:35:33', NULL, 'Evidence file downloaded by user', NULL),
(1608, 8, '', 26, '2026-01-10 15:35:33', NULL, 'Evidence file downloaded by user', NULL),
(1609, 7, '', 26, '2026-01-10 15:35:34', NULL, 'Evidence file downloaded by user', NULL),
(1610, 6, '', 26, '2026-01-10 15:35:34', NULL, 'Evidence file downloaded by user', NULL),
(1611, 10, '', 26, '2026-01-10 15:35:34', NULL, 'Evidence file downloaded by user', NULL),
(1612, 9, '', 26, '2026-01-10 15:35:34', NULL, 'Evidence file downloaded by user', NULL),
(1613, 1, '', 26, '2026-01-10 15:40:20', NULL, 'Evidence file downloaded by user', NULL),
(1614, 5, '', 26, '2026-01-10 15:40:21', NULL, 'Evidence file downloaded by user', NULL),
(1615, 9, '', 26, '2026-01-10 15:40:23', NULL, 'Evidence file downloaded by user', NULL),
(1616, 1, '', 26, '2026-01-10 15:42:50', NULL, 'Evidence file downloaded by user', NULL),
(1617, 5, '', 26, '2026-01-10 15:42:51', NULL, 'Evidence file downloaded by user', NULL),
(1618, 9, '', 26, '2026-01-10 15:42:52', NULL, 'Evidence file downloaded by user', NULL),
(1619, 1, '', 26, '2026-01-10 15:46:09', NULL, 'Evidence file downloaded by user', NULL),
(1620, 5, '', 26, '2026-01-10 15:46:09', NULL, 'Evidence file downloaded by user', NULL),
(1621, 9, '', 26, '2026-01-10 15:46:10', NULL, 'Evidence file downloaded by user', NULL),
(1622, 1, '', 26, '2026-01-10 15:47:15', NULL, 'Evidence file downloaded by user', NULL),
(1623, 5, '', 26, '2026-01-10 15:47:15', NULL, 'Evidence file downloaded by user', NULL),
(1624, 9, '', 26, '2026-01-10 15:47:16', NULL, 'Evidence file downloaded by user', NULL),
(1625, 1, '', 26, '2026-01-10 15:48:37', NULL, 'Evidence file downloaded by user', NULL),
(1626, 5, '', 26, '2026-01-10 15:48:38', NULL, 'Evidence file downloaded by user', NULL),
(1627, 9, '', 26, '2026-01-10 15:48:38', NULL, 'Evidence file downloaded by user', NULL),
(1628, 1, '', 26, '2026-01-10 15:54:01', NULL, 'Evidence file downloaded by user', NULL),
(1629, 5, '', 26, '2026-01-10 15:54:01', NULL, 'Evidence file downloaded by user', NULL),
(1630, 9, '', 26, '2026-01-10 15:54:04', NULL, 'Evidence file downloaded by user', NULL),
(1631, 1, '', 26, '2026-01-10 15:58:43', NULL, 'Evidence file downloaded by user', NULL),
(1632, 5, '', 26, '2026-01-10 15:58:44', NULL, 'Evidence file downloaded by user', NULL),
(1633, 9, '', 26, '2026-01-10 15:58:46', NULL, 'Evidence file downloaded by user', NULL),
(1634, 1, '', 26, '2026-01-10 17:54:15', NULL, 'Evidence file downloaded by user', NULL),
(1635, 5, '', 26, '2026-01-10 17:54:16', NULL, 'Evidence file downloaded by user', NULL),
(1636, 9, '', 26, '2026-01-10 17:54:18', NULL, 'Evidence file downloaded by user', NULL),
(1637, 1, '', 26, '2026-01-10 18:02:46', NULL, 'Evidence file downloaded by user', NULL),
(1638, 5, '', 26, '2026-01-10 18:02:46', NULL, 'Evidence file downloaded by user', NULL),
(1639, 9, '', 26, '2026-01-10 18:02:49', NULL, 'Evidence file downloaded by user', NULL),
(1640, 1, '', 26, '2026-01-10 18:05:59', NULL, 'Evidence file downloaded by user', NULL),
(1641, 5, '', 26, '2026-01-10 18:05:59', NULL, 'Evidence file downloaded by user', NULL),
(1642, 9, '', 26, '2026-01-10 18:06:01', NULL, 'Evidence file downloaded by user', NULL),
(1643, 1, '', 26, '2026-01-10 18:13:21', NULL, 'Evidence file downloaded by user', NULL),
(1644, 5, '', 26, '2026-01-10 18:13:22', NULL, 'Evidence file downloaded by user', NULL),
(1645, 9, '', 26, '2026-01-10 18:13:24', NULL, 'Evidence file downloaded by user', NULL),
(1646, 1, '', 26, '2026-01-10 18:16:03', NULL, 'Evidence file downloaded by user', NULL),
(1647, 5, '', 26, '2026-01-10 18:16:04', NULL, 'Evidence file downloaded by user', NULL),
(1648, 9, '', 26, '2026-01-10 18:16:07', NULL, 'Evidence file downloaded by user', NULL),
(1649, 1, '', 26, '2026-01-10 18:19:15', NULL, 'Evidence file downloaded by user', NULL),
(1650, 5, '', 26, '2026-01-10 18:19:16', NULL, 'Evidence file downloaded by user', NULL),
(1651, 9, '', 26, '2026-01-10 18:19:19', NULL, 'Evidence file downloaded by user', NULL),
(1652, 1, '', 26, '2026-01-10 18:23:52', NULL, 'Evidence file downloaded by user', NULL),
(1653, 5, '', 26, '2026-01-10 18:23:53', NULL, 'Evidence file downloaded by user', NULL),
(1654, 9, '', 26, '2026-01-10 18:23:55', NULL, 'Evidence file downloaded by user', NULL),
(1655, 1, '', 26, '2026-01-10 18:28:20', NULL, 'Evidence file downloaded by user', NULL),
(1656, 5, '', 26, '2026-01-10 18:28:20', NULL, 'Evidence file downloaded by user', NULL),
(1657, 9, '', 26, '2026-01-10 18:28:22', NULL, 'Evidence file downloaded by user', NULL),
(1658, 1, '', 26, '2026-01-10 18:30:07', NULL, 'Evidence file downloaded by user', NULL),
(1659, 5, '', 26, '2026-01-10 18:30:08', NULL, 'Evidence file downloaded by user', NULL),
(1660, 9, '', 26, '2026-01-10 18:30:10', NULL, 'Evidence file downloaded by user', NULL),
(1661, 1, '', 26, '2026-01-10 18:35:12', NULL, 'Evidence file downloaded by user', NULL),
(1662, 5, '', 26, '2026-01-10 18:35:13', NULL, 'Evidence file downloaded by user', NULL),
(1663, 9, '', 26, '2026-01-10 18:35:15', NULL, 'Evidence file downloaded by user', NULL),
(1664, 1, '', 26, '2026-01-10 18:46:51', NULL, 'Evidence file downloaded by user', NULL),
(1665, 5, '', 26, '2026-01-10 18:46:52', NULL, 'Evidence file downloaded by user', NULL),
(1666, 9, '', 26, '2026-01-10 18:46:54', NULL, 'Evidence file downloaded by user', NULL),
(1667, 1, '', 26, '2026-01-10 18:49:33', NULL, 'Evidence file downloaded by user', NULL),
(1668, 5, '', 26, '2026-01-10 18:49:33', NULL, 'Evidence file downloaded by user', NULL),
(1669, 9, '', 26, '2026-01-10 18:49:35', NULL, 'Evidence file downloaded by user', NULL),
(1670, 1, '', 26, '2026-01-10 18:52:12', NULL, 'Evidence file downloaded by user', NULL),
(1671, 5, '', 26, '2026-01-10 18:52:13', NULL, 'Evidence file downloaded by user', NULL),
(1672, 9, '', 26, '2026-01-10 18:52:15', NULL, 'Evidence file downloaded by user', NULL),
(1673, 1, '', 26, '2026-01-10 18:56:04', NULL, 'Evidence file downloaded by user', NULL),
(1674, 5, '', 26, '2026-01-10 18:56:04', NULL, 'Evidence file downloaded by user', NULL),
(1675, 9, '', 26, '2026-01-10 18:56:07', NULL, 'Evidence file downloaded by user', NULL),
(1676, 1, '', 26, '2026-01-10 18:58:49', NULL, 'Evidence file downloaded by user', NULL),
(1677, 5, '', 26, '2026-01-10 18:58:50', NULL, 'Evidence file downloaded by user', NULL),
(1678, 9, '', 26, '2026-01-10 18:58:51', NULL, 'Evidence file downloaded by user', NULL),
(1679, 1, '', 26, '2026-01-10 19:01:03', NULL, 'Evidence file downloaded by user', NULL),
(1680, 5, '', 26, '2026-01-10 19:01:04', NULL, 'Evidence file downloaded by user', NULL),
(1681, 9, '', 26, '2026-01-10 19:01:06', NULL, 'Evidence file downloaded by user', NULL),
(1682, 1, '', 26, '2026-01-10 19:06:34', NULL, 'Evidence file downloaded by user', NULL),
(1683, 5, '', 26, '2026-01-10 19:06:35', NULL, 'Evidence file downloaded by user', NULL),
(1684, 9, '', 26, '2026-01-10 19:06:37', NULL, 'Evidence file downloaded by user', NULL),
(1685, 1, '', 26, '2026-01-10 19:09:08', NULL, 'Evidence file downloaded by user', NULL),
(1686, 5, '', 26, '2026-01-10 19:09:09', NULL, 'Evidence file downloaded by user', NULL),
(1687, 9, '', 26, '2026-01-10 19:09:10', NULL, 'Evidence file downloaded by user', NULL),
(1688, 1, '', 26, '2026-01-10 19:11:33', NULL, 'Evidence file downloaded by user', NULL),
(1689, 5, '', 26, '2026-01-10 19:11:33', NULL, 'Evidence file downloaded by user', NULL),
(1690, 9, '', 26, '2026-01-10 19:11:34', NULL, 'Evidence file downloaded by user', NULL),
(1691, 1, '', 26, '2026-01-10 19:14:27', NULL, 'Evidence file downloaded by user', NULL),
(1692, 5, '', 26, '2026-01-10 19:14:28', NULL, 'Evidence file downloaded by user', NULL),
(1693, 9, '', 26, '2026-01-10 19:14:30', NULL, 'Evidence file downloaded by user', NULL),
(1694, 1, '', 26, '2026-01-10 19:17:12', NULL, 'Evidence file downloaded by user', NULL),
(1695, 5, '', 26, '2026-01-10 19:17:13', NULL, 'Evidence file downloaded by user', NULL),
(1696, 9, '', 26, '2026-01-10 19:17:15', NULL, 'Evidence file downloaded by user', NULL),
(1697, 1, '', 26, '2026-01-10 19:19:44', NULL, 'Evidence file downloaded by user', NULL),
(1698, 5, '', 26, '2026-01-10 19:19:44', NULL, 'Evidence file downloaded by user', NULL),
(1699, 9, '', 26, '2026-01-10 19:19:47', NULL, 'Evidence file downloaded by user', NULL);
INSERT INTO `evidence_custody_log` (`id`, `evidence_id`, `action`, `performed_by`, `performed_at`, `location`, `notes`, `witness_id`) VALUES
(1700, 1, '', 26, '2026-01-10 19:21:42', NULL, 'Evidence file downloaded by user', NULL),
(1701, 5, '', 26, '2026-01-10 19:21:43', NULL, 'Evidence file downloaded by user', NULL),
(1702, 9, '', 26, '2026-01-10 19:21:46', NULL, 'Evidence file downloaded by user', NULL),
(1703, 1, '', 26, '2026-01-10 19:24:05', NULL, 'Evidence file downloaded by user', NULL),
(1704, 5, '', 26, '2026-01-10 19:24:06', NULL, 'Evidence file downloaded by user', NULL),
(1705, 9, '', 26, '2026-01-10 19:24:08', NULL, 'Evidence file downloaded by user', NULL),
(1706, 1, '', 26, '2026-01-10 19:26:41', NULL, 'Evidence file downloaded by user', NULL),
(1707, 5, '', 26, '2026-01-10 19:26:42', NULL, 'Evidence file downloaded by user', NULL),
(1708, 9, '', 26, '2026-01-10 19:26:44', NULL, 'Evidence file downloaded by user', NULL),
(1709, 1, '', 26, '2026-01-10 19:29:57', NULL, 'Evidence file downloaded by user', NULL),
(1710, 5, '', 26, '2026-01-10 19:29:59', NULL, 'Evidence file downloaded by user', NULL),
(1711, 9, '', 26, '2026-01-10 19:30:01', NULL, 'Evidence file downloaded by user', NULL),
(1712, 10, '', 26, '2026-01-11 14:42:09', NULL, 'Evidence file downloaded by user', NULL),
(1713, 1, '', 26, '2026-01-11 14:57:47', NULL, 'Evidence file downloaded by user', NULL),
(1714, 5, '', 26, '2026-01-11 14:57:48', NULL, 'Evidence file downloaded by user', NULL),
(1715, 9, '', 26, '2026-01-11 14:57:50', NULL, 'Evidence file downloaded by user', NULL),
(1716, 1, '', 26, '2026-01-11 15:16:32', NULL, 'Evidence file downloaded by user', NULL),
(1717, 5, '', 26, '2026-01-11 15:16:32', NULL, 'Evidence file downloaded by user', NULL),
(1718, 9, '', 26, '2026-01-11 15:16:33', NULL, 'Evidence file downloaded by user', NULL),
(1719, 1, '', 26, '2026-01-11 15:21:46', NULL, 'Evidence file downloaded by user', NULL),
(1720, 5, '', 26, '2026-01-11 15:21:46', NULL, 'Evidence file downloaded by user', NULL),
(1721, 9, '', 26, '2026-01-11 15:21:48', NULL, 'Evidence file downloaded by user', NULL),
(1722, 1, '', 26, '2026-01-11 15:25:44', NULL, 'Evidence file downloaded by user', NULL),
(1723, 5, '', 26, '2026-01-11 15:25:45', NULL, 'Evidence file downloaded by user', NULL),
(1724, 9, '', 26, '2026-01-11 15:25:46', NULL, 'Evidence file downloaded by user', NULL),
(1725, 1, '', 26, '2026-01-11 15:26:20', NULL, 'Evidence file downloaded by user', NULL),
(1726, 5, '', 26, '2026-01-11 15:26:21', NULL, 'Evidence file downloaded by user', NULL),
(1727, 9, '', 26, '2026-01-11 15:26:24', NULL, 'Evidence file downloaded by user', NULL),
(1728, 11, 'collected', 30, '2026-01-12 18:10:53', NULL, 'Evidence collected and uploaded to system', NULL),
(1729, 11, '', 30, '2026-01-12 18:10:56', NULL, 'Evidence file downloaded by user', NULL),
(1730, 11, '', 30, '2026-01-12 18:12:35', NULL, 'Evidence file downloaded by user', NULL),
(1731, 11, '', 30, '2026-01-12 18:18:13', NULL, 'Evidence file downloaded by user', NULL),
(1732, 11, '', 30, '2026-01-12 18:21:02', NULL, 'Evidence file downloaded by user', NULL),
(1733, 11, '', 30, '2026-01-12 18:25:01', NULL, 'Evidence file downloaded by user', NULL),
(1734, 11, '', 30, '2026-01-12 18:31:24', NULL, 'Evidence file downloaded by user', NULL),
(1735, 11, '', 30, '2026-01-12 18:48:18', NULL, 'Evidence file downloaded by user', NULL),
(1736, 1, '', 26, '2026-01-14 15:26:36', NULL, 'Evidence file downloaded by user', NULL),
(1737, 5, '', 26, '2026-01-14 15:26:38', NULL, 'Evidence file downloaded by user', NULL),
(1738, 9, '', 26, '2026-01-14 15:26:41', NULL, 'Evidence file downloaded by user', NULL),
(1739, 1, '', 26, '2026-01-14 15:36:42', NULL, 'Evidence file downloaded by user', NULL),
(1740, 5, '', 26, '2026-01-14 15:36:43', NULL, 'Evidence file downloaded by user', NULL),
(1741, 9, '', 26, '2026-01-14 15:36:46', NULL, 'Evidence file downloaded by user', NULL),
(1742, 1, '', 26, '2026-01-14 15:38:47', NULL, 'Evidence file downloaded by user', NULL),
(1743, 5, '', 26, '2026-01-14 15:38:48', NULL, 'Evidence file downloaded by user', NULL),
(1744, 9, '', 26, '2026-01-14 15:38:51', NULL, 'Evidence file downloaded by user', NULL),
(1745, 1, '', 26, '2026-01-14 15:42:40', NULL, 'Evidence file downloaded by user', NULL),
(1746, 5, '', 26, '2026-01-14 15:42:40', NULL, 'Evidence file downloaded by user', NULL),
(1747, 9, '', 26, '2026-01-14 15:42:41', NULL, 'Evidence file downloaded by user', NULL),
(1748, 1, '', 26, '2026-01-14 15:44:54', NULL, 'Evidence file downloaded by user', NULL),
(1749, 5, '', 26, '2026-01-14 15:44:55', NULL, 'Evidence file downloaded by user', NULL),
(1750, 9, '', 26, '2026-01-14 15:44:57', NULL, 'Evidence file downloaded by user', NULL),
(1751, 1, '', 26, '2026-01-14 15:48:47', NULL, 'Evidence file downloaded by user', NULL),
(1752, 5, '', 26, '2026-01-14 15:48:47', NULL, 'Evidence file downloaded by user', NULL),
(1753, 9, '', 26, '2026-01-14 15:48:48', NULL, 'Evidence file downloaded by user', NULL),
(1754, 1, '', 26, '2026-01-14 15:49:06', NULL, 'Evidence file downloaded by user', NULL),
(1755, 5, '', 26, '2026-01-14 15:49:07', NULL, 'Evidence file downloaded by user', NULL),
(1756, 9, '', 26, '2026-01-14 15:49:10', NULL, 'Evidence file downloaded by user', NULL),
(1757, 1, '', 26, '2026-01-14 15:51:14', NULL, 'Evidence file downloaded by user', NULL),
(1758, 5, '', 26, '2026-01-14 15:51:15', NULL, 'Evidence file downloaded by user', NULL),
(1759, 9, '', 26, '2026-01-14 15:51:15', NULL, 'Evidence file downloaded by user', NULL),
(1760, 1, '', 26, '2026-01-14 15:53:18', NULL, 'Evidence file downloaded by user', NULL),
(1761, 5, '', 26, '2026-01-14 15:53:20', NULL, 'Evidence file downloaded by user', NULL),
(1762, 9, '', 26, '2026-01-14 15:53:21', NULL, 'Evidence file downloaded by user', NULL),
(1763, 1, '', 26, '2026-01-14 15:57:32', NULL, 'Evidence file downloaded by user', NULL),
(1764, 5, '', 26, '2026-01-14 15:57:33', NULL, 'Evidence file downloaded by user', NULL),
(1765, 9, '', 26, '2026-01-14 15:57:34', NULL, 'Evidence file downloaded by user', NULL),
(1766, 1, '', 26, '2026-01-14 16:03:55', NULL, 'Evidence file downloaded by user', NULL),
(1767, 5, '', 26, '2026-01-14 16:03:56', NULL, 'Evidence file downloaded by user', NULL),
(1768, 9, '', 26, '2026-01-14 16:03:57', NULL, 'Evidence file downloaded by user', NULL),
(1769, 1, '', 26, '2026-01-14 16:14:43', NULL, 'Evidence file downloaded by user', NULL),
(1770, 5, '', 26, '2026-01-14 16:14:43', NULL, 'Evidence file downloaded by user', NULL),
(1771, 9, '', 26, '2026-01-14 16:14:46', NULL, 'Evidence file downloaded by user', NULL),
(1772, 1, '', 26, '2026-01-14 16:21:35', NULL, 'Evidence file downloaded by user', NULL),
(1773, 5, '', 26, '2026-01-14 16:21:36', NULL, 'Evidence file downloaded by user', NULL),
(1774, 9, '', 26, '2026-01-14 16:21:52', NULL, 'Evidence file downloaded by user', NULL),
(1775, 1, '', 26, '2026-01-14 16:28:51', NULL, 'Evidence file downloaded by user', NULL),
(1776, 5, '', 26, '2026-01-14 16:28:52', NULL, 'Evidence file downloaded by user', NULL),
(1777, 9, '', 26, '2026-01-14 16:28:54', NULL, 'Evidence file downloaded by user', NULL),
(1778, 1, '', 26, '2026-01-14 16:33:48', NULL, 'Evidence file downloaded by user', NULL),
(1779, 5, '', 26, '2026-01-14 16:33:49', NULL, 'Evidence file downloaded by user', NULL),
(1780, 5, '', 26, '2026-01-14 22:05:30', NULL, 'Evidence file downloaded by user', NULL),
(1781, 9, '', 26, '2026-01-14 22:05:32', NULL, 'Evidence file downloaded by user', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `evidence_edit_history`
--

CREATE TABLE `evidence_edit_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `evidence_id` int(10) UNSIGNED NOT NULL,
  `edited_by` int(10) UNSIGNED NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `old_value` text DEFAULT NULL,
  `old_file_path` varchar(500) DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `new_file_path` varchar(500) DEFAULT NULL,
  `edited_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `evidence_edit_history`
--

INSERT INTO `evidence_edit_history` (`id`, `evidence_id`, `edited_by`, `field_name`, `old_value`, `old_file_path`, `new_value`, `new_file_path`, `edited_at`) VALUES
(1, 1, 26, 'file_name', 'WhatsApp Image 2025-11-12 at 00.25.23 (1).jpeg', NULL, 'WhatsApp Image 2025-11-12 at 00.30.13.jpeg', NULL, '2025-12-31 08:17:23'),
(2, 1, 26, 'file_path', 'evidence/2025/10/1767174873_2f370d1132e70796cf2d.jpeg.enc', NULL, 'evidence/2025/10/1767179843_37be3a61b0d14a993b41.jpeg.enc', NULL, '2025-12-31 08:17:23'),
(3, 1, 26, 'file_size', '57794', NULL, '66926', NULL, '2025-12-31 08:17:23'),
(4, 1, 26, 'file_name', 'WhatsApp Image 2025-11-12 at 00.30.13.jpeg', 'evidence/2025/10/1767179843_37be3a61b0d14a993b41.jpeg.enc', 'sidebar-logo-20251218120613.jpeg', 'evidence/2025/10/1767190051_53197c783f209dbc5b27.jpeg.enc', '2025-12-31 11:07:31'),
(5, 1, 26, 'file_path', 'evidence/2025/10/1767179843_37be3a61b0d14a993b41.jpeg.enc', 'evidence/2025/10/1767179843_37be3a61b0d14a993b41.jpeg.enc', 'evidence/2025/10/1767190051_53197c783f209dbc5b27.jpeg.enc', 'evidence/2025/10/1767190051_53197c783f209dbc5b27.jpeg.enc', '2025-12-31 11:07:31'),
(6, 1, 26, 'file_size', '66926', NULL, '52996', NULL, '2025-12-31 11:07:31'),
(7, 1, 26, 'file_name', 'sidebar-logo-20251218120613.jpeg', 'evidence/2025/10/1767190051_53197c783f209dbc5b27.jpeg.enc', 'licensed-image.jpg', 'evidence/2025/10/1767190176_19c17dda3c79fba9a587.jpg.enc', '2025-12-31 11:09:36'),
(8, 1, 26, 'file_path', 'evidence/2025/10/1767190051_53197c783f209dbc5b27.jpeg.enc', 'evidence/2025/10/1767190051_53197c783f209dbc5b27.jpeg.enc', 'evidence/2025/10/1767190176_19c17dda3c79fba9a587.jpg.enc', 'evidence/2025/10/1767190176_19c17dda3c79fba9a587.jpg.enc', '2025-12-31 11:09:36'),
(9, 1, 26, 'file_size', '52996', NULL, '274167', NULL, '2025-12-31 11:09:36'),
(10, 1, 26, 'file_name', 'licensed-image.jpg', 'evidence/2025/10/1767190176_19c17dda3c79fba9a587.jpg.enc', 'WhatsApp Image 2025-11-12 at 00.09.15 (1).jpeg', 'evidence/2025/10/1767190362_2d8c3c9eef92b8ac7374.jpeg.enc', '2025-12-31 11:12:42'),
(11, 1, 26, 'file_path', 'evidence/2025/10/1767190176_19c17dda3c79fba9a587.jpg.enc', 'evidence/2025/10/1767190176_19c17dda3c79fba9a587.jpg.enc', 'evidence/2025/10/1767190362_2d8c3c9eef92b8ac7374.jpeg.enc', 'evidence/2025/10/1767190362_2d8c3c9eef92b8ac7374.jpeg.enc', '2025-12-31 11:12:42'),
(12, 1, 26, 'file_size', '274167', NULL, '50455', NULL, '2025-12-31 11:12:42');

-- --------------------------------------------------------

--
-- Table structure for table `evidence_file_versions`
--

CREATE TABLE `evidence_file_versions` (
  `id` int(10) UNSIGNED NOT NULL,
  `evidence_id` int(10) UNSIGNED NOT NULL,
  `version_number` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `file_size` int(10) UNSIGNED DEFAULT NULL,
  `replaced_by` int(10) UNSIGNED DEFAULT NULL,
  `replaced_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `evidence_file_versions`
--

INSERT INTO `evidence_file_versions` (`id`, `evidence_id`, `version_number`, `file_name`, `file_path`, `file_type`, `file_size`, `replaced_by`, `replaced_at`, `notes`) VALUES
(1, 1, 1, 'WhatsApp Image 2025-11-12 at 00.30.13.jpeg', 'evidence/versions/1/v1_1767179843_37be3a61b0d14a993b41.jpeg.enc', 'image/jpeg', 66926, 26, '2025-12-31 14:07:31', 'Replaced with: sidebar-logo-20251218120613.jpeg'),
(2, 1, 2, 'sidebar-logo-20251218120613.jpeg', 'evidence/versions/1/v2_1767190051_53197c783f209dbc5b27.jpeg.enc', 'image/jpeg', 52996, 26, '2025-12-31 14:09:36', 'Replaced with: licensed-image.jpg'),
(3, 1, 3, 'licensed-image.jpg', 'evidence/versions/1/v3_1767190176_19c17dda3c79fba9a587.jpg.enc', 'image/jpeg', 274167, 26, '2025-12-31 14:12:42', 'Replaced with: WhatsApp Image 2025-11-12 at 00.09.15 (1).jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `file_encryption_registry`
--

CREATE TABLE `file_encryption_registry` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `encryption_algorithm` varchar(50) DEFAULT 'AES-256-CBC',
  `encryption_key_hash` varchar(64) NOT NULL COMMENT 'Hash of the encryption key',
  `iv` varchar(32) NOT NULL COMMENT 'Initialization vector',
  `access_level` enum('public','internal','restricted','confidential','top_secret') DEFAULT 'internal',
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investigation_notes`
--

CREATE TABLE `investigation_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `person_id` int(10) UNSIGNED NOT NULL,
  `investigator_id` int(10) UNSIGNED NOT NULL,
  `note_type` enum('investigation','statement','observation','interview') DEFAULT 'investigation',
  `note_text` text NOT NULL,
  `is_edited` tinyint(1) DEFAULT 0,
  `last_edited_at` timestamp NULL DEFAULT NULL,
  `last_edited_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `investigation_notes`
--

INSERT INTO `investigation_notes` (`id`, `case_id`, `person_id`, `investigator_id`, `note_type`, `note_text`, `is_edited`, `last_edited_at`, `last_edited_by`, `created_at`, `updated_at`) VALUES
(1, 10, 13, 26, 'investigation', 'waan badalay', 1, '2025-12-31 06:47:18', 26, '2025-12-31 06:30:39', '2025-12-31 06:47:18'),
(2, 10, 13, 26, 'investigation', 'hdfjsdsdf', 0, NULL, NULL, '2025-12-31 06:30:41', '2025-12-31 06:30:41'),
(3, 10, 13, 26, 'investigation', 'dfgdfgdfg', 0, NULL, NULL, '2025-12-31 06:30:48', '2025-12-31 06:30:48'),
(4, 10, 13, 26, 'investigation', 'dfgdfgdfg', 0, NULL, NULL, '2025-12-31 06:30:50', '2025-12-31 06:30:50'),
(5, 10, 12, 26, 'statement', 'ccfdfgsdf', 0, NULL, NULL, '2025-12-31 11:42:00', '2025-12-31 11:42:00'),
(6, 10, 14, 26, 'investigation', 'bxndc', 0, NULL, NULL, '2025-12-31 16:49:09', '2025-12-31 16:49:09'),
(7, 10, 15, 26, 'statement', 'hdhdhd', 0, NULL, NULL, '2025-12-31 16:51:03', '2025-12-31 16:51:03'),
(8, 10, 18, 26, 'statement', 'dddfdfsddxccgsdfgsdfgdf', 1, '2025-12-31 17:26:54', 26, '2025-12-31 17:26:43', '2025-12-31 17:26:54'),
(9, 10, 18, 26, 'statement', '[AUDIO_STATEMENT:7] Audio statement recorded on 12/31/2025, 11:38:16 PM', 0, NULL, NULL, '2025-12-31 17:38:16', '2025-12-31 17:38:16'),
(10, 10, 18, 26, 'statement', '[AUDIO_STATEMENT:8] Audio statement recorded on 12/31/2025, 11:39:47 PM', 0, NULL, NULL, '2025-12-31 17:39:48', '2025-12-31 17:39:48'),
(11, 10, 19, 26, 'statement', 'GGGGHHHHH', 0, NULL, NULL, '2025-12-31 17:44:45', '2025-12-31 17:44:45'),
(12, 10, 19, 26, 'statement', '[AUDIO_STATEMENT:10] Audio statement recorded on 12/31/2025, 11:45:08 PM', 0, NULL, NULL, '2025-12-31 17:45:08', '2025-12-31 17:45:08'),
(13, 10, 18, 26, 'statement', 'dfhjhgfd', 0, NULL, NULL, '2026-01-07 12:57:58', '2026-01-07 12:57:58'),
(14, 10, 13, 26, 'investigation', 'Waxaa lagula talinayaa in dambiilaha si rasmi ah loo soo ooggo dacwad, iyadoo la raacayo caddaymaha la helay. Waxaa sidoo kale muhiim ah in la sii wado baaritaanno dheeraad ah si loo xaqiijiyo dhammaan xogo muhiim ah oo ku saabsan dhacdada, sida suurtagalnimada in ay jiraan dambiilayaal kale oo ku lug leh. Caddaymaha waa in si ammaan ah loo keydiyaa laguna diiwaangeliyo si loo fududeeyo dacwadda sharciga.\n\nWaxaa sidoo kale lagula talinayaa in la sameeyo warbixin buuxda oo loogu talagalay saraakiisha sharciga si ay u fahmaan dhammaan xaqiiqooyinka la helay iyo sida ay caddaymaha u taageerayaan dacwadda.', 0, NULL, NULL, '2026-01-10 13:27:49', '2026-01-10 13:27:49'),
(15, 10, 14, 26, 'investigation', 'Waxaa lagula talinayaa in dambiilaha si rasmi ah loo soo ooggo dacwad, iyadoo la raacayo caddaymaha la helay. Waxaa sidoo kale muhiim ah in la sii wado baaritaanno dheeraad ah si loo xaqiijiyo dhammaan xogo muhiim ah oo ku saabsan dhacdada, sida suurtagalnimada in ay jiraan dambiilayaal kale oo ku lug leh. Caddaymaha waa in si ammaan ah loo keydiyaa laguna diiwaangeliyo si loo fududeeyo dacwadda sharciga.\n\nWaxaa sidoo kale lagula talinayaa in la sameeyo warbixin buuxda oo loogu talagalay saraakiisha sharciga si ay u fahmaan dhammaan xaqiiqooyinka la helay iyo sida ay caddaymaha u taageerayaan dacwadda.', 0, NULL, NULL, '2026-01-10 13:27:57', '2026-01-10 13:27:57'),
(16, 10, 12, 26, 'statement', 'Waxaa lagula talinayaa in dambiilaha si rasmi ah loo soo ooggo dacwad, iyadoo la raacayo caddaymaha la helay. Waxaa sidoo kale muhiim ah in la sii wado baaritaanno dheeraad ah si loo xaqiijiyo dhammaan xogo muhiim ah oo ku saabsan dhacdada, sida suurtagalnimada in ay jiraan dambiilayaal kale oo ku lug leh. Caddaymaha waa in si ammaan ah loo keydiyaa laguna diiwaangeliyo si loo fududeeyo dacwadda sharciga.\n\nWaxaa sidoo kale lagula talinayaa in la sameeyo warbixin buuxda oo loogu talagalay saraakiisha sharciga si ay u fahmaan dhammaan xaqiiqooyinka la helay iyo sida ay caddaymaha u taageerayaan dacwadda.', 0, NULL, NULL, '2026-01-10 13:28:06', '2026-01-10 13:28:06'),
(17, 10, 15, 26, 'statement', 'Waxaa lagula talinayaa in dambiilaha si rasmi ah loo soo ooggo dacwad, iyadoo la raacayo caddaymaha la helay. Waxaa sidoo kale muhiim ah in la sii wado baaritaanno dheeraad ah si loo xaqiijiyo dhammaan xogo muhiim ah oo ku saabsan dhacdada, sida suurtagalnimada in ay jiraan dambiilayaal kale oo ku lug leh. Caddaymaha waa in si ammaan ah loo keydiyaa laguna diiwaangeliyo si loo fududeeyo dacwadda sharciga.\n\nWaxaa sidoo kale lagula talinayaa in la sameeyo warbixin buuxda oo loogu talagalay saraakiisha sharciga si ay u fahmaan dhammaan xaqiiqooyinka la helay iyo sida ay caddaymaha u taageerayaan dacwadda.', 0, NULL, NULL, '2026-01-10 13:28:10', '2026-01-10 13:28:10'),
(18, 10, 18, 26, 'statement', 'Waxaa lagula talinayaa in dambiilaha si rasmi ah loo soo ooggo dacwad, iyadoo la raacayo caddaymaha la helay. Waxaa sidoo kale muhiim ah in la sii wado baaritaanno dheeraad ah si loo xaqiijiyo dhammaan xogo muhiim ah oo ku saabsan dhacdada, sida suurtagalnimada in ay jiraan dambiilayaal kale oo ku lug leh. Caddaymaha waa in si ammaan ah loo keydiyaa laguna diiwaangeliyo si loo fududeeyo dacwadda sharciga.\n\nWaxaa sidoo kale lagula talinayaa in la sameeyo warbixin buuxda oo loogu talagalay saraakiisha sharciga si ay u fahmaan dhammaan xaqiiqooyinka la helay iyo sida ay caddaymaha u taageerayaan dacwadda.', 0, NULL, NULL, '2026-01-10 13:28:18', '2026-01-10 13:28:18'),
(19, 10, 19, 26, 'statement', 'Waxaa lagula talinayaa in dambiilaha si rasmi ah loo soo ooggo dacwad, iyadoo la raacayo caddaymaha la helay. Waxaa sidoo kale muhiim ah in la sii wado baaritaanno dheeraad ah si loo xaqiijiyo dhammaan xogo muhiim ah oo ku saabsan dhacdada, sida suurtagalnimada in ay jiraan dambiilayaal kale oo ku lug leh. Caddaymaha waa in si ammaan ah loo keydiyaa laguna diiwaangeliyo si loo fududeeyo dacwadda sharciga.\n\nWaxaa sidoo kale lagula talinayaa in la sameeyo warbixin buuxda oo loogu talagalay saraakiisha sharciga si ay u fahmaan dhammaan xaqiiqooyinka la helay iyo sida ay caddaymaha u taageerayaan dacwadda.', 0, NULL, NULL, '2026-01-10 13:28:24', '2026-01-10 13:28:24'),
(20, 13, 28, 30, 'investigation', 'aniga wax dhibaato ah ma geysan , ninkaa  wuu inaabaayaa', 0, NULL, NULL, '2026-01-12 12:09:04', '2026-01-12 12:09:04'),
(21, 13, 28, 30, 'investigation', 'habeenki dhacdada mawa joogin magalada anigu', 0, NULL, NULL, '2026-01-12 12:09:16', '2026-01-12 12:09:16'),
(22, 13, 27, 30, 'statement', 'ninkaaan dad arkay ayaa ii sheegay inuuu meesha asaga kasoo baxay', 0, NULL, NULL, '2026-01-12 12:11:28', '2026-01-12 12:11:28'),
(23, 13, 29, 30, 'statement', 'ninkaan anigaa indhahheyga ku arkay isagoo meesha kasoo baxay , waana u dhaaran karaaa', 0, NULL, NULL, '2026-01-12 12:12:54', '2026-01-12 12:12:54');

-- --------------------------------------------------------

--
-- Table structure for table `investigation_reports`
--

CREATE TABLE `investigation_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `report_type` enum('preliminary','interim','final','court_submission') NOT NULL,
  `report_subtype` varchar(50) DEFAULT NULL,
  `period_covered_from` date DEFAULT NULL,
  `period_covered_to` date DEFAULT NULL,
  `court_reference_number` varchar(100) DEFAULT NULL,
  `charges_preferred` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`charges_preferred`)),
  `case_strength` enum('weak','moderate','strong','conclusive') DEFAULT NULL,
  `recommended_action` varchar(100) DEFAULT NULL,
  `approval_status` enum('draft','pending_approval','approved','rejected') DEFAULT 'draft',
  `approved_by` int(10) UNSIGNED DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `court_order_reference` varchar(100) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Additional structured data for specific report types' CHECK (json_valid(`metadata`)),
  `updated_at` datetime DEFAULT NULL,
  `report_title` varchar(255) NOT NULL,
  `report_content` longtext NOT NULL,
  `report_file_path` varchar(255) DEFAULT NULL,
  `is_signed` tinyint(1) DEFAULT 0,
  `signature_hash` varchar(64) DEFAULT NULL,
  `signed_by` int(10) UNSIGNED DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investigation_timeline`
--

CREATE TABLE `investigation_timeline` (
  `id` int(10) UNSIGNED NOT NULL,
  `case_id` int(10) UNSIGNED NOT NULL,
  `investigator_id` int(10) UNSIGNED NOT NULL,
  `activity_type` enum('interview','site_visit','evidence_collection','analysis','meeting','report','other') NOT NULL,
  `activity_title` varchar(255) NOT NULL,
  `activity_description` text DEFAULT NULL,
  `activity_date` datetime NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `persons_involved` text DEFAULT NULL,
  `outcome` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `investigator_conclusions`
--

CREATE TABLE `investigator_conclusions` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `investigator_id` int(11) NOT NULL,
  `conclusion_title` varchar(255) NOT NULL,
  `findings` text NOT NULL,
  `recommendations` text DEFAULT NULL,
  `conclusion_summary` text NOT NULL,
  `status` enum('draft','submitted','reviewed') DEFAULT 'draft',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `submitted_at` datetime DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `investigator_conclusions`
--

INSERT INTO `investigator_conclusions` (`id`, `case_id`, `investigator_id`, `conclusion_title`, `findings`, `recommendations`, `conclusion_summary`, `status`, `created_at`, `updated_at`, `submitted_at`, `reviewed_by`, `reviewed_at`, `review_notes`) VALUES
(1, 10, 26, 'Caddeyntu waxay muujinaysaa in dambiilaha la aqoonsaday oo ku lug lahaa dhacdada', 'Markii aan baaritaanka ku guda jiray, waxaan si taxaddar leh u ururiyay dhammaan caddeymaha goobta dhacdada. Waxaa la arkay dhowr arrimood oo muhiim ah, oo ay ku jiraan markhaatiyaal aragtiyo caddeeyey, muuqaalka kamaradaha ee goobta, iyo raadad jireed oo tilmaamaya ka qaybgalka dambiilaha. Falanqaynta caddaymahan waxay muujinaysaa in dhacdadu aysan ahayn shil, balse ay ahayd fal qorsheysan oo uu dambiiluhu si toos ah ugu lug lahaa.\n\nSidoo kale, markhaatiyaashu waxay bixiyeen faahfaahin dheeraad ah oo ku saabsan sida dhacdadu u dhacday iyo goorta ay bilowday. Muuqaalka kamaraduhu wuxuu xaqiijiyay joogitaanka dambiilaha goobta, halka raadadka jireed iyo agabka la isticmaalay ay ku tusinayaan falka dhabta ah ee uu sameeyay.', 'Waxaa lagula talinayaa in dambiilaha si rasmi ah loo soo ooggo dacwad, iyadoo la raacayo caddaymaha la helay. Waxaa sidoo kale muhiim ah in la sii wado baaritaanno dheeraad ah si loo xaqiijiyo dhammaan xogo muhiim ah oo ku saabsan dhacdada, sida suurtagalnimada in ay jiraan dambiilayaal kale oo ku lug leh. Caddaymaha waa in si ammaan ah loo keydiyaa laguna diiwaangeliyo si loo fududeeyo dacwadda sharciga.\n\nWaxaa sidoo kale lagula talinayaa in la sameeyo warbixin buuxda oo loogu talagalay saraakiisha sharciga si ay u fahmaan dhammaan xaqiiqooyinka la helay iyo sida ay caddaymaha u taageerayaan dacwadda.', 'Marka la eego dhammaan baaritaannada, caddayntu waxay muujinaysaa in dambiilaha uu si toos ah ugu lug lahaa dhacdada. Waxaa lagula talinayaa in talaabooyinka sharciga la qaado iyadoo lagu saleynayo caddeymaha la helay, waxaana la sii wadi karaa baaritaanno dheeraad ah si loo hubiyo in kiisaska oo dhan si sax ah loo xalliyo.', 'draft', '2026-01-04 21:34:36', '2026-01-11 12:17:38', NULL, NULL, NULL, NULL),
(2, 13, 30, 'gabagabada kiiska', 'markaan aragnay sawirka iyo aan qiimeena sida ee dadka wax u sheegeen waxaa noo cadaatay ba in sawirka uusoo diray uu ahaaba mid hore oo ussan mar dhaw aheeen sawirkaaaas', 'waxaaan soo jeedicna in sawiraanata cadeeenta ah la isricmaalo', 'waxaaan kusoo gabagabeena in eedeysanaha ku cadyahay dhaca uu geestya', 'draft', '2026-01-12 15:17:42', '2026-01-12 15:17:54', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `note_edit_history`
--

CREATE TABLE `note_edit_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `note_id` int(10) UNSIGNED NOT NULL,
  `edited_by` int(10) UNSIGNED NOT NULL,
  `old_text` text NOT NULL,
  `new_text` text NOT NULL,
  `edited_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `note_edit_history`
--

INSERT INTO `note_edit_history` (`id`, `note_id`, `edited_by`, `old_text`, `new_text`, `edited_at`) VALUES
(1, 1, 26, 'hdfjsdsdf', 'waan badalay', '2025-12-31 06:47:18'),
(2, 8, 26, 'dddfdfsdd', 'dddfdfsddxccgsdfgsdfgdf', '2025-12-31 17:26:54');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `notification_type` enum('case_assigned','deadline_warning','status_changed','approval_required','custody_alert','system_alert','message') NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `link_entity_type` varchar(50) DEFAULT NULL,
  `link_entity_id` int(10) UNSIGNED DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `priority` enum('low','medium','high','critical') DEFAULT 'medium',
  `created_at` datetime DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `notification_type`, `title`, `message`, `link_entity_type`, `link_entity_id`, `link_url`, `is_read`, `read_at`, `priority`, `created_at`, `expires_at`) VALUES
(1, 10, 'status_changed', 'New Case for Court', 'Case #CASE/kcjd-r/2025/0001 has been sent to court for review.', 'case', 10, '/court/cases/view/10', 0, NULL, 'high', '2026-01-02 20:26:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `id` int(10) UNSIGNED NOT NULL,
  `person_type` enum('accused','accuser','witness','other') NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `national_id` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `gps_latitude` decimal(10,8) DEFAULT NULL,
  `gps_longitude` decimal(11,8) DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `fingerprint_hash` varchar(64) DEFAULT NULL,
  `fingerprint_data` mediumblob DEFAULT NULL,
  `is_repeat_offender` tinyint(1) DEFAULT 0,
  `risk_level` enum('low','medium','high','critical') DEFAULT 'low',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `person_type`, `first_name`, `middle_name`, `last_name`, `date_of_birth`, `gender`, `national_id`, `phone`, `email`, `address`, `gps_latitude`, `gps_longitude`, `photo_path`, `fingerprint_hash`, `fingerprint_data`, `is_repeat_offender`, `risk_level`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 'accuser', 'nasra', NULL, 'nasra', NULL, 'male', '484884', '8584844', NULL, 'kismayo', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:12:03', '2025-12-29 12:12:03', 5),
(2, 'accused', 'mohamed', NULL, 'hussein dhalahow', NULL, 'male', '588558', '85888584', NULL, 'kismayo', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:12:03', '2025-12-29 12:12:03', 5),
(3, 'accuser', 'abdi', NULL, 'noor farax', NULL, 'male', '47474747', '646464', NULL, 'sgaqaalaha', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:33:51', '2025-12-29 12:33:51', 5),
(4, 'accuser', 'abdu', NULL, 'ali abdi', NULL, 'male', '4774474', '3477474', NULL, 'siinaay', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:33:52', '2025-12-29 12:33:52', 5),
(5, 'accuser', 'abdi', NULL, 'noor farax', NULL, 'male', '47474747', '646464', NULL, 'sgaqaalaha', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:35:03', '2025-12-29 12:35:03', 5),
(6, 'accuser', 'abdu', NULL, 'ali abdi', NULL, 'male', '4774474', '3477474', NULL, 'siinaay', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:35:04', '2025-12-29 12:35:04', 5),
(7, 'accused', 'mohamed', NULL, 'hussein dhalahow', NULL, 'male', '57577', '575757', NULL, 'kenta', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:35:04', '2025-12-29 12:35:04', 5),
(8, 'accused', 'jeekeey', NULL, 'ali abdu', NULL, 'male', '474747', '7668686', NULL, 'kibora', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-29 12:35:05', '2025-12-29 12:35:05', 5),
(9, 'accuser', 'abdi', NULL, 'noor farax', NULL, 'male', '47474747', NULL, NULL, 'kismayo', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-30 21:55:54', '2025-12-30 21:55:54', 24),
(10, 'accuser', 'abdi', NULL, 'noor farax', NULL, 'male', '47474747', NULL, NULL, 'kismayo', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2025-12-30 21:57:15', '2025-12-30 21:57:15', 24),
(11, 'accused', 'mohamed', NULL, 'hussein dhalahow', NULL, 'male', '57577', '575757', NULL, 'kismayo', NULL, NULL, 'uploads/persons/1767131835_1d35f02ba9d4c78f5f29.jpeg', NULL, NULL, 0, 'low', '2025-12-30 21:57:15', '2025-12-31 01:03:58', 24),
(12, 'accuser', 'abdi', NULL, 'noor farax', '2002-01-01', 'male', '47474747', '646464', NULL, 'kismayo', NULL, NULL, 'uploads/persons/1767392072_ec65b96389f319c18b3b.png', NULL, NULL, 0, 'low', '2025-12-30 22:32:42', '2026-01-02 22:14:32', 25),
(13, 'accused', 'mohamed', NULL, 'hussein dhalahow', NULL, 'male', '57577', '575757', NULL, 'kismayo', NULL, NULL, 'uploads/persons/1767391632_1f1db18d4cfb25c103dc.png', NULL, NULL, 0, 'low', '2025-12-30 22:32:43', '2026-01-02 22:07:12', 25),
(14, 'accused', 'abdirizack', 'abdi', 'mohamed', '1993-01-01', 'male', '6556', '7474', 'celec22023@gusronk.com', 'kismayo\r\nshaqaaalaha', NULL, NULL, 'uploads/persons/1767391702_dde4107ed3827ee86e30.png', NULL, NULL, 0, 'low', '2025-12-31 19:46:06', '2026-01-02 22:08:22', 26),
(15, 'accuser', 'nimco', 'yare', 'abdu', '2002-01-01', 'female', '78876', '67777', 'celec22023@gusronk.com', 'kismayo\r\nshaqaaalaha', NULL, NULL, 'uploads/persons/1767391930_40ba278fabf8b622e8d9.png', NULL, NULL, 0, 'low', '2025-12-31 19:50:50', '2026-01-02 22:12:10', 26),
(16, 'witness', 'mohamed', 'hussein', 'dhalahow', '2002-01-01', NULL, '47474747', '12344', 'fomir64223@gardsiir.com', 'kismayo\r\nshaqaaalaha', NULL, NULL, 'uploads/persons/1767212443_c38734f19cb73e541dfe.jpeg', NULL, NULL, 0, 'low', '2025-12-31 20:20:43', '2025-12-31 20:20:43', 26),
(17, 'witness', 'mohamed', 'hussein', 'dhalahow', '2002-01-01', 'male', '6556', '1234433', 'fomir64223@gardsiir.com', 'kismayo\r\nshaqaaalaha', NULL, NULL, 'uploads/persons/1767212567_57597a897d3846182874.png', NULL, NULL, 0, 'low', '2025-12-31 20:22:47', '2025-12-31 20:22:47', 26),
(18, 'witness', 'mohamed', 'hussein', 'dhalahow', '2001-01-01', 'male', '6556', '1234433', 'fomir64223@gardsiir.com', 'kismayo\r\nshaqaaalaha', NULL, NULL, 'uploads/persons/1767212767_14726b365a58e6fba9b3.jpeg', NULL, NULL, 0, 'low', '2025-12-31 20:26:07', '2025-12-31 20:26:07', 26),
(19, 'witness', 'mohamed', 'hussein', 'dhalahow', '1993-01-01', 'male', '78876', '56333', 'fomir64223@gardsiir.com', 'kismayo\r\nshaqaaalaha', NULL, NULL, 'uploads/persons/1767213646_79aa69551b309060c8b6.jpeg', NULL, NULL, 0, 'low', '2025-12-31 20:40:46', '2025-12-31 20:40:46', 26),
(20, 'accuser', 'abdi', NULL, 'noor farax', NULL, 'male', '47474747', '646464', NULL, 'kismayo', NULL, NULL, 'uploads/persons/1767468848_f0c6517c2b168d2bf5de.png', NULL, NULL, 0, 'low', '2026-01-03 19:34:08', '2026-01-03 19:34:08', 25),
(21, 'accused', 'mohamed', NULL, 'hussein dhalahow', NULL, 'male', '57577', '575757', NULL, 'kismayo', NULL, NULL, 'uploads/persons/1767468848_731d44396d2ceb6ed04e.png', NULL, NULL, 0, 'low', '2026-01-03 19:34:08', '2026-01-03 19:34:08', 25),
(22, 'accused', 'abdi', NULL, 'farax', NULL, 'male', '474747', '7668686', NULL, 'kismayo', NULL, NULL, 'uploads/persons/1767468849_dfe7a482a9242521092f.png', NULL, NULL, 0, 'low', '2026-01-03 19:34:09', '2026-01-03 19:34:09', 25),
(23, 'accused', 'nuurto', NULL, 'cali', NULL, 'female', '7888', '5566', NULL, 'kismayo', NULL, NULL, 'uploads/persons/1767468850_698ac3f8aa42c009d67b.png', NULL, NULL, 0, 'low', '2026-01-03 19:34:10', '2026-01-03 19:34:10', 25),
(24, 'other', 'keenan', NULL, 'abdi', NULL, NULL, '858855', '4774755', NULL, 'kismayo', NULL, NULL, NULL, NULL, NULL, 0, 'low', '2026-01-03 19:34:11', '2026-01-03 19:34:11', 25),
(25, 'accuser', 'maryam', NULL, 'abdi dhubow', NULL, 'female', '383883', '061500000', NULL, 'wadada aargo siinaaay', NULL, NULL, 'uploads/persons/1767859200_90508fefdbd8e2e28e07.png', NULL, NULL, 0, 'low', '2026-01-08 08:00:00', '2026-01-08 08:00:00', 25),
(26, 'accused', 'jeylani', NULL, 'geedi farax', NULL, 'male', '88383', '0614112537', NULL, 'sgaqaalaha dhinaca vafmadow', NULL, NULL, 'uploads/persons/1767859200_dec599e6834cd2e692e7.jpg', NULL, NULL, 0, 'low', '2026-01-08 08:00:00', '2026-01-08 08:00:00', 25),
(27, 'accuser', 'cabdifatax', NULL, 'hussein abdi', NULL, 'male', '383883', '061500000', NULL, 'shaqaalaha', NULL, NULL, 'uploads/persons/1768229738_8683938a2e96201e5ec2.jpeg', NULL, NULL, 0, 'low', '2026-01-12 14:55:38', '2026-01-12 14:55:38', 29),
(28, 'accused', 'geyle', NULL, 'farax  noor', NULL, 'male', '88383', '0614112537', NULL, 'siinaay', NULL, NULL, 'uploads/persons/1768229738_6eaf0750843d98ba93c8.png', NULL, NULL, 0, 'low', '2026-01-12 14:55:38', '2026-01-12 14:55:38', 29),
(29, 'witness', 'mohamed', 'hussein', 'dhalahow', '2002-01-01', 'male', '78876', '0618189239', 'badhey14@gmail.com', 'kismayo\r\nshaqaaalaha', NULL, NULL, 'uploads/persons/1768230751_60af1961386df06538cc.jpg', NULL, NULL, 0, 'low', '2026-01-12 15:12:31', '2026-01-12 15:12:31', 30);

-- --------------------------------------------------------

--
-- Table structure for table `person_aliases`
--

CREATE TABLE `person_aliases` (
  `id` int(10) UNSIGNED NOT NULL,
  `person_id` int(10) UNSIGNED NOT NULL,
  `alias_name` varchar(200) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `police_centers`
--

CREATE TABLE `police_centers` (
  `id` int(10) UNSIGNED NOT NULL,
  `center_code` varchar(20) NOT NULL,
  `center_name` varchar(200) NOT NULL,
  `location` varchar(255) NOT NULL,
  `gps_latitude` decimal(10,8) DEFAULT NULL,
  `gps_longitude` decimal(11,8) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `police_centers`
--

INSERT INTO `police_centers` (`id`, `center_code`, `center_name`, `location`, `gps_latitude`, `gps_longitude`, `phone`, `email`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'HQ001', 'Central Police Station', '123 Main Street, Capital City', -1.28638900, 36.81722300, '+254712345678', 'central@police.gov', 1, '2025-12-29 10:58:10', '2025-12-29 10:58:10'),
(2, 'EAST001', 'East Division Police Station', '456 Eastern Road, Capital City', -1.29206600, 36.82194600, '+254712345679', 'east@police.gov', 1, '2025-12-29 10:58:10', '2025-12-29 10:58:10'),
(3, 'WEST001', 'West Division Police Station', '789 Western Avenue, Capital City', -1.28333300, 36.81666700, '+254712345680', 'west@police.gov', 1, '2025-12-29 10:58:10', '2025-12-29 10:58:10'),
(4, 'KSM-001', 'Kismayo Central Police Station', 'Kismayo City Center, Jubaland', -0.35826530, 42.54528030, '+252-61-1234567', 'central@kismayo.police.gov', 1, '2025-12-29 11:38:40', '2025-12-29 11:38:40'),
(5, 'KSM-002', 'Kismayo Port Police Station', 'Port Area, Kismayo', -0.35811000, 42.54915000, '+252-61-1234568', 'port@kismayo.police.gov', 1, '2025-12-29 11:38:40', '2025-12-29 11:38:40'),
(6, 'KSM-003', 'Kismayo Airport Security', 'Kismayo International Airport', -0.37737000, 42.45923000, '+252-61-1234569', 'airport@kismayo.police.gov', 1, '2025-12-29 11:38:40', '2025-12-29 11:38:40'),
(7, 'kcjd-r', 'katarbiilka', 'ffff', NULL, NULL, '1234433', 'celec22023@gusronk.com', 1, '2025-12-29 13:00:44', '2025-12-29 13:00:44'),
(8, 'XGD-01', 'Xabsiga dhexe', 'calaley', NULL, NULL, '061622222', 'xabsi@gmail.com', 1, '2026-01-12 11:20:56', '2026-01-12 11:20:56');

-- --------------------------------------------------------

--
-- Table structure for table `report_approvals`
--

CREATE TABLE `report_approvals` (
  `id` int(10) UNSIGNED NOT NULL,
  `report_id` int(10) UNSIGNED NOT NULL,
  `approver_id` int(10) UNSIGNED NOT NULL,
  `approval_level` enum('investigator','supervisor','commander','prosecutor') DEFAULT 'supervisor',
  `status` enum('pending','approved','rejected','revision_requested') DEFAULT 'pending',
  `comments` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_settings`
--

CREATE TABLE `report_settings` (
  `id` int(11) UNSIGNED NOT NULL,
  `center_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'If NULL, applies to all centers (system-wide)',
  `setting_key` varchar(100) NOT NULL COMMENT 'e.g., header_image, full_report_sections, basic_report_sections',
  `setting_value` text DEFAULT NULL COMMENT 'JSON or text value',
  `setting_type` enum('text','json','image','file') NOT NULL DEFAULT 'text',
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(11) UNSIGNED DEFAULT NULL,
  `updated_by` int(11) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `report_settings`
--

INSERT INTO `report_settings` (`id`, `center_id`, `setting_key`, `setting_value`, `setting_type`, `description`, `is_active`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, NULL, 'header_image', 'reports/headers/report_header_1768057991.jpeg', 'image', 'Report header image/logo (shared by all reports)', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:13:11'),
(2, NULL, 'full_statement1', 'Ku: Xafiiska XeerIlaaliyaha_Guud ee Dawladda jubaland = kismaayo\n', 'text', 'Full Report Statement 1 - Appears after case numbers', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:20'),
(3, NULL, 'full_statement2', 'Og: Taliyaha Qeybta Boliiska Gobolka Jubbada Hoose = kismaayo', 'text', 'Full Report Statement 2 - Appears below statement 1', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:20'),
(4, NULL, 'full_statement3', 'Ujeedo: Taar', 'text', 'Full Report Statement 3 - Appears before report sections', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:20'),
(5, NULL, 'full_footer_text', 'T/Xigeenka Saldhiga Dhexe Ee Degmada Kismaayo\nDhamme C/Xakiin Yuusuf Ibraahim : ________________________________________\n', 'text', 'Full Report Footer text with signature section', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:20'),
(6, NULL, 'basic_statement1', 'Ku: Xafiiska XeerIlaaliyaha_Guud ee Dawladda jubaland = kismaayo\n', 'text', 'Basic Report Statement 1 - Appears after case numbers', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:52'),
(7, NULL, 'basic_statement2', 'Og: Taliyaha Qeybta Boliiska Gobolka Jubbada Hoose = kismaayo', 'text', 'Basic Report Statement 2 - Appears below statement 1', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:52'),
(8, NULL, 'basic_statement3', 'Ujeedo: Taar', 'text', 'Basic Report Statement 3 - Appears before report sections', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:52'),
(9, NULL, 'basic_footer_text', 'T/Xigeenka Saldhiga Dhexe Ee Degmada Kismaayo\nDhamme C/Xakiin Yuusuf Ibraahim : ________________________________________\n', 'text', 'Basic Report Footer text with signature section', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:52'),
(10, NULL, 'custom_statement1', 'Ku: Xafiiska XeerIlaaliyaha_Guud ee Dawladda jubaland = kismaayo\n', 'text', 'Customized Report Statement 1 - Appears after case numbers', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:56'),
(11, NULL, 'custom_statement2', 'Og: Taliyaha Qeybta Boliiska Gobolka Jubbada Hoose = kismaayo', 'text', 'Customized Report Statement 2 - Appears below statement 1', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:56'),
(12, NULL, 'custom_statement3', 'Ujeedo: Taar', 'text', 'Customized Report Statement 3 - Appears before report sections', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:56'),
(13, NULL, 'custom_footer_text', 'T/Xigeenka Saldhiga Dhexe Ee Degmada Kismaayo\nDhamme C/Xakiin Yuusuf Ibraahim : ________________________________________\n', 'text', 'Customized Report Footer text with signature section', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-10 12:12:56'),
(14, NULL, 'full_report_sections', '{\r\n    \"case_overview\": {\r\n        \"title\": \"Case Overview\",\r\n        \"enabled\": true,\r\n        \"order\": 1,\r\n        \"template\": \"This section provides a comprehensive overview of the case including all relevant details.\"\r\n    },\r\n    \"parties_involved\": {\r\n        \"title\": \"Parties Involved\",\r\n        \"enabled\": true,\r\n        \"order\": 2,\r\n        \"template\": \"Detailed information about all parties involved including accusers, accused, and witnesses.\"\r\n    },\r\n    \"evidence_summary\": {\r\n        \"title\": \"Evidence Summary\",\r\n        \"enabled\": true,\r\n        \"order\": 3,\r\n        \"template\": \"Complete catalog of all evidence collected during the investigation.\"\r\n    },\r\n    \"investigation_details\": {\r\n        \"title\": \"Investigation Details\",\r\n        \"enabled\": true,\r\n        \"order\": 4,\r\n        \"template\": \"Detailed account of investigation activities, interviews, and findings.\"\r\n    },\r\n    \"investigator_conclusions\": {\r\n        \"title\": \"Investigator Conclusions\",\r\n        \"enabled\": true,\r\n        \"order\": 5,\r\n        \"template\": \"Professional conclusions and recommendations based on investigation findings.\"\r\n    },\r\n    \"recommendations\": {\r\n        \"title\": \"Recommendations\",\r\n        \"enabled\": true,\r\n        \"order\": 6,\r\n        \"template\": \"Recommended next steps and actions for case resolution.\"\r\n    }\r\n}', 'json', 'Text sections configuration for Full Investigation Report', 1, NULL, NULL, '2026-01-10 12:09:51', NULL),
(15, NULL, 'basic_report_sections', '{\r\n    \"case_overview\": {\r\n        \"title\": \"Case Overview\",\r\n        \"enabled\": true,\r\n        \"order\": 1,\r\n        \"template\": \"Brief overview of the case and key details.\"\r\n    },\r\n    \"summary\": {\r\n        \"title\": \"Summary\",\r\n        \"enabled\": true,\r\n        \"order\": 2,\r\n        \"template\": \"Summary of the investigation and key findings.\"\r\n    },\r\n    \"conclusion\": {\r\n        \"title\": \"Conclusion\",\r\n        \"enabled\": true,\r\n        \"order\": 3,\r\n        \"template\": \"Brief conclusion and recommendation.\"\r\n    }\r\n}', 'json', 'Text sections configuration for Basic Investigation Report', 1, NULL, NULL, '2026-01-10 12:09:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` enum('string','integer','boolean','json') DEFAULT 'string',
  `description` text DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `setting_type`, `description`, `is_public`, `updated_at`, `updated_by`) VALUES
(1, 'system_name', 'Police Case Management System', 'string', 'System name', 1, '2025-12-29 10:58:10', NULL),
(2, 'system_version', '1.0.0', 'string', 'Current system version', 1, '2025-12-29 10:58:10', NULL),
(3, 'max_file_upload_size', '52428800', 'integer', 'Maximum file upload size in bytes (50MB)', 0, '2025-12-29 10:58:10', NULL),
(4, 'custody_time_limit_hours', '48', 'integer', 'Default custody time limit in hours', 0, '2025-12-29 10:58:10', NULL),
(5, 'custody_warning_threshold', '36', 'integer', 'Hours before custody limit to show warning', 0, '2025-12-29 10:58:10', NULL),
(6, 'password_expiry_days', '90', 'integer', 'Password expiry period in days', 0, '2025-12-29 10:58:10', NULL),
(7, 'session_timeout_minutes', '30', 'integer', 'Session timeout in minutes', 0, '2025-12-29 10:58:10', NULL),
(8, 'enable_biometric', '1', 'boolean', 'Enable biometric fingerprint capture', 0, '2025-12-29 10:58:10', NULL),
(9, 'enable_gps', '1', 'boolean', 'Enable GPS location capture', 0, '2025-12-29 10:58:10', NULL),
(10, 'enable_notifications', '1', 'boolean', 'Enable system notifications', 0, '2025-12-29 10:58:10', NULL),
(11, 'court_email', 'court@judiciary.gov', 'string', 'Court system email address', 0, '2025-12-29 10:58:10', NULL),
(12, 'evidence_retention_years', '7', 'integer', 'Evidence retention period in years', 0, '2025-12-29 10:58:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `center_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('super_admin','admin','ob_officer','investigator','court_user') NOT NULL,
  `badge_number` varchar(50) DEFAULT NULL,
  `language` varchar(10) NOT NULL DEFAULT 'en',
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `failed_login_attempts` tinyint(4) DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `center_id`, `username`, `email`, `password_hash`, `full_name`, `phone`, `role`, `badge_number`, `language`, `is_active`, `last_login`, `failed_login_attempts`, `locked_until`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 1, 'superadmin', 'superadmin@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'System Administrator', '+254700000001', 'super_admin', 'SA001', 'en', 1, '2026-01-12 11:37:55', 0, NULL, '2025-12-29 10:58:10', '2026-01-12 11:45:10', NULL),
(2, 1, 'admin_central', 'admin.central@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'John Kamau', '+254700000002', 'admin', 'A001', 'en', 1, '2025-12-29 14:02:07', 0, NULL, '2025-12-29 10:58:10', '2025-12-29 14:02:07', 1),
(3, 2, 'admin_east', 'admin.east@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'Mary Wanjiku', '+254700000003', 'admin', 'A002', 'en', 1, NULL, 0, NULL, '2025-12-29 10:58:10', '2025-12-29 11:39:27', 1),
(4, 3, 'admin_west', 'admin.west@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'Peter Omondi', '+254700000004', 'admin', 'A003', 'en', 1, NULL, 0, NULL, '2025-12-29 10:58:10', '2025-12-29 11:39:27', 1),
(5, 1, 'ob_officer1', 'ob1@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'James Mwangi', '+254700000005', 'ob_officer', 'OB001', 'en', 1, '2025-12-29 12:31:08', 3, NULL, '2025-12-29 10:58:10', '2026-01-03 19:21:48', 2),
(6, 2, 'ob_officer2', 'ob2@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'Grace Akinyi', '+254700000006', 'ob_officer', 'OB002', 'en', 1, NULL, 0, NULL, '2025-12-29 10:58:10', '2025-12-29 11:39:27', 3),
(7, 1, 'investigator1', 'inv1@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'David Kipchoge', '+254700000007', 'investigator', 'INV001', 'en', 1, '2025-12-29 10:00:24', 0, NULL, '2025-12-29 10:58:10', '2025-12-29 10:00:24', 2),
(8, 1, 'investigator2', 'inv2@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'Sarah Njeri', '+254700000008', 'investigator', 'INV002', 'en', 1, NULL, 0, NULL, '2025-12-29 10:58:10', '2025-12-29 11:39:27', 2),
(9, 2, 'investigator3', 'inv3@police.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'Michael Otieno', '+254700000009', 'investigator', 'INV003', 'en', 1, NULL, 0, NULL, '2025-12-29 10:58:10', '2025-12-29 11:39:27', 3),
(10, 1, 'court_user1', 'court1@judiciary.gov', '$2y$12$eaL8JWy0MsvaUQbpIrTUTOhsVqhHkjhKr68bVl/hTfvhkNKWVuVtS', 'Judge Alice Muthoni', '+254700000010', 'court_user', 'CT001', 'en', 1, '2025-12-29 10:00:54', 0, NULL, '2025-12-29 10:58:10', '2025-12-29 10:00:54', 1),
(21, 7, 'abdi', 'mohamedbadhey@gmail.com', '', 'mohamed hussein dhalahow', '1234433', 'admin', '677', 'en', 1, NULL, 4, NULL, '2025-12-29 13:55:51', '2026-01-12 14:51:37', 1),
(22, 7, 'farax', 'admin@foodorder.com', '', 'mohamed hussein dhalahow', '1234433', 'admin', '6644', 'en', 1, NULL, 4, NULL, '2025-12-29 13:58:49', '2025-12-29 17:18:04', 1),
(23, 7, 'moha', 'fomir64223@gardsiir.com', '$2y$12$MiGkjvtc2qrGQflQjpjNLOjIRqQVeHcf.NfQjP1N07okiXihZt5aO', 'mohamed hussein dhalahow', '1234433', 'admin', '6644', 'en', 1, '2026-01-11 07:08:01', 0, NULL, '2025-12-30 21:36:02', '2026-01-11 07:08:01', 1),
(24, 6, 'obuser', 'badhey14@gmail.com', '$2y$12$W.14q6a.mxkFq6YviPU7MOYRqfmJf/WErjWebjBrQE8WsnbMqmMeC', 'mohamed hussein dhalaho', '7474', 'ob_officer', '6464', 'en', 1, '2025-12-30 22:27:46', 0, NULL, '2025-12-30 21:38:21', '2025-12-30 22:27:46', 1),
(25, 7, 'obuser1', 'badwwhey14@gmail.com', '$2y$12$ixrMq99aSKXWfdHkBAFwfeZJ8ndXyVu.h/KylkYa14s6LWawJ18fa', 'mohamed hussein dhalahow', '1234433', 'ob_officer', '', 'en', 1, '2026-01-11 07:09:30', 0, NULL, '2025-12-30 22:30:50', '2026-01-11 07:09:30', 1),
(26, 7, 'baare', 'adeemin@foodorder.com', '$2y$12$84zKtbOlWf1nUnut.mEt4.tjpMA9x9K97AZu/uGEnNbFTfFh2/bhm', 'mohamed hussein dhalahow', '12344', 'investigator', '455', 'en', 1, '2026-01-14 19:05:09', 0, NULL, '2025-12-30 22:36:25', '2026-01-14 19:05:18', 1),
(27, 7, 'court', 'mohameeeedbadhey@gmail.com', '$2y$12$tFzXpu75WXHaxOs2BTVJU.CvEe3JPLdT1aY/Jhd6rVG4cnUty82jS', 'mohamed hussein dhalahow', '1234433', 'court_user', '6464', 'en', 1, '2026-01-03 08:58:46', 0, NULL, '2026-01-03 08:12:05', '2026-01-03 08:58:46', 1),
(28, 8, 'abdixakin', 'admin@teekoob.com', '$2y$12$PjW0V2tf4oxmsHDd./6jpeoB3vwUvZnFoErp/kBeTANggublz0Htm', 'abdixakin taliye', '061636363', 'admin', '6363', 'en', 1, '2026-01-12 14:56:42', 0, NULL, '2026-01-12 11:22:17', '2026-01-12 14:56:42', 1),
(29, 8, 'abdu', 'abdu@gmail.com', '$2y$12$Y/KKDibI4O9oC4QNwjMTwO3ryNz6m4OZTaiVl9nQsggIF4QqsVSfi', 'abdullahi siciid abdullahi', '0618189239', 'ob_officer', '7272', 'so', 1, '2026-01-12 14:51:42', 0, NULL, '2026-01-12 11:23:49', '2026-01-12 14:51:42', 1),
(30, 8, 'kazama', 'kapeboy320@deepmails.org', '$2y$12$1Vh9JvZQsFWCMnIWRPIhouRdXUg9nn8cISXqfgeiWUXtn1pgNpQ8.', 'kazaama baare', '0616363737', 'investigator', '7272', 'en', 1, '2026-01-12 15:48:06', 0, NULL, '2026-01-12 11:42:32', '2026-01-12 15:48:06', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token_hash` varchar(64) NOT NULL,
  `refresh_token_hash` varchar(64) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `user_id`, `token_hash`, `refresh_token_hash`, `ip_address`, `user_agent`, `expires_at`, `created_at`) VALUES
(78, 27, '991906e1ecdb7dfc9edc34e6841036908f5123aaf67e6a50dc0dcf77120ef007', '51edb813425e47dcefed7e245b5dffc1776342842f89b2ba251283147a3e5238', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-03 09:28:46', '2026-01-03 08:58:46'),
(137, 26, '9bd8213e0b4d705966ce7420a86b443259a85c792ce7bd873a08ca07c501be63', '49f280e0cf8387bde1c19bba825e85321aff429bc78b00995fbbb1f405878062', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-11 12:25:28', '2026-01-11 11:55:28'),
(138, 26, '77711973f07d94a6d05e569445ad1759960485e39d63bb0a987b2419b71b5f94', '4a4d1629e1fdc762b419c6459a1723f2da1c4be08bad09760bb3e8e1e17395ab', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-11 12:33:30', '2026-01-11 12:03:30'),
(139, 26, '45b72bea872bb9b5c22f63c84300771f16c1c6b0f43aab175589638fc697abcb', '8ef3e43b3cc484d3dca7c42d8765c4a3510dba5c2df737b1af279e3d10c023af', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-11 15:35:02', '2026-01-11 15:05:02'),
(150, 30, 'f28e05227473d2883aa8dc1e2e37ad573e5b1600358d7e6f492813acd9fcfe3b', '87741cc862733f7a050ad77c3f1acc38a4ee17d0a9977b650c3a382ef9c11855', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-12 15:37:16', '2026-01-12 15:07:16'),
(151, 30, '145424c6c3f1f9f5b06e57772cbf4f03b9d811c99376e2a895d79060c3bc0ab2', '7ea03dcfb3d998f96c2ea318cad300ff39a5add86404871057928867d5d64fb9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-12 16:18:06', '2026-01-12 15:48:06'),
(152, 26, 'f4b1d003b95b09f0c9e1b2d9354498da50f25a25b7c9479398792cb8488a9640', 'e60864ca8d03767e3458274d0a377534bf56fe33321d715168770ed35fc966f7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-14 12:56:09', '2026-01-14 12:26:09'),
(153, 26, '1aaa538aa76d518db12eab5f330c7b5fe0b578e3e78504f947c5228cea7cd1b7', '60eaa8dcaee791ef4685bb8e0c7c51e5abd4a2e660866408e62ea0aba415c503', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-14 13:27:19', '2026-01-14 12:57:19'),
(154, 26, '43564861a69ebcf456a62e1d63b50936da070529a9ba57a5688f321ad17656d9', 'dbf99d5cf1763ed482377df0b56bd8fdd93089b5227f9d725d3c7b1ca3ef50d5', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-14 13:58:41', '2026-01-14 13:28:41'),
(155, 26, 'f2d6f7027d6a58046dd328aa42183ba450ee6b2a0505589c49c9bc184286350c', '4a950f4f12d085d976813ca2c21e5dc101ab9ef5ac81afd9312f945718dc207e', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-14 19:35:09', '2026-01-14 19:05:09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_type` (`activity_type`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `case_number` (`case_number`),
  ADD UNIQUE KEY `ob_number` (`ob_number`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `idx_case_number` (`case_number`),
  ADD KEY `idx_ob_number` (`ob_number`),
  ADD KEY `idx_center` (`center_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_priority` (`priority`),
  ADD KEY `idx_incident_date` (`incident_date`),
  ADD KEY `idx_crime_type` (`crime_type`),
  ADD KEY `idx_sensitive` (`is_sensitive`),
  ADD KEY `idx_court_status` (`court_status`),
  ADD KEY `idx_court_deadline` (`court_deadline`),
  ADD KEY `idx_sent_to_court_date` (`sent_to_court_date`),
  ADD KEY `sent_to_court_by` (`sent_to_court_by`),
  ADD KEY `court_assigned_by` (`court_assigned_by`),
  ADD KEY `closed_by` (`closed_by`);
ALTER TABLE `cases` ADD FULLTEXT KEY `idx_description` (`incident_description`);

--
-- Indexes for table `case_assignments`
--
ALTER TABLE `case_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_by` (`assigned_by`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_investigator` (`investigator_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `case_comments`
--
ALTER TABLE `case_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `case_parties`
--
ALTER TABLE `case_parties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_person` (`person_id`),
  ADD KEY `idx_role` (`party_role`),
  ADD KEY `idx_witness_affiliation` (`witness_affiliation`),
  ADD KEY `idx_affiliated_person` (`affiliated_person_id`);

--
-- Indexes for table `case_relationships`
--
ALTER TABLE `case_relationships`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_relationship` (`case_id`,`related_case_id`),
  ADD KEY `idx_case_id` (`case_id`),
  ADD KEY `idx_related_case_id` (`related_case_id`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indexes for table `case_status_history`
--
ALTER TABLE `case_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `changed_by` (`changed_by`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_changed_at` (`changed_at`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_name` (`name`),
  ADD KEY `idx_active` (`is_active`),
  ADD KEY `idx_display_order` (`display_order`);

--
-- Indexes for table `court_assignments`
--
ALTER TABLE `court_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_by` (`assigned_by`),
  ADD KEY `idx_case_id` (`case_id`),
  ADD KEY `idx_assigned_to` (`assigned_to`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_deadline` (`deadline`);

--
-- Indexes for table `court_communications`
--
ALTER TABLE `court_communications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_case_id` (`case_id`),
  ADD KEY `idx_report_id` (`report_id`),
  ADD KEY `idx_communication_date` (`communication_date`),
  ADD KEY `idx_communication_type` (`communication_type`),
  ADD KEY `fk_court_comm_created_by` (`created_by`),
  ADD KEY `idx_court_comm_case_date` (`case_id`,`communication_date`);

--
-- Indexes for table `custody_alerts`
--
ALTER TABLE `custody_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acknowledged_by` (`acknowledged_by`),
  ADD KEY `resolved_by` (`resolved_by`),
  ADD KEY `idx_custody` (`custody_record_id`),
  ADD KEY `idx_type` (`alert_type`),
  ADD KEY `idx_severity` (`alert_severity`),
  ADD KEY `idx_acknowledged` (`is_acknowledged`),
  ADD KEY `idx_resolved` (`is_resolved`);

--
-- Indexes for table `custody_daily_logs`
--
ALTER TABLE `custody_daily_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_daily_log` (`custody_record_id`,`log_date`,`log_time`),
  ADD KEY `logged_by` (`logged_by`),
  ADD KEY `idx_custody` (`custody_record_id`),
  ADD KEY `idx_log_date` (`log_date`);

--
-- Indexes for table `custody_movement_log`
--
ALTER TABLE `custody_movement_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `authorized_by` (`authorized_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_custody` (`custody_record_id`),
  ADD KEY `idx_movement_type` (`movement_type`),
  ADD KEY `idx_movement_dates` (`movement_start`,`movement_end`);

--
-- Indexes for table `custody_records`
--
ALTER TABLE `custody_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_person` (`person_id`),
  ADD KEY `idx_status` (`custody_status`),
  ADD KEY `idx_center` (`center_id`),
  ADD KEY `idx_custody_dates` (`custody_start`,`custody_end`),
  ADD KEY `idx_presence_status` (`presence_status`),
  ADD KEY `idx_bail_status` (`bail_status`);

--
-- Indexes for table `digital_signatures`
--
ALTER TABLE `digital_signatures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `signature_hash` (`signature_hash`),
  ADD KEY `idx_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_signature` (`signature_hash`),
  ADD KEY `idx_signer` (`signed_by`);

--
-- Indexes for table `document_templates`
--
ALTER TABLE `document_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `template_name` (`template_name`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_type` (`template_type`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `evidence`
--
ALTER TABLE `evidence`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `evidence_number` (`evidence_number`),
  ADD KEY `collected_by` (`collected_by`),
  ADD KEY `collected_from_person_id` (`collected_from_person_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_evidence_number` (`evidence_number`),
  ADD KEY `idx_type` (`evidence_type`),
  ADD KEY `idx_critical` (`is_critical`),
  ADD KEY `last_edited_by` (`last_edited_by`);

--
-- Indexes for table `evidence_custody_log`
--
ALTER TABLE `evidence_custody_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `performed_by` (`performed_by`),
  ADD KEY `witness_id` (`witness_id`),
  ADD KEY `idx_evidence` (`evidence_id`),
  ADD KEY `idx_performed_at` (`performed_at`);

--
-- Indexes for table `evidence_edit_history`
--
ALTER TABLE `evidence_edit_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_evidence` (`evidence_id`),
  ADD KEY `idx_edited_at` (`edited_at`),
  ADD KEY `idx_edited_by` (`edited_by`);

--
-- Indexes for table `evidence_file_versions`
--
ALTER TABLE `evidence_file_versions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `replaced_by` (`replaced_by`),
  ADD KEY `idx_evidence` (`evidence_id`),
  ADD KEY `idx_version` (`evidence_id`,`version_number`),
  ADD KEY `idx_replaced_at` (`replaced_at`);

--
-- Indexes for table `file_encryption_registry`
--
ALTER TABLE `file_encryption_registry`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `file_path` (`file_path`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_file_path` (`file_path`),
  ADD KEY `idx_access_level` (`access_level`);

--
-- Indexes for table `investigation_notes`
--
ALTER TABLE `investigation_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_person` (`person_id`),
  ADD KEY `idx_investigator` (`investigator_id`),
  ADD KEY `idx_created` (`created_at`),
  ADD KEY `last_edited_by` (`last_edited_by`);

--
-- Indexes for table `investigation_reports`
--
ALTER TABLE `investigation_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `signed_by` (`signed_by`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_type` (`report_type`),
  ADD KEY `fk_reports_approved_by` (`approved_by`),
  ADD KEY `idx_reports_case_type` (`case_id`,`report_type`),
  ADD KEY `idx_reports_approval_status` (`approval_status`),
  ADD KEY `idx_reports_created_at` (`created_at`);

--
-- Indexes for table `investigation_timeline`
--
ALTER TABLE `investigation_timeline`
  ADD PRIMARY KEY (`id`),
  ADD KEY `investigator_id` (`investigator_id`),
  ADD KEY `idx_case` (`case_id`),
  ADD KEY `idx_activity_date` (`activity_date`);

--
-- Indexes for table `investigator_conclusions`
--
ALTER TABLE `investigator_conclusions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_case_id` (`case_id`),
  ADD KEY `idx_investigator_id` (`investigator_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_reviewed_by` (`reviewed_by`);

--
-- Indexes for table `note_edit_history`
--
ALTER TABLE `note_edit_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `edited_by` (`edited_by`),
  ADD KEY `idx_note` (`note_id`),
  ADD KEY `idx_edited_at` (`edited_at`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`),
  ADD KEY `idx_type` (`notification_type`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fingerprint_hash` (`fingerprint_hash`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_fingerprint` (`fingerprint_hash`),
  ADD KEY `idx_national_id` (`national_id`),
  ADD KEY `idx_name` (`last_name`,`first_name`),
  ADD KEY `idx_type` (`person_type`);

--
-- Indexes for table `person_aliases`
--
ALTER TABLE `person_aliases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_person` (`person_id`);

--
-- Indexes for table `police_centers`
--
ALTER TABLE `police_centers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `center_code` (`center_code`),
  ADD KEY `idx_center_code` (`center_code`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `report_approvals`
--
ALTER TABLE `report_approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_report_id` (`report_id`),
  ADD KEY `idx_approver_id` (`approver_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_approvals_created_at` (`created_at`);

--
-- Indexes for table `report_settings`
--
ALTER TABLE `report_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_center_setting` (`center_id`,`setting_key`),
  ADD KEY `fk_report_settings_created_by` (`created_by`),
  ADD KEY `fk_report_settings_updated_by` (`updated_by`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `idx_key` (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_center` (`center_id`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_token` (`token_hash`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cases`
--
ALTER TABLE `cases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `case_assignments`
--
ALTER TABLE `case_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `case_comments`
--
ALTER TABLE `case_comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `case_parties`
--
ALTER TABLE `case_parties`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `case_relationships`
--
ALTER TABLE `case_relationships`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `case_status_history`
--
ALTER TABLE `case_status_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `court_assignments`
--
ALTER TABLE `court_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `court_communications`
--
ALTER TABLE `court_communications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custody_alerts`
--
ALTER TABLE `custody_alerts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custody_daily_logs`
--
ALTER TABLE `custody_daily_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `custody_movement_log`
--
ALTER TABLE `custody_movement_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custody_records`
--
ALTER TABLE `custody_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `digital_signatures`
--
ALTER TABLE `digital_signatures`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_templates`
--
ALTER TABLE `document_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `evidence`
--
ALTER TABLE `evidence`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `evidence_custody_log`
--
ALTER TABLE `evidence_custody_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1782;

--
-- AUTO_INCREMENT for table `evidence_edit_history`
--
ALTER TABLE `evidence_edit_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `evidence_file_versions`
--
ALTER TABLE `evidence_file_versions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `file_encryption_registry`
--
ALTER TABLE `file_encryption_registry`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `investigation_notes`
--
ALTER TABLE `investigation_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `investigation_reports`
--
ALTER TABLE `investigation_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `investigation_timeline`
--
ALTER TABLE `investigation_timeline`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `investigator_conclusions`
--
ALTER TABLE `investigator_conclusions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `note_edit_history`
--
ALTER TABLE `note_edit_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `person_aliases`
--
ALTER TABLE `person_aliases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `police_centers`
--
ALTER TABLE `police_centers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `report_approvals`
--
ALTER TABLE `report_approvals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_settings`
--
ALTER TABLE `report_settings`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cases`
--
ALTER TABLE `cases`
  ADD CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`center_id`) REFERENCES `police_centers` (`id`),
  ADD CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cases_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cases_ibfk_4` FOREIGN KEY (`sent_to_court_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cases_ibfk_5` FOREIGN KEY (`court_assigned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cases_ibfk_6` FOREIGN KEY (`closed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `case_assignments`
--
ALTER TABLE `case_assignments`
  ADD CONSTRAINT `case_assignments_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `case_assignments_ibfk_2` FOREIGN KEY (`investigator_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `case_assignments_ibfk_3` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `case_comments`
--
ALTER TABLE `case_comments`
  ADD CONSTRAINT `case_comments_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `case_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `case_parties`
--
ALTER TABLE `case_parties`
  ADD CONSTRAINT `case_parties_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `case_parties_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  ADD CONSTRAINT `fk_affiliated_person` FOREIGN KEY (`affiliated_person_id`) REFERENCES `persons` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `case_status_history`
--
ALTER TABLE `case_status_history`
  ADD CONSTRAINT `case_status_history_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `case_status_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `court_assignments`
--
ALTER TABLE `court_assignments`
  ADD CONSTRAINT `court_assignments_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `court_assignments_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `court_assignments_ibfk_3` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `court_communications`
--
ALTER TABLE `court_communications`
  ADD CONSTRAINT `fk_court_comm_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_court_comm_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_court_comm_report` FOREIGN KEY (`report_id`) REFERENCES `investigation_reports` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `custody_alerts`
--
ALTER TABLE `custody_alerts`
  ADD CONSTRAINT `custody_alerts_ibfk_1` FOREIGN KEY (`custody_record_id`) REFERENCES `custody_records` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `custody_alerts_ibfk_2` FOREIGN KEY (`acknowledged_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `custody_alerts_ibfk_3` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `custody_daily_logs`
--
ALTER TABLE `custody_daily_logs`
  ADD CONSTRAINT `custody_daily_logs_ibfk_1` FOREIGN KEY (`custody_record_id`) REFERENCES `custody_records` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `custody_daily_logs_ibfk_2` FOREIGN KEY (`logged_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `custody_movement_log`
--
ALTER TABLE `custody_movement_log`
  ADD CONSTRAINT `custody_movement_log_ibfk_1` FOREIGN KEY (`custody_record_id`) REFERENCES `custody_records` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `custody_movement_log_ibfk_2` FOREIGN KEY (`authorized_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `custody_movement_log_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `custody_records`
--
ALTER TABLE `custody_records`
  ADD CONSTRAINT `custody_records_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `custody_records_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`),
  ADD CONSTRAINT `custody_records_ibfk_3` FOREIGN KEY (`center_id`) REFERENCES `police_centers` (`id`),
  ADD CONSTRAINT `custody_records_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `digital_signatures`
--
ALTER TABLE `digital_signatures`
  ADD CONSTRAINT `digital_signatures_ibfk_1` FOREIGN KEY (`signed_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `document_templates`
--
ALTER TABLE `document_templates`
  ADD CONSTRAINT `document_templates_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `evidence`
--
ALTER TABLE `evidence`
  ADD CONSTRAINT `evidence_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evidence_ibfk_2` FOREIGN KEY (`collected_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `evidence_ibfk_3` FOREIGN KEY (`collected_from_person_id`) REFERENCES `persons` (`id`),
  ADD CONSTRAINT `evidence_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `evidence_ibfk_5` FOREIGN KEY (`last_edited_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `evidence_custody_log`
--
ALTER TABLE `evidence_custody_log`
  ADD CONSTRAINT `evidence_custody_log_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evidence_custody_log_ibfk_2` FOREIGN KEY (`performed_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `evidence_custody_log_ibfk_3` FOREIGN KEY (`witness_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `evidence_edit_history`
--
ALTER TABLE `evidence_edit_history`
  ADD CONSTRAINT `evidence_edit_history_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evidence_edit_history_ibfk_2` FOREIGN KEY (`edited_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evidence_file_versions`
--
ALTER TABLE `evidence_file_versions`
  ADD CONSTRAINT `evidence_file_versions_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evidence_file_versions_ibfk_2` FOREIGN KEY (`replaced_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `file_encryption_registry`
--
ALTER TABLE `file_encryption_registry`
  ADD CONSTRAINT `file_encryption_registry_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `investigation_notes`
--
ALTER TABLE `investigation_notes`
  ADD CONSTRAINT `investigation_notes_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `investigation_notes_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `investigation_notes_ibfk_3` FOREIGN KEY (`investigator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `investigation_notes_ibfk_4` FOREIGN KEY (`last_edited_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `investigation_reports`
--
ALTER TABLE `investigation_reports`
  ADD CONSTRAINT `fk_reports_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `investigation_reports_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `investigation_reports_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `investigation_reports_ibfk_3` FOREIGN KEY (`signed_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `investigation_timeline`
--
ALTER TABLE `investigation_timeline`
  ADD CONSTRAINT `investigation_timeline_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `investigation_timeline_ibfk_2` FOREIGN KEY (`investigator_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `note_edit_history`
--
ALTER TABLE `note_edit_history`
  ADD CONSTRAINT `note_edit_history_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `investigation_notes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `note_edit_history_ibfk_2` FOREIGN KEY (`edited_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `persons`
--
ALTER TABLE `persons`
  ADD CONSTRAINT `persons_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `person_aliases`
--
ALTER TABLE `person_aliases`
  ADD CONSTRAINT `person_aliases_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `report_approvals`
--
ALTER TABLE `report_approvals`
  ADD CONSTRAINT `fk_report_approvals_approver` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_report_approvals_report` FOREIGN KEY (`report_id`) REFERENCES `investigation_reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `report_settings`
--
ALTER TABLE `report_settings`
  ADD CONSTRAINT `fk_report_settings_center` FOREIGN KEY (`center_id`) REFERENCES `police_centers` (`id`) ON DELETE CASCADE ON UPDATE SET NULL,
  ADD CONSTRAINT `fk_report_settings_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE SET NULL,
  ADD CONSTRAINT `fk_report_settings_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE SET NULL;

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `system_settings_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`center_id`) REFERENCES `police_centers` (`id`);

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
