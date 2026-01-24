Case Study 3 – Foodie-Fi

📌 Dataset
This case study uses a Foodie-Fi subscription dataset with two tables:

plans – Subscription plan details

subscriptions – Customer subscription history

We analyze the data to answer real-world business questions about customer behavior, churn, upgrades, and time-based subscription patterns.

📈 Focus: Ranking, Aggregation & Conditional Analysis
Key points of this project:

Count and rank customers by subscription actions

Analyze plan upgrades and downgrades

Calculate churn rates and percentages

Track time to upgrade to annual plans

Analyze monthly and weekly trends

✅ Results
All questions were solved successfully using SQL window functions, aggregation, and conditional statements.
Insights include customer counts, churn patterns, subscription breakdowns, and plan upgrades/downgrades.

🏆 Learnings / Skills

Date Functions: extracting month/year, calculating periods

Conditional Aggregation: use of CASE statements for categories

Ranking & Window Functions: calculating row numbers, ranks, and cumulative counts

Percentage Calculations: compute accurate percentages for reporting

Analyzing customer subscription behavior

Results Screenshots
Q1: How many customers has Foodie-Fi ever had?

Screenshot: Q1_Total_Customers.png

Q2: Monthly distribution of trial plan start_date

Screenshot: Q2_Trial_Monthly.png

Q3: Plan start_date values after 2020, by plan_name

Screenshot: Q3_Post2020_Plans.png

Q4: Customer count & percentage who churned

Screenshot: Q4_Churned_Customers.png

Q5: Customers who churned after trial & percentage

Screenshot: Q5_Churn_After_Trial.png

Q6: Number & percentage of customer plans after trial

Screenshot: Q6_Plans_After_Trial.png

Q7: Customer count & percentage for all plans at 2020-12-31

Screenshot: Q7_Plan_Breakdown_2020-12-31.png

Q8: Customers upgraded to annual plan in 2020

Screenshot: Q8_Annual_Upgrade_2020.png

Q9: Average days to annual plan & 30-day breakdown

Screenshot: Q9_Annual_Plan_30days.png

Q10: Customers downgraded from pro monthly to basic monthly in 2020

Screenshot: Q10_Downgrade_Pro_to_Basic_2020.png
