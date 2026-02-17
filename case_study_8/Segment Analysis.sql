-- ===============================================
-- Step 0: Create a temporary filtered dataset (interests with at least 6 months)
DROP TABLE IF EXISTS filtered_metrics;
CREATE TEMP TABLE filtered_metrics AS
SELECT m.*
FROM fresh_segments.interest_metrics m
JOIN (
    SELECT interest_id
    FROM fresh_segments.interest_metrics
    GROUP BY interest_id
    HAVING COUNT(DISTINCT month_year) >= 6
) f
ON m.interest_id = f.interest_id;

-- ===============================================
-- Question 1: Top 10 and Bottom 10 interests by maximum composition value
-- Get the maximum composition per interest along with the month
DROP TABLE IF EXISTS interest_max_composition;
CREATE TEMP TABLE interest_max_composition AS
SELECT DISTINCT ON (interest_id)
    interest_id,
    month_year,
    composition
FROM filtered_metrics
ORDER BY interest_id, composition DESC;

-- Top 10
SELECT *
FROM interest_max_composition
ORDER BY composition DESC
LIMIT 10;
-- Answer / Insight:
-- interest_id | month_year | composition
-- ------------+------------+------------
-- 21057       | 12-2018    | 21.2
-- 6284        | 07-2018    | 18.82
-- 39          | 07-2018    | 17.44
-- 77          | 07-2018    | 17.19
-- 12133       | 10-2018    | 15.15
-- 5969        | 12-2018    | 15.05
-- 171         | 07-2018    | 14.91
-- 4898        | 07-2018    | 14.23
-- 6286        | 07-2018    | 14.1
-- 4           | 07-2018    | 13.97

-- Bottom 10
SELECT *
FROM interest_max_composition
ORDER BY composition ASC
LIMIT 10;
-- Answer / Insight:
-- interest_id | month_year | composition
-- ------------+------------+------------
-- 33958       | 08-2018    | 1.88
-- 37412       | 10-2018    | 1.94
-- 19599       | 03-2019    | 1.97
-- 19635       | 07-2018    | 2.05
-- 19591       | 10-2018    | 2.08
-- 37421       | 08-2019    | 2.09
-- 42011       | 01-2019    | 2.09
-- 22408       | 07-2018    | 2.12
-- 34085       | 08-2019    | 2.14
-- 36138       | 02-2019    | 2.18

-- ===============================================
-- Question 2: 5 interests with lowest average ranking
SELECT interest_id, AVG(ranking) AS avg_ranking
FROM filtered_metrics
GROUP BY interest_id
ORDER BY avg_ranking ASC
LIMIT 5;
-- Answer / Insight:
-- interest_id | avg_ranking
-- ------------+-------------
-- 41548       | 1.00
-- 42203       | 4.11
-- 115         | 5.93
-- 171         | 9.36
-- 4           | 11.86

-- ===============================================
-- Question 3: 5 interests with largest standard deviation in percentile_ranking
SELECT interest_id, STDDEV(percentile_ranking) AS sd_percentile
FROM filtered_metrics
GROUP BY interest_id
ORDER BY sd_percentile DESC
LIMIT 5;
-- Answer / Insight:
-- interest_id | sd_percentile
-- ------------+---------------
-- 23          | 30.18
-- 20764       | 28.97
-- 38992       | 28.32
-- 43546       | 26.24
-- 10839       | 25.61

-- ===============================================
-- Question 4: Min and Max percentile_ranking and corresponding month for these 5 interests

-- Step 1: Get the 5 most variable interests
DROP TABLE IF EXISTS variable_interests;
CREATE TEMP TABLE variable_interests AS
SELECT interest_id
FROM (
    SELECT interest_id, STDDEV(percentile_ranking) AS sd_percentile
    FROM filtered_metrics
    GROUP BY interest_id
    ORDER BY sd_percentile DESC
    LIMIT 5
) t;

-- Step 2: For each variable interest, get min and max percentile_ranking along with the corresponding month
SELECT
    v.interest_id,
    min_table.percentile_ranking AS min_percentile,
    min_table.month_year AS min_month,
    max_table.percentile_ranking AS max_percentile,
    max_table.month_year AS max_month
FROM variable_interests v
JOIN LATERAL (
    SELECT m.percentile_ranking, m.month_year
    FROM filtered_metrics m
    WHERE m.interest_id = v.interest_id
    ORDER BY m.percentile_ranking ASC
    LIMIT 1
) min_table ON TRUE
JOIN LATERAL (
    SELECT m.percentile_ranking, m.month_year
    FROM filtered_metrics m
    WHERE m.interest_id = v.interest_id
    ORDER BY m.percentile_ranking DESC
    LIMIT 1
) max_table ON TRUE
ORDER BY v.interest_id;
-- Answer / Insight:
-- interest_id | min_percentile | min_month | max_percentile | max_month
-- ------------+----------------+-----------+----------------+-----------
-- 10839       | 4.84           | 03-2019   | 75.03          | 07-2018
-- 20764       | 11.23          | 08-2019   | 86.15          | 07-2018
-- 23          | 7.92           | 08-2019   | 86.69          | 07-2018
-- 38992       | 2.2            | 07-2019   | 82.44          | 11-2018
-- 43546       | 5.7            | 06-2019   | 73.15          | 03-2019

-- ===============================================
-- Question 5: Customer segment insights (qualitative)
-- Answer / Insight:
-- Customers in this segment engage with a few highly dominant interests (high composition)
-- but some interests fluctuate a lot (high percentile_ranking SD).
-- Recommendations:
-- • Focus on popular interests that consistently rank high (stable segments)
-- • Offer promotions around months where composition spikes
-- • Avoid targeting sporadic interests with low coverage for long-term campaigns
