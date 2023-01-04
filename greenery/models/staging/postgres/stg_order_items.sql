{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id as order_fk,
    product_id as product_fk,
    quantity
FROM {{ source('postgres', 'order_items') }}