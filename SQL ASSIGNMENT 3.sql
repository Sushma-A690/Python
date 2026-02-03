use sakila;
-- 1 
select * from customer
where customer_id IN (select customer_id from payment
group by customer_id
having count(*)>5);

-- 2 
select first_name,last_name from actor
where actor_id IN (select actor_id from film_actor
group by actor_id
having count(*)>10) ; 

-- 3
select first_name,last_name from customer
where customer_id NOT IN (select customer_id from payment );

-- 4
select title from film
where rental_rate> (select Avg(rental_rate) from film) ;

-- 5

select title from film
where film_id NOT IN (select film_id from inventory 
where inventory_id IN (select inventory_id from rental)
); -- but this fails if it has null should use NOT EXISTS

-- 6

select * from customer 
where customer_id IN (select customer_id from rental
where month(rental_date) IN (select month(rental_date) from rental 
where customer_id = 5 ));
-- AND customer_id <> 5 ; if they want excluding 5 and this query works for only same month not for same year 

-- 7
select first_name,last_name from staff where staff_id IN (select staff_id from payment 
where amount > (select AVG(amount) from payment)
);

-- 8 
select title,rental_duration from film 
where rental_duration > (select AVG(rental_duration) from film) ;

-- 9 
select * from customer 
	where address_id IN (select address_id from address
	where address =
	(select address from address
	where address_id = (select address_id from customer 
	where customer_id = 1)
	)
	); 

-- 10
select * from payment 
where amount >(select avg(amount) from payment);

