SELECT m.pizza_name, 
  m.price, 
  (SELECT pz.name FROM pizzeria pz WHERE pz.id = m.pizzeria_id) AS pizzeria_name
FROM menu m
WHERE id NOT IN (
  SELECT menu_id 
  FROM person_order
)
ORDER BY m.pizza_name, m.price;