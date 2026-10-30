{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    d.Date_Key,
    e.Employee_Key,
    ec.certification_name,
    ec.certification_cost
    
from {{ ref('stg_employee_certifications') }} ec
INNER JOIN {{ ref('oliver_dim_employee') }} e ON ec.employee_id = e.EmployeeID 
INNER JOIN {{ ref('oliver_dim_date') }} d ON ec.certification_awarded_date = d.date_ID