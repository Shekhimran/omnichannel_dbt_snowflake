{{ config(
    materialized = 'table'
) }}

SELECT
    $1::INT              AS channel_id,
    $2::VARCHAR(150)     AS channel_name,
    CURRENT_TIMESTAMP()  AS created_at,
    CURRENT_TIMESTAMP()  AS updated_at
FROM @raw_stg/channels.csv.gz
(FILE_FORMAT => my_csv_format);