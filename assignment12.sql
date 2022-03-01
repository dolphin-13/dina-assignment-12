-- creating database
create database pizza_restaurant;

-- creating tables
use pizza_restaurant;
CREATE TABLE `customer` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  `phone_number` VARCHAR(20) NULL,
  PRIMARY KEY (`customer_id`));
  
CREATE TABLE `order` (
  `order_id` INT NOT NULL,
  `order_date` DATETIME NULL,
  `customer_id` INT NULL,
  PRIMARY KEY (`order_id`));
  
alter table `order`
add foreign key (customer_id) references customer (customer_id); 

CREATE TABLE pizza (
  pizza_id INT NOT NULL,
  pizza_type VARCHAR(50) NULL,
  pizza_price DECIMAL(3,2) NULL,
  PRIMARY KEY (pizza_id));
  
CREATE TABLE `order_pizza` (
`order_id` INT NOT NULL,
`pizza_id` INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES `order` (order_id),
FOREIGN KEY (pizza_id) REFERENCES `pizza` (pizza_id));

-- inserting data into the tables
insert into customer (customer_id, first_name, last_name, phone_number)
values (1, 'Trevor', 'Page', '226-555-4982');

insert into customer (customer_id, first_name, last_name, phone_number)
values (2, 'John', 'Doe', '555-555-9498');

update customer
set phone_number = '226-555-4982'
where customer_id = 1;

update customer
set phone_number = '555-555-9498'
where customer_id = 2;

select * from customer;

insert into `order`(order_id, order_date, customer_id)
values (1, '2014-09-10 09:47:00', 1);

insert into `order`(order_id, order_date, customer_id)
values (2, '2014-09-10 13:20:00', 2);

insert into `order`(order_id, order_date, customer_id)
values (3, '2014-09-10 09:47:00', 1);

select * from `order`;

insert into pizza(pizza_id, pizza_type, pizza_price)
values (1, 'Pepperoni & Cheese', 7.99);

insert into pizza(pizza_id, pizza_type, pizza_price)
values (2, 'Vegetarian', 9.99);

insert into pizza(pizza_id, pizza_type, pizza_price)
values (3, 'Meat Lovers', 14.99);

alter table pizza
change column pizza_price pizza_price decimal(4, 2);

insert into pizza(pizza_id, pizza_type, pizza_price)
values (3, 'Meat Lovers', 14.99);

insert into pizza(pizza_id, pizza_type, pizza_price)
values (4, 'Hawaiian', 12.99);

select * from pizza;

insert into order_pizza (order_id, pizza_id)
values (1, 1);

insert into order_pizza (order_id, pizza_id)
values (1, 3);

insert into order_pizza (order_id, pizza_id)
values (2, 2);

insert into order_pizza (order_id, pizza_id)
values (2, 3);

insert into order_pizza (order_id, pizza_id)
values (2, 3);

insert into order_pizza (order_id, pizza_id)
values (3, 3);

insert into order_pizza (order_id, pizza_id)
values (3, 4);

select * from order_pizza;

-- Creating table with all data
select OP.order_id, O.customer_id, P.pizza_type, P.pizza_price, C.first_name, C.last_name
from order_pizza as OP
left join `order` as O
on OP.order_id = O.order_id
left join pizza as P
on OP.pizza_id = P.pizza_id 
left join customer as C
on O.customer_id = C.customer_id
order by O.customer_id;

-- How much money each individual customer has spent at their restaurant
select C.customer_id, C.first_name, C.last_name, sum(pizza_price) as sum from order_pizza as OP
join pizza as P on P.pizza_id = OP.pizza_id
join `order` as O on O.order_id = OP.order_id
join customer as C on C.customer_id = O.customer_id
group by C.customer_id;

update `order`
set order_date = '2014-09-11 11:47:00'
where order_id = 3;

select * from `order`;

-- How much each customer is ordering on which date
select C.customer_id, C.first_name, C.last_name, DATE(O.order_date) as `date`, sum(pizza_price) as sum from order_pizza as OP
join pizza as P on P.pizza_id = OP.pizza_id
join `order` as O on O.order_id = OP.order_id
join customer as C on C.customer_id = O.customer_id
group by DATE(O.order_date), C.customer_id
having C.customer_id;

select DATE(order_date) from `order`;

