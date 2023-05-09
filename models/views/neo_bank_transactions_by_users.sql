WITH transactions AS(
    SELECT * FROM {{ ref("neo_bank_transactions")}}
),

users AS (
    SELECT * FROM {{ ref("neo_bank_users")}}
)

SELECT
    --Key
    u.user_id,
    --Users table
    u.user_age,
    u.user_country,
    u.account_creation_date,
    u.user_plan,
    u.crypto_user,
    u.contacts,
    u.referral_success,
    u.email_activated,
    u.push_activated,

    --Transactions table
    t.transaction_id,
    t.transaction_date,
    t.transaction_type,
    t.trasaction_amount_usd AS transaction_amount_usd,
    t.transaction_state
FROM users u
    --Making a LEFT JOIN in order to have users who never made a transaction
LEFT JOIN transactions t ON u.user_id = t.user_id