-- Test queries for Solved Cases Feature

-- 1. Check Investigator-Solved Cases (closed without sending to court)
SELECT 
    c.case_number,
    c.ob_number,
    c.crime_type,
    c.crime_category,
    c.priority,
    c.status,
    c.court_status,
    c.closed_date,
    pc.center_name,
    u.full_name as closed_by_name,
    u.badge_number
FROM cases c
LEFT JOIN police_centers pc ON pc.id = c.center_id
LEFT JOIN users u ON u.id = c.closed_by
WHERE c.status = 'closed' 
  AND c.court_status = 'not_sent'
ORDER BY c.closed_date DESC;

-- 2. Check Court-Solved Cases (sent to court and closed by court)
SELECT 
    c.case_number,
    c.ob_number,
    c.crime_type,
    c.crime_category,
    c.priority,
    c.court_status,
    c.sent_to_court_date,
    c.closed_date,
    pc.center_name,
    sender.full_name as sent_by_name,
    sender.badge_number as sent_by_badge
FROM cases c
LEFT JOIN police_centers pc ON pc.id = c.center_id
LEFT JOIN users sender ON sender.id = c.sent_to_court_by
WHERE c.court_status = 'court_closed'
ORDER BY c.closed_date DESC;

-- 3. Summary Statistics
SELECT 
    'Investigator Solved' as resolution_type,
    COUNT(*) as total_cases
FROM cases 
WHERE status = 'closed' AND court_status = 'not_sent'
UNION ALL
SELECT 
    'Court Solved' as resolution_type,
    COUNT(*) as total_cases
FROM cases 
WHERE court_status = 'court_closed';

-- 4. Check if there are any test cases available
SELECT 
    'Total Closed Cases' as category,
    COUNT(*) as count
FROM cases 
WHERE status = 'closed'
UNION ALL
SELECT 
    'Cases Sent to Court' as category,
    COUNT(*) as count
FROM cases 
WHERE court_status != 'not_sent';
