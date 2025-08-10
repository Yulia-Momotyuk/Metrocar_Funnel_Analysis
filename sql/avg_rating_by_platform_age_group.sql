-- =========================================
-- Average Rating by Platform & Age Group
-- =========================================
SELECT
    s.age_range,
    a.platform,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(DISTINCT r.review_id) AS total_reviews
FROM reviews r
JOIN ride_requests rr 
    ON rr.ride_id = r.ride_id
JOIN signups s 
    ON s.user_id = r.user_id
JOIN app_downloads a 
    ON a.app_download_key = s.session_id
GROUP BY s.age_range, a.platform;




































