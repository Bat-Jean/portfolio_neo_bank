{{
    config(
        materialized="table"
    )
}}
WITH notification_issues AS (
    SELECT * FROM {{ ref("notifications_issues") }}
)

SELECT
    user_id,
    COUNT(notification_name) AS total_notifications,
    SUM(CASE
        WHEN real_push_status = "push sent" THEN +1
        ELSE 0
        END) AS successful_pushs,

    SUM(CASE
        WHEN real_push_status = "push sent without consent" THEN +1
        ELSE 0
    END) AS push_sent_without_consent,

    SUM(CASE
        WHEN real_push_status = "push desactivated after notification" THEN +1
        ELSE 0
    END) AS push_desactivated_after_notification,

    SUM(CASE
        WHEN real_push_status = "push before after notification" THEN +1
        ELSE 0
    END) AS push_desactivated_before_notification,

    SUM(CASE
        WHEN real_push_status = "push error" THEN +1
        ELSE 0
    END) AS push_error,
    
    SUM(CASE
        WHEN real_push_status = "wrong channel used" THEN +1
        ELSE 0
    END) AS wrong_used_of_push_channel,

        SUM(CASE
        WHEN real_push_status = "No push" AND push_activated = "Yes" THEN +1
        ELSE 0
    END) AS No_push_despite_consent            
FROM notification_issues
GROUP BY user_id