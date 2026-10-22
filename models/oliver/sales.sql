
  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


SELECT
c.FirstName as customer_first_name,
c.LastName as customer_last_name,
d.date_ID as date_day,
p.Product_Name,
e.FirstName as employee_first_name,
e.LastName as employee_last_name,
f.Dollars_Sold

FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.Cust_Key = c.Cust_Key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.Date_Key = d.Date_Key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.Product_Key = p.Product_Key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.Employee_Key = e.Employee_Key