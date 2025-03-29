{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['p.productid', 'p.productname']) }} as productkey,
p.productid,
p.producttype,
p.productname,
p.productcalories,
p.productcost,
s.length,
s.breadtype
FROM {{ source('samssubs_landing', 'product') }} as p JOIN {{ source('samssubs_landing', 'sandwich') }} as s ON p.productid = s.productid