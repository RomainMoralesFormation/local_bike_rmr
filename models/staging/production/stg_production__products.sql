SELECT
  product_id,
  product_name,
  brand_id,
  category_id,
  model_year,
  list_price as price
FROM {{source('local_bike_production', 'products')}}