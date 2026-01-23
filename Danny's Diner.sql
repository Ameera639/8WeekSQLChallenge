 --1-What is the total amount each customer spent at the restaurant?
SELECT 
    S.customer_id,
    SUM(M.price) AS Total_spend
FROM sales AS S
INNER JOIN menu AS M
ON S.product_id = M.product_id
GROUP BY S.customer_id;

/*
Answer:
customer_id    Total_spend
A	             76
B	             74
C	             36

*/

 --2-How many days has each customer visited the restaurant?
SELECT
    customer_id,
    COUNT(DISTINCT order_date) AS days
FROM sales
GROUP BY customer_id;


/*
Answer:
customer_id   Days
A       	  4
B       	  6
C        	  2


*/

--3-What was the first item from the menu purchased by each customer?
WITH CTE AS (
    SELECT 
        S.customer_id,
        S.product_id,
        M.product_name,
        RANK() OVER(PARTITION BY S.customer_id ORDER BY S.order_date ASC) AS rnk
    FROM sales AS S
    INNER JOIN menu AS M
        ON S.product_id = M.product_id
)
SELECT
    customer_id,
    product_id,
    product_name
FROM CTE
WHERE rnk = 1;
/*
Answer:
customer_id   product_id      product_name

A	              1	            sushi
A	              2	            curry
B	              2	            curry
C	              3	            ramen
C	              3	            ramen

*/

--4-What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT
    menu.product_name,
    COUNT(sales.order_date) AS Orders
FROM sales
INNER JOIN menu
    ON sales.product_id = menu.product_id
GROUP BY menu.product_name
ORDER BY Orders DESC
LIMIT 1;

/*
Answer:

product_name  Orders
ramen	        8

*/

--5-Which item was the most popular for each customer?
WITH CustomerRank AS (
    SELECT
        sales.customer_id,
        menu.product_name,
        COUNT(*) AS Orders,
        RANK() OVER(PARTITION BY sales.customer_id ORDER BY COUNT(*) DESC) AS rnk
    FROM sales
    INNER JOIN menu
        ON sales.product_id = menu.product_id
    GROUP BY sales.customer_id, menu.product_name
)
SELECT
    customer_id,
    product_name,
    Orders
FROM CustomerRank
WHERE rnk = 1;

/*
Answer:
customer_id  product_name  Orders
A	           ramen	     3
B	           sushi	     2
B	           ramen	     2
B	           curry	     2
C	           ramen	     3

*/

--6-Which item was purchased first by the customer after they became a member?
WITH CTE AS (
    SELECT 
        sales.customer_id,
        sales.product_id,
        menu.product_name,
        sales.order_date,
        RANK() OVER(PARTITION BY sales.customer_id ORDER BY sales.order_date ASC) AS rnk
    FROM sales
    INNER JOIN menu
        ON sales.product_id = menu.product_id
    INNER JOIN members
        ON sales.customer_id = members.customer_id
    WHERE sales.order_date >= members.join_date
)
SELECT
    customer_id,
    product_name,
    order_date
FROM CTE
WHERE rnk = 1;

/*
Answer:
customer_id  product_name      order_date
A	             curry	       2021-01-07
B	             sushi	       2021-01-11

*/

--7-Which item was purchased just before the customer became a member?

WITH CTE AS (
    SELECT 
        sales.customer_id,
        sales.product_id,
        menu.product_name,
        sales.order_date,
        RANK() OVER(PARTITION BY sales.customer_id ORDER BY sales.order_date DESC) AS rnk
    FROM sales
    INNER JOIN menu
        ON sales.product_id = menu.product_id
    INNER JOIN members
        ON sales.customer_id = members.customer_id
    WHERE sales.order_date < members.join_date
)
SELECT
    customer_id,
    product_name,
    order_date
FROM CTE
WHERE rnk = 1;
/*
Answer:
    customer_id product_name  order_date

       A	       sushi	   2021-01-01
       A	       curry	   2021-01-01
       B	       sushi	   2021-01-04

*/

--8-What is the total items and amount spent for each member before they became a member?
SELECT
    sales.customer_id,
    COUNT(sales.product_id) AS total_items,
    SUM(menu.price) AS total_spent
FROM sales
INNER JOIN menu
    ON sales.product_id = menu.product_id
INNER JOIN members
    ON sales.customer_id = members.customer_id
WHERE sales.order_date < members.join_date
GROUP BY sales.customer_id;

/*
Answer:
customer_id  total_items  total_spent
A	             2	          25
B	             3	          40

*/

--9-If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT
    sales.customer_id,
    SUM(
        CASE 
            WHEN menu.product_name = 'sushi' THEN menu.price * 10 * 2
            ELSE menu.price * 10
        END
    ) AS points
FROM sales
INNER JOIN menu
    ON sales.product_id = menu.product_id
GROUP BY sales.customer_id;
/*
Answer:
customer_id    points
A	            860
B	            940
C	            360

*/

--10-In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT
    sales.customer_id,
    SUM(
        CASE 
            WHEN sales.order_date BETWEEN members.join_date 
                 AND DATE(members.join_date, '+6 day')
            THEN menu.price * 10 * 2
            ELSE 
                CASE 
                    WHEN menu.product_name = 'sushi' THEN menu.price * 10 * 2
                    ELSE menu.price * 10
                END
        END
    ) AS points
FROM sales
INNER JOIN menu
    ON sales.product_id = menu.product_id
INNER JOIN members
    ON sales.customer_id = members.customer_id
WHERE sales.customer_id IN ('A','B')
  AND sales.order_date <= '2021-01-31'
GROUP BY sales.customer_id;

/*
Answer:
customer_id  points
A	          1370
B	           820

*/




