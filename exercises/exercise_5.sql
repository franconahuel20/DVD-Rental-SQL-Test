/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
5. Listar el Top tres de vendedores (staff) para cada una de las tiendas.
*/
select 
  s.staff_id, 
  s.first_name || ' ' || s.last_name as staff_full_name, 
  st.store_id, 
  sum(
    replace(p.amount, '$', ''):: integer
  ) amount, 
  RANK() OVER (
    PARTITION BY s.staff_id 
    ORDER BY 
      sum(
        replace(p.amount, '$', ''):: integer
      ) desc
  ) AS rank 
from 
  dvd_rental.payment p 
  join dvd_rental.staff s on s.staff_id = p.staff_id 
  join dvd_rental.store st on st.store_id = s.store_id 
group by 
  1, 
  2, 
  3 
order by 
  4;