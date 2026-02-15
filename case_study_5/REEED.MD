 Results / Output

The queries in this repository generate the following key insights from the `clean_weekly_sales` table:

1.Data Cleansing  
   - All `week_date` values are converted to DATE format.  
   - `week_number`, `month_number`, `calendar_year`, `age_band`, and `demographic` columns are correctly mapped.  
   - Null values replaced with `'unknown'`.  
   - `avg_transaction` column calculated for all records.

2.Data Exploration  
   - Day of the week, total transactions per year, total sales per region per month, and total transactions per platform are available.  
   - Retail vs Shopify sales percentages per month and demographic sales percentages per year can be easily visualized.  
   - Top contributors to Retail sales by `age_band` and `demographic` are identified.  
   - Average transaction size per year per platform is calculated.

3.Before & After Analysis  
   - Sales comparisonbefore and after 15-June-2020 (sustainability change) is provided.  
   - Both 4-week and 12-week periods are analyzed.  
   - Growth/reduction in actual sales and percentage change is included.  
   - Comparison with previous years (2018 and 2019) is included.

4.Bonus Analysis  
   - The highest negative impact areas are identified across:
     - `region`
     - `platform`
     - `age_band`
     - `demographic`
     - `customer_type`
   - This helps prioritize which areas of the business need attention after the sustainability change.

> Note: For full query outputs, please run the SQL scripts on PostgreSQL. Screenshots or CSV exports of query results can be added to the `screenshots/` folder for reference.
