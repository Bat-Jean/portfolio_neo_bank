SELECT
    -- Key
    string_field_1 AS user_id,
    -- Device name, 4 distinct values (Apple, Android, Unkown and brand)
    CASE 
      WHEN string_field_0 = "Apple" THEN "Apple"
      WHEN string_field_0 = "Android" THEN "Android"
      ELSE "No info"
    END AS device_name
FROM `portfolio_neo_bank.devices`