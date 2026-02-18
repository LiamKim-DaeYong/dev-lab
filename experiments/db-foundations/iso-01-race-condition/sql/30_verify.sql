\echo '--- verify state ---'

SELECT COUNT(*) AS orders_count FROM orders;
SELECT COALESCE(SUM(qty), 0) AS sold_qty FROM orders;
SELECT product_id, stock AS inventory_stock FROM inventory WHERE product_id = 1;

SELECT CASE
  WHEN (SELECT COALESCE(SUM(qty), 0) FROM orders) > 1 THEN 'OVERSOLD'
  ELSE 'OK'
END AS status;
