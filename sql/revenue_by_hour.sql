-- =========================================
-- Revenue by Hour
-- =========================================
SELECT
    EXTRACT(HOUR FROM t.transaction_ts) AS hour,
    s.age_range,
    a.platform,
    SUM(t.purchase_amount_usd) AS revenue
FROM transactions t
JOIN ride_requests rr 
    ON t.ride_id = rr.ride_id
JOIN signups s 
    ON s.user_id = rr.user_id
JOIN app_downloads a 
    ON a.app_download_key = s.session_id
WHERE t.charge_status = 'Approved'
GROUP BY hour, s.age_range, a.platform
ORDER BY hour, s.age_range, a.platform;





































