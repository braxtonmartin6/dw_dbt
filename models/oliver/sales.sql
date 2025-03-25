
  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


SELECT
c.first_name as customer_first_name,
c.last_name as customer_last_name,
d.date_day,
p.product_id,
e.first_name as employee_first_name,
e.last_name as employee_last_name,
s.store_id,
fs.dollars_sold
FROM {{ ref('fact_sales') }} fs

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON fs.customer_key = c.customer_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON fs.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON fs.product_key = p.product_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON fs.date_key = d.date_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON fs.store_key = s.store_key
