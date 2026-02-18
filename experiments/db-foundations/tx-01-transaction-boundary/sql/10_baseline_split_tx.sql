\echo '--- baseline: split transaction start ---'

-- Tx A: 주문 저장 (성공)
-- 주의: qty=2는 "주문 수량"이며, 시작 재고(stock)는 00_schema.sql에서 1로 설정됨
INSERT INTO orders (product_id, qty) VALUES (1, 2);

-- Tx B: 재고 차감 (실패 유도: stock 1 -> -1)
BEGIN;
UPDATE inventory
SET stock = stock - 2
WHERE product_id = 1;
COMMIT;

\echo '--- baseline: split transaction end ---'
