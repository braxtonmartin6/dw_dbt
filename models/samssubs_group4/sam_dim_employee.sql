{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['employeeid', 'employeefname']) }} as employeekey,
employeeid,
employeefname,
employeelname,
employeebday
FROM {{ source('samssubs_landing', 'employee') }}