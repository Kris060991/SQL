WITH CTE_date AS (
  SELECT gs.day::date AS missing_date
  FROM generate_series('2022-01-01', '2022-01-10', interval '1 day') AS gs(day)
)
SELECT CTE_date.missing_date
FROM CTE_date
LEFT JOIN
  (SELECT * FROM person_visits pv
  WHERE person_id = 1 OR person_id = 2) AS pv
  ON pv.visit_date = CTE_date.missing_date
WHERE pv.visit_date IS NULL
ORDER BY CTE_date.missing_date;