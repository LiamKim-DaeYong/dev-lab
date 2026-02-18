\echo '--- writer update start ---'
SELECT pg_sleep(1);
BEGIN;
UPDATE mvcc_item SET val = val + 1 WHERE id = 1;
COMMIT;
SELECT val AS writer_committed_value FROM mvcc_item WHERE id = 1;
\echo '--- writer update end ---'
