{{ config(
    materialized = "table"
) }}

WITH all_transactions AS(
    SELECT * FROM {{ ref("neo_bank_transactions_by_users") }}
)

SELECT
    user_id,
    email_activated,
    push_activated,
    transaction_id,
    transaction_date,
    transaction_type,
    transaction_amount_usd,
    transaction_state
FROM all_transactions
WHERE transaction_id IS NOT NULL
ORDER BY user_id