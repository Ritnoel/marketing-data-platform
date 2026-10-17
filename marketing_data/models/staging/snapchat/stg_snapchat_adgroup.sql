/*
    Tables
*/
WITH source_data AS (
    SELECT * FROM {{ source('snapchat_ads', 'snapchat_ads_adgroup_history_new_ad_group_names') }}
),
/*
    Transformations
*/
formatted AS (
    SELECT
        -- FK
        CAST(_surrogate_key AS STRING) AS _surrogate_key,
        CAST(ad_group_id AS STRING) AS ad_group_id,
        CAST(campaign_id AS STRING) AS ad_campaign_id,
        -- Details
        CAST(ad_group_name AS STRING) AS ad_group_name,
        -- Metadata
        CAST(ad_group_updated_at AS TIMESTAMP) AS ad_group_updated_at
    FROM
        source_data
)
SELECT * FROM formatted