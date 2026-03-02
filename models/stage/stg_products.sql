{{ config(
    materialized = 'table'
) }}

SELECT
    $1::INT              AS product_sku,
    $2::VARCHAR(150)     AS product_name,
    $3::DECIMAL(10,2)    AS unit_price,
    CURRENT_TIMESTAMP()  AS created_at,
    CURRENT_TIMESTAMP()  AS updated_at
FROM @raw_stg/products.csv.gz
(FILE_FORMAT => my_csv_format);