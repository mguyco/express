-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 10.8.4.37
-- Generation Time: Nov 09, 2021 at 10:24 PM
-- Server version: 8.0.21
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `express`
--

-- --------------------------------------------------------

--
-- Table structure for table `catalogs`
--

CREATE TABLE `express_catalogs` (
  `id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `key` char(32) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `catalogs`
--

INSERT INTO `express_catalogs` (`id`, `name`, `key`, `active`) VALUES
(1, 'Desk Phones', 'phones', 1),
(2, 'User Bundles', 'bundles', 1),
(3, 'Group Features', 'group', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `express_customers` (
  `id` int NOT NULL,
  `orderId` int NOT NULL,
  `data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `invites`
--

CREATE TABLE `express_invites` (
  `id` int NOT NULL,
  `orderId` int NOT NULL,
  `account` json DEFAULT NULL,
  `accessCode` varchar(10) NOT NULL,
  `generatedByUser` varchar(32) NOT NULL,
  `generatedOnDate` datetime DEFAULT NULL,
  `expiresOnDate` datetime DEFAULT NULL,
  `activatedOnDate` datetime DEFAULT NULL,
  `response` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invites`
--

INSERT INTO `express_invites` (`id`, `orderId`, `account`, `accessCode`, `generatedByUser`, `generatedOnDate`, `expiresOnDate`, `activatedOnDate`, `response`) VALUES
(1, 369459, '{\"city\": \"LOS ANGELES\", \"state\": \"California\", \"domain\": \"graiwer-kaplan.com\", \"country\": \"United States\", \"orderID\": 369459, \"zipCode\": \"90010-2679\", \"location\": {\"dc\": \"Irvine\", \"abbrv\": \"we\", \"state\": \"California\", \"region\": \"West\", \"cluster\": 4, \"obProxy\": \"sip1.we.ucx.telepacific.com\"}, \"accountID\": 1288898, \"clusterID\": 13, \"stateAbbr\": \"CA\", \"customerID\": 1214304, \"contactName\": \"Gary Kaplan\", \"countryAbbr\": \"US\", \"newCustomer\": \"false\", \"orderStatus\": \"Jeopardy - TPx Not Ready\", \"addressLine1\": \"3600 WILSHIRE BLVD\", \"addressLine2\": \"\", \"contactEmail\": \"gkaplan@graiwer-kaplan.com\", \"contactPhone\": \"(213) 381-4350\", \"customerName\": \"GK PARTNER 3600 Wilshire Blvd\", \"orderProduct\": \"UCx\", \"contactLastName\": \"Kaplan\", \"parentAccountID\": 0, \"contactFirstName\": \"Gary\", \"lastOrderNoteDate\": \"2021-11-05 20:52:56\", \"customerParentName\": \"GK PARTNERS\", \"enterpriseMappingID\": 11772}', 'XYHBFPR3TC', 'mguy', '2021-11-05 21:08:39', '2021-12-05 21:08:39', '2021-11-05 21:09:53', '{\"id\": \"ac0b05c58d598cb8815e1f7b9687056d\", \"host\": \"\", \"browser\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\", \"referer\": \"http://localhost/\", \"ipAddress\": \"10.60.8.188\"}');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `express_log` (
  `id` int NOT NULL,
  `method` varchar(8) NOT NULL,
  `endpoint` varchar(32) DEFAULT NULL,
  `ipAddress` varchar(16) DEFAULT NULL,
  `userAgent` varchar(164) DEFAULT NULL,
  `utc` datetime DEFAULT NULL,
  `request` json NOT NULL,
  `response` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `log`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `express_orders` (
  `id` int NOT NULL,
  `orderId` int NOT NULL,
  `buildId` int NOT NULL DEFAULT '0',
  `visitedOnDate` datetime DEFAULT NULL,
  `savedOnDate` datetime DEFAULT NULL,
  `completedOnDate` datetime DEFAULT NULL,
  `numbers` json DEFAULT NULL,
  `products` json DEFAULT NULL,
  `data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `express_orders` (`id`, `orderId`, `buildId`, `visitedOnDate`, `savedOnDate`, `completedOnDate`, `numbers`, `products`, `data`) VALUES
(1, 369459, 0, '2021-11-05 21:11:21', NULL, NULL, '[{\"TN\": \"+1-2133807500\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814330\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814331\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814332\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814333\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814323\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814324\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814325\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814326\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814327\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814328\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814329\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814340\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814341\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814342\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814343\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814344\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814334\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814335\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814336\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814337\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814338\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814339\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814350\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814351\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814352\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814353\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814354\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814355\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814345\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814346\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814347\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814348\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814349\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814360\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814361\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814362\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814363\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814364\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814365\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814366\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814356\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814357\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814358\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814359\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814370\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814371\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814372\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814373\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814374\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814375\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814376\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814377\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814367\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814368\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814369\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814381\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814382\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814383\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814384\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814385\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814386\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814387\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814300\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814380\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814378\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814379\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814392\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814393\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814394\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814395\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814396\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814397\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814310\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814398\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814311\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814399\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814390\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814391\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814309\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814301\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814389\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814302\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814303\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814304\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814305\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814306\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814307\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814308\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814320\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814321\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814322\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814312\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814313\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814314\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814315\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814316\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814317\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814318\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133814319\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133558948\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133894165\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133803751\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2133876469\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134011287\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134011288\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134271028\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134271025\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134875195\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134876783\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134876732\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2134876702\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-7145355015\", \"Status\": \"Ported-In\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"ANAHEIM\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2132017574\", \"Status\": \"Assigned\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2132017573\", \"Status\": \"Assigned\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}, {\"TN\": \"+1-2132017575\", \"Status\": \"Assigned\", \"Carrier\": \"TPx: TELEPACIFIC - CA - 7453\", \"Country\": \"\", \"CustomerID\": 1288898, \"RateCenter\": \"LSAN DA 10\", \"CountryAbbr\": \"\", \"CountryCode\": 1, \"RateCenterState\": \"CA\"}]', '[{\"Qty\": 1, \"Service\": \"DSXX-UCX-GRP\", \"DisplayAs\": \"Auto Attendant - Standard\", \"ProductID\": 38693, \"ServiceID\": 2313, \"QuoteServiceID\": 2711623}, {\"Qty\": 1, \"Service\": \"DSXX-UCX-GRP\", \"DisplayAs\": \"Auto Attendant - Standard Setup Charge\", \"ProductID\": 38710, \"ServiceID\": 2313, \"QuoteServiceID\": 2711623}, {\"Qty\": 61, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"User Bundle Configuration Charge\", \"ProductID\": 38578, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 1, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"Call Reporting - Lite Supervisor\", \"ProductID\": 62421, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 61, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"Call Reporting - Lite Monitored User\", \"ProductID\": 62422, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 1, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"Geo-Location Emergency System Registration -- per geo-location\", \"ProductID\": 38538, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 1, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"Unlimited Local Usage\", \"ProductID\": 41036, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 61000, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"UCx & iPBX Bundle Domestic Usage Included\", \"ProductID\": 38589, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 1, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"UCx & iPBX Domestic USA & Canada Usage -- overage per minute\", \"ProductID\": 38543, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 61, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"User Bundle Count\", \"ProductID\": 38591, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 116, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"Direct Inward Dial Number -- On-Net\", \"ProductID\": 38523, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 3, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"New DID Installation Charge -- On-Net\", \"ProductID\": 38592, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 72, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"End User Connection Charge (EUCC)\", \"ProductID\": 44850, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 21, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"UCx Basic User Bundle\", \"ProductID\": 50117, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 32, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"UCx Voice User Bundle\", \"ProductID\": 50118, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 2, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"UCx Receptionist Client Add-On\", \"ProductID\": 38638, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 8, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"UCx Complete User Bundle\", \"ProductID\": 50119, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 113, \"Service\": \"DSXX-UCX-USRBN\", \"DisplayAs\": \"Existing DID Porting Charge -- On-Net\", \"ProductID\": 38524, \"ServiceID\": 2312, \"QuoteServiceID\": 2711624}, {\"Qty\": 1, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Customer Site Visit Charge - Includes 1 hour travel to and from\", \"ProductID\": 40723, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}, {\"Qty\": 1, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Professional Installation of Equipment\", \"ProductID\": 43876, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}, {\"Qty\": 58, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Phone Installation Charge - per unit\", \"ProductID\": 40724, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}, {\"Qty\": 1, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Algo 8301 Paging Adapter & Scheduler\", \"ProductID\": 52426, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}, {\"Qty\": 58, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Polycom VVX 41x Business Media Phone\", \"ProductID\": 36624, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}, {\"Qty\": 58, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Polycom AC Adapter for VVX 30x, 31x, & 41x phones (2200-46175-001)\", \"ProductID\": 37524, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}, {\"Qty\": 2, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Polycom VVX Color Expansion Module (2200-4635-025)\", \"ProductID\": 38777, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}, {\"Qty\": 18, \"Service\": \"DSXX-HSPBX-CPEPR\", \"DisplayAs\": \"Poly Voyager 6200 UC Wireless BT - Dual Ear Headset\", \"ProductID\": 66139, \"ServiceID\": 1417, \"QuoteServiceID\": 2711625}]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `express_products` (
  `id` int NOT NULL,
  `productId` int NOT NULL,
  `catalogId` int NOT NULL,
  `product` json DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `express_products` (`id`, `productId`, `catalogId`, `product`, `active`) VALUES
(1, 50119, 2, '{\"list\": [\"Desktop & Mobile UCx Apps\", \"Screen Sharing\", \"Audio & Video Conferencing\"], \"name\": \"UCx Complete\", \"image\": \"https://image.flaticon.com/icons/svg/438/438555.svg\", \"description\": \"Employee with multiple devices, works remotely\"}', 1),
(2, 38575, 2, '{\"list\": [\"No desk phone required\", \"Access from anywhere\", \"Storage up to 30 days\"], \"name\": \"Voice Mailbox\", \"image\": \"https://image.flaticon.com/icons/svg/1801/1801285.svg\", \"description\": \"Basic voice mail box only\"}', 0),
(3, 38639, 3, '{\"name\": \"Basic Auto Attendant\"}', 1),
(4, 35668, 1, '{\"list\": [\"Use your existing phone with TPx\", \"Easy to setup\", \"Most devices supported\"], \"name\": \"Use existing phone\", \"image\": \"https://image.flaticon.com/icons/svg/1802/1802712.svg\", \"description\": \"Bring your own device\"}', 1),
(5, 38693, 3, '{\"name\": \"Standard Auto Attendant\"}', 1),
(6, 57502, 1, '{\"list\": [\"3.5 inch color display\", \"USB headset support\", \"6 line operation\"], \"name\": \"Polycom VVX 350\", \"image\": \"http://mms3.dscicorp.com/express/catalog/phones/polycom/vvx/350/front.jpg\", \"description\": \"Small but powerful business phone\"}', 1),
(7, 50117, 2, '{\"list\": [\"Voice Calling\", \"Video Calling\"], \"name\": \"UCx Basic\", \"image\": \"https://image.flaticon.com/icons/svg/1869/1869768.svg\", \"description\": \"Lobby, conference room, visitor\"}', 1),
(8, 57508, 1, '{\"list\": [\"3.5 inch color display\", \"USB headset support\", \"6 line operation\"], \"name\": \"Polycom VVX 350\", \"image\": \"http://mms3.dscicorp.com/express/catalog/phones/polycom/vvx/350/front.jpg\", \"description\": \"Small but powerful business phone\"}', 1),
(9, 57507, 1, '{\"list\": [\"2.8 inch color display\", \"USB headset support\", \"4 line operation\"], \"name\": \"Polycom VVX 250\", \"image\": \"http://mms3.dscicorp.com/express/catalog/phones/polycom/vvx/250/front.jpg\", \"description\": \"The economical and elegant desk phone\"}', 1),
(10, 50118, 2, '{\"list\": [\"HD Voice &amp; Video\", \"Call Forwarding\", \"Voicemail to Email\"], \"name\": \"UCx Voice\", \"image\": \"https://image.flaticon.com/icons/svg/1869/1869768.svg\", \"description\": \"Office-based employee, no mobility needs\"}', 1),
(11, 57509, 1, '{\"list\": [\"4.5 inch color display\", \"USB headset support\", \"6 line operation\"], \"name\": \"Polycom VVX 450\", \"image\": \"http://www.twacomm.com/assets/3186257507/product_images/47729.jpg\", \"description\": \"Small but powerful business phone\"}', 1),
(12, 61877, 1, '{\"list\": [\"DECT / Wireless\", \"No desk required\", \"Single base station\"], \"name\": \"Polycom VVX D230\", \"image\": \"http://mms3.dscicorp.com/express/catalog/phones/polycom/vvx/d230/front.jpg\", \"description\": \"Business class VOIP with no wires\"}', 1),
(13, 38556, 2, '{\"list\": [\"Desktop & Mobile UCx Apps\", \"Screen Sharing\", \"Audio & Video Conferencing\"], \"name\": \"UCx Agent Standard\", \"image\": \"https://image.flaticon.com/icons/svg/438/438555.svg\", \"description\": \"Employee with multiple devices, works remotely\"}', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `catalogs`
--
ALTER TABLE `express_catalogs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `express_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invites`
--
ALTER TABLE `express_invites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log`
--
ALTER TABLE `express_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `express_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orderId` (`orderId`);

--
-- Indexes for table `products`
--
ALTER TABLE `express_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Product` (`productId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `catalogs`
--
ALTER TABLE `express_catalogs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `express_customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `invites`
--
ALTER TABLE `express_invites`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `log`
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `express_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `express_products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
