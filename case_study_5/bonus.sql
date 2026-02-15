SELECT region, platform, age_band, demographic, customer_type,
       SUM(CASE WHEN week_date >= '2020-06-15' THEN sales ELSE 0 END) -
       SUM(CASE WHEN week_date < '2020-06-15' THEN sales ELSE 0 END) AS sales_diff
FROM data_mart.clean_weekly_sales
WHERE calendar_year = 2020
GROUP BY region, platform, age_band, demographic, customer_type
ORDER BY sales_diff ASC
LIMIT 10;
