DROP TABLE IF EXISTS mvcc_item;

CREATE TABLE mvcc_item (
  id INT PRIMARY KEY,
  val INT NOT NULL
);

INSERT INTO mvcc_item (id, val) VALUES (1, 10);
