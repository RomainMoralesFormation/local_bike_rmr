SELECT
     oi.sk_order_items
    ,oi.order_id
    ,o.customer_id
    ,oi.product_id
    ,o.store_id
    ,o.staff_id
    ,o.order_date
    ,o.shipped_date
    ,oi.quantity_ordered
    ,oi.gross_amount
    ,oi.is_discount
    ,oi.discount_amount
    ,oi.net_amount

FROM {{ ref('int_sales__order_items_amount') }} oi
-- Récupération des données globales liées à la commande
LEFT JOIN {{ ref('int_sales__orders_metric') }} o
    ON oi.order_id = o.order_id