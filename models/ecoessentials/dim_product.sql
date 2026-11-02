{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

SELECT
    product_id as product_key,
    product_id,
    product_type,
    product_name,
    price
FROM {{ source('ecoessentials_transactional', 'product') }}