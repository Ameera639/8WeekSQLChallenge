--How many customers has Foodie-Fi ever had?
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM subscriptions;

--What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

SELECT STRFTIME('%Y-%m-01', start_date) AS month_start,
       COUNT(*) AS trial_count
FROM subscriptions
WHERE plan_id = 0
GROUP BY month_start
ORDER BY month_start;

--What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

SELECT p.plan_name,
       COUNT(*) AS plan_count
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE start_date > '2020-12-31'
GROUP BY p.plan_name;

--What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

SELECT
  COUNT(DISTINCT customer_id) AS churned_customers,
  ROUND(100.0 * COUNT(DISTINCT customer_id) / 
        (SELECT COUNT(DISTINCT customer_id) FROM subscriptions), 1) AS churn_percentage
FROM subscriptions
WHERE plan_id = 4;

--How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

WITH first_trial AS (
  SELECT customer_id, MIN(start_date) AS trial_date
  FROM subscriptions
  WHERE plan_id = 0
  GROUP BY customer_id
)
SELECT COUNT(*) AS churn_after_trial,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions), 0) AS percentage
FROM subscriptions s
JOIN first_trial f ON s.customer_id = f.customer_id
WHERE s.plan_id = 4 AND s.start_date > f.trial_date;

--What is the number and percentage of customer plans after their initial free trial?
SELECT p.plan_name, 
       COUNT(*) AS plan_count,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM subscriptions WHERE plan_id != 0), 1) AS percentage
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE s.plan_id != 0   -- حددنا الجدول هنا s
GROUP BY p.plan_name;


--What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
SELECT p.plan_name, COUNT(*) AS customer_count,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions WHERE start_date <= '2020-12-31'), 1) AS percentage
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE start_date <= '2020-12-31'
GROUP BY p.plan_name;

--How many customers have upgraded to an annual plan in 2020?
SELECT COUNT(DISTINCT customer_id) AS upgraded_customers
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.plan_name LIKE '%annual%' AND start_date BETWEEN '2020-01-01' AND '2020-12-31';

--How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
WITH first_join AS (
  SELECT customer_id, MIN(start_date) AS join_date
  FROM subscriptions
  GROUP BY customer_id
)
SELECT ROUND(AVG(JULIANDAY(s.start_date) - JULIANDAY(f.join_date)),1) AS avg_days_to_annual
FROM subscriptions s
JOIN first_join f ON s.customer_id = f.customer_id
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.plan_name LIKE '%annual%';

--Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
-- 10. Breakdown average days to annual plan into 30-day periods
SELECT 
    CASE 
        WHEN days_to_annual BETWEEN 0 AND 30 THEN '0-30 days'
        WHEN days_to_annual BETWEEN 31 AND 60 THEN '31-60 days'
        WHEN days_to_annual BETWEEN 61 AND 90 THEN '61-90 days'
        WHEN days_to_annual BETWEEN 91 AND 120 THEN '91-120 days'
        ELSE '120+ days'
    END AS period_30_days,
    COUNT(*) AS customer_count
FROM (
    SELECT 
        s.customer_id,
        MIN(s.start_date) AS join_date,
        MIN(CASE WHEN p.plan_name = 'pro annual' THEN s.start_date END) AS annual_start,
        JULIANDAY(MIN(CASE WHEN p.plan_name = 'pro annual' THEN s.start_date END)) -
        JULIANDAY(MIN(s.start_date)) AS days_to_annual
    FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
    GROUP BY s.customer_id
    HAVING annual_start IS NOT NULL
) AS t
GROUP BY period_30_days
ORDER BY period_30_days;

--How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
-- 11. Customers who downgraded from pro monthly to basic monthly in 2020
SELECT COUNT(*) AS downgraded_customers
FROM (
    SELECT s1.customer_id
    FROM subscriptions s1
    JOIN subscriptions s2 
        ON s1.customer_id = s2.customer_id
        AND s1.start_date < s2.start_date
    JOIN plans p1 ON s1.plan_id = p1.plan_id
    JOIN plans p2 ON s2.plan_id = p2.plan_id
    WHERE p1.plan_name = 'pro monthly'
      AND p2.plan_name = 'basic monthly'
      AND strftime('%Y', s2.start_date) = '2020'
    GROUP BY s1.customer_id
) AS t;
