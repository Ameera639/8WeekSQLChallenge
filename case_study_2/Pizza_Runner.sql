
--How many pizzas were ordered?
SELECT COUNT(*) AS total_pizzas_ordered
FROM customer_orders;


--How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM customer_orders;


--How many successful orders were delivered by each runner?

SELECT runner_id,
       COUNT(*) AS successful_deliveries
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id
ORDER BY runner_id;

--How many of each type of pizza was delivered?

SELECT p.pizza_name,
       COUNT(*) AS total_delivered
FROM customer_orders c
JOIN pizza_names p ON c.pizza_id = p.pizza_id
GROUP BY p.pizza_name;


--How many Vegetarian and Meatlovers were ordered by each customer?

SELECT customer_id,
       SUM(CASE WHEN pizza_id = 1 THEN 1 ELSE 0 END) AS Meatlovers_count,
       SUM(CASE WHEN pizza_id = 2 THEN 1 ELSE 0 END) AS Vegetarian_count
FROM customer_orders
GROUP BY customer_id;

--What was the maximum number of pizzas delivered in a single order?


SELECT MAX(pizza_count) AS max_pizzas_in_single_order
FROM (
    SELECT order_id, COUNT(*) AS pizza_count
    FROM customer_orders
    GROUP BY order_id
) AS t;

--For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT customer_id,
       SUM(CASE WHEN (exclusions IS NOT NULL AND exclusions != '') OR 
                     (extras IS NOT NULL AND extras != '') THEN 1 ELSE 0 END) AS pizzas_with_changes,
       SUM(CASE WHEN (exclusions IS NULL OR exclusions = '') AND 
                     (extras IS NULL OR extras = '') THEN 1 ELSE 0 END) AS pizzas_without_changes
FROM customer_orders
GROUP BY customer_id;

--How many pizzas were delivered that had both exclusions and extras?

SELECT COUNT(*) AS pizzas_with_exclusions_and_extras
FROM customer_orders
WHERE (exclusions IS NOT NULL AND exclusions != '')
  AND (extras IS NOT NULL AND extras != '');

  --Total volume of pizzas ordered for each hour of the day

  
  SELECT strftime('%H', order_time) AS order_hour,
       COUNT(*) AS total_pizzas
FROM customer_orders
GROUP BY order_hour
ORDER BY order_hour;
--Volume of orders for each day of the week


SELECT strftime('%w', order_time) AS day_of_week,
       COUNT(*) AS total_orders
FROM customer_orders
GROUP BY day_of_week
ORDER BY day_of_week;
