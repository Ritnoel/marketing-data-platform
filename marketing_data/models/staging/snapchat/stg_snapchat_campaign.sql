/*
    Tables
*/
WITH source_data AS (
    SELECT * FROM {{ source('snapchat_ads', 'snapchat_ads_campaign_history_new_campaign_names') }}
),
/*
    Transformations
*/
formatted AS (
    SELECT
        -- FK
        CAST(campaign_id AS STRING) AS campaign_id,
        -- Details
        CAST(account_id AS STRING) AS account_id,
        CAST(campaign_name AS STRING) AS campaign_name
        -- Metadata
        
    FROM
        source_data
)
SELECT * FROM formatted

