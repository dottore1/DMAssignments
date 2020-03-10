-- creating a database
create database AcmeShop;

-- and dropping it again
create database testdb;
drop database testdb;

-- !!!! Make a new connection to the new database
-- Postgres does not have an equivalent of "use database" as other databases have

-- creating and altering tables
CREATE TABLE my_table(
   id serial PRIMARY KEY,
   my_attribute VARCHAR (50) UNIQUE NOT NULL
);

select * from my_table;

ALTER TABLE my_table ADD COLUMN my_new_coulmn TIMESTAMP;

select * from my_table;

ALTER TABLE my_table ALTER COLUMN my_new_coulmn TYPE varchar(50);

select * from my_table;

ALTER TABLE my_table DROP COLUMN my_new_coulmn;

select * from my_table;

DROP TABLE my_table;

select * from my_table; -- will give an error!

-- creating the initial tables
CREATE TABLE customers(
   id serial PRIMARY KEY,
   username VARCHAR (50) UNIQUE NOT NULL,
   password VARCHAR (50) NOT NULL,
   email VARCHAR (355) UNIQUE NOT NULL,
   created_on TIMESTAMP NOT NULL,
   last_login TIMESTAMP
);

select * from products;

CREATE TABLE products(
   id serial PRIMARY KEY,
   name VARCHAR (150) NOT NULL,
   price float (2) NOT NULL
);

select * from products;

CREATE TABLE orders(
   id serial PRIMARY KEY,
   order_number CHAR (10) UNIQUE NOT NULL,
   customer_id integer NOT NULL REFERENCES customers (id)
);

select * from orders;

CREATE TABLE order_lines(
    id serial PRIMARY KEY,
    order_id integer NOT NULL REFERENCES orders (id),
    product_id integer NOT NULL REFERENCES products (id),
    amount integer not null
);

select * from order_lines;

-- inserting two users
INSERT INTO customers (username, password, email, created_on) VALUES ('John', 'myPassW0rd', 'john@acme.com', NOW()); -- becomes user 1
INSERT INTO customers (username, password, email, created_on) VALUES ('Anne', 'SomePassword', 'anne@acme.com', NOW()); -- becomes user 2

select * from customers;

-- inserting products
INSERT INTO products (name, price) VALUES ('Samsung Galaxy S20', 7799.95); -- becomes product 1
INSERT INTO products (name, price) VALUES ('Samsung Galaxy S20 - Leather Cover', 799.95); -- becomes product 2
INSERT INTO products (name, price) VALUES ('iPhone 11 Pro', 8899.00); -- becomes product 3
INSERT INTO products (name, price) VALUES ('iPhone 11 Pro - Leather Cover', 399.50); -- becomes product 4
INSERT INTO products (name, price) VALUES ('Huawai P30 Lite', 1664.50); -- becomes product 5
INSERT INTO products (name, price) VALUES ('Huawai P30 - Leather Cover', 1664.50); -- becomes product 6 - and is never used

select * from products;

-- inserting orders and order_lines
INSERT INTO orders (order_number, customer_id) VALUES ('DA-0001234', 1); -- becomes order 1
INSERT INTO order_lines (order_id, product_id, amount) VALUES (1, 1, 2); -- 2 Samsung phones
INSERT INTO order_lines (order_id, product_id, amount) VALUES (1, 2, 2); -- 2 matching leather covers
INSERT INTO order_lines (order_id, product_id, amount) VALUES (1, 5, 1); -- 1 Huawai Phone

INSERT INTO orders (order_number, customer_id) VALUES ('DA-0001235', 1); -- becomes order 2 - with no products

INSERT INTO orders (order_number, customer_id) VALUES ('DE-0001236', 2); -- becomes order 3
INSERT INTO order_lines (order_id, product_id, amount) VALUES (3, 3, 2); -- 2 iPhones
INSERT INTO order_lines (order_id, product_id, amount) VALUES (3, 4, 1); -- 1 matching leather cover

INSERT INTO orders (order_number, customer_id) VALUES ('DE-0001237', 2); -- becomes order 4
INSERT INTO order_lines (order_id, product_id, amount) VALUES (4, 1, 1); -- 1 Samsung Phone

select * from orders;
select * from order_lines;

-- Showing a foreign key constraint in action
INSERT INTO order_lines (order_id, product_id, amount) VALUES (999, 1, 1); -- gives an error as order_id (999) does not exist in orders.id

-- show current state with selects

-- show join types
-- Cross join
select customers.username, products.name from customers CROSS JOIN products;

select customers.username, products.name from customers CROSS JOIN products ORDER BY products.name;

-- Inner join
SELECT * FROM orders, order_lines, products, customers
WHERE orders.id = order_lines.order_id
  AND orders.customer_id = customers.id
  AND order_lines.product_id = products.id; -- traditional - the empty order is not in the list

SELECT * FROM orders INNER JOIN order_lines ON orders.id = order_lines.id; -- works the same, different syntax
SELECT * FROM orders INNER JOIN order_lines USING (id); -- requires ID's to be called the same, so does not work in this context
SELECT * FROM orders NATURAL INNER JOIN order_lines; -- again, requires ID's to be called the same.

-- Left outer join
SELECT * FROM orders
    LEFT JOIN order_lines ON orders.id = order_lines.order_id
    LEFT JOIN customers ON orders.customer_id = customers.id
    LEFT JOIN products ON order_lines.product_id = products.id;

SELECT customers.username, orders.order_number, products.name, order_lines.amount FROM orders
    LEFT JOIN order_lines ON orders.id = order_lines.order_id
    LEFT JOIN customers ON orders.customer_id = customers.id
    LEFT JOIN products ON order_lines.product_id = products.id;

-- Right outer join
SELECT customers.username,orders.order_number, products.name, order_lines.amount FROM orders
    RIGHT JOIN order_lines ON orders.id = order_lines.order_id
    RIGHT JOIN customers ON orders.customer_id = customers.id
    RIGHT JOIN products ON order_lines.product_id = products.id;

-- Full outer join
SELECT customers.username, orders.order_number, products.name, order_lines.amount FROM orders
    FULL JOIN order_lines ON orders.id = order_lines.order_id
    FULL JOIN customers ON orders.customer_id = customers.id
    FULL JOIN products ON order_lines.product_id = products.id;

-- Nested Queries
SELECT customers.id as id,
       customers.username as username,
       orders.order_number as orderNr,
       order_lines.amount as count,
       products.name as productName
FROM orders, order_lines, products, customers
WHERE orders.id = order_lines.order_id
  AND orders.customer_id = customers.id
  AND order_lines.product_id = products.id;


select * from (
    SELECT customers.id as id,
           customers.username as username,
           orders.order_number as orderNr,
           order_lines.amount as count,
           products.name as productName
    FROM orders, order_lines, products, customers
    WHERE orders.id = order_lines.order_id
      AND orders.customer_id = customers.id
      AND order_lines.product_id = products.id
    ) AS myResultSet WHERE id = 1;

-- Views
CREATE VIEW MyEasyOverview AS
SELECT customers.id as id,
       customers.username as username,
       orders.order_number as orderNr,
       order_lines.amount as count,
       products.name as productName
FROM orders, order_lines, products, customers
WHERE orders.id = order_lines.order_id
  AND orders.customer_id = customers.id
  AND order_lines.product_id = products.id;

SELECT * FROM MyEasyOverview WHERE id = 2;


-- The SUPER simple join example:

create table t1(
	num integer not null,
	name varchar(10) not null
);

create table t2(
	num integer not null,
	value varchar(10) not null
);

INSERT INTO t1 (num,name) VALUES (1,'a');
INSERT INTO t1 (num,name) VALUES (2,'b');
INSERT INTO t1 (num,name) VALUES (3,'c');

INSERT INTO t2 (num,value) VALUES (1,'xxx');
INSERT INTO t2 (num,value) VALUES (3,'yyy');
INSERT INTO t2 (num,value) VALUES (5,'zzz');

select * from t1;

select * from t2;

SELECT * FROM t1 CROSS JOIN t2;

SELECT * FROM t1 INNER JOIN t2 ON t1.num = t2.num;

SELECT * FROM t1 INNER JOIN t2 USING (num);

SELECT * FROM t1 NATURAL INNER JOIN t2;

SELECT * FROM t1 LEFT JOIN t2 ON t1.num = t2.num;

SELECT * FROM t1 LEFT JOIN t2 USING (num);

SELECT * FROM t1 RIGHT JOIN t2 ON t1.num = t2.num;

SELECT * FROM t1 FULL JOIN t2 ON t1.num = t2.num;