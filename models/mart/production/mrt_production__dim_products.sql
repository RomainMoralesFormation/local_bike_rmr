WITH product_details_enriched as (
    SELECT
        *
        ,ntile(100) over(order by price desc) as price_segment_percentile
    FROM {{ ref('int_production__product_details') }}
)
SELECT 
     product_id
    ,product_name
    ,model_year
    ,price
    ,category_name
    ,brand_name
    ,product_market
    ,case
        when price_segment_percentile <= 3 then 'Elite Range'
        when price_segment_percentile <= 20 then 'High end'
        when price_segment_percentile <= 50 then 'Mid-range'
        else 'Entry Level'
    end as price_segment
FROM product_details_enriched