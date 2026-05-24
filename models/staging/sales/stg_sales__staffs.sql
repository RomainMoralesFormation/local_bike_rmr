SELECT
  active,
  email,
  first_name,
  last_name,
  manager_id,
  phone,
  staff_id,
  store_id
FROM {{ source('local_bike_sales', 'staffs') }}
