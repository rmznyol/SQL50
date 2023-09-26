-- Page With No Likes [Facebook SQL Interview Question] (Easy)

SELECT pages.page_id 
FROM pages
LEFT JOIN page_likes
ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id is NULL;

-- Unfinished Parts [Tesla SQL Interview Question] (Easy)

SELECT part, assembly_step 
FROM parts_assembly
WHERE finish_date is NULL;

-- Histogram of Tweets [Twitter SQL Interview Question] (Easy)

SELECT *, COUNT(*) as users_num
FROM (
  SELECT COUNT(tweet_id) as tweet_bucket
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
) as T 
GROUP BY tweet_bucket

-- Laptop vs. Mobile Viewership [New York Times SQL Interview Question] (Easy)
SELECT SUM(
  CASE device_type 
  WHEN 'laptop' THEN 1
  ELSE 0 END) as laptop_views,
  SUM(CASE device_type 
  WHEN 'tablet' THEN 1
  WHEN 'phone' THEN 1
  ELSE 0 END) as mobile_views
FROM viewership;

-- Average Post Hiatus (Part 1) [Facebook SQL Interview Question] (Easy)

SELECT  user_id,
EXTRACT(DAY FROM MAX(post_date) - MIN(post_Date)) as days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Teams Power Users [Microsoft SQL Interview Question] (Easy)

SELECT  sender_id, COUNT(message_id) as message_count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = 8 AND
EXTRACT(YEAR FROM sent_date) = 2022
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;


-- Cities With Completed Trades [Robinhood SQL Interview Question] (Easy)

SELECT u.city, COUNT(*) as total_orders
FROM trades as t
INNER JOIN users as u
ON t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3;

-- Average Review Ratings [Amazon SQL Interview Question] (Easy)

SELECT EXTRACT(MONTH FROM submit_date), product_id as product, ROUNd(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY product_id, EXTRACT(YEAR FROM submit_date), EXTRACT(MONTH FROM submit_date)
ORDER BY EXTRACT(YEAR FROM submit_date), EXTRACT(MONTH FROM submit_date), product_id;

-- App Click-through Rate (CTR) [Facebook SQL Interview Question] (easy)

SELECT app_id, ROUND(100.0 *
    SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2)  AS ctr_rate
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id;

-- Second Day Confirmation [TikTok SQL Interview Question] (Easy)

SELECT DISTINCT user_id 
FROM emails as e 
INNER JOIN texts as t
ON e.email_id = t.email_id
WHERE t.signup_action = 'Confirmed'
AND e.signup_date + INTERVAL '1 day' =  t.action_date;

-- Cards Issued Difference [JPMorgan Chase SQL Interview Question] (Easy)

SELECT card_name, MAX(issued_amount) - MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;


-- Compressed Mean [Alibaba SQL Interview Question] (Easy)

SELECT ROUND(SUM(item_count :: DECIMAL * order_occurrences)/ SUM(order_occurrences), 1) as mean
FROM items_per_order;

-- Pharmacy Analytics (Part 1) [CVS Health SQL Interview Question] (Easy)

SELECT drug, total_sales - cogs as total_profit
FROM pharmacy_sales
ORDER BY total_profit DESC
LIMIT 3 ;

-- Pharmacy Analytics (Part 2) [CVS Health SQL Interview Question]

SELECT manufacturer, COUNT(drug) as drug_count, SUM(cogs- total_sales) as total_loss
FROM pharmacy_sales
WHERE total_sales - cogs < 0
GROUP BY manufacturer
ORDER BY total_loss DESC;

-- Pharmacy Analytics (Part 3) [CVS Health SQL Interview Question] (Easy)

SELECT manufacturer, CONCAT('$',ROUND(SUM(total_sales) / 1000000)::VARCHAR, ' million') as sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY ROUND(SUM(total_sales) / 1000000) DESC, manufacturer DESC;