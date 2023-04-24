{{ config(severity="warn") }}

select *
from {{ ref("incremental_full_refreshes") }}
where queries_run > {{ var("incremental_full_refresh_per_period_limit") }}
