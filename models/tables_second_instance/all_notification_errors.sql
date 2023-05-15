{{
    config (
        materialized = "table"
    )
}}

WITH email_agg AS (
    SELECT * FROM {{ref("email_issues_aggregated")}}
),

push_agg AS (
    SELECT * FROM {{ref("push_issues_aggregated")}}
)

SELECT
    e.user_id,
    e.total_notifications,
    e.successful_emails,
    p.successful_pushs,
    e.agg_email_errors,
    p.agg_push_errors,
    e.agg_email_errors + p.agg_push_errors AS total_notification_issues,
    ROUND(IFNULL(SAFE_DIVIDE(e.agg_email_errors + p.agg_push_errors, e.total_notifications), 0), 3) AS issue_percentage
FROM email_agg e
JOIN push_agg p ON e.user_id = p.user_id
