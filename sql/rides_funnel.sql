-- =========================================
-- Rides Funnel Query
-- =========================================
SELECT
    s.age_range AS age_group,
    ad.platform,
    COUNT(*) AS ride_requested,
    COUNT(*) FILTER (WHERE rr.accept_ts IS NOT NULL) AS ride_accepted,
    COUNT(*) FILTER (WHERE rr.dropoff_ts IS NOT NULL) AS ride_completed,
    COUNT(*) FILTER (WHERE t.charge_status = 'Approved') AS ride_paid,
    COUNT(DISTINCT r.review_id) AS ride_reviewed
FROM ride_requests rr
JOIN signups s 
    ON s.user_id = rr.user_id
JOIN app_downloads ad 
    ON s.session_id = ad.app_download_key
LEFT JOIN transactions t 
    ON t.ride_id = rr.ride_id
LEFT JOIN reviews r 
    ON r.ride_id = rr.ride_id
GROUP BY s.age_range, ad.platform
ORDER BY s.age_range, ad.platform;



































