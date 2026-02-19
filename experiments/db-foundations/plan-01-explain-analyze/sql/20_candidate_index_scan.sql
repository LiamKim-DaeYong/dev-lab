\echo '--- candidate: add composite index ---'

CREATE INDEX IF NOT EXISTS idx_app_events_user_type_created_desc
ON app_events (user_id, event_type, created_at DESC);

ANALYZE app_events;

\echo '--- candidate: with index ---'

EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, event_type, created_at
FROM app_events
WHERE user_id = 42
  AND event_type = 'checkout'
ORDER BY created_at DESC
LIMIT 50;
