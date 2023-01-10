/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
1. Listar los cinco clientes que más han pagado por alquilar DVD de películas de terror (o
un género cualquiera específico).
*/
with tmp_1 as (
  select 
    c.customer_id, 
    c.store_id, 
    c.first_name || ' ' || c.last_name as customer_full_name, 
    c.store_id, 
    c.email, 
    c.address_id, 
    c.activebool, 
    c.create_date, 
    c.last_update, 
    c.active, 
    p.amount 
  from 
    dvd_rental.customer c 
    join dvd_rental.payment p on p.customer_id = c.customer_id 
    join dvd_rental.rental r on r.rental_id = p.rental_id 
    join dvd_rental.inventory i on i.inventory_id = r.inventory_id 
    join dvd_rental.film f on f.film_id = i.film_id 
    join dvd_rental.film_category fc on f.film_id = fc.film_id 
    join dvd_rental.category ca on fc.category_id = ca.category_id 
  where 
    ca.category_id = 1
), 
top_5_customers as(
  select 
    t1.customer_full_name, 
    t1.customer_id, 
    sum(
      replace(t1.amount, '$', ''):: integer
    ) amount 
  from 
    tmp_1 t1 
  group by 
    1, 
    2 
  order by 
    3 desc 
  limit 
    5
) 
select 
  * 
from 
  top_5_customers