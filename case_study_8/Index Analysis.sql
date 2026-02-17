DROP TABLE IF EXISTS filtered_metrics;

CREATE TABLE filtered_metrics AS
SELECT m.*
FROM fresh_segments.interest_metrics m
JOIN (
    SELECT interest_id
    FROM fresh_segments.interest_metrics
    GROUP BY interest_id
    HAVING COUNT(DISTINCT month_year) >= 6
) f
ON m.interest_id = f.interest_id;

DROP TABLE IF EXISTS metrics_avg_comp;

CREATE TABLE metrics_avg_comp AS
SELECT
    m.interest_id,
    m.month_year,
    m.composition,
    m.index_value,
    ROUND( (CAST(m.composition AS NUMERIC) / NULLIF(CAST(m.index_value AS NUMERIC),0)), 2 ) AS avg_composition
FROM filtered_metrics m;

-- =========================================================
-- Question 1: Top 10 interests by average composition for each month
-- =========================================================
SELECT month_year, interest_id, avg_composition
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY avg_composition DESC) AS rn
    FROM metrics_avg_comp
) t
WHERE rn <= 10
ORDER BY month_year, avg_composition DESC;
-- OUTPUT:
-- month_year	interest_id	avg_composition
-- 01-2019	    21057	    7.66
-- 01-2019	    6065	    7.05
-- 01-2019	    21245	    6.67
-- 01-2019	    5969	    6.46
-- 01-2019	    18783	    6.46
-- 01-2019	    7541	    6.44
-- 01-2019	    10981	    6.16
-- 01-2019	    34	        5.90

-- =========================================================
-- Question 2: Most frequent interest in top 10 across all months
-- =========================================================
WITH top10 AS (
    SELECT month_year, interest_id
    FROM (
        SELECT *, ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY avg_composition DESC) AS rn
        FROM metrics_avg_comp
    ) t
    WHERE rn <= 10
)
SELECT interest_id, COUNT(*) AS appear_count
FROM top10
GROUP BY interest_id
ORDER BY appear_count DESC
LIMIT 1;
-- OUTPUT:
-- interest_id	appear_count
-- 6065	        10

-- =========================================================
-- Question 3: Average of top 10 interests per month
-- =========================================================
SELECT month_year, ROUND(AVG(avg_composition),2) AS avg_top10_composition
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY avg_composition DESC) AS rn
    FROM metrics_avg_comp
) t
WHERE rn <= 10
GROUP BY month_year
ORDER BY month_year;
-- OUTPUT:
-- month_year	avg_top10_composition
-- 01-2019	6.40
-- 02-2019	6.58
-- 03-2019	6.17
-- 04-2019	5.75
-- 05-2019	3.54
-- 06-2019	2.43
-- 07-2018	6.04
-- 07-2019	2.77
-- 08-2018	5.95
-- 08-2019	2.63
-- 09-2018	6.90
-- 10-2018	7.07
-- 11-2018	6.62
-- 12-2018	6.65
-- null	    2.37

-- =========================================================
-- Question 4: 3-month rolling average of max average composition
-- =========================================================
WITH top_interest AS (
    SELECT month_year, interest_id, avg_composition,
           ROW_NUMBER() OVER (PARTITION BY month_year ORDER BY avg_composition DESC) AS rn
    FROM metrics_avg_comp
),
max_per_month AS (
    SELECT month_year, interest_id, avg_composition AS max_index_composition
    FROM top_interest
    WHERE rn = 1
),
rolling AS (
    SELECT m1.month_year, m1.interest_id, m1.max_index_composition,
           ROUND( AVG(CAST(m1.max_index_composition AS NUMERIC)) OVER (
                   ORDER BY TO_DATE(m1.month_year, 'MM-YYYY') ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
           ), 2 ) AS three_month_moving_avg,
           LAG(m1.interest_id || ': ' || CAST(m1.max_index_composition AS NUMERIC), 1) OVER (ORDER BY TO_DATE(m1.month_year, 'MM-YYYY')) AS one_month_ago,
           LAG(m1.interest_id || ': ' || CAST(m1.max_index_composition AS NUMERIC), 2) OVER (ORDER BY TO_DATE(m1.month_year, 'MM-YYYY')) AS two_months_ago
    FROM max_per_month m1
)
SELECT *
FROM rolling
WHERE TO_DATE(month_year, 'MM-YYYY') BETWEEN DATE '2018-09-01' AND DATE '2019-08-01'
ORDER BY TO_DATE(month_year, 'MM-YYYY');
-- OUTPUT:
-- month_year	interest_id	max_index_composition	three_month_moving_avg	one_month_ago	two_months_ago
-- 09-2018	    21057	    8.26	                7.61	                6324: 7.21	    6324: 7.36
-- 10-2018	    21057	    9.14	                8.20	                21057: 8.26	    6324: 7.21
-- 11-2018	    21057	    8.28	                8.56	                21057: 9.14	    21057: 8.26
-- 12-2018	    21057	    8.31	                8.58	                21057: 8.28	    21057: 9.14
-- 01-2019	    21057	    7.66	                8.08	                21057: 8.31	    21057: 8.28
-- 02-2019	    21057	    7.66	                7.88	                21057: 7.66	    21057: 8.31
-- 03-2019	    7541	    6.54	                7.29	                21057: 7.66	    21057: 7.66
-- 04-2019	    6065	    6.28	                6.83	                7541: 6.54	    21057: 7.66
-- 05-2019	    21245	    4.41	                5.74	                6065: 6.28	    7541: 6.54
-- 06-2019	    6324	    2.77	                4.49	                21245: 4.41	    6065: 6.28
-- 07-2019	    6324	    2.82	                3.33	                6324: 2.77	    21245: 4.41
-- 08-2019	    4898	    2.73	                2.77	                6324: 2.82	    6324: 2.77

-- =========================================================
-- Question 5: Possible reasons for month-to-month max composition change
-- =========================================================
-- OUTPUT / Insight:
-- 1. Composition may spike due to seasonal campaigns or promotions.
-- 2. Certain interests may temporarily gain more engagement in some months.
-- 3. Fluctuations might indicate variability in client behavior or data collection.
-- 4. Large fluctuations could signal a need to review segmentation or targeting strategy.
