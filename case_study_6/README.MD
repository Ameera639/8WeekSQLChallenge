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
