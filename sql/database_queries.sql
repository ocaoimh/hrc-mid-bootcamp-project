USE credit_card_classification;

### Select all the data from table credit_card_data to check if the data was imported correctly.
SELECT *
FROM credit_card_data; 

SELECT COUNT(*)
FROM credit_card_data; #17976 -- correct number of observations after dropping records with missing balance

/* Use the alter table command to drop the column q4_balance from the database, 
as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. 
Limit your returned results to 10.*/

ALTER TABLE credit_card_data
DROP COLUMN q4_balance;

ALTER TABLE credit_card_data
RENAME COLUMN `#_bank_accounts_open` TO bank_accounts_open,
RENAME COLUMN `#_credit_cards_held` TO credit_cards_held,
RENAME COLUMN `#_homes_owned` TO homes_owned; # also decided to rename these 3 columns to standardize them

SELECT *
FROM credit_card_data
LIMIT 10; #After checking, the Q4 Balance column has been successfully dropped.

### Use sql query to find how many rows of data you have.
SELECT COUNT(*)
FROM credit_card_data;

### What are the unique values in the column offer_accepted?
SELECT DISTINCT offer_accepted
FROM credit_card_data; # No, Yes

### What are the unique values in the column Reward?
SELECT DISTINCT reward
FROM credit_card_data; # Air Miles, Cash Back, Points

### What are the unique values in the column mailer_type?
SELECT DISTINCT mailer_type
FROM credit_card_data; # Letter, Postcard

### What are the unique values in the column credit_cards_held?
SELECT DISTINCT credit_cards_held
FROM credit_card_data; # 1, 2, 3, 4

# What are the unique values in the column household_size?
SELECT DISTINCT household_size
FROM credit_card_data; # 1, 2, 3, 4, 5, 6, 8, 9