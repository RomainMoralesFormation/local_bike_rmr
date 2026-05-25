SELECT
    stk.store_id,
    str.store_name,
    str.city as store_city,
    str.state as store_state,
    stk.product_id,
    stk.quantity as available_stock_quantity,
    -- Alerte opérationnelle de rupture de stock
    case 
        when stk.quantity = 0 then 'Rupture totale'
        when stk.quantity <= 5 then 'Stock critique'
        else 'Stock suffisant'
    end as stock_status
FROM {{ ref('stg_production__stocks') }} stk
-- Récupération des informations relatives aux boutiques
JOIN {{ ref('stg_sales__stores') }} str 
    ON stk.store_id = str.store_id