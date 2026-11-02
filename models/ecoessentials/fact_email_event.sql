{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

SELECT
    e.email_key,
    et.event_type_key,
    u.user_key,
    d.date_key,
    c.campaign_key
FROM {{ source('ecoessentials_marketing', 'marketing_emails') }} m
LEFT JOIN {{ ref('dim_email') }} e ON e.email_id = m.emailid 
LEFT JOIN {{ ref('dim_event_type') }} et ON et.event_type = m.eventtype 
LEFT JOIN {{ ref('dim_user') }} u ON u.user_fname = m.subscriberfirstname AND u.user_lname = m.subscriberlastname
LEFT JOIN {{ ref('dim_date') }} d ON d.date_day = CAST(m.eventtimestamp AS DATE)
LEFT JOIN {{ ref('dim_promotional_campaign') }} c ON c.campaign_id = m.campaignid 