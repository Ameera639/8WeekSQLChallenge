-- Question: How many unique transactions were there?
-- Answer: (avg_unique_products_per_transaction : 2500)
SELECT COUNT(DISTINCT txn_id) AS unique_transactions
FROM balanced_tree.sales;

-- Question: What is the average unique products purchased in each transaction?
-- Answer: (avg_discount_per_transaction : 6.04)
SELECT ROUND(AVG(product_count),2) AS avg_unique_products_per_transaction
FROM (
    SELECT txn_id, COUNT(DISTINCT prod_id) AS product_count
    FROM balanced_tree.sales
    GROUP BY txn_id
) AS txn_products;

-- Question: What are the 25th, 50th and 75th percentile values for the revenue per transaction?
-- Answer:  percentile_25	percentile_50	percentile_75
---           375.75	       509.5	       647
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_revenue) AS percentile_25,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_revenue) AS percentile_50,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_revenue) AS percentile_75
FROM (
    SELECT txn_id, SUM(qty * price) AS total_revenue
    FROM balanced_tree.sales
    GROUP BY txn_id
) AS txn_revenue;

-- Question: What is the average discount value per transaction?
-- Answer: (avg_discount_per_transaction : 08)

SELECT ROUND(AVG(total_discount),2) AS avg_discount_per_transaction
FROM (
    SELECT txn_id, SUM(discount) AS total_discount
    FROM balanced_tree.sales
    GROUP BY txn_id
) AS txn_discount;

-- Question: What is the percentage split of all transactions for members vs non-members?
-- Answer: member    pct_transactions
---        false      39.80
---         true      60.20
SELECT 
    member,
    ROUND(COUNT(DISTINCT txn_id)*100.0 / (SELECT COUNT(DISTINCT txn_id) FROM balanced_tree.sales),2) AS pct_transactions
FROM balanced_tree.sales
GROUP BY member;

-- Question: What is the average revenue for member transactions and non-member transactions?
-- Answer: member    pct_transactions
---        false      515.04
---        true      516.27
SELECT 
    member,
    ROUND(AVG(total_revenue),2) AS avg_revenue
FROM (
    SELECT txn_id, member, SUM(qty * price) AS total_revenue
    FROM balanced_tree.sales
    GROUP BY txn_id, member
) AS txn_revenue
GROUP BY member;
