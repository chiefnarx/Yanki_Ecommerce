-- Windows Functions
-- Calculate the total sales amount for each order along with the individual product sales.

SELECT
	o.order_id,
	p.product_id, 
	price,
	o.quantity,
	o.total_price,
	SUM(p.price * o.quantity) OVER (PARTITION BY o.order_id) AS total_sales_amount

FROM yanki.orders o
JOIN yanki.products p ON o.product_id = p.product_id;

-- Calculate the running total price for each order.

SELECT
	order_id,
	product_id, 
	quantity, 
	total_price,
	SUM(total_price) OVER (ORDER BY order_id) AS running_total_price

FROM yanki.orders;


-- Rank products by their price within each category
SELECT
	product_id,
	product_name, 
	brand,
	category,
	price,
	RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS price_rank_by_Category
FROM yanki.products


-- Rank Functions
-- Rank customers by the total amount they have spent.
SELECT 
	customer_id,
	customer_name, 
	SUM(total_price) AS total_spent,
	RANK() OVER (ORDER BY SUM(total_pruce) DESC) AS customer_rank
FROM yanki.customers c
JOIN yanki.orders o ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id, 
	c.customer_name;


-- Rank products by their total sales amount
SELECT
	product_id,
	product_name,
	SUM(Quantity) AS total_quantity_sold,
	SUM(total_price) AS total_sales_amount,
	RANK() OVER (ORDER BY SUM(total_price) DESC) AS product_rank
FROM
	yanki.products p
JOIN
	yanki.orders ON p.product_id = o.product_id
GROUP BY
	p.product_id,
	p.product_name;


-- Rank orders by their total price.
SELECT
	order_id,
	total_price,
	RANK() OVER (ORDER BY total_price DESC) AS order_rank
FROM
	yanki.orders;

	
-- Case Functioms
-- Categorize the orders based on the total price

SELECT
	order_id,
	total_price
	CASE 
		WHEN total_price >= 1000 THEN 'HIGH'
		WHEN total_price <= 500 AND total_price = 1000 THEN 'MEDIUM'
		ELSE 'LOW'
	END AS price_category
FROM yanki.orders;


-- Classify customers by the number of orders they made

SELECT
	customer_id,
	customer_name,
	COUNT(order_id) AS num_orders,
	CASE
		WHEN COUNT(order_id) >= 10 THEN 'FREQUENT'
		WHEN COUNT(order_id) >= 5 AND COUNT(order_id) < 10 THEN 'REGULAR'
		ELSE 'OCCASIONAL'
	END AS order_frequency
FROM yanki.customers;
JOIN yanki.orders ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id,
	c.customer_name;


-- Classify products by their prices.

SELECT 
	product_id,
	product_name,
	price,
	CASE
		WHEN price >= 500 THEN 'EXPENSIVE'
		WHEN price >= 100 AND price < 500 THEN 'MODERATE'
		ELSE 'AFFORDABLE'
	END AS price_category
FROM yanki.products;


-- Inner Join
-- Retrieve customer details along with the products they ordered.
SELECT 
	c.customer_id,
	c.customer_name,
	c.email,
	c.phone_number,
	o.order_id,
	p.product_id,
	p.product_name,
	p.brand,
	p.price,
	o.quantity,
	o.total_price
FROM
	yanki.customers
INNER JOIN
	yanki.orders o ON c.customer_id = o.customer_id
INNER JOIN
	yanki.products p ON o.product_id = p.product_id

-- Retrieve order details along with payment information
SELECT
	order_id,
	payment_method,
	transaction_status
FROM
	yanki.orders o
INNER JOIN
	yanki.payment_method pm ON o.order_id = pm.order_id;


-- Left Join
-- Retrieve all customers along with their orders, even if they haven't placed any orders.
SELECT
	customer_id,
	customer_name,
	email,
	phone_number,
	order_id,
	product_id,
	quantity,
	total_price
FROM 
	yanki.customers c
LEFT JOIN
	yanki.orders o ON c.customer_id = o.customer_id


-- Retrieve all orders along with product details, even if there are corresponding products.
SELECT
	order_id,
	customer_id,
	p.product_id,
	p.product_name,
	p.price,
	o.quantity,
	o.total_price
FROM
	yanki.orders o
LEFT JOIN 
	yanki.products p ON o.product_id = p.product_id;


-- Right Join
-- Retrieve all orders along with payment information, even if there are noc orresponding payment records.
SELECT
	o.order_id,
	pm.payment_method,
	pm.transaction_status
FROM
	yanki.orders o
RIGHT JOIN
	yanki.payment_method pm ON o.order_id = pm.order_id;


-- Retrieve all products along with the orders, even if there are no corresponding orders
SELECT
	product_id,
	product_name,
	order_id,
	quantity,
	total_price
FROM
	yanki.products p
RIGHT JOIN
	yanki.orders o ON p.product_id = o.product_id;


-- Outer Join
-- Retrieve all customers along with their orders, including customers who have not placed any orders, and orders
SELECT
	customer_id,
	customer_name,
	email,
	phone_number,
	order_id,
	product_id,
	quantity,
	total_price
FROM
	yanki.customers c
FULL OUTER JOIN
	yanki.orders o ON c.customer_id = o.customer_id;


-- Retrieve all orders along with payment information, including orders without corresponding payment records
SELECT
	order_id,
	payment_method,
	transaction_status,
FROM
	yanki.orders o
FULL OUTER JOIN
	yanki.payment_method pm ON o.order_id = pm.order_id
