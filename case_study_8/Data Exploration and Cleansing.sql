-- Question 1: Update the month_year column to be a date data type with the start of the month
ALTER TABLE fresh_segments.interest_metrics
ALTER COLUMN month_year TYPE DATE
USING DATE_TRUNC('month', TO_DATE(month_year, 'MM-YYYY'));
-- Answer / Insight: Execution successful. month_year is now DATE and represents the first day of each month. Ready for time-based analysis.

-- Question 2: Count of records in fresh_segments.interest_metrics for each month_year value, sorted chronologically with NULLs first
SELECT 
    month_year,
    COUNT(*) AS record_count
FROM fresh_segments.interest_metrics
GROUP BY month_year
ORDER BY month_year NULLS FIRST;
-- Answer / Insight: NULL = 1,194 rows. Date range: 2018-07-01 to 2019-08-01. Earliest month = 2018-07-01 (729 rows), Latest month = 2019-08-01 (1,149 rows). Data covers 14 valid months; NULLs need handling before analysis.

-- Question 3: What should we do with these NULL values in month_year?
-- Answer / Insight: NULLs lack a time reference. Recommended to remove these rows or impute the correct month if possible to preserve analytical integrity.

-- Question 4: How many interest_id values exist in metrics but not in interest_map? And vice versa?
-- In metrics but not in interest_map
SELECT COUNT(DISTINCT m.interest_id)
FROM fresh_segments.interest_metrics m
LEFT JOIN fresh_segments.interest_map mp
    ON m.interest_id::INTEGER = mp.id
WHERE mp.id IS NULL;

-- In interest_map but not in metrics
SELECT COUNT(DISTINCT mp.id)
FROM fresh_segments.interest_map mp
LEFT JOIN fresh_segments.interest_metrics m
    ON mp.id = m.interest_id::INTEGER
WHERE m.interest_id IS NULL;
-- Answer / Insight: Both queries return 0 rows. All interest_id values are consistent between metrics and interest_map.

-- Question 5: Summarise id values in interest_map by total record count in metrics
SELECT 
    id,
    COUNT(*) AS total_records
FROM fresh_segments.interest_metrics m
JOIN fresh_segments.interest_map mp
    ON m.interest_id::INTEGER = mp.id
GROUP BY id
ORDER BY total_records DESC;
-- Answer / Insight: Shows total records per id. Highlights the most active interests in the dataset.

-- Question 6: What sort of table join should we perform for analysis? Check interest_id = 21246
SELECT m.*, mp.*
FROM fresh_segments.interest_metrics m
LEFT JOIN fresh_segments.interest_map mp
    ON m.interest_id::INTEGER = mp.id  -- تحويل VARCHAR الى INTEGER لتجنب الخطأ
WHERE m.interest_id = '21246';        -- إذا m.interest_id نصي، حط الرقم بين علامات اقتباس
-- Answer / Insight: Use INNER JOIN for interests present in both tables, or LEFT JOIN to keep all metrics. Shows all columns from metrics and all columns from interest_map.


-- Question 7: Are there any records where month_year < created_at? Are these valid?
SELECT *
FROM fresh_segments.interest_metrics m
JOIN fresh_segments.interest_map mp
    ON m.interest_id::INTEGER = mp.id
WHERE m.month_year < mp.created_at;
-- Answer / Insight: Records where month_year < created_at are likely invalid. Indicates data entry errors or incorrect dates and should be reviewed before analysis.
