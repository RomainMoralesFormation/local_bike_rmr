SELECT
  active,
  email,
  first_name,
  last_name,
  safe_cast(manager_id as int) as manager_id,
  phone,
  staff_id,
  store_id
FROM {{ source('local_bike_sales', 'staffs') }}