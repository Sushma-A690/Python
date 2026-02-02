use sakila;
-- 1
select customer_id,COUNT(*) from customer 
group by customer_id
having count(*)>1; -- using primary key 
select first_name,last_name,email,Count(*) from customer
Group by first_name,last_name,email
having count(*) >1;
-- 2
SELECT description,
       LENGTH(description) - LENGTH(REPLACE(lower(description), 'a', '')) AS a_count
FROM film;
-- 3
SELECT description,
       LENGTH(description) - LENGTH(REPLACE(lower(description), 'a', '')) AS a_count,
        LENGTH(description) - LENGTH(REPLACE(lower(description), 'e', '')) AS e_count,
         LENGTH(description) - LENGTH(REPLACE(lower(description), 'i', '')) AS i_count,
          LENGTH(description) - LENGTH(REPLACE(lower(description), 'o', '')) AS o_count,
           LENGTH(description) - LENGTH(REPLACE(lower(description), 'u', '')) AS u_count
FROM film;
-- 4
select c.first_name,c.last_name,t.total_amount,t.payment_in_year from customer c
join(select sum(amount) as total_amount,year(payment_date) as payment_in_year,customer_id from payment 
group by customer_id,year(payment_date)
having sum(amount)>0) t on c.customer_id = t.customer_id;-- yearly 
select first_name,last_name,t.total_amount,t.Month_of_purchase,t.year_of_purchase,t.no_of_the_month from customer c join(select customer_id,sum(amount) as total_amount, monthname(payment_date) as Month_of_purchase,month(payment_date) as no_of_the_month,year(payment_date) as year_of_purchase from payment
group by customer_id,monthname(payment_date),year(payment_date),month(payment_date)
having sum(amount)>0) t ON c.customer_id = t.customer_id
Order by t.no_of_the_month asc; -- monthly
select c.first_name,c.last_name,t.total_amount,t. week_number from customer c
join(select sum(amount) as total_amount,FLOOR( (DAYOFYEAR(payment_date) - 1) / 7 ) + 1 AS week_number,customer_id from payment 
group by customer_id,FLOOR( (DAYOFYEAR(payment_date) - 1) / 7 ) + 1
having sum(amount)>0) t on c.customer_id = t.customer_id
order by t.week_number; -- week number instead of select weekofyear() i took the condition as weekofyear starts with monday

-- 5
select curdate() as today_date,
CASE
 WHEN (year(curdate())% 4 =0 and year(curdate())% 100 <> 0)or (YEAR(curdate()) % 400 = 0) THEN 'It is a leap year' 
 ELSE 'It is not a Leap year'
 END as leap_year_check ; -- % 400 is mainly to check the one's from centuries
 
 select '2000-07-18' as randomdate,
	CASE
	 WHEN (year('2000-07-18')% 4 =0 and year('2000-07-18')% 100 <> 0 ) or (YEAR('2000-07-18') % 400 = 0)THEN 'It is a leap year' 
      ELSE 'It is not a Leap year' 
	 END as leap_year_check ;

-- 6
SELECT DATEDIFF("2026-12-31",curdate());
-- 7
SELECT payment_date, quarter(payment_date) as payment_by_quarter from payment ;

select payment_date from payment
where quarter(payment_date)=1; -- why its showing 2006 when its not in the payment_date column but in last_update
-- 8 
SELECT CONCAT(
    TIMESTAMPDIFF(YEAR, '2000-07-25', CURDATE()), ' years, ',
    TIMESTAMPDIFF(MONTH, '2000-07-25', CURDATE()) % 12, ' months, ',
    DATEDIFF(
        CURDATE(),
        DATE_ADD(
            DATE_ADD('2000-07-25',
                     INTERVAL TIMESTAMPDIFF(YEAR, '2000-07-25', CURDATE()) YEAR),
            INTERVAL TIMESTAMPDIFF(MONTH, '2000-07-25', CURDATE()) % 12 MONTH
        )
    ), ' days'
) AS age

SELECT 
    TIMESTAMPDIFF(YEAR, '2000-07-25', '2026-02-02') AS 'years',
    TIMESTAMPDIFF(MONTH, '2000-07-25', '2026-02-02') % 12 AS months,
    DATEDIFF(
        '2026-02-02',
        DATE_ADD(
            DATE_ADD(
                '2000-07-25',
                INTERVAL TIMESTAMPDIFF(YEAR, '2000-07-25', '2026-02-02') YEAR
            ),
            INTERVAL TIMESTAMPDIFF(MONTH, '2000-07-25', '2026-02-02') % 12 MONTH
        )
    ) AS days;


