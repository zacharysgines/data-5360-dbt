{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

SELECT
    campaign_id as campaign_key,
    campaign_id,
    campaign_name,
    campaign_discount
FROM {{ source('ecoessentials_transactional', 'promotional_campaign') }}