{% macro set_query_tag() -%}
  {# --TODO: extend this for tests once new test PR is merged #}
  {% set dbt_environment_name = env_var('DBT_CLOUD_ENVIRONMENT_NAME', 'not set') %}
  {% set dbt_project_name = project_name %}
  {% set dbt_job_id = env_var('DBT_CLOUD_JOB_ID', 'not set') %}
  {% set dbt_run_id = env_var('DBT_CLOUD_RUN_ID', 'not set') %}
  {% set dbt_run_reason = env_var('DBT_CLOUD_RUN_REASON', 'development_and_testing') %}
  {% set dbt_user_name = target.user %}
  {% set dbt_model_name = model.name %} 
  
  {% if dbt_model_name %}
    
    {% set new_query_tag = '{"dbt_project_name": "%s", "dbt_user_name": "%s", "dbt_model_name": "%s", "dbt_environment_name": "%s", "dbt_job_id": "%s", "dbt_run_id": "%s", "dbt_run_reason": "%s"}'
      |format(dbt_project_name,
              dbt_user_name,
              dbt_model_name, 
              dbt_environment_name,
              dbt_job_id,
              dbt_run_id,
              dbt_run_reason) %}
    {% set original_query_tag = get_current_query_tag() %}
    {{ log("Setting query_tag to '" ~ new_query_tag ~ "'. Will reset to '" ~ original_query_tag ~ "' after materialization.") }}
    {% do run_query("alter session set query_tag = '{}'".format(new_query_tag)) %}
    {{ return(original_query_tag)}}
  
  {% endif %}
  
  {{ return(none)}}

{% endmacro %}