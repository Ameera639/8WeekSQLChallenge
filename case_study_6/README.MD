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
1. Total users

Answer: 1782

2. Average cookies per user

Answer: 2.00

3. Unique visits per month

Answer:

month	unique_visits
2020-01	876
2020-03	916
2020-04	248
2020-05	36
4. Number of events per event type

Answer:

event_name	total_events
Page View	20928
Add to Cart	8451
Purchase	1777
Ad Impression	876
Ad Click	702
5. Percentage of visits with purchase

Answer: 49.86%

6. Percentage of visits viewing checkout but no purchase

Answer: 20.57%

7. Top 3 pages by views

Answer:

page_name	view_count
All Products	3174
Checkout	2103
Home Page	1782
8. Views and cart adds per product category

Answer:

product_category	views	cart_adds
null	7059	0
Luxury	3032	1870
Shellfish	6204	3792
Fish	4633	2789
9. Top 3 products by purchases

Answer:

product_id	purchase_count
null	1777
10. Product funnel table (example)

Answer:

product_id	views	cart_adds	abandoned	purchases
101	500	120	30	90
102	300	80	10	70
103	450	100	25	75
11. Category funnel table (example)

Answer:

product_category	views	cart_adds	abandoned	purchases
Electronics	1000	250	50	200
Apparel	800	200	40	160
Home & Garden	600	150	25	125
12. Most viewed / cart added / purchased product

Answer:

product_id	views	cart_adds	abandoned	purchases
null	7059	0	0	1777
13. Most abandoned product

Answer:

product_id	views	cart_adds	abandoned	purchases	abandoned_pct
null	7059	0	0	1777	null
14. Highest view → purchase %

Answer:

product_id	views	cart_adds	abandoned	purchases	view_to_purchase_pct
null	7059	0	0	1777	25.17
15. Average view → cart add %

Answer: 40.38%

16. Average cart add → purchase %

Answer: 21.03%

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
