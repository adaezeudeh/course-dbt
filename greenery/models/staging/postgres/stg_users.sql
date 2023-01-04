{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id as address_fk
FROM {{ source('postgres', 'users') }}