{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

SELECT
    emailid as email_key,
    emailid as email_id,
    emailname as email_name
FROM {{ source('ecoessentials_marketing', 'marketing_emails') }}