select dbt_model_name,
       dbt_job_id,
       dbt_run_id,
       dbt_environment_name,
       dbt_project_name,
       start_time,
       execution_time,
       credits_used
from   {{ref('incr_query_logs')}}
where user_name = 'MATT_W'
and   start_time >= current_date