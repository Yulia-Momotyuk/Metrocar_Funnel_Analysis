-- =========================================
-- Revenue per User by Platform
-- =========================================
SELECT
    s.age_range,
    ad.platform,
    SUM(t.purchase_amount_usd) / COUNT(DISTINCT s.user_id) AS revenue_per_user
FROM transactions t
JOIN ride_requests rr 
    ON rr.ride_id = t.ride_id
JOIN signups s 
    ON s.user_id = rr.user_id
JOIN app_downloads ad 
    ON ad.app_download_key = s.session_id
WHERE t.charge_status = 'Approved'
GROUP BY s.age_range, ad.platform
ORDER BY s.age_range, ad.platform;





































