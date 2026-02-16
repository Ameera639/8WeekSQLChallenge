-- ==========================
-- Product-level funnel
-- ==========================
DROP TABLE IF EXISTS clique_bait.product_funnel;

CREATE TABLE clique_bait.product_funnel AS
SELECT 
    ph.product_id,
    -- Count of product views
    SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS views,
    -- Count of times product was added to cart
    SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS cart_adds,
    -- Count of products added to cart but NOT purchased
    SUM(
        CASE 
            WHEN e.event_type = 2 
                 AND NOT EXISTS (
                     SELECT 1 
                     FROM clique_bait.events e2
                     WHERE e2.event_type = 3 
                       AND e2.page_id = e.page_id
                 )
            THEN 1 
            ELSE 0 
        END
    ) AS abandoned,
    -- Count of products purchased
    SUM(CASE WHEN e.event_type = 3 THEN 1 ELSE 0 END) AS purchases
FROM clique_bait.events e
JOIN clique_bait.page_hierarchy ph
  ON e.page_id = ph.page_id
GROUP BY ph.product_id;

-- Example output (product_funnel table):
-- | product_id | views | cart_adds | abandoned | purchases |
-- |------------|-------|-----------|-----------|-----------|
-- | 101        | 500   | 120       | 30        | 90        |
-- | 102        | 300   | 80        | 10        | 70        |
-- | 103        | 450   | 100       | 25        | 75        |


-- ==========================
-- Category-level funnel
-- ==========================
DROP TABLE IF EXISTS clique_bait.category_funnel;

CREATE TABLE clique_bait.category_funnel AS
SELECT 
    ph.product_category,
    SUM(pf.views) AS views,           -- Total views per category
    SUM(pf.cart_adds) AS cart_adds,   -- Total cart adds per category
    SUM(pf.abandoned) AS abandoned,   -- Total abandoned per category
    SUM(pf.purchases) AS purchases    -- Total purchases per category
FROM clique_bait.product_funnel pf
JOIN clique_bait.page_hierarchy ph
  ON pf.product_id = ph.product_id
GROUP BY ph.product_category;

-- Example output (category_funnel table):
-- | product_category | views | cart_adds | abandoned | purchases |
-- |-----------------|-------|-----------|-----------|-----------|
-- | Electronics     | 1000  | 250       | 50        | 200       |
-- | Apparel         | 800   | 200       | 40        | 160       |
-- | Home & Garden   | 600   | 150       | 25        | 125       |


-- ==========================
-- Insights
-- ==========================

-- a) Most viewed / cart added / purchased product
SELECT * 
FROM clique_bait.product_funnel
ORDER BY views DESC, cart_adds DESC, purchases DESC
LIMIT 1;

-- Expected output:
-- | product_id | views | cart_adds | abandoned | purchases |
-- |------------|-------|-----------|-----------|-----------|
-- | null       | 7059  | 0         | 0         | 1777     |


-- b) Most abandoned product
SELECT *,
       ROUND(abandoned*100.0/NULLIF(cart_adds,0),2) AS abandoned_pct
FROM clique_bait.product_funnel
ORDER BY abandoned_pct DESC
LIMIT 1;

-- Expected output:
-- | product_id | views | cart_adds | abandoned | purchases | abandoned_pct |
-- |------------|-------|-----------|-----------|-----------|---------------|
-- |null        | 7059   |0       |0            |1777       |null       |


-- c) Highest view → purchase %
SELECT *,
       ROUND(purchases*100.0/NULLIF(views,0),2) AS view_to_purchase_pct
FROM clique_bait.product_funnel
ORDER BY view_to_purchase_pct DESC
LIMIT 1;

-- Expected output:
-- | product_id | views | cart_adds | abandoned | purchases | view_to_purchase_pct |
-- |------------|-------|-----------|-----------|-----------|--------------------|
-- | null       |7059   | 0        | 0       |1777          | 25.17            |


-- d) Average view → cart add %
SELECT ROUND(SUM(cart_adds)*100.0/NULLIF(SUM(views),0),2) AS avg_view_to_cart_pct
FROM clique_bait.product_funnel;

-- Expected output:
-- | avg_view_to_cart_pct |
-- |--------------------|
-- | 40.38            |


-- e) Average cart add → purchase %
SELECT ROUND(SUM(purchases)*100.0/NULLIF(SUM(cart_adds),0),2) AS avg_cart_to_purchase_pct
FROM clique_bait.product_funnel;

-- Expected output:
-- | avg_cart_to_purchase_pct |
-- |-------------------------|
-- |21.03                    |
