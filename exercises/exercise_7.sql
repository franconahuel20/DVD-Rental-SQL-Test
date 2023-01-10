/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
7. Listar la película que más se rentó por cada categoría.
*/
with rent_movies as(
  select 
    name as genre, 
    count(rental_id) as "conteo", 
    f.title 
  from 
    dvd_rental.rental r 
    join dvd_rental.inventory using(inventory_id) 
    join dvd_rental.film f using(film_id) 
    join dvd_rental.film_category using (film_id) 
    join dvd_rental.category using(category_id) 
  group by 
    genre, 
    f.title 
  order by 
    conteo desc
), 
most_rents as(
  select 
    distinct(genre), 
    max(conteo) as rents 
  from 
    rent_movies 
  group by 
    1 
  order by 
    rents desc
) 
select 
  m.genre, 
  m.rents, 
  r.title 
from 
  most_rents m 
  inner join rent_movies r on m.rents = r.conteo