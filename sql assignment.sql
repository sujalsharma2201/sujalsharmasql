#1 
use new; 
create table employees (
emp_id int NOT NULL primary key,
emp_name char(30) NOT NULL,
age int check(age >=18),
email char(70) UNIQUE,
salary decimal default 3000);

#2 Constraints are rules enforced on data in a database to ensure its accuracy, reliability, and consistency. 
#They help maintain data integrity by preventing invalid data from being entered or 
#inconsistent relationships from being formed.

#constraints  maintain integrity by reducing errors,promote consistency and prevent invalid data
#type of constraint 
create table employees (
emp_id int NOT NULL primary key, #primary key constraint
emp_name char(30) NOT NULL,
age int check(age >=18),
email varchar(70) UNIQUE, #unique constraint
salary decimal default 3000); #default constraint

#3
#The NOT NULL constraint is used to ensure that a column cannot contain NULL values,
# meaning that every record must have a value for that column. 
#It is applied when a value is required for the column to make sense in the context of the data or
# when missing values could lead to logical inconsistencies or errors.

#No, a primary key cannot contain NULL values.

#4
create table name(
id int,
first_name char(30),
last_name char(30));

#add constraint 
alter table name 
ADD constraint pk_id primary key (id);

#remove constraint
alter table name
drop constraint pk_id;

#5
#When attempting to insert, update, or delete data in a way that violates a database constraint,
# the database management system (DBMS) enforces the rules defined by the constraints and
# prevents the operation from completing.
# This ensures data integrity but results in an error.

#example
insert into employees values
(1,"emp1",20,"emp1@gmail.com",30000),
(1,"emp2",20,"emp2@gmail.com",40000); 
#it throws error bcoz duplicate primary key exists.


#6
CREATE TABLE products (
product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2));

alter table products add constraint primary key (product_id);
alter table products alter column price  set DEFAULT 50.00;

#7
select student_name,class_name
from students inner join classes
where students.class_id = classes.class_id;

#8
select order_id,customer_name,product_name 
from product p 
LEFT JOIN orders o on p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;

#9
select products_name,sum(amount)
from products inner join sales
where products.product_id = sales.product_id
group by products_name;

#10
select order_id,customer_name,quantity from
order_details od
inner join orders o on o.customer_id = customers.customer_id
inner join od on o.order_id = od.order_id;

#sql commands
#1
#different primarykey in mavenmovie database are
#actor_id,Actor_award_id,address_id,advisor_id,category_id,city_id,country_id,customer_id,film_id

#different foriegn keys are
#director_id: A foreign key referencing directors(director_id).
#genre_id: A foreign key referencing genres(genre_id).

#2 
use mavenmovies;
select * from actor;

#3
select * from customer;

#4
select distinct(country) from country;

#5
select * from customer
where active = 1;

#6 
select * from rental;
select rental_id from rental
where customer_id = 1;

#7
select * from film
where rental_duration > 5;

#8
select * from film
where replacement_cost between 15 and 20; 

#9
select count(distinct(first_name)) from actor;

#10
select * from customer
limit 10;

#11
select * from customer
where first_name like 'B%'
limit 3;

#12
select * from film
where rating = "G";

#13
select * from customer
where first_name like 'A%';

#14
select * from customer
where first_name like '%A';

#15
select * from city
where city like '%A%';

#16
select * from customer
where first_name like '%NI%';

#17
select * from customer
where first_name like '_r%';

#18
select * from customer
where first_name like 'A%'
and 
length(first_name) = 5;

#19
select * from customer
where first_name like 'A%'and'o%';

#20
select * from film
where rating in('PG','PG-13');

#21
select * from film 
where length between 50 and 100;

#22
select * from actor
limit 50;

#23
select distinct(film_id) from inventory;

#basic aggregate functions
#1 
use sakila;
select count(rental_id) from rental;

#2
select avg(datediff(return_date,rental_date)) avg_rented_days from rental;

#3
select upper(first_name),upper(last_name) from customer;

#4
select rental_id,month(rental_date) as month_of_rental from rental;

#5
select customer_id,count(distinct customer_id) as no_Of_rents from customer
group by customer_id;

#6
--

#7
SELECT c.name AS category_name, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

#8
select avg(rental_rate),name 
from film join language
where film.language_id = language.language_id
group by name;

#join
#9
select f.title,C.first_name,c.last_name from Film f
JOIN customer c on r.customer_id = c.customer_id
JOIN rental r on r.inventory_id = i.inventory_id
JOIN inventory i on f.film_id = i.film_id;

#10
select first_name,last_name from actor a
join film_actor fa on fa.actor_id = a.actor_id
join film f on fa.film_id = f.film_id
where title = 'Gone with the Wind';

#11
 SELECT 
CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
SUM(payment.amount) AS total_spent
FROM 
customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id
ORDER BY total_spent DESC;

#12
SELECT 
CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
city.city AS customer_city,
GROUP_CONCAT(DISTINCT film.title ORDER BY film.title ASC) AS rented_movies
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE city.city = 'London'
GROUP BY customer.customer_id, city.city
ORDER BY customer_name;

#13
SELECT 
film.title AS movie_title,
COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;

#14
SELECT 
CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,customer.customer_id
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
WHERE inventory.store_id IN (1, 2)
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT inventory.store_id) = 2
ORDER BY customer_name;

#window function
#1 
select 
concat(first_name,' ',last_name) as customer_name,
sum(amount) as total_spent,
row_number() over(order by sum(amount)) as rankno
from customer c
JOIN rental r on c.customer_id = r.customer_id
JOIN payment p on p.rental_id = r.rental_id
group by customer_name
order by rankno desc;

#3
SELECT 
title AS film_title,
length AS film_length,
AVG(DATEDIFF(return_date,rental_date)) AS avg_rental_duration
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date IS NOT NULL
GROUP BY length, title
ORDER BY film_length, film_title;

#4
select 
name as category_name,
title as film_title,
count(rental_id) as rental_count,
row_number() over(order by count(rental_id)) as count_no
from film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
group by category.category_id,film.film_id,category.name,film.title
order by count_no desc
limit 3;

#6
SELECT 
DATE_FORMAT(payment.payment_date, '%Y-%m') AS month,
SUM(payment.amount) AS total_revenue
FROM payment
GROUP BY DATE_FORMAT(payment.payment_date, '%Y-%m')
ORDER BY month;

#7
SELECT 
category.name AS category_name,
film.title AS film_title,
COUNT(rental.rental_id) AS rental_count,
SUM(COUNT(rental.rental_id)) OVER (
PARTITION BY category.category_id
ORDER BY COUNT(rental.rental_id) DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_rentals
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.category_id, film.film_id, category.name, film.title
ORDER BY category_name, rental_count DESC;

#10
SELECT 
DATE_FORMAT(payment.payment_date, '%Y-%m') AS month,
SUM(payment.amount) AS total_revenue
FROM payment
GROUP BY DATE_FORMAT(payment.payment_date, '%Y-%m')
ORDER BY total_revenue DESC
LIMIT 5;

#norm and cte
#1 a prominent example of violation in 1NF can often be seen in the address table .
#where multiple phone numbers or email addresses are stored in a single column.
#To bring the address table into 1NF, we need to ensure that each column contains only atomic values. 
#This can be achieved by creating a new row for each phone number, 
#thereby ensuring that each field contains only one value per row.

#2
#The film_actor table violated 2NF because of the partial dependency of the last_update field 
#on only part of the composite key (film_id). 
#To normalize it, we separated the last_update field into a separate film table,
# ensuring that the remaining fields in the film_actor table depend on the whole primary key. 
#This structure now complies with 2NF.

#3
#The staff table violates 3NF because of the transitive dependency between store_name and staff_id.
# By separating the store-related information into a new store table, 
#we eliminate the transitive dependency, bringing the database to 3NF.

#5
WITH ActorFilmCount AS (
SELECT 
a.actor_id,
a.first_name,
a.last_name,
COUNT(fa.film_id) AS film_count
FROM 
actor a
JOIN 
film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
a.actor_id, a.first_name, a.last_name
)
SELECT 
first_name, 
last_name, 
film_count
FROM ActorFilmCount
ORDER BY film_count DESC;

#6
WITH FilmLanguageInfo AS (
SELECT 
f.title AS film_title,
l.name AS language_name,
f.rental_rate
FROM 
film f
JOIN 
language l ON f.language_id = l.language_id
)
SELECT 
film_title, 
language_name, 
rental_rate
FROM FilmLanguageInfo
ORDER BY film_title;

#7
WITH CustomerRevenue AS (
SELECT 
c.customer_id,
c.first_name,
c.last_name,
SUM(p.amount) AS total_revenue
FROM 
customer c
JOIN 
payment p ON c.customer_id = p.customer_id
GROUP BY 
c.customer_id, c.first_name, c.last_name
)
SELECT 
first_name, 
last_name, 
total_revenue
FROM CustomerRevenue
ORDER BY total_revenue DESC;

#8
WITH FilmRentalRank AS (
SELECT 
f.title AS film_title,
f.rental_duration,
RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank
FROM 
film f
)
SELECT 
film_title, rental_duration, rental_rank
FROM FilmRentalRank
ORDER BY rental_rank;

#9
WITH RentalCount AS (SELECT 
r.customer_id,
COUNT(r.rental_id) AS rental_count
FROM 
rental r
GROUP BY 
r.customer_id
HAVING 
COUNT(r.rental_id) > 2
)
SELECT 
c.customer_id,
c.first_name,
c.last_name,
c.email,
c.address_id,
rc.rental_count
FROM RentalCount rc
JOIN customer c ON rc.customer_id = c.customer_id
ORDER BY rc.rental_count DESC;

#11
WITH ActorPairs AS (
SELECT         
fa1.actor_id AS actor1_id,
fa2.actor_id AS actor2_id,
fa1.film_id
FROM 
film_actor fa1
JOIN 
film_actor fa2 ON fa1.film_id = fa2.film_id
WHERE 
fa1.actor_id < fa2.actor_id  
)
SELECT 
ap.actor1_id,ap.actor2_id,f.title AS film_title
FROM ActorPairs ap
JOIN film f ON ap.film_id = f.film_id
ORDER BY film_title;

