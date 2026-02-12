-- СЕССИЯ #1
-- Начинаем транзакцию на уровне изоляции SERIALIZABLE
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Проверяем текущий рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- СЕССИЯ #2
-- Начинаем транзакцию на уровне изоляции SERIALIZABLE
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Обновляем рейтинг Pizza Hut
UPDATE pizzeria SET rating = 3.0 WHERE name = 'Pizza Hut';

-- Фиксируем изменения
COMMIT;

-- Проверяем финальный рейтинг Pizza Hut
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';