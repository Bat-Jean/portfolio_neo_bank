SELECT
    -- Key
    transaction_id,
    -- FKey
    user_id,
    -- cast to datetime
    CAST(created_date AS DATETIME) AS transaction_date,
    -- transactions type & direction contatenated
    CONCAT(transactions_type," ",direction) AS transaction_type,
    -- aliases
    transactions_currency AS transaction_currency,
    amount_usd AS trasaction_amount_usd,
    transactions_state AS transaction_state,
FROM `portfolio_neo_bank.transactions`