{{ config(
    materialized = 'table',
    database = 'group3_project',
    schema = 'dw_ecoessentials'
) }}

SELECT
    o.order_key,
    p.product_key,
    u.user_key,
    d.date_key,
    c.campaign_key,
    ol.quantity,
    ol.discount,
    ol.price_after_discount
FROM {{ source('ecoessentials_transactional', 'order_line') }} ol
LEFT JOIN {{ source('ecoessentials_transactional', 'ORDER') }} order_source ON order_source.order_id = ol.order_id
LEFT JOIN {{ ref('dim_order') }} o ON o.order_id = ol.order_id 
LEFT JOIN {{ ref('dim_product') }} p ON p.product_id = ol.product_id 
LEFT JOIN {{ ref('dim_user') }} u ON u.customer_id = order_source.customer_id 
LEFT JOIN {{ ref('dim_date') }} d ON d.date_day = CAST(order_source.order_timestamp AS DATE)
LEFT JOIN {{ ref('dim_promotional_campaign') }} c ON c.campaign_id = ol.campaign_id 