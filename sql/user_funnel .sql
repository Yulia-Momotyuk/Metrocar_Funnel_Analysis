-- =========================================
-- User Funnel Query for Metrocar
-- =========================================

WITH downloads_with_signup AS (
    SELECT
        d.app_download_key,
        d.platform,
        d.download_ts,
        s.user_id,
        s.signup_ts,
        s.age_range
    FROM app_downloads d
    LEFT JOIN signups s 
        ON s.session_id = d.app_download_key
),

user_funnel AS (
    SELECT
        rr.user_id,
        MIN(rr.request_ts) AS first_request_ts,
        MIN(rr.accept_ts) 
            FILTER (WHERE rr.accept_ts IS NOT NULL) AS first_accept_ts,
        MIN(rr.dropoff_ts) 
            FILTER (WHERE rr.dropoff_ts IS NOT NULL) AS first_dropoff_ts,
        MIN(t.transaction_ts) 
            FILTER (WHERE t.charge_status = 'Approved') AS first_payment_ts,
        MIN(r.review_id) AS first_review_id
    FROM ride_requests rr
    LEFT JOIN transactions t 
        ON rr.ride_id = t.ride_id
    LEFT JOIN reviews r 
        ON rr.ride_id = r.ride_id
    GROUP BY rr.user_id
)

SELECT
    d.age_range,
    d.platform,
    COUNT(DISTINCT d.app_download_key) AS downloads,
    COUNT(DISTINCT d.user_id) 
        FILTER (WHERE d.signup_ts IS NOT NULL) AS signups,
    COUNT(DISTINCT d.user_id) 
        FILTER (WHERE uf.first_request_ts IS NOT NULL) AS requested,
    COUNT(DISTINCT d.user_id) 
        FILTER (WHERE uf.first_accept_ts IS NOT NULL) AS accepted,
    COUNT(DISTINCT d.user_id) 
        FILTER (WHERE uf.first_dropoff_ts IS NOT NULL) AS completed,
    COUNT(DISTINCT d.user_id) 
        FILTER (WHERE uf.first_payment_ts IS NOT NULL) AS paid,
    COUNT(DISTINCT d.user_id) 
        FILTER (WHERE uf.first_review_id IS NOT NULL) AS reviewed
FROM downloads_with_signup d
LEFT JOIN user_funnel uf 
    ON d.user_id = uf.user_id
GROUP BY 
    d.age_range, 
    d.platform
ORDER BY 
    d.age_range, 
    d.platform;


































