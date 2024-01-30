Use sakila;

# Task 1

select * from film ;
select * from inventory ;

select * from film as f  where f.title in ('Brotherhood blanket', 'Soup wisdom') ;

select f.film_id, f.title,COUNT(i.inventory_id) as 'No of Copies' from film as f join inventory i ON f.film_id = i.film_id 
Where f.title in ('Brotherhood blanket', 'Soup wisdom') group by f.film_id,f.title ;

# Task 2

select * from film ;
select * from category;
select * from inventory;


select c.name as genre, COUNT(*) as total_movies
from film f join film_category as fc join category as c on f.film_id = fc.film_id 
and fc.category_id = c.category_id group by  c.name;

# Task 3

select * from film ;
select * from category;
select * from inventory;
select* from actor;
select* from film_actor;

select a.first_name,a.last_name, max(f.replacement_cost) as Highest_cost 
from actor as a join film_actor as fa join film as f on a.actor_id = fa.actor_id and fa.film_id = f.film_id
group by a.first_name,a.last_name  order by Highest_cost desc limit 3;

# Task 4

select * from film ;
select * from category;
select* from film_category;
select* from inventory;
select* from rental;


select c.name as genre, sum(p.amount) as total_sale_amount
from film as f join film_category as fc 
join category as c join inventory as i join rental as r 
join payment as p on f.film_id = fc.film_id and fc.category_id = c.category_id 
and f.film_id = i.film_id and i.inventory_id = r.inventory_id and r.rental_id = p.rental_id
group by c.name;


# Task 5

select c.name as genre, COUNT(*) as total_movies
from film as f join film_category as fc join category as c on f.film_id = fc.film_id 
and fc.category_id = c.category_id group by  c.name order by  total_movies  desc limit 10 ;

SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customdata1.csv' FROM film ;


