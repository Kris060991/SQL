-- СЕССИЯ #1
-- Начинаем транзакцию с уровнем изоляции REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Обновляем рейтинг Pizza Hut
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- СЕССИЯ #2
-- Начинаем транзакцию с уровнем изоляции REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Обновляем рейтинг Pizza Hut
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut'