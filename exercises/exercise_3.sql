/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
3. Listar los tres clientes (nombre, apellido y fecha de creación) que más películas
alquilaron y los tres que menos alquilaron.
*/
with first_3 as (
  select 
    c.customer_id, 
    c.store_id, 
    c.first_name || ' ' || c.last_name as customer_full_name, 
    p.amount, 
    r.rental_id 
  from 
    dvd_rental.customer c 
    join dvd_rental.payment p on p.customer_id = c.customer_id 
    join dvd_rental.rental r on r.rental_id = p.rental_id
), 
first_3_customers as(
  select 
    f3.customer_full_name, 
    f3.customer_id, 
    count(f3.rental_id) as quantity_rental, 
    sum(
      replace(f3.amount, '$', ''):: integer
    ) amount 
  from 
    first_3 f3 
  group by 
    1, 
    2 
  order by 
    3 desc 
  limit 
    3
), 
last_3 as (
  select 
    c.customer_id, 
    c.store_id, 
    c.first_name || ' ' || c.last_name as customer_full_name, 
    p.amount, 
    r.rental_id 
  from 
    dvd_rental.customer c 
    join dvd_rental.payment p on p.customer_id = c.customer_id 
    join dvd_rental.rental r on r.rental_id = p.rental_id
), 
last_3_customers as(
  select 
    l3.customer_full_name, 
    l3.customer_id, 
    count(l3.rental_id) as quantity_rental, 
    sum(
      replace(l3.amount, '$', ''):: integer
    ) amount 
  from 
    last_3 l3 
  group by 
    1, 
    2 
  order by 
    3 asc 
  limit 
    3
) 
SELECT 
  * 
FROM 
  first_3_customers 
union all 
select 
  * 
from 
  last_3_customers;