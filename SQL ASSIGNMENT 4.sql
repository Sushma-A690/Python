use sakila;

-- 1 List all customers along with the films they have rented.
select c.first_name, c.last_name, f.title,r.rental_id from customer c
left Join rental r on c.customer_id = r.customer_id
left join inventory i  on r.inventory_id = i.inventory_id 
left join film f on f.film_id = i.film_id ;
-- 2  List all customers and show their rental count, including those who haven't rented any films.

select c.customer_id,c.first_name,c.last_name,count(rental_id) as total_rental from customer c
left join rental r ON r.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name;

-- 3. Show all films along with their category. Include films that don't have a category assigned.
select f.title,c.name from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on c.category_id = fc.category_id ;
-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
select c.email as customer_email,s.email as staff_email from customer c
left join staff s on c.email = s.email
UNION 
select  c.email as customer_email,s.email as staff_email from customer c
Right join staff s on c.email = s.email;
-- 5 Find all actors who acted in the film "ACADEMY DINOSAUR".
select a.first_name,a.last_name,f.title from actor a 
join film_actor fa on fa.actor_id = a.actor_id
join film f on f.film_id = fa.film_id 
where f.title = 'ACADEMY DINOSAUR' ; -- validation is done by using title in select
-- 6  List all stores and the total number of staff members working in each store, even if a store has no staff.
select s.store_id,count(st.staff_id) as total_staff from  store s 
left join staff st on st.store_id = s.store_id
group by s.store_id;
-- 7 List the customers who have rented films more than 5 times. Include their name and total rental count.
select c.customer_id,c.first_name,c.last_name, count(r.rental_id) as total_rental from customer c
join rental r on c.customer_id = r.customer_id 
group by c.customer_id,c.first_name,c.last_name
having total_rental> 5; -- customer_id is the primary key of customer.

# This means customer_id uniquely determines first_name and last_name.

# MySQL sees that first_name and last_name are functionally dependent on customer_id.

# So it allows you to select them without adding them to GROUP BY, even with ONLY_FULL_GROUP_BY enabled.
SELECT @@sql_mode;
