TRUNCATE TABLE app_reads;
TRUNCATE TABLE orders RESTART IDENTITY;
UPDATE inventory SET stock = 1 WHERE product_id = 1;
