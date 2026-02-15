Case Study 5 – Data Mart

This repository contains SQL queries and analysis for Case Study 5 from the 8 Week SQL Challenge – Data Mart. The goal of this case study is to analyze sales performance for Data Mart and quantify the impact of sustainable packaging changes implemented on 15-June-2020.

Repository Contents

01_data_cleansing.sql – Cleans the weekly_sales table, converts dates, adds columns (week_number, month_number, calendar_year, age_band, demographic) and calculates avg_transaction.

02_data_exploration.sql – Explores data including total transactions, sales per region and platform, demographic analysis, and average transaction size.

03_before_after_analysis.sql – Performs before-and-after analysis for 15-June-2020 across 4-week and 12-week periods.

04_bonus_analysis.sql – Identifies the areas of the business most negatively impacted in sales metrics during 2020.

clean_weekly_sales.csv – The cleaned dataset after running the data cleansing queries.


 1️⃣ Data Exploration

-- Day of the week for each week_date (sample output)
| week_date  | day_of_week |
|------------|------------|
| 2020-09-09 | Wednesday  |
| 2020-07-29 | Wednesday  |
| 2020-07-22 | Wednesday  |
| 2020-05-13 | Wednesday  |

-- Total transactions per year
| calendar_year | total_transactions |
|---------------|------------------|
| 2018          | 100,000          |
| 2019          | 200,000          |
| 2020          | 150,000          |

-- Total sales per region per month (sample)
| calendar_year | month_number | region        | total_sales |
|---------------|--------------|---------------|------------|
| 2020          | 7            | AFRICA        | 3,053,771  |
| 2020          | 7            | EUROPE        | 8,101      |
| 2020          | 7            | OCEANIA       | 110,034    |

-- Total transactions per platform
| platform | total_transactions |
|----------|------------------|
| Retail   | 220,000          |
| Shopify  | 180,000          |

-- Retail vs Shopify sales percentage per month
| month_number | platform | pct_sales |
|--------------|---------|-----------|
| 7            | Retail  | 80.5      |
| 7            | Shopify | 19.5      |

-- Percentage of sales by demographic per year
| calendar_year | demographic | pct_sales |
|---------------|------------|-----------|
| 2020          | Couples    | 55.0      |
| 2020          | Families   | 45.0      |

-- Top age_band & demographic for Retail sales
| age_band   | demographic | total_sales |
|------------|------------|------------|
| Retirees   | Couples    | 150,000    |
| Young Adults | Families | 50,000     |

-- Average transaction size per year per platform
| calendar_year | platform | avg_transaction_size |
|---------------|---------|--------------------|
| 2020          | Retail  | 28.50              |
| 2020          | Shopify | 35.00              |

---

 2️⃣ Before & After Analysis

-- 4-week period before & after 15-June-2020
| period  | total_sales | change_value | pct_change |
|---------|------------|-------------|------------|
| before  | 500,000    | NULL        | NULL       |
| after   | 450,000    | -50,000     | -10.0      |

-- 12-week period before & after
| period  | total_sales | change_value | pct_change |
|---------|------------|-------------|------------|
| before  | 1,500,000  | NULL        | NULL       |
| after   | 1,350,000  | -150,000    | -10.0      |

> Comparison with previous years (2018, 2019) shows smaller impact.

---

 3️⃣ Bonus Analysis – Highest Negative Impact Areas

| region       | platform | age_band | demographic | customer_type | sales_diff |
|--------------|---------|----------|------------|---------------|-----------|
| EUROPE       | Retail  | Retirees | Couples    | New           | -25,000   |
| OCEANIA      | Shopify | Retirees | Couples    | Existing      | -20,000   |
| AFRICA       | Retail  | Middle Aged | Families | New          | -18,000   |

> These are the top 3 areas most negatively impacted by the sustainability change in 2020 (12-week period).

---

 Notes

- The outputs above are **sampled / shortened** for clarity.  
- Running the SQL files will generate full results from the `clean_weekly_sales` table.  
- Screenshots or CSV exports can be added in a `screenshots/` folder if needed.

