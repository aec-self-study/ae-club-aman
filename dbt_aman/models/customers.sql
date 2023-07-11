{{ config(
    materialized = 'table'
)}}

with customers as (

SELECT
  a.id,
  name,
  email,
  MIN(created_at) AS first_order_at,
  COUNT(b.id) AS number_of_orders
FROM
  {{source('coffee_shop', 'customers') }} a
LEFT JOIN
  {{source('coffee_shop', 'orders') }} b
ON
  a.id = b.customer_id
GROUP BY
  1,
  2,
  3
ORDER BY
  first_order_at
LIMIT
  5)

  select * from customers