
SELECT
    order_id,
    customer_id,
    store_id,
    staff_id,
    order_status,
    order_date,
    required_date,
    shipped_date,
    -- Délai global constaté entre commande et livraison (si expédié)
    case 
        when shipped_date is not null then date_diff(shipped_date, order_date, day)
    end as days_to_ship,
    -- Écart par rapport à l'engagement client (positif = retard, négatif = avance)
    case 
        when shipped_date is not null then date_diff(shipped_date, required_date, day)
    end as delivery_delay_days,
    -- Statut du délais de livraison
    case 
        when shipped_date is null then 'En attente'
        when shipped_date <= required_date then 'Dans les temps'
        else 'En retard'
    end as status_delivery_times
    
FROM {{ref('stg_sales__orders')}}