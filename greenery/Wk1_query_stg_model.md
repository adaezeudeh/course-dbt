1). How many users do we have?

select count (1) from users;
--130

2). On average, how many orders do we receive per hour?

WITH hourly_orders AS (
  SELECT COUNT(1) as num_orders, 
         EXTRACT(HOUR FROM created_at) as hour
  FROM orders
  GROUP BY hour
)
SELECT round(AVG(num_orders),0) FROM hourly_orders;
--15

3). On average, how long does an order take from being placed to being delivered?

WITH delivery_times AS (
  SELECT DATE_PART('day', delivered_at - created_at) as delivery_time
  FROM orders
)
SELECT round(AVG(delivery_time) * 24) as avg_delivery_time_hours FROM delivery_times;

4). How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

WITH user_purchases AS (
  SELECT user_id, COUNT(1) as num_purchases
  FROM orders
  GROUP BY user_id
)
SELECT 
  CASE
    WHEN num_purchases = 1 THEN 'one purchase'
    WHEN num_purchases = 2 THEN 'two purchases'
    ELSE 'three or more purchases'
  END as num_purchases, 
  COUNT(1) as num_users
FROM user_purchases
GROUP BY num_purchases
HAVING num_purchases <= 2
UNION ALL
SELECT 'three or more purchases' as num_purchases, 
       COUNT(1) as num_users
FROM user_purchases
WHERE num_purchases > 2;
--one purchase
	
25
two purchases
	
28
three or more purchases
	
71


5). 
On average, how many unique sessions do we have per hour?
WITH hourly_sessions AS (
  SELECT COUNT(DISTINCT session_id) as num_sessions, 
         EXTRACT(HOUR FROM created_at) as hour
  FROM events
  GROUP BY hour
)
SELECT round(AVG(num_sessions)) FROM hourly_sessions;
