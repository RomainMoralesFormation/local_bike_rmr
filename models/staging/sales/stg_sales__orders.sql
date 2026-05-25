SELECT
  customer_id,
  order_date,
  order_id,
  order_status,
  required_date,
  safe_cast(shipped_date as date) as shipped_date,
  staff_id,
  store_id
FROM {{ source('local_bike_sales', 'orders') }}