DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS inventory;

CREATE TABLE inventory (
  product_id INT PRIMARY KEY,
  stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE orders (
  order_id BIGSERIAL PRIMARY KEY,
  product_id INT NOT NULL REFERENCES inventory(product_id),
  qty INT NOT NULL CHECK (qty > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 시작 재고는 1개로 설정
INSERT INTO inventory (product_id, stock) VALUES (1, 1);
