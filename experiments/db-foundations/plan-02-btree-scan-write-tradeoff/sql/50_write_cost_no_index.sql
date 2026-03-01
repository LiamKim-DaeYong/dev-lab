\echo '--- write cost baseline: insert into no-index table ---'

TRUNCATE TABLE write_no_index_plan02;

EXPLAIN (ANALYZE, BUFFERS)
INSERT INTO write_no_index_plan02 (user_id, event_type, created_at, payload)
SELECT
  (g % 1000) + 1 AS user_id,
  CASE
    WHEN g % 100 = 0 THEN 'checkout'
    WHEN g % 5 = 0 THEN 'purchase'
    ELSE 'view'
  END AS event_type,
  now() - make_interval(secs => g) AS created_at,
  repeat(md5(g::text), 2) AS payload
FROM generate_series(1, 20000) AS g;
