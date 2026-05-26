SELECT
    s.staff_id,
    staff_full_name,
    is_active_staff,
    store_id,
    manager_id,
    manager_full_name
FROM {{ ref('int_sales__staffs_and_managers') }}