/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/
/*
9. Cantidad y promedio de películas por lenguaje en cada categoría.
*/
with languages_temp as (
select c.category_id,c."name" as "category_name",l.language_id,l."name" as "language_name" 
from dvd_rental."language" l
	inner join dvd_rental.film f on f.language_id = l.language_id 
	inner join dvd_rental.film_category fc on fc.film_id = f.film_id 
	inner join dvd_rental.category c on fc.category_id = c.category_id
	),temporal as(
	select lt."category_name",
SUM(CASE WHEN lt.language_id = 1 THEN 1
 ELSE 0 END) "English",
 SUM(CASE WHEN lt.language_id = 2 THEN 1
 ELSE 0 END) "Italian",
 SUM(CASE WHEN lt.language_id = 3 THEN 1
 ELSE 0 END) "Japanese",
 SUM(CASE WHEN lt.language_id = 4 THEN 1
 ELSE 0 END) "Mandarin",
 SUM(CASE WHEN lt.language_id = 5 THEN 1
 ELSE 0 END) "French",
 SUM(CASE WHEN lt.language_id = 6 THEN 1
 ELSE 0 END) "German"
 from languages_temp lt
group by lt.category_id,lt."category_name",lt.language_id,lt."language_name")
	
select 
t."category_name",t."English",t."English"/
CASE WHEN sum(t."English") = 0 THEN 1
 ELSE sum(t."English")
 END
 as avg_english,
 
t."Italian",t."Italian"/
CASE WHEN sum(t."Italian") = 0 THEN 1
 ELSE sum(t."Italian")
 END
as avg_italian,

t."Japanese",t."Japanese"/
CASE WHEN sum(t."Japanese") = 0 THEN 1
 ELSE sum(t."Japanese")
 END
as avg_japanese,

t."Mandarin",t."Mandarin"/
CASE WHEN sum(t."Mandarin") = 0 THEN 1
 ELSE sum(t."Mandarin")
 END
as avg_mandarin,

t."French",t."French"/
CASE WHEN sum(t."French") = 0 THEN 1
 ELSE sum(t."French")
 END
as avg_french,

t."German",t."German"/
CASE WHEN sum(t."German") = 0 THEN 1
 ELSE sum(t."German")
 END
as avg_german

from temporal t group by t."category_name",t."English",t."Italian",t."Japanese",t."Mandarin",t."French",t."German";