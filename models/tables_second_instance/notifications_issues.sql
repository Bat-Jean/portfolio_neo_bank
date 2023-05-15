{{
    config(
        materialized = "table"
    )
}}

WITH notifications AS (
    SELECT * FROM {{ ref("notifications_updated") }}
)

SELECT
    user_id,
    notification_name,
    notification_date,
    notification_channel,
    notification_status,
    device_name,
    email_activated,
    CASE
        WHEN notification_channel = "EMAIL" AND notification_status = "SENT" AND email_activated = "Yes" THEN "emails sent"
        WHEN notification_channel = "EMAIL" AND notification_status = "SENT" AND email_activated = "No" THEN "email sent without consent"
        WHEN notification_channel = "EMAIL" AND notification_status = "FAILED" AND email_activated = "Yes" THEN "email error"
        WHEN notification_channel = "EMAIL" AND notification_status = "FAILED" AND email_activated = "No" THEN "wrong channel used"
        WHEN notification_channel = "EMAIL" AND notification_status = "SENT" AND email_activated = "Missing" THEN "emails desactivated after notification"
        WHEN notification_channel = "EMAIL" AND notification_status = "FAILED" AND email_activated = "Missing" THEN "emails desactivated before notification"
        ELSE "No emails"
        END AS real_email_status,
    push_activated,
    CASE
        WHEN notification_channel = "PUSH" AND notification_status = "SENT" AND email_activated = "Yes" THEN "push sent"
        WHEN notification_channel = "PUSH" AND notification_status = "SENT" AND email_activated = "No" THEN "push sent without consent"
        WHEN notification_channel = "PUSH" AND notification_status = "FAILED" AND email_activated = "Yes" THEN "push error"
        WHEN notification_channel = "PUSH" AND notification_status = "FAILED" AND email_activated = "No" THEN "wrong channel used"
        WHEN notification_channel = "PUSH" AND notification_status = "SENT" AND email_activated = "Missing" THEN "push desactivated after notification"
        WHEN notification_channel = "PUSH" AND notification_status = "FAILED" AND email_activated = "Missing" THEN "push desactivated before notification"
        ELSE "No pushes"
        END AS real_push_status,    
    CASE
        WHEN notification_status = "SENT" AND notification_channel = "SMS" THEN "SMS sent"
        WHEN notification_status = "FAILED" AND notification_channel = "SMS" THEN "SMS fail"
        ELSE "No SMS sent"
    END AS SMS_notifications
FROM notifications