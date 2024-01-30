use hr;

# Task 1

select * from regions;
select * from locations;
select* from employees;
select* from job_history;

select max(employees.department_id) as Total_employees, locations.city from employees join departments 
join locations on employees.department_id = departments.department_id and departments.location_id = locations.location_id
group by locations.city order by Total_employees desc limit 5 ;


# Task 2

select * from locations;
select* from employees;
select* from countries;

select employees.first_name,employees.last_name, max(employees.employee_id) as 'employees', locations.city,locations.state_province ,countries.country_name
from employees join departments join locations join countries on employees.department_id = departments.department_id 
and departments.location_id = locations.location_id 
and locations.country_id = countries.country_id
group by employees.first_name, employees.last_name, employees.department_id, locations.city, locations.state_province, countries.country_name
order by employees desc limit 5 ;

 

# Task 3

select locations.city, count(employees.employee_id) AS e_count from employees
join departments 
join locations 
on employees.department_id = departments.department_id and departments.location_id = locations.location_id 
group by locations.city order by e_count asc limit 10;


# Task 4
select * from locations;
select* from employees;
select* from job_history;

select e.employee_id, e.first_name,d.department_id ,avg(YEAR(curdate())- YEAR(hire_date)) as 'Avrage Expriance' from employees as e 
left join departments as d on  e.department_id = d.department_id GROUP BY e.employee_id, e.first_name, d.department_id;

# Task 5

select* from employees;

select employees.first_name,employees.last_name, max(employees.employee_id) as 'employees', employees.email,employees.phone_number
from employees join departments join locations join countries on employees.department_id = departments.department_id 
and departments.location_id = locations.location_id 
and locations.country_id = countries.country_id
group by employees.first_name, employees.last_name, employees.department_id, locations.city, employees.email,employees.phone_number
order by employees desc limit 5 ;



