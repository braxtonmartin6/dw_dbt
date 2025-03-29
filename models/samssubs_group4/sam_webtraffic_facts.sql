{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT
    d.date_key,
    e.eventtypekey,
    t.traffickey,
    COUNT(*) AS total_interactions
FROM {{ source('samssubs_landing2', 'web_traffic_events') }} wte
INNER JOIN {{ ref('sam_dim_date') }} d ON d.date_day = TO_DATE(wte.event_timestamp)
INNER JOIN {{ ref('sam_dim_eventtype') }} e ON e.event_name = wte.event_name
INNER JOIN {{ ref('sam_dim_traffic') }} t on t.traffic_source = wte.traffic_source
GROUP BY ALL