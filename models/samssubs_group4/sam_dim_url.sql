{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['page_url']) }} as urlkey,
page_url
FROM {{ source('samssubs_landing2', 'web_traffic_events') }}