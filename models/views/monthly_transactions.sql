WITH transactions AS(
    SELECT * FROM {{ ref("neo_bank_transactions_by_users") }}
)

SELECT
    -- Count of distinct users that made a transaction during a given month (using GROUP BY to do so)
    COUNT(DISTINCT user_id) AS users_that_made_transaction,
    DATETIME_TRUNC(transaction_date,MONTH) AS transaction_year_month
FROM transactions
GROUP BY transaction_year_month