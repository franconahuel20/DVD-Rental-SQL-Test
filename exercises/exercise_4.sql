/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
4. Listar la cantidad de películas en el inventario para cada tienda.
*/
select 
  i.inventory_id, 
  i.store_id, 
  count(f.film_id) as quantity_films 
from 
  dvd_rental.store s 
  join dvd_rental.staff st on st.store_id = s.store_id 
  join dvd_rental.payment p on p.staff_id = st.staff_id 
  join dvd_rental.rental r on r.rental_id = p.rental_id 
  join dvd_rental.inventory i on i.inventory_id = r.inventory_id 
  join dvd_rental.film f on f.film_id = i.film_id 
group by 
  1, 
  2 
order by 
  quantity_films desc;