use sakila;
# Task 1 -- data of actors ..
select * from actor order by last_update ;

# Task 2 -- Count of First_Name & Last_Name.

select first_name, COUNT(*)  from actor group by first_name ;
select last_name, COUNT(*)  from actor group by last_name ;

select concat(first_name,' ',last_name) as Full_Name,
(select COUNT(*)  from actor as a1 where a1.first_name = a2.first_name) as First_Name_Count, 
(select COUNT(*) from actor as  a1 where a1.last_name = a2.last_name) as Last_Name_Count
from actor as a2 group by Full_Name,First_Name_Count,Last_Name_Count;


# Task 3 -- Movies_count

select* from film;
 select title ,count(*) from film group by title;
 
 select rating , count(*)  as Movies_count from film group by rating  order by Movies_count asc;
 
 # Task 4 -- Avrage rantel rate

select* from film;
 
  select rating , avg(rental_rate) as AVG_rate from film group by rating order by AVG_rate asc ;

 
 # Task 5 -- Replacement_cost (max and min)
 
 select* from film;
select title ,replacement_cost from film where replacement_cost <= 9; -- upto 9.
select title ,replacement_cost from film where replacement_cost between 15 and 20; -- between 15 and 20
select title ,replacement_cost from film where replacement_cost in (9.99,29.99) order by replacement_cost asc ; 

select replacement_cost from film ;
select max(replacement_cost) from film ;
select min(replacement_cost) from film ;

# Task 6-- title with K and Q .

select* from film;
select * from film_actor;
select  f.title , count(fa.actor_id) as Count_Of_Actors from film as f join film_actor as fa on f.film_id = fa.film_id group by f.title ;

# Task 7

select title from film where title LIKE 'k%';
select title from film where title LIKE 'Q%';
select title from film where title like 'k%' or title like 'Q%';

# Task 8

select* from film;
select* from actor;
select * from film_actor;

select film_Id,title from film where title = 'AGENT TRUMAN';

select a.first_name, a.last_name from actor as a 
join film_actor as fa 
join film as f on  a.actor_id = fa.actor_id and  fa.film_Id = f.film_Id where f.title = 'AGENT TRUMAN';

select a.first_name, a.last_name from actor as a 
join film_actor as fa 
join film as f on  a.actor_id = fa.actor_id and  fa.film_Id = f.film_Id where f.film_Id = 6;

# Task 9

select* from film;
select* from category;
select f.title as Movies_Names,c.name as Category from film as f join category as c 
where c.name in ('Children','Family');

# Task 10 -- no of  Freq_Rental_Movies.

select* from film;
select* from inventory;
select* from rental;

select f.title as Movies_Names ,count(r.rental_id) as Freq_Rental_Movies from film as f join inventory as i 
join rental as r  on f.film_id = i.film_id and i.inventory_id = r.inventory_id group by Movies_Names order by Freq_Rental_Movies desc ;

# Task 11 -- Number of movies category  > 15

select* from film;
select* from category;
select* from film_category;

select title ,avg(f.replacement_cost - f.rental_rate) >15 as avg_count from film  as f group by title; 

select count(*) as category_count from 
( select c.name from category as c
join film_category as fc 
join film as f on c.category_id = fc.category_id 
and fc.film_id = f.film_id 
group by c.name 
having avg(f.replacement_cost - f.rental_rate) > 15 ) as Number_of_Movies;


select c.name from category as c
join film_category as fc 
join film as f on c.category_id = fc.category_id 
and fc.film_id = f.film_id 
group by c.name 
having avg(f.replacement_cost - f.rental_rate) > 15 ;

# Task 12-- No of movies per category

select* from film;
select* from category;
select* from film_category;

select c.name ,count(f.title)  as Count_Of_Movies from category as c join film_category as fc 
join film as f on c.category_id = fc.category_id and fc.film_id = f.film_id group by c.name order by Count_Of_Movies desc ;

