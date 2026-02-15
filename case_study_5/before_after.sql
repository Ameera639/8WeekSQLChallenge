-- Define periods 4 weeks before and after 15-June-2020
WITH sales_period AS (
  SELECT *,
         CASE WHEN week_date < '2020-06-15' THEN 'before'
              ELSE 'after'
         END AS period
  FROM data_mart.clean_weekly_sales
  WHERE week_date BETWEEN '2020-05-18' AND '2020-07-12'
)
SELECT period, SUM(sales) AS total_sales,
       SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY period) AS change_value,
       ROUND((SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY period)) / LAG(SUM(sales)) OVER (ORDER BY period) * 100,2) AS pct_change
FROM sales_period
GROUP BY period;

-- For 12 weeks before and after
WITH sales_period AS (
  SELECT *,
         CASE WHEN week_date < '2020-06-15' THEN 'before'
              ELSE 'after'
         END AS period
  FROM data_mart.clean_weekly_sales
  WHERE week_date BETWEEN '2020-03-23' AND '2020-09-07'
)
SELECT period, SUM(sales) AS total_sales,
       SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY period) AS change_value,
       ROUND((SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY period)) / LAG(SUM(sales)) OVER (ORDER BY period) * 100,2) AS pct_change
FROM sales_period
GROUP BY period;
