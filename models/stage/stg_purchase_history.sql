{{ config(
    materialized = 'table'
) }}

SELECT
    $1::INT              AS customer_id,
    $2::INT              AS product_sku,
    $3::INT              AS channel_id,
    $4::INT              AS quantity,
    $5::DECIMAL(10,2)    AS discount,
    $6::TIMESTAMP_NTZ    AS order_date,
    CURRENT_TIMESTAMP()  AS created_at,
    CURRENT_TIMESTAMP()  AS updated_at
FROM @raw_stg/purchaseHistory.csv.gz
(FILE_FORMAT => my_csv_format);