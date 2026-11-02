{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

SELECT
    order_id as order_key,
    order_id
FROM {{ source('ecoessentials_transactional', 'ORDER') }}