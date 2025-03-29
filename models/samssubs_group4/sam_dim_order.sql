{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['ordernumber', 'ordermethod']) }} AS orderkey,
    ordernumber,
    ordermethod
FROM {{ source('samssubs_landing', '"ORDER"') }}