
-- ===============================================
-- Question 1: Which interests have been present in all month_year dates (14 months)?
-- Answer / Insight: Interests appearing in all 14 months represent stable segments.
WITH interest_months AS (
    SELECT
        interest_id,
        COUNT(DISTINCT month_year) AS total_months
    FROM fresh_segments.interest_metrics
    GROUP BY interest_id
)
SELECT interest_id
FROM interest_months
WHERE total_months = 14;
/*
interest_id
------------
100
10008
10009
10010
101
102
10249
10250
10251
10284
10326
10351
107
108
10832
10833
10834
10835
*/

-- ===============================================
-- Question 2: Find total_months value that passes 90% cumulative percentage
-- Answer / Insight: Threshold total_months where cumulative percentage reaches 90%.
WITH interest_records AS (
    SELECT
        interest_id,
        COUNT(*) AS total_records,
        COUNT(DISTINCT month_year) AS total_months
    FROM fresh_segments.interest_metrics
    GROUP BY interest_id
),
ordered_interest AS (
    SELECT
        interest_id,
        total_months,
        total_records,
        SUM(total_records) OVER (ORDER BY total_records DESC) AS cumulative_records,
        SUM(total_records) OVER () AS total_all_records,
        (SUM(total_records) OVER (ORDER BY total_records DESC) * 100.0) / SUM(total_records) OVER () AS cumulative_percentage
    FROM interest_records
)
SELECT total_months
FROM ordered_interest
WHERE cumulative_percentage >= 90
ORDER BY cumulative_percentage
LIMIT 1;
/*
total_months
------------
8
*/

-- ===============================================
-- Question 3: Total data points removed if we remove interests below threshold
-- Answer / Insight: Number of records removed by filtering low-coverage interests.
WITH interest_records AS (
    SELECT
        interest_id,
        COUNT(*) AS total_records,
        COUNT(DISTINCT month_year) AS total_months
    FROM fresh_segments.interest_metrics
    GROUP BY interest_id
),
threshold AS (
    SELECT total_months AS threshold_months
    FROM (
        SELECT
            total_months,
            SUM(total_records) OVER (ORDER BY total_records DESC) * 100.0 / SUM(total_records) OVER () AS cumulative_percentage
        FROM interest_records
    ) t
    WHERE cumulative_percentage >= 90
    ORDER BY cumulative_percentage
    LIMIT 1
)
SELECT SUM(total_records) AS removed_records
FROM interest_records
CROSS JOIN threshold
WHERE total_months < threshold.threshold_months;
/*
removed_records
---------------
2421
*/

-- ===============================================
-- Question 4: Does this decision make sense to remove these data points from a business perspective?
-- Answer / Insight:
-- Yes, it makes sense. Removing low-coverage interests (those appearing in fewer than 8 months) focuses analysis 
-- on stable segments that appear consistently over time.
-- Example:
-- - Interest 10008 appears in all 14 months → keep it (stable segment)
-- - Interest 12345 appears in only 2 months → remove it (unstable, less informative)
-- This ensures insights are based on meaningful trends rather than sporadic spikes.

-- ===============================================
-- Question 5: Unique interests per month after removal
-- Answer / Insight: Number of remaining unique interests per month after filtering low-coverage interests.
WITH interest_records AS (
    SELECT
        interest_id,
        COUNT(DISTINCT month_year) AS total_months,
        COUNT(*) AS total_records
    FROM fresh_segments.interest_metrics
    GROUP BY interest_id
),
ordered_interest AS (
    SELECT
        interest_id,
        total_months,
        total_records,
        SUM(total_records) OVER (ORDER BY total_records DESC) AS cumulative_records,
        SUM(total_records) OVER () AS total_all_records,
        (SUM(total_records) OVER (ORDER BY total_records DESC) * 100.0) / SUM(total_records) OVER () AS cumulative_percentage
    FROM interest_records
),
threshold AS (
    SELECT total_months AS threshold_months
    FROM ordered_interest
    WHERE cumulative_percentage >= 90
    ORDER BY cumulative_percentage
    LIMIT 1
),
filtered_interest AS (
    SELECT im.interest_id
    FROM interest_records im
    CROSS JOIN threshold t
    WHERE im.total_months >= t.threshold_months
)
SELECT
    m.month_year,
    COUNT(DISTINCT m.interest_id) AS unique_interests
FROM fresh_segments.interest_metrics m
JOIN filtered_interest f
    ON m.interest_id = f.interest_id
GROUP BY m.month_year
ORDER BY m.month_year;
/*
month_year      | unique_interests
----------------+-----------------
01-2019         | 934
02-2019         | 965
03-2019         | 960
04-2019         | 933
05-2019         | 753
06-2019         | 728
07-2018         | 694
07-2019         | 759
08-2018         | 735
08-2019         | 947
09-2018         | 759
10-2018         | 833
11-2018         | 899
12-2018         | 952
null            | 1
removed_records | 2421
*/
