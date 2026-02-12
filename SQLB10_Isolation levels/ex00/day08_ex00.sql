-- СЕССИЯ #1
-- Начинаем транзакцию
BEGIN;

-- Обновляем рейтинг Pizza Hut до 5 баллов
UPDATE pizzeria SET rating = 5 WHERE name = 'Pizza Hut';

-- Проверяем изменения в сессии #1
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- СЕССИЯ #2
-- Проверяем, что изменения не видны до COMMIT
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- СЕССИЯ #1
-- Фиксируем транзакцию
COMMIT;

-- СЕССИЯ #2
-- Проверяем, что изменения стали видны после COMMIT
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';