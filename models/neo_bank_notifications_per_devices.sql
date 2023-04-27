WITH devices AS (
    SELECT * FROM {{ ref("neo_bank_devices")}}
),

notifications AS(
    SELECT * FROM {{ ref("neo_bank_notifications")}}
)

SELECT
    -- Key
    n.user_id,
    -- device
    d.device_name,
    -- notifications
    n.nofification_name,
    n.notification_date,
    n.notification_channel,
    n.notification_status

FROM notifications n
JOIN devices d ON d.user_id = n.user_id

