WITH last_currency_rates AS (

  SELECT DISTINCT ON (id) 
    id,
    name,
    rate_to_usd,
    updated
  FROM currency
  ORDER BY id, updated DESC
),
user_balances AS (

  SELECT 
    user_id,
    type,
    currency_id,
    SUM(money) AS volume
  FROM balance
  GROUP BY user_id, type, currency_id
)
SELECT 
  COALESCE(u.name, 'not defined') AS name,
  COALESCE(u.lastname, 'not defined') AS lastname,
  ub.type,
  ub.volume,
  COALESCE(c.name, 'not defined') AS currency_name,
  COALESCE(c.rate_to_usd, 1) AS last_rate_to_usd,
  ub.volume * COALESCE(c.rate_to_usd, 1) AS total_volume_in_usd
FROM user_balances ub
LEFT JOIN "user" u ON ub.user_id = u.id
LEFT JOIN last_currency_rates c ON ub.currency_id = c.id
ORDER BY name DESC, lastname, type;