SELECT pz.name AS pizzeria_name
FROM person_visits pv
JOIN pizzeria pz ON pv.pizzeria_id = pz.id
JOIN person p ON pv.person_id = p.id
WHERE p.name = 'Andrey'
  AND NOT EXISTS (
    SELECT 1
    FROM person_order po
    JOIN menu m ON po.menu_id = m.id
    WHERE po.person_id = pv.person_id
    AND m.pizzeria_id = pv.pizzeria_id
  )
ORDER BY pizzeria_name;