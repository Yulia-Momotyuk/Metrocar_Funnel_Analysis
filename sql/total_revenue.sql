-- =========================================
-- Total Revenue
-- =========================================
SELECT
    s.age_range,
    a.platform,
    SUM(t.purchase_amount_usd) AS total_revenue
FROM transactions t
JOIN ride_requests rr 
    ON rr.ride_id = t.ride_id
JOIN signups s 
    ON s.user_id = rr.user_id
JOIN app_downloads a 
    ON a.app_download_key = s.session_id
WHERE t.charge_status = 'Approved'
GROUP BY s.age_range, a.platform;



































