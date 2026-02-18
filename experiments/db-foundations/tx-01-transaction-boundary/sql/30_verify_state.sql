\echo '--- current state ---'

SELECT COUNT(*) AS orders_count FROM orders;
SELECT product_id, stock AS inventory_stock FROM inventory ORDER BY product_id;
