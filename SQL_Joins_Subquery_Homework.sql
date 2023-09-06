--1. List all customers who live in Texas (use JOINs)

select address.address_id, address.district, first_name, last_name
from address
inner join customer
on customer.address_id = address.address_id 
where district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name

select p.payment_id, p.customer_id, p.amount, c.first_name, c.last_name
from payment as p
inner join customer as c
on p.customer_id = c.customer_id
where amount > 6.99
order by p.payment_id asc;

-- 3. Show all customers names who have made payments over $175(use subqueries)

select first_name, last_name
from customer
where customer_id in (
	select customer_id 
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc
)
group by first_name, last_name;

-- 4. List all customers that live in Nepal (use the city table)

select customer.first_name, customer.last_name,country
from customer
full join address
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id
full join country
on city.country_id = country.country_id
where country = 'Nepal';

-- 5. Which staff member had the most transactions?

select first_name, last_name, max(transactions)
from (
	select first_name, last_name, count(payment.payment_id) as transactions
	from staff
	inner join payment
	on staff.staff_id = payment.staff_id
	group by 1,2
) sub
group by 1,2;

-- 6. How many movies of each rating are there?

select rating, count(rating)
from film
group by rating
order by count(rating) desc;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
);

-- 8. How many free rentals did our stores give away?

select count(payment_id), amount
from payment
where amount =0
group by amount;





