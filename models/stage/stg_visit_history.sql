{{ config(
    materialized = 'table'
) }}

SELECT
    $1::INT              AS customer_id,
    $2::INT              AS channel_id,
    $3::TIMESTAMP_NTZ    AS visit_timestamp,
    $4::TIMESTAMP_NTZ    AS bounce_timestamp,
    CURRENT_TIMESTAMP()  AS created_at,
    CURRENT_TIMESTAMP()  AS updated_at
FROM @raw_stg/visitHistory.csv.gz
(FILE_FORMAT => my_csv_format);