-- =========================================
-- Successful Trips Overview
-- =========================================
SELECT
    s.age_range,
    a.platform,
    COUNT(DISTINCT rr.ride_id) AS successful_trips
FROM ride_requests rr
JOIN signups s 
    ON s.user_id = rr.user_id
JOIN app_downloads a 
    ON a.app_download_key = s.session_id
WHERE rr.dropoff_ts IS NOT NULL
GROUP BY s.age_range, a.platform;




































