{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['storeid', 'zip']) }} as storekey,
storeid,
address,
city,
state,
zip
FROM {{ source('samssubs_landing', 'store') }}