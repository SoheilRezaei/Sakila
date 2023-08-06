--customer
INSERT INTO customer_staging
SELECT c.first_name , c.last_name , c.active , ad.address , ci.city , co.country 
FROM customer c 
INNER JOIN address ad
ON c.address_id = ad.address_id
INNER JOIN city ci
ON ad.city_id = ci.city_id
INNER JOIN country co
ON ci.country_id = co.country_id




--store
INSERT INTO store_staging
SELECT  ad.address , ci.city , co.country , staf.first_name , staf.last_name  
FROM store s
INNER JOIN address ad
ON s.address_id = ad.address_id
INNER JOIN city ci
ON ad.city_id = ci.city_id
INNER JOIN country co
ON ci.country_id = co.country_id
INNER JOIN staff staf
ON s.manager_staff_id = staf.staff_id 



--staff
INSERT INTO staff_staging
SELECT s.first_name , s.last_name , ad.address , ci.city , co.country 
FROM staff s
INNER JOIN address ad
ON s.address_id = ad.address_id
INNER JOIN city ci
ON ad.city_id = ci.city_id
INNER JOIN country co
ON ci.country_id = co.country_id



--film
INSERT INTO film_staging
SELECT  f.title , f.description , f.release_year , l.name AS 'film_language' , f.rental_duration , f.rental_rate , f.length AS 'film_duration', f.replacement_cost , f.rating , ca.name AS 'film_category' 
FROM film f
INNER JOIN language l 
ON f.language_id = l.language_id
INNER JOIN film_category fc
ON f.film_id = fc.film_id
INNER JOIN category ca
ON ca.category_id = fc.category_id



--rental
INSERT INTO rental_staging
SELECT cu.first_name AS 'customer_firstname', cu.last_name AS 'customoer_lastname' , st.first_name AS 'staff_firstname' , st.last_name AS 'staff_lastname' ,
fi.title AS 'film_name' , ad.address AS 'Store_address' , re.rental_date , re.return_date , act.first_name AS 'actor_firstname', act.last_name AS 'actor_lastname'
FROM rental re
INNER JOIN customer cu
ON re.customer_id = cu.customer_id
INNER JOIN staff st
ON re.staff_id = st.staff_id
INNER JOIN inventory inv
ON re.inventory_id = inv.inventory_id
INNER JOIN film fi
ON inv.film_id = fi.film_id
INNER JOIN store sto
ON inv.store_id = sto.store_id
INNER JOIN address ad
ON sto.address_id = ad.address_id
INNER JOIN film_actor fa
ON inv.film_id = fa.film_id
INNER JOIN actor act
ON fa.actor_id = act.actor_id





WITH rental_dates (rental_date)AS
(    SELECT rental_date FROM rental
    UNION    SELECT return_date FROM rental
)SELECT DISTINCT CAST(rental_date AS DATETIME) AS rental_date FROM rental_dates AS Date