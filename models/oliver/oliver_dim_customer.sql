{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
customer_id as Cust_Key,
customer_id as CustomerID,
first_name as FirstName,
last_name as LastName,
email as Email,
phone_number as PhoneNumber,
state as State
FROM {{ source('oliver_landing', 'customer') }}