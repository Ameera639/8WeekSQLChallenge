-- =========================================
-- A. Customer Nodes Exploration
-- =========================================

-- 1️⃣ How many unique nodes are there on the Data Bank system?
SELECT COUNT(DISTINCT node_id) AS unique_nodes
FROM customer_nodes;


-- 2️⃣ What is the number of nodes per region?
SELECT region_id,
       COUNT(DISTINCT node_id) AS nodes_per_region
FROM customer_nodes
GROUP BY region_id
ORDER BY region_id;


-- 3️⃣ How many customers are allocated to each region?
SELECT region_id,
       COUNT(DISTINCT customer_id) AS customers_per_region
FROM customer_nodes
GROUP BY region_id
ORDER BY region_id;


-- 4️⃣ How many days on average are customers reallocated to a different node?
SELECT ROUND(AVG(end_date - start_date),2) AS avg_reallocation_days
FROM customer_nodes
WHERE end_date IS NOT NULL;


-- 5️⃣ Median, 80th, and 95th percentile for reallocation days per region
SELECT region_id,
       PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY end_date - start_date) AS median_days,
       PERCENTILE_CONT(0.8)  WITHIN GROUP (ORDER BY end_date - start_date) AS p80_days,
       PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY end_date - start_date) AS p95_days
FROM customer_nodes
WHERE end_date IS NOT NULL
GROUP BY region_id
ORDER BY region_id;


-- =========================================
-- B. Customer Transactions
-- =========================================

-- 1️⃣ Unique count and total amount for each transaction type
SELECT txn_type,
       COUNT(DISTINCT customer_id) AS unique_customers,
       SUM(txn_amount) AS total_amount
FROM customer_transactions
GROUP BY txn_type;


-- 2️⃣ Average total historical deposit counts and amounts for all customers
WITH deposits AS (
  SELECT customer_id,
         COUNT(*) AS deposit_count,
         SUM(txn_amount) AS deposit_amount
  FROM customer_transactions
  WHERE txn_type = 'deposit'
  GROUP BY customer_id
)
SELECT ROUND(AVG(deposit_count),2)  AS avg_deposit_count,
       ROUND(AVG(deposit_amount),2) AS avg_deposit_amount
FROM deposits;


-- 3️⃣ For each month - how many customers make >1 deposit AND >=1 purchase or withdrawal
WITH monthly_txns AS (
  SELECT customer_id,
         DATE_TRUNC('month', txn_date) AS txn_month,
         SUM(CASE WHEN txn_type = 'deposit' THEN 1 ELSE 0 END) AS deposits,
         SUM(CASE WHEN txn_type IN ('purchase','withdrawal') THEN 1 ELSE 0 END) AS spending
  FROM customer_transactions
  GROUP BY customer_id, txn_month
)
SELECT txn_month,
       COUNT(customer_id) AS customer_count
FROM monthly_txns
WHERE deposits > 1
  AND spending >= 1
GROUP BY txn_month
ORDER BY txn_month;


-- 4️⃣ Closing balance for each customer at the end of the month
WITH running_balance AS (
  SELECT customer_id,
         txn_date,
         DATE_TRUNC('month', txn_date) AS txn_month,
         SUM(
           CASE
             WHEN txn_type = 'deposit' THEN txn_amount
             ELSE -txn_amount
           END
         ) OVER (
           PARTITION BY customer_id
           ORDER BY txn_date
         ) AS balance
  FROM customer_transactions
)
SELECT customer_id,
       txn_month,
       MAX(balance) AS closing_balance
FROM running_balance
GROUP BY customer_id, txn_month
ORDER BY customer_id, txn_month;


-- 5️⃣ Percentage of customers who increase closing balance by >5%
WITH monthly_balance AS (
  SELECT customer_id,
         txn_month,
         MAX(balance) AS closing_balance
  FROM (
    SELECT customer_id,
           DATE_TRUNC('month', txn_date) AS txn_month,
           SUM(
             CASE
               WHEN txn_type = 'deposit' THEN txn_amount
               ELSE -txn_amount
             END
           ) OVER (
             PARTITION BY customer_id
             ORDER BY txn_date
           ) AS balance
    FROM customer_transactions
  ) t
  GROUP BY customer_id, txn_month
),
comparison AS (
  SELECT customer_id,
         closing_balance,
         LAG(closing_balance) OVER (
           PARTITION BY customer_id ORDER BY txn_month
         ) AS prev_balance
  FROM monthly_balance
)
SELECT ROUND(
  100.0 * COUNT(*) /
  (SELECT COUNT(DISTINCT customer_id) FROM customer_transactions),
  2
) AS percentage_customers
FROM comparison
WHERE prev_balance IS NOT NULL
  AND closing_balance > prev_balance * 1.05;


-- =========================================
-- C. Data Allocation Challenge
-- =========================================

-- 1️⃣ Running customer balance including impact of each transaction
SELECT customer_id,
       txn_date,
       txn_type,
       txn_amount,
       SUM(
         CASE
           WHEN txn_type = 'deposit' THEN txn_amount
           ELSE -txn_amount
         END
       ) OVER (
         PARTITION BY customer_id
         ORDER BY txn_date
       ) AS running_balance
FROM customer_transactions
ORDER BY customer_id, txn_date;


-- 2️⃣ Min, average, and maximum values of running balance per customer
WITH rb AS (
  SELECT customer_id,
         SUM(
           CASE
             WHEN txn_type = 'deposit' THEN txn_amount
             ELSE -txn_amount
           END
         ) OVER (
           PARTITION BY customer_id
           ORDER BY txn_date
         ) AS running_balance
  FROM customer_transactions
)
SELECT customer_id,
       MIN(running_balance) AS min_balance,
       ROUND(AVG(running_balance),2) AS avg_balance,
       MAX(running_balance) AS max_balance
FROM rb
GROUP BY customer_id;


-- =========================================
-- D. Extra Challenge – Interest Calculation
-- =========================================

-- 1️⃣ Monthly interest based on daily balance (annual rate 6%, no compounding)
WITH daily_balance AS (
  SELECT customer_id,
         txn_date,
         SUM(
           CASE
             WHEN txn_type = 'deposit' THEN txn_amount
             ELSE -txn_amount
           END
         ) OVER (
           PARTITION BY customer_id
           ORDER BY txn_date
         ) AS balance
  FROM customer_transactions
)
SELECT customer_id,
       DATE_TRUNC('month', txn_date) AS month,
       ROUND(SUM(balance * (0.06/365)),2) AS monthly_interest
FROM daily_balance
GROUP BY customer_id, month
ORDER BY customer_id, month;

