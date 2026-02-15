
SELECT week_date, TO_CHAR(week_date, 'Day') AS day_of_week
FROM data_mart.clean_weekly_sales
LIMIT 10;


SELECT calendar_year, SUM(transactions) AS total_transactions
FROM data_mart.clean_weekly_sales
GROUP BY calendar_year;

SELECT calendar_year, month_number, region, SUM(sales) AS total_sales
FROM data_mart.clean_weekly_sales
GROUP BY calendar_year, month_number, region;
