
WITH 
  total_order as (
    -- Calcul du total par commande
    SELECT 
       order_id
      ,count(distinct order_id) as order_nb_items
      ,sum(gross_amount) as order_gross_amount
      ,max(is_discount) as order_is_discount
      ,sum(discount_amount) as order_discount_amount
      ,sum(net_amount) as order_net_amount
 
    FROM {{ ref('int_sales__order_items_amount') }}
    GROUP BY order_id
    )
  ,borne_date as (
    -- On considère :
      --> la date max de commande de la table comme date max de commande au global
      --> les délais opérationnels moyen entre la commande et la livraison
    SELECT 
       max(order_date) as max_date
      ,avg(days_to_ship) avg_days_to_ship
    FROM {{ ref('int_sales__orders_metric') }}
    )
  ,total_order_enriched as (
    -- Calcul du total par client 
    SELECT
       om.customer_id
      ,count(distinct om.order_id) as total_orders
      ,sum(o.order_nb_items) as total_items
      ,round(sum(o.order_gross_amount), 2) as total_amount
      ,max(o.order_is_discount) as customer_has_discount -- peut-être affiné (nb discount, nbdays since last discount) <!>
      ,round(sum(o.order_discount_amount), 2) as total_discount_amount
      ,round(sum(o.order_net_amount), 2) as total_net_amount
      ,ntile(100) over(order by sum(o.order_net_amount) desc) as net_amount_percentile
      ,max(om.order_date) as last_order_date
      --,om.order_status
      ,avg(om.days_to_ship) as avg_days_to_ship_by_customer -- peut-être analysé plus finement
      ,avg(om.delivery_delay_days) as avg_delivery_delay_days
      --,last_value(om.status_delivery_times) over(partition by om.customer_id order by om.order_date) as last_status_delivery_times

    FROM {{ ref('int_sales__orders_metric') }} om
    -- Récupération du customer_id et des métriques globales de la commande
    LEFT JOIN total_order o
      ON om.order_id = o.order_id

    GROUP BY om.customer_id
    )
SELECT
   customer_id
  ,total_orders
  ,total_items
  ,total_amount
  ,customer_has_discount
  ,total_discount_amount
  ,total_net_amount
  ,date_diff(bd.max_date, last_order_date, month) as months_since_last_order
  ,case
    when net_amount_percentile <= 3 then 'VIP'
    when net_amount_percentile <= 10 then 'Gold'
    when net_amount_percentile <= 20 then 'Silver'
    when net_amount_percentile <= 30 then 'Bronze'
    else 'Classic'
   end as customer_segment
  ,avg_days_to_ship
  ,avg_delivery_delay_days
FROM total_order_enriched
CROSS JOIN borne_date bd