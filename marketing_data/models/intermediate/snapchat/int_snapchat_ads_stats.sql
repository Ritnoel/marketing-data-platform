-- {{ config(materialized='view') }}

-- select ad_detail_id as ad_id, 
--        ad_spend, 
--        ad_impressions, 
--        ad_clicks, 
--        ad_currency_code, 
--        ad_date
-- from {{ ref('stg_snapchat_ads_stats') }}


{{ config(materialized='view') }}

select
    ad_detail_id as ad_id,
    ad_date,
    'snapchat' as platform,
    ad_currency_code,
    sum(ad_spend) as ad_spend,
    sum(ad_impressions) as ad_impressions,
    sum(ad_clicks) as ad_clicks
from {{ ref('stg_snapchat_ads_stats') }}
group by
    ad_detail_id,
    ad_date,
    ad_currency_code