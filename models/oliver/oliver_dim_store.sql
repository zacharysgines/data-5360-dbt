{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
store_id as Store_Key,
store_id as Store_ID,
store_name as Store_Name,
street as Street,
city as City,
state as State
FROM {{ source('oliver_landing', 'store') }}