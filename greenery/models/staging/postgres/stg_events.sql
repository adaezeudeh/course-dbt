{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    user_id as user_fk,
    page_url,
    created_at,
    event_type,
    order_id as order_fk,
    product_id as product_fk
FROM {{ source('postgres', 'events') }}