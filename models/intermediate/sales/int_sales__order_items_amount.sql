SELECT
  sk_order_items
  order_id,
  item_id,
  product_id,
  quantity,
  unit_price,
  discount,
  -- Chiffre d'affaires théorique / brut
  quantity * unit_price as gross_amount,
  -- Montant de la réduction accordée
  round(quantity * unit_price * discount, 2) as discount_amount,
  -- Chiffre d'affaires net de la remise commerciale
  round(quantity * unit_price * (1 - discount), 2) as net_amount
FROM {{ref('stg_sales__order_items')}}