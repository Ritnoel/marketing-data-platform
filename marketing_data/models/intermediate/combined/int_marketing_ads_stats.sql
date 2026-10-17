{{ config(materialized='view') }}

select ad_id, ad_date, platform, ad_currency_code, ad_spend, ad_impressions, ad_clicks
from {{ ref('int_facebook_ads_stats') }}
union all
select ad_id, ad_date, platform, ad_currency_code, ad_spend, ad_impressions, ad_clicks
from {{ ref('int_snapchat_ads_stats') }}