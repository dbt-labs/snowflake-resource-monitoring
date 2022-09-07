{% macro generate_single_dim_over_time(table_name, dim_column_name, metric_column_name, date_column_name) %}
  {% set sql %}
with base as (

select {{dim_column_name}},
        {{date_column_name}},
        sum({{metric_column_name}}) as {{metric_column_name}}
from   {{table_name}}
group by 1,2
),

final as (
    select *, 
           sum({{metric_column_name}}) over (partition by {{dim_column_name}} order by {{date_column_name}}) as {{metric_column_name}}_cumulative
    from base
)

select * from final

  {% endset %}

  {{return(sql)}}

{% endmacro %}