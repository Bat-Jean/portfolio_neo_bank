WITH account_creations AS(
    SELECT * FROM {{ ref("monthly_account_creations") }}
)

SELECT
    creation_month,
    --Cumulative sum of new users
    SUM(users_creation_month) OVER (ORDER BY creation_month) AS cumulative_users
FROM account_creations