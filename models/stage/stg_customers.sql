{{ config(
    materialized = 'table'
) }}

SELECT
    $1::INT              AS customer_id,
    $2::VARCHAR(150)     AS name,
    $3::DATE             AS date_birth,
    $4::VARCHAR(150)     AS email_address,
    $5::VARCHAR(30)      AS phone_number,
    $6::VARCHAR(100)     AS country,
    CURRENT_TIMESTAMP()  AS created_at,
    CURRENT_TIMESTAMP()  AS updated_at
FROM @raw_stg/customers.csv.gz
(FILE_FORMAT => my_csv_format);