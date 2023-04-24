select *
from {{ ref("stg_query_logs") }}
where
    start_time > dateadd(minute, -60, current_timestamp)
    and dbt_user_name = '{{target.user}}'
order by start_time desc
limit 10
;
