CREATE TABLE data_mart.clean_weekly_sales AS
SELECT
  TO_DATE(week_date, 'DD/MM/YY') AS week_date,
  EXTRACT(WEEK FROM TO_DATE(week_date, 'DD/MM/YY')) AS week_number,
  EXTRACT(MONTH FROM TO_DATE(week_date, 'DD/MM/YY')) AS month_number,
  EXTRACT(YEAR FROM TO_DATE(week_date, 'DD/MM/YY')) AS calendar_year,
  COALESCE(segment, 'unknown') AS segment,
  CASE
    WHEN segment LIKE 'C1%' OR segment LIKE 'F1%' THEN 'Young Adults'
    WHEN segment LIKE 'C2%' OR segment LIKE 'F2%' THEN 'Middle Aged'
    WHEN segment LIKE 'C3%' OR segment LIKE 'F3%' OR segment LIKE 'C4%' OR segment LIKE 'F4%' THEN 'Retirees'
    ELSE 'unknown'
  END AS age_band,

  CASE
    WHEN segment LIKE 'C%' THEN 'Couples'
    WHEN segment LIKE 'F%' THEN 'Families'
    ELSE 'unknown'
  END AS demographic,
  COALESCE(customer_type, 'unknown') AS customer_type,
  transactions,
  sales,
  ROUND(sales / transactions, 2) AS avg_transaction
FROM data_mart.weekly_sales
WHERE week_date ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$';


  SELECT * FROM data_mart.clean_weekly_sales LIMIT 10;



