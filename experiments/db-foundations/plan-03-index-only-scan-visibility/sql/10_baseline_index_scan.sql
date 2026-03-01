\echo '--- baseline: non-covering index ---'

DROP INDEX IF EXISTS idx_orders_ios_covering;
DROP INDEX IF EXISTS idx_orders_ios_key;

CREATE INDEX idx_orders_ios_key
ON orders_ios (user_id, status, created_at DESC);

ANALYZE orders_ios;

\echo '--- baseline explain ---'
EXPLAIN (ANALYZE, BUFFERS)
SELECT created_at, total_amount
FROM orders_ios
WHERE user_id = 42
  AND status = 'paid'
ORDER BY created_at DESC
LIMIT 100;
