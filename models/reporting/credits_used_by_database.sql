
select * 
from {{ metrics.calculate(
    metric('credits_used'),
    grain='day',
    dimensions=['database_name'],
) }}