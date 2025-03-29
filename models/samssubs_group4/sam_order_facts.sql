{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT
    c.customerkey,
    d.date_key,
    e.employeekey,
    p.productkey,
    s.storekey,
    o.ordernumber,
    od.orderlineqty,
    p.productcost,
    od.pointsearned
FROM {{ source('samssubs_landing', '"ORDER"') }} o
INNER JOIN {{ source('samssubs_landing', 'orderdetails') }} od ON o.ordernumber = od.ordernumber
INNER JOIN {{ ref('sam_dim_customer') }} c ON c.customerid = o.customerid
INNER JOIN {{ ref('sam_dim_employee') }} e ON e.employeeid = o.employeeid
INNER JOIN {{ source('samssubs_landing', 'employee') }} emp on emp.employeeid = e.employeeid
INNER JOIN {{ ref('sam_dim_store') }} s ON s.storeid = emp.storeid 
INNER JOIN {{ ref('sam_dim_date') }} d ON d.date_day = o.orderdate
INNER JOIN {{ ref('sam_dim_product') }} p ON p.productid = od.productid