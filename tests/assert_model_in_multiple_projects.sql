

with base as (
   select * from {{ref('models_by_project')}}
),

final as (
    select *, row_number() over (partition by dbt_model_name order by dbt_project_name) as row_num
    from   base 
)

select * from final where row_num > 1