{{
    config (
        materialized = "table"
    )
}}

WITH last_transaction AS (
    SELECT * FROM {{ ref("last_transaction_id") }}
),

transactions_agg AS(
    SELECT * FROM {{ ref("transactions_users_agg_users_only") }}
)

SELECT
    l.user_id,
    l.account_creation_date,
    t.user_age,
    t.user_country,
    t.user_plan,
    t.crypto_user,
    l.last_transaction_date,
    l.transaction_id,
    l.transaction_type,
    l.transaction_state,
    t.sum_transactions,
    DATETIME_DIFF(l.last_transaction_date, l.account_creation_date, DAY) +1 AS presence_days,
    CASE
        WHEN DATETIME_DIFF("2019-04-30", l.last_transaction_date, DAY) <= 30 THEN "Active"
        WHEN DATETIME_DIFF("2019-04-30", l.last_transaction_date, DAY) > 30 THEN "Not Active"
    ELSE NULL
    END AS Active_user
FROM last_transaction l
JOIN transactions_agg t ON l.user_id = t.user_id

