---------------------------- (1) Recommendations for astronaut-related films
--------------------------------------78



SELECT count(title) FROM film WHERE fulltext @@ to_tsquery('astronaut') group by to_tsquery('astronaut')

	
---------------------------- (2) Count of Films for R Rating & Replacement cost between 5 & 15
--------------------------------------52
select
	rating,
	count(replacement_cost)
from 	
	film 
where
	rating = 'R'
	and
	replacement_cost between 5 and 15
group by rating
	

---------------------------- (3) Bonus for staff who handled more payments & amounts
-------------------------------------- Staff 2 should be given the bonus
select 
	staff_id,
	count(payment_id),
	sum(amount)
from 
	payment
group by 
	staff_id
order by 
	sum desc
	
	
	
---------------------------- (4) Auditing the store in order to know The average of replacement cost of movies per rating
--------------------------------------52

select 
	rating,
	store_id,
	avg(replacement_cost)
from 
	film
inner join inventory on film.film_id = inventory.film_id 
group by
	store_id,
	rating
order by 
	rating,
	avg desc
	

	
	
---------------------------- (5) Sending coupons for customer who spent most money
--------------------------------------
select 
	concat(c.first_name,' ', c.last_name) AS Name,
	c.email,
	sum(amount)
from 
	customer c
inner join payment p on p.customer_id = c.customer_id 
group by 
	c.customer_id 
order by
	sum desc
limit 5



---------------------------- (6) Count of each movies in each store
--------------------------------------
select 
	title,
	store_id,
	count(i.film_id)
from 
	film f 
inner join inventory i on i.film_id = f.film_id 
group by 
	store_id,
	title
order by 
	title
	
	
	
---------------------------- (7) Platinum credit card for customer who atleast have 40 transaction payments
-------------------------------------- 

select 
	first_name,
	email
from 
	customer 
inner join payment on customer.customer_id = payment.customer_id
group by 
	first_name,
	email
having
	count(payment_id ) >= 40
order by 
	count(payment_id )




	
	


