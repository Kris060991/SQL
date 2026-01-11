ALTER TABLE person_discounts
  ADD CONSTRAINT ch_nn_person_id CHECK (person_id IS NOT NULL),
  ADD CONSTRAINT ch_nn_pizzeria_id CHECK (pizzeria_id IS NOT NULL),
  ADD CONSTRAINT ch_nn_discount CHECK (discount IS NOT NULL),
  ADD CONSTRAINT ch_range_discount CHECK (discount BETWEEN 0 AND 100),
  ALTER COLUMN discount SET DEFAULT 0;

-- -- Удалить существующие ограничения
-- ALTER TABLE person_discounts 
--   DROP CONSTRAINT IF EXISTS ch_nn_person_id,
--   DROP CONSTRAINT IF EXISTS ch_nn_pizzeria_id,
--   DROP CONSTRAINT IF EXISTS ch_nn_discount,
--   DROP CONSTRAINT IF EXISTS ch_range_discount;
-- -- Убрать значение по умолчанию
-- ALTER TABLE person_discounts 
--   ALTER COLUMN discount DROP DEFAULT;