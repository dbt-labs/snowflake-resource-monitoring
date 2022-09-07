
select * from {{ ref('credits_used_by_model_name') }} where credits_used > {{ var('model_credit_limit') }}