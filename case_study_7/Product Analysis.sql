-- Question: What are the top 3 products by total revenue before discount?
-- Answer:
-- prod_id	total_revenue
-- 2a2353	217683
-- 9ec847	209304
-- 5d267b	152000
SELECT prod_id, SUM(qty * price) AS total_revenue
FROM balanced_tree.sales
GROUP BY prod_id
ORDER BY total_revenue DESC
LIMIT 3;

-- Question: What is the total quantity, revenue and discount for each product (segment equivalent)?
-- Answer:
-- segment	total_quantity	total_revenue	total_discount
-- c4a632	3856	50128	15418
-- f084eb	3792	136512	15646
-- 9ec847	3876	209304	15500
-- e83aa3	3786	121152	15257
-- c8d436	3646	36460	15003
-- e31d39	3707	37070	15065
-- b9a74d	3655	62135	14873
-- 2a2353	3819	217683	15553
-- d5e9a6	3752	86296	14669
-- 72f5d4	3757	71383	15283
-- 2feb6b	3770	109330	14946
-- 5d267b	3800	152000	15487
SELECT prod_id AS segment,
       SUM(qty) AS total_quantity,
       SUM(qty * price) AS total_revenue,
       SUM(discount) AS total_discount
FROM balanced_tree.sales
GROUP BY prod_id;

-- Question: What is the top selling product for each segment?
-- Answer:
-- segment	prod_id	total_quantity
-- 2a2353	2a2353	3819
-- 2feb6b	2feb6b	3770
-- 5d267b	5d267b	3800
-- 72f5d4	72f5d4	3757
-- 9ec847	9ec847	3876
-- b9a74d	b9a74d	3655
-- c4a632	c4a632	3856
-- c8d436	c8d436	3646
-- d5e9a6	d5e9a6	3752
-- e31d39	e31d39	3707
-- e83aa3	e83aa3	3786
-- f084eb	f084eb	3792
WITH segment_sales AS (
    SELECT prod_id AS segment, prod_id, SUM(qty) AS total_quantity,
           ROW_NUMBER() OVER (PARTITION BY prod_id ORDER BY SUM(qty) DESC) AS rn
    FROM balanced_tree.sales
    GROUP BY prod_id
)
SELECT segment, prod_id, total_quantity
FROM segment_sales
WHERE rn = 1;

-- Question: What is the total quantity, revenue and discount for each category?
-- Answer:
-- category	total_quantity	total_revenue	total_discount
-- c4a632	3856	50128	15418
-- f084eb	3792	136512	15646
-- 9ec847	3876	209304	15500
-- e83aa3	3786	121152	15257
-- c8d436	3646	36460	15003
-- e31d39	3707	37070	15065
-- b9a74d	3655	62135	14873
-- 2a2353	3819	217683	15553
-- d5e9a6	3752	86296	14669
-- 72f5d4	3757	71383	15283
-- 2feb6b	3770	109330	14946
-- 5d267b	3800	152000	15487
SELECT prod_id AS category,
       SUM(qty) AS total_quantity,
       SUM(qty * price) AS total_revenue,
       SUM(discount) AS total_discount
FROM balanced_tree.sales
GROUP BY prod_id;

-- Question: What is the top selling product for each category?
-- Answer:
-- category	prod_id	total_quantity
-- 2a2353	2a2353	3819
-- 2feb6b	2feb6b	3770
-- 5d267b	5d267b	3800
-- 72f5d4	72f5d4	3757
-- 9ec847	9ec847	3876
-- b9a74d	b9a74d	3655
-- c4a632	c4a632	3856
-- c8d436	c8d436	3646
-- d5e9a6	d5e9a6	3752
-- e31d39	e31d39	3707
-- e83aa3	e83aa3	3786
-- f084eb	f084eb	3792
WITH category_sales AS (
    SELECT prod_id AS category, prod_id, SUM(qty) AS total_quantity,
           ROW_NUMBER() OVER (PARTITION BY prod_id ORDER BY SUM(qty) DESC) AS rn
    FROM balanced_tree.sales
    GROUP BY prod_id
)
SELECT category, prod_id, total_quantity
FROM category_sales
WHERE rn = 1;

-- Question: What is the percentage split of revenue by product for each segment?
-- Answer:
-- segment	prod_id	pct_revenue
-- 2a2353	2a2353	100.00
-- 2feb6b	2feb6b	100.00
-- 5d267b	5d267b	100.00
-- 72f5d4	72f5d4	100.00
-- 9ec847	9ec847	100.00
-- b9a74d	b9a74d	100.00
-- c4a632	c4a632	100.00
-- c8d436	c8d436	100.00
-- d5e9a6	d5e9a6	100.00
-- e31d39	e31d39	100.00
-- e83aa3	e83aa3	100.00
-- f084eb	f084eb	100.00
SELECT prod_id AS segment, prod_id,
       ROUND(SUM(qty * price) *100.0 / SUM(SUM(qty * price)) OVER (PARTITION BY prod_id),2) AS pct_revenue
FROM balanced_tree.sales
GROUP BY prod_id;

-- Question: What is the percentage split of revenue by segment for each category?
-- Answer:
-- category	segment	pct_revenue
-- 2a2353	2a2353	100.00
-- 2feb6b	2feb6b	100.00
-- 5d267b	5d267b	100.00
-- 72f5d4	72f5d4	100.00
-- 9ec847	9ec847	100.00
-- b9a74d	b9a74d	100.00
-- c4a632	c4a632	100.00
-- c8d436	c8d436	100.00
-- d5e9a6	d5e9a6	100.00
-- e31d39	e31d39	100.00
-- e83aa3	e83aa3	100.00
-- f084eb	f084eb	100.00
SELECT prod_id AS category, prod_id AS segment,
       ROUND(SUM(qty * price) *100.0 / SUM(SUM(qty * price)) OVER (PARTITION BY prod_id),2) AS pct_revenue
FROM balanced_tree.sales
GROUP BY prod_id;

-- Question: What is the percentage split of total revenue by category?
-- Answer:
-- category	pct_total_revenue
-- c4a632	3.89
-- f084eb	10.59
-- 9ec847	16.23
-- e83aa3	9.40
-- c8d436	2.83
-- e31d39	2.87
-- b9a74d	4.82
-- 2a2353	16.88
-- d5e9a6	6.69
-- 72f5d4	5.54
-- 2feb6b	8.48
-- 5d267b	11.79
SELECT prod_id AS category,
       ROUND(SUM(qty * price) *100.0 / SUM(SUM(qty * price)) OVER (),2) AS pct_total_revenue
FROM balanced_tree.sales
GROUP BY prod_id;

-- Question: What is the total transaction “penetration” for each product?
-- Answer:
-- prod_id	penetration_pct
-- 2a2353	50.72
-- 2feb6b	50.32
-- 5d267b	50.72
-- 72f5d4	50.00
-- 9ec847	51.00
-- b9a74d	49.72
-- c4a632	50.96
-- c8d436	49.68
-- d5e9a6	49.88
-- e31d39	49.72
-- e83aa3	49.84
-- f084eb	51.24
SELECT prod_id,
       ROUND(COUNT(DISTINCT txn_id)*100.0 / (SELECT COUNT(DISTINCT txn_id) FROM balanced_tree.sales),2) AS penetration_pct
FROM balanced_tree.sales
WHERE qty >= 1
GROUP BY prod_id;

-- Question: What is the most common combination of at least 1 quantity of any 3 products in a single transaction?
-- Answer:
-- product_id_1	product_id_2	product_id_3	combination_count
-- 5d267b	9ec847	c8d436	352
WITH txn_products AS (
    SELECT txn_id, prod_id
    FROM balanced_tree.sales
    WHERE qty >= 1
)
SELECT product_id_1, product_id_2, product_id_3, COUNT(*) AS combination_count
FROM (
    SELECT t1.txn_id, t1.prod_id AS product_id_1,
           t2.prod_id AS product_id_2,
           t3.prod_id AS product_id_3
    FROM txn_products t1
    JOIN txn_products t2 ON t1.txn_id = t2.txn_id AND t1.prod_id < t2.prod_id
    JOIN txn_products t3 ON t1.txn_id = t3.txn_id AND t2.prod_id < t3.prod_id
) AS combos
GROUP BY product_id_1, product_id_2, product_id_3
ORDER BY combination_count DESC
LIMIT 1;
