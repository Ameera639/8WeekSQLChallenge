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
