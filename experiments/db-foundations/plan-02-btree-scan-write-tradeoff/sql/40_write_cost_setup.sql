\echo '--- write cost setup ---'

DROP TABLE IF EXISTS write_no_index_plan02;
DROP TABLE IF EXISTS write_with_index_plan02;

CREATE TABLE write_no_index_plan02 (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INT NOT NULL,
  event_type TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL,
  payload TEXT NOT NULL
);

CREATE TABLE write_with_index_plan02 (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INT NOT NULL,
  event_type TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL,
  payload TEXT NOT NULL
);

CREATE INDEX idx_write_with_index_user_type_created
  ON write_with_index_plan02 (user_id, event_type, created_at DESC);
CREATE INDEX idx_write_with_index_event_type
  ON write_with_index_plan02 (event_type);
CREATE INDEX idx_write_with_index_created_at
  ON write_with_index_plan02 (created_at DESC);

ANALYZE write_no_index_plan02;
ANALYZE write_with_index_plan02;
