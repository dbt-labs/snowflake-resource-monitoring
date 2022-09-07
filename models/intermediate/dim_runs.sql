{{
    config(
        materialized='table'
    )
}}

select dbt_run_id, dbt_job_id
from   {{ ref('incr_query_logs') }}
where 1=1 
and dbt_job_id is not null
and dbt_job_id != 'not set'
group by 1,2