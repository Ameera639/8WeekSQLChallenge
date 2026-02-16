-- 4. Number of events per event type
SELECT ei.event_name,
       COUNT(e.event_type) AS total_events
FROM clique_bait.events e
JOIN clique_bait.event_identifier ei
  ON e.event_type = ei.event_type
GROUP BY ei.event_name
ORDER BY total_events DESC;

-- Expected Output:
-- | event_name     total_events |
-- |-----------------------------|
-- | Page View     |20928        |
-- | Add to Cart   |8451         |
-- | Purchase      | 1777        |
-- |Ad Impression  | 876         |
-- | Ad Click      | 702         |

-- 5. Percentage of visits with purchase
SELECT ROUND(
    COUNT(DISTINCT CASE WHEN event_type=3 THEN visit_id END)*100.0
    / COUNT(DISTINCT visit_id),2) AS purchase_visit_pct
FROM clique_bait.events;

-- Expected Output:
-- | purchase_visit_pct |
-- |------------------|
-- |49.86             |

-- 6. Percentage of visits viewing checkout but no purchase
SELECT ROUND(
    COUNT(DISTINCT CASE WHEN event_type=2 AND visit_id NOT IN 
        (SELECT DISTINCT visit_id FROM clique_bait.events WHERE event_type=3)
    THEN visit_id END)*100.0
    / COUNT(DISTINCT visit_id),2) AS checkout_no_purchase_pct
FROM clique_bait.events;

-- Expected Output:
-- | checkout_no_purchase_pct |
-- |------------------------- |
-- | 20.57                    |