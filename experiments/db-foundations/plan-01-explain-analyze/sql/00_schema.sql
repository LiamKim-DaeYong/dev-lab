DROP TABLE IF EXISTS app_events;

CREATE TABLE app_events (
  id BIGSERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  event_type TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL,
  amount INT NOT NULL,
  payload TEXT
);

-- 250,000건 샘플 데이터
-- user_id=42는 상대적으로 빈도를 높여 조건 조회 대상이 되게 구성
INSERT INTO app_events (user_id, event_type, created_at, amount, payload)
SELECT
  CASE
    WHEN gs % 100 = 0 THEN 42
    ELSE (gs % 5000) + 1
  END AS user_id,
  CASE
    WHEN gs % 25 = 0 THEN 'checkout'
    WHEN gs % 5 = 0 THEN 'add_to_cart'
    ELSE 'view'
  END AS event_type,
  NOW() - (gs || ' seconds')::INTERVAL AS created_at,
  (gs % 9000) + 1000 AS amount,
  repeat('x', 40) AS payload
FROM generate_series(1, 250000) AS gs;

ANALYZE app_events;
