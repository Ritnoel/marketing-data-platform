{{
    config(
        event_time='ad_date',
    )
}}

/*
    Tables
*/

WITH source_data AS (

    SELECT * FROM {{ source('snapchat_ads', 'snapchat_ads_stats') }}

),

/*
    Transformations
*/

formatted AS (

    SELECT
        -- FK
        CAST(ad_detail_id AS STRING) AS ad_detail_id,

        -- Measures
        CAST(ad_spend AS DOUBLE) AS ad_spend,
        TRY_CAST(ad_impressions AS INTEGER) AS ad_impressions,
        TRY_CAST(ad_clicks AS INTEGER) AS ad_clicks,
        CAST(ad_currency_code AS STRING) AS ad_currency_code,
        CAST(ad_country AS STRING) AS ad_country,
        CAST(data_src AS STRING) AS data_src,

        -- Metadata
        CAST(ad_date AS DATE) AS ad_date
    FROM
        source_data
)

SELECT * FROM formatted

