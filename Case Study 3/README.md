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
All 11 questions were solved successfully using SQL window functions, aggregation, and conditional statements.
Insights include customer counts, churn patterns, subscription breakdowns, and plan upgrades/downgrades.

🏆 Learnings / Skills

Date Functions: extracting month/year, calculating periods

Conditional Aggregation: use of CASE statements for categories

Ranking & Window Functions: calculating row numbers, ranks, and cumulative counts

Percentage Calculations: compute accurate percentages for reporting

Customer Behavior Analysis: track churn, upgrades, and downgrades

Data Cleaning & Filtering: exclude trial or null plans for precise insights

Results Screenshots
Q1: How many customers has Foodie-Fi ever had?

Screenshot: Q1_TotalCustomers.png

Q2: Monthly distribution of trial plan start_date

Screenshot: Q2_TrialMonthly.png

Q3: Plan start_date values after 2020, breakdown by plan_name

Screenshot: Q3_PlansAfter2020.png

Q4: Customer count & percentage of churned customers

Screenshot: Q4_ChurnedCustomers.png

Q5: Customers who churned straight after initial trial

Screenshot: Q5_ChurnAfterTrial.png

Q6: Number and percentage of customer plans after initial trial

Screenshot: Q6_PlansAfterTrial.png

Q7: Customer count & percentage breakdown of all 5 plan_name values at 2020-12-31

Screenshot: Q7_PlansBreakdown_20201231.png

Q8: How many customers upgraded to an annual plan in 2020

Screenshot: Q8_AnnualUpgrade_2020.png

Q9: Average days to upgrade to an annual plan from joining

Screenshot: Q9_AvgDaysToAnnual.png

Q10: Breakdown of avg days into 30-day periods

Screenshot: Q10_AvgDays30Period.png

Q11: Customers downgraded from pro monthly to basic monthly in 2020

Screenshot: Q11_Downgrades2020.png
