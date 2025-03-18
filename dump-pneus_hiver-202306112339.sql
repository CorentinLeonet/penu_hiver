-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: pneus_hiver
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_assignment`
--

DROP TABLE IF EXISTS `auth_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `idx-auth_assignment-user_id` (`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_assignment`
--

LOCK TABLES `auth_assignment` WRITE;
/*!40000 ALTER TABLE `auth_assignment` DISABLE KEYS */;
INSERT INTO `auth_assignment` VALUES ('admin','2',1686346610);
/*!40000 ALTER TABLE `auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item`
--

DROP TABLE IF EXISTS `auth_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` smallint NOT NULL,
  `description` text COLLATE utf8mb3_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item`
--

LOCK TABLES `auth_item` WRITE;
/*!40000 ALTER TABLE `auth_item` DISABLE KEYS */;
INSERT INTO `auth_item` VALUES ('admin',1,'Administrator',NULL,NULL,1686346610,1686346610),('user-management',2,'User Management',NULL,NULL,1686346610,1686346610);
/*!40000 ALTER TABLE `auth_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item_child`
--

DROP TABLE IF EXISTS `auth_item_child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item_child`
--

LOCK TABLES `auth_item_child` WRITE;
/*!40000 ALTER TABLE `auth_item_child` DISABLE KEYS */;
INSERT INTO `auth_item_child` VALUES ('admin','user-management');
/*!40000 ALTER TABLE `auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_rule`
--

DROP TABLE IF EXISTS `auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_rule`
--

LOCK TABLES `auth_rule` WRITE;
/*!40000 ALTER TABLE `auth_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `countryid` int DEFAULT NULL,
  `lat` varchar(100) DEFAULT NULL,
  `lon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_FK` (`countryid`),
  CONSTRAINT `city_FK` FOREIGN KEY (`countryid`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (2,'Liège',22,'50.63295859999999','5.569749799999999'),(3,'Namur',22,'50.4649359','4.865072899999999');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect_status`
--

DROP TABLE IF EXISTS `collect_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collect_status` (
  `id` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect_status`
--

LOCK TABLES `collect_status` WRITE;
/*!40000 ALTER TABLE `collect_status` DISABLE KEYS */;
INSERT INTO `collect_status` VALUES (1,1);
/*!40000 ALTER TABLE `collect_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Afghanistan (l\')','AF'),(2,'├àland(les ├Äles)','AX'),(3,'Albanie (l\')','AL'),(4,'Alg├®rie (l\')','DZ'),(5,'Samoa am├®ricaines (les)','AS'),(6,'Andorre (l\')','AD'),(7,'Angola (l\')','AO'),(8,'Anguilla','AI'),(9,'Antarctique (l\')','AQ'),(10,'Antigua-et-Barbuda','AG'),(11,'Argentine (l\')','AR'),(12,'Arm├®nie (l\')','AM'),(13,'Aruba','AW'),(14,'Australie (l\')','AU'),(15,'Autriche (l\')','AT'),(16,'Azerba├»djan (l\')','AZ'),(17,'Bahamas (les)','BS'),(18,'Bahre├»n','BH'),(19,'Bangladesh (le)','BD'),(20,'Barbade (la)','BB'),(21,'B├®larus (le)','BY'),(22,'Belgique (la)','BE'),(23,'Belize (le)','BZ'),(24,'B├®nin (le)','BJ'),(25,'Bermudes (les)','BM'),(26,'Bhoutan (le)','BT'),(27,'Bolivie (├ëtat plurinational de)','BO'),(28,'Bonaire, Saint-Eustache et Saba','BQ'),(29,'Bosnie-Herz├®govine (la)','BA'),(30,'Botswana (le)','BW'),(31,'Bouvet (l\'├Äle)','BV'),(32,'Br├®sil (le)','BR'),(33,'Indien (le┬áTerritoire britannique de l\'oc├®an)','IO'),(34,'Brun├®i Darussalam (le)','BN'),(35,'Bulgarie (la)','BG'),(36,'Burkina Faso (le)','BF'),(37,'Burundi (le)','BI'),(38,'Cabo Verde','CV'),(39,'Cambodge (le)','KH'),(40,'Cameroun (le)','CM'),(41,'Canada (le)','CA'),(42,'Ca├»mans (les┬á├Äles)','KY'),(43,'R├®publique centrafricaine (la)','CF'),(44,'Tchad (le)','TD'),(45,'Chili (le)','CL'),(46,'Chine (la)','CN'),(47,'Christmas (l\'├Äle)','CX'),(48,'Cocos (les┬á├Äles)/ Keeling (les┬á├Äles)','CC'),(49,'Colombie (la)','CO'),(50,'Comores (les)','KM'),(51,'Congo (la R├®publique d├®mocratique du)','CD'),(52,'Congo (le)','CG'),(53,'Cook (les ├Äles)','CK'),(54,'Costa Rica (le)','CR'),(55,'C├┤te d\'Ivoire (la)','CI'),(56,'Croatie (la)','HR'),(57,'Cuba','CU'),(58,'Cura├ºao','CW'),(59,'Chypre','CY'),(60,'Tch├®quie (la)','CZ'),(61,'Danemark (le)','DK'),(62,'Djibouti','DJ'),(63,'Dominique (la)','DM'),(64,'dominicaine (la┬áR├®publique)','DO'),(65,'├ëquateur (l\')','EC'),(66,'├ëgypte (l\')','EG'),(67,'El Salvador','SV'),(68,'Guin├®e ├®quatoriale (la)','GQ'),(69,'├ërythr├®e (l\')','ER'),(70,'Estonie (l\')','EE'),(71,'Eswatini (l\')','SZ'),(72,'├ëthiopie (l\')','ET'),(73,'Falkland (les ├Äles)/Malouines (les ├Äles)','FK'),(74,'F├®ro├® (les ├Äles)','FO'),(75,'Fidji (les)','FJ'),(76,'Finlande (la)','FI'),(77,'France (la)','FR'),(78,'Guyane fran├ºaise (la┬á)','GF'),(79,'Polyn├®sie fran├ºaise (la)','PF'),(80,'Terres australes fran├ºaises (les)','TF'),(81,'Gabon (le)','GA'),(82,'Gambie (la)','GM'),(83,'G├®orgie (la)','GE'),(84,'Allemagne (l\')','DE'),(85,'Ghana (le)','GH'),(86,'Gibraltar','GI'),(87,'Gr├¿ce (la)','GR'),(88,'Groenland (le)','GL'),(89,'Grenade (la)','GD'),(90,'Guadeloupe (la)','GP'),(91,'Guam','GU'),(92,'Guatemala (le)','GT'),(93,'Guernesey','GG'),(94,'Guin├®e (la)','GN'),(95,'Guin├®e-Bissau (la)','GW'),(96,'Guyana (le)','GY'),(97,'Ha├»ti','HT'),(98,'Heard-et-├Äles MacDonald (l\'├Äle)','HM'),(99,'Saint-Si├¿ge (le)','VA'),(100,'Honduras (le)','HN'),(101,'Hong Kong','HK'),(102,'Hongrie (la)','HU'),(103,'Islande (l\')','IS'),(104,'Inde (l\')','IN'),(105,'Indon├®sie (l\')','ID'),(106,'Iran (R├®publique Islamique d\')','IR'),(107,'Iraq (l\')','IQ'),(108,'Irlande (l\')','IE'),(109,'├Äle de Man','IM'),(110,'Isra├½l','IL'),(111,'Italie (l\')','IT'),(112,'Jama├»que (la)','JM'),(113,'Japon (le)','JP'),(114,'Jersey','JE'),(115,'Jordanie (la)','JO'),(116,'Kazakhstan (le)','KZ'),(117,'Kenya (le)','KE'),(118,'Kiribati','KI'),(119,'Cor├®e (la┬áR├®publique populaire d├®mocratique de)','KP'),(120,'Cor├®e (la R├®publique de)','KR'),(121,'Kowe├»t (le)','KW'),(122,'Kirghizistan (le)','KG'),(123,'Lao (la R├®publique d├®mocratique populaire)','LA'),(124,'Lettonie (la)','LV'),(125,'Liban (le)','LB'),(126,'Lesotho (le)','LS'),(127,'Lib├®ria (le)','LR'),(128,'Libye (la)','LY'),(129,'Liechtenstein (le)','LI'),(130,'Lituanie (la)','LT'),(131,'Luxembourg (le)','LU'),(132,'Macao','MO'),(133,'Madagascar','MG'),(134,'Malawi (le)','MW'),(135,'Malaisie (la)','MY'),(136,'Maldives (les)','MV'),(137,'Mali (le)','ML'),(138,'Malte','MT'),(139,'Marshall (les ├Äles)','MH'),(140,'Martinique (la)','MQ'),(141,'Mauritanie (la)','MR'),(142,'Maurice','MU'),(143,'Mayotte','YT'),(144,'Mexique (le)','MX'),(145,'Micron├®sie (├ëtats f├®d├®r├®s de)','FM'),(146,'Moldova (la R├®publique de)','MD'),(147,'Monaco','MC'),(148,'Mongolie (la)','MN'),(149,'Mont├®n├®gro (le)','ME'),(150,'Montserrat',''),(151,'Maroc (le)','MA'),(152,'Mozambique (le)','MZ'),(153,'Myanmar (le)','MM'),(154,'Namibie (la)','NA'),(155,'Nauru','NR'),(156,'N├®pal (le)','NP'),(157,'Pays-Bas (les)','NL'),(158,'Nouvelle-Cal├®donie (la)','NC'),(159,'Nouvelle-Z├®lande (la)','NZ'),(160,'Nicaragua (le)','NI'),(161,'Niger (le)','NE'),(162,'Nig├®ria (le)','NG'),(163,'Niue','NU'),(164,'Norfolk (l\'├Äle)','NF'),(165,'Mac├®doine du Nord (la)','MK'),(166,'Mariannes du Nord (les ├Äles)','MP'),(167,'Norv├¿ge (la)','NO'),(168,'Oman','OM'),(169,'Pakistan (le)','PK'),(170,'Palaos (les)','PW'),(171,'Palestine, ├ëtat de','PS'),(172,'Panama (le)','PA'),(173,'Papouasie-Nouvelle-Guin├®e (la)','PG'),(174,'Paraguay (le)','PY'),(175,'P├®rou (le)','PE'),(176,'Philippines (les)','PH'),(177,'Pitcairn','PN'),(178,'Pologne (la)','PL'),(179,'Portugal (le)','PT'),(180,'Porto Rico','PR'),(181,'Qatar (le)','QA'),(182,'R├®union (La)','RE'),(183,'Roumanie (la)','RO'),(184,'Russie (la F├®d├®ration de)','RU'),(185,'Rwanda (le)','RW'),(186,'Saint-Barth├®lemy','BL'),(187,'Sainte-H├®l├¿ne, Ascension et Tristan da Cunha','SH'),(188,'Saint-Kitts-et-Nevis','KN'),(189,'Sainte-Lucie','LC'),(190,'Saint-Martin (partie fran├ºaise)','MF'),(191,'Saint-Pierre-et-Miquelon','PM'),(192,'Saint-Vincent-et-les Grenadines','VC'),(193,'Samoa (le)','WS'),(194,'Saint-Marin','SM'),(195,'Sao Tom├®-et-Principe','ST'),(196,'Arabie saoudite (l\')','SA'),(197,'S├®n├®gal (le)','SN'),(198,'Serbie (la)','RS'),(199,'Seychelles (les)','SC'),(200,'Sierra Leone (la)','SL'),(201,'Singapour','SG'),(202,'Saint-Martin (partie n├®erlandaise)','SX'),(203,'Slovaquie (la)','SK'),(204,'Slov├®nie (la)','SI'),(205,'Salomon (les ├Äles)','SB'),(206,'Somalie (la)','SO'),(207,'Afrique du Sud (l\')','ZA'),(208,'G├®orgie du Sud-et-les ├Äles Sandwich du Sud (la)','GS'),(209,'Soudan du Sud (le)','SS'),(210,'Espagne (l\')','ES'),(211,'Sri Lanka','LK'),(212,'Soudan (le)','SD'),(213,'Suriname (le)','SR'),(214,'Svalbard et l\'├Äle Jan Mayen (le)','SJ'),(215,'Su├¿de (la)','SE'),(216,'Suisse (la)','CH'),(217,'R├®publique arabe syrienne (la)','SY'),(218,'Ta├»wan (Province de Chine)','TW'),(219,'Tadjikistan (le)','TJ'),(220,'Tanzanie (la R├®publique-Unie de)','TZ'),(221,'Tha├»lande (la)','TH'),(222,'Timor-Leste (le)','TL'),(223,'Togo (le)','TG'),(224,'Tokelau (les)','TK'),(225,'Tonga (les)','TO'),(226,'Trinit├®-et-Tobago (la)','TT'),(227,'Tunisie (la)','TN'),(228,'Turquie (la)','TR'),(229,'Turkm├®nistan (le)','TM'),(230,'Turks-et-Ca├»cos (les ├Äles)','TC'),(231,'Tuvalu (les)','TV'),(232,'Ouganda (l\')','UG'),(233,'Ukraine (l\')','UA'),(234,'├ëmirats arabes unis (les)','AE'),(235,'Royaume-Uni de Grande-Bretagne et d\'Irlande du Nord (le)','GB'),(236,'├Äles mineures ├®loign├®es des ├ëtats-Unis (les)','UM'),(237,'├ëtats-Unis d\'Am├®rique (les)','US'),(238,'Uruguay (l\')','UY'),(239,'Ouzb├®kistan (l\')','UZ'),(240,'Vanuatu (le)','VU'),(241,'Venezuela (R├®publique bolivarienne du)','VE'),(242,'Viet Nam (le)','VN'),(243,'Vierges britanniques (les┬á├Äles)','VG'),(244,'Vierges des ├ëtats-Unis (les ├Äles)','VI'),(245,'Wallis-et-Futuna','WF'),(246,'Sahara occidental (le)*','EH'),(247,'Y├®men (le)','YE'),(248,'Zambie (la)','ZM'),(249,'Zimbabwe (le)','ZW');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cron_job`
--

DROP TABLE IF EXISTS `cron_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cron_job` (
  `id_cron_job` int NOT NULL AUTO_INCREMENT,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `limit` int DEFAULT NULL,
  `offset` int DEFAULT NULL,
  `running` smallint unsigned NOT NULL,
  `success` smallint unsigned NOT NULL,
  `started_at` int unsigned DEFAULT NULL,
  `ended_at` int unsigned DEFAULT NULL,
  `last_execution_time` float DEFAULT NULL,
  PRIMARY KEY (`id_cron_job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cron_job`
--

LOCK TABLES `cron_job` WRITE;
/*!40000 ALTER TABLE `cron_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `cron_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('Da\\User\\Migration\\m000000_000001_create_user_table',1686334950),('Da\\User\\Migration\\m000000_000002_create_profile_table',1686334950),('Da\\User\\Migration\\m000000_000003_create_social_account_table',1686334951),('Da\\User\\Migration\\m000000_000004_create_token_table',1686334951),('Da\\User\\Migration\\m000000_000005_add_last_login_at',1686334951),('Da\\User\\Migration\\m000000_000006_add_two_factor_fields',1686334951),('Da\\User\\Migration\\m000000_000007_enable_password_expiration',1686334951),('Da\\User\\Migration\\m000000_000008_add_last_login_ip',1686334951),('Da\\User\\Migration\\m000000_000009_add_gdpr_consent_fields',1686334951),('Da\\User\\Migration\\m000000_000010_add_auth_tf_type_auth_tf_mobile_phone_columns_to_user_table',1686334951),('m000000_000000_base',1686334947),('m140506_102106_rbac_init',1686335004),('m150927_060316_cronjob_init',1686463654),('m170907_052038_rbac_add_index_on_auth_assignment_user_id',1686335004),('m180523_151638_rbac_updates_indexes_without_prefix',1686335004),('m200409_110543_rbac_update_mssql_trigger',1686335004),('m210609_120000_my_migration',1686346610);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `user_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `public_email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `gravatar_email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `gravatar_id` varchar(32) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timezone` varchar(40) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_profile_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL,
  `job` blob NOT NULL,
  `pushed_at` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `reserved_at` int DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `done_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel` (`channel`),
  KEY `reserved_at` (`reserved_at`),
  KEY `priority` (`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=23152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_account`
--

DROP TABLE IF EXISTS `social_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `client_id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` varchar(32) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8mb3_unicode_ci,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_social_account_provider_client_id` (`provider`,`client_id`),
  UNIQUE KEY `idx_social_account_code` (`code`),
  KEY `fk_social_account_user` (`user_id`),
  CONSTRAINT `fk_social_account_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_account`
--

LOCK TABLES `social_account` WRITE;
/*!40000 ALTER TABLE `social_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_data`
--

DROP TABLE IF EXISTS `temp_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `temperature` varchar(100) NOT NULL,
  `cityid` int NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `temp_data_FK` (`cityid`),
  CONSTRAINT `temp_data_FK` FOREIGN KEY (`cityid`) REFERENCES `city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_data`
--

LOCK TABLES `temp_data` WRITE;
/*!40000 ALTER TABLE `temp_data` DISABLE KEYS */;
INSERT INTO `temp_data` VALUES (110,'-50',2,'2023-06-11 07:25:35'),(111,'-50',3,'2023-06-11 07:25:36'),(197,'23.11',2,'2023-06-11 20:33:05'),(198,'22.6',3,'2023-06-11 20:33:05');
/*!40000 ALTER TABLE `temp_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `user_id` int DEFAULT NULL,
  `code` varchar(32) COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` smallint NOT NULL,
  `created_at` int NOT NULL,
  UNIQUE KEY `idx_token_user_id_code_type` (`user_id`,`code`,`type`),
  CONSTRAINT `fk_token_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (3,'VSD4Ol2MT9GVayhiAGg8yTerWq0EK3xG',1,1686471586);
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `password_hash` varchar(60) COLLATE utf8mb3_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8mb3_unicode_ci NOT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `registration_ip` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `flags` int NOT NULL DEFAULT '0',
  `confirmed_at` int DEFAULT NULL,
  `blocked_at` int DEFAULT NULL,
  `updated_at` int NOT NULL,
  `created_at` int NOT NULL,
  `last_login_at` int DEFAULT NULL,
  `last_login_ip` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_tf_key` varchar(16) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_tf_enabled` tinyint(1) DEFAULT '0',
  `auth_tf_type` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_tf_mobile_phone` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password_changed_at` int DEFAULT NULL,
  `gdpr_consent` tinyint(1) DEFAULT '0',
  `gdpr_consent_date` int DEFAULT NULL,
  `gdpr_deleted` tinyint(1) DEFAULT '0',
  `cityid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_username` (`username`),
  UNIQUE KEY `idx_user_email` (`email`),
  KEY `user_FK` (`cityid`),
  CONSTRAINT `user_FK` FOREIGN KEY (`cityid`) REFERENCES `city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'admin','email@example.com','$2y$10$ZRvqispXsTtJVv988Ac60OxyC/GqO.OoTIXt0loiFlCr3NAEHqsvS','tAgLQ2_kmSODpFwdiNJLBqB_dqa6MFex',NULL,NULL,0,1686346610,NULL,1686346610,1686346610,1686517355,'127.0.0.1','',0,NULL,NULL,1686346610,0,NULL,0,3),(3,'Bob','bob@gmail.com','$2y$10$nQAnSxq8l/nrQ8U3PrR1wejj1ubdZVT9iF3tszX/fCZ4/qF///Z7e','Hg-tYpLce4UepvkTQpSt-N-640TQp5xD',NULL,'127.0.0.1',0,1686412975,NULL,1686430197,1686412975,1686514324,'127.0.0.1','',0,NULL,NULL,1686412975,0,NULL,0,2),(4,'Roger','roger@gmail.com','$2y$10$o6LANPEsIO4TqoSWu8Kt8eMgX46hfZCRc5n8fxV2DG6wsIFHh/YRi','RySKQRej0a8ZitKevaK3xphMywMaI-id',NULL,'127.0.0.1',0,1686450153,NULL,1686451051,1686450153,1686450162,'127.0.0.1','',0,NULL,NULL,1686450153,0,NULL,0,3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'pneus_hiver'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-11 23:39:15
