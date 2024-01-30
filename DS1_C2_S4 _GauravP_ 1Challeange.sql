use world;

# Task 1

select * from city;
select * from country;
select * from countrylanguage;

SELECT *, COUNT(*) OVER() AS total_rows
FROM Country where code in ('USA','GBR','ARE');

# Task 2

select sum(population) from city;

select country.Continent, SUM(city.Population) as 'Total_Population'from city
join country ON city.CountryCode = country.Code
group by country.Continent;

# Task 3

select * from city;
select * from country;
select * from countrylanguage;

select cl.Countrycode from countrylanguage as cl where cl.language = 'French';

select  c.Continent from country as c where c.Continent ='Europe';

select c.Name, c.Continent as E_continent from country as c
where c.Code in (select cl.Countrycode from countrylanguage as cl where cl.language = 'French') and c.Continent = 'Europe' ;

# Task 4

select * from city;
select * from country;
select * from countrylanguage;

select max(population) from city;
select c.Continent,max(c.population) as Highest_Population from country as c group by c.Continent ;







