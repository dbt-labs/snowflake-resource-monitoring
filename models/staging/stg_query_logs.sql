with source_data as (
    select query_id,
       database_name,
       schema_name,
       query_type,
       user_name,
       role_name,
       warehouse_name,
       warehouse_size,
       warehouse_type,
       query_tag,       
       case when check_json(query_tag) is null then parse_json(query_tag) else 'error' end as query_tag_json,
       execution_status,
       start_time,
       end_time,
       total_elapsed_time,
       bytes_scanned,
       percentage_scanned_from_cache,
       bytes_written,
       bytes_written_to_result,
       bytes_read_from_result,
       rows_produced,
       rows_inserted,
       rows_updated,
       rows_deleted,
       rows_unloaded,
       partitions_scanned,
       partitions_total,
       compilation_time,
       execution_time,
       credits_used_cloud_services as credits_used
from {{source('costexplorer_snowflake', 'query_history')}}
)

select json_extract_path_text(query_tag_json, 'dbt_environment_name') as dbt_environment_name,
       json_extract_path_text(query_tag_json, 'dbt_model_name') as dbt_model_name,
       json_extract_path_text(query_tag_json, 'dbt_materialization_type') as dbt_materialization_type,
       json_extract_path_text(query_tag_json, 'dbt_job_id') as dbt_job_id,
       json_extract_path_text(query_tag_json, 'dbt_run_id') as dbt_run_id,
       json_extract_path_text(query_tag_json, 'dbt_run_reason') as dbt_run_reason,
       json_extract_path_text(query_tag_json, 'dbt_project_name') as dbt_project_name,
       json_extract_path_text(query_tag_json, 'dbt_user_name') as dbt_user_name,
       json_extract_path_text(query_tag_json, 'dbt_incremental_full_refresh') as dbt_incremental_full_refresh,
       *
from   source_data
where  1=1
and    query_tag_json != 'error'