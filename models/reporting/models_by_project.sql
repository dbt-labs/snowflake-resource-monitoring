    select dbt_model_name, dbt_project_name
    from   {{ref('incr_query_logs')}}
    where  dbt_environment_name = 'production'
    group by 1,2