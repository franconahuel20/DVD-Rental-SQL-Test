/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
10. Determinar el primero y segundo mayor fan de cada actor (de acuerdo a los clientes que
alquilaron el mayor número de películas en donde estos actores participaron).
*/
select 
  * 
from 
  (
    select 
      t.customer_id, 
      customer_full_name, 
      t.actor_full_name, 
      count(*) as "quantity_rentals", 
      row_number() over(
        partition by t.customer_id 
        order by 
          count(*) desc
      ) 
    from 
      (
        select 
          r.customer_id, 
          c.first_name || ' ' || c.last_name as customer_full_name, 
          r.inventory_id, 
          i.film_id, 
          fa.actor_id, 
          a.first_name || ' ' || a.last_name as actor_full_name 
        from 
          dvd_rental.rental r 
          join dvd_rental.customer c on r.customer_id = c.customer_id 
          join dvd_rental.inventory i on r.inventory_id = i.inventory_id 
          join dvd_rental.film f on f.film_id = i.film_id 
          join dvd_rental.film_actor fa on fa.film_id = f.film_id 
          join dvd_rental.actor a on a.actor_id = fa.actor_id
      ) t 
    group by 
      1, 
      2, 
      3 
    order by 
      1, 
      4 desc
  ) t2 
where 
  t2.row_number between 1 
  and 2