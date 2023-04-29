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

SELECT homes_owned, own_your_home
FROM credit_card_data;

SELECT DISTINCT own_your_home,COUNT(homes_owned)
FROM credit_card_data
WHERE homes_owned = 3
GROUP BY own_your_home;

SELECT homes_owned, COUNT(*) OVER (PARTITION BY own_your_home) AS count
FROM credit_card_data
GROUP BY homes_owned, own_your_home;

Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'OVER (PARTITION BY own_your_home) FROM credit_card_data GROUP BY homes_owned, co' at line 1
Error Code: 1055. Expression #1 of PARTITION BY or ORDER BY clause of window '<unnamed window>' is not in GROUP BY clause and contains nonaggregated column 'credit_card_classification.credit_card_data.own_your_home' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

