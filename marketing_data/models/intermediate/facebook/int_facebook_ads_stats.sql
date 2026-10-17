-- {{ config(materialized='view') }}

-- select facebook_stats.ad_id, 
--        facebook_stats.ad_spend, 
--        facebook_stats.ad_impressions, 
--        facebook_stats.ad_clicks, 
--        facebook_acc.ad_currency_code, 
--        facebook_stats.ad_date
-- from {{ ref('stg_facebook_ads_stats') }} as facebook_stats
-- join {{ ref('stg_facebook_account') }}  as facebook_acc
--     on facebook_stats.account_id = facebook_acc.account_id

{{ config(materialized='view') }}

with account_details as (
    select *
    from {{ ref('stg_facebook_account') }}
    qualify row_number() over (
        partition by account_id
        order by account_updated_at desc
    ) = 1
)

select
    stats.ad_id,
    stats.ad_date,
    'facebook' as platform,
    account_details.ad_currency_code,
    stats.ad_spend,
    stats.ad_impressions,
    stats.ad_clicks
from {{ ref('stg_facebook_ads_stats') }} as stats
left join account_details
    on stats.account_id = account_details.account_id