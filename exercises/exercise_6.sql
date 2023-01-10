/*
********************************
SQL Test (ES)
********************************
Author: Herrera, Franco Nahuel.
Date: 10/01/2023
*/

/*
6. Listar el acumulado por día de pagos en un mes para un cliente.
*/
SELECT 
  p.customer_id, 
  date(p.payment_date) as date_payment, 
  sum(
    replace(p.amount, '$', ''):: integer
  ) as day_total 
FROM 
  dvd_rental.payment p 
where 
  p.customer_id = 10 
  and EXTRACT(
    MONTH 
    FROM 
      date(p.payment_date)
  ) = 08 
  and EXTRACT(
    YEAR 
    FROM 
      date(p.payment_date)
  ) = 2007 
GROUP BY 
  p.customer_id, 
  date_payment 
ORDER BY 
  date_payment asc;