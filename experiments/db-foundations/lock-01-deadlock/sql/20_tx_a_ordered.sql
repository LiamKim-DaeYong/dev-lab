\echo '--- TX A ordered path start ---'
BEGIN;
UPDATE account_balance SET balance = balance - 10 WHERE account_id = 1;
SELECT pg_sleep(2);
UPDATE account_balance SET balance = balance + 10 WHERE account_id = 2;
COMMIT;
\echo '--- TX A ordered path end ---'
