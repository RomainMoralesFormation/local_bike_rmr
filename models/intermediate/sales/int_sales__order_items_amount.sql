SELECT
  sk_order_items,
  order_id,
  item_id,
  product_id,
  quantity_ordered,
  unit_price,
  discount,
  -- Chiffre d'affaires théorique / brut
  quantity_ordered * unit_price as gross_amount,
  -- Flag indiquant si une rmeise a été accordée
  case when discount > 0 then 1 else 0 end as is_discount,
  -- Montant de la réduction accordée
  round(quantity_ordered * unit_price * discount, 2) as discount_amount,
  -- Chiffre d'affaires net de la remise commerciale
  round(quantity_ordered * unit_price * (1 - discount), 2) as net_amount
  
FROM {{ ref('stg_sales__order_items') }}