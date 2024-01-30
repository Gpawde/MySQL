# Task 1
Create database stylexcarz_db;
use stylexcarz_db;
# Task 2
create table salesperson
(salespersonid int ,
salesperson_name varchar(100) ,
salesperson_city varchar(100),
commision_rate varchar(100)
);
create table customers
(customerid int,
c_firstname varchar(100),
c_lastname varchar(100),
c_city varchar(100),
c_rating varchar(100)
);
create table orders
(orderid int,
amount varchar(100),
orderdate varchar(100),
salespersonid varchar(100),
customerid varchar(100)
);


alter table salesperson modify salespersonid varchar(50) primary key ;
alter table customers modify customerid varchar(50) primary key ;
alter table orders modify orderid varchar(50) primary key ;
alter table salesperson modify salesperson_name varchar(50) not null;
alter table salesperson modify salesperson_city varchar(50) not null;
alter table salesperson modify commision_rate varchar(50) not null;
alter table customers modify c_firstname varchar(50) not null;
alter table customers modify c_lastname varchar(50) not null;
alter table customers modify c_city varchar(50) not null;
alter table customers modify c_rating varchar(50) not null;
alter table orders modify amount varchar(50) not null;
alter table orders modify orderdate varchar(50) not null;
alter table orders modify salespersonid varchar(50) not null;
alter table orders modify customerid varchar(50) not null;

desc salesperson;
insert into salesperson(salespersonid,salesperson_name,salesperson_city,commision_rate) values
(1001,'William','New York',12),
(1002,'Liam','New Jersey',13),
(1003,'Axelrod','San Jose',10),
(1004,'James','San Diego',11),
(1005,'Fran','Austin',26),
(1007,'Oliver','New York',15),
(1008,'John','Atlanta',2),
(1009,'Charles','New Jersey',2);
select* from salesperson;
insert into customers(customerid,c_firstname,c_lastname,c_city,c_rating) values
(2001,'Hoffman','Anny','New York',1),
(2002,'Giovanni','Jenny','New Jersey',2),
(2003,'Liu','Williams','San Jose',3),
(2004,'Grass','Harry','San Diego',3),
(2005,'Clemens','John','Austin',4),
(2006,'Cisneros','Fanny','New York',4),
(2007,'Pereira','Jonathan','Atlanta',3);
select* from customers;
insert into orders(orderid,amount,orderdate,salespersonid,customerid) values
('3001',23,2020-02-01,1009,2007);
insert into orders(orderid,amount,orderdate,salespersonid,customerid) values
('3003',89,2021-03-06,1002,2002);
select* from orders;
insert into orders(orderid,amount,orderdate,salespersonid,customerid) values
('3002',20,2021-02-23​,1007,2007);
INSERT INTO  orders( orderid, amount, orderdate, salespersonid, customerid) values ('3004','67',2021-04-02,1004,2002);
INSERT INTO orders ( orderid, amount, orderdate, salespersonid, customerid) values ('3005',30,2021-07-30,1001,2007);
INSERT INTO orders ( orderid, amount, orderdate, salespersonid, customerid) values 
('3006',35,2021-09-18,1001,2004),
('3007',19,2021-10-02,1001,2001),
('3008',21,2021-10-09,1003,2003),
('3009',45,2021-10-10,1009,2005);
INSERT INTO orders ( orderid, amount, orderdate, salespersonid, customerid) values('3002',20,2021-02-23,1007,2007);	

# commission increase by 15 % -- # Task 4

update salesperson set commision_rate =(select commision_rate + (select commision_rate*.15)) where salespersonid = '1001';
update salesperson set commision_rate =(select commision_rate + (select commision_rate*.15)) where salespersonid = '1002';
update salesperson set commision_rate =(select commision_rate + (select commision_rate*.15)) where salespersonid = '1003';
update salesperson set commision_rate =(select commision_rate + (select commision_rate*.15)) where salespersonid = '1004';
update salesperson set commision_rate =(select commision_rate + (select commision_rate*.15)) where salespersonid = '1008';
update salesperson set commision_rate =(select commision_rate + (select commision_rate*.15)) where salespersonid = '1009';

# Task 5 

create database stylexcarz_db_bkp;
use stylexcarz_db_bkp;
create table stylexcarz_db_bkp.salesperson_bkp like stylexcarz_db.salesperson;
insert stylexcarz_db_bkp.salesperson_bkp select * from stylexcarz_db.salesperson;
create table stylexcarz_db_bkp.customers_bkp like stylexcarz_db.customers;
insert stylexcarz_db_bkp.customers_bkp select * from stylexcarz_db.customers;
create table stylexcarz_db_bkp.orders_bkp like stylexcarz_db.orders;
insert stylexcarz_db_bkp.orders_bkp select * from stylexcarz_db.orders;
 
 # Task 6
 
 update customers set c_rating =(select c_rating + 3) where customerid = '2007';
 update customers set c_rating =(select c_rating + 3) where customerid = '2002';
select * from customers;
