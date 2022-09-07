

with base as (
    select dbt_job_id,
           dt,
           sum(credits_used) as credits_used
    from   {{ref('incr_query_logs')}}
    group by 1,2
),

final as (
    select *, sum(credits_used) over (partition by dbt_job_id order by dt) as credits_used_cumulative
    from base
)

select * from final order by 1,2