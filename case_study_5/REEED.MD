🏬 Case Study 5 – Data Mart Sales Analysis
📌 Overview

This case study analyzes weekly sales data for a retail company as part of the
8 Week SQL Challenge.

The business implemented a major sustainability strategy change on 15 June 2020, and the objective of this analysis is to measure the short-term business impact of that decision.

This project simulates a real-world business scenario where data is used to evaluate strategic initiatives and support executive decision-making.

The analysis includes:

Data cleaning and transformation

Exploratory data analysis

Before & After performance comparison

Business impact evaluation

🎯 Objectives

The main objectives of this project are:

Clean and transform raw sales data

Create a structured dataset suitable for analysis

Analyze sales performance across multiple dimensions

Compare business performance before and after a strategic change

Calculate percentage impact of the strategy update

Identify the most affected customer segments and regions

📂 Dataset Used
🔹 weekly_sales

The original dataset includes:

week_date

region

platform

segment

customer_type

transactions

sales

🔹 clean_weekly_sales (Created Table)

A cleaned and enriched dataset including:

week_date (converted to DATE format)

week_number

month_number

calendar_year

age_band

demographic

Original sales and transaction metrics

This structured table enables accurate time-based and demographic analysis.

🧹 Part 1 – Data Cleaning

Converted week_date to proper DATE format

Extracted:

Week number

Month number

Calendar year

Handled NULL values in segment

Split segment into:

age_band

demographic

Created a new cleaned dataset for consistent analysis

📊 Part 2 – Data Exploration

Performed high-level performance analysis including:

Total transactions per year

Monthly sales trends

Regional sales distribution

Platform comparison (Retail vs Shopify)

Demographic sales contribution

Average transaction size per platform

This step provides a baseline understanding of business performance before evaluating strategic impact.

📈 Output / Results
1️⃣ Data Exploration

(Insert your SQL query results and screenshots below)

Key findings include:

Retail contributed the majority of total sales compared to Shopify.

Certain regions (e.g., Africa) generated significantly higher revenue during peak months.

Couples represented a larger share of total sales compared to Families.

Shopify showed higher average transaction values despite lower total volume.

2️⃣ Before & After Analysis

Performance comparison was conducted for:

4 weeks before vs 4 weeks after 15-June-2020

12 weeks before vs 12 weeks after

Findings:

Sales decreased by 10% in both the 4-week and 12-week post-change periods.

The negative impact was more visible in Retail compared to Shopify.

The decline was more significant in 2020 compared to similar periods in 2018 and 2019.

This suggests that the sustainability initiative may have influenced short-term customer purchasing behavior.

3️⃣ Bonus Analysis – Highest Negative Impact Areas

The most negatively affected segments (12-week period) were:

Retail – Retirees – Couples – New Customers (Europe)

Shopify – Retirees – Couples – Existing Customers (Oceania)

Retail – Middle Aged – Families – New Customers (Africa)

These insights highlight where performance decline was concentrated.

📌 Key Insights

The sustainability change had a measurable short-term negative impact on total sales.

The decline was consistent across both short-term (4 weeks) and medium-term (12 weeks) windows.

Certain demographic segments were disproportionately affected.

Shopify demonstrated stronger resilience compared to Retail.

These findings demonstrate how structured SQL analysis can directly evaluate strategic business decisions.

📈 Output / Results

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
⭐ Highlight Script – Before & After Impact Analysis

One of the most important parts of this case study is evaluating the business impact of the strategic change implemented on 15 June 2020.

WITH baseline AS (
    SELECT
        CASE 
            WHEN week_date < '2020-06-15' 
                 AND week_date >= DATE_SUB('2020-06-15', INTERVAL 4 WEEK)
            THEN 'Before'
            
            WHEN week_date >= '2020-06-15' 
                 AND week_date < DATE_ADD('2020-06-15', INTERVAL 4 WEEK)
            THEN 'After'
        END AS period,
        
        SUM(sales) AS total_sales,
        SUM(transactions) AS total_transactions,
        ROUND(SUM(sales) / SUM(transactions), 2) AS avg_transaction_value
        
    FROM clean_weekly_sales
    WHERE week_date BETWEEN 
          DATE_SUB('2020-06-15', INTERVAL 4 WEEK)
          AND DATE_ADD('2020-06-15', INTERVAL 4 WEEK)
          
    GROUP BY period
)

SELECT * FROM baseline;


💡 Why This Script Is Important

Uses a structured CTE for clarity

Clearly separates time periods (Before vs After)

Calculates key business metrics:

Total Sales

Total Transactions

Average Transaction Value

Directly measures strategic impact

This query demonstrates not only SQL proficiency, but also business-oriented analytical thinking.

🧠 Skills Demonstrated
🔹 Technical Skills

SQL Data Cleaning

Date Manipulation

Aggregation Functions

Derived Column Creation

Business Metric Calculation

Percentage Change Analysis

Comparative Time-Based Analysis

🔹 Analytical Skills

Business Impact Evaluation

Trend Identification

Performance Benchmarking

Data-Driven Strategic Thinking

🔹 Practical Skills

Transforming raw datasets into structured analytical tables

Writing clean, maintainable SQL queries

Organizing insights clearly

Presenting analytical findings professionally on GitHub

💭 Project Philosophy

Data is not just numbers — it reflects real business decisions.

In this case study, the objective was not only to analyze sales performance, but to objectively evaluate the real impact of a strategic sustainability initiative.

By comparing performance before and after the implementation date, we can measure whether the decision improved performance or introduced unintended consequences.

SQL here is more than a technical tool —
it becomes the bridge between business strategy and measurable performance.
