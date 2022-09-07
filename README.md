Welcom to the Snowflake Resource Monitoring Project!

NOTE: This is Snowflake-only at present (with a thought on how to extend to other warehouses :) ) 

### Background

Monitoring data warehouse utilization levels becomes a key consideration as analytics organizations mature and grow. In dbt, the [snowflake spend](https://hub.getdbt.com/gitlabhq/snowflake_spend/latest/) package has gained some traction as an approach for doing this. Snowflake spend is great for 
analyzing workloads according to database, schema, user and warehouse. However, to really identify potential bottlenecks and areas for improvement, it's useful to go deeper by understanding the trends in model run times, configuration, user behavior in development vs. production environments, etc.

### Setup

Add the macro code from `config/set_query_tag.sql` to dbt Snowflake projects you want to monitor. This version of the package uses some dbt Cloud specific environment variables:

- DBT_CLOUD_JOB_ID
- DBT_CLOUD_RUN_ID
- DBT_CLOUD_RUN_REASON

### Potential Future Directions: 
- Make this approach generic across Data Warehouses by logging the models and test runs in an `on-run-end` hook + macro.
- Build additional reporting and pre-canned alerts
- Implement anomaly detection on usage reporting time series (dbt Python models)
- 