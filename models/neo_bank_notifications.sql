SELECT
    -- Key
    user_id,
    -- notification name
    reason AS nofification_name,
    channel AS notification_channel,
    status AS notification_status,
    -- created_date from TIMESTAMP TO DATETIME
    CAST(created_date AS DATETIME) AS notification_date
FROM `portfolio_neo_bank.notifications`