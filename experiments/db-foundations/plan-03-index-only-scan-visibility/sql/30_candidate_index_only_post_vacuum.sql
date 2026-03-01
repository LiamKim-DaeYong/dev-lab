\echo '--- candidate(after vacuum): refresh visibility map ---'

VACUUM (ANALYZE) orders_ios;

\echo '--- candidate(after vacuum) explain ---'
EXPLAIN (ANALYZE, BUFFERS)
SELECT created_at, total_amount
FROM orders_ios
WHERE user_id = 42
  AND status = 'paid'
ORDER BY created_at DESC
LIMIT 100;
