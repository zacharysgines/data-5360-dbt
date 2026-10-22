{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.Cust_Key,
    d.Date_Key,
    s.Store_Key,
    p.Product_Key,
    e.Employee_Key,
    ol.quantity as Quantity,
    o.total_amount as Dollars_Sold,
    ol.unit_price as Unit_Price

FROM {{ source('oliver_landing', 'orderline') }} ol
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON ol.order_id = o.order_id
INNER JOIN {{ ref('oliver_dim_customer') }} c ON o.customer_id = c.CustomerID 
INNER JOIN {{ ref('oliver_dim_date') }} d ON o.order_date = d.date_ID
INNER JOIN {{ ref('oliver_dim_store') }} s ON o.store_id = s.Store_ID 
INNER JOIN {{ ref('oliver_dim_product') }} p ON ol.product_id = p.Product_ID
INNER JOIN {{ ref('oliver_dim_employee') }} e ON o.employee_id = e.EmployeeID 