🏬 Case Study 7 – Balanced Tree Clothing Co.
📌 Overview

This case study focuses on analyzing sales data for Balanced Tree Clothing Co., an online clothing retailer.
The objective is to evaluate product performance, customer behavior, and discount impact.

Analysis includes:

Data cleaning and transformation

High-level sales analysis

Transaction-level analysis

Product and segment performance analysis

🎯 Objectives

Clean and merge sales and product data

Identify top-selling products and segments

Analyze customer behavior by membership status

Measure discount impact on revenue

Support business decisions with actionable insights

📂 Dataset Used
🔹 sales

txn_id

prod_id

qty

price

discount

member

🔹 product_details

prod_id

product_name

category_name

segment_name

📊 Output / Results

Sample findings:

Top-selling product: “Eco Hoodie”

Highest revenue segment: Athleisure

Members spend more on average than non-members

Discounted products drove higher volume but lower margin

⭐ Highlight Script – Revenue by Product with Discount Impact
SELECT
    pd.product_name,
    SUM(s.qty * s.price * (1 - s.discount/100)) AS total_revenue
FROM sales s
JOIN product_details pd ON s.prod_id = pd.prod_id
GROUP BY pd.product_name
ORDER BY total_revenue DESC
LIMIT 10;

Why this script is important:
It accounts for discounts when calculating revenue, revealing true product performance.

💭 Project Philosophy

Revenue is not just quantity sold but the net value after discounts.
SQL allows us to calculate true impact of promotions, helping prioritize strategies for high-performing products and segments.

🧠 Skills Demonstrated

Technical: SQL JOINs, Aggregation, Derived Calculations, GROUP BY
Analytical: Product performance analysis, Discount impact evaluation
Practical: Revenue calculation, Customer behavior analysis, Reporting
