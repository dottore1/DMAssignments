create table products(
	product_id serial PRIMARY KEY,
	name VARCHAR(150) UNIQUE not NULL,
	price real not NULL
);

select * from orders;

create table orders(
	order_id serial PRIMARY KEY,
	order_number VARCHAR(10) UNIQUE, 
	customer_id INTEGER NOT NULL REFERENCES customer(customer_id)
);

create table order_lines(
	order_lines_id serial PRIMARY KEY, 
	order_id INTEGER NOT NULL REFERENCES orders(order_id), 
	product_id INTEGER not NULL REFERENCES products(product_id),
	amount INTEGER not NULL 
);

alter table orders drop column customer_id;

alter table orders add column customer_id INTEGER NOT NULL REFERENCES customer(customer_id);


alter table orders drop constraint customer_id;


select * from order_lines;


INSERT INTO products(name, price)
VALUES('Samsung Galaxy S20', 7799.95);
INSERT INTO products(name, price)
VALUES('Samsung Galaxy S20 - Leather Cover', 799.95);
INSERT INTO products(name, price)
VALUES('Iphone 11 PRO', 8899);
INSERT INTO products(name, price)
VALUES('Iphone 11 PRO - Leather Cover', 399.5);
INSERT INTO products(name, price)
VALUES('Huawai P30 LITE', 1664.5);
INSERT INTO products(name, price)
VALUES('Huawai P30 LITE - Leather Cover', 1664.5);



INSERT INTO customer(username, password, email, created_on)
VALUES('John','MyPassW0rd', 'john@acme.com', NOW());
INSERT INTO customer(username, password, email, created_on)
VALUES('Anne','SomePassword', 'anne@acme.com', NOW());



INSERT INTO orders(order_number, customer_id)
VALUES('DA-0001234',1);

INSERT INTO orders(order_number, customer_id)
VALUES('DA-0001235',1);

INSERT INTO orders(order_number, customer_id)
VALUES('DA-0001236',2);

INSERT INTO orders(order_number, customer_id)
VALUES('DA-0001237',2);

INSERT INTO order_lines(order_id, product_id, amount)
VALUES(1,1,2);

INSERT INTO order_lines(order_id, product_id, amount)
VALUES(1,2,2);

INSERT INTO order_lines(order_id, product_id, amount)
VALUES(1,5,1);

INSERT INTO order_lines(order_id, product_id, amount)
VALUES(3,3,2);

INSERT INTO order_lines(order_id, product_id, amount)
VALUES(3,4,1);

INSERT INTO order_lines(order_id, product_id, amount)
VALUES(4,1,1);


ALTER TABLE products ADD COLUMN manufacturer VARCHAR(250);

SELECT name, price, order_number, email FROM products, customer, orders;

SELECT * FROM customer FULL JOIN orders on customer.customer_id = orders.customer_id;

CREATE VIEW newview AS
SELECT email, order_number, name, amount FROM customer
	INNER JOIN orders on customer.customer_id = orders.order_id
	INNER JOIN order_lines on orders.order_id = order_lines.order_lines_id
	INNER JOIN products on order_lines.product_id = products.product_id;

select * from newview;

select * from newview where order_number = 'DA-0001234';

drop view my_view;

