{{
    config(
        materialized="table"
    )
}}

WITH push_issues AS (
    SELECT * FROM {{ref("push_issues_detailed")}}
)

SELECT
    user_id,
    total_notifications,
    successful_pushs,
    SUM(push_sent_without_consent + push_desactivated_after_notification + push_desactivated_before_notification + push_error + wrong_used_of_push_channel) AS agg_push_errors,
FROM push_issues
GROUP BY user_id, total_notifications, successful_pushs