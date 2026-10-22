{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
product_id as Product_Key,
product_id as Product_ID,
product_name as Product_Name,
description as Description
FROM {{ source('oliver_landing', 'product') }}