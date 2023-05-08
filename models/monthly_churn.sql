{{
    config (
        materialized = "table"
    )
}}

WITH account_creation AS(
    SELECT * FROM {{ ref ("monthly_account_creations") }}
),

monthly_transactions AS (
    SELECT * FROM {{ ref("monthly_transactions") }}
),

cumulative_users AS (
    SELECT * FROM {{ ref("cumulative_users") }}
)

SELECT
    -- Year_month
    t.transaction_year_month AS year_month,
    -- New users
    c.users_creation_month AS new_users,
    -- Users that made a transaction during a given month
    t.users_that_made_transaction AS made_transaction,
    -- Cumulative users: MTD
    cu.cumulative_users,
    -- Percentage of users who made a transaction during a given month
    ROUND(t.users_that_made_transaction / cu.cumulative_users, 2)*100 AS active_users,
    -- Percentage of users that made no transaction during a given month
    100 - (ROUND(t.users_that_made_transaction / cu.cumulative_users, 2)*100) AS churners
FROM account_creation c
INNER JOIN monthly_transactions t ON c.creation_month = t.transaction_year_month
INNER JOIN cumulative_users cu ON c.creation_month = cu.creation_month
ORDER BY year_month
    