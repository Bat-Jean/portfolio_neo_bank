{{
    config(
        materialized="table"
    )
}}

WITH email_issues AS (
    SELECT * FROM {{ref("email_issues_detailed")}}
)

SELECT
    user_id,
    total_notifications,
    successful_emails,
    SUM(email_sent_without_consent + emails_desactivated_after_notification + emails_desactivated_before_notification + email_error + wrong_used_of_email_channel) AS agg_email_errors,
FROM email_issues
GROUP BY user_id, total_notifications, successful_emails