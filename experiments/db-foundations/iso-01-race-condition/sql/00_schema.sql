DROP TABLE IF EXISTS app_reads;
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
  worker TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE app_reads (
  worker TEXT PRIMARY KEY,
  cached_stock INT NOT NULL
);

-- 초기 재고 1개
INSERT INTO inventory (product_id, stock) VALUES (1, 1);
