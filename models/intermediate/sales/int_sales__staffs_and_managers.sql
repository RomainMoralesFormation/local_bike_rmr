SELECT
    s.staff_id,
    concat(s.first_name, ' ', s.last_name) as staff_full_name,
    s.active as is_active_staff,
    s.store_id,
    s.manager_id,
    concat(m.first_name, ' ', m.last_name) as manager_full_name
FROM {{ ref('stg_sales__staffs') }} s 
-- Récupération du nom du manager s'il existe
LEFT JOIN {{ ref('stg_sales__staffs') }} m 
    ON s.manager_id = m.staff_id