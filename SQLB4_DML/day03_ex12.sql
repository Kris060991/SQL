INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT 
  (SELECT MAX(id) FROM person_order) + 
  (SELECT COUNT(*) FROM person p2 WHERE p2.id <= p.id),
  p.id,
  (SELECT id FROM menu WHERE pizza_name = 'greek pizza'),
  '2022-02-25'::DATE
FROM person p;

-- скрипт проверки 
-- SELECT count(*) = 9 AS CHECK
-- FROM person_order
-- WHERE order_date = '2022-02-25'
--  AND menu_id =
--    (SELECT id
--     FROM menu
--     WHERE pizza_name = 'greek pizza');