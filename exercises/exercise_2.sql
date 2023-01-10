/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
2. Listar los cuatro actores (nombre y apellido) que más películas filmaron en el último año.
*/
with tmp_2 as (
  select 
    f.film_id, 
    a.first_name || ' ' || a.last_name as actor_full_name, 
    a.actor_id 
  from 
    dvd_rental.film f 
    join dvd_rental.film_actor fa on fa.actor_id = f.film_id 
    join dvd_rental.actor a on fa.actor_id = a.actor_id
), 
top_4_actors as(
  select 
    t2.actor_full_name, 
    t2.actor_id, 
    count(t2.actor_id) 
  from 
    tmp_2 t2 
  group by 
    1, 
    2 
  order by 
    3 desc 
  limit 
    4
) 
select 
  * 
from 
  top_4_actors