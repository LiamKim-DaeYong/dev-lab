\echo '--- baseline: no index ---'
\echo 'query: recent checkout events for user 42'

EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, event_type, created_at
FROM app_events
WHERE user_id = 42
  AND event_type = 'checkout'
ORDER BY created_at DESC
LIMIT 50;
