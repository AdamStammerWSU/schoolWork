-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: census2
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `county`
--

DROP TABLE IF EXISTS `county`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `county` (
  `county_name` varchar(40) NOT NULL,
  PRIMARY KEY (`county_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `county`
--

LOCK TABLES `county` WRITE;
/*!40000 ALTER TABLE `county` DISABLE KEYS */;
INSERT INTO `county` VALUES ('Aitkin'),('Anoka'),('Becker'),('Beltrami'),('Benton'),('Big Stone'),('Blue Earth'),('Brown'),('Carlton'),('Carver'),('Cass'),('Chippewa'),('Chisago'),('Clay'),('Clearwater'),('Cook'),('Cottonwood'),('Crow Wing'),('Dakota'),('Dodge'),('Douglas'),('Faribault'),('Fillmore'),('Freeborn'),('Goodhue'),('Grant'),('Hennepin'),('Houston'),('Hubbard'),('Isanti'),('Itasca'),('Jackson'),('Kanabec'),('Kandiyohi'),('Kittson'),('Koochiching'),('Lac qui Parle'),('Lake'),('Lake of the Woods'),('Le Sueur'),('Lincoln'),('Lyon'),('Mahnomen'),('Marshall'),('Martin'),('McLeod'),('Meeker'),('Mille Lacs'),('Minnesota'),('Morrison'),('Mower'),('Murray'),('Nicollet'),('Nobles'),('Norman'),('Olmsted'),('Otter Tail'),('Pennington'),('Pine'),('Pipestone'),('Polk'),('Pope'),('Ramsey'),('Red Lake'),('Redwood'),('Renville'),('Rice'),('Rock'),('Roseau'),('Scott'),('Sherburne'),('Sibley'),('St. Louis'),('Stearns'),('Steele'),('Stevens'),('Swift'),('Todd'),('Traverse'),('Wabasha'),('Wadena'),('Waseca'),('Washington'),('Watonwan'),('Wilkin'),('Winona'),('Wright'),('Yellow Medicine');
/*!40000 ALTER TABLE `county` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `county_measure`
--

DROP TABLE IF EXISTS `county_measure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `county_measure` (
  `state_name` varchar(40) NOT NULL,
  `county_name` varchar(40) NOT NULL,
  `population` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  PRIMARY KEY (`state_name`,`county_name`,`year`),
  KEY `county_name` (`county_name`),
  KEY `year` (`year`),
  CONSTRAINT `county_measure_ibfk_1` FOREIGN KEY (`state_name`) REFERENCES `state` (`state_name`),
  CONSTRAINT `county_measure_ibfk_2` FOREIGN KEY (`county_name`) REFERENCES `county` (`county_name`),
  CONSTRAINT `county_measure_ibfk_3` FOREIGN KEY (`year`) REFERENCES `year` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `county_measure`
--

LOCK TABLES `county_measure` WRITE;
/*!40000 ALTER TABLE `county_measure` DISABLE KEYS */;
INSERT INTO `county_measure` VALUES ('Minnesota','Aitkin',15301,2000),('Minnesota','Anoka',298084,2000),('Minnesota','Becker',30000,2000),('Minnesota','Beltrami',39650,2000),('Minnesota','Benton',34226,2000),('Minnesota','Big Stone',5820,2000),('Minnesota','Blue Earth',55941,2000),('Minnesota','Brown',26911,2000),('Minnesota','Carlton',31671,2000),('Minnesota','Carver',70205,2000),('Minnesota','Cass',27150,2000),('Minnesota','Chippewa',13088,2000),('Minnesota','Chisago',41101,2000),('Minnesota','Clay',51229,2000),('Minnesota','Clearwater',8423,2000),('Minnesota','Cook',5168,2000),('Minnesota','Cottonwood',12167,2000),('Minnesota','Crow Wing',55099,2000),('Minnesota','Dakota',355904,2000),('Minnesota','Dodge',17731,2000),('Minnesota','Douglas',32821,2000),('Minnesota','Faribault',16181,2000),('Minnesota','Fillmore',21122,2000),('Minnesota','Freeborn',32584,2000),('Minnesota','Goodhue',44127,2000),('Minnesota','Grant',6289,2000),('Minnesota','Hennepin',1116200,2000),('Minnesota','Houston',19718,2000),('Minnesota','Hubbard',18376,2000),('Minnesota','Isanti',31287,2000),('Minnesota','Itasca',43992,2000),('Minnesota','Jackson',11268,2000),('Minnesota','Kanabec',14996,2000),('Minnesota','Kandiyohi',41203,2000),('Minnesota','Kittson',5285,2000),('Minnesota','Koochiching',14355,2000),('Minnesota','Lac qui Parle',8067,2000),('Minnesota','Lake',11058,2000),('Minnesota','Lake of the Woods',4522,2000),('Minnesota','Le Sueur',25426,2000),('Minnesota','Lincoln',6429,2000),('Minnesota','Lyon',25425,2000),('Minnesota','Mahnomen',5190,2000),('Minnesota','Marshall',10155,2000),('Minnesota','Martin',21802,2000),('Minnesota','McLeod',34898,2000),('Minnesota','Meeker',22644,2000),('Minnesota','Mille Lacs',22330,2000),('Minnesota','Minnesota',4919479,2000),('Minnesota','Morrison',31712,2000),('Minnesota','Mower',38603,2000),('Minnesota','Murray',9165,2000),('Minnesota','Nicollet',29771,2000),('Minnesota','Nobles',20832,2000),('Minnesota','Norman',7442,2000),('Minnesota','Olmsted',124277,2000),('Minnesota','Otter Tail',57159,2000),('Minnesota','Pennington',13584,2000),('Minnesota','Pine',26530,2000),('Minnesota','Pipestone',9895,2000),('Minnesota','Polk',31369,2000),('Minnesota','Pope',11236,2000),('Minnesota','Ramsey',511035,2000),('Minnesota','Red Lake',4299,2000),('Minnesota','Redwood',16815,2000),('Minnesota','Renville',17154,2000),('Minnesota','Rice',56665,2000),('Minnesota','Rock',9721,2000),('Minnesota','Roseau',16338,2000),('Minnesota','Scott',89498,2000),('Minnesota','Sherburne',64417,2000),('Minnesota','Sibley',15356,2000),('Minnesota','St. Louis',200528,2000),('Minnesota','Stearns',133166,2000),('Minnesota','Steele',33680,2000),('Minnesota','Stevens',10053,2000),('Minnesota','Swift',11956,2000),('Minnesota','Todd',24426,2000),('Minnesota','Traverse',4134,2000),('Minnesota','Wabasha',21610,2000),('Minnesota','Wadena',13713,2000),('Minnesota','Waseca',19526,2000),('Minnesota','Washington',201130,2000),('Minnesota','Watonwan',11876,2000),('Minnesota','Wilkin',7138,2000),('Minnesota','Winona',49985,2000),('Minnesota','Wright',89986,2000),('Minnesota','Yellow Medicine',11080,2000);
/*!40000 ALTER TABLE `county_measure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `midwest`
--

DROP TABLE IF EXISTS `midwest`;
/*!50001 DROP VIEW IF EXISTS `midwest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `midwest` AS SELECT 
 1 AS `state_name`,
 1 AS `population`,
 1 AS `year`,
 1 AS `number_of_reps`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `northeast`
--

DROP TABLE IF EXISTS `northeast`;
/*!50001 DROP VIEW IF EXISTS `northeast`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `northeast` AS SELECT 
 1 AS `state_name`,
 1 AS `population`,
 1 AS `year`,
 1 AS `number_of_reps`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `south`
--

DROP TABLE IF EXISTS `south`;
/*!50001 DROP VIEW IF EXISTS `south`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `south` AS SELECT 
 1 AS `state_name`,
 1 AS `population`,
 1 AS `year`,
 1 AS `number_of_reps`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `state` (
  `state_name` varchar(40) NOT NULL,
  PRIMARY KEY (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES ('Alabama'),('Alaska'),('Arizona'),('Arkansas'),('California'),('Colorado'),('Connecticut'),('Delaware'),('Florida'),('Georgia'),('Hawaii'),('Idaho'),('Illinois'),('Indiana'),('Iowa'),('Kansas'),('Kentucky'),('Louisiana'),('Maine'),('Maryland'),('Massachusetts'),('Michigan'),('Minnesota'),('Mississippi'),('Missouri'),('Montana'),('Nebraska'),('Nevada'),('New Hampshire'),('New Jersey'),('New Mexico'),('New York'),('North Carolina'),('North Dakota'),('Ohio'),('Oklahoma'),('Oregon'),('Pennsylvania'),('Rhode Island'),('South Carolina'),('South Dakota'),('Taxas'),('Tennesse'),('Utah'),('Vermont'),('Virginia'),('Washington'),('West Verginia'),('Wisconsin'),('Wyoming');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state_measure`
--

DROP TABLE IF EXISTS `state_measure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `state_measure` (
  `state_name` varchar(40) NOT NULL,
  `population` int(11) DEFAULT NULL,
  `year` int(11) NOT NULL,
  `number_of_reps` int(11) DEFAULT NULL,
  PRIMARY KEY (`state_name`,`year`),
  KEY `year` (`year`),
  CONSTRAINT `state_measure_ibfk_1` FOREIGN KEY (`state_name`) REFERENCES `state` (`state_name`),
  CONSTRAINT `state_measure_ibfk_2` FOREIGN KEY (`year`) REFERENCES `year` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state_measure`
--

LOCK TABLES `state_measure` WRITE;
/*!40000 ALTER TABLE `state_measure` DISABLE KEYS */;
INSERT INTO `state_measure` VALUES ('Alabama',9046,1810,1),('Alabama',127901,1820,3),('Alabama',309527,1830,5),('Alabama',590756,1840,7),('Alabama',771623,1850,7),('Alabama',964201,1860,6),('Alabama',996992,1870,8),('Alabama',1262505,1880,8),('Alabama',1513401,1890,9),('Alabama',1828697,1900,9),('Alabama',2138093,1910,10),('Alabama',2348174,1920,10),('Alabama',2646248,1930,9),('Alabama',2832961,1940,9),('Alabama',3061743,1950,9),('Alabama',3266740,1960,8),('Alabama',3444354,1970,7),('Alabama',3894025,1980,7),('Alaska',128643,1950,1),('Alaska',226167,1960,1),('Alaska',302853,1970,1),('Alaska',401851,1980,1),('Alaska',550043,1990,1),('Arizona',204354,1910,1),('Arizona',334162,1920,1),('Arizona',435573,1930,1),('Arizona',499261,1940,2),('Arizona',749587,1950,2),('Arizona',1302161,1960,3),('Arizona',1775399,1970,4),('Arizona',2716546,1980,5),('Arizona',3665228,1990,6),('Arkansas',30388,1830,1),('Arkansas',97574,1840,1),('Arkansas',209897,1850,2),('Arkansas',435450,1860,3),('Arkansas',484471,1870,4),('Arkansas',802525,1880,5),('Arkansas',1128211,1890,6),('Arkansas',1311564,1900,7),('Arkansas',1574449,1910,7),('Arkansas',1752204,1920,7),('Arkansas',1854482,1930,7),('Arkansas',1949387,1940,7),('Arkansas',1909511,1950,6),('Arkansas',1786272,1960,4),('Arkansas',1923322,1970,4),('Arkansas',2286357,1980,4),('Arkansas',2350725,1990,4),('California',92597,1850,2),('California',379994,1860,3),('California',560247,1870,4),('California',864694,1880,6),('California',1213398,1890,7),('California',1485053,1900,8),('California',2377549,1910,11),('California',3426861,1920,11),('California',5677251,1930,20),('California',6907387,1940,23),('California',10586223,1950,30),('California',15717204,1960,38),('California',19971069,1970,43),('California',23667764,1980,45),('California',29760021,1990,52),('Colorado',39864,1870,1),('Colorado',194327,1880,1),('Colorado',413249,1890,2),('Colorado',539700,1900,3),('Colorado',799024,1910,4),('Colorado',939629,1920,4),('Colorado',1035791,1930,4),('Colorado',1123296,1940,4),('Colorado',1325089,1950,4),('Colorado',1753947,1960,4),('Colorado',2209596,1970,5),('Colorado',2889735,1980,6),('Colorado',3294394,1990,6),('Connecticut',237946,1790,7),('Connecticut',251002,1800,7),('Connecticut',261942,1810,7),('Connecticut',275248,1820,6),('Connecticut',297675,1830,6),('Connecticut',309978,1840,4),('Connecticut',370792,1850,4),('Connecticut',460147,1860,4),('Connecticut',537454,1870,4),('Connecticut',622700,1880,4),('Connecticut',746258,1890,4),('Connecticut',908420,1900,5),('Connecticut',1114756,1910,5),('Connecticut',1380631,1920,5),('Connecticut',1606903,1930,6),('Connecticut',1709242,1940,6),('Connecticut',2007280,1950,6),('Connecticut',2535234,1960,6),('Connecticut',3032217,1970,6),('Connecticut',3107564,1980,6),('Connecticut',3287116,1990,6),('Delaware',59096,1790,1),('Delaware',64273,1800,1),('Delaware',72674,1810,2),('Delaware',72749,1820,1),('Delaware',76748,1830,1),('Delaware',78085,1840,1),('Delaware',91532,1850,1),('Delaware',112216,1860,1),('Delaware',125015,1870,1),('Delaware',146608,1880,1),('Delaware',168493,1890,1),('Delaware',184735,1900,1),('Delaware',202322,1910,1),('Delaware',223003,1920,1),('Delaware',230380,1930,1),('Delaware',266505,1940,1),('Delaware',318085,1950,1),('Delaware',446292,1960,1),('Delaware',548104,1970,1),('Delaware',594338,1980,1),('Delaware',666168,1990,1),('Delaware',783600,2000,1),('Florida',54477,1840,1),('Florida',87445,1850,1),('Florida',140424,1860,1),('Florida',187748,1870,2),('Florida',269493,1880,2),('Florida',391422,1890,2),('Florida',528542,1900,3),('Florida',752619,1910,4),('Florida',968470,1920,4),('Florida',1468211,1930,5),('Florida',1897414,1940,6),('Florida',2771305,1950,8),('Florida',4951560,1960,12),('Florida',6791418,1970,15),('Florida',9746961,1980,19),('Florida',12937926,1990,23),('Georgia',82548,1790,2),('Georgia',162686,1800,4),('Georgia',252433,1810,6),('Georgia',340989,1820,7),('Georgia',516823,1830,9),('Georgia',691392,1840,8),('Georgia',906185,1850,8),('Georgia',1057286,1860,7),('Georgia',1184109,1870,9),('Georgia',1542180,1880,10),('Georgia',1837353,1890,11),('Georgia',2216331,1900,11),('Georgia',2609121,1910,12),('Georgia',2895832,1920,12),('Georgia',2908506,1930,10),('Georgia',3123723,1940,10),('Georgia',3444578,1950,10),('Georgia',3943116,1960,10),('Georgia',4587930,1970,10),('Georgia',5462982,1980,10),('Georgia',6478216,1990,11),('Hawaii',499794,1950,1),('Hawaii',632772,1960,2),('Hawaii',769913,1970,2),('Hawaii',964691,1980,2),('Hawaii',1108229,1990,2),('Idaho',32610,1880,1),('Idaho',88548,1890,1),('Idaho',161772,1900,1),('Idaho',325594,1910,2),('Idaho',431866,1920,2),('Idaho',445032,1930,2),('Idaho',524873,1940,2),('Idaho',588637,1950,2),('Idaho',667191,1960,2),('Idaho',713015,1970,2),('Idaho',944127,1980,2),('Idaho',1006749,1990,2),('Illinois',12282,1810,1),('Illinois',55211,1820,1),('Illinois',157445,1830,3),('Illinois',476183,1840,7),('Illinois',851470,1850,9),('Illinois',1711951,1860,14),('Illinois',2539891,1870,19),('Illinois',3077871,1880,20),('Illinois',3826352,1890,22),('Illinois',4821550,1900,25),('Illinois',5638591,1910,27),('Illinois',6485280,1920,27),('Illinois',7630654,1930,27),('Illinois',7897241,1940,26),('Illinois',8712176,1950,25),('Illinois',10081158,1960,24),('Illinois',11110285,1970,24),('Illinois',11427409,1980,22),('Illinois',11430602,1990,20),('Indiana',24520,1810,1),('Indiana',147718,1820,3),('Indiana',343031,1830,7),('Indiana',685866,1840,10),('Indiana',988416,1850,11),('Indiana',1350428,1860,11),('Indiana',1680637,1870,13),('Indiana',1978301,1880,13),('Indiana',2192404,1890,13),('Indiana',2516462,1900,13),('Indiana',2700876,1910,13),('Indiana',2930390,1920,13),('Indiana',3238503,1930,12),('Indiana',3427796,1940,11),('Indiana',3934224,1950,11),('Indiana',4662498,1960,11),('Indiana',5195392,1970,11),('Indiana',5490210,1980,10),('Indiana',5544159,1990,10),('Iowa',43112,1840,2),('Iowa',192914,1850,2),('Iowa',674913,1860,6),('Iowa',1194020,1870,9),('Iowa',1624615,1880,11),('Iowa',1912297,1890,11),('Iowa',2231853,1900,11),('Iowa',2224771,1910,11),('Iowa',2404021,1920,11),('Iowa',2470939,1930,9),('Iowa',2538268,1940,8),('Iowa',2621073,1950,8),('Iowa',2757537,1960,7),('Iowa',2825368,1970,6),('Iowa',2913808,1980,6),('Iowa',2776755,1990,5),('Kansas',107206,1860,1),('Kansas',364399,1870,3),('Kansas',996096,1880,7),('Kansas',1428108,1890,8),('Kansas',1470495,1900,8),('Kansas',1690949,1910,8),('Kansas',1769257,1920,8),('Kansas',1880999,1930,7),('Kansas',1801028,1940,6),('Kansas',1905299,1950,6),('Kansas',2178611,1960,5),('Kansas',2249071,1970,5),('Kansas',2364236,1980,5),('Kansas',2477574,1990,4),('Kentucky',73677,1790,2),('Kentucky',220955,1800,6),('Kentucky',406511,1810,10),('Kentucky',564317,1820,12),('Kentucky',687917,1830,13),('Kentucky',779828,1840,10),('Kentucky',982405,1850,10),('Kentucky',1155684,1860,9),('Kentucky',1321011,1870,10),('Kentucky',1648690,1880,11),('Kentucky',1858635,1890,11),('Kentucky',2147174,1900,11),('Kentucky',2289905,1910,11),('Kentucky',2416630,1920,11),('Kentucky',2614589,1930,9),('Kentucky',2845627,1940,9),('Kentucky',2944806,1950,8),('Kentucky',3038156,1960,7),('Kentucky',3220711,1970,7),('Kentucky',3660324,1980,7),('Kentucky',3685296,1990,6),('Louisiana',76556,1810,1),('Louisiana',153407,1820,3),('Louisiana',215739,1830,3),('Louisiana',352411,1840,4),('Louisiana',517762,1850,4),('Louisiana',708002,1860,5),('Louisiana',726915,1870,6),('Louisiana',939946,1880,6),('Louisiana',1118588,1890,6),('Louisiana',1381625,1900,7),('Louisiana',1656388,1910,8),('Louisiana',1798509,1920,8),('Louisiana',2101593,1930,8),('Louisiana',2363880,1940,8),('Louisiana',2683516,1950,8),('Louisiana',3257022,1960,8),('Louisiana',3644637,1970,8),('Louisiana',4206116,1980,8),('Louisiana',4219973,1990,7),('Maine',298335,1820,7),('Maine',399455,1830,8),('Maine',501793,1840,7),('Maine',583169,1850,6),('Maine',628279,1860,5),('Maine',626915,1870,5),('Maine',648936,1880,4),('Maine',661086,1890,4),('Maine',694466,1900,4),('Maine',742371,1910,4),('Maine',768014,1920,4),('Maine',797423,1930,3),('Maine',847226,1940,3),('Maine',913774,1950,3),('Maine',969265,1960,2),('Maine',993722,1970,2),('Maine',1125043,1980,2),('Maryland',319728,1790,8),('Maryland',341548,1800,9),('Maryland',380546,1810,9),('Maryland',407350,1820,9),('Maryland',447040,1830,8),('Maryland',470019,1840,6),('Maryland',583034,1850,6),('Maryland',687049,1860,5),('Maryland',780894,1870,6),('Maryland',934943,1880,6),('Maryland',1042390,1890,6),('Maryland',1188044,1900,6),('Maryland',1295346,1910,6),('Maryland',1499661,1920,6),('Maryland',1631526,1930,6),('Maryland',1821244,1940,6),('Maryland',2343001,1950,7),('Maryland',3100689,1960,8),('Maryland',3923897,1970,8),('Maryland',4216933,1980,8),('Maryland',4781468,1990,8),('Maryland',5296486,2000,8),('Massachusetts',378787,1790,14),('Massachusetts',422845,1800,17),('Massachusetts',472040,1810,20),('Massachusetts',523287,1820,13),('Massachusetts',610408,1830,12),('Massachusetts',737699,1840,10),('Massachusetts',994514,1850,11),('Massachusetts',1231066,1860,10),('Massachusetts',1457351,1870,11),('Massachusetts',1783085,1880,12),('Massachusetts',2238947,1890,13),('Massachusetts',2805346,1900,14),('Massachusetts',3366416,1910,16),('Massachusetts',3852356,1920,16),('Massachusetts',4249614,1930,15),('Massachusetts',4316721,1940,14),('Massachusetts',4690514,1950,14),('Massachusetts',5148578,1960,12),('Massachusetts',5689170,1970,12),('Massachusetts',5737093,1980,11),('Massachusetts',6016425,1990,10),('Michigan',31639,1830,1),('Michigan',212267,1840,3),('Michigan',397654,1850,4),('Michigan',749113,1860,6),('Michigan',1184059,1870,9),('Michigan',1636937,1880,11),('Michigan',2093890,1890,12),('Michigan',2420982,1900,12),('Michigan',2810173,1910,13),('Michigan',3668412,1920,13),('Michigan',4842325,1930,17),('Michigan',5256106,1940,17),('Michigan',6371766,1950,18),('Michigan',7823194,1960,19),('Michigan',8881826,1970,19),('Michigan',9262044,1980,18),('Michigan',9295297,1990,16),('Minnesota',6077,1850,2),('Minnesota',172023,1860,2),('Minnesota',439706,1870,3),('Minnesota',780773,1880,5),('Minnesota',1310283,1890,7),('Minnesota',1751394,1900,9),('Minnesota',2075708,1910,10),('Minnesota',2387125,1920,10),('Minnesota',2563953,1930,9),('Minnesota',2792300,1940,9),('Minnesota',2982483,1950,9),('Minnesota',3413864,1960,8),('Minnesota',3806103,1970,8),('Minnesota',4075970,1980,8),('Minnesota',4375099,1990,8),('Mississippi',31306,1810,1),('Mississippi',75448,1820,1),('Mississippi',136621,1830,2),('Mississippi',375651,1840,4),('Mississippi',606526,1850,5),('Mississippi',791305,1860,5),('Mississippi',827922,1870,6),('Mississippi',1131597,1880,7),('Mississippi',1289600,1890,7),('Mississippi',1551270,1900,8),('Mississippi',1797114,1910,8),('Mississippi',1790618,1920,8),('Mississippi',2009821,1930,7),('Mississippi',2183796,1940,7),('Mississippi',2178914,1950,6),('Mississippi',2178141,1960,5),('Mississippi',2216994,1970,5),('Mississippi',2520770,1980,5),('Mississippi',2573216,1990,5),('Missouri',66586,1820,1),('Missouri',140455,1830,2),('Missouri',383702,1840,5),('Missouri',682044,1850,7),('Missouri',1182012,1860,9),('Missouri',1721295,1870,13),('Missouri',2168380,1880,14),('Missouri',2679185,1890,15),('Missouri',3106665,1900,16),('Missouri',3293335,1910,16),('Missouri',3404055,1920,16),('Missouri',3629367,1930,13),('Missouri',3784664,1940,13),('Missouri',3954653,1950,11),('Missouri',4319813,1960,10),('Missouri',4677623,1970,10),('Missouri',4916766,1980,9),('Missouri',5117073,1990,9),('Montana',39159,1880,1),('Montana',142924,1890,1),('Montana',243329,1900,1),('Montana',376053,1910,2),('Montana',548889,1920,2),('Montana',537606,1930,2),('Montana',559456,1940,2),('Montana',591024,1950,2),('Montana',674767,1960,2),('Montana',694409,1970,2),('Montana',786690,1980,2),('Montana',799065,1990,1),('Nebraska',28841,1860,1),('Nebraska',122993,1870,1),('Nebraska',452402,1880,3),('Nebraska',1062656,1890,6),('Nebraska',1066300,1900,6),('Nebraska',1192214,1910,6),('Nebraska',1296372,1920,6),('Nebraska',1377963,1930,5),('Nebraska',1315834,1940,4),('Nebraska',1325510,1950,4),('Nebraska',1411330,1960,3),('Nebraska',1485333,1970,3),('Nebraska',1569825,1980,3),('Nebraska',1578385,1990,3),('Nevada',6857,1860,1),('Nevada',42491,1870,1),('Nevada',62266,1880,1),('Nevada',47355,1890,1),('Nevada',42335,1900,1),('Nevada',81875,1910,1),('Nevada',77407,1920,1),('Nevada',91058,1930,1),('Nevada',110247,1940,1),('Nevada',160083,1950,1),('Nevada',285278,1960,1),('Nevada',488738,1970,1),('Nevada',800508,1980,2),('Nevada',1201833,1990,2),('New Hampshire',141885,1790,4),('New Hampshire',183858,1800,5),('New Hampshire',214460,1810,6),('New Hampshire',244161,1820,6),('New Hampshire',269328,1830,5),('New Hampshire',284574,1840,4),('New Hampshire',317976,1850,3),('New Hampshire',326073,1860,3),('New Hampshire',318300,1870,3),('New Hampshire',346991,1880,2),('New Hampshire',376530,1890,2),('New Hampshire',411588,1900,2),('New Hampshire',430572,1910,2),('New Hampshire',443083,1920,2),('New Hampshire',465293,1930,2),('New Hampshire',491524,1940,2),('New Hampshire',533242,1950,2),('New Hampshire',606921,1960,2),('New Hampshire',737681,1970,2),('New Hampshire',920610,1980,2),('New Hampshire',1109252,1990,2),('New Jersey',184139,1790,5),('New Jersey',211149,1800,6),('New Jersey',245562,1810,6),('New Jersey',277575,1820,6),('New Jersey',320823,1830,6),('New Jersey',373306,1840,5),('New Jersey',489555,1850,5),('New Jersey',672035,1860,5),('New Jersey',906096,1870,7),('New Jersey',1131116,1880,7),('New Jersey',1444933,1890,8),('New Jersey',1883669,1900,10),('New Jersey',2537167,1910,12),('New Jersey',3155900,1920,12),('New Jersey',4041334,1930,14),('New Jersey',4160165,1940,14),('New Jersey',4835329,1950,14),('New Jersey',6066782,1960,15),('New Jersey',7171112,1970,15),('New Jersey',7365011,1980,14),('New Jersey',7730188,1990,13),('New Mexico',327301,1910,1),('New Mexico',360350,1920,1),('New Mexico',423317,1930,1),('New Mexico',531818,1940,2),('New Mexico',681187,1950,2),('New Mexico',951023,1960,2),('New Mexico',1017055,1970,2),('New Mexico',1303302,1980,3),('New Mexico',1515069,1990,3),('New York',340120,1790,10),('New York',589051,1800,17),('New York',959049,1810,27),('New York',1372812,1820,34),('New York',1918608,1830,40),('New York',2428921,1840,34),('New York',3097394,1850,33),('New York',3880735,1860,31),('New York',4382759,1870,33),('New York',5082871,1880,34),('New York',6003174,1890,34),('New York',7268894,1900,37),('New York',9113614,1910,43),('New York',10385227,1920,43),('New York',12588066,1930,45),('New York',13479142,1940,45),('New York',14830192,1950,43),('New York',16782304,1960,41),('New York',18241391,1970,39),('New York',17558165,1980,34),('New York',17990455,1990,31),('North Carolina',393751,1790,10),('North Carolina',478103,1800,12),('North Carolina',555500,1810,13),('North Carolina',638829,1820,13),('North Carolina',737987,1830,13),('North Carolina',753419,1840,9),('North Carolina',869039,1850,8),('North Carolina',992622,1860,7),('North Carolina',1071361,1870,8),('North Carolina',1399750,1880,9),('North Carolina',1617949,1890,9),('North Carolina',1893810,1900,10),('North Carolina',2206287,1910,10),('North Carolina',2559123,1920,10),('North Carolina',3170276,1930,11),('North Carolina',3571623,1940,12),('North Carolina',4061929,1950,12),('North Carolina',4556155,1960,11),('North Carolina',5084411,1970,11),('North Carolina',5880095,1980,11),('North Carolina',6628637,1990,12),('North Dakota',36909,1880,1),('North Dakota',190983,1890,1),('North Dakota',319146,1900,2),('North Dakota',577056,1910,3),('North Dakota',646872,1920,3),('North Dakota',680845,1930,2),('North Dakota',641935,1940,2),('North Dakota',619636,1950,2),('North Dakota',632446,1960,2),('North Dakota',617792,1970,1),('North Dakota',652717,1980,1),('North Dakota',638800,1990,1),('Ohio',45365,1800,1),('Ohio',230760,1810,6),('Ohio',581434,1820,14),('Ohio',937903,1830,19),('Ohio',1519467,1840,21),('Ohio',1980329,1850,21),('Ohio',2339511,1860,19),('Ohio',2665260,1870,20),('Ohio',3198062,1880,21),('Ohio',3672329,1890,21),('Ohio',4157545,1900,21),('Ohio',4767121,1910,22),('Ohio',5759394,1920,22),('Ohio',6646697,1930,24),('Ohio',6907612,1940,23),('Ohio',7946627,1950,23),('Ohio',9706397,1960,24),('Ohio',10657423,1970,23),('Ohio',10797603,1980,21),('Ohio',10847115,1990,19),('Oklahoma',790391,1900,5),('Oklahoma',1657155,1910,8),('Oklahoma',2028283,1920,8),('Oklahoma',2396040,1930,9),('Oklahoma',2336434,1940,8),('Oklahoma',2233351,1950,6),('Oklahoma',2328284,1960,6),('Oklahoma',2559463,1970,6),('Oklahoma',3025487,1980,6),('Oklahoma',3145585,1990,6),('Oregon',12093,1850,1),('Oregon',52465,1860,1),('Oregon',90923,1870,1),('Oregon',174768,1880,1),('Oregon',317704,1890,2),('Oregon',413536,1900,2),('Oregon',672765,1910,3),('Oregon',783389,1920,3),('Oregon',953786,1930,3),('Oregon',1089684,1940,4),('Oregon',1521341,1950,4),('Oregon',1768687,1960,4),('Oregon',2091533,1970,4),('Oregon',2633156,1980,5),('Oregon',2842321,1990,5),('Pennsylvania',434373,1790,13),('Pennsylvania',602365,1800,18),('Pennsylvania',810091,1810,23),('Pennsylvania',1049458,1820,26),('Pennsylvania',1348233,1830,28),('Pennsylvania',1724033,1840,24),('Pennsylvania',2311786,1850,25),('Pennsylvania',2906215,1860,24),('Pennsylvania',3521951,1870,27),('Pennsylvania',4282891,1880,28),('Pennsylvania',5258113,1890,30),('Pennsylvania',6302115,1900,32),('Pennsylvania',7665111,1910,36),('Pennsylvania',8720017,1920,36),('Pennsylvania',9631350,1930,34),('Pennsylvania',9900180,1940,33),('Pennsylvania',10498012,1950,30),('Pennsylvania',11319366,1960,27),('Pennsylvania',11800766,1970,25),('Pennsylvania',11864720,1980,23),('Pennsylvania',11881643,1990,21),('Rhode Island',68825,1790,2),('Rhode Island',69122,1800,2),('Rhode Island',76931,1810,2),('Rhode Island',83059,1820,2),('Rhode Island',97199,1830,2),('Rhode Island',108830,1840,2),('Rhode Island',147545,1850,2),('Rhode Island',174620,1860,2),('Rhode Island',217353,1870,2),('Rhode Island',276531,1880,2),('Rhode Island',345506,1890,2),('Rhode Island',428556,1900,2),('Rhode Island',542610,1910,3),('Rhode Island',604397,1920,3),('Rhode Island',687497,1930,2),('Rhode Island',713346,1940,2),('Rhode Island',791896,1950,2),('Rhode Island',859488,1960,2),('Rhode Island',949723,1970,2),('Rhode Island',947154,1980,2),('Rhode Island',1003464,1990,2),('South Carolina',249073,1790,6),('South Carolina',345591,1800,8),('South Carolina',415115,1810,9),('South Carolina',502741,1820,9),('South Carolina',581185,1830,9),('South Carolina',594398,1840,7),('South Carolina',668507,1850,6),('South Carolina',703708,1860,4),('South Carolina',705606,1870,5),('South Carolina',995577,1880,7),('South Carolina',1151149,1890,7),('South Carolina',1340316,1900,7),('South Carolina',1515400,1910,7),('South Carolina',1683724,1920,7),('South Carolina',1738765,1930,6),('South Carolina',1899804,1940,6),('South Carolina',2117027,1950,6),('South Carolina',2382594,1960,6),('South Carolina',2590713,1970,6),('South Carolina',3120729,1980,6),('South Carolina',3486703,1990,6),('South Dakota',98268,1880,2),('South Dakota',348600,1890,2),('South Dakota',401570,1900,2),('South Dakota',583888,1910,3),('South Dakota',636547,1920,3),('South Dakota',692849,1930,2),('South Dakota',642961,1940,2),('South Dakota',652740,1950,2),('South Dakota',680514,1960,2),('South Dakota',666257,1970,2),('South Dakota',690768,1980,1),('South Dakota',696004,1990,1),('Utah',210779,1890,1),('Utah',276749,1900,1),('Utah',373351,1910,2),('Utah',449396,1920,2),('Utah',507847,1930,2),('Utah',550310,1940,2),('Utah',688862,1950,2),('Utah',890627,1960,2),('Utah',1059273,1970,2),('Utah',1461037,1980,3),('Utah',1722850,1990,3),('Vermont',85425,1790,2),('Vermont',154465,1800,4),('Vermont',217895,1810,6),('Vermont',235981,1820,5),('Vermont',280652,1830,5),('Vermont',291948,1840,4),('Vermont',314120,1850,3),('Vermont',315098,1860,3),('Vermont',330551,1870,3),('Vermont',332286,1880,2),('Vermont',332422,1890,2),('Vermont',343641,1900,2),('Vermont',355956,1910,2),('Vermont',352428,1920,2),('Vermont',359611,1930,1),('Vermont',359231,1940,1),('Vermont',377747,1950,1),('Vermont',389881,1960,1),('Vermont',444732,1970,1),('Vermont',511456,1980,1),('Virginia',691737,1790,19),('Virginia',807557,1800,22),('Virginia',877683,1810,23),('Virginia',938261,1820,22),('Virginia',1044054,1830,21),('Virginia',1025227,1840,15),('Virginia',1119348,1850,13),('Virginia',1219630,1860,11),('Virginia',1225163,1870,9),('Virginia',1512565,1880,10),('Virginia',1655980,1890,10),('Virginia',1854184,1900,10),('Virginia',2061612,1910,10),('Virginia',2309187,1920,10),('Virginia',2421851,1930,9),('Virginia',2677773,1940,9),('Virginia',3318680,1950,10),('Virginia',3966949,1960,10),('Virginia',4651448,1970,10),('Virginia',5346797,1980,10),('Virginia',6187358,1990,11),('Washington',75116,1880,1),('Washington',357232,1890,2),('Washington',518103,1900,3),('Washington',1141990,1910,5),('Washington',1356621,1920,5),('Washington',1563396,1930,6),('Washington',1736191,1940,6),('Washington',2378963,1950,7),('Washington',2853214,1960,7),('Washington',3413244,1970,7),('Washington',4132353,1980,8),('Washington',4866692,1990,9),('Wisconsin',30945,1840,2),('Wisconsin',305391,1850,3),('Wisconsin',775881,1860,6),('Wisconsin',1054670,1870,8),('Wisconsin',1315497,1880,9),('Wisconsin',1693330,1890,10),('Wisconsin',2069042,1900,11),('Wisconsin',2333860,1910,11),('Wisconsin',2632067,1920,11),('Wisconsin',2939006,1930,10),('Wisconsin',3137587,1940,10),('Wisconsin',3434575,1950,10),('Wisconsin',3951777,1960,10),('Wisconsin',4417821,1970,9),('Wisconsin',4705642,1980,9),('Wisconsin',4891769,1990,9),('Wyoming',20789,1880,1),('Wyoming',62555,1890,1),('Wyoming',92531,1900,1),('Wyoming',145965,1910,1),('Wyoming',194402,1920,1),('Wyoming',225565,1930,1),('Wyoming',250742,1940,1),('Wyoming',290529,1950,1),('Wyoming',330066,1960,1),('Wyoming',332416,1970,1),('Wyoming',469557,1980,1),('Wyoming',453588,1990,1);
/*!40000 ALTER TABLE `state_measure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `west`
--

DROP TABLE IF EXISTS `west`;
/*!50001 DROP VIEW IF EXISTS `west`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `west` AS SELECT 
 1 AS `state_name`,
 1 AS `population`,
 1 AS `year`,
 1 AS `number_of_reps`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `year`
--

DROP TABLE IF EXISTS `year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `year` (
  `year` int(11) NOT NULL,
  PRIMARY KEY (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `year`
--

LOCK TABLES `year` WRITE;
/*!40000 ALTER TABLE `year` DISABLE KEYS */;
INSERT INTO `year` VALUES (1790),(1791),(1792),(1793),(1794),(1795),(1796),(1797),(1798),(1799),(1800),(1801),(1802),(1803),(1804),(1805),(1806),(1807),(1808),(1809),(1810),(1811),(1812),(1813),(1814),(1815),(1816),(1817),(1818),(1819),(1820),(1821),(1822),(1823),(1824),(1825),(1826),(1827),(1828),(1829),(1830),(1831),(1832),(1833),(1834),(1835),(1836),(1837),(1838),(1839),(1840),(1841),(1842),(1843),(1844),(1845),(1846),(1847),(1848),(1849),(1850),(1851),(1852),(1853),(1854),(1855),(1856),(1857),(1858),(1859),(1860),(1861),(1862),(1863),(1864),(1865),(1866),(1867),(1868),(1869),(1870),(1871),(1872),(1873),(1874),(1875),(1876),(1877),(1878),(1879),(1880),(1881),(1882),(1883),(1884),(1885),(1886),(1887),(1888),(1889),(1890),(1891),(1892),(1893),(1894),(1895),(1896),(1897),(1898),(1899),(1900),(1901),(1902),(1903),(1904),(1905),(1906),(1907),(1908),(1909),(1910),(1911),(1912),(1913),(1914),(1915),(1916),(1917),(1918),(1919),(1920),(1921),(1922),(1923),(1924),(1925),(1926),(1927),(1928),(1929),(1930),(1931),(1932),(1933),(1934),(1935),(1936),(1937),(1938),(1939),(1940),(1941),(1942),(1943),(1944),(1945),(1946),(1947),(1948),(1949),(1950),(1951),(1952),(1953),(1954),(1955),(1956),(1957),(1958),(1959),(1960),(1961),(1962),(1963),(1964),(1965),(1966),(1967),(1968),(1969),(1970),(1971),(1972),(1973),(1974),(1975),(1976),(1977),(1978),(1979),(1980),(1981),(1982),(1983),(1984),(1985),(1986),(1987),(1988),(1989),(1990),(1991),(1992),(1993),(1994),(1995),(1996),(1997),(1998),(1999),(2000),(2001),(2002),(2003),(2004),(2005),(2006),(2007),(2008),(2009),(2010),(2011),(2012),(2013),(2014),(2015),(2016),(2017),(2018),(2019),(2020);
/*!40000 ALTER TABLE `year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `midwest`
--

/*!50001 DROP VIEW IF EXISTS `midwest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `midwest` AS select `state_measure`.`state_name` AS `state_name`,`state_measure`.`population` AS `population`,`state_measure`.`year` AS `year`,`state_measure`.`number_of_reps` AS `number_of_reps` from `state_measure` where ((`state_measure`.`state_name` = 'Iowa') or (`state_measure`.`state_name` = 'Kansas') or (`state_measure`.`state_name` = 'Minnesota') or (`state_measure`.`state_name` = 'Missouri') or (`state_measure`.`state_name` = 'Nebraska') or (`state_measure`.`state_name` = 'North Dakota') or (`state_measure`.`state_name` = 'South Dakota') or (`state_measure`.`state_name` = 'Illinois') or (`state_measure`.`state_name` = 'Indiana') or (`state_measure`.`state_name` = 'Michigan') or (`state_measure`.`state_name` = 'Ohio') or (`state_measure`.`state_name` = 'Wisconsin')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `northeast`
--

/*!50001 DROP VIEW IF EXISTS `northeast`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `northeast` AS select `state_measure`.`state_name` AS `state_name`,`state_measure`.`population` AS `population`,`state_measure`.`year` AS `year`,`state_measure`.`number_of_reps` AS `number_of_reps` from `state_measure` where ((`state_measure`.`state_name` = 'Connecticut') or (`state_measure`.`state_name` = 'Maine') or (`state_measure`.`state_name` = 'Massachusetts') or (`state_measure`.`state_name` = 'New Hampshire') or (`state_measure`.`state_name` = 'Rhode Island') or (`state_measure`.`state_name` = 'Vermont') or (`state_measure`.`state_name` = 'New York') or (`state_measure`.`state_name` = 'New Jersey') or (`state_measure`.`state_name` = 'Pennsylvania')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `south`
--

/*!50001 DROP VIEW IF EXISTS `south`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `south` AS select `state_measure`.`state_name` AS `state_name`,`state_measure`.`population` AS `population`,`state_measure`.`year` AS `year`,`state_measure`.`number_of_reps` AS `number_of_reps` from `state_measure` where ((`state_measure`.`state_name` = 'Delaware') or (`state_measure`.`state_name` = 'Florida') or (`state_measure`.`state_name` = 'Georgia') or (`state_measure`.`state_name` = 'Maryland') or (`state_measure`.`state_name` = 'North Carolina') or (`state_measure`.`state_name` = 'South Carolina') or (`state_measure`.`state_name` = 'Virginia') or (`state_measure`.`state_name` = 'West Virginia') or (`state_measure`.`state_name` = 'Alabama') or (`state_measure`.`state_name` = 'Kentucky') or (`state_measure`.`state_name` = 'Mississippi') or (`state_measure`.`state_name` = 'Tennessee') or (`state_measure`.`state_name` = 'Arkansas') or (`state_measure`.`state_name` = 'Louisiana') or (`state_measure`.`state_name` = 'Oklahoma') or (`state_measure`.`state_name` = 'Texas')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `west`
--

/*!50001 DROP VIEW IF EXISTS `west`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `west` AS select `state_measure`.`state_name` AS `state_name`,`state_measure`.`population` AS `population`,`state_measure`.`year` AS `year`,`state_measure`.`number_of_reps` AS `number_of_reps` from `state_measure` where ((`state_measure`.`state_name` = 'Arizona') or (`state_measure`.`state_name` = 'Colorado') or (`state_measure`.`state_name` = 'Idaho') or (`state_measure`.`state_name` = 'Montana') or (`state_measure`.`state_name` = 'Nevada') or (`state_measure`.`state_name` = 'New Mexico') or (`state_measure`.`state_name` = 'Utah') or (`state_measure`.`state_name` = 'Wyoming') or (`state_measure`.`state_name` = 'Alaska') or (`state_measure`.`state_name` = 'California') or (`state_measure`.`state_name` = 'Hawaii') or (`state_measure`.`state_name` = 'Oregon') or (`state_measure`.`state_name` = 'Washington')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-30 10:04:48
