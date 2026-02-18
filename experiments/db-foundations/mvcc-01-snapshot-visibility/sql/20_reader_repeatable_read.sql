\echo '--- reader: REPEATABLE READ start ---'
BEGIN ISOLATION LEVEL REPEATABLE READ;

SELECT val AS first_read_rr FROM mvcc_item WHERE id = 1;
SELECT pg_sleep(5);
SELECT val AS second_read_rr FROM mvcc_item WHERE id = 1;

COMMIT;
\echo '--- reader: REPEATABLE READ end ---'
