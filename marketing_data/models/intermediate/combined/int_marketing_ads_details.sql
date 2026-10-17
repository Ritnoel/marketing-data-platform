{{ config(materialized='view') }}

select ad_id, ad_group_id, campaign_id, ad_name, ad_group_name, campaign_name, channel_name, ad_detail_updated_at, platform
from {{ ref('int_facebook_ads_details') }}
union all
select ad_id, ad_group_id, campaign_id, ad_name, ad_group_name, campaign_name, channel_name, ad_detail_updated_at, platform
from {{ ref('int_snapchat_ads_details') }}