SELECT
  -- Macro disponible dans le package dbt_utils - Génère un hash MD5 unique au format STRING
 {{ dbt_utils.generate_surrogate_key(['store_id', 'product_id']) }} as sk_stocks,
  store_id,
  product_id,
  quantity
FROM {{source('local_bike_production', 'stocks') }}