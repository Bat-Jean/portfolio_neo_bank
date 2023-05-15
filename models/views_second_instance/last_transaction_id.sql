WITH last_transaction_date AS(
    SELECT * FROM {{ ref("last_transaction_date") }}
),

transaction_per_user AS(
    SELECT * FROM {{ ref("neo_bank_transactions_by_users") }}
)

SELECT
    l.user_id,
    t.account_creation_date,
    l.last_transaction_date,
    t.transaction_id,
    t.transaction_type,
    t.transaction_state
FROM last_transaction_date l
JOIN transaction_per_user t ON l.user_id = t.user_id AND l.last_transaction_date = t.transaction_date
GROUP BY l.user_id, t.account_creation_date, l.last_transaction_date, t.transaction_id, t.transaction_type, t.transaction_state