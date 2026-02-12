-- СЕССИЯ #1
-- Начинаем транзакцию с уровнем изоляции READ COMMITTED
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- СЕССИЯ #2
-- Начинаем транзакцию с уровнем изоляции READ COMMITTED
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Обновляем рейтинг Pizza Hut
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';