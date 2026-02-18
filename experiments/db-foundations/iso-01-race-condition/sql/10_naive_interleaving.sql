\echo '--- baseline: naive interleaving start ---'

-- A가 재고 읽음 (앱 메모리에 캐시한다고 가정)
INSERT INTO app_reads (worker, cached_stock)
SELECT 'A', stock FROM inventory WHERE product_id = 1;

-- B도 같은 시점 재고 읽음
INSERT INTO app_reads (worker, cached_stock)
SELECT 'B', stock FROM inventory WHERE product_id = 1;

-- A 처리: cached_stock > 0 이므로 주문 생성, 재고를 cached-1로 기록
INSERT INTO orders (product_id, qty, worker)
SELECT 1, 1, 'A'
WHERE (SELECT cached_stock FROM app_reads WHERE worker = 'A') > 0;

UPDATE inventory
SET stock = (SELECT cached_stock - 1 FROM app_reads WHERE worker = 'A')
WHERE product_id = 1;

-- B 처리: stale read를 그대로 사용 (동일하게 주문 생성)
INSERT INTO orders (product_id, qty, worker)
SELECT 1, 1, 'B'
WHERE (SELECT cached_stock FROM app_reads WHERE worker = 'B') > 0;

UPDATE inventory
SET stock = (SELECT cached_stock - 1 FROM app_reads WHERE worker = 'B')
WHERE product_id = 1;

\echo '--- baseline: naive interleaving end ---'
