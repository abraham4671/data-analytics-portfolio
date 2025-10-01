create database superstore;
use superstore;
create table customers (customer_id varchar(50) primary key, customer_name varchar (255), segment varchar(100));
create table products (product_id varchar(50) primary key, product_name varchar(255), category varchar(100), sub_category varchar(100));
create table location (city varchar(100), state varchar(100), postal_code varchar(20), region varchar(50), primary key (city,state, postal_code));
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(100),
    customer_id VARCHAR(50),
    segment VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT,
    sales DECIMAL(12,2),
    discount DECIMAL(6,2),
    profit DECIMAL(12,2),
    unit_price DECIMAL(12,2)
);
-- Count rows
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM location;

-- Preview first 10 rows
SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;

# Join orders with customers to get customer details per order
SELECT 
    o.order_id, o.order_date, c.customer_name, c.segment
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LIMIT 10;

# Join orders with order_items and products to get order line details
SELECT 
    o.order_id, p.product_name, oi.quantity, oi.sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LIMIT 10;

-- Total sales per customer
SELECT c.customer_name, SUM(oi.sales) AS total_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Orders per region
SELECT l.region, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN location l ON c.city = l.city AND c.state = l.state
GROUP BY l.region;

-- Orders with sales > 500
SELECT o.order_id, o.order_date, oi.sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.sales > 500;

-- Customers in 'Corporate' segment
SELECT * FROM customers
WHERE segment = 'Corporate';

# Create a summarized table for Python use
CREATE TABLE customer_sales_summary AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.segment,
    SUM(oi.sales) AS total_sales,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.segment;
SELECT o.order_id, o.order_date, o.ship_date, o.ship_mode,
       c.customer_name, l.city, l.state, l.region
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN location l ON c.postal_code = l.postal_code;
SELECT o.order_id, o.order_date, o.ship_date, o.ship_mode,
       c.customer_name, l.city, l.state, l.region
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN location l ON c.postal_code = l.postal_code;
SELECT o.order_id, o.order_date, o.ship_date, o.ship_mode,
       c.customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM location;
SELECT DISTINCT c.postal_code
FROM customers c
LEFT JOIN location l ON c.postal_code = l.postal_code
WHERE l.postal_code IS NULL;
SELECT o.order_id, o.order_date, o.ship_date, o.ship_mode,
       c.customer_name, l.city, l.state, l.region
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN location l ON c.postal_code = l.postal_code;
SELECT o.order_id, o.order_date, o.ship_date, o.ship_mode,
       c.customer_name, l.city, l.state, l.region
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN location l ON c.postal_code = l.postal_code;
SELECT 
  o.order_id, 
  o.order_date, 
  c.customer_name, 
  COALESCE(l.city, 'Unknown') AS city,
  COALESCE(l.state, 'Unknown') AS state,
  COALESCE(l.region, 'Unknown') AS region
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN location l 
  ON TRIM(UPPER(c.postal_code)) = TRIM(UPPER(l.postal_code));
SELECT 
  COALESCE(city, 'Unknown') AS city,
  COALESCE(state, 'Unknown') AS state,
  COALESCE(region, 'Unknown') AS region
FROM location;
SELECT c.customer_id, c.postal_code FROM customers c LEFT JOIN location l ON c.postal_code = l.postal_code WHERE l.postal_code IS NULL;
