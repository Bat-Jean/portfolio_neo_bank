{{ 
    config (
        materialized = "table"
    )
}}

WITH transactions AS(
    SELECT * FROM {{ ref("neo_bank_transactions") }}
)

SELECT
    -- PK
    user_id,
    transaction_id,
    transaction_date,
    transaction_type,
    transaction_currency,
    -- Name wasn't written correctly before
    trasaction_amount_usd AS transaction_amount_usd,
    transaction_state
FROM transactions

    
