-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2026 at 09:33 AM
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
(13, 'CASE/XGD-01/2026/0001', 'OB/XGD-01/2026/0001', 8, '2026-01-02 19:54:00', '2026-01-12 17:55:37', 'suuqa yare kismayo', NULL, NULL, 'ninkaan ayaa wuxuu usoo dhacay dukaan  suuq yare ku yaalo isaga oo lagu eedeeye dhac', 'Tuugnimo', 'property', 'medium', 1, 'approved', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 14:59:33', NULL, '2026-01-12 14:59:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 14:55:37', '2026-01-12 14:59:33', 29, 28),
(14, 'CASE/XGD-01/2026/0002', 'OB/XGD-01/2026/0002', 8, '2025-12-27 22:41:00', '2026-01-14 22:41:39', 'agagaarka  badar', NULL, NULL, 'qarax ayaa ka dhacay', 'qarax', 'violent', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-14 22:41:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-14 19:41:39', '2026-01-14 19:46:13', 29, NULL),
(15, 'CASE/XGD-01/2026/0003', 'OB/XGD-01/2026/0003', 8, '2026-01-20 10:35:00', '2026-01-16 10:40:08', 'shaqaalaha', NULL, NULL, 'dab ayaa kacayfffffff', 'natural', 'property', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:40:08', '2026-01-16 07:40:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:40:08', '2026-01-16 07:40:08', 29, NULL),
(16, 'CASE/XGD-01/2026/0004', 'OB/XGD-01/2026/0004', 8, '2026-01-20 10:35:00', '2026-01-16 10:41:19', 'shaqaalaha', NULL, NULL, 'dab ayaa kacayfffffff', 'natural', 'property', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:41:19', '2026-01-16 07:41:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:41:19', '2026-01-16 07:41:19', 29, NULL),
(17, 'CASE/XGD-01/2026/0005', 'OB/XGD-01/2026/0005', 8, '2026-01-20 10:35:00', '2026-01-16 10:41:28', 'shaqaalaha', NULL, NULL, 'dab ayaa kacayfffffff', 'natural', 'property', 'medium', 1, 'draft', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:41:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:41:28', '2026-01-16 07:41:28', 29, NULL),
(18, 'CASE/XGD-01/2026/0006', 'OB/XGD-01/2026/0006', 8, '2026-01-16 10:43:00', '2026-01-16 10:41:59', 'kismayo', NULL, NULL, 'sdfsdfasdfasdfassas', 'sdsds', 'violent', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:41:59', '2026-01-16 07:41:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:41:59', '2026-01-16 07:41:59', 29, NULL),
(19, 'CASE/XGD-01/2026/0007', 'OB/XGD-01/2026/0007', 8, '2026-01-15 10:43:00', '2026-01-16 10:43:51', 'agagaarka  badar', NULL, NULL, 'qof ayaa badda ku dhintay', 'natural waaye', 'violent', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:43:51', '2026-01-16 07:43:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:43:51', '2026-01-16 07:43:51', 29, NULL),
(20, 'CASE/XGD-01/2026/0008', 'OB/XGD-01/2026/0008', 8, '2026-01-16 10:45:00', '2026-01-16 10:46:33', 'suuqa yare kismayo', NULL, NULL, 'bamb gacmeed ayaa la tuuray', 'dil', 'drug', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:46:33', '2026-01-16 07:46:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:46:33', '2026-01-16 07:46:33', 29, NULL),
(21, 'CASE/XGD-01/2026/0009', 'OB/XGD-01/2026/0009', 8, '2026-01-16 10:49:00', '2026-01-16 10:49:45', 'siinaay agteeda', NULL, NULL, 'siinaay ayaa qoys isku dagaale', 'sss', 'violent', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:49:45', '2026-01-16 07:49:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:49:45', '2026-01-16 07:49:45', 29, NULL),
(22, 'CASE/XGD-01/2026/0010', 'OB/XGD-01/2026/0010', 8, '2026-01-16 10:49:00', '2026-01-16 10:49:50', 'siinaay agteeda', NULL, NULL, 'siinaay ayaa qoys isku dagaale', 'sss', 'violent', 'medium', 0, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:49:50', '2026-01-16 07:49:50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:49:50', '2026-01-16 07:49:50', 29, NULL),
(23, 'CASE/XGD-01/2026/0011', 'OB/XGD-01/2026/0011', 8, '2026-01-16 10:49:00', '2026-01-16 10:52:46', 'siinaay agteeda', NULL, NULL, 'siinaay ayaa qoys isku dagaale', 'sss', 'violent', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:52:46', '2026-01-16 07:52:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:52:46', '2026-01-16 07:52:46', 29, NULL),
(24, 'CASE/XGD-01/2026/0012', 'OB/XGD-01/2026/0012', 8, '2026-01-16 10:53:00', '2026-01-16 10:53:49', 'xcvxcvxvxv', NULL, NULL, 'xcvxcvxczxcv', 'xcvzxczxc', 'drug', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:53:49', '2026-01-16 07:53:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:53:49', '2026-01-16 07:53:49', 29, NULL),
(25, 'CASE/XGD-01/2026/0013', 'OB/XGD-01/2026/0013', 8, '2026-01-16 10:53:00', '2026-01-16 10:56:38', 'xcvxcvxvxv', NULL, NULL, 'xcvxcvxczxcv', 'xcvzxczxc', 'drug', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:56:38', '2026-01-16 07:56:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:56:38', '2026-01-16 07:56:38', 29, NULL),
(26, 'CASE/XGD-01/2026/0014', 'OB/XGD-01/2026/0014', 8, '2026-01-16 10:57:00', '2026-01-16 10:58:09', 'kismayo', NULL, NULL, 'bhvhghghghgh', 'gghghg', 'violent', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 10:58:09', '2026-01-16 07:58:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 07:58:09', '2026-01-16 07:58:09', 29, NULL),
(27, 'CASE/XGD-01/2026/0015', 'OB/XGD-01/2026/0015', 8, '2026-01-16 11:03:00', '2026-01-16 11:03:43', 'hththt', NULL, NULL, 'thththtbghhh', 'hhhtt', 'cybercrime', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 11:03:43', '2026-01-16 08:03:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 08:03:43', '2026-01-16 08:03:43', 29, NULL),
(28, 'CASE/XGD-01/2026/0016', 'OB/XGD-01/2026/0016', 8, '2026-01-16 11:07:00', '2026-01-16 11:07:14', 'dffd', NULL, NULL, 'dfdddhfdfdf', 'dfdf', 'property', 'medium', 1, '', 'not_sent', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 11:07:14', '2026-01-16 08:07:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-16 08:07:14', '2026-01-16 08:07:14', 29, NULL);

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
-- Table structure for table `court_acknowledgments`
--

CREATE TABLE `court_acknowledgments` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `uploaded_at` datetime NOT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `court_acknowledgments`
--

INSERT INTO `court_acknowledgments` (`id`, `case_id`, `file_path`, `file_name`, `file_type`, `uploaded_at`, `uploaded_by`, `notes`) VALUES
(2, 10, 'uploads/court-acknowledgments/69681659cf2d7_1768429145.png', 'Gemini_Generated_Image_soj0kosoj0kosoj0.png', 'png', '2026-01-14 22:19:05', 26, '');

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
-- Table structure for table `custody_documentation`
--

CREATE TABLE `custody_documentation` (
  `id` int(11) NOT NULL,
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
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `custody_documentation`
--

INSERT INTO `custody_documentation` (`id`, `case_id`, `accused_person_id`, `custody_start`, `custody_end`, `custody_duration`, `custody_location`, `accused_photo`, `court_order_image`, `court_order_reference`, `notes`, `custody_status`, `release_reason`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 10, 13, '2026-01-06 00:52:00', NULL, NULL, 'Station Lock-up', NULL, 'uploads/court-orders/1768427588_32d1ea446f71d10e7340.jpeg', NULL, 'ninkaaan waala haynaaa', 'in_custody', NULL, '2026-01-14 21:53:08', 26, NULL, NULL),
(2, 10, 13, '2026-01-15 00:58:00', NULL, NULL, 'Station Lock-up', NULL, 'uploads/court-orders/1768427925_1913868b3d85cd105e40.jpeg', NULL, 'lama denaayo', 'in_custody', NULL, '2026-01-14 21:58:45', 26, NULL, NULL),
(3, 10, 14, '2026-01-14 22:05:00', '2026-01-18 22:05:00', '4 days', 'xabsiga kismayo', NULL, 'uploads/court-orders/1768428343_522e68f9f2539d13f39c.jpeg', NULL, 'walaa haynaa illa amar dambo', 'in_custody', NULL, '2026-01-14 22:05:43', 26, '2026-01-14 22:13:24', 26);

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
(1781, 9, '', 26, '2026-01-14 22:05:32', NULL, 'Evidence file downloaded by user', NULL),
(1782, 1, '', 26, '2026-01-14 22:52:22', NULL, 'Evidence file downloaded by user', NULL),
(1783, 5, '', 26, '2026-01-14 22:52:22', NULL, 'Evidence file downloaded by user', NULL),
(1784, 9, '', 26, '2026-01-14 22:52:24', NULL, 'Evidence file downloaded by user', NULL),
(1785, 1, '', 26, '2026-01-14 23:13:08', NULL, 'Evidence file downloaded by user', NULL),
(1786, 5, '', 26, '2026-01-14 23:13:08', NULL, 'Evidence file downloaded by user', NULL),
(1787, 9, '', 26, '2026-01-14 23:13:10', NULL, 'Evidence file downloaded by user', NULL),
(1788, 1, '', 26, '2026-01-14 23:14:21', NULL, 'Evidence file downloaded by user', NULL),
(1789, 5, '', 26, '2026-01-14 23:14:22', NULL, 'Evidence file downloaded by user', NULL),
(1790, 9, '', 26, '2026-01-14 23:14:24', NULL, 'Evidence file downloaded by user', NULL),
(1791, 1, '', 26, '2026-01-15 00:25:53', NULL, 'Evidence file downloaded by user', NULL),
(1792, 5, '', 26, '2026-01-15 00:25:54', NULL, 'Evidence file downloaded by user', NULL),
(1793, 9, '', 26, '2026-01-15 00:25:57', NULL, 'Evidence file downloaded by user', NULL),
(1794, 1, '', 26, '2026-01-15 00:28:50', NULL, 'Evidence file downloaded by user', NULL),
(1795, 5, '', 26, '2026-01-15 00:28:51', NULL, 'Evidence file downloaded by user', NULL),
(1796, 9, '', 26, '2026-01-15 00:28:52', NULL, 'Evidence file downloaded by user', NULL),
(1797, 1, '', 26, '2026-01-15 00:30:57', NULL, 'Evidence file downloaded by user', NULL),
(1798, 5, '', 26, '2026-01-15 00:30:58', NULL, 'Evidence file downloaded by user', NULL),
(1799, 9, '', 26, '2026-01-15 00:30:59', NULL, 'Evidence file downloaded by user', NULL),
(1800, 1, '', 26, '2026-01-15 00:33:32', NULL, 'Evidence file downloaded by user', NULL),
(1801, 5, '', 26, '2026-01-15 00:33:33', NULL, 'Evidence file downloaded by user', NULL),
(1802, 9, '', 26, '2026-01-15 00:33:35', NULL, 'Evidence file downloaded by user', NULL),
(1803, 1, '', 26, '2026-01-15 00:35:05', NULL, 'Evidence file downloaded by user', NULL),
(1804, 5, '', 26, '2026-01-15 00:35:05', NULL, 'Evidence file downloaded by user', NULL),
(1805, 9, '', 26, '2026-01-15 00:35:06', NULL, 'Evidence file downloaded by user', NULL),
(1806, 1, '', 26, '2026-01-15 00:37:31', NULL, 'Evidence file downloaded by user', NULL),
(1807, 5, '', 26, '2026-01-15 00:37:32', NULL, 'Evidence file downloaded by user', NULL),
(1808, 9, '', 26, '2026-01-15 00:37:32', NULL, 'Evidence file downloaded by user', NULL),
(1809, 1, '', 26, '2026-01-15 00:40:28', NULL, 'Evidence file downloaded by user', NULL),
(1810, 5, '', 26, '2026-01-15 00:40:29', NULL, 'Evidence file downloaded by user', NULL),
(1811, 9, '', 26, '2026-01-15 00:40:30', NULL, 'Evidence file downloaded by user', NULL),
(1812, 1, '', 26, '2026-01-15 00:42:16', NULL, 'Evidence file downloaded by user', NULL),
(1813, 5, '', 26, '2026-01-15 00:42:16', NULL, 'Evidence file downloaded by user', NULL),
(1814, 9, '', 26, '2026-01-15 00:42:18', NULL, 'Evidence file downloaded by user', NULL),
(1815, 1, '', 26, '2026-01-15 00:42:26', NULL, 'Evidence file downloaded by user', NULL),
(1816, 5, '', 26, '2026-01-15 00:42:27', NULL, 'Evidence file downloaded by user', NULL),
(1817, 9, '', 26, '2026-01-15 00:42:28', NULL, 'Evidence file downloaded by user', NULL),
(1818, 1, '', 26, '2026-01-15 00:42:43', NULL, 'Evidence file downloaded by user', NULL),
(1819, 5, '', 26, '2026-01-15 00:42:43', NULL, 'Evidence file downloaded by user', NULL),
(1820, 9, '', 26, '2026-01-15 00:42:43', NULL, 'Evidence file downloaded by user', NULL),
(1821, 1, '', 26, '2026-01-15 00:44:09', NULL, 'Evidence file downloaded by user', NULL),
(1822, 5, '', 26, '2026-01-15 00:44:10', NULL, 'Evidence file downloaded by user', NULL),
(1823, 9, '', 26, '2026-01-15 00:44:12', NULL, 'Evidence file downloaded by user', NULL),
(1824, 1, '', 26, '2026-01-15 00:45:27', NULL, 'Evidence file downloaded by user', NULL),
(1825, 5, '', 26, '2026-01-15 00:45:27', NULL, 'Evidence file downloaded by user', NULL),
(1826, 9, '', 26, '2026-01-15 00:45:29', NULL, 'Evidence file downloaded by user', NULL),
(1827, 1, '', 26, '2026-01-15 00:50:12', NULL, 'Evidence file downloaded by user', NULL),
(1828, 5, '', 26, '2026-01-15 00:50:12', NULL, 'Evidence file downloaded by user', NULL),
(1829, 9, '', 26, '2026-01-15 00:50:13', NULL, 'Evidence file downloaded by user', NULL),
(1830, 1, '', 26, '2026-01-15 00:50:48', NULL, 'Evidence file downloaded by user', NULL),
(1831, 5, '', 26, '2026-01-15 00:50:49', NULL, 'Evidence file downloaded by user', NULL),
(1832, 9, '', 26, '2026-01-15 00:50:51', NULL, 'Evidence file downloaded by user', NULL),
(1833, 1, '', 26, '2026-01-15 00:52:32', NULL, 'Evidence file downloaded by user', NULL),
(1834, 5, '', 26, '2026-01-15 00:52:33', NULL, 'Evidence file downloaded by user', NULL),
(1835, 9, '', 26, '2026-01-15 00:52:35', NULL, 'Evidence file downloaded by user', NULL),
(1836, 1, '', 26, '2026-01-15 00:57:58', NULL, 'Evidence file downloaded by user', NULL),
(1837, 5, '', 26, '2026-01-15 00:57:59', NULL, 'Evidence file downloaded by user', NULL),
(1838, 9, '', 26, '2026-01-15 00:58:00', NULL, 'Evidence file downloaded by user', NULL),
(1839, 1, '', 26, '2026-01-15 01:01:42', NULL, 'Evidence file downloaded by user', NULL),
(1840, 5, '', 26, '2026-01-15 01:01:43', NULL, 'Evidence file downloaded by user', NULL),
(1841, 9, '', 26, '2026-01-15 01:01:44', NULL, 'Evidence file downloaded by user', NULL),
(1842, 1, '', 26, '2026-01-15 01:05:03', NULL, 'Evidence file downloaded by user', NULL),
(1843, 5, '', 26, '2026-01-15 01:05:04', NULL, 'Evidence file downloaded by user', NULL),
(1844, 9, '', 26, '2026-01-15 01:05:05', NULL, 'Evidence file downloaded by user', NULL),
(1845, 1, '', 26, '2026-01-15 01:07:35', NULL, 'Evidence file downloaded by user', NULL),
(1846, 5, '', 26, '2026-01-15 01:07:36', NULL, 'Evidence file downloaded by user', NULL),
(1847, 9, '', 26, '2026-01-15 01:07:37', NULL, 'Evidence file downloaded by user', NULL),
(1848, 1, '', 26, '2026-01-15 01:09:04', NULL, 'Evidence file downloaded by user', NULL),
(1849, 5, '', 26, '2026-01-15 01:09:05', NULL, 'Evidence file downloaded by user', NULL),
(1850, 9, '', 26, '2026-01-15 01:09:07', NULL, 'Evidence file downloaded by user', NULL),
(1851, 1, '', 26, '2026-01-15 01:13:12', NULL, 'Evidence file downloaded by user', NULL),
(1852, 5, '', 26, '2026-01-15 01:13:13', NULL, 'Evidence file downloaded by user', NULL),
(1853, 9, '', 26, '2026-01-15 01:13:15', NULL, 'Evidence file downloaded by user', NULL),
(1854, 1, '', 26, '2026-01-15 01:14:56', NULL, 'Evidence file downloaded by user', NULL),
(1855, 5, '', 26, '2026-01-15 01:14:56', NULL, 'Evidence file downloaded by user', NULL),
(1856, 9, '', 26, '2026-01-15 01:14:58', NULL, 'Evidence file downloaded by user', NULL),
(1857, 1, '', 26, '2026-01-15 01:18:48', NULL, 'Evidence file downloaded by user', NULL),
(1858, 5, '', 26, '2026-01-15 01:18:48', NULL, 'Evidence file downloaded by user', NULL),
(1859, 9, '', 26, '2026-01-15 01:18:48', NULL, 'Evidence file downloaded by user', NULL),
(1860, 1, '', 26, '2026-01-15 13:32:32', NULL, 'Evidence file downloaded by user', NULL),
(1861, 5, '', 26, '2026-01-15 13:32:32', NULL, 'Evidence file downloaded by user', NULL),
(1862, 9, '', 26, '2026-01-15 13:32:34', NULL, 'Evidence file downloaded by user', NULL),
(1863, 1, '', 26, '2026-01-16 07:41:34', NULL, 'Evidence file downloaded by user', NULL),
(1864, 5, '', 26, '2026-01-16 07:41:35', NULL, 'Evidence file downloaded by user', NULL),
(1865, 9, '', 26, '2026-01-16 07:41:36', NULL, 'Evidence file downloaded by user', NULL);

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
-- Table structure for table `medical_examination_forms`
--

CREATE TABLE `medical_examination_forms` (
  `id` int(11) UNSIGNED NOT NULL,
  `case_id` int(11) UNSIGNED NOT NULL,
  `person_id` int(11) UNSIGNED DEFAULT NULL,
  `case_number` varchar(100) DEFAULT NULL,
  `patient_name` varchar(255) NOT NULL,
  `party_type` enum('victim','accused','witness','other') DEFAULT NULL,
  `form_data` longtext NOT NULL COMMENT 'JSON data of complete form',
  `qr_code` varchar(255) DEFAULT NULL,
  `verification_code` varchar(100) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `hospital_name` varchar(255) DEFAULT NULL,
  `examination_date` date DEFAULT NULL,
  `created_by` int(11) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medical_examination_forms`
--

INSERT INTO `medical_examination_forms` (`id`, `case_id`, `person_id`, `case_number`, `patient_name`, `party_type`, `form_data`, `qr_code`, `verification_code`, `report_date`, `hospital_name`, `examination_date`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:17:47.233Z\",\"case_id\":\"10\"}', NULL, 'MED-00000001-D18B62', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:17:47', '2026-01-16 05:50:51'),
(2, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:18\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:18:07.471Z\",\"case_id\":\"12\"}', NULL, 'MED-00000002-49CEAA', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:18:07', '2026-01-16 05:50:51'),
(3, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:18\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:18:28.773Z\",\"case_id\":\"12\"}', NULL, 'MED-00000003-8413CF', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:18:29', '2026-01-16 05:50:51'),
(4, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"swal2-textarea\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"swal2-checkbox\":false,\"saved_at\":\"2026-01-16T05:19:05.699Z\",\"case_id\":\"12\"}', NULL, 'MED-00000004-51FA69', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:19:06', '2026-01-16 05:50:51'),
(5, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:19:29.378Z\",\"case_id\":\"12\"}', NULL, 'MED-00000005-0330E0', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:19:29', '2026-01-16 05:50:51'),
(6, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:19:54.828Z\",\"case_id\":\"12\"}', NULL, 'MED-00000006-FF99F1', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:19:55', '2026-01-16 05:50:51'),
(7, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:19:59.375Z\",\"case_id\":\"12\"}', NULL, 'MED-00000007-0FC0F8', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:19:59', '2026-01-16 05:50:51'),
(8, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:20:29.364Z\",\"case_id\":\"12\"}', NULL, 'MED-00000008-FC83C2', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:20:29', '2026-01-16 05:50:51'),
(9, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:20:59.376Z\",\"case_id\":\"12\"}', NULL, 'MED-00000009-EB2BED', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:20:59', '2026-01-16 05:50:51'),
(10, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:21:10.806Z\",\"case_id\":\"12\"}', NULL, 'MED-00000010-C84B40', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:21:11', '2026-01-16 05:50:51'),
(11, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:21:29.369Z\",\"case_id\":\"12\"}', NULL, 'MED-00000011-D59EF7', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:21:29', '2026-01-16 05:50:51'),
(12, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:21:59.377Z\",\"case_id\":\"12\"}', NULL, 'MED-00000012-3F444D', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:21:59', '2026-01-16 05:50:51'),
(13, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:22:29.378Z\",\"case_id\":\"12\"}', NULL, 'MED-00000013-8BB9C2', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:22:29', '2026-01-16 05:50:51'),
(14, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:22:59.369Z\",\"case_id\":\"12\"}', NULL, 'MED-00000014-DC2F20', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:22:59', '2026-01-16 05:50:51'),
(15, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:19\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:38:50.991Z\",\"case_id\":\"12\"}', NULL, 'MED-00000015-5912DB', '2026-01-16', NULL, '2026-01-16', 26, '2026-01-16 02:38:51', '2026-01-16 05:50:51'),
(16, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"dddd\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:51:39.876Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000016-50C40E&choe=UTF-8', 'MED-00000016-50C40E', '2026-01-16', 'dddd', '2026-01-16', 26, '2026-01-16 02:51:40', '2026-01-16 02:51:40'),
(17, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"fghjk\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:54:21.609Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000017-70930E&choe=UTF-8', 'MED-00000017-70930E', '2026-01-16', 'fghjk', '2026-01-16', 26, '2026-01-16 02:54:22', '2026-01-16 02:54:22');
INSERT INTO `medical_examination_forms` (`id`, `case_id`, `person_id`, `case_number`, `patient_name`, `party_type`, `form_data`, `qr_code`, `verification_code`, `report_date`, `hospital_name`, `examination_date`, `created_by`, `created_at`, `updated_at`) VALUES
(18, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"fgff\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"ffff\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:55:07.200Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000018-2E61C5&choe=UTF-8', 'MED-00000018-2E61C5', '2026-01-16', 'fgff', '2026-01-16', 26, '2026-01-16 02:55:07', '2026-01-16 02:55:07'),
(19, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"kismayo general hospital\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"jeylani geedi farax\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:57:26.263Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000019-38E6CA&choe=UTF-8', 'MED-00000019-38E6CA', '2026-01-16', 'kismayo general hospital', '2026-01-16', 26, '2026-01-16 02:57:26', '2026-01-16 02:57:26'),
(20, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"kismayo general hospital\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"jeylani geedi farax\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T05:58:36.833Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000020-0A9F0C&choe=UTF-8', 'MED-00000020-0A9F0C', '2026-01-16', 'kismayo general hospital', '2026-01-16', 26, '2026-01-16 02:58:40', '2026-01-16 02:58:40'),
(21, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"kismayo general hospital\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"yy\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"verification_time\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T06:01:15.895Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000021-B1534B&choe=UTF-8', 'MED-00000021-B1534B', '2026-01-16', 'kismayo general hospital', '2026-01-16', 26, '2026-01-16 03:01:16', '2026-01-16 03:01:16'),
(22, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"ttt\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"verification_time\":\"\",\"pregnant_yes\":true,\"pregnant_no\":false,\"intoxicated_yes\":true,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T06:01:55.404Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000022-F9C5FC&choe=UTF-8', 'MED-00000022-F9C5FC', '2026-01-16', 'ttt', '2026-01-16', 26, '2026-01-16 03:01:55', '2026-01-16 03:01:55'),
(23, 10, 12, 'CASE/kcjd-r/2025/0001', 'abdi  noor farax', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"fghjk\",\"victim_name\":\"abdi  noor farax\",\"accused_name\":\"mohamed hussein dhalahow\",\"age\":\"24 years\",\"location\":\"kismayo\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 646464\",\"patient_name\":\"abdi  noor farax\",\"admission_number\":\"47474747\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"08:16\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"verification_time\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T06:04:59.207Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000023-66A73F&choe=UTF-8', 'MED-00000023-66A73F', '2026-01-16', 'fghjk', '2026-01-16', 26, '2026-01-16 03:04:59', '2026-01-16 03:04:59'),
(24, 10, 15, 'CASE/kcjd-r/2025/0001', 'nimco yare abdu', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2025/0001\",\"hospital_name\":\"horseee\",\"victim_name\":\"nimco yare abdu\",\"accused_name\":\"sss\",\"age\":\"24 years\",\"location\":\"kismayoshaqaaalaha\",\"incident_datetime\":\"2025-12-01 01:33:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 67777\",\"patient_name\":\"nimco yare abdu\",\"admission_number\":\"78876\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"09:06\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"hh\",\"evidence_vaginal_swab\":\"yy\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"verification_time\":\"\",\"pregnant_yes\":true,\"pregnant_no\":false,\"intoxicated_yes\":true,\"intoxicated_no\":false,\"eyes_yes\":true,\"eyes_no\":false,\"mouth_yes\":true,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":true,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":true,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"verifier_signature\":\"data:image/png;base64,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\",\"saved_at\":\"2026-01-16T06:07:11.738Z\",\"case_id\":\"10\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2F%2Fverify-medical-form%3Fcode%3DMED-00000024-F71DDB&choe=UTF-8', 'MED-00000024-F71DDB', '2026-01-16', 'horseee', '2026-01-16', 26, '2026-01-16 03:07:12', '2026-01-16 03:07:12'),
(25, 12, 25, 'CASE/kcjd-r/2026/0002', 'maryam  abdi dhubow', '', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"bbb\",\"victim_name\":\"maryam  abdi dhubow\",\"accused_name\":\"\",\"age\":\"\",\"location\":\"wadada aargo siinaaay\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 061500000\",\"patient_name\":\"maryam  abdi dhubow\",\"admission_number\":\"383883\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"09:13\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"verification_time\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T06:13:24.910Z\",\"case_id\":\"12\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2Fverify-medical-form%3Fcode%3DMED-00000025-33B7E2&choe=UTF-8', 'MED-00000025-33B7E2', '2026-01-16', 'bbb', '2026-01-16', 26, '2026-01-16 03:13:25', '2026-01-16 03:13:25'),
(26, 12, 26, 'CASE/kcjd-r/2026/0002', 'jeylani  geedi farax', 'accused', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"fghjk\",\"victim_name\":\"\",\"accused_name\":\"jeylani  geedi farax\",\"age\":\"\",\"location\":\"sgaqaalaha dhinaca vafmadow\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 0614112537\",\"patient_name\":\"jeylani  geedi farax\",\"admission_number\":\"88383\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"09:18\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"verification_time\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"saved_at\":\"2026-01-16T06:18:34.445Z\",\"case_id\":\"12\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2Fverify-medical-form%3Fcode%3DMED-00000026-F258CB&choe=UTF-8', 'MED-00000026-F258CB', '2026-01-16', 'fghjk', '2026-01-16', 26, '2026-01-16 03:18:34', '2026-01-16 03:18:34'),
(27, 12, 26, 'CASE/kcjd-r/2026/0002', 'jeylani  geedi farax', 'accused', '{\"caseSearchInput\":\"\",\"report_date\":\"2026-01-16\",\"case_number\":\"CASE/kcjd-r/2026/0002\",\"hospital_name\":\"fghjk\",\"victim_name\":\"\",\"accused_name\":\"jeylani  geedi farax\",\"age\":\"\",\"location\":\"sgaqaalaha dhinaca vafmadow\",\"incident_datetime\":\"2026-01-10 12:58:00\",\"police_report_datetime\":\"\",\"crime_description\":\"\",\"kidnapping_status\":\"\",\"hospital_submission_date\":\"\",\"police_station\":\"\",\"ob_number\":\"\",\"officer_name\":\"mohamed hussein dhalahow\",\"officer_rank\":\"\",\"officer_position\":\"\",\"officer_phone\":\"\",\"exam_date\":\"\",\"reference\":\"Contact: 0614112537\",\"patient_name\":\"jeylani  geedi farax\",\"admission_number\":\"88383\",\"examination_date\":\"2026-01-16\",\"examination_time\":\"09:18\",\"assault_type\":\"\",\"post_assault_hygiene\":\"\",\"assault_details\":\"\",\"personal_history\":\"\",\"gynecological_history\":\"\",\"pregnancy_months\":\"\",\"last_period\":\"\",\"children_count\":\"\",\"height\":\"\",\"weight\":\"\",\"body_build\":\"\",\"temperature\":\"\",\"pulse\":\"\",\"blood_pressure\":\"\",\"respiration\":\"\",\"eyes_details\":\"\",\"mouth_details\":\"\",\"scalp_details\":\"\",\"neck_details\":\"\",\"swab_details\":\"\",\"findings_details\":\"\",\"anal_exam_details\":\"\",\"evidence_dna\":\"\",\"evidence_vaginal_swab\":\"\",\"evidence_pubic_hair\":\"\",\"evidence_body_hair\":\"\",\"evidence_head_hair\":\"\",\"evidence_foreign_swab\":\"\",\"evidence_foreign_hair\":\"\",\"evidence_clothing\":\"\",\"evidence_blood_stain\":\"\",\"doctor_name\":\"\",\"doctor_phone\":\"\",\"doctor_email\":\"\",\"injury_description\":\"\",\"injury_age\":\"\",\"weapon_type\":\"\",\"prior_treatment\":\"\",\"medical_assessment\":\"\",\"verifier_name\":\"\",\"verifier_position\":\"\",\"verification_date\":\"\",\"verification_time\":\"\",\"pregnant_yes\":false,\"pregnant_no\":false,\"intoxicated_yes\":false,\"intoxicated_no\":false,\"eyes_yes\":false,\"eyes_no\":false,\"mouth_yes\":false,\"mouth_no\":false,\"scalp_yes\":false,\"scalp_no\":false,\"neck_yes\":false,\"neck_no\":false,\"swab_vaginal_yes\":false,\"swab_vaginal_no\":false,\"swab_anal_yes\":false,\"swab_anal_no\":false,\"finding_murux\":false,\"finding_dilaac\":false,\"finding_dhiig_gaduudan\":false,\"finding_dhiig_hoorsi\":false,\"anal_exam_yes\":false,\"anal_exam_no\":false,\"photos_yes\":false,\"photos_no\":false,\"doctor_senior\":false,\"doctor_experienced\":false,\"injury_head_neck\":false,\"injury_chest_abdomen\":false,\"injury_upper_limbs\":false,\"injury_lower_limbs\":false,\"injury_other\":false,\"injury_minor\":false,\"injury_serious\":false,\"injury_very_serious\":false,\"verifier_signature\":\"data:image/png;base64,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\",\"saved_at\":\"2026-01-16T06:23:52.582Z\",\"case_id\":\"12\"}', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http%3A%2F%2Flocalhost%3A8080%2Fverify-medical-form%3Fcode%3DMED-00000027-4D5314&choe=UTF-8', 'MED-00000027-4D5314', '2026-01-16', 'fghjk', '2026-01-16', 26, '2026-01-16 03:23:52', '2026-01-16 03:23:52');

-- --------------------------------------------------------

--
-- Table structure for table `non_criminal_certificates`
--

CREATE TABLE `non_criminal_certificates` (
  `id` int(10) UNSIGNED NOT NULL,
  `certificate_number` varchar(100) NOT NULL,
  `person_id` int(10) UNSIGNED DEFAULT NULL,
  `person_name` varchar(255) NOT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `gender` enum('MALE','FEMALE','male','female') NOT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_place` varchar(255) DEFAULT NULL,
  `photo_path` longtext DEFAULT NULL COMMENT 'Base64 encoded photo or file path',
  `purpose` text DEFAULT NULL,
  `validity_period` varchar(50) DEFAULT '6 months',
  `issue_date` date NOT NULL,
  `director_name` varchar(255) DEFAULT NULL,
  `director_signature` text DEFAULT NULL,
  `issued_by` int(10) UNSIGNED NOT NULL,
  `verification_token` varchar(64) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `verification_count` int(11) DEFAULT 0,
  `last_verified_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `non_criminal_certificates`
--

INSERT INTO `non_criminal_certificates` (`id`, `certificate_number`, `person_id`, `person_name`, `mother_name`, `gender`, `birth_date`, `birth_place`, `photo_path`, `purpose`, `validity_period`, `issue_date`, `director_name`, `director_signature`, `issued_by`, `verification_token`, `is_active`, `verification_count`, `last_verified_at`, `notes`, `created_at`, `updated_at`) VALUES
(5, 'JPFHQ/CID/NC:7457/2026', NULL, 'mohamed badhey', 'maryan hussien', 'MALE', '2025-10-29', 'KISMAIO, SOMALIA', 'data:image/jpeg;base64,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', '', '6 months', '2026-01-15', 'Omar Hujale Abdi', 'data:image/png;base64,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', 26, 'dfa92fefa4abc0e2f8042a6e6c2535114887520a50f6fb3157d303b100b98c44', 1, 0, NULL, NULL, '2026-01-15 20:34:11', '2026-01-16 04:40:16');

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
(1, 10, 'status_changed', 'New Case for Court', 'Case #CASE/kcjd-r/2025/0001 has been sent to court for review.', 'case', 10, '/court/cases/view/10', 0, NULL, 'high', '2026-01-02 20:26:29', NULL),
(2, 28, 'system_alert', 'Incident Reported (No Parties)', 'Incident case CASE/XGD-01/2026/0015 has been reported and needs investigator assignment', 'cases', 27, '/cases/view/27', 0, NULL, 'medium', '2026-01-16 08:03:43', NULL),
(3, 28, 'system_alert', 'Incident Reported (No Parties)', 'Incident case CASE/XGD-01/2026/0016 has been reported and needs investigator assignment', 'cases', 28, '/cases/view/28', 0, NULL, 'medium', '2026-01-16 08:07:14', NULL);

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
(1, NULL, 'header_image', 'reports/headers/report_header_1768511275.png', 'image', 'Report header image/logo (shared by all reports)', 1, NULL, NULL, '2026-01-10 12:09:51', '2026-01-15 18:07:55'),
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
(21, 7, 'abdi', 'mohamedbadhey@gmail.com', '', 'mohamed hussein dhalahow', '1234433', 'admin', '677', 'en', 1, NULL, 5, '2026-01-16 08:05:28', '2025-12-29 13:55:51', '2026-01-16 07:35:28', 1),
(22, 7, 'farax', 'admin@foodorder.com', '', 'mohamed hussein dhalahow', '1234433', 'admin', '6644', 'en', 1, NULL, 4, NULL, '2025-12-29 13:58:49', '2025-12-29 17:18:04', 1),
(23, 7, 'moha', 'fomir64223@gardsiir.com', '$2y$12$MiGkjvtc2qrGQflQjpjNLOjIRqQVeHcf.NfQjP1N07okiXihZt5aO', 'mohamed hussein dhalahow', '1234433', 'admin', '6644', 'en', 1, '2026-01-11 07:08:01', 0, NULL, '2025-12-30 21:36:02', '2026-01-11 07:08:01', 1),
(24, 6, 'obuser', 'badhey14@gmail.com', '$2y$12$W.14q6a.mxkFq6YviPU7MOYRqfmJf/WErjWebjBrQE8WsnbMqmMeC', 'mohamed hussein dhalaho', '7474', 'ob_officer', '6464', 'en', 1, '2025-12-30 22:27:46', 0, NULL, '2025-12-30 21:38:21', '2025-12-30 22:27:46', 1),
(25, 7, 'obuser1', 'badwwhey14@gmail.com', '$2y$12$ixrMq99aSKXWfdHkBAFwfeZJ8ndXyVu.h/KylkYa14s6LWawJ18fa', 'mohamed hussein dhalahow', '1234433', 'ob_officer', '', 'en', 1, '2026-01-11 07:09:30', 0, NULL, '2025-12-30 22:30:50', '2026-01-11 07:09:30', 1),
(26, 7, 'baare', 'adeemin@foodorder.com', '$2y$12$84zKtbOlWf1nUnut.mEt4.tjpMA9x9K97AZu/uGEnNbFTfFh2/bhm', 'mohamed hussein dhalahow', '12344', 'investigator', '455', 'en', 1, '2026-01-16 08:06:32', 0, NULL, '2025-12-30 22:36:25', '2026-01-16 08:06:32', 1),
(27, 7, 'court', 'mohameeeedbadhey@gmail.com', '$2y$12$tFzXpu75WXHaxOs2BTVJU.CvEe3JPLdT1aY/Jhd6rVG4cnUty82jS', 'mohamed hussein dhalahow', '1234433', 'court_user', '6464', 'en', 1, '2026-01-03 08:58:46', 0, NULL, '2026-01-03 08:12:05', '2026-01-03 08:58:46', 1),
(28, 8, 'abdixakin', 'admin@teekoob.com', '$2y$12$PjW0V2tf4oxmsHDd./6jpeoB3vwUvZnFoErp/kBeTANggublz0Htm', 'abdixakin taliye', '061636363', 'admin', '6363', 'en', 1, '2026-01-16 08:18:23', 0, NULL, '2026-01-12 11:22:17', '2026-01-16 08:18:23', 1),
(29, 8, 'abdu', 'abdu@gmail.com', '$2y$12$Y/KKDibI4O9oC4QNwjMTwO3ryNz6m4OZTaiVl9nQsggIF4QqsVSfi', 'abdullahi siciid abdullahi', '0618189239', 'ob_officer', '7272', 'en', 1, '2026-01-16 08:06:55', 0, NULL, '2026-01-12 11:23:49', '2026-01-16 08:06:55', 1),
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
(150, 30, 'f28e05227473d2883aa8dc1e2e37ad573e5b1600358d7e6f492813acd9fcfe3b', '87741cc862733f7a050ad77c3f1acc38a4ee17d0a9977b650c3a382ef9c11855', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-12 15:37:16', '2026-01-12 15:07:16'),
(151, 30, '145424c6c3f1f9f5b06e57772cbf4f03b9d811c99376e2a895d79060c3bc0ab2', '7ea03dcfb3d998f96c2ea318cad300ff39a5add86404871057928867d5d64fb9', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-12 16:18:06', '2026-01-12 15:48:06');

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
-- Indexes for table `court_acknowledgments`
--
ALTER TABLE `court_acknowledgments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `idx_uploaded_at` (`uploaded_at`);

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
-- Indexes for table `custody_documentation`
--
ALTER TABLE `custody_documentation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `accused_person_id` (`accused_person_id`),
  ADD KEY `custody_status` (`custody_status`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_custody_start` (`custody_start`),
  ADD KEY `idx_custody_end` (`custody_end`);

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
-- Indexes for table `medical_examination_forms`
--
ALTER TABLE `medical_examination_forms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `verification_code` (`verification_code`),
  ADD KEY `idx_case_id` (`case_id`),
  ADD KEY `idx_person_id` (`person_id`),
  ADD KEY `idx_created_by` (`created_by`),
  ADD KEY `idx_report_date` (`report_date`),
  ADD KEY `idx_case_number` (`case_number`),
  ADD KEY `idx_patient_name` (`patient_name`(191)),
  ADD KEY `idx_verification_code` (`verification_code`);

--
-- Indexes for table `non_criminal_certificates`
--
ALTER TABLE `non_criminal_certificates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `certificate_number` (`certificate_number`),
  ADD UNIQUE KEY `verification_token` (`verification_token`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

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
-- AUTO_INCREMENT for table `court_acknowledgments`
--
ALTER TABLE `court_acknowledgments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
-- AUTO_INCREMENT for table `custody_documentation`
--
ALTER TABLE `custody_documentation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1866;

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
-- AUTO_INCREMENT for table `medical_examination_forms`
--
ALTER TABLE `medical_examination_forms`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `non_criminal_certificates`
--
ALTER TABLE `non_criminal_certificates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `note_edit_history`
--
ALTER TABLE `note_edit_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

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
