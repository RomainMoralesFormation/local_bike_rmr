SELECT
  -- Macro disponible dans le package dbt_utils - Génère un hash MD5 unique au format STRING
 {{ dbt_utils.generate_surrogate_key(['order_id', 'item_id']) }} as sk_order_items,
  order_id,
  item_id,
  list_price as unit_price,
  product_id,
  quantity as quantity_ordered,
  discount
FROM {{ source('local_bike_sales', 'order_items') }}