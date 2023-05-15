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
        WHEN real_email_status = "emails sent" THEN +1
        ELSE 0
        END) AS successful_emails,

    SUM(CASE
        WHEN real_email_status = "email sent without consent" THEN +1
        ELSE 0
    END) AS email_sent_without_consent,

    SUM(CASE
        WHEN real_email_status = "emails desactivated after notification" THEN +1
        ELSE 0
    END) AS emails_desactivated_after_notification,

    SUM(CASE
        WHEN real_email_status = "emails before after notification" THEN +1
        ELSE 0
    END) AS emails_desactivated_before_notification,

    SUM(CASE
        WHEN real_email_status = "email error" THEN +1
        ELSE 0
    END) AS email_error,
    
    SUM(CASE
        WHEN real_email_status = "wrong channel used" THEN +1
        ELSE 0
    END) AS wrong_used_of_email_channel,

        SUM(CASE
        WHEN real_email_status = "No emails" AND email_activated = "Yes" THEN +1
        ELSE 0
    END) AS No_emails_despite_consent            
FROM notification_issues
GROUP BY user_id