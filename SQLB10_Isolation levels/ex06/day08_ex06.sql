-- СЕССИЯ #1
-- Начинаем транзакцию с уровнем изоляции REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;

-- Фиксируем изменения
COMMIT;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;

-- СЕССИЯ #2
-- Начинаем транзакцию с уровнем изоляции REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Вставляем новую пиццерию 'Kazan Pizza 2' с рейтингом 4 и ID=11
INSERT INTO pizzeria VALUES (11, 'Kazan Pizza 2', 4);

-- Фиксируем изменения
COMMIT;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;