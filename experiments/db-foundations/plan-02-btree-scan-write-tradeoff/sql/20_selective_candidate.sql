\echo '--- selective candidate: add composite index ---'

CREATE INDEX IF NOT EXISTS idx_plan02_user_type_created_desc
ON app_events_plan02 (user_id, event_type, created_at DESC);

ANALYZE app_events_plan02;

\echo '--- selective candidate: with composite index ---'
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, event_type, created_at
FROM app_events_plan02
WHERE user_id = 101
  AND event_type = 'checkout'
ORDER BY created_at DESC
LIMIT 50;
