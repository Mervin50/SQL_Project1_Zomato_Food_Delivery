# 1. Select a particular database?
use Zomato;

# 2. Count number of rows in orders table?
select count(*) as "Number of rows" from orders;

# 3. Return n random records from users table?
select * from users 
order by rand() limit 5;

# 4. Find null values or blank cells in orders table in ratings column?
SELECT * FROM orders
WHERE restaurant_rating IS NULL OR restaurant_rating = '';

# 5. Replace null values above with 0
update orders set restaurant_rating = 0
where restaurant_rating IS NULL OR restaurant_rating = '';

# Checking if the update get into effect or not
select * from orders;

# 6. Find orders placed by each customer?
SELECT t2.name,COUNT(*) AS '#orders' FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY t2.user_id;

# 7. Find restaurants with most number of menu items?
SELECT r_name,COUNT(*) AS 'menu_items' FROM restaurants t1
JOIN menu t2
ON t1.r_id = t2.r_id
GROUP BY t2.r_id
ORDER BY menu_items DESC;

# 8. Find number of votes and average ratings for all restaurants?
SELECT r_name,COUNT(*) AS 'num_votes',ROUND(AVG(restaurant_rating),2) AS "rating"
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE restaurant_rating IS NOT NULL
GROUP BY t1.r_id
order by rating desc;

# 9. Find restaurant with maximum number of revenue in given month?
SELECT r_name as "Restaurant Name",SUM(amount) AS 'revenue' FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTHNAME(DATE(date)) = 'July'
GROUP BY t1.r_id
ORDER BY revenue DESC LIMIT 1;

# 10. Find restuarants with sales greater than 1500?  
SELECT r_name as "Restaurant name",SUM(amount) AS 'revenue' FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
GROUP BY t1.r_id
HAVING revenue > 1500;

# 11. Find the customers who have never ordered?
SELECT u.user_id, u.name
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.user_id IS NULL;

# 12. Show order details of a particular customer in given data range?
SELECT t1.order_id,f_name,date FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
JOIN food t3
ON t2.f_id = t3.f_id
WHERE user_id = 5 AND date BETWEEN '2022-05-15' AND '2022-07-15';

# 13. Customers Favourite food?
SELECT u.name AS user_name, f.f_name AS food_name, COUNT(*) AS count
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN food f ON od.f_id = f.f_id
GROUP BY u.name, f.f_name
ORDER BY count DESC;

# 14. Find the most costly restaurants (Average price/dish)?
SELECT r_name,SUM(amount)/COUNT(*) AS 'Avg_price' FROM menu t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
GROUP BY t1.r_id
ORDER BY Avg_price ASC LIMIT 1;

# 15. Find the delivery partner compensation using the formula (#deliveries * 100 + 1000 * avg_rating)?
SELECT partner_name, (COUNT(*) * 100) + (AVG(delivery_rating) * 1000) AS 'salary'
FROM orders t1
JOIN delivery_partner t2 ON t1.partner_id = t2.partner_id
GROUP BY t1.partner_id
ORDER BY salary DESC;

# 16. Find the revenue per month for a restaurant?
SELECT 
    YEAR(date) AS year,
    MONTH(date) AS month,
    r_id AS restaurant_id,
    SUM(amount) AS revenue
FROM 
    orders
GROUP BY 
    YEAR(date),
    MONTH(date),
    r_id
ORDER BY 
    year,
    month,
    restaurant_id;















