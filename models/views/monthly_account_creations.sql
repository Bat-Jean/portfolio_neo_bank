WITH account_creations AS(
    SELECT * FROM {{ ref("neo_bank_transactions_by_users") }}
)

SELECT
    COUNT(DISTINCT user_id) AS users_creation_month,
    DATETIME_TRUNC(account_creation_date, MONTH) AS creation_month
FROM account_creations
GROUP BY creation_month
ORDER BY creation_month