

select dt,
       dbt_model_name,
       dbt_project_name,
       dbt_environment_name,
       user_name,
       count(*) as queries_run 
from   {{ ref('incr_query_logs') }}
where  dbt_materialization_type = 'incremental'
and    dbt_incremental_full_refresh = True 
group by 1,2,3,4,5