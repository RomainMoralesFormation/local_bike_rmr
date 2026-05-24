SELECT
  city,
  email,
  phone,
  state,
  store_id,
  store_name,
  street,
  zip_code
FROM {{ source('local_bike_sales', 'stores') }}