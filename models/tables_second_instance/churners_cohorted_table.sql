{{
    config(
        materialized = "table"
    )
}}

WITH last_transaction AS (
    SELECT * FROM {{ ref("last_transaction_with_aggregation") }}
)

SELECT
    user_id,
    sum_transactions,
    presence_days,
    ROUND(sum_transactions/presence_days, 2) AS avg_transactions_by_presence_days,
    DATETIME_DIFF("2019-04-30", last_transaction_date, DAY) AS number_of_days_without_activity,
    CASE   
        WHEN DATETIME_DIFF("2019-04-30", last_transaction_date, DAY) BETWEEN 30 AND 59 THEN "One month"
        WHEN DATETIME_DIFF("2019-04-30", last_transaction_date, DAY) BETWEEN 60 AND 89 THEN "Two months"
        WHEN DATETIME_DIFF("2019-04-30", last_transaction_date, DAY) >= 90 THEN "Three months or more"
    ELSE NULL
    END AS last_activity,
    CASE
        WHEN presence_days BETWEEN 1 AND 7 THEN "One week presence"
        WHEN presence_days BETWEEN 8 AND 30 THEN "One month presence"
        WHEN presence_days > 30 THEN "More than one month presence"
    ELSE NULL
    END AS presence_days_cohorts
FROM last_transaction
WHERE Active_user = "Not Active"

