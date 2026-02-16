CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop integer DEFAULT 10)
RETURNS TABLE (fib_number integer) AS $$
WITH RECURSIVE fibonacci(a, b) AS (
  -- Базовый случай: первые два числа Фибоначчи равны 0 и 1
  SELECT 0::integer AS a, 1::integer AS b
    
  UNION ALL
    
  -- Рекурсивный шаг: следующее число Фибоначчи равно сумме двух предыдущих
  SELECT b, a + b
  FROM fibonacci
  WHERE b < pstop
)
SELECT a AS fib_number
FROM fibonacci
WHERE a < pstop
ORDER BY a;
$$ LANGUAGE SQL;

SELECT * 
FROM fnc_fibonacci(100);

SELECT * 
FROM fnc_fibonacci();