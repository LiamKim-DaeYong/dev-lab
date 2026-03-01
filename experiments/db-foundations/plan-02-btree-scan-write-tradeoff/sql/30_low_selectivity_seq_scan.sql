\echo '--- low selectivity case: even with index, Seq Scan can win ---'

CREATE INDEX IF NOT EXISTS idx_plan02_event_type
ON app_events_plan02 (event_type);

ANALYZE app_events_plan02;

EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, event_type, created_at, payload
FROM app_events_plan02
WHERE event_type = 'view';
