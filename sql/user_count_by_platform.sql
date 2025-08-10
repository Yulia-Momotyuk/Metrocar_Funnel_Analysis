-- =========================================
-- User Count by Platform
-- =========================================
SELECT
    s.age_range,
    a.platform,
    COUNT(DISTINCT s.user_id) AS total_users
FROM signups s
JOIN app_downloads a 
    ON a.app_download_key = s.session_id
GROUP BY s.age_range, a.platform;




































