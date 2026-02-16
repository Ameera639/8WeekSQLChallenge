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

📈 Output / Results


HIGH LEVEL SALES ANALYSIS

| Question                                                               | Answer    |
| ---------------------------------------------------------------------- | --------- |
| What was the total quantity sold for all products?                     | 45216     |
| What is the total generated revenue for all products before discounts? | 1,289,453 |
| What was the total discount amount for all products?                   | 182,700   |


TRANSACTION ANALYSIS

| Question                                                                            | Answer                               |
| ----------------------------------------------------------------------------------- | ------------------------------------ |
| How many unique transactions were there?                                            | 2,500                                |
| What is the average unique products purchased in each transaction?                  | 6.04                                 |
| What are the 25th, 50th and 75th percentile values for the revenue per transaction? | 25th: 375.75, 50th: 509.5, 75th: 647 |
| What is the average discount value per transaction?                                 | 8.04                                 |
| What is the percentage split of all transactions for members vs non-members?        | Member: 60.20%, Non-member: 39.80%   |
| What is the average revenue for member transactions and non-member transactions?    | Member: 516.27, Non-member: 515.04   |


PRODUCT ANALYSIS
| Question                                                                                              | Answer                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| What are the top 3 products by total revenue before discount?                                         | 1) 2a2353: 217,683 <br> 2) 9ec847: 209,304 <br> 3) 5d267b: 152,000                                                                                                                                                                                                                                                                                                                                                                                                        |
| What is the total quantity, revenue and discount for each segment?                                    | See segment totals: <br> c4a632: 3856 / 50,128 / 15,418 <br> f084eb: 3792 / 136,512 / 15,646 <br> 9ec847: 3876 / 209,304 / 15,500 <br> e83aa3: 3786 / 121,152 / 15,257 <br> c8d436: 3646 / 36,460 / 15,003 <br> e31d39: 3707 / 37,070 / 15,065 <br> b9a74d: 3655 / 62,135 / 14,873 <br> 2a2353: 3819 / 217,683 / 15,553 <br> d5e9a6: 3752 / 86,296 / 14,669 <br> 72f5d4: 3757 / 71,383 / 15,283 <br> 2feb6b: 3770 / 109,330 / 14,946 <br> 5d267b: 3800 / 152,000 / 15,487 |
| What is the top selling product for each segment?                                                     | Each product is the top in its segment with quantities: <br> 2a2353: 3819, 2feb6b: 3770, 5d267b: 3800, 72f5d4: 3757, 9ec847: 3876, b9a74d: 3655, c4a632: 3856, c8d436: 3646, d5e9a6: 3752, e31d39: 3707, e83aa3: 3786, f084eb: 3792                                                                                                                                                                                                                                       |
| What is the total quantity, revenue and discount for each category?                                   | Same as segments (no separate category mapping), totals identical                                                                                                                                                                                                                                                                                                                                                                                                         |
| What is the top selling product for each category?                                                    | Same as segment top sellers                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| What is the percentage split of revenue by product for each segment?                                  | Each product contributes 100% of its own segment                                                                                                                                                                                                                                                                                                                                                                                                                          |
| What is the percentage split of revenue by segment for each category?                                 | Each segment contributes 100% of its category                                                                                                                                                                                                                                                                                                                                                                                                                             |
| What is the percentage split of total revenue by category?                                            | c4a632: 3.89% <br> f084eb: 10.59% <br> 9ec847: 16.23% <br> e83aa3: 9.40% <br> c8d436: 2.83% <br> e31d39: 2.87% <br> b9a74d: 4.82% <br> 2a2353: 16.88% <br> d5e9a6: 6.69% <br> 72f5d4: 5.54% <br> 2feb6b: 8.48% <br> 5d267b: 11.79%                                                                                                                                                                                                                                        |
| What is the total transaction “penetration” for each product?                                         | 2a2353: 50.72% <br> 2feb6b: 50.32% <br> 5d267b: 50.72% <br> 72f5d4: 50.00% <br> 9ec847: 51.00% <br> b9a74d: 49.72% <br> c4a632: 50.96% <br> c8d436: 49.68% <br> d5e9a6: 49.88% <br> e31d39: 49.72% <br> e83aa3: 49.84% <br> f084eb: 51.24%                                                                                                                                                                                                                                |
| What is the most common combination of at least 1 quantity of any 3 products in a single transaction? | 5d267b + 9ec847 + c8d436: 352 transactions                                                                                                                                                                                                                                                                                                                                                                                                                                |


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
