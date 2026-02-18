\echo '--- candidate: atomic guard start ---'

-- Worker A: 원자적 조건 갱신 성공 시에만 주문 생성
WITH updated AS (
  UPDATE inventory
  SET stock = stock - 1
  WHERE product_id = 1
    AND stock > 0
  RETURNING product_id
)
INSERT INTO orders (product_id, qty, worker)
SELECT product_id, 1, 'A'
FROM updated;

-- Worker B: 이미 재고가 0이면 UPDATE 0건 -> 주문 미생성
WITH updated AS (
  UPDATE inventory
  SET stock = stock - 1
  WHERE product_id = 1
    AND stock > 0
  RETURNING product_id
)
INSERT INTO orders (product_id, qty, worker)
SELECT product_id, 1, 'B'
FROM updated;

\echo '--- candidate: atomic guard end ---'
