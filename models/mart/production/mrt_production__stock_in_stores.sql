SELECT
    sk_stocks,
    store_id,
    store_name,
    store_city,
    store_state,
    product_id,
    available_stock_quantity,
    stock_status -- améliorer le calcul du stock pour prendre en compte les volumes vendus
FROM {{ ref('int_production__stock_in_stores') }}