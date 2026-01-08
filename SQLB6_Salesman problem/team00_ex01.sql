WITH RECURSIVE tour AS (
  SELECT 
    point1 AS start_city,
    point2 AS next_city,
    cost AS total_cost,
    ARRAY[point1, point2] AS path
  FROM routes
  WHERE point1 = 'a'

  UNION ALL

  SELECT 
    t.start_city,
    r.point2 AS next_city,
    t.total_cost + r.cost AS total_cost,
    t.path || r.point2 AS path
  FROM tour t
  JOIN routes r ON t.next_city = r.point1
  WHERE array_length(t.path, 1) < 4 AND NOT r.point2 = ANY(t.path)
),

final_tour AS (
  SELECT
    t.total_cost + r.cost AS total_cost,
    '{' || array_to_string(t.path || ARRAY['a'], ',') || '}' AS tour
  FROM tour t
  JOIN routes r ON t.next_city = r.point1 AND r.point2 = 'a'
  WHERE array_length(t.path, 1) = 4
)

SELECT DISTINCT total_cost, tour
FROM final_tour
WHERE total_cost = (SELECT MIN(total_cost) FROM final_tour)
   OR total_cost = (SELECT MAX(total_cost) FROM final_tour)
ORDER BY total_cost, tour;