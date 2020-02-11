/*

Stworzyć prostą baze danych z 4-5 tabel.

*/
USE JOB
GO

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS users_history;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
id_users INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
name_users NVARCHAR(255) NOT NULL,
surname_users NVARCHAR(255) NOT NULL,
email_users NVARCHAR(255) NOT NULL,
city_users NVARCHAR(255) NOT NULL,
street_users NVARCHAR(255) NOT NULL,
nr_floor_users NVARCHAR(20) NOT NULL,
post_code_users NVARCHAR(10) NOT NULL
)

CREATE TABLE accounts
(
id_accounts INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
iban_accounts VARCHAR(45) NOT NULL,
bank_name_accounts VARCHAR(45) NOT NULL,
account_balance_accounts MONEY NOT NULL,
account_currency_accounts VARCHAR(3) NOT NULL,
id_users_accounts INT NOT NULL,
CONSTRAINT fk_account_user FOREIGN KEY (id_users_accounts) 
  REFERENCES users (id_users),
CONSTRAINT chk_accounts CHECK (account_balance_accounts > 0)
)

CREATE TABLE transactions
(
id_transactions INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
account_from_transactions INT NOT NULL,
account_to_transactions INT NOT NULL,
user_from_transactions INT NOT NULL,
user_to_transactions INT NOT NULL,
date_transactions DATETIME DEFAULT CURRENT_TIMESTAMP,
time_transactions TIME DEFAULT CONVERT (TIME, Getdate()),
value_transactions MONEY NOT NULL,
CONSTRAINT fk_accounts_form FOREIGN KEY (account_from_transactions)
  REFERENCES accounts (id_accounts),
CONSTRAINT fk_accounts_to FOREIGN KEY (account_to_transactions) 
  REFERENCES accounts (id_accounts),
CONSTRAINT fk_user_from FOREIGN KEY (user_from_transactions) 
  REFERENCES users (id_users),
CONSTRAINT fk_user_to FOREIGN KEY (user_to_transactions) 
  REFERENCES users (id_users)
)

CREATE TABLE users_history
(
id_users_history INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
name_users_history NVARCHAR(255) NOT NULL,
surname_users_history NVARCHAR(255) NOT NULL,
email_users_history NVARCHAR(255) NOT NULL,
city_users_history NVARCHAR(255) NOT NULL,
street_users_history NVARCHAR(255) NOT NULL,
nr_floor_users_history NVARCHAR(20) NOT NULL,
post_code_users_history NVARCHAR(10) NOT NULL,
begin_date_users_history DATE DEFAULT Getdate(),
end_date_users_history DATE,
id_user_users_history INT NOT NULL,
CONSTRAINT fk_id_users FOREIGN KEY (id_user_users_history)
   REFERENCES users (id_users),
CONSTRAINT fk_date CHECK (begin_date_users_history <= end_date_users_history)
)