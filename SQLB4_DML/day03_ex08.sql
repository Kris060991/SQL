INSERT INTO menu (id, pizzeria_id, pizza_name, price)
VALUES (
  (SELECT MAX(id) + 1 FROM menu), 
  (SELECT id FROM pizzeria WHERE name = 'Dominos'), 
  'sicilian pizza', 
  900);

-- скрипт проверки 
-- SELECT count(*) = 1 AS CHECK
-- FROM menu
-- WHERE id = 20
--  AND pizzeria_id = 2
--  AND pizza_name = 'sicilian pizza'
--  AND price = 900;

-- удалить 
-- DELETE FROM menu WHERE pizza_name = 'sicilian pizza';