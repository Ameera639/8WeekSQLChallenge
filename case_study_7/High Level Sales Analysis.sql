-- Question: What was the total quantity sold for all products?
-- Answer: (45216)
SELECT SUM(qty) AS total_quantity_sold
FROM balanced_tree.sales;

-- Question: What is the total generated revenue for all products before discounts?
-- Answer: (1289453)
SELECT SUM(qty * price) AS total_revenue_before_discount
FROM balanced_tree.sales;

-- Question: What was the total discount amount for all products?
-- Answer: (182700)
SELECT SUM(discount) AS total_discount_amount
FROM balanced_tree.sales;
;