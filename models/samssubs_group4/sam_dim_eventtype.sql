{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['event_name']) }} as eventtypekey,
event_name
FROM {{ source('samssubs_landing2', 'web_traffic_events') }}