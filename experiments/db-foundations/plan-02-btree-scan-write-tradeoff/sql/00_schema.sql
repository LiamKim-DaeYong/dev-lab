\echo '--- setup: app_events_plan02 ---'

DROP TABLE IF EXISTS app_events_plan02;

CREATE TABLE app_events_plan02 (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INT NOT NULL,
  event_type TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL,
  payload TEXT NOT NULL
);

INSERT INTO app_events_plan02 (user_id, event_type, created_at, payload)
SELECT
  (g % 1000) + 1 AS user_id,
  CASE
    WHEN g % 100 = 0 THEN 'checkout'
    WHEN g % 5 = 0 THEN 'purchase'
    ELSE 'view'
  END AS event_type,
  now() - make_interval(secs => g) AS created_at,
  repeat(md5(g::text), 2) AS payload
FROM generate_series(1, 300000) AS g;

ANALYZE app_events_plan02;

\echo '--- distribution check ---'
SELECT event_type, count(*) AS cnt
FROM app_events_plan02
GROUP BY event_type
ORDER BY event_type;
