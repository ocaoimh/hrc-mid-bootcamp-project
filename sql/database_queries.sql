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

## 8 Arrange the data in a decreasing order by the average_balance of the customer. 
## Return only the customer_number of the top 10 customers with the highest average_balances in your data.
SELECT 	*
FROM credit_card_data;

SELECT customer_number, average_balance
FROM credit_card_data
ORDER BY average_balance DESC
LIMIT 10;

## 9 What is the average balance of all the customers in your data?
SELECT ROUND(AVG(average_balance),2) AS total_avg_balance
FROM credit_card_data;

## 10 
## 1 What is the average balance of the customers grouped by Income Level? 
##  The returned result should have only two columns, income level and Average balance of the customers.
##  Use an alias to change the name of the second column.

SELECT income_level, ROUND(AVG(average_balance),2) AS avg_balance
FROM credit_card_data
GROUP BY income_level;

## 2 What is the average balance of the customers grouped by number_of_bank_accounts_open? 
## The returned result should have only two columns, number_of_bank_accounts_open and Average balance of the customers.
## Use an alias to change the name of the second column.

SELECT bank_accounts_open, ROUND(AVG(average_balance),2) AS avg_balance
FROM credit_card_data
GROUP BY bank_accounts_open;

## 3 What is the average number of credit cards held by customers for each of the credit card ratings? 
## The returned result should have only two columns, 
## rating and average number of credit cards held. Use an alias to change the name of the second column.

SELECT credit_rating, CEILING(AVG(credit_cards_held)) AS avg_num_cards # decided to round up
FROM credit_card_data
GROUP BY credit_rating;

## 4 Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open? 
## You can analyse this by grouping the data by one of the variables and then aggregating the results of 
## the other column. Visually check if there is a positive correlation or negative correlation or no correlation 
## between the variables.

SELECT bank_accounts_open, CEILING(AVG(credit_cards_held)) AS avg_credit_cards
FROM credit_card_data
GROUP BY bank_accounts_open; 
# the average number of credit card held is 2, no matter the number of bank accounts a client has (1 to 3). This suggests no correlation between both variables.

## 11 Your managers are only interested in the customers with the following properties:

## Credit rating medium or high
## Credit cards held 2 or less
## Owns their own home
## Household size 3 or more

## For the rest of the things, they are not too concerned.
## Write a simple query to find what are the options available for them?

DROP TEMPORARY TABLE IF EXISTS manager_table;
CREATE TEMPORARY TABLE manager_table (
SELECT *
FROM credit_card_data
WHERE (credit_rating = 'medium' OR credit_rating = 'high')
  AND credit_cards_held <= 2
  AND own_your_home = 'yes'
  AND household_size >= 3
  ) ; # This is a new temporary table for managers' use including all the filter provided above.
  
## Checking temp table
SELECT *
FROM manager_table; 

## Can you filter the customers who accepted the offers here?
SELECT *
FROM manager_table
WHERE offer_accepted = 'yes';
  
  ## 12 Your managers want to find out the list of customers whose average balance is less than the average
  ## balance of all the customers in the database. Write a query to show them the list of such customers. 
  ## You might need to use a subquery for this problem.

# Looking at the entire database  
SELECT customer_number, average_balance
FROM credit_card_data
WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_data);

# Looking only at the subset managers_table
SELECT customer_number, average_balance
FROM manager_table
WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_data);

## 13 Since this is something that the senior management is regularly interested in, create a view of the same query.

DROP VIEW IF EXISTS below_avg_balance_customers;
CREATE VIEW below_avg_balance_customers AS
SELECT customer_number, average_balance
FROM credit_card_data
WHERE average_balance < (SELECT AVG(average_balance) FROM credit_card_data);

SELECT * FROM below_avg_balance_customers;

## 14 What is the number of people who accepted the offer vs number of people who did not?

SELECT offer_accepted, COUNT(*) as count
FROM credit_card_data
GROUP BY offer_accepted;

## 15 Your managers are more interested in customers with a credit rating of high or medium. 
## What is the difference in average balances of the customers with high credit card rating and low credit card rating?

SELECT AVG(CASE WHEN credit_rating = 'High' THEN average_balance END)
       - AVG(CASE WHEN credit_rating = 'Low' THEN average_balance END) as balance_diff
FROM credit_card_data;

## 16 In the database, which all types of communication (mailer_type) were used and with how many customers?

SELECT mailer_type, COUNT(DISTINCT customer_number) as num_customers
FROM credit_card_data
GROUP BY mailer_type;


## 17 Provide the details of the customer that is the 11th least Q1_balance in your database.

SELECT customer_number, Q1_balance, ROW_NUMBER() OVER(ORDER BY q1_balance ASC) AS least_rank
FROM credit_card_data
ORDER BY Q1_balance ASC
LIMIT 1 OFFSET 10;