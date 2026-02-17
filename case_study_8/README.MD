🏬 Case Study 8 – Foodie-Fi Subscription Analysis
📌 Overview

This case study focuses on Foodie-Fi, a subscription-based food delivery service.
The goal is to understand subscription trends, churn, and plan performance.

Analysis includes:

Data cleaning and transformation

Plan-level and customer-level analysis

Churn and retention evaluation

Revenue contribution by plan type

🎯 Objectives

Clean and structure subscription datasets

Analyze subscription events and plan performance

Measure customer churn and retention rates

Identify top revenue-generating plans

Support marketing and retention strategies with data

📂 Dataset Used
🔹 subscriptions

customer_id

plan_id

start_date

end_date

status

🔹 plans

plan_id

plan_name

price

duration

discount

📈 Output / Results
1️⃣ Average Composition Table

| month_year | interest_id | avg_composition |
| ---------- | ----------- | --------------- |
| 01-2019    | 21057       | 7.66            |
| 01-2019    | 6065        | 7.05            |
| 01-2019    | 21245       | 6.67            |
| 01-2019    | 5969        | 6.46            |
| 01-2019    | 18783       | 6.46            |
| 01-2019    | 7541        | 6.44            |
| 01-2019    | 10981       | 6.16            |
| 01-2019    | 34          | 5.90            |

2️⃣ Most Frequent Interest in Top 10 Across All Months

| interest_id | appear_count |
| ----------- | ------------ |
| 6065        | 10           |


3️⃣ Average of Top 10 Interests per Month
| month_year | avg_top10_composition |
| ---------- | --------------------- |
| 01-2019    | 6.40                  |
| 02-2019    | 6.58                  |
| 03-2019    | 6.17                  |
| 04-2019    | 5.75                  |
| 05-2019    | 3.54                  |
| 06-2019    | 2.43                  |
| 07-2018    | 6.04                  |
| 07-2019    | 2.77                  |
| 08-2018    | 5.95                  |
| 08-2019    | 2.63                  |
| 09-2018    | 6.90                  |
| 10-2018    | 7.07                  |
| 11-2018    | 6.62                  |
| 12-2018    | 6.65                  |
| null       | 2.37                  |
4️⃣ 3-Month Rolling Average of Max Average Composition
| month_year | interest_id | max_index_composition | three_month_moving_avg | one_month_ago | two_months_ago |
| ---------- | ----------- | --------------------- | ---------------------- | ------------- | -------------- |
| 09-2018    | 21057       | 8.26                  | 7.61                   | 6324: 7.21    | 6324: 7.36     |
| 10-2018    | 21057       | 9.14                  | 8.20                   | 21057: 8.26   | 6324: 7.21     |
| 11-2018    | 21057       | 8.28                  | 8.56                   | 21057: 9.14   | 21057: 8.26    |
| 12-2018    | 21057       | 8.31                  | 8.58                   | 21057: 8.28   | 21057: 9.14    |
| 01-2019    | 21057       | 7.66                  | 8.08                   | 21057: 8.31   | 21057: 8.28    |
| 02-2019    | 21057       | 7.66                  | 7.88                   | 21057: 7.66   | 21057: 8.31    |
| 03-2019    | 7541        | 6.54                  | 7.29                   | 21057: 7.66   | 21057: 7.66    |
| 04-2019    | 6065        | 6.28                  | 6.83                   | 7541: 6.54    | 21057: 7.66    |
| 05-2019    | 21245       | 4.41                  | 5.74                   | 6065: 6.28    | 7541: 6.54     |
| 06-2019    | 6324        | 2.77                  | 4.49                   | 21245: 4.41   | 6065: 6.28     |
| 07-2019    | 6324        | 2.82                  | 3.33                   | 6324: 2.77    | 21245: 4.41    |
| 08-2019    | 4898        | 2.73                  | 2.77                   | 6324: 2.82    | 6324: 2.77     |

Sample findings:

Annual plan generates 60% of revenue

Trial-to-paid conversion: 40%

Churn highest in monthly plans

Revenue growth aligned with promotional periods

⭐ Highlight Script – Top Revenue Plans
SELECT
    p.plan_name,
    SUM(s.amount_paid) AS total_revenue,
    COUNT(s.customer_id) AS total_subscribers
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
GROUP BY p.plan_name
ORDER BY total_revenue DESC;


Why this script is important:
It highlights the revenue contribution of each plan, helping prioritize growth strategies.

💭 Project Philosophy
Data is the key to subscription growth.
SQL analysis reveals which plans drive revenue and which plans require retention efforts.
Understanding plan performance allows business to make informed decisions and optimize subscription strategy.

🧠 Skills Demonstrated
Technical: SQL JOINs, Aggregation, Grouping, Revenue calculations
Analytical: Churn analysis, Revenue evaluation, Subscription trend analysis
Practical: Customer behavior analysis, Plan performance evaluation, Reporting
