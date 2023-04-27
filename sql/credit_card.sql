CREATE DATABASE `credit_card_classification` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `credit_card_data` (
  `Customer Number` int DEFAULT NULL,
  `Offer Accepted` text COLLATE utf8mb4_unicode_ci,
  `Reward` text COLLATE utf8mb4_unicode_ci,
  `Mailer Type` text COLLATE utf8mb4_unicode_ci,
  `Income Level` text COLLATE utf8mb4_unicode_ci,
  `# Bank Accounts Open` int DEFAULT NULL,
  `Overdraft Protection` text COLLATE utf8mb4_unicode_ci,
  `Credit Rating` text COLLATE utf8mb4_unicode_ci,
  `# Credit Cards Held` int DEFAULT NULL,
  `# Homes Owned` int DEFAULT NULL,
  `Household Size` int DEFAULT NULL,
  `Own Your Home` text COLLATE utf8mb4_unicode_ci,
  `Average Balance` double DEFAULT NULL,
  `Q1 Balance` double DEFAULT NULL,
  `Q2 Balance` double DEFAULT NULL,
  `Q3 Balance` double DEFAULT NULL,
  `Q4 Balance` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
