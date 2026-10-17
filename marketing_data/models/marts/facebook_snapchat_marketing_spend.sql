{{ config(materialized='table') }}

select 
    details.ad_id, 
    ad_group_id, 
    campaign_id, 
    campaign_name, 
    ad_name, 
    ad_group_name, 
    channel_name, 
    ad_detail_updated_at, 
    details.platform, 
    ad_currency_code, 
    ad_spend, 
    ad_impressions, 
    ad_clicks, 
    ad_date
from {{ ref('int_marketing_ads_stats') }} as stats
left join {{ ref('int_marketing_ads_details') }}  as details
on details.ad_id = stats.ad_id and details.platform = stats.platform