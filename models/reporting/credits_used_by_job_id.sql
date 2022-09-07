
select * 
from {{ metrics.calculate(
    metric('credits_used'),
    grain='day',
    dimensions=['dbt_job_id'],
) }}