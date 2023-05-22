{{
    config(
        materialized="table" 
    )
}}
-- Table with all transactions for cohorted users

WITH transactions AS (
    SELECT * FROM {{ ref("all_transactions") }}
),

cohorts AS (
    SELECT * FROM {{ ref("churners_cohorted_table") }}
)

SELECT
    t.user_id,
    t.transaction_id,
    t.transaction_date,
    t.transaction_type,
    t.transaction_amount_usd,
    t.transaction_state,
    c.presence_days_cohorts,
    c.presence_days
FROM transactions t
JOIN cohorts c ON t.user_id = c.user_id