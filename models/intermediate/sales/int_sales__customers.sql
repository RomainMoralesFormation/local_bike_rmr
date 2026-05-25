SELECT 
    customer_id,
    city,
    state,
    zip_code,
    -- Appel de la macro en lui passant la liste des colonnes textuelles à surveiller
    {{ check_any_null(['first_name', 'last_name', 'phone', 'email', 'street', 'zip_code', 'city', 'state']) }} as has_missing_info
FROM {{ ref('stg_sales__customers') }}