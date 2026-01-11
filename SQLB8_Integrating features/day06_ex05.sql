COMMENT ON TABLE person_discounts IS 'Реестр персональных скидок';
COMMENT ON COLUMN person_discounts.id IS 'Уникальный ID скидки';
COMMENT ON COLUMN person_discounts.person_id IS 'ID клиента';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'ID пиццерии';
COMMENT ON COLUMN person_discounts.discount IS 'Размер скидки в %';