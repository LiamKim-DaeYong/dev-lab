\echo '--- setup: orders_ios ---'

DROP TABLE IF EXISTS orders_ios;

CREATE TABLE orders_ios (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INT NOT NULL,
  status TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL,
  total_amount INT NOT NULL,
  note TEXT NOT NULL
);

INSERT INTO orders_ios (user_id, status, created_at, total_amount, note)
SELECT
  CASE
    WHEN g % 100 = 0 THEN 42
    ELSE (g % 20000) + 1
  END AS user_id,
  CASE
    WHEN g % 20 = 0 THEN 'paid'
    WHEN g % 5 = 0 THEN 'cancelled'
    ELSE 'pending'
  END AS status,
  now() - make_interval(secs => g) AS created_at,
  1000 + (g % 9000) AS total_amount,
  repeat('n', 80) AS note
FROM generate_series(1, 400000) AS g;

ANALYZE orders_ios;

\echo '--- distribution ---'
SELECT status, count(*) AS cnt
FROM orders_ios
GROUP BY status
ORDER BY status;
