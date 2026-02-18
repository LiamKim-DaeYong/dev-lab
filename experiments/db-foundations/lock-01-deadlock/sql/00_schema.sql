DROP TABLE IF EXISTS account_balance;

CREATE TABLE account_balance (
  account_id INT PRIMARY KEY,
  balance INT NOT NULL
);

INSERT INTO account_balance (account_id, balance)
VALUES (1, 100), (2, 100);
