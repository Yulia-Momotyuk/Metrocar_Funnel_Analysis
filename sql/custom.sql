-- =========================================
-- Custom SQL: Ride Requests Base Table
-- =========================================
WITH base AS (
    SELECT
        rr.ride_id,
        rr.user_id,
        rr.request_ts,
        rr.accept_ts,
        rr.pickup_ts,
        rr.dropoff_ts,
        rr.cancel_ts,
        CASE WHEN rr.accept_ts IS NOT NULL THEN 1 ELSE 0 END AS is_accepted,
        CASE WHEN rr.pickup_ts IS NOT NULL THEN 1 ELSE 0 END AS is_picked_up,
        CASE WHEN rr.dropoff_ts IS NOT NULL THEN 1 ELSE 0 END AS is_completed,
        CASE WHEN rr.cancel_ts IS NOT NULL THEN 1 ELSE 0 END AS is_cancelled,
        EXTRACT(DOW FROM rr.request_ts) AS day_of_week,
        EXTRACT(HOUR FROM rr.request_ts) AS hour_of_day,
        EXTRACT(EPOCH FROM rr.pickup_ts - rr.accept_ts) / 60 AS wait_time_min,
        CASE
            WHEN EXTRACT(EPOCH FROM rr.pickup_ts - rr.accept_ts) / 60 < 1 THEN '0-1 min'
            WHEN EXTRACT(EPOCH FROM rr.pickup_ts - rr.accept_ts) / 60 BETWEEN 1 AND 3 THEN '1-3 min'
            WHEN EXTRACT(EPOCH FROM rr.pickup_ts - rr.accept_ts) / 60 BETWEEN 3 AND 5 THEN '3-5 min'
            WHEN EXTRACT(EPOCH FROM rr.pickup_ts - rr.accept_ts) / 60 BETWEEN 5 AND 10 THEN '5-10 min'
            ELSE '10+ min'
        END AS wait_time_group,
        s.age_range,
        ad.platform
    FROM ride_requests rr
    LEFT JOIN signups s 
        ON rr.user_id = s.user_id
    LEFT JOIN app_downloads ad 
        ON s.session_id = ad.app_download_key
    WHERE rr.request_ts IS NOT NULL
)
SELECT *
FROM base;



































