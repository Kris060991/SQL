UPDATE menu
SET price = price * 0.9
WHERE pizza_name = 'greek pizza';

-- скрипт проверки 
-- SELECT (800-800*0.1) = price AS CHECK
-- FROM menu
-- WHERE pizza_name = 'greek pizza'