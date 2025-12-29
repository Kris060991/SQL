SELECT m.pizza_name AS pizza_name,
  m.price,
  pz.name AS pizzeria_name,
  pv.visit_date
FROM person_visits pv
JOIN menu m ON pv.pizzeria_id = m.pizzeria_id
JOIN pizzeria pz ON pv.pizzeria_id = pz.id
JOIN person p ON pv.person_id = p.id
WHERE p.name = 'Kate' AND m.price BETWEEN 800 AND 1000
ORDER BY pizza_name, m.price, pizzeria_name;