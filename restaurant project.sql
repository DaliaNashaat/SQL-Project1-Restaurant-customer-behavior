USE restaurant_db;

-- 1. View the menu_items table.
SELECT*
FROM menu_items

-- 2. Find the number of items on the menu.
SELECT COUNT(DISTINCT(item_name))
FROM menu_items 

-- 3. What are the least and most expensive items on the menu?
SELECT item_name, price
FROM menu_items
ORDER BY price

SELECT item_name, price
FROM menu_items
ORDER BY price DESC

-- 4. How many Italian dishes are on the menu?
SELECT COUNT(*)
FROM menu_items
WHERE category='Italian'

-- 5. What are the least and most expensive Italian dishes on the menu?
SELECT *
FROM menu_items
WHERE category='Italian'
ORDER BY price

SELECT *
FROM menu_items
WHERE category='Italian'
ORDER BY price DESC
-- 6. How many dishes are in each category?
SELECT category, COUNT(*) num_dishes
FROM menu_items
GROUP BY category

-- 7. What is the average dish price within each category?
SELECT category, AVG(price) avg_price
FROM menu_items
GROUP BY category

-- 1. View the order_details table.
SELECT*
FROM order_details
-- 2. What is the date range of the table?
SELECT MIN(order_date), MAX(order_date)
FROM order_details
-- 3. How many orders were made within this date range?
SELECT COUNT(DISTINCT(order_id))
FROM order_details
-- 4. How many items were ordered within this date range?
SELECT COUNT(*)
FROM order_details
-- 5. Which orders had the most number of items?
SELECT order_id, COUNT(item_id) NUM_ITEMS
FROM order_details
GROUP BY order_id
ORDER BY  NUM_ITEMS DESC

-- 6. How many orders had more than 12 items?
SELECT COUNT(*) AS num_orders_more_12
FROM
	(SELECT order_id, COUNT(item_id) NUM_ITEMS
	FROM order_details
	GROUP BY order_id
	HAVING NUM_ITEMS>12) AS T

-- 1. Combine the menu_items and order_details tables into a single table.
SELECT *
FROM menu_items 

SELECT *
FROM order_details

SELECT *
FROM menu_items m
LEFT JOIN order_details o
ON m.menu_item_id=o.item_id

-- 2. What were the least and most ordered items? What categories were they in?

SELECT item_name, category, COUNT(order_details_id) num_purchased
FROM menu_items m
LEFT JOIN order_details o
ON m.menu_item_id=o.item_id
GROUP BY item_name, category

-- 3. What were the top 5 orders that spent the most money?
SELECT o.order_id ,SUM(m.price) total_spent
FROM menu_items m
LEFT JOIN order_details o
ON m.menu_item_id=o.item_id
GROUP BY o.order_id
ORDER BY  total_spent DESC
LIMIT 5 
-- 4. View the details of the highest spend order. What insights can you gather from the order?
SELECT category, COUNT(item_id)
FROM menu_items m
LEFT JOIN order_details o
ON m.menu_item_id=o.item_id
WHERE order_id=440
GROUP BY category

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from them?
SELECT order_id, category, COUNT(item_id)
FROM menu_items m
LEFT JOIN order_details o
ON m.menu_item_id=o.item_id
WHERE order_id IN (440, 2075,1957,330,2675)
GROUP BY order_id, category

-- We should keep this expensive Italian dishes on the menu because people ordered them a lot