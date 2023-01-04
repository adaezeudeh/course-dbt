{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id,
    user_id as user_fk,
    promo_id as promo_fk,
    address_id as address_fk,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
FROM {{ source('postgres', 'orders') }}