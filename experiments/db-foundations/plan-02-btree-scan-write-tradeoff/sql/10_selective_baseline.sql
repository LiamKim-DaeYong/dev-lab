\echo '--- selective baseline: no composite index ---'

EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, event_type, created_at
FROM app_events_plan02
WHERE user_id = 101
  AND event_type = 'checkout'
ORDER BY created_at DESC
LIMIT 50;
