# Task 1-- Count of employees

use hr;
select *from employees;
select count(employee_id) from employees;

# Task 2 -- Count of employees department 
select *from employees;
select *from departments;
select department_id, count(employee_id) as 'Department Id Count' from employees group by department_id;


# Tasks 3 -- salary with <6000.
select * from employees;
select first_name, last_name , salary from employees where salary > 6000;


# Task 4 -- employee with greater than 20000
use hr;
select * from employees;
# select count(employee_id) from employees group by employee_id having salary > 20000 ;
select count(employee_id) as count_employees from employees where salary > 20000 ;

# Task 5 -- employees getting commission 

select *from employees;
select *from departments;

select * from employees where commission_pct    >0 ;

# Task 6 -- Name with full name 

select concat(first_name,'  ', last_name) as 'Full Name' from employees where commission_pct    > 0 ;

# Task 7 -- empployee details given order
select *from employees;
select *from departments;

select employee_id as 'Employee ID',concat(first_name,'  ', last_name) as 'Full Name',email as 'Email ID', phone_number as 'Phone number' from employees;

# Task 8 -- top three hightwst salary pay

select department_id, sum(salary) from employees group by department_id  ORDER BY SUM(salary) desc limit 3;

# task 9 -- list of employess  that have in iT Dep
 
select * from employees where department_id = '60';

# Task 10 -- count of it department and avg salary

select department_id,count(department_id), avg(salary) from employees group by department_id having department_id = '60' ;

# Task 11 -- Employees range between in 7000 to 10000

select *from employees;
select *from departments;

SELECT department_id, COUNT(department_id) as 'no od=f employees'FROM employees 
WHERE salary between 7000 and 10000 GROUP BY department_id;







