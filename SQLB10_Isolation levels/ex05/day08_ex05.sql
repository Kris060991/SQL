-- СЕССИЯ #1
-- Начинаем транзакцию с уровнем изоляции READ COMMITTED
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;

-- Фиксируем изменения
COMMIT;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;

-- СЕССИЯ #2
-- Начинаем транзакцию с уровнем изоляции READ COMMITTED
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Вставляем новую пиццерию 'Kazan Pizza' с рейтингом 5 и ID=10
INSERT INTO pizzeria VALUES (10, 'Kazan Pizza', 5);

-- Фиксируем изменения
COMMIT;

-- Суммирование всех рейтингов пиццерий
SELECT SUM(rating) AS total_rating FROM pizzeria;