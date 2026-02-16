🏬 Case Study 6 – MovieStream Subscription Analysis
📌 Overview

This case study analyzes customer subscription data for MovieStream, a digital streaming service.
The goal is to understand subscription trends, retention, and the impact of promotional campaigns.

The analysis includes:

Data cleaning and transformation

Exploratory data analysis

Customer retention and churn analysis

Revenue impact evaluation

This simulates a real-world scenario of subscription-based services using SQL to support business decisions.

🎯 Objectives

Clean and transform subscription data

Analyze subscription trends by plan type (trial, monthly, annual)

Measure customer churn and retention

Evaluate revenue impact of different subscription plans

Identify patterns to improve business strategy

📂 Dataset Used
🔹 subscriptions

customer_id

plan_id

start_date

end_date

status (active/churned)

amount_paid

🔹 plans

plan_id

plan_name

price

duration

discount

🧹 Data Cleaning

Convert date columns to DATE type

Handle NULLs and missing plan information

Create derived columns such as subscription duration and renewal status

📈 Output / Results

Sample findings:

Monthly subscription trend shows growth in annual plans

Trial-to-paid conversion rate: 35%

Highest churn in monthly plans

Revenue per plan type: Annual > Monthly > Trial

🖥️ Digital Analysis – Outputs

1️⃣ Total users

total_users
5,000

2️⃣ Average cookies per user

avg_cookies_per_user
1.75

3️⃣ Unique visits per month

month	unique_visits
2020-01	1,200
2020-02	1,500

4️⃣ Number of events per event type

event_type	total_events
page_view	10,000
add_to_cart	3,500
purchase	2,000

5️⃣ Percentage of visits with purchase

purchase_visit_pct
25.0

6️⃣ Percentage of visits viewing checkout but no purchase

checkout_no_purchase_pct
10.0

7️⃣ Top 3 pages by views

page_name	view_count
Home	3,000
Product1	2,500
Category1	2,000

8️⃣ Views and cart adds per product category

product_category	views	cart_adds
Electronics	3,500	1,200
Clothing	4,000	1,500

9️⃣ Top 3 products by purchases

product_name	purchase_count
Product1	500
Product2	450
Product3	400
🛒 Product Funnel Analysis – Outputs

Product-level funnel table (sample)

product_name	views	cart_adds	abandoned	purchases
Product1	1,200	500	100	400
Product2	1,000	400	50	350
Product3	900	350	30	320

Category-level funnel table (sample)

product_category	views	cart_adds	abandoned	purchases
Electronics	3,500	1,200	200	1,000
Clothing	4,000	1,500	150	1,350

Analysis results (top insights)

Product with most views, cart adds, purchases → Product1

Product most likely to be abandoned → Product1 (20% abandonment)

Product with highest view → purchase % → Product3 (35%)

Average view → cart add conversion → 34%

Average cart add → purchase conversion → 88%

⭐ Highlight Script – Churn Analysis

SELECT
    plan_id,
    COUNT(customer_id) AS total_customers,
    SUM(CASE WHEN status='Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN status='Churned' THEN 1 ELSE 0 END)/COUNT(customer_id)*100,2) AS churn_rate
FROM subscriptions
GROUP BY plan_id;



Why this script is important:
It identifies the subscription plans with the highest churn rate, allowing the business to target retention strategies.

💭 Project Philosophy

Customer retention drives sustainable revenue. SQL allows us to quantify churn and uncover insights that guide subscription strategies.
Analyzing before vs after promotional campaigns gives insight into the effectiveness of business decisions.

🧠 Skills Demonstrated

Technical: SQL Aggregation, CASE statements, JOINs, Date functions
Analytical: Churn analysis, Trend detection, Revenue evaluation
Practical: Data cleaning, Derived metrics, Reporting
