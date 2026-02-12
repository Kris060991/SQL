-- СЕССИЯ #1
-- Проверяем текущий уровень изоляции
SHOW TRANSACTION ISOLATION LEVEL;

-- Начинаем транзакцию с уровнем изоляции READ COMMITTED
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Обновляем рейтинг Pizza Hut
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut 
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- СЕССИЯ #2
-- Проверяем текущий уровень изоляции
SHOW TRANSACTION ISOLATION LEVEL;

-- Начинаем транзакцию с уровнем изоляции READ COMMITTED
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Обновляем рейтинг Pizza Hut (до того как сделаем commit сессии1 зависает)
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';