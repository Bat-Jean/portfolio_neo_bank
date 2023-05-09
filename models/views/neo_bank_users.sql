SELECT
    -- Key
    user_id,
    -- Age
    EXTRACT(YEAR FROM created_date) - birth_year AS user_age,
    -- Country
    country AS user_country,
    -- Account date
    CAST(created_date AS DATETIME) AS account_creation_date,

    -- plans (Standard, Premium, Metal) with free and offers
    CASE
      WHEN plan LIKE "STANDARD" THEN "Standard"
      WHEN plan LIKE "PREMIUM%" THEN "Premium"
      WHEN plan LIKE "METAL%" THEN "Metal"
      ELSE NULL
    END AS user_plan,

    -- Crypto
    CASE
      WHEN user_settings_crypto_unlocked = 0 THEN "No crypto"
      WHEN user_settings_crypto_unlocked = 1 THEN "Crypto"
      ELSE NULL
    END AS crypto_user,

    -- push
    CASE
      WHEN attributes_notifications_marketing_push IS NULL THEN "Missing"
      WHEN attributes_notifications_marketing_push = 1.0 THEN "Yes"
      WHEN attributes_notifications_marketing_push = 0.0 THEN "No"
      ELSE NULL
    END AS push_activated,

    -- email
    CASE
      WHEN attributes_notifications_marketing_email IS NULL THEN "Missing"
      WHEN attributes_notifications_marketing_email = 1.0 THEN "Yes"
      WHEN attributes_notifications_marketing_email = 0.0 THEN "No"
      ELSE NULL
    END AS email_activated,

    -- contacts
    num_contacts AS contacts,

    -- referral sucess percentage
    IFNULL(SAFE_DIVIDE(num_referrals, num_successful_referrals),0) AS referral_success

FROM `portfolio_neo_bank.users`