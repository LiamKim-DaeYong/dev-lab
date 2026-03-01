\echo '--- candidate(before vacuum): covering index ---'

DROP INDEX IF EXISTS idx_orders_ios_key;
DROP INDEX IF EXISTS idx_orders_ios_covering;

CREATE INDEX idx_orders_ios_covering
ON orders_ios (user_id, status, created_at DESC)
INCLUDE (total_amount);

ANALYZE orders_ios;

-- write churn을 의도적으로 발생시켜 all-visible 비트를 흔든다.
UPDATE orders_ios
SET note = note || ''
WHERE user_id = 42
  AND status = 'paid';

ANALYZE orders_ios;

\echo '--- candidate(before vacuum) explain ---'
EXPLAIN (ANALYZE, BUFFERS)
SELECT created_at, total_amount
FROM orders_ios
WHERE user_id = 42
  AND status = 'paid'
ORDER BY created_at DESC
LIMIT 100;
