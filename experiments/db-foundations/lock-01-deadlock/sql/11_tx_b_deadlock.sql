\echo '--- TX B deadlock path start ---'
BEGIN;
UPDATE account_balance SET balance = balance - 20 WHERE account_id = 2;
SELECT pg_sleep(2);
UPDATE account_balance SET balance = balance + 20 WHERE account_id = 1;
COMMIT;
\echo '--- TX B deadlock path end ---'
