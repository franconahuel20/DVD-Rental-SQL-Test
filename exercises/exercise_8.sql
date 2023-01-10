/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/
/*
8. Contar el número de clientes por país.
*/
select country, count(*) as customers_per_country from dvd_rental.country
inner join dvd_rental.city on dvd_rental.country.country_id = dvd_rental.city.country_id
inner join dvd_rental.address on dvd_rental.city.city_id=dvd_rental.address.city_id
inner join dvd_rental.customer on dvd_rental.address.address_id=dvd_rental.customer.address_id
group by country
order by customers_per_country desc