-- 1. Total users
SELECT COUNT(DISTINCT cookie_id) AS total_users
FROM clique_bait.events;

-- Expected Output:
-- | total_users :   1782 |


-- 2. Average cookies per user
SELECT ROUND(AVG(cookie_count),2) AS avg_cookies_per_user
FROM (
    SELECT cookie_id, COUNT(DISTINCT visit_id) AS cookie_count
    FROM clique_bait.events
    GROUP BY cookie_id
) AS user_cookie_counts;

-- Expected Output:
-- | avg_cookies_per_user : 2.00|
 
SELECT TO_CHAR(event_time, 'YYYY-MM') AS month,
       COUNT(DISTINCT visit_id) AS unique_visits
FROM clique_bait.events
GROUP BY TO_CHAR(event_time, 'YYYY-MM')
ORDER BY month;

-- Expected Output:
-- | month   | unique_visits |
-- |---------|---------------|
-- | 2020-01 |  876          |
-- | 2020-03 | 	916          |
-- | 2020-04 |  248          |
-- | 2020-05 |  36           |


