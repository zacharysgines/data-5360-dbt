{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
employee_id as Employee_Key,
employee_id as EmployeeID,
first_name as FirstName,
last_name as LastName,
email as Email,
phone_number as Phone_Number,
hire_date as Hire_Date,
position as Position
FROM {{ source('oliver_landing', 'employee') }}