SELECT * FROM pizza_project.orders;
use pizza_project ;

select * from order_details;  

select * from pizzas; 

select * from orders;  

select * from pizza_types;

-- Retrieve the total number of orders placed.
select count(distinct order_id) as 'Total Orders' from orders;

-- Calculate the total revenue generated from pizza sales.

-- to see the details
select order_details.pizza_id, order_details.quantity, pizzas.price
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id ;

-- to get the answer
select cast(sum(order_details.quantity * pizzas.price) as decimal(10,2)) as 'Total Revenue'
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id ;


-- Identify the highest-priced pizza.
-- using TOP/Limit functions
SELECT pizza_types.name AS `Pizza Name`, 
       CAST(pizzas.price AS DECIMAL(10,2)) AS `Price`
FROM pizzas 
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY CAST(pizzas.price AS DECIMAL(10,2)) DESC
LIMIT 1;


-- Alternative (using window function) - without using TOP function






-- Identify the most common pizza size ordered.

select pizzas.size, count(distinct order_id) as 'No of Orders', sum(quantity) as 'Total Quantity Ordered' 
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizzas.size
order by count(distinct order_id) desc ; 



-- List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name AS 'Pizza', 
       SUM(quantity) AS 'Total Ordered'
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name 
ORDER BY SUM(quantity) DESC
LIMIT 5;
------------------
-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT
    pizza_types.category,
    SUM(order_details.quantity) AS `Total Quantity Ordered`
FROM
    order_details
JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY
    pizza_types.category
ORDER BY
    `Total Quantity Ordered` DESC
LIMIT 5;



-- Determine the distribution of orders by hour of the day.

SELECT
    HOUR(time) AS `Hour of the Day`
FROM
    orders
GROUP BY
    HOUR(time);





-- find the category-wise distribution of pizzas

SELECT
    category,
    COUNT(DISTINCT pizza_type_id) AS `No of Pizzas`
FROM
    pizza_types
GROUP BY
    category
ORDER BY
    COUNT(DISTINCT pizza_type_id) DESC;



-- Calculate the average number of pizzas ordered per day.


-- alternate using subquery
SELECT
    AVG(`Total Pizza Ordered that day`) AS `Avg Number of Pizzas Ordered per Day`
FROM
    (
        SELECT
            orders.date AS `Date`,
            SUM(order_details.quantity) AS `Total Pizza Ordered that day`
        FROM
            order_details
        JOIN
            orders ON order_details.order_id = orders.order_id
        GROUP BY
            orders.date
    ) AS pizzas_ordered;



-- Determine the top 3 most ordered pizza types based on revenue.

SELECT
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS `Revenue from pizza`
FROM
    order_details
JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY
    pizza_types.name
ORDER BY
    `Revenue from pizza` DESC
LIMIT 3;




