{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

--Get all distinct customers and their information from the ecoessentials_transactional table
WITH customers AS (
    SELECT
        customer_id,
        customer_first_name AS first_name,
        customer_last_name AS last_name,
        customer_phone,
        customer_address,
        customer_city,
        customer_state,
        customer_zip,
        customer_country
    FROM {{ source('ecoessentials_transactional', 'customer') }}
),

--Get all distinct subscribers and their information from the ecoessentials_marketing table
subscribers AS (
    SELECT
        subscriberfirstname AS first_name,
        subscriberlastname AS last_name,
        subscriberid AS subscriber_id
    FROM {{ source('ecoessentials_marketing', 'marketing_emails') }}
    GROUP BY 1,2,3
)

--Create one row for each customer/subscriber, combining customers and subscribers by first and last name if they match 
SELECT
    --For the key, just count up by 1 for each new row instead of using either of the keys themselves
    ROW_NUMBER() OVER (ORDER BY COALESCE(c.last_name, s.last_name), COALESCE(c.first_name, s.first_name)) AS user_key,
    c.customer_id,
    s.subscriber_id,
    COALESCE(c.first_name, s.first_name) AS user_fname,     --Use the customer first/last name as the user first/last name unless it doesn't exist,
    COALESCE(c.last_name, s.last_name) AS user_lname,       --then use the subscriber first/last name
    c.customer_phone AS user_phone,
    c.customer_address AS user_address,
    c.customer_city AS user_city,
    c.customer_state AS user_state,
    c.customer_zip AS user_zip,
    c.customer_country AS user_country
FROM customers c
FULL OUTER JOIN subscribers s
    ON c.first_name = s.first_name
   AND c.last_name = s.last_name