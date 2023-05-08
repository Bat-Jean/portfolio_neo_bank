-- Creating a table of transactions aggregated by users, even users without transactions made

{{
    config(
        materialized="table"
    )
}}

WITH transactions AS(
    SELECT * FROM {{ ref("neo_bank_transactions_by_users") }}
)

SELECT
    user_id,
    user_age,
    user_country,
    account_creation_date,
    user_plan,
    crypto_user,
    contacts,
    referral_success,
    COUNT(transaction_id) AS sum_transactions
FROM transactions

GROUP BY user_id, user_age, user_country, account_creation_date, user_plan, crypto_user, contacts, referral_success