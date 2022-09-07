with source as (

          select * 
          from {{ source('costexplorer_snowflake', 'warehouse_metering_history') }}
          where    start_time >= current_date - {{var('lookback_days', 30)}}

      ),

      renamed as (

          select
             START_TIME as starttime,
             END_TIME as endtime,
             WAREHOUSE_ID,
             WAREHOUSE_NAME,
             CREDITS_USED,
             CREDITS_USED_COMPUTE as compute_credit,
             CREDITS_USED_CLOUD_SERVICES as cloud_credit

          from source

      )

      select * from renamed