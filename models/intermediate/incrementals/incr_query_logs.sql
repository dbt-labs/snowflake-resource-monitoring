
{{
    config(
        materialized='incremental',
        unique_key='query_id',
        incremental_strategy='delete+insert',
        on_schema_change='sync_all_columns'
    )
}}


select start_time::date as dt, * 
from {{ ref('stg_query_logs') }}
{% if is_incremental() %}
where start_time::date > (select max(dt) from {{this}} )
{% endif %}