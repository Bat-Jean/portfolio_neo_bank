WITH notifications AS (
    SELECT * FROM {{ ref("neo_bank_notifications_per_devices") }}
),

users AS (
    SELECT * FROM {{ ref("neo_bank_users") }}
)

SELECT
    n.user_id,
    n.nofification_name AS notification_name,
    n.notification_date,
    n.notification_channel,
    n.notification_status,
    n.device_name,
    u.email_activated,
    u.push_activated,
FROM notifications n
JOIN users u ON n.user_id = u.user_id