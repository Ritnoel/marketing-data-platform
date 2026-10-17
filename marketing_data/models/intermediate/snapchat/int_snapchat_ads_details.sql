{{ config(materialized='view') }}

with ads as (
    select * from {{ ref('stg_snapchat_ads') }}
),

ad_groups as (
    select *
    from {{ ref('stg_snapchat_adgroup') }}
    qualify row_number() over (
        partition by ad_group_id
        order by ad_group_updated_at desc
    ) = 1
),

campaigns as (
    select * from {{ ref('stg_snapchat_campaign') }}
),

join_all_details as (
    select
        ads.ad_id,
        ads.ad_group_id,
        ad_groups.ad_campaign_id as campaign_id,
        ads.ad_name,
        ad_groups.ad_group_name,
        campaigns.campaign_name,
        greatest(
            ads.ad_detail_updated_at,
            ad_groups.ad_group_updated_at
        ) as ad_detail_updated_at
    from ads
    left join ad_groups
        on ads.ad_group_id = ad_groups.ad_group_id
    left join campaigns
        on ad_groups.ad_campaign_id = campaigns.campaign_id
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
        'snapchat' as platform
    from join_all_details
)

select * from formatted