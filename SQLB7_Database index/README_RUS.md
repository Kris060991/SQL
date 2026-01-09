## _I improved my SQL Query! Please, provide proof!_

В этом проекте ты освоишь продвинутые техники работы с индексами PostgreSQL: ты научишься создавать разные типы индексов, анализировать запросы и оптимизировать их так, чтобы все работало максимально быстро.

Эти навыки пригодятся, когда нужно будет ускорить медленные отчеты, снизить нагрузку на сервер, гарантировать уникальность данных (например, чтобы в одном ресторане не было двух пицц с одинаковым названием) или просто сделать так, чтобы пользователи твоего приложения не ждали лишнюю секунду там, где можно ответить мгновенно.

Убедись, что все изменения, которые были внесены в проект SQLB4_DML (Day 03) в ходе заданий 07-13, должны сохраняться (это похоже на реальную ситуацию, когда после выпуска релиза требуется обеспечить согласованность данных для новых изменений).


## Задание 00 — Let’s create indexes for every foreign key

Создай простой BTree index для каждого внешнего ключа в нашей базе данных.

Шаблон имени должен соответствовать следующему правилу: idx_{имя_таблицы}_{имя_столбца}.

Например, имя индекса типа B-дерево для столбца pizzeria_id в таблице `menu` будет `idx_menu_pizzeria_id`.

## Задание 01 — How to see that index works?

Прежде чем продолжить, напиши SQL-запрос, который возвращает названия пицц и соответствующие названия пиццерий.

Ознакомься с примером ожидаемого результата ниже (сортировка не требуется).

| pizza_name | pizzeria_name | 
| ------ | ------ |
| cheese pizza | Pizza Hut |
| ... | ... |

Необходимо убедиться, что индексы работают для твоего SQL-запроса. 

В качестве доказательства потребуется вывод команды `EXPLAIN ANALYZE`.

Ознакомься с примером вывода этой команды:
    
    ...
    ->  Index Scan using idx_menu_pizzeria_id on menu m  (...)
    ...

**Подсказка**: Подумай, почему твои индексы могут не использоваться напрямую, и что нужно сделать, чтобы их задействовать?

## Задание 02 — Formula is in the index. Is it Ok?

Создай функциональный B-Tree index с именем `idx_person_name` по столбцу `name` таблицы person. Индекс должен содержать имена людей в верхнем регистре.

Напишите и предоставьте любой SQL-запрос с доказательством работы индекса (`EXPLAIN ANALYZE`), демонстрирующим, что индекс idx_person_name используется.

## Задание 03 — Multicolumn index for our goals

Создай улучшенный многоколоночный B-Tree index с именем `idx_person_order_multi` для приведенного ниже SQL-запроса.

    SELECT person_id, menu_id,order_date
    FROM person_order
    WHERE person_id = 8 AND menu_id = 19;

Команда `EXPLAIN ANALYZE` должна вернуть план выполнения, соответствующий следующему шаблону. Обрати особое внимание на использование сканирования "Index Only Scan"!

    Index Only Scan using idx_person_order_multi on person_order ...

Предоставь любой SQL-запрос с доказательством работы индекса (`EXPLAIN ANALYZE`), демонстрирующим, что индекс `idx_person_order_multi` используется.

## Задание 04 — Uniqueness for data

Cоздай уникальный B-Tree index с именем `idx_menu_unique` для таблицы `menu` для столбцов `pizzeria_id` и `pizza_name`. 

Напиши и предоставь любой SQL-запрос с доказательством работы индекса (`EXPLAIN ANALYZE`), демонстрирующим, что индекс `idx_menu_unique` используется.

## Задание 05 — Partial uniqueness for data

Создай частично уникальный B-Tree index с именем `idx_person_order_order_date` на таблице `person_order` для атрибутов `person_id` и `menu_id` с частичной уникальностью по столбцу `order_date` для даты '2022-01-01'.

Команда `EXPLAIN ANALYZE` должна возвращать следующий шаблон:

    Index Only Scan using idx_person_order_order_date on person_order …

## Задание 06 — Let’s make performance improvement                                                                                

Проанализируй приведенный ниже SQL-запрос с технической точки зрения (не обращай внимания на логическую составляющую этого оператора).

    SELECT
        m.pizza_name AS pizza_name,
        max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
    FROM  menu m
    INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
    ORDER BY 1,2;

Создай новый B-Tree index с именем `idx_1`, который должен улучшить показатель «Время выполнения» (Execution Time) этого запроса. Предоставь доказательства улучшения с помощью команды `EXPLAIN ANALYZE`.

**Подсказка**: Это задание похоже на задачу "метода грубой силы" для поиска хорошего покрывающего индекса (covering index), поэтому перед каждым новым тестом удаляй индекс `idx_1`.

Пример моего улучшения:

**До**:

    Sort  (cost=26.08..26.13 rows=19 width=53) (actual time=0.247..0.254 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=25.30..25.68 rows=19 width=53) (actual time=0.110..0.182 rows=19 loops=1)
            ->  Sort  (cost=25.30..25.35 rows=19 width=21) (actual time=0.088..0.096 rows=19 loops=1)
                Sort Key: pz.rating
                Sort Method: quicksort  Memory: 26kB
                ->  Merge Join  (cost=0.27..24.90 rows=19 width=21) (actual time=0.026..0.060 rows=19 loops=1)
                        Merge Cond: (m.pizzeria_id = pz.id)
                        ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.013..0.029 rows=19 loops=1)
                            Heap Fetches: 19
                        ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..12.22 rows=6 width=15) (actual time=0.005..0.008 rows=6 loops=1)
    Planning Time: 0.711 ms
    Execution Time: 0.338 ms

**После**:

    Sort  (cost=26.28..26.33 rows=19 width=53) (actual time=0.144..0.148 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=0.27..25.88 rows=19 width=53) (actual time=0.049..0.107 rows=19 loops=1)
            ->  Nested Loop  (cost=0.27..25.54 rows=19 width=21) (actual time=0.022..0.058 rows=19 loops=1)
                ->  Index Scan using idx_1 on …
                ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..2.19 rows=3 width=22) (actual time=0.004..0.005 rows=3 loops=6)
    …
    Planning Time: 0.338 ms
    Execution Time: 0.203 ms