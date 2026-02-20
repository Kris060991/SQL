insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');


WITH balance_rates AS (
  SELECT 
    b.user_id,
    b.money,
    b.updated AS balance_updated,
    b.currency_id,
    c.name AS currency_name,
    c.rate_to_usd,
    ROW_NUMBER() OVER (
      PARTITION BY b.user_id, b.money, b.updated, b.currency_id
      ORDER BY 
        CASE WHEN c.updated <= b.updated THEN 1 ELSE 2 END,
        ABS(EXTRACT(EPOCH FROM (c.updated - b.updated)))
    ) AS rn
  FROM balance b
  JOIN currency c ON b.currency_id = c.id
)
SELECT
  COALESCE(u.name, 'not defined') AS name,
  COALESCE(u.lastname, 'not defined') AS lastname,
  br.currency_name,
  br.money * br.rate_to_usd AS currency_in_usd
FROM balance_rates br
LEFT JOIN "user" u ON br.user_id = u.id
WHERE br.rn = 1
ORDER BY name DESC, lastname, currency_name;