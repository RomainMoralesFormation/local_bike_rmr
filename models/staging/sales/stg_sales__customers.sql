SELECT
  city,
  customer_id,
  email,
  first_name,
  last_name,
  phone,
  state,
  street,
  zip_code
FROM {{ source('local_bike_sales', 'customers') }}