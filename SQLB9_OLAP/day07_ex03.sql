SELECT 
  name,
  SUM(count) AS total_count
FROM 
  (SELECT 
    pz.name, 
    COUNT(*) AS count
  FROM person_visits pv
  JOIN pizzeria pz ON pv.pizzeria_id = pz.id
  GROUP BY pz.name
     
  UNION ALL
     
  SELECT 
    pz.name, 
    COUNT(*) AS count
  FROM person_order po
  JOIN menu m ON po.menu_id = m.id
  JOIN pizzeria pz ON m.pizzeria_id = pz.id
  GROUP BY pz.name) AS combined
GROUP BY name
ORDER BY total_count DESC, name;