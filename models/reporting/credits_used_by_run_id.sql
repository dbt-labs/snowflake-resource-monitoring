with runs_data as (

    select * 
    from {{ metrics.calculate(
        metric('credits_used'),
        grain='day',
        dimensions=['dbt_run_id'],
    ) }}

),

final as (
    select r.*, d.dbt_job_id 
    from   runs_data r 
    join {{ ref('dim_runs') }} d 
      on r.dbt_run_id = d.dbt_run_id
)

select * from final 