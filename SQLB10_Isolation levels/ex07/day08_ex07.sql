-- СЕССИЯ #1
-- Проверяем текущий уровень изоляции
SHOW TRANSACTION ISOLATION LEVEL;

-- Начинаем транзакцию
BEGIN;

-- Блокируем запись id=1 для обновления
UPDATE pizzeria SET rating = 4.2 WHERE id = 1;

-- Пытаемся обновить запись id=2, которая заблокирована Session #2
-- Здесь Session #1 будет ждать освобождения блокировки от Session #2
UPDATE pizzeria SET rating = 3.9 WHERE id = 2;

-- Завершаем транзакцию
COMMIT;

-- СЕССИЯ #2
-- Проверяем текущий уровень изоляции
SHOW TRANSACTION ISOLATION LEVEL;

-- Начинаем транзакцию
BEGIN;

-- Блокируем запись id=2 для обновления
UPDATE pizzeria SET rating = 4.0 WHERE id = 2;

-- Пытаемся обновить запись id=1, которая заблокирована Session #1
-- Здесь возникает DEADLOCK!
UPDATE pizzeria SET rating = 4.5 WHERE id = 1;

-- Завершаем транзакцию
COMMIT;