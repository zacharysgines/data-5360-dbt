{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

WITH event_types AS (
    SELECT DISTINCT eventtype AS event_type
    FROM {{ source('ecoessentials_marketing', 'marketing_emails') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY event_type) AS event_type_key,
    event_type
FROM event_types