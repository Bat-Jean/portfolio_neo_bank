WITH transactions_users AS (
    SELECT * FROM {{ ref("neo_bank_transactions_by_users")}}
)

SELECT
    user_id,
    MAX(transaction_date) AS last_transaction_date
FROM transactions_users
GROUP BY user_id
