-- =========================================
-- Hourly Ride Distribution
-- =========================================
SELECT
    s.age_range,
    a.platform,
    EXTRACT(HOUR FROM rr.pickup_ts) AS ride_hour,
    COUNT(*) AS ride_count
FROM ride_requests rr
JOIN signups s 
    ON s.user_id = rr.user_id
JOIN app_downloads a 
    ON a.app_download_key = s.session_id
WHERE rr.pickup_ts IS NOT NULL
GROUP BY s.age_range, a.platform, ride_hour
ORDER BY s.age_range, a.platform, ride_hour;




































