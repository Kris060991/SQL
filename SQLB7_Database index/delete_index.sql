-- Удаление существующих индексов, если они есть
-- 00 
DROP INDEX IF EXISTS idx_person_visits_person_id;
DROP INDEX IF EXISTS idx_person_visits_pizzeria_id;
DROP INDEX IF EXISTS idx_person_order_person_id;
DROP INDEX IF EXISTS idx_person_order_menu_id;
DROP INDEX IF EXISTS idx_menu_pizzeria_id;
-- 02 
DROP INDEX IF EXISTS idx_person_name;
-- 03
DROP INDEX IF EXISTS idx_person_order_multi;
-- 04 
DROP INDEX IF EXISTS  idx_menu_unique;
-- 05 
DROP INDEX IF EXISTS idx_person_order_order_date;
-- 06 
DROP INDEX IF EXISTS idx_1;