\echo '--- distribution check ---'

SELECT event_type, COUNT(*) AS cnt
FROM app_events
GROUP BY event_type
ORDER BY cnt DESC;

SELECT COUNT(*) AS target_rows
FROM app_events
WHERE user_id = 42
  AND event_type = 'checkout';
