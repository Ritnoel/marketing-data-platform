{{ config(materialized='view') }}

with all_ads as (
    select *
    from {{ ref('stg_facebook_ads') }}
    qualify row_number() over (
        partition by ad_id
        order by ad_updated_at desc
    ) = 1
),

ad_groups as (
    select *
    from {{ ref('stg_facebook_adgroup') }}
    qualify row_number() over (
        partition by ad_group_id
        order by ad_group_updated_at desc
    ) = 1
),

all_campaigns as (
    select *
    from {{ ref('stg_facebook_campaign') }}
    qualify row_number() over (
        partition by campaign_id
        order by campaign_updated_at desc
    ) = 1
),

join_all_details as (
    select
        all_ads.ad_id,
        all_ads.ad_group_id,
        all_ads.campaign_id,
        all_ads.ad_name,
        ad_groups.ad_group_name,
        all_campaigns.campaign_name,
        greatest(
            all_ads.ad_updated_at,
            ad_groups.ad_group_updated_at,
            all_campaigns.campaign_updated_at
        ) as ad_detail_updated_at
    from all_ads
    left join ad_groups
        on all_ads.ad_group_id = ad_groups.ad_group_id
    left join all_campaigns
        on all_ads.campaign_id = all_campaigns.campaign_id
),

formatted as (
    select
        -- Key
        ad_id,

        -- Foreign keys
        ad_group_id,
        campaign_id,

        -- Details
        ad_name,
        ad_group_name,
        campaign_name,
        'Paid Social' as channel_name,

        -- Metadata
        ad_detail_updated_at,
        'facebook' as platform
    from join_all_details
)

select * from formatted