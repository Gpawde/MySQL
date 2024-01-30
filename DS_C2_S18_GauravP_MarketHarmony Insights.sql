use modelcarsdb;

-- Part 1
  
-- Task 1 Customer Data Analysis
select * from customers;
select * from products;
  
-- 1  Find the total number of customers.
-- total number of customer are 122.
select count(customerNumber) as 'Customer Count' from customers;
  
-- 2.  Find the top 10 customers by credit limit.
--  max credit limit is 227600.
select * from customers;
select * from payments;
select concat(contactFirstName,' ',contactLastName) as 'Full Name',
creditLimit as 'top 10 Credit Limit' from customers order by creditLimit desc limit 10;

-- 3. Find the average credit limit for customers in each country.
-- Denmark have highest credit limit ,where as poland,portugual,russia have zero credit limit.

select country,avg(creditLimit) as Average_Credit_Limit from
customers group by country  order by Average_Credit_Limit desc;

-- 4. Find the number of customers in each state.
-- The state with the most customers is Null, with 73 customers.The states with the 
-- fewest customers are Victoria, BC, and NSW, with only 2 customers each.
select * from customers;
select * from payments;
select state,count(customerNumber) as Cunstomer_Count
 from customers group by state order by Cunstomer_Count desc;

-- 5. Retrieve customer information with contact details.

select SQL_CALC_FOUND_ROWS concat(contactFirstName,' ',contactLastName) as 'Full Name',
phone,addressline1,city,state,postalCode,country from customers; 

SELECT FOUND_ROWS() AS number_of_rows;

-- 6. Find customers who haven't placed any orders.
-- There are 24 customer that haven't placed order.
select * from customers;
select * from orders;
select SQL_CALC_FOUND_ROWS c.customerNumber, CONCAT(c.contactFirstName, ' ', c.contactLastName) as 'Full Name'
from customers as c left join orders as o on c.customerNumber = o.customerNumber
where o.customerNumber is null;

-- 7. Calculate total sales for each customer
-- Diego Freyre leads the sales team with ₹715,738.98, followed by Susan at ₹584,188.24 and Nelson (total sales hidden). 
-- The remaining salespeople have sales between ₹126,983.19 and ₹156,251.03, with Paul Henriot at the bottom at ₹126,983.19.
select * from customers;
select * from payments;
select CONCAT(c.contactFirstName, ' ', c.contactLastName) as Full_Name,sum(p.amount) as total_sales_amount
from customers as c left join payments as p on c.customerNumber = p.customerNumber 
group by Full_Name, c.customerNumber order by total_sales_amount desc;

-- 8.  List customers with their assigned sales representatives.
select * from customers;
select * from employees;

select concat(c.contactFirstName, ' ', c.contactLastName) as Customer_Name,
concat(e.firstName,' ', e.lastName) as Sales_Repsentative from customers as c
JOIN employees as e on c.salesRepEmployeeNumber = e.employeeNumber;

-- 9. Retrieve customer information with their most recent payment details.
-- most recent payment done by 'Carinr Schmitt'

select * from customers;
select * from payments;
select * from orders;
select concat(c.contactFirstName, ' ', c.contactLastName)as Customer_Name,c.phone,c.addressline1,c.city,c.state,
max(p.paymentDate) as latest_Payment_Date
from payments as p join customers as c on p.customerNumber = c.customerNumber 
group by c.customerNumber, c.contactFirstName, c.contactLastName, c.phone, c.addressline1, c.city, c.state;

-- 10. Identify customers who have exceeded their credit limit.
-- there are 46 customer who had exceeded their credit limit 

select * from customers;
select * from payments;
select SQL_CALC_FOUND_ROWS CONCAT(c.contactFirstName, ' ', c.contactLastName) as Full_Name, c.creditLimit,SUM(p.amount) AS Total_Payments
from customers as c left join payments as p on c.customerNumber = p.customerNumber group by c.customerNumber,c.creditLimit
having Total_Payments > creditLimit;
SELECT FOUND_ROWS() AS number_of_rows;

-- 11. Find the names of all customers who have placed an order for a product from a specific product line.

select * from customers;
select * from orderdetails;
select * from products;
select * from orders;

select concat(c.contactFirstName, ' ', c.contactLastName) AS Customer_Name,p.productLine
from customers AS c
join orders AS o ON c.customerNumber = o.customerNumber
join orderdetails AS od ON o.orderNumber = od.orderNumber
join products AS p ON od.productCode = p.productCode
where p.productLine = 'Motorcycles';

-- 12.  Find the names of all customers who have placed an order for the most expensive product.
-- There are 28 customer how have oder most expensive product,which are classic cars.
select * from customers;
select * from orderdetails;
select * from products;
select * from orders;
select * from orders;

select max(MSRP) from products;
select sql_calc_found_rows concat(c.contactFirstName,' ', c.contactLastName) AS Customer_Name,p.MSRP,p.productLine
from customers as c
join orders as o on c.customerNumber = o.customerNumber
join orderdetails as od on o.orderNumber = od.orderNumber
join products as p on od.productCode = p.productCode
where p.MSRP = (select max(MSRP) from products);
select found_rows() as NumberOfRows;

-- 13. Find the names of all customers who work for the same office as their sales representative
-- There are 100 customer who work for the same office as their sales representative.
select * from customers;
select * from employees;
select * from offices;

select sql_calc_found_rows concat(c.contactFirstName,' ', c.contactLastName) as Customer_Name, e.officeCode,c.salesRepEmployeeNumber
from customers as c
join employees as e
join offices as o
on c.salesRepEmployeeNumber = e.employeeNumber 
and e.officeCode = o.officeCode ;
select found_rows() as numberofrows;

-- Task 2 Office Data Analysis

-- 1. List all offices with their basic information.

select * from offices;

-- 2. Count the number of employees working in each office.
-- most of the employees are working in 1 and 4 offices 
select * from offices;
select * from employees;
select officeCode,count(employeeNumber) as Employees_count from employees 
group by officeCode order by Employees_count desc;

-- 3. Identify offices with less than a certain number of employees

select * from offices;
select * from employees;
select officeCode,count(employeeNumber) as Employees_count from employees group by officeCode 
having Employees_count > 2;

-- 4. List offices along with their assigned territories.
-- There are 4 territories EMEA,JAPAN,APAC,EMEA.
select * from offices;
select officeCode,city,territory from offices;
select officeCode,city,count(territory) from offices group by officeCode ;


-- 5. Find offices that have no employees assigned to them.
-- There is no offices where the employees are not assigned.
select * from offices;
select * from employees;
select o.officeCode,o.city,o.territory
from offices as o left join employees as e on o.officeCode = e.officeCode
where e.employeeNumber = null;

-- 6. Retrieve the most profitable office based on total sales.
-- Most profitable office is in Paris which belong the territory of EMEA with total Sale of 3083761.58 .
select * from offices;
select * from employees;
select * from orderdetails;
select * from orders;
select * from payments;

select o.officeCode,o.city,o.territory,sum(od.quantityOrdered * od.priceEach) AS TotalSales
from offices AS o
join employees AS e ON o.officeCode = e.officeCode
join customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
join orders AS ord ON c.customerNumber = ord.customerNumber
join orderdetails AS od ON ord.orderNumber = od.orderNumber
join products AS p ON od.productCode = p.productCode
group by o.officeCode, o.city, o.territory
order by TotalSales desc ;

-- 7. Find the total number of offices.
-- there are 7 total number of offices

select * from offices;
select count(*) AS TotalOffices from offices;

-- 8.  Find the office with the highest number of employees.
-- SAN Francisco  is the office with the highest number of employees
select * from offices;
select * from employees;

select e.officeCode,o.city,count(employeeNumber) as Employees_count from employees as e 
join offices as o on e.officeCode = o.officeCode
group by officeCode limit 1;

-- 9.  Find the average credit limit for customers in each office
--  the average credit limit is significantly higher in countries like the US, France, and Japan compared to Canada and Boston. Additionally, 
-- countries within the same region (EMEA and APAC) seem to have similar average credit limits.
select o.officeCode,o.city,o.territory,avg(c.creditLimit) as AverageCreditLimit
from offices as o
join employees as e on o.officeCode = e.officeCode
join customers as c on e.employeeNumber = c.salesRepEmployeeNumber
group by o.officeCode, o.city, o.territory;

-- 10.  Find the number of offices in each country.
--  Most of the offices are present in  USA.
select * from offices;
select * from employees;
select country,count(*) as NumberOfOffices from offices group by country;


-- Part 2

-- Task 1 : Employee Data Analysis

-- 1 . Find the total number of employees.
-- No.of.employees are 23.
select * from employees;
select count(employeeNumber)  as countofemployees from employees ;

-- 2 Find the number of employees in each office.
-- most of the employees are working in 1 and 4 offices

select * from offices;
select * from employees;
select officeCode,count(employeeNumber) as Employees_count from employees group by officeCode ;

-- 3 List all employees with their basic information.

select * from employees;

-- 4 Count the number of employees holding each job title. 
-- There are 23 employees in which 17 is sales represantitve, 1 presisdent, 2 vp , 3 sale manager.
select * from employees;
select jobTitle, count(employeeNumber) as countofemployee from employees group by jobTitle ;

-- 5 Find employees who don't have a manager (reportsTo is NULL)
-- President as an employees who don't have a manager.
select * from employees;
select * from employees where reportsTo is NULL;

-- 6 List employees along with their assigned offices.

select * from offices;
select * from employees;
select e.employeeNumber,e.firstName,e.lastName,o.officeCode,o.city,o.territory
from employees as e
join offices as o on e.officeCode = o.officeCode;

-- 7. Identify sales representatives with the highest number of customers.  
-- The sales representative with the highest number of customers is Pamella Castillo, with 10 customers.
select * from employees;
select * from customers;
select e.employeeNumber,concat(e.firstName,' ',e.lastName) as SalesRep_Name,e.jobTitle,count(c.customerNumber) as CustomerCount
from employees as e 
left join customers as c 
on e.employeeNumber = c.salesRepEmployeeNumber 
group by e.employeeNumber, SalesRep_Name, e.jobTitle
order by CustomerCount desc;

-- 8 Find the most profitable sales representative based on total sales.

select e.employeeNumber,concat(e.firstName, ' ', e.lastName) as SalesRep_Name,e.jobTitle,sum(od.quantityOrdered * od.priceEach) as TotalSales
from employees as e
join customers as c on e.employeeNumber = c.salesRepEmployeeNumber
join orders as ord on c.customerNumber = ord.customerNumber
join orderdetails as od on ord.orderNumber = od.orderNumber
join products as p on od.productCode = p.productCode
group by e.employeeNumber, SalesRep_Name, e.jobTitle
order by TotalSales desc limit 1;

-- 9. Find the names of all employees who have sold more than the average sales amount for their office.
-- The Highest is generated by Gerard hernandez.
select e.employeeNumber,concat(e.firstName, ' ', e.lastName) as SalesRep_Name,e.jobTitle, 
avg(od.quantityOrdered * od.priceEach) as AverageSalesAmount,
sum(od.quantityOrdered * od.priceEach) as TotalSales
from employees as e
join customers as c on e.employeeNumber = c.salesRepEmployeeNumber
join orders as ord on c.customerNumber = ord.customerNumber
join orderdetails as od on ord.orderNumber = od.orderNumber
join products as p on od.productCode = p.productCode
group by e.employeeNumber, SalesRep_Name, e.jobTitle
having TotalSales > AverageSalesAmount
order by TotalSales desc;

-- Task 2 : Product Data Analysis

-- 1. List all products with their basic information
select * from products;

-- 2. List all products with their product lines information.
-- There are 110 products with their product lines information.
select * from products;
select * from productlines;
select sql_calc_found_rows p.productCode,p.productName,p.productLine,pl.textDescription as ProductLineDescription
from products as p
join productlines as pl on p.productLine = pl.productLine;
select found_rows() as NumberofRows;

-- 3  Count the number of products in each product line. 
-- In product line Most of the product are Classic Cars and Vintage cars and we can that 50% market share belong to cars.
select * from products;
select * from productlines;
select pl.productLine, count(p.productLine) as Product_Count from products as p 
left join productlines as pl
on p.productLine = pl.productLine
group by pl.productLine ;

-- 4 Find the product line with the highest average product price
-- The highest average product price in the product line is belong to Classic cars.
select pl.productLine,avg(p.buyPrice) as AverageProductPrice
from productlines as pl
join products as p on pl.productLine = p.productLine
group by pl.productLine
order by AverageProductPrice desc;

-- 5. Find all products with a price above or below a certain amount (MSRP should be between 50 and 100)
-- There are 51 products that belong if MSRP should be between 50 and 100.
select * from products;
select * from productlines;
select sql_calc_found_rows productName,productLine,MSRP from products where MSRP  between 50 and 100 ;
select found_rows()as Numberofrows; 

-- 6. Find the total sales amount for each product line.
-- most of the sale genetrated by Classic cars than after Motorcycles and so on

select pl.productLine,sum(od.quantityOrdered * od.priceEach) as TotalSalesAmount
from productlines as pl
join products as p on pl.productLine = p.productLine
join orderdetails as od on p.productCode = od.productCode
join orders as o on od.orderNumber = o.orderNumber
group by pl.productLine;

-- 7 . Identify products with low inventory levels (less than a specific threshold value 10 of quantityInStock).
--  there is no products with low inventory levels with a a specific threshold value 10 of quantityInStock.
select productCode,productName,quantityInStock
from products where quantityInStock < 10;

-- 8. List products along with their descriptions.

select sql_calc_found_rows productName,productDescription from products;
select found_rows() as numberofrows;


-- 9 Retrieve the most expensive product based on MSRP.
-- the most expencive product based on MSRP is 1952 Alipne Reanult 1300, which is belong to Classic cars.
select * from products;
select productName,productLine,max(MSRP)as mostexpensiveproduct  from products 
group by productName,productLine order by mostexpensiveproduct desc limit 1;


-- 10. Calculate total sales for each product
-- the product  which genetrated most of sale is 1992 Ferrrari 360 Spider red.
select * from products;
select * from productlines;
select p.productCode,p.productline,p.productName,sum(od.quantityOrdered * od.priceEach) as TotalSales
from products AS p
join orderdetails as od on p.productCode = od.productCode
join orders as o on od.orderNumber = o.orderNumber
group by p.productCode, p.productName order by TotalSales desc;

-- 11. Identify the best-selling products based on total sales.
-- the best-selling products is 1992 Ferrrari 360 Spider red.
select * from products;
select * from productlines;
select p.productCode,p.productName,sum(od.quantityOrdered * od.priceEach) as TotalSales
from products as p
join orderdetails as od on p.productCode = od.productCode
join orders as o on od.orderNumber = o.orderNumber
group by p.productCode, p.productName
order by TotalSales desc;

-- 12. Identify the most profitable product line based on total sales.
-- The most profitable product line based on total sales is Classic Cars.
select * from products;
select * from productlines;
select p.productline,sum(od.quantityOrdered * od.priceEach) as TotalSales
from products as p
join orderdetails as od on p.productCode = od.productCode
join orders as o on od.orderNumber = o.orderNumber
group by p.productline
order by TotalSales desc limit 1;

-- 13. Find the best-selling product within each product line.
-- Classic :Cars	1962 Ford Mustang, Motorcycles:	2003 Harley-Davidson Eagle Drag Bike,Planes: 1980s Black Hawk Helicopter
-- Ships: 18th century schooner,Trains: Collectable Wooden Train,Trucks and Buses: 1958 Setra Bus,Vintage Cars: 1917 Grand Touring Sedan

select sum(quantityOrdered * priceEach) as  TotalSales from orderdetails;
select productCode,productName,productLine,TotalSales
from (select p.productCode,p.productName,pl.productLine,sum(od.quantityOrdered * od.priceEach) as TotalSales,
	ROW_NUMBER() OVER (PARTITION BY pl.productLine ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS SalesRank
    from products as p
    join orderdetails as od on p.productCode = od.productCode
    join productlines as pl ON p.productLine = pl.productLine
    join orders as o on od.orderNumber = o.orderNumber
    group by p.productCode, p.productName, pl.productLine
) RankedProducts
where SalesRank = 1;

-- 14. Retrieve products with low inventory levels (less than a threshold value 10 of quantityInStock)
-- within specific product lines ('Classic Cars', 'Motorcycles'). 
 -- there is no products with low inventory levels with threshold value 10 of quantityInStock.
select * from products;
select * from productlines;

select p.productCode,p.productName,p.quantityInStock,p.productLine
from products as p
join productlines as pl on p.productLine = pl.productLine
where p.quantityInStock < 10
and pl.productLine in ('Classic Cars', 'Motorcycles');

-- 15. Find the names of all products that have been ordered by more than 10 customers 

select p.productCode,p.productName
from products as p
join orderdetails as od on p.productCode = od.productCode
join orders AS o ON od.orderNumber = o.orderNumber
group by p.productCode, p.productName
having count(distinct o.customerNumber) > 10;

-- 16.  Find the names of all products that have been ordere more than the average number of orders for their product line
-- The products that have been ordere more than the average number of orders
-- for their product line is Classic Cars, MOtoorcycles and Vintage Cars.
select * from offices;
select * from products;
select * from orderdetails;
select * from orders;
select * from productlines;
-- select p.productCode,p.productNamefrom products as p
-- join orderdetails as od on p.productCode = od.productCode
-- join orders AS o ON od.orderNumber = o.orderNumber
-- group by p.productCode, p.productName
-- having  count(DISTINCT o.orderNumber) > AVG(COUNT(DISTINCT o.orderNumber)) OVER (PARTITION BY pl.productLine);//


SELECT productCode,productName,productLine from 
(select p.productCode,p.productName,pl.productLine,count(distinct o.orderNumber) AS OrderCount,
avg(count(distinct o.orderNumber)) OVER (PARTITION BY pl.productLine) AS AvgOrderCountPerLine
from products as p
join orderdetails AS od ON p.productCode = od.productCode
join orders AS o ON od.orderNumber = o.orderNumber
join productlines AS pl ON p.productLine = pl.productLine
group by p.productCode, p.productName, pl.productLine ) as ProductOrders
where OrderCount > AvgOrderCountPerLine;


-- Part 3
-- Task 1: Order Data Analysis

-- 1. List all orders with their basic information
 -- There are 326 orders .
select sql_calc_found_rows * from orders;
select found_rows() as numberofrows;

-- 2. Find all order details for a particular order (order number=12345).

select * from orders where orderNumber=10165;

-- 3. Find all order details for a particular product (Choose any product of your choice)

select * from orders;
select * from orderdetails;
select* from products;
select o.orderDate,o.requiredDate,o.shippedDate,o.status 
from orders as o 
join orderdetails as ord  on o.orderNumber = ord.orderNumber
join products as p on ord.productCode = p.productCode
where p.productName='P-51-D Mustang';

-- 4  Find the total quantity ordered for a particular product (Choose any product of your choice).

select * from orders;
select * from orderdetails;
select* from products;
select p.productCode,p.productName,sum(od.quantityOrdered) as TotalQuantityOrdered
from products as p
join orderdetails as od on p.productCode = od.productCode
group by p.productCode, p.productName
having p.productCode = 'S10_2016';


-- 5. Find all orders placed on a particular date (orderDate = '2023-09-28').

select * from orders;
select orderNumber,orderDate,customerNumber
from orders where orderDate = '2003-09-28';

-- 6. Find all orders placed by a particular customer (Choose any customer of your choice).

select * from orders;
select* from customers;

select * from orders as o 
join customers as c on o.customerNumber = c.customerNumber
where c.customerName = 'Atelier graphique';

-- 7  Find the total number of orders placed in a particular month (orderDate between '2023-09-01' AND '2023-09-30').

select count(*) as TotalOrders from orders
where orderDate between '2003-09-01' and '2003-09-30';

-- 8. Find the average order amount for each customer.
-- We can say that most of the sale generated by 'Collectable Mini Designs Co.'

select c.customerNumber,c.customerName,avg(p.amount) as AverageOrderAmount
from customers as c
join payments as p on c.customerNumber = p.customerNumber
group by c.customerNumber, c.customerName order by AverageOrderAmount desc;

-- 9. Find the number of orders placed in each month.
 -- Most of the sales generated in month of 10 and 11 in ever yr.
select * from orders;
select date_format(orderDate, '%Y-%m') as Months,count(*) as NumberOfOrders
from orders
group by Months
order by Months ;

-- 10. Identify orders that are still pending shipment (status = 'Pending’).
-- there is no pending orders.
-- there is 4 orders On Hold.
-- there is 6 orders are Cancelled.
-- there is 6 orders are In Process.
-- there is 303 orders are Shipped.

select * from orders;
select sql_calc_found_rows * from orders where status = 'Shipped';
select found_rows() as numberofrows;
select * from orders where status = 'In Process';


-- 11. List orders along with customer details
-- most of the orders are generated from USA country after than France and so on.
select * from orders;
select * from customers;
select * from orderdetails;

select o.orderNumber,o.orderDate,c.customerName,c.contactFirstName,
c.contactLastName,c.phone,c.addressLine1,c.city,c.state,c.postalCode,c.country
from orders as o
join customers as c on o.customerNumber = c.customerNumber;

select count(o.orderNumber) as no_of_orders,c.state
from orders as o
join customers as c on o.customerNumber = c.customerNumber group by c.state;

select count(o.orderNumber) as no_of_orders,c.country
from orders as o
join customers as c on o.customerNumber = c.customerNumber group by c.country order by no_of_orders desc;

-- 12 Retrieve the most recent orders (based on order date)

select orderNumber,orderDate,customerNumber
from orders
order by orderDate desc
limit 10; 


-- 13. Calculate total sales for each order

select o.orderNumber,sum(od.quantityOrdered * od.priceEach) as TotalSales
from orders as o
join orderdetails as od on o.orderNumber = od.orderNumber
group by o.orderNumber order by TotalSales desc;

-- 14. Find the highest-value order based on total sales
-- The highest-value order based on total sales is 10165.
select * from orders;
select * from customers;
select * from orderdetails;

SELECT o.orderNumber,sum(od.quantityOrdered * od.priceEach) as TotalSales
from orders as o
join orderdetails as od on o.orderNumber = od.orderNumber
group by o.orderNumber
order by TotalSales desc limit 1;

 -- 15. List all orders with their corresponding order details
 
 select * from orders;
select * from customers;
 
select o.orderNumber,o.orderDate,o.customerNumber,od.productCode,od.quantityOrdered,od.priceEach
from orders as o
join orderdetails as od on o.orderNumber = od.orderNumber;

-- 16.List the most frequently ordered products.
-- The most frequently ordered products is 1992 FErraro 360 Spider red.

select * from orders;
select * from customers;
select p.productCode,p.productName,count(od.orderNumber) as OrderCount
from products as p
join orderdetails as od on p.productCode = od.productCode
group by p.productCode, p.productName
order by OrderCount desc;

-- 17.Calculate total revenue for each order.
-- the highest revenue genertated by order number is 10165 and the lowest by 10408.
select * from orders;
select * from customers;
select o.orderNumber,sum(od.quantityOrdered * od.priceEach) as TotalRevenue
from orders as o
join orderdetails as od on o.orderNumber = od.orderNumber
group by o.orderNumber order by TotalRevenue desc;

-- 18 Identify the most profitable orders based on total revenue.
-- the most profitable orders based on total revenue is 10165.
select * from orders;
select * from customers;
select o.orderNumber,sum(od.quantityOrdered * od.priceEach) as TotalRevenue
from orders as o
join orderdetails as od on o.orderNumber = od.orderNumber
group by o.orderNumber
order by TotalRevenue desc; 

 -- 19. List all orders with detailed product information.

select * from orders;
select * from customers;
select o.orderNumber,o.orderDate,p.productCode,p.productName,od.quantityOrdered,od.priceEach
from orders as o
join orderdetails as od on o.orderNumber = od.orderNumber
join products as p on od.productCode = p.productCode;

-- 20. Identify orders with delayed shipping (shippedDate > requiredDate).
-- there is one Order which delayed by almost 2 months for shipping.
select * from orders;
select * from customers;

select orderNumber,orderDate,requiredDate,shippedDate
from orders where shippedDate > requiredDate;

-- 20. Find the most popular product combinations within orders.
--  This are the product which is frequently appear together in orders. which having 1862 count of orders.
select * from orders;
select * from customers;
select * from orderdetails;
select * from orderdetails;
select sql_calc_found_rows od1.productCode as Product1,od2.productCode as Product2,count(*) as OrderCount
from orderdetails as od1
join orderdetails as od2 on od1.orderNumber = od2.orderNumber
where od1.productCode < od2.productCode
group by Product1, Product2
order by OrderCount desc ;
select found_rows(); 

-- 21 Calculate revenue for each order and identify the top 10 most profitable.
-- "The top 10 most profitable orders generate revenue above 50000 and are generating more revenue."
select * from orders;
select * from customers;
select o.orderNumber,sum(od.quantityOrdered * od.priceEach) as TotalRevenue
from orders as o
join orderdetails as od on o.orderNumber = od.orderNumber
group by o.orderNumber
order by TotalRevenue desc
limit 10;

