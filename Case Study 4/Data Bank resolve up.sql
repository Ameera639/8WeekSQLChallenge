-- =========================================
-- A. Customer Nodes Exploration
-- =========================================

-- 1️⃣ How many unique nodes are there on the Data Bank system?

SELECT COUNT(DISTINCT node_id) AS unique_nodes
FROM data_bank.customer_nodes;

-- 2️⃣ What is the number of nodes per region?
SELECT R.region_name,
       COUNT(DISTINCT C.node_id) AS nodes_per_region
FROM customer_nodes AS C
INNER JOIN regions AS R 
    ON C.region_id = R.region_id
GROUP BY R.region_name
LIMIT 100;


-- 3️⃣ How many customers are allocated to each region?
SELECT 
    R.region_name,
    COUNT(C.customer_id) AS counts_customers,
    COUNT(DISTINCT C.customer_id) AS unique_customers
FROM customer_nodes AS C
INNER JOIN regions AS R
    ON C.region_id = R.region_id
GROUP BY R.region_name
LIMIT 100;

-- 4️⃣ How many days on average are customers reallocated to a different node?
WITH days_in_node AS (
    SELECT 
        customer_id,
        node_id,
        SUM(end_date - start_date) AS days_in_node
    FROM customer_nodes
    WHERE end_date <> '9999-12-31'
    GROUP BY customer_id, node_id
)
SELECT 
    ROUND(AVG(days_in_node), 0) AS average_days_in_node
FROM days_in_node;



-- 5️⃣ Median, 80th, and 95th percentile for reallocation days per region

WITH days_in_node AS (
    SELECT 
        R.region_name,
        (end_date - start_date) AS days_in_node
    FROM customer_nodes C
    JOIN regions R
        ON R.region_id = C.region_id
    WHERE end_date <> '9999-12-31'
)

SELECT 
    region_name,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY days_in_node) AS median,
    PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY days_in_node) AS p80,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY days_in_node) AS p95
FROM days_in_node
GROUP BY region_name
ORDER BY region_name;



/* =========================================================
B. Customer Transactions
========================================================= */


/* ---------------------------------------------------------
1️⃣ What is the unique count and total amount for each transaction type?
--------------------------------------------------------- */

SELECT 
    txn_type,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(*) AS transaction_count,
    SUM(txn_amount) AS total_amount
FROM customer_transactions
GROUP BY txn_type
ORDER BY txn_type;



/* ---------------------------------------------------------
2️⃣ What is the average total historical deposit counts 
   and amounts for all customers?
--------------------------------------------------------- */

WITH deposits AS (
    SELECT 
        customer_id,
        COUNT(*) AS deposit_count,
        SUM(txn_amount) AS total_deposit_amount
    FROM customer_transactions
    WHERE txn_type = 'deposit'
    GROUP BY customer_id
)

SELECT 
    ROUND(AVG(deposit_count), 2) AS avg_deposit_count_per_customer,
    ROUND(AVG(total_deposit_amount), 2) AS avg_total_deposit_amount_per_customer
FROM deposits;



/* ---------------------------------------------------------
3️⃣ For each month - how many Data Bank customers 
   make more than 1 deposit AND either 
   1 purchase OR 1 withdrawal in a single month?
--------------------------------------------------------- */

WITH monthly_activity AS (
    SELECT 
        DATE_TRUNC('month', txn_date) AS month,
        customer_id,
        SUM(CASE WHEN txn_type = 'deposit' THEN 1 ELSE 0 END) AS deposits,
        SUM(CASE WHEN txn_type = 'purchase' THEN 1 ELSE 0 END) AS purchases,
        SUM(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS withdrawals
    FROM customer_transactions
    GROUP BY DATE_TRUNC('month', txn_date), customer_id
)

SELECT 
    month,
    COUNT(customer_id) AS customers_meeting_criteria
FROM monthly_activity
WHERE deposits > 1
  AND (purchases = 1 OR withdrawals = 1)
GROUP BY month
ORDER BY month;



/* ---------------------------------------------------------
4️⃣ What is the closing balance for each customer 
   at the end of each month?
--------------------------------------------------------- */

WITH monthly_net_change AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', txn_date) AS month,
        SUM(
            CASE 
                WHEN txn_type = 'deposit' THEN txn_amount
                ELSE -txn_amount
            END
        ) AS net_change
    FROM customer_transactions
    GROUP BY customer_id, DATE_TRUNC('month', txn_date)
),

running_balance AS (
    SELECT 
        customer_id,
        month,
        SUM(net_change) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS closing_balance
    FROM monthly_net_change
)

SELECT *
FROM running_balance
ORDER BY customer_id, month
LIMIT 10; 


/* ---------------------------------------------------------
5️⃣ What is the percentage of customers who increase 
   their closing balance by more than 5% month-over-month?
--------------------------------------------------------- */

WITH monthly_net_change AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', txn_date) AS month,
        SUM(
            CASE 
                WHEN txn_type = 'deposit' THEN txn_amount
                ELSE -txn_amount
            END
        ) AS net_change
    FROM customer_transactions
    GROUP BY customer_id, DATE_TRUNC('month', txn_date)
),

running_balance AS (
    SELECT 
        customer_id,
        month,
        SUM(net_change) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS closing_balance
    FROM monthly_net_change
),

balance_growth AS (
    SELECT 
        customer_id,
        month,
        closing_balance,
        LAG(closing_balance) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS previous_balance
    FROM running_balance
)

SELECT 
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN closing_balance > previous_balance * 1.05 
                THEN 1 ELSE 0 
            END
        ) / COUNT(*),
        2
    ) AS percentage_of_customers_increasing_balance
FROM balance_growth
WHERE previous_balance IS NOT NULL;

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
ORDER BY customer_id, txn_date
LIMIT 10;  -- 👈 Sugar screenshot limit


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
GROUP BY customer_id
ORDER BY customer_id
LIMIT 10;  -- 👈 Sugar screenshot limit


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
ORDER BY customer_id, month
LIMIT 10;  -- 👈 Sugar screenshot limit
