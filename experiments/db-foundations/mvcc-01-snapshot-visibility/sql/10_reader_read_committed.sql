\echo '--- reader: READ COMMITTED start ---'
BEGIN ISOLATION LEVEL READ COMMITTED;

SELECT val AS first_read_rc FROM mvcc_item WHERE id = 1;
SELECT pg_sleep(5);
SELECT val AS second_read_rc FROM mvcc_item WHERE id = 1;

COMMIT;
\echo '--- reader: READ COMMITTED end ---'
