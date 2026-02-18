\echo '--- candidate: single transaction start ---'

BEGIN;
-- qty=2는 주문 수량, 시작 재고(stock)는 1
INSERT INTO orders (product_id, qty) VALUES (1, 2);

-- 실패 유도: stock 1 -> -1 (CHECK 위반)
UPDATE inventory
SET stock = stock - 2
WHERE product_id = 1;
COMMIT;

\echo '--- candidate: single transaction end ---'
