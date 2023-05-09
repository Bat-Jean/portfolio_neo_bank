{{ config (
    materialized = "table"
)
}}

WITH notifications AS (
    SELECT * FROM {{ ref("neo_bank_notifications_per_devices") }}
),

users AS (
    SELECT * FROM {{ ref("neo_bank_transactions_by_users")}}
)

SELECT
    --PK
    n.user_id,
    --Notifications
    n.device_name AS device,
    n.nofification_name AS name,
    n.notification_channel AS channel,
    n.notification_status AS status,
    n.notification_date AS date,
    -- users and what they allowed notification wise
    u.user_age,
    u.user_country,
    u.user_plan,
    u.push_activated,
    u.email_activated
FROM notifications n
JOIN users u ON n.user_id = u.user_id
