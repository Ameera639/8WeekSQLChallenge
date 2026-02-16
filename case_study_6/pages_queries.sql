-- 7. Top 3 pages by views
SELECT ph.page_name,
       COUNT(*) AS view_count
FROM clique_bait.events e
JOIN clique_bait.page_hierarchy ph
  ON e.page_id = ph.page_id
WHERE event_type=1
GROUP BY ph.page_name
ORDER BY view_count DESC
LIMIT 3;

-- Expected Output:
-- | page_name   | view_count |
-- |-------------------------- |
-- | All Products   | 3174     |
-- |Checkout        | 2103     |
-- | Home Page       | 1782    |

-- 8. Views and cart adds per product category
SELECT ph.product_category,
       SUM(CASE WHEN e.event_type=1 THEN 1 ELSE 0 END) AS views,
       SUM(CASE WHEN e.event_type=2 THEN 1 ELSE 0 END) AS cart_adds
FROM clique_bait.events e
JOIN clique_bait.page_hierarchy ph
  ON e.page_id = ph.page_id
GROUP BY ph.product_category;

-- Expected Output:
-- | product_category | views | cart_adds |
-- |--------------------------------------|
-- | null            |7059     | 0        |
-- | Luxury          |3032     | 1870     |
-- |Shellfish        |6204     | 3792     |
-- |Fish             |4633     |2789      |



-- 9. Top 3 products by purchases
SELECT ph.product_id,
       COUNT(*) AS purchase_count
FROM clique_bait.events e
JOIN clique_bait.page_hierarchy ph
  ON e.page_id = ph.page_id
WHERE event_type=3
GROUP BY ph.product_id
ORDER BY purchase_count DESC
LIMIT 3;

-- Expected Output:
-- | product_id | purchase_count |
-- |-----------------------|
-- |null    | 1777         |
-