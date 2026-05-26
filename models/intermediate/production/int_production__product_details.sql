SELECT
    p.product_id,
    p.product_name,
    p.model_year,
    p.price,
    ifnull(c.category_name, 'Catégorie à définir') as category_name,
    ifnull(b.brand_name, 'Marque à définir') as brand_name,
    -- Regroupement par marché pertinent
    -- https://www.unionsportcycle.com/observatoire-du-cycle/chiffres-marche
    case 
        when lower(c.category_name) like any ('%mountain%','%road%') 
            then 'Aventure & Sport'
        when lower(c.category_name) like any ('%cruisers%', '%comfort%', '%children%') 
            then 'Quotidien & Urbain'
        when lower(c.category_name) like any('%cyclocross%', '%electric%')
            then 'Mixte'
        else 'Marché à définir'
    end as product_market
    
FROM {{ref('stg_production__products')}} p

-- Récupération du libellé de la catégories
JOIN {{ref('stg_production__categories')}} c
    on p.category_id = c.category_id

-- Récupération du libellé de la marque
JOIN {{ref('stg_production__brands')}} b
    on p.brand_id = b.brand_id