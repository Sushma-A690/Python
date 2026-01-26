SHOW databases;
USE sakila;
SHOW TABLES;
SELECT * FROM sakila.actor;
SELECT TABLE_NAME, COLUMN_NAME
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'sakila'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
-- 1
SELECT * FROM customer;
SELECT first_name,last_name from customer 
WHERE first_name LIKE 'J%' AND active=1; -- to manually check we can use active in the select
-- 2
SELECT * FROM film;
SELECT title from film
WHERE title LIKE '%ACTION%' or description LIKE '%WAR%';  
-- 3
SELECT * FROM customer;
SELECT first_name,last_name from customer
WHERE NOT last_name = 'SMITH' AND first_name LIKE '%a' ;
-- 4
SELECT * FROM film;
SELECT title from film
WHERE rental_rate > 3.0 AND replacement_cost IS NOT NULL;
-- 5
SELECT * FROM customer;
SELECT COUNT(*),store_id from customer
WHERE active=1
GROUP BY store_id
HAVING Count(*) ;
-- 6
SELECT distinct(rating) FROM film;
-- 7
select rental_duration,AVG(length) from film
GROUP BY rental_duration
HAVING AVG(length)>100;
-- 8
select * from payment ;
select payment_date,SUM(amount) from payment
Group by payment_date
HAVING COUNT(*)>100 ;
-- 9
SELECT * FROM customer;
select first_name,last_name from customer
WHERE email IS NULL OR email LIKE '%.org';
-- 10
Select title,rating from film
WHERE rating IN ('PG','G')
ORDER BY rental_rate DESC;
-- 11
SELECT * from film;
SELECT length,count(*) from film
where title LIKE 'T%'
group by length
having count(*)>5;
-- 12
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(film_id) > 10
);
-- 13
select * from film;
select title,rental_rate,length from film
ORDER BY rental_rate DESC, length DESC
LIMIT 5;
-- 14
SELECT first_name,last_name,
  (SELECT COUNT(*) 
     FROM rental 
     WHERE rental.customer_id = customer.customer_id) AS total_rentals
FROM customer
WHERE customer_id IN (
      SELECT customer_id
      FROM rental
      GROUP BY customer_id
      HAVING COUNT(rental_id) > 0
)
ORDER BY total_rentals DESC;
-- 15 
select * from film;

