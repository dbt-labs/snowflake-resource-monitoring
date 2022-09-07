{% macro set_query_tag() -%}
  {# --TODO: extend this for tests once new test PR is merged #}

  {# -- These are built in dbt Cloud environment variables you can leverage to better understand your runs usage data #}
  {% set dbt_job_id = env_var('DBT_CLOUD_JOB_ID', 'not set') %}
  {% set dbt_run_id = env_var('DBT_CLOUD_RUN_ID', 'not set') %}
  {% set dbt_run_reason = env_var('DBT_CLOUD_RUN_REASON', 'development_and_testing') %}

  {# -- These are built in to dbt Core #}
  {% set dbt_project_name = project_name %}
  {% set dbt_user_name = target.user %}
  {% set dbt_model_name = model.name %}
  {% set dbt_materialization_type = model.config.materialized %}
  {% set dbt_incremental_full_refresh = 'false' %}
  {% set dbt_environment_name = target.name %}

  {% if dbt_materialization_type == 'incremental' and should_full_refresh() %}
     {% set dbt_incremental_full_refresh = 'true' %}
  {% endif %}

  {% if dbt_model_name %}
    
    {% set new_query_tag = '{"dbt_environment_name": "%s", "dbt_job_id": "%s", "dbt_run_id": "%s", "dbt_run_reason": "%s", "dbt_project_name": "%s", "dbt_user_name": "%s", "dbt_model_name": "%s", "dbt_materialization_type": "%s", "dbt_incremental_full_refresh": "%s"}'
      |format(dbt_environment_name,
              dbt_job_id,
              dbt_run_id, 
              dbt_run_reason,
              dbt_project_name,
              dbt_user_name,
              dbt_model_name,
              dbt_materialization_type,
              dbt_incremental_full_refresh) %}
    {% set original_query_tag = get_current_query_tag() %}
    {{ log("Setting query_tag to '" ~ new_query_tag ~ "'. Will reset to '" ~ original_query_tag ~ "' after materialization.") }}
    {% do run_query("alter session set query_tag = '{}'".format(new_query_tag)) %}
    {{ return(original_query_tag)}}
  
  {% endif %}
  
  {{ return(none)}}

{% endmacro %}