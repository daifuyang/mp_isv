-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: tenant_487934091
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Current Database: `tenant_487934091`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenant_487934091` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tenant_487934091`;

--
-- Table structure for table `cmf_address`
--

DROP TABLE IF EXISTS `cmf_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `gender` tinyint(3) NOT NULL DEFAULT '0' COMMENT '性别',
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `room` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '门牌号',
  `default` tinyint(3) NOT NULL COMMENT '默认',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `latitude` decimal(10,7) NOT NULL COMMENT '纬度',
  `longitude` decimal(10,7) NOT NULL COMMENT '经度',
  `user_id` bigint(20) NOT NULL COMMENT '所属用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_address`
--

LOCK TABLES `cmf_address` WRITE;
/*!40000 ALTER TABLE `cmf_address` DISABLE KEYS */;
INSERT INTO `cmf_address` VALUES (4,'戴富阳1111',1,'15161178722','上海市宝山区殷高西路逸景佳苑','12-1002',0,0,0.0000000,0.0000000,0),(6,'戴富阳',1,'13601116703','济南市槐荫区老槐树舌尖上的美味铁板鱿鱼','1-001',0,0,0.0000000,0.0000000,0),(7,'戴富阳1111',1,'15161178722','上海市宝山区殷高西路逸景佳苑','12-1002',0,0,0.0000000,0.0000000,0),(8,'陈泽凡',1,'13601486703','纬十二路67-1号附近齐鲁晚报南辛庄中心发行站','011',0,0,0.0000000,0.0000000,0),(9,'戴富样',1,'15161178722','上海市宝山区殷高西路逸景佳苑','12-1002',0,0,0.0000000,0.0000000,0),(10,'陈小鸟',1,'13601486703','三角线街20号铁程幼儿园','1-001',0,0,0.0000000,0.0000000,0),(20,'戴富阳',0,'17625458589','上海市宝山区高境镇逸景佳苑','22-1001',1,487934091,31.3233510,121.4823410,0);
/*!40000 ALTER TABLE `cmf_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_admin_notice`
--

DROP TABLE IF EXISTS `cmf_admin_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_admin_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知标题',
  `desc` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '通知描述',
  `create_at` int(10) DEFAULT '0' COMMENT '创建时间',
  `type` tinyint(3) DEFAULT '0' COMMENT '类型（0 => 订单）',
  `status` tinyint(3) DEFAULT '0' COMMENT '状态（0 => 未读，1 => 已读）',
  `audio` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '通知提示音',
  `target_id` bigint(20) DEFAULT NULL COMMENT '目标id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_notice`
--

LOCK TABLES `cmf_admin_notice` WRITE;
/*!40000 ALTER TABLE `cmf_admin_notice` DISABLE KEYS */;
INSERT INTO `cmf_admin_notice` VALUES (1,'堂食订单通知','',1609922163,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(2,'堂食订单通知','',1609922163,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(3,'堂食订单通知','',1609922164,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(4,'堂食订单通知','',1609922164,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(5,'堂食订单通知','',1609922286,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(6,'堂食订单通知','',1609922287,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(7,'堂食订单通知','',1609922287,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(8,'堂食订单通知','',1609922287,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(9,'堂食订单通知','',1609922370,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(10,'堂食订单通知','',1609922497,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(11,'堂食订单通知','',1609923040,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(12,'堂食订单通知','',1609923125,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(13,'堂食订单通知','',1609923706,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(14,'堂食订单通知','',1609923823,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(15,'堂食订单通知','',1609927345,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(16,'堂食订单通知','',1609927445,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(17,'堂食订单通知','',1609934628,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(18,'堂食订单通知','',1609934707,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(19,'堂食订单通知','',1609949785,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(20,'堂食订单通知','',1609949785,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(21,'堂食订单通知','',1609949786,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(22,'堂食订单通知','',1609949786,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(23,'堂食订单通知','',1609949950,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(24,'堂食订单通知','',1609950632,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(25,'堂食订单通知','',1609951309,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(26,'堂食订单通知','',1609954959,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(27,'堂食订单通知','',1609956274,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(28,'堂食订单通知','',1609956370,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(29,'堂食订单通知','',1609962195,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(30,'堂食订单通知','',1609983845,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(31,'堂食订单通知','',1610010305,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(32,'堂食订单通知','',1610010456,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(33,'堂食订单通知','',1610037922,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(34,'外卖订单提醒','',1610080832,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(35,'外卖订单提醒','',1610080833,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(36,'外卖订单提醒','',1610080833,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(37,'外卖订单提醒','',1610080834,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(38,'外卖订单提醒','',1610080990,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(39,'外卖订单提醒','',1610081186,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(40,'外卖订单提醒','',1610081186,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(41,'外卖订单提醒','',1610081186,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(42,'外卖订单提醒','',1610081187,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(43,'外卖订单提醒','',1610081358,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(44,'外卖订单提醒','',1610081685,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(45,'外卖订单提醒','',1610082046,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(46,'外卖订单提醒','',1610082323,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(47,'外卖订单提醒','',1610082694,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(48,'外卖订单提醒','',1610085982,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(49,'外卖订单提醒','',1610086360,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(50,'堂食订单通知','',1610091652,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(51,'堂食订单通知','',1610091652,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(52,'堂食订单通知','',1610091653,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(53,'堂食订单通知','',1610091653,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(54,'外卖订单提醒','',1610091722,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(55,'外卖订单提醒','',1610091723,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(56,'外卖订单提醒','',1610091723,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(57,'外卖订单提醒','',1610091724,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(58,'堂食订单通知','',1610091808,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(59,'外卖订单提醒','',1610091927,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(60,'外卖订单提醒','',1610091970,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(61,'外卖订单提醒','',1610091971,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(62,'外卖订单提醒','',1610091971,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(63,'外卖订单提醒','',1610091972,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(64,'外卖订单提醒','',1610092169,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(65,'堂食订单通知','',1610092476,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(66,'外卖订单提醒','',1610092601,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(67,'外卖订单提醒','',1610092814,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(68,'堂食订单通知','',1610093126,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(69,'外卖订单提醒','',1610093222,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(70,'外卖订单提醒','',1610093233,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(71,'外卖订单提醒','',1610093510,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(72,'外卖订单提醒','',1610093591,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(73,'堂食订单通知','',1610096807,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(74,'外卖订单提醒','',1610096897,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(75,'外卖订单提醒','',1610097159,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(76,'堂食订单通知','',1610104027,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(77,'外卖订单提醒','',1610104187,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(78,'外卖订单提醒','',1610104400,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(79,'外卖订单提醒','',1610114928,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(80,'外卖订单提醒','',1610115259,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(81,'堂食订单通知','',1610125730,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(82,'外卖订单提醒','',1610125817,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(83,'外卖订单提醒','',1610126073,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(84,'堂食订单通知','',1610161471,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(85,'堂食订单通知','',1610161472,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(86,'堂食订单通知','',1610161472,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(87,'堂食订单通知','',1610161472,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(88,'堂食订单通知','',1610161671,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(89,'堂食订单通知','',1610162330,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(90,'堂食订单通知','',1610162968,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(91,'堂食订单通知','',1610166619,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(92,'外卖订单提醒','',1610168981,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(93,'外卖订单提醒','',1610169317,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(94,'堂食订单通知','',1610173882,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(95,'堂食订单通知','',1610179751,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(96,'外卖订单提醒','',1610179907,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(97,'外卖订单提醒','',1610180127,0,0,'https://v.hji5.com/codecloud/n2.mp3',NULL),(98,'堂食订单通知','',1610195554,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(99,'堂食订单通知','',1610249623,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(100,'堂食订单通知','',1610724672,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(101,'堂食订单通知','',1610724725,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(102,'堂食订单通知','',1610724725,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(103,'堂食订单通知','',1610724726,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(104,'堂食订单通知','',1610724726,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(105,'堂食订单通知','',1610724908,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(106,'堂食订单通知','',1610725566,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(107,'堂食订单通知','',1610726266,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(108,'堂食订单通知','',1610729928,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(109,'堂食订单通知','',1610737148,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(110,'堂食订单通知','',1610758849,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(111,'堂食订单通知','',1610812898,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(112,'堂食订单通知','',1610986515,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(113,'堂食订单通知','',1610986536,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(114,'堂食订单通知','',1611298457,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(115,'堂食订单通知','',1611298457,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(116,'堂食订单通知','',1611298457,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(117,'堂食订单通知','',1611298458,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(118,'堂食订单通知','',1611298646,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(119,'堂食订单通知','',1611299298,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(120,'堂食订单通知','',1611299942,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(121,'堂食订单通知','',1611303647,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(122,'堂食订单通知','',1611310910,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(123,'堂食订单通知','',1611332527,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(124,'堂食订单通知','',1611386627,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(125,'堂食订单通知','',1612961109,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(126,'堂食订单通知','',1612961109,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(127,'堂食订单通知','',1612961110,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(128,'堂食订单通知','',1612961110,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(129,'堂食订单通知','',1612961277,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(130,'堂食订单通知','',1612961277,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(131,'堂食订单通知','',1612961278,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(132,'堂食订单通知','',1612961278,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(133,'堂食订单通知','',1612961330,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(134,'堂食订单通知','',1612961411,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(135,'堂食订单通知','',1612961978,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(136,'堂食订单通知','',1612962082,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(137,'堂食订单通知','',1612962607,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(138,'堂食订单通知','',1612962755,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(139,'堂食订单通知','',1612966294,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(140,'堂食订单通知','',1612966397,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(141,'堂食订单通知','',1612973528,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(142,'堂食订单通知','',1612973653,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(143,'堂食订单通知','',1612995213,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(144,'堂食订单通知','',1612995308,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(145,'堂食订单通知','',1613021642,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(146,'堂食订单通知','',1613049280,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(147,'堂食订单通知','',1613049389,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(148,'堂食订单通知','',1613185010,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(149,'堂食订单通知','',1613185010,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(150,'堂食订单通知','',1613185011,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(151,'堂食订单通知','',1613185011,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(152,'堂食订单通知','',1613185145,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(153,'堂食订单通知','',1613185845,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(154,'堂食订单通知','',1613186503,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(155,'堂食订单通知','',1613190167,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(156,'堂食订单通知','',1613197401,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(157,'堂食订单通知','',1613209789,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(158,'堂食订单通知','',1613209790,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(159,'堂食订单通知','',1613209790,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(160,'堂食订单通知','',1613209791,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(161,'堂食订单通知','',1613209927,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(162,'堂食订单通知','',1613210130,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(163,'堂食订单通知','',1613210131,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(164,'堂食订单通知','',1613210131,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(165,'堂食订单通知','',1613210132,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(166,'堂食订单通知','',1613210301,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(167,'堂食订单通知','',1613210587,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(168,'堂食订单通知','',1613210978,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(169,'堂食订单通知','',1613211244,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(170,'堂食订单通知','',1613211603,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(171,'堂食订单通知','',1613214945,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(172,'堂食订单通知','',1613215280,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(173,'堂食订单通知','',1613219072,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(174,'堂食订单通知','',1613222172,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(175,'堂食订单通知','',1613222551,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(176,'堂食订单通知','',1613224894,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(177,'堂食订单通知','',1613224895,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(178,'堂食订单通知','',1613224895,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(179,'堂食订单通知','',1613224896,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(180,'堂食订单通知','',1613225071,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(181,'堂食订单通知','',1613225708,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(182,'堂食订单通知','',1613226388,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(183,'堂食订单通知','',1613230041,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(184,'堂食订单通知','',1613237283,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(185,'堂食订单通知','',1613243865,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(186,'堂食订单通知','',1613244212,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(187,'堂食订单通知','',1613258945,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(188,'堂食订单通知','',1613273119,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(189,'堂食订单通知','',1613297898,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(190,'堂食订单通知','',1613298247,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(191,'堂食订单通知','',1613313009,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(192,'堂食订单通知','',1613390340,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(193,'堂食订单通知','',1613445855,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(194,'堂食订单通知','',1613445866,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(195,'堂食订单通知','',1613446206,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(196,'堂食订单通知','',1613467190,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(197,'堂食订单通知','',1613467345,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(198,'堂食订单通知','',1613467659,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(199,'堂食订单通知','',1613467708,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(200,'堂食订单通知','',1613491869,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(201,'堂食订单通知','',1613493724,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(202,'堂食订单通知','',1613494031,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(203,'堂食订单通知','',1613494288,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(204,'堂食订单通知','',1613494345,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(205,'堂食订单通知','',1613639634,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(206,'堂食订单通知','',1613640689,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(207,'堂食订单通知','',1613744256,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(208,'堂食订单通知','',1613744520,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(209,'堂食订单通知','',1613745402,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(210,'堂食订单通知','',1613745442,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL),(211,'堂食订单通知','',1613746007,0,0,'https://v.hji5.com/codecloud/n1.mp3',NULL);
/*!40000 ALTER TABLE `cmf_admin_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_asset`
--

DROP TABLE IF EXISTS `cmf_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_asset` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  `file_size` int(11) NOT NULL COMMENT '文件大小',
  `create_at` int(10) DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) DEFAULT '1' COMMENT '文件状态',
  `file_key` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件惟一码',
  `remark_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名',
  `file_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名',
  `file_path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `suffix` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件后缀',
  `type` tinyint(3) NOT NULL COMMENT '资源类型',
  `more` text COLLATE utf8mb4_general_ci COMMENT '更多配置',
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,51738,1605231168,0,'618caaec-7f11-46f2-4a02-a8772c11177a','菜品图.png','00900b430403560d879a7cfce98e94ef.png','default/20201113/00900b430403560d879a7cfce98e94ef.png','png',0,'',0),(2,1,403521,1605236495,0,'2f4ffd2a-8ee1-4bcc-4d81-ef58531c262d','2.jpg','585c553908da29c8677bb7d644691354.jpg','default/20201113/585c553908da29c8677bb7d644691354.jpg','jpg',0,'',0),(3,1,403521,1606206438,0,'03a64ffb-b199-470b-50e0-2108548ef8da','2.jpg','94fc07f6753043e024a6fe040ce07ea3.jpg','default/20201124/94fc07f6753043e024a6fe040ce07ea3.jpg','jpg',0,'',0),(4,1,403521,1606207267,0,'ac8864ee-ffe9-4255-4c11-cb8358052779','2.jpg','d48509c274c0f34264a59388f574dbeb.jpg','default/20201124/d48509c274c0f34264a59388f574dbeb.jpg','jpg',0,'',0),(5,1,403521,1606271800,0,'ed65d40a-9ab6-4cb4-6b0d-2998ab5224c3','2.jpg','5db9e8a1dfcf9dbcf138a9160ab88b8a.jpg','default/20201125/5db9e8a1dfcf9dbcf138a9160ab88b8a.jpg','jpg',0,'',0),(6,1,403521,1606283766,1,'c6d92e66-01e5-4768-5091-0031c8095405','2.jpg','d3ac00bdfc36ead5d8b358dd9828d133.jpg','default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','jpg',0,'',0),(7,1,27462,1606286282,1,'55c10fe8-20d7-471e-6d5a-f00d3e3ee19c','bookBanner.jpg','373c7f9acf2e8673b9de3797d973a5de.jpg','default/20201125/373c7f9acf2e8673b9de3797d973a5de.jpg','jpg',0,'',0),(8,1,80749,1606722008,1,'9665bd9d-e55c-47e6-63a9-f73ce2e6a10a','pgb.jpeg','235a65e1559686601cb721bce6659dd3.jpeg','default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','jpeg',0,'',0),(9,1,82339,1606722629,1,'bc7bac3d-010b-4174-6bad-3035102bfd30','timg.jpeg','57b4b6ac13c16b6f5c22c673746c27a7.jpeg','default/20201130/57b4b6ac13c16b6f5c22c673746c27a7.jpeg','jpeg',0,'',0),(10,1,110198,1607049638,1,'407bc102-d6a3-4cd1-7752-196a17cbc9db','timg (1).jpeg','f5102b01d6bb14b1da0bce3f5d72c3e7.jpeg','default/20201204/f5102b01d6bb14b1da0bce3f5d72c3e7.jpeg','jpeg',0,'',0),(11,1,48848,1607049878,1,'1c0cb1be-867e-4a31-4b46-86329bf54bb7','黄焖鸡.jpg','11557a98fb0f20ccbd29e70cba480e4d.jpg','default/20201204/11557a98fb0f20ccbd29e70cba480e4d.jpg','jpg',0,'',0),(12,1,175973,1607050202,1,'b875a72f-aa4d-4b2a-4882-60912fe922df','jyzs.jpg','dbc15663a2a8292ee873e3c73e7b1a91.jpg','default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','jpg',0,'',0),(13,1,132867,1607050315,1,'94c72a9d-2e9f-47b4-6873-cf580325d487','jhcjd.jpg','5c039573c7e51b4a42bf66bc3caebc29.jpg','default/20201204/5c039573c7e51b4a42bf66bc3caebc29.jpg','jpg',0,'',0),(14,1,156755,1607050388,1,'b4ba8213-f4c5-4697-4c3d-29a300e620f8','川味回锅肉.jpg','dd1a8e873a3ee7afe905fc36dc68fab6.jpg','default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','jpg',0,'',0),(15,1,101243,1607050454,1,'d6a7d01b-1b33-4dbb-7e7c-2cba59710861','ksj.jpg','79bc3ce4984de1ae8336dd90f48fb8af.jpg','default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','jpg',0,'',0),(16,1,80237,1607052022,1,'f6ca1730-e14e-45ba-7a87-e4f93f741184','kz.jpg','6d66aef5065ff247de27668080c171f5.jpg','default/20201204/6d66aef5065ff247de27668080c171f5.jpg','jpg',0,'',0),(17,1,130916,1607052206,1,'27a13997-1b77-4b3c-63c1-501f330a78b9','paitiao.jpg','6ccf79170769750171c619d17dc856ea.jpg','default/20201204/6ccf79170769750171c619d17dc856ea.jpg','jpg',0,'',0),(18,1,241855,1607052802,1,'8f4bca1c-f656-4371-62ad-28e94ac252eb','mxw.jpg','2f7c355ef9f8d859a7e21f9b31780ee6.jpg','default/20201204/2f7c355ef9f8d859a7e21f9b31780ee6.jpg','jpg',0,'',0),(19,1,156755,1607052887,1,'de78540f-77bc-40aa-72ae-c5a6999fb76d','cwhgr.jpg','1642809aaf1cb8fe33a89e2de74ee178.jpg','default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','jpg',0,'',0),(20,1,59748,1607916627,0,'0b79bcb8-922f-4f81-7739-a16298c4cf5d','logo.jpg','fe0371a4b70019895a8c507a15de502e.jpg','default/20201214/fe0371a4b70019895a8c507a15de502e.jpg','jpg',0,'',0),(21,1,403521,1608277442,1,'c1d92008-e7dc-411b-7deb-30ef16ed4f44','2.jpg','48adbcedc8763ee76eefea3182f0ac93.jpg','default/20201218/48adbcedc8763ee76eefea3182f0ac93.jpg','jpg',0,'',0),(22,1,403521,1608277453,0,'1b6143ce-c10e-4071-758d-eb528f814c81','2.jpg','07325aa8d8e75423619d05ea85e2cd05.jpg','default/20201218/07325aa8d8e75423619d05ea85e2cd05.jpg','jpg',0,'',0),(23,1,403521,1608277487,0,'94c25187-fa81-4f89-4e9a-849a245ed1e2','2.jpg','7f9fece45ca70d1355207cd32010f49a.jpg','default/20201218/7f9fece45ca70d1355207cd32010f49a.jpg','jpg',0,'',0),(24,1,403521,1608277517,0,'3756ea76-f0b9-4282-4c39-4756a517416d','2.jpg','27afef9e7ca225ce8e7f08c49adea6ef.jpg','default/20201218/27afef9e7ca225ce8e7f08c49adea6ef.jpg','jpg',0,'',0),(25,1,403521,1608277551,0,'279ff17e-7447-4d87-48a1-9e45ea7dab9a','2.jpg','3af192bf076d6c3eab48ad132aa81648.jpg','default/20201218/3af192bf076d6c3eab48ad132aa81648.jpg','jpg',0,'',0),(26,1,59748,1608281463,1,'e17ddc86-63c8-407c-42c7-c5fdf73d2b2b','logo.jpg','f9d6070cb291a0c75159fe06fafdf6f8.jpg','default/20201218/f9d6070cb291a0c75159fe06fafdf6f8.jpg','jpg',0,'',0),(27,1,59748,1609835914,0,'cb823014-28f1-4b38-6d2e-3e39ea46ef7a','logo.jpg','10226dadb0cb24dceaa99fe9fbe32271.jpg','default/20210105/10226dadb0cb24dceaa99fe9fbe32271.jpg','jpg',0,'',0),(28,1,2937808,1610982148,1,'f5599391-02dd-4dca-6f16-b78d1579ccbb','馄饨.png','49626f1de2ac9449a82825d7d3f604e4.png','default/20210118/49626f1de2ac9449a82825d7d3f604e4.png','png',0,'',0),(29,1,11255,1610982188,1,'f93fd172-3570-41f0-6426-db579cac432a','waimai.png','3e375dbbd122fee68858e3af58ef8998.png','default/20210118/3e375dbbd122fee68858e3af58ef8998.png','png',0,'',0),(30,1,4450,1610982197,1,'fcc378b6-0bff-4bb8-54f9-c328dcc286fd','eatin.png','b0db6c0ed62c591b99678dfc4b58f021.png','default/20210118/b0db6c0ed62c591b99678dfc4b58f021.png','png',0,'',0),(31,1,9332,1610982238,1,'a3dfce5b-6c0b-4580-577e-b317b91e9df4','矩形 15 拷贝 3@2x.png','cd0de6d7e4dd8043580c972c304a662d.png','default/20210118/cd0de6d7e4dd8043580c972c304a662d.png','png',0,'',0),(32,1,284926,1611664355,1,'39347260-9eaa-41c7-52af-947a21dde84f','矩形 16 拷贝 2.png','63c728946a7ac94e1b56ac2582d4ee72.png','default/20210126/63c728946a7ac94e1b56ac2582d4ee72.png','png',0,'',0),(33,1,284926,1611664365,1,'1ec4a565-5d16-4d51-6bf4-b00202c27901','矩形 16 拷贝 2.png','35e71bab15cb5d35ec16e5a018aacb9d.png','default/20210126/35e71bab15cb5d35ec16e5a018aacb9d.png','png',0,'',0),(34,1,2937808,1614566600,0,'7039d42e-93f0-433d-6b05-19ab493ee25c','混沌.png','25b6a17c6b27d9cff4b8e8fdcdfadcb4.png','tenant/487934091/20210301/25b6a17c6b27d9cff4b8e8fdcdfadcb4.png','png',0,'',487934091),(35,1,2937808,1614566717,1,'bd4cb4b4-29dc-4992-65d9-529b9f88849f','混沌.png','f899cd05c1466def1742fb965b40c74f.png','tenant/487934091/20210301/f899cd05c1466def1742fb965b40c74f.png','png',0,'',487934091),(36,1,9332,1614566722,1,'98ca7fa4-c08f-4172-449e-7f13da5a54a5','scan.png','a2d3aecd68a1eaa55beefa8f459c57f0.png','tenant/487934091/20210301/a2d3aecd68a1eaa55beefa8f459c57f0.png','png',0,'',487934091),(37,1,4450,1614566727,1,'1f582bb4-f958-4bb5-7c4e-fe86f270203f','eatin.png','a105a2f2b43cf348b000e65a1755d534.png','tenant/487934091/20210301/a105a2f2b43cf348b000e65a1755d534.png','png',0,'',487934091),(38,1,32537,1614566730,1,'6384088a-1d0c-4e01-5bbb-b9fa87217ce4','waimai.png','dbabd9887b67d1895b611a66dd0eeb5c.png','tenant/487934091/20210301/dbabd9887b67d1895b611a66dd0eeb5c.png','png',0,'',487934091),(39,1,49937,1614567057,1,'1ecf7638-9da8-44b4-760f-bd9aa4b24110','牛年快乐.png','9d4e3575cc5719d90a4f9a38473a6a35.png','tenant/487934091/20210301/9d4e3575cc5719d90a4f9a38473a6a35.png','png',0,'',487934091);
/*!40000 ALTER TABLE `cmf_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_auth_access`
--

DROP TABLE IF EXISTS `cmf_auth_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_auth_access` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `rule_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规则唯一英文标识,全小写',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_access`
--

LOCK TABLES `cmf_auth_access` WRITE;
/*!40000 ALTER TABLE `cmf_auth_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_auth_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_auth_rule`
--

DROP TABLE IF EXISTS `cmf_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_auth_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '额外url参数',
  `title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规则描述',
  `status` tinyint(3) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule`
--

LOCK TABLES `cmf_auth_rule` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule` DISABLE KEYS */;
INSERT INTO `cmf_auth_rule` VALUES (1,'app/dashboard','','',1),(2,'app/published','','',1),(3,'app/order/default','','',1),(4,'app/dishes','','',1),(5,'app/desk/default','','',1),(6,'app/member/default','','',1),(7,'app/marketing','','',1),(8,'app/theme/default','','',1),(9,'portal/default','','',1),(10,'app/store','','',1),(11,'app/user','','',1),(12,'app/settings/default','','',1),(13,'app/notice','','',1),(14,'app/store/edit_for_here','','',1);
/*!40000 ALTER TABLE `cmf_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_auth_rule_api`
--

DROP TABLE IF EXISTS `cmf_auth_rule_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_auth_rule_api` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `auth_rule_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规则唯一英文标识,全小写',
  `url` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '额外url参数',
  `status` tinyint(3) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule_api`
--

LOCK TABLES `cmf_auth_rule_api` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule_api` DISABLE KEYS */;
INSERT INTO `cmf_auth_rule_api` VALUES (1,'app/dashboard','/api/v1/admin/dashboard/analysis','',1),(2,'app/dashboard','/api/v1/admin/dashboard/sales_ranking','',1);
/*!40000 ALTER TABLE `cmf_auth_rule_api` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_card`
--

DROP TABLE IF EXISTS `cmf_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_card` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `card_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员卡名称',
  `card_show_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包端显示名称',
  `card_background` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡片背景图片',
  `alipay_background_id` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL COMMENT '背景图片Id',
  `valid_period` int(11) NOT NULL COMMENT '有效期',
  `benefit_info` json DEFAULT NULL COMMENT '权益说明',
  `create_at` int(11) DEFAULT NULL,
  `update_at` int(11) DEFAULT NULL,
  `delete_at` int(10) DEFAULT '0' COMMENT '''删除时间''',
  `template_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板ID',
  `sync_to_alipay` tinyint(2) NOT NULL DEFAULT '0' COMMENT '同步到支付宝卡包',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_card`
--

LOCK TABLES `cmf_card` WRITE;
/*!40000 ALTER TABLE `cmf_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_card_template`
--

DROP TABLE IF EXISTS `cmf_card_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_card_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `card_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员卡名称',
  `card_show_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包端显示名称',
  `card_background` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡片背景图片',
  `alipay_background_id` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL COMMENT '背景图片Id',
  `valid_period` int(11) NOT NULL COMMENT '有效期',
  `benefit_info` json DEFAULT NULL COMMENT '权益说明',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` int(10) DEFAULT '0' COMMENT '''删除时间''',
  `template_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板ID',
  `sync_to_alipay` tinyint(2) NOT NULL DEFAULT '0' COMMENT '同步到支付宝卡包',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_card_template`
--

LOCK TABLES `cmf_card_template` WRITE;
/*!40000 ALTER TABLE `cmf_card_template` DISABLE KEYS */;
INSERT INTO `cmf_card_template` VALUES (1,'嗨吃卡','嗨吃卡','template/vip.png','L95pKI64T1SUgK9rJzOtBgAAACMAAQQD',30,'[{\"title\": \"会员须知\", \"benefit_desc\": [\"嗨吃卡早用早省\"]}]',1609749249,1609749249,0,'20201228000000002607585000300615',1,1,487934091);
/*!40000 ALTER TABLE `cmf_card_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_desk`
--

DROP TABLE IF EXISTS `cmf_desk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_desk` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '座位名称',
  `category_id` int(11) NOT NULL COMMENT '对应小程序id',
  `category_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应小程序id',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '桌位状态',
  `list_order` double NOT NULL DEFAULT '10000' COMMENT '排序',
  `desk_number` bigint(20) NOT NULL COMMENT '桌位编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_desk`
--

LOCK TABLES `cmf_desk` WRITE;
/*!40000 ALTER TABLE `cmf_desk` DISABLE KEYS */;
INSERT INTO `cmf_desk` VALUES (1,487934091,1,'1号（4人）',1,'莲花厅（4人桌位）',0,0,0),(2,487934091,1,'2号（4人）',1,'莲花厅（4人桌位）',1,10000,0),(3,487934091,1,'3号（4人）',1,'莲花厅（4人桌位）',1,10000,0);
/*!40000 ALTER TABLE `cmf_desk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_desk_category`
--

DROP TABLE IF EXISTS `cmf_desk_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_desk_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `category_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '座位名称',
  `least_seats` int(2) NOT NULL COMMENT '最少人数',
  `maximum_seats` int(2) NOT NULL COMMENT '最多人数',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_desk_category`
--

LOCK TABLES `cmf_desk_category` WRITE;
/*!40000 ALTER TABLE `cmf_desk_category` DISABLE KEYS */;
INSERT INTO `cmf_desk_category` VALUES (1,487934091,'莲花厅（4人桌位）',3,4,0),(2,487934091,'VIP厅（10人桌）',6,10,0);
/*!40000 ALTER TABLE `cmf_desk_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_exp_log`
--

DROP TABLE IF EXISTS `cmf_exp_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_exp_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  `exp` int(11) NOT NULL COMMENT '增加积分',
  `fee` varchar(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '合计金额',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_exp_log`
--

LOCK TABLES `cmf_exp_log` WRITE;
/*!40000 ALTER TABLE `cmf_exp_log` DISABLE KEYS */;
INSERT INTO `cmf_exp_log` VALUES (1,10,12330,'0.01','消费',1613494288),(2,10,7920,'0.01','消费',1613494345),(3,11,0,'0.01','消费',1613640689),(4,11,5,'0.01','储值',1613641205),(5,1,7920,'0.01','消费',1613744256),(6,1,7920,'0.01','消费',1613744520),(7,1,7920,'0.01','消费',1613745402),(8,1,7920,'0.01','消费',1613745442),(9,1,7920,'0.01','消费',1613746008);
/*!40000 ALTER TABLE `cmf_exp_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food`
--

DROP TABLE IF EXISTS `cmf_food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应小程序id',
  `food_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品唯一编号',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品名称',
  `use_sku` tinyint(3) NOT NULL DEFAULT '0' COMMENT '启用规格',
  `use_tasty` tinyint(3) NOT NULL DEFAULT '0' COMMENT '启用口味',
  `tasty` text COLLATE utf8mb4_general_ci COMMENT '口味',
  `use_member` tinyint(3) NOT NULL COMMENT '是否启用菜品会员价',
  `member_price` decimal(9,2) NOT NULL COMMENT '菜品会员价',
  `use_material` tinyint(3) NOT NULL DEFAULT '0' COMMENT '启用加料',
  `original_price` decimal(9,2) NOT NULL COMMENT '菜品原价',
  `price` decimal(9,2) NOT NULL COMMENT '菜品售价',
  `box_fee` decimal(9,2) NOT NULL COMMENT '餐盒费',
  `inventory` int(11) DEFAULT NULL COMMENT '库存',
  `volume` int(11) DEFAULT NULL COMMENT '销量',
  `start_sale` tinyint(3) NOT NULL DEFAULT '1' COMMENT '起售',
  `thumbnail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品缩略图',
  `scene` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支持场景（0 =>全部；1=>堂食；2=>外卖）',
  `is_recommend` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否推荐菜',
  `content` text COLLATE utf8mb4_general_ci,
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` int(10) DEFAULT '0' COMMENT '''删除时间''',
  `status` tinyint(3) DEFAULT NULL COMMENT '菜品状态',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `default_inventory` int(11) DEFAULT NULL COMMENT '默认库存',
  `flavor` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品口味',
  `dish_type` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品类型',
  `cooking_method` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品做法',
  `except` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品摘要',
  `excerpt` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品摘要',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food`
--

LOCK TABLES `cmf_food` WRITE;
/*!40000 ALTER TABLE `cmf_food` DISABLE KEYS */;
INSERT INTO `cmf_food` VALUES (1,'487934091','TB007','红烧肉',0,0,'[]',0,77.00,0,99.00,88.00,0.00,-1,666,1,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg',0,1,'<p>123</p>',1612011595,1612011595,0,1,1,-1,'','','','','好吃吃的红烧肉'),(2,'487934091','111','山药玉米煲龙骨汤',0,0,'[]',0,0.00,0,0.00,42.00,0.00,-1,0,1,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg',0,1,'',1606722188,1606722188,0,1,1,NULL,NULL,NULL,NULL,'',''),(3,'487934091','xg','农家攸香香干',0,0,'[]',0,0.00,0,25.00,12.50,0.00,-1,0,1,'default/20201130/57b4b6ac13c16b6f5c22c673746c27a7.jpeg',0,1,'',1607496266,1607496266,0,0,1,-1,NULL,NULL,NULL,'',''),(4,'487934091','','红烧排骨',1,1,'[{\"attr_key\":\"例：辣度\",\"attr_val\":[\"例：微微辣\",\"例：中辣\"]}]',0,0.00,1,0.00,0.00,0.00,-1,0,1,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg',0,1,'<p>顶顶顶d</p>',1607495298,1607495298,0,0,1,-1,NULL,NULL,NULL,'',''),(5,'487934091','','猪蹄',1,1,'[{\"attr_key\":\"例：辣度\",\"attr_val\":[\"例：微微辣\",\"例：中辣\"]}]',0,0.00,1,0.00,0.00,20.00,-1,0,66,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg',0,1,'<p>宝马奥迪</p>',1606827523,1606827523,1606918369,1,1,NULL,NULL,NULL,NULL,'',''),(6,'487934091','','火鸡',1,1,'[{\"attr_key\":\"例：辣度\",\"attr_val\":[\"例：微微辣\",\"例：中辣\"]}]',0,0.00,1,0.00,0.00,0.00,-1,0,1,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg',2,0,'<p>哈哈x</p>',1607496303,1607496303,0,0,1,-1,NULL,NULL,NULL,'',''),(7,'487934091','','汤粉',1,0,'[]',0,0.00,0,0.00,0.00,0.00,-1,0,1,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg',1,0,'<p>7678</p>',1607496366,1607496366,0,0,1,-1,NULL,NULL,NULL,'',''),(8,'487934091',' ','油炸花生米',1,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"加冰\",\"常温\",\"加热\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"全塘\",\"半糖\",\"无糖\"]}]',0,0.00,1,0.00,20.00,0.00,0,0,1,'',0,0,'',1606923381,1606923381,0,1,1,NULL,NULL,NULL,NULL,'',''),(9,'487934091','','肠粉',1,1,'[{\"attr_key\":\"例：辣度\",\"attr_val\":[\"例：微微辣\",\"例：中辣\"]}]',0,0.00,0,0.00,0.00,0.00,-1,0,1,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg',0,1,'<p>234234</p>',1607496323,1607496323,0,1,1,-1,NULL,NULL,NULL,'',''),(10,'487934091','','油炸大串',1,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"加冰\",\"常温\",\"加热\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"全塘\",\"半糖\",\"无糖\"]}]',0,0.00,1,0.00,20.00,0.00,0,0,1,'',0,0,'<p>油炸大串</p>',1607308949,1607308949,0,1,1,NULL,NULL,NULL,NULL,'',''),(11,'487934091','hmjx','小份黄焖鸡+米饭',1,1,'[{\"attr_key\":\"例：辣度\",\"attr_val\":[\"例：微微辣\",\"例：中辣\"]},{\"attr_key\":\"甜\",\"attr_val\":[\"少糖\",\"多糖\"]}]',0,0.00,1,27.80,18.70,0.00,-1,0,1,'default/20201204/f5102b01d6bb14b1da0bce3f5d72c3e7.jpeg',1,1,'<p>小份黄焖鸡+米饭</p>',1607496333,1607496333,0,0,1,-1,NULL,NULL,NULL,'',''),(12,'487934091','hmjxg','小份黄焖鸡+香菇（含米饭）',0,0,'[]',0,0.00,0,0.00,39.90,0.00,-1,0,1,'default/20201204/11557a98fb0f20ccbd29e70cba480e4d.jpg',1,0,'',1607496342,1607496342,0,1,1,-1,NULL,NULL,NULL,'',''),(13,'487934091','jyzs','椒盐猪手',0,0,'[]',0,0.00,0,0.00,0.00,0.00,-1,0,2,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg',1,1,'',1607050263,1607050263,0,1,1,NULL,NULL,NULL,NULL,'',''),(14,'487934091','jhcjd','韭黄炒鸡蛋',0,0,'[]',0,0.00,0,0.00,0.00,0.00,-1,0,1,'default/20201204/5c039573c7e51b4a42bf66bc3caebc29.jpg',1,1,'',1607496386,1607496386,0,0,1,-1,NULL,NULL,NULL,'',''),(15,'487934091','cwhgfr','川味回锅肉',0,0,'[]',0,0.00,0,0.00,35.00,0.00,-1,0,1,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg',1,1,'',1607050414,1607050414,0,1,1,NULL,NULL,NULL,NULL,'',''),(16,'487934091','gghc','口水鸡',0,0,'[]',0,0.00,0,29.00,0.00,0.00,-1,0,1,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg',1,1,'',1607050521,1607050521,0,1,1,NULL,NULL,NULL,NULL,'',''),(17,'487934091','bxkz','不需要筷子',0,0,'[]',0,0.00,0,0.00,0.00,0.00,-1,0,1,'default/20201204/6d66aef5065ff247de27668080c171f5.jpg',1,1,'',1607496412,1607496412,0,1,1,-1,NULL,NULL,NULL,'',''),(18,'487934091','bxkz1','竹筷（每副仅一人用）',0,0,'[]',0,0.00,0,0.00,0.19,0.00,-1,0,1,'default/20201204/6d66aef5065ff247de27668080c171f5.jpg',0,1,'',1607496448,1607496448,0,0,1,-1,NULL,NULL,NULL,'',''),(19,'487934091','mxw','毛血旺',0,0,'[]',0,0.00,0,0.00,49.00,0.00,-1,0,1,'default/20201204/2f7c355ef9f8d859a7e21f9b31780ee6.jpg',1,1,'',1607052842,1607052842,0,1,1,NULL,NULL,NULL,NULL,'',''),(20,'487934091','cwhgr','川味回锅肉',0,0,'[]',0,0.00,0,0.00,35.00,0.00,-1,0,1,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg',1,1,'<p>川味回锅肉</p>',1607496468,1607496468,0,0,1,-1,NULL,NULL,NULL,'',''),(21,'487934091','','东坡肉',1,1,'[{\"attr_key\":\"辣度\",\"attr_val\":[\"微辣\",\"酸辣\"]}]',0,0.00,1,0.00,0.00,0.00,-1,0,1,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg',0,1,'<p>苏东坡的肉</p>',1607309501,1607309501,0,1,2,NULL,NULL,NULL,NULL,'','');
/*!40000 ALTER TABLE `cmf_food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_attr_key`
--

DROP TABLE IF EXISTS `cmf_food_attr_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_attr_key` (
  `attr_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性名称',
  PRIMARY KEY (`attr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_key`
--

LOCK TABLES `cmf_food_attr_key` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_key` DISABLE KEYS */;
INSERT INTO `cmf_food_attr_key` VALUES (1,'123'),(2,'大份'),(3,'分类一'),(4,'天天'),(5,'大份123'),(6,'大份123123'),(7,'规格一'),(8,'规格二'),(9,'规格三'),(10,'是的'),(11,'12'),(12,'w '),(13,'一店');
/*!40000 ALTER TABLE `cmf_food_attr_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_attr_post`
--

DROP TABLE IF EXISTS `cmf_food_attr_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_attr_post` (
  `attr_post_id` int(11) NOT NULL AUTO_INCREMENT,
  `food_id` int(11) DEFAULT NULL,
  `attr_value_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`attr_post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_post`
--

LOCK TABLES `cmf_food_attr_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_post` DISABLE KEYS */;
INSERT INTO `cmf_food_attr_post` VALUES (2,4,2),(3,5,3),(4,6,4),(9,7,9),(10,7,10),(11,8,11),(12,8,12),(13,9,13),(14,9,10),(15,10,11),(16,10,12),(17,9,14),(18,9,15),(19,10,16),(20,10,17),(21,21,18),(22,21,19),(23,11,20),(24,11,21),(25,11,22),(26,9,23);
/*!40000 ALTER TABLE `cmf_food_attr_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_attr_value`
--

DROP TABLE IF EXISTS `cmf_food_attr_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_attr_value` (
  `attr_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_id` int(11) DEFAULT NULL,
  `attr_value` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性名称',
  PRIMARY KEY (`attr_value_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_value`
--

LOCK TABLES `cmf_food_attr_value` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_value` DISABLE KEYS */;
INSERT INTO `cmf_food_attr_value` VALUES (1,1,''),(2,3,''),(3,4,''),(4,2,''),(5,7,'大份'),(6,7,'小分'),(7,8,'加量'),(8,8,'减量'),(9,9,'糖'),(10,9,'辣'),(11,1,'大份'),(12,1,'小份'),(13,9,'醋'),(14,0,'醋'),(15,0,'辣'),(16,1,'大份'),(17,1,'小份'),(18,13,'一人份'),(19,13,'三人份'),(20,13,'小份'),(21,13,'大份'),(22,13,'中份'),(23,9,'');
/*!40000 ALTER TABLE `cmf_food_attr_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_category`
--

DROP TABLE IF EXISTS `cmf_food_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品分类名称',
  `icon` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品分类推荐图标',
  `is_required` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否必选品（0=>否，1=>是）',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '场景类型（0=>全部，1=>堂食，2=>外卖）',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` int(10) DEFAULT '0' COMMENT '''删除时间''',
  `status` tinyint(3) DEFAULT NULL COMMENT '菜品分类状态',
  `scene` tinyint(3) DEFAULT NULL COMMENT '支持场景',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category`
--

LOCK TABLES `cmf_food_category` WRITE;
/*!40000 ALTER TABLE `cmf_food_category` DISABLE KEYS */;
INSERT INTO `cmf_food_category` VALUES (1,487934091,'aiyongtech',NULL,0,0,0,1606271286,1606271286,1606290734,1,NULL,1),(2,487934091,'news','',0,0,0,1606292651,1606292651,1606292752,1,0,1),(10,487934091,'测试一','',0,0,0,1606311832,1606311832,1606311893,1,0,1),(11,487934091,'四人','',0,0,0,1606311845,1606311845,1606311889,1,0,1),(12,487934091,'aiyongtech','',0,0,0,1606311863,1606311863,1606311886,1,0,1),(13,487934091,'test',NULL,0,0,0,1606296777,1606296777,1606311891,0,0,1),(14,487934091,'热销','',0,0,0,1610251595,1610251595,0,1,1,1),(15,487934091,'优惠','',1,0,0,1606722462,1606722462,0,1,2,1),(16,487934091,'必选品','',1,0,0,1606721419,1606721419,0,1,0,1),(17,487934091,'现褒靓汤','',0,0,0,1606740994,1606740994,0,0,1,1),(18,487934091,'新品推荐','',1,0,0,1606722473,1606722473,0,1,2,1),(19,487934091,'干锅铁板','',0,0,0,1606721339,1606721339,0,1,0,1),(20,487934091,'下饭川菜','',0,0,0,1606721354,1606721354,0,1,0,1),(21,487934091,'麻辣川湘',NULL,0,0,0,1606721390,1606721390,0,1,0,1),(22,487934091,'大促销',NULL,1,0,0,1606741025,1606741025,1606741031,1,1,1),(23,487934091,'大促销',NULL,1,0,0,1606741045,1606741045,0,0,1,1);
/*!40000 ALTER TABLE `cmf_food_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_category_post`
--

DROP TABLE IF EXISTS `cmf_food_category_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_category_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `food_id` int(11) DEFAULT NULL,
  `food_category_id` int(11) DEFAULT NULL,
  `store_id` bigint(20) DEFAULT NULL,
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `status` tinyint(3) DEFAULT NULL COMMENT '菜品状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_post`
--

LOCK TABLES `cmf_food_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_post` DISABLE KEYS */;
INSERT INTO `cmf_food_category_post` VALUES (1,1,14,NULL,0,0,NULL),(3,2,14,NULL,0,0,NULL),(4,2,17,NULL,0,0,NULL),(5,3,15,NULL,0,0,NULL),(6,3,20,NULL,0,0,NULL),(7,4,14,NULL,0,0,NULL),(8,4,21,NULL,0,0,NULL),(9,5,21,NULL,0,0,NULL),(10,5,23,NULL,0,0,NULL),(11,6,18,NULL,0,0,NULL),(12,6,17,NULL,0,0,NULL),(14,0,20,NULL,0,0,NULL),(15,0,21,NULL,0,0,NULL),(16,7,20,NULL,0,0,NULL),(17,7,21,NULL,0,0,NULL),(18,8,1,NULL,0,0,NULL),(19,9,20,NULL,0,0,NULL),(20,9,23,NULL,0,0,NULL),(22,11,18,NULL,0,0,NULL),(23,12,18,NULL,0,0,NULL),(24,13,14,NULL,0,0,NULL),(25,14,14,NULL,0,0,NULL),(26,15,14,NULL,0,0,NULL),(27,16,14,NULL,0,0,NULL),(28,17,16,NULL,0,0,NULL),(29,18,16,NULL,0,0,NULL),(30,19,21,NULL,0,0,NULL),(31,20,21,NULL,0,0,NULL),(32,10,14,NULL,0,0,NULL),(33,10,20,NULL,0,0,NULL),(34,21,14,NULL,0,0,NULL),(35,21,20,NULL,0,0,NULL),(36,11,21,NULL,0,0,NULL),(37,11,15,NULL,0,0,NULL),(38,3,14,NULL,0,0,NULL),(39,6,14,NULL,0,0,NULL),(40,9,14,NULL,0,0,NULL),(41,11,14,NULL,0,0,NULL),(42,12,14,NULL,0,0,NULL),(43,7,14,NULL,0,0,NULL),(44,17,14,NULL,0,0,NULL),(45,18,14,NULL,0,0,NULL),(46,20,14,NULL,0,0,NULL),(47,1,15,NULL,0,0,NULL);
/*!40000 ALTER TABLE `cmf_food_category_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_category_store_house`
--

DROP TABLE IF EXISTS `cmf_food_category_store_house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_category_store_house` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品分类名称',
  `icon` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品分类推荐图标',
  `is_required` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否必选品（0=>否，1=>是）',
  `scene` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支持场景（0 =>全部；1=>堂食；2=>外卖）',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` int(10) DEFAULT '0' COMMENT '''删除时间''',
  `status` tinyint(3) DEFAULT NULL COMMENT '菜品分类状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_store_house`
--

LOCK TABLES `cmf_food_category_store_house` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_store_house` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_food_category_store_house` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_material_post`
--

DROP TABLE IF EXISTS `cmf_food_material_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_material_post` (
  `food_id` int(11) DEFAULT NULL,
  `material_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '加料名称',
  `material_price` decimal(9,2) NOT NULL COMMENT '加料加价',
  `id` tinyint(11) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_material_post`
--

LOCK TABLES `cmf_food_material_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_material_post` DISABLE KEYS */;
INSERT INTO `cmf_food_material_post` VALUES (4,'辣椒',0.00,1,487934091),(5,'冰块',0.00,2,487934091),(6,'1',0.00,3,487934091),(6,'2',0.00,4,487934091),(8,'测试加料1',1.00,9,487934091),(8,'测试加料2',2.00,10,487934091),(10,'测试加料1',1.00,11,487934091),(10,'测试加料2',2.00,12,487934091),(21,'加肉',10.00,21,487934091),(21,'小菜',10.00,22,487934091),(11,'加肉',20.00,23,487934091),(11,'饮料',5.00,28,487934091);
/*!40000 ALTER TABLE `cmf_food_material_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_order`
--

DROP TABLE IF EXISTS `cmf_food_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `trade_no` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝订单号',
  `pay_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方支付类型',
  `store_id` int(11) NOT NULL COMMENT '所属门店id',
  `order_type` tinyint(3) NOT NULL COMMENT '订单类型（1 => 门店扫码就餐',
  `appointment_time` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预约取餐时间',
  `order_detail` json NOT NULL COMMENT '订单详情',
  `box_fee` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '餐盒费',
  `delivery_fee` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '配送费',
  `coupon_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '合计金额',
  `desk_id` int(11) DEFAULT NULL COMMENT '桌号id',
  `desk_name` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '桌位名称详情',
  `user_id` bigint(20) DEFAULT NULL COMMENT '下单人信息',
  `name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户预留姓名',
  `mobile` varchar(11) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户预留手机号',
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户预留收货地址',
  `create_at` bigint(20) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  `order_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）',
  `queue_no` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '取餐队列号',
  `store_name` longtext COLLATE utf8mb4_general_ci,
  `total_amount` double DEFAULT NULL,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `address_id` int(11) DEFAULT NULL COMMENT '选择地址id',
  `store_number` longtext COLLATE utf8mb4_general_ci,
  `longitude` double DEFAULT NULL,
  `store_district` longtext COLLATE utf8mb4_general_ci,
  `store_city` longtext COLLATE utf8mb4_general_ci,
  `store_province` longtext COLLATE utf8mb4_general_ci,
  `store_phone` longtext COLLATE utf8mb4_general_ci,
  `latitude` double DEFAULT NULL,
  `store_address` longtext COLLATE utf8mb4_general_ci,
  `voucher_id` int(11) DEFAULT NULL COMMENT '优惠券id',
  `delivery_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运输状态（TRADE_RECEIVED => 已接单，TRADE_DELIVERY => 运输中',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order`
--

LOCK TABLES `cmf_food_order` WRITE;
/*!40000 ALTER TABLE `cmf_food_order` DISABLE KEYS */;
INSERT INTO `cmf_food_order` VALUES (49,'T202101061042786360','2021010622001421661409279378','alipay',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 9, \"tasty\": [], \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,'辣一点',378.00,0,'',1,'','13601486703','',1609922152,0,'TRADE_FINISHED','61507',NULL,NULL,487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,'T202101061054817330','2021010622001421661409044405','alipay',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 5, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 4, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 6, \"tasty\": [], \"food_id\": 15, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"口水鸡\", \"count\": 3, \"tasty\": [], \"food_id\": 16, \"material\": []}]',0.00,0.00,0.00,'辣一点',420.00,0,'',1,'','13601486703','',1609922278,0,'TRADE_FINISHED','61657',NULL,NULL,487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,'T20210106405507428','2021010622001421661409276277','alipay',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 5, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 4, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 6, \"tasty\": [], \"food_id\": 15, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"口水鸡\", \"count\": 3, \"tasty\": [], \"food_id\": 16, \"material\": []}]',0.00,0.00,0.00,'辣一点',420.00,0,'',1,'','13601486703','',1609922303,0,'TRADE_CLOSED','',NULL,NULL,487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,'T202101071279093925','2021010722001421661408776956','alipay',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 5, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 3, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 3, \"tasty\": [], \"food_id\": 15, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"口水鸡\", \"count\": 2, \"tasty\": [], \"food_id\": 16, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"不需要筷子\", \"count\": 3, \"tasty\": [], \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,'哈哈哈',315.00,0,'',1,'','13601486703','',1609949776,0,'TRADE_FINISHED','20000',NULL,NULL,487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,'T20210107417607977','2021010722001421661410132254','alipay',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 5, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 2, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',245.00,0,'',1,'','13601486703','',1609999906,0,'TRADE_CLOSED','',NULL,NULL,487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,'T202101071029814831','2021010722001421661410176715','alipay',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 5, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 1, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 3, \"tasty\": [], \"food_id\": 15, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"口水鸡\", \"count\": 3, \"tasty\": [], \"food_id\": 16, \"material\": []}, {\"fee\": 39.9, \"sku\": [], \"name\": \"小份黄焖鸡+香菇（含米饭）\", \"count\": 1, \"tasty\": [], \"food_id\": 12, \"material\": []}, {\"fee\": 0, \"sku\": [{\"count\": 0, \"sku_id\": 15, \"sku_fee\": 333, \"sku_detail\": \"\"}], \"name\": \"肠粉\", \"count\": 2, \"tasty\": [{\"attr_key\": \"例：辣度\", \"attr_value\": \"例：微微辣\"}], \"food_id\": 9, \"material\": []}]',0.00,0.00,0.00,'多放点辣',354.90,0,'',1,'','13601486703','',1610003612,0,'TRADE_FINISHED','56554',NULL,NULL,487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,'T202101071795260383','2021010722001421661410161130','alipay',1,2,'立即就餐','[{\"fee\": 0, \"sku\": [{\"count\": 0, \"sku_id\": 14, \"sku_fee\": 88, \"sku_detail\": \"\"}], \"name\": \"肠粉\", \"count\": 4, \"tasty\": [{\"attr_key\": \"例：辣度\", \"attr_value\": \"例：微微辣\"}], \"food_id\": 9, \"material\": []}, {\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 3, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 2, \"tasty\": [], \"food_id\": 13, \"material\": []}]',0.00,0.00,0.00,'',126.00,0,'',1,'','13601486703','',1610006856,0,'TRADE_FINISHED','59801',NULL,NULL,487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(56,'W202101081664090231','2021010822001421661410410516','alipay',1,4,'','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 3, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 1, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 2, \"tasty\": [], \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'放点辣',196.00,0,'',1,'陈泽凡','13601486703','上海市宝山区通河路533弄3号(红太阳商业广场2楼)海底捞火锅(红太阳广场店)1001',1610080767,0,'TRADE_FINISHED','47382',NULL,NULL,487934091,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,'W20210108863555331','2021010822001421661410137464','alipay',1,4,'','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 4, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 3, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 4, \"tasty\": [], \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'来之不易',308.00,0,'',1,'陈泽凡','13601486703','上海市宝山区经地路99弄经纬汇5号楼4层海底捞海底捞火锅(宝山经纬汇店)1001',1610081146,0,'TRADE_FINISHED','47718',NULL,NULL,487934091,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,'T20210108188379127','2021010822001421661410418499','alipay',1,3,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 3, \"tasty\": [], \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,'哈哈😄',126.00,0,'',1,'','13601486703','',1610091644,0,'TRADE_FINISHED','58152',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(59,'W20210108905776872','2021010822001421661410864386','alipay',1,4,'','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 3, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 2, \"tasty\": [], \"food_id\": 13, \"material\": []}]',0.00,0.00,0.00,'💝💝💝',126.00,0,'',1,'陈泽凡','13601486703','上海市宝山区经地路99弄经纬汇5号楼4层海底捞海底捞火锅(宝山经纬汇店)1001',1610091712,0,'TRADE_FINISHED','58308',NULL,NULL,487934091,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,'W20210108665406923','2021010822001421661410464549','alipay',1,4,'','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 3, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 2, \"tasty\": [], \"food_id\": 13, \"material\": []}]',0.00,0.00,0.00,'💝💝💝💝',126.00,0,'',1,'陈泽凡','13601486703','上海市宝山区经地路99弄经纬汇5号楼4层海底捞海底捞火锅(宝山经纬汇店)1001',1610091743,0,'TRADE_FINISHED','58528',NULL,NULL,487934091,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,'T20210109273712250','2021010922001496711408123961','alipay',1,3,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',77.00,0,'',1,'','15161178722','',1610161460,0,'TRADE_FINISHED','41624',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(62,'T20210115134002015','','balance',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',77.00,0,'',1,'','15161178722','',1610724672,1610724672,'TRADE_FINISHED','84673',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,'T202101151320743375','2021011522001496711413138601','alipay',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"food_id\": 15, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"口水鸡\", \"count\": 1, \"tasty\": [], \"food_id\": 16, \"material\": []}]',0.00,0.00,0.00,'',77.00,0,'',1,'','15161178722','',1610724719,0,'TRADE_FINISHED','20000',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,'T20210119797384165','','balance',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 1, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',77.00,0,'',2,'','17625458589','',1610986515,1610986515,'TRADE_FINISHED','20000',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,'T202101191854763110','','balance',1,2,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"椒盐猪手\", \"count\": 1, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 35, \"sku\": [], \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"food_id\": 15, \"material\": []}, {\"fee\": 0, \"sku\": [], \"name\": \"不需要筷子\", \"count\": 1, \"tasty\": [], \"food_id\": 17, \"material\": []}, {\"fee\": 39.9, \"sku\": [], \"name\": \"小份黄焖鸡+香菇（含米饭）\", \"count\": 1, \"tasty\": [], \"food_id\": 12, \"material\": []}]',0.00,0.00,0.00,'',116.90,0,'',2,'','17625458589','',1610986536,1610986536,'TRADE_FINISHED','20000',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,'T20210122843265394','2021012222001421661422123254','alipay',1,3,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 4, \"tasty\": [], \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,'陈泽凡',168.00,0,'',5,'','13601487703','',1611298441,0,'TRADE_FINISHED','55428',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,'T20210122188728937','2021012222001421661422227876','alipay',1,3,'立即就餐','[{\"fee\": 42, \"sku\": [], \"name\": \"山药玉米煲龙骨汤\", \"count\": 2, \"tasty\": [], \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,'初中',84.00,0,'',5,'','13601487703','',1611298892,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,'T202102101244355993','2021021022001496711434904781','alipay',1,2,'20:45','[{\"fee\": 42, \"sku\": null, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": null, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 0, \"sku\": null, \"name\": \"椒盐猪手\", \"count\": 1, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 50, \"sku\": null, \"name\": \"东坡肉\", \"count\": 1, \"tasty\": [{\"attr_key\": \"辣度\", \"attr_value\": \"微辣\"}], \"food_id\": 21, \"material\": [{\"id\": 21, \"count\": 1, \"material_name\": \"加肉\", \"material_price\": 10}]}, {\"fee\": 50, \"sku\": null, \"name\": \"东坡肉\", \"count\": 1, \"tasty\": [{\"attr_key\": \"辣度\", \"attr_value\": \"酸辣\"}], \"food_id\": 21, \"material\": [{\"id\": 21, \"count\": 1, \"material_name\": \"加肉\", \"material_price\": 10}]}]',0.00,0.00,0.00,'',63.00,0,'',9,'','15161178722','',1612961101,0,'TRADE_FINISHED','76481',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,'T202102101121862049','2021021022001496711434725716','alipay',1,2,'20:47','[{\"fee\": 42, \"sku\": null, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"sku\": null, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 0, \"sku\": null, \"name\": \"椒盐猪手\", \"count\": 1, \"tasty\": [], \"food_id\": 13, \"material\": []}, {\"fee\": 50, \"sku\": null, \"name\": \"东坡肉\", \"count\": 1, \"tasty\": [{\"attr_key\": \"辣度\", \"attr_value\": \"微辣\"}], \"food_id\": 21, \"material\": [{\"id\": 21, \"count\": 1, \"material_name\": \"加肉\", \"material_price\": 10}]}, {\"fee\": 50, \"sku\": null, \"name\": \"东坡肉\", \"count\": 1, \"tasty\": [{\"attr_key\": \"辣度\", \"attr_value\": \"酸辣\"}], \"food_id\": 21, \"material\": [{\"id\": 21, \"count\": 1, \"material_name\": \"加肉\", \"material_price\": 10}]}]',0.00,0.00,0.00,'',63.00,0,'',9,'','15161178722','',1612961269,0,'TRADE_FINISHED','76590',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(70,'T202102111993393842','2021021122001496711434710986','alipay',1,2,'10:54','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 103.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}, {\"id\": 12, \"count\": 1, \"material_name\": \"测试加料2\", \"material_price\": 2}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',268.99,0,'',9,'','15161178722','',1613012049,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(71,'T20210211392657025','','balance',1,2,'13:34','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 24.09, \"name\": \"油炸大串\", \"count\": 4, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 21, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',258.36,0,'',9,'','15161178722','',1613021642,1613021642,'TRADE_FINISHED','48843',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(72,'T202102111662295184','2021021122001496711435123555','alipay',1,2,'13:37','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 24.09, \"name\": \"油炸大串\", \"count\": 4, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 21, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',258.36,0,'',9,'','15161178722','',1613021828,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(73,'T202102131423035365','2021021322001496711435689852','alipay',1,2,'10:56','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 101.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}]',0.00,0.00,0.00,'',231.99,0,'',9,'','15161178722','',1613185003,1613273120,'TRADE_FINISHED','41120',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,'T20210213243426878','2021021322001496711435948757','alipay',1,2,'17:49','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 101.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}]',0.00,0.00,0.00,'',231.99,0,'',9,'','15161178722','',1613209783,1613297898,'TRADE_FINISHED','65899',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(75,'T202102131731616633','2021021322001496711436088373','alipay',1,2,'17:55','[{\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',77.00,0,'',9,'','15161178722','',1613210124,1613298248,'TRADE_FINISHED','66248',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(76,'T20210213263867442','2021021322001496711435845704','alipay',1,2,'22:01','[{\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',77.00,0,'',9,'','15161178722','',1613224888,1613313009,'TRADE_FINISHED','81010',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(77,'T2021021527165104','2021021522001496711436942904','alipay',1,2,'19:58','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 39.9, \"name\": \"小份黄焖鸡+香菇（含米饭）\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 12, \"material\": []}]',0.00,0.00,0.00,'',169.90,0,'',10,'','15161178722','',1613390334,1613433535,'TRADE_FINISHED','71941',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(78,'T20210216614413743','','balance',1,2,'11:24','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 101.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',266.99,0,'',10,'','15161178722','',1613445855,1613489056,'TRADE_FINISHED','41057',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(79,'T202102161431192715','','balance',1,2,'11:24','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 101.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',266.99,0,'',10,'','15161178722','',1613445866,1613489067,'TRADE_FINISHED','41067',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(80,'T202102161480348004','2021021622001496711436752833','alipay',1,2,'11:29','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 101.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',266.99,0,'',10,'','15161178722','',1613446199,1613489400,'TRADE_FINISHED','41407',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(81,'T20210216619046756','','balance',1,2,'17:19','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 103.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}, {\"id\": 12, \"count\": 1, \"material_name\": \"测试加料2\", \"material_price\": 2}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',268.99,0,'',10,'','15161178722','',1613467190,1613510391,'TRADE_FINISHED','62391',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(82,'T20210216793990477','','balance',1,2,'17:22','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',10,'','15161178722','',1613467345,1613510546,'TRADE_FINISHED','62547',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(83,'T202102161581527327','','balance',1,2,'17:27','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 101.99, \"name\": \"油炸大串\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}], \"sku_id\": 20, \"food_id\": 10, \"material\": [{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]}, {\"fee\": 35, \"name\": \"川味回锅肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,'',266.99,0,'',10,'','15161178722','',1613467659,1613510860,'TRADE_FINISHED','62860',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(84,'T202102161156751369','','balance',1,2,'17:28','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 49, \"name\": \"毛血旺\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 19, \"material\": []}]',0.00,0.00,0.00,'',137.00,0,'',10,'','15161178722','',1613467708,1613510909,'TRADE_FINISHED','62909',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(85,'T202102171415828908','2021021722001496711437342126','alipay',1,2,'00:11','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 49, \"name\": \"毛血旺\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 19, \"material\": []}]',0.00,0.00,0.00,'',137.00,0,'',10,'','15161178722','',1613491863,1613535064,'TRADE_FINISHED','20000',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(86,'T2021021736586665','2021021722001496711437147570','alipay',1,2,'00:41','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 49, \"name\": \"毛血旺\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 19, \"material\": []}]',0.00,0.00,0.00,'',137.00,0,'',10,'','15161178722','',1613493718,1613536919,'TRADE_FINISHED','20000',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(87,'T202102171662383562','2021021722001496711437355576','alipay',1,2,'00:51','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 49, \"name\": \"毛血旺\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 19, \"material\": []}]',0.00,0.00,0.00,'',137.00,0,'',10,'','15161178722','',1613494282,1613537483,'TRADE_FINISHED','20000',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(88,'T20210217975087705','2021021722001496711437292774','alipay',1,2,'00:52','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',10,'','15161178722','',1613494339,1613537540,'TRADE_FINISHED','20000',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(89,'T202102181146849589','','balance',1,2,'17:13','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',10,'','15161178722','',1613639634,1613682835,'TRADE_FINISHED','62035',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(90,'T202102181898208725','2021021822001496711437797133','alipay',1,2,'17:31','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,'',130.00,0,'',11,'','15161178722','',1613640682,1613683883,'TRADE_FINISHED','63090',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(91,'T20210219602395343','2021021922001430081409678842','alipay',1,2,'19:28','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',2,'','15161178722','',1613734111,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(92,'T202102191775648211','2021021922001496711439284490','alipay',1,2,'21:25','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','15161178722','',1613741106,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(93,'T202102192079549684','2021021922001496711439320572','alipay',1,2,'21:25','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','15161178722','',1613741158,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(94,'T202102191258798058','2021021922001496711439501101','alipay',1,2,'21:39','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','15161178722','',1613741972,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(95,'T202102192098592173','2021021922001496711438924958','alipay',1,2,'21:50','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','15161178722','',1613742610,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(96,'T202102191067458544','2021021922001496711439302397','alipay',1,2,'22:11','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613743887,1613787088,'TRADE_FINISHED','80258',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(97,'T202102191745800236','2021021922001496711438855437','alipay',1,2,'22:19','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613744377,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(98,'T20210219995378874','2021021922001496711439331515','alipay',1,2,'22:21','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613744512,1613787713,'TRADE_FINISHED','80523',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(99,'T202102191642674446','2021021922001496711438931165','alipay',1,2,'22:29','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613744995,1613788196,'TRADE_FINISHED','81447',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(100,'T202102191301421369','2021021922001496711438907828','alipay',1,2,'22:34','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613745256,1613788457,'TRADE_FINISHED','81406',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(101,'T20210219320028116','2021021922001496711439282666','alipay',1,2,'22:39','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613745566,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(102,'T20210219865045395','2021021922001496711439287089','alipay',1,2,'22:40','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613745609,1613788810,'TRADE_FINISHED','82014',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(103,'T202102191715703784','2021021922001496711438933067','alipay',1,2,'22:46','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613745985,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(104,'T20210219630748132','2021021922001496711438654226','alipay',1,2,'23:27','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613748459,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(105,'T202102191447408327','2021021922001496711439588693','alipay',1,2,'23:28','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458598','',1613748489,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(106,'T202102191297794183','2021021922001496711439256139','alipay',1,2,'23:31','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','15161178722','',1613748694,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(107,'T202102191557790344','2021021922001496711438974626','alipay',1,2,'23:42','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613749341,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(108,'T202102191017053882','2021021922001496711438973024','alipay',1,2,'23:47','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',1,'','17625458589','',1613749622,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(109,'T20210220563911288','2021022022001451691446920610','alipay',1,2,'10:15','[{\"fee\": 42, \"name\": \"山药玉米煲龙骨汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,'',42.00,0,'',2,'','15888888888','',1613787316,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(110,'T202103041354485165','2021030422001496711450353855','alipay',1,2,'22:35','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',3,'','17625458589','',1614868549,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(111,'T20210304371666476','2021030422001496711450328626','alipay',1,2,'22:39','[{\"fee\": 88, \"name\": \"红烧肉\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,'',88.00,0,'',3,'','17625458589','',1614868782,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(112,'T202103061347590676','2021030622001496711451791435','alipay',1,2,'15:07','[{\"fee\": 49, \"name\": \"毛血旺\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 19, \"material\": []}]',0.00,0.00,0.00,'',49.00,0,'',3,'','17625458589','',1615014435,0,'TRADE_CLOSED','',NULL,NULL,487934091,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `cmf_food_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_order_detail`
--

DROP TABLE IF EXISTS `cmf_food_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品唯一编号',
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `food_id` int(11) NOT NULL COMMENT '所属食物id',
  `food_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品名称',
  `sku_id` int(11) NOT NULL COMMENT '所属食物规格id',
  `sku_detail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '规格详情',
  `count` int(11) NOT NULL COMMENT '购买数量',
  `fee` decimal(9,2) NOT NULL COMMENT '菜品单价',
  `food_thumbnail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品缩略图',
  `cooking_method` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品做法',
  `alipay_material_id` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '阿里素材标识',
  `dish_type` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品类型',
  `flavor` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品口味',
  `member_price` decimal(9,2) NOT NULL COMMENT '菜品会员价',
  `use_member` tinyint(3) NOT NULL COMMENT '是否启用菜品会员价',
  `material` json NOT NULL COMMENT '加料',
  `box_fee` decimal(9,2) NOT NULL COMMENT '餐盒费',
  `tasty` json NOT NULL COMMENT '口味',
  `food_remark` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '最终拼接详情',
  `total` decimal(9,2) NOT NULL COMMENT '菜品总价',
  `price` decimal(9,2) NOT NULL COMMENT '菜品单价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_detail`
--

LOCK TABLES `cmf_food_order_detail` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_detail` DISABLE KEYS */;
INSERT INTO `cmf_food_order_detail` VALUES (1,'cwhgfr','T20201221902268140',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2020122100502200000081250406','','',0.00,0,'null',0.00,'null','',0.00,0.00),(2,'FL01','T20201221902268140',11,'小份黄焖鸡+米饭',27,'小份',1,15.00,'default/20201204/f5102b01d6bb14b1da0bce3f5d72c3e7.jpeg','','2020122100502200000081250407','','',0.00,0,'null',0.00,'null','',0.00,0.00),(3,'cwhgfr','T20201221316899050',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2020122100502200000081252320','','',0.00,0,'null',0.00,'null','',0.00,0.00),(4,'FL01','T20201221316899050',11,'小份黄焖鸡+米饭',27,'小份',1,15.00,'default/20201204/f5102b01d6bb14b1da0bce3f5d72c3e7.jpeg','','2020122100502200000081252321','','',0.00,0,'null',0.00,'null','',0.00,0.00),(5,'111','T20201227864418474',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122700502200000082223110','','',0.00,0,'null',0.00,'null','',0.00,0.00),(6,'21-25','T20201227864418474',21,'东坡肉',25,'三人份',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122700502200000082223111','','',0.00,0,'null',0.00,'null','',0.00,0.00),(7,'111','T202012272359331',2,'山药玉米煲龙骨汤',0,'',6,252.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122700502200000082226282','','',0.00,0,'null',0.00,'null','',0.00,0.00),(8,'21-25','T202012272359331',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122700502200000082226653','','',0.00,0,'null',0.00,'null','',0.00,0.00),(9,'21-25','T202012281922447431',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082278785','','',0.00,0,'null',0.00,'null','',0.00,0.00),(10,'21-25','T202012281922447431',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082278879','','',0.00,0,'null',0.00,'null','',0.00,0.00),(11,'21-25','T202012281043176042',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082281787','','',0.00,0,'null',0.00,'null','',0.00,0.00),(12,'gghc','T202012281043176042',16,'口水鸡',0,'',4,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2020122800502200000082281788','','',0.00,0,'null',0.00,'null','',0.00,0.00),(13,'cwhgfr','T202012281043176042',15,'川味回锅肉',0,'',6,210.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2020122800502200000082281789','','',0.00,0,'null',0.00,'null','',0.00,0.00),(14,'jyzs','T202012281043176042',13,'椒盐猪手',0,'',8,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020122800502200000082281690','','',0.00,0,'null',0.00,'null','',0.00,0.00),(15,'111','T202012281043176042',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122800502200000082281401','','',0.00,0,'null',0.00,'null','',0.00,0.00),(16,'111','T202012281102038886',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122800502200000082286521','','',0.00,0,'null',0.00,'null','',0.00,0.00),(17,'jyzs','T202012281102038886',13,'椒盐猪手',0,'',5,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020122800502200000082286846','','',0.00,0,'null',0.00,'null','',0.00,0.00),(18,'gghc','T202012281102038886',16,'口水鸡',0,'',4,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2020122800502200000082286848','','',0.00,0,'null',0.00,'null','',0.00,0.00),(19,'21-25','T202012281102038886',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082286633','','',0.00,0,'null',0.00,'null','',0.00,0.00),(20,'111','T202012281232504897',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122800502200000082287308','','',0.00,0,'null',0.00,'null','',0.00,0.00),(21,'21-25','T202012281232504897',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082287480','','',0.00,0,'null',0.00,'null','',0.00,0.00),(22,'111','T202012281212907052',2,'山药玉米煲龙骨汤',0,'',7,294.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122800502200000082287985','','',0.00,0,'null',0.00,'null','',0.00,0.00),(23,'111','T202012281353333028',2,'山药玉米煲龙骨汤',0,'',7,294.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122800502200000082289335','','',0.00,0,'null',0.00,'null','',0.00,0.00),(24,'21-25','T202012281353333028',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082289336','','',0.00,0,'null',0.00,'null','',0.00,0.00),(25,'111','T20201228190918718',2,'山药玉米煲龙骨汤',0,'',7,294.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122800502200000082291310','','',0.00,0,'null',0.00,'null','',0.00,0.00),(26,'21-25','T20201228190918718',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082291205','','',0.00,0,'null',0.00,'null','',0.00,0.00),(27,'jyzs','T202012282062771869',13,'椒盐猪手',0,'',4,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020122800502200000082291442','','',0.00,0,'null',0.00,'null','',0.00,0.00),(28,'111','T202012282062771869',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2020122800502200000082290962','','',0.00,0,'null',0.00,'null','',0.00,0.00),(29,'jyzs','T2020122869337986',13,'椒盐猪手',0,'',3,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020122800502200000082295305','','',0.00,0,'null',0.00,'null','',0.00,0.00),(30,'gghc','T2020122869337986',16,'口水鸡',0,'',3,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2020122800502200000082295722','','',0.00,0,'null',0.00,'null','',0.00,0.00),(31,'21-25','T2020122869337986',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082295307','','',0.00,0,'null',0.00,'null','',0.00,0.00),(32,'cwhgfr','T2020122869337986',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2020122800502200000082295308','','',0.00,0,'null',0.00,'null','',0.00,0.00),(33,'jyzs','T202012281736750274',13,'椒盐猪手',0,'',3,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020122800502200000082295880','','',0.00,0,'null',0.00,'null','',0.00,0.00),(34,'gghc','T202012281736750274',16,'口水鸡',0,'',3,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2020122800502200000082295881','','',0.00,0,'null',0.00,'null','',0.00,0.00),(35,'21-25','T202012281736750274',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122800502200000082295882','','',0.00,0,'null',0.00,'null','',0.00,0.00),(36,'cwhgfr','T202012281736750274',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2020122800502200000082295620','','',0.00,0,'null',0.00,'null','',0.00,0.00),(37,'jyzs','T202012291368159516',13,'椒盐猪手',0,'',5,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020122900502200000082363689','','',0.00,0,'null',0.00,'null','',0.00,0.00),(38,'21-25','T202012291368159516',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122900502200000082363795','','',0.00,0,'null',0.00,'null','',0.00,0.00),(39,'QS001','T20201229265082468',21,'东坡肉',24,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122900502200000082371096','','',0.00,0,'null',0.00,'null','',0.00,0.00),(40,'21-25','T20201229265082468',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122900502200000082371301','','',0.00,0,'null',0.00,'null','',0.00,0.00),(41,'QS001','T2020122963506027',21,'东坡肉',24,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122900502200000082371455','','',0.00,0,'null',0.00,'null','',0.00,0.00),(42,'21-25','T2020122963506027',21,'东坡肉',25,'',0,0.00,'default/20201204/1642809aaf1cb8fe33a89e2de74ee178.jpg','','2020122900502200000082371307','','',0.00,0,'null',0.00,'null','',0.00,0.00),(43,'jyzs','T20201230434980925',13,'椒盐猪手',0,'',5,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020123000502200000082635052','','',0.00,0,'null',0.00,'null','',0.00,0.00),(44,'jyzs','T20201230334504784',13,'椒盐猪手',0,'',5,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2020123000502200000082635158','','',0.00,0,'null',0.00,'null','',0.00,0.00),(45,'111','T20210103362895305',2,'山药玉米煲龙骨汤',0,'',7,294.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010300502200000083190072','','',0.00,0,'null',0.00,'null','',0.00,0.00),(46,'111','T202101041440547869',2,'山药玉米煲龙骨汤',0,'',6,252.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010400502200000083305761','','',0.00,0,'null',0.00,'null','',0.00,0.00),(47,'111','T202101042048559049',2,'山药玉米煲龙骨汤',0,'',6,252.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010400502200000083306139','','',0.00,0,'null',0.00,'null','',0.00,0.00),(48,'111','T202101041799940214',2,'山药玉米煲龙骨汤',0,'',7,294.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010400502200000083308433','','',0.00,0,'null',0.00,'null','',0.00,0.00),(49,'111','T20210104981029872',2,'山药玉米煲龙骨汤',0,'',3,126.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010400502200000083310047','','',0.00,0,'null',0.00,'null','',0.00,0.00),(50,'111','T202101061042786360',2,'山药玉米煲龙骨汤',0,'',9,378.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010600502200000083540625','','',0.00,0,'null',0.00,'null','',0.00,0.00),(51,'111','T202101061054817330',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010600502200000083541132','','',0.00,0,'null',0.00,'null','',0.00,0.00),(52,'jyzs','T202101061054817330',13,'椒盐猪手',0,'',4,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010600502200000083541324','','',0.00,0,'null',0.00,'null','',0.00,0.00),(53,'cwhgfr','T202101061054817330',15,'川味回锅肉',0,'',6,210.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010600502200000083540861','','',0.00,0,'null',0.00,'null','',0.00,0.00),(54,'gghc','T202101061054817330',16,'口水鸡',0,'',3,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2021010600502200000083541325','','',0.00,0,'null',0.00,'null','',0.00,0.00),(55,'111','T20210106405507428',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010600502200000083541343','','',0.00,0,'null',0.00,'null','',0.00,0.00),(56,'jyzs','T20210106405507428',13,'椒盐猪手',0,'',4,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010600502200000083540872','','',0.00,0,'null',0.00,'null','',0.00,0.00),(57,'cwhgfr','T20210106405507428',15,'川味回锅肉',0,'',6,210.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010600502200000083541143','','',0.00,0,'null',0.00,'null','',0.00,0.00),(58,'gghc','T20210106405507428',16,'口水鸡',0,'',3,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2021010600502200000083541344','','',0.00,0,'null',0.00,'null','',0.00,0.00),(59,'111','T202101071279093925',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010700502200000083607702','','',0.00,0,'null',0.00,'null','',0.00,0.00),(60,'jyzs','T202101071279093925',13,'椒盐猪手',0,'',3,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010700502200000083607584','','',0.00,0,'null',0.00,'null','',0.00,0.00),(61,'cwhgfr','T202101071279093925',15,'川味回锅肉',0,'',3,105.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010700502200000083607829','','',0.00,0,'null',0.00,'null','',0.00,0.00),(62,'gghc','T202101071279093925',16,'口水鸡',0,'',2,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2021010700502200000083607830','','',0.00,0,'null',0.00,'null','',0.00,0.00),(63,'bxkz','T202101071279093925',17,'不需要筷子',0,'',3,0.00,'default/20201204/6d66aef5065ff247de27668080c171f5.jpg','','2021010700502200000083607478','','',0.00,0,'null',0.00,'null','',0.00,0.00),(64,'111','T20210107417607977',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010700502200000083661173','','',0.00,0,'null',0.00,'null','',0.00,0.00),(65,'jyzs','T20210107417607977',13,'椒盐猪手',0,'',2,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010700502200000083660762','','',0.00,0,'null',0.00,'null','',0.00,0.00),(66,'cwhgfr','T20210107417607977',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010700502200000083661067','','',0.00,0,'null',0.00,'null','',0.00,0.00),(67,'111','T202101071029814831',2,'山药玉米煲龙骨汤',0,'',5,210.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010700502200000083667322','','',0.00,0,'null',0.00,'null','',0.00,0.00),(68,'jyzs','T202101071029814831',13,'椒盐猪手',0,'',1,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010700502200000083667210','','',0.00,0,'null',0.00,'null','',0.00,0.00),(69,'cwhgfr','T202101071029814831',15,'川味回锅肉',0,'',3,105.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010700502200000083667323','','',0.00,0,'null',0.00,'null','',0.00,0.00),(70,'gghc','T202101071029814831',16,'口水鸡',0,'',3,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2021010700502200000083667211','','',0.00,0,'null',0.00,'null','',0.00,0.00),(71,'hmjxg','T202101071029814831',12,'小份黄焖鸡+香菇（含米饭）',0,'',1,39.90,'default/20201204/11557a98fb0f20ccbd29e70cba480e4d.jpg','','2021010700502200000083667538','','',0.00,0,'null',0.00,'null','',0.00,0.00),(72,'BT12','T202101071029814831',9,'肠粉',15,'辣',0,0.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010700502200000083667325','','',0.00,0,'null',0.00,'null','',0.00,0.00),(73,'QA123','T202101071795260383',9,'肠粉',14,'醋',0,0.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010700502200000083672869','','',0.00,1,'null',0.00,'null','',0.00,0.00),(74,'111','T202101071795260383',2,'山药玉米煲龙骨汤',0,'',3,126.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010700502200000083672871','','',0.00,0,'null',0.00,'null','',0.00,0.00),(75,'jyzs','T202101071795260383',13,'椒盐猪手',0,'',2,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010700502200000083673114','','',0.00,0,'null',0.00,'null','',0.00,0.00),(76,'111','W202101081664090231',2,'山药玉米煲龙骨汤',0,'',3,126.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010800502200000083769507','','',0.00,0,'null',0.00,'null','',0.00,0.00),(77,'jyzs','W202101081664090231',13,'椒盐猪手',0,'',1,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010800502200000083769629','','',0.00,0,'null',0.00,'null','',0.00,0.00),(78,'cwhgfr','W202101081664090231',15,'川味回锅肉',0,'',2,70.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010800502200000083769508','','',0.00,0,'null',0.00,'null','',0.00,0.00),(79,'111','W20210108863555331',2,'山药玉米煲龙骨汤',0,'',4,168.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010800502200000083770288','','',0.00,0,'null',0.00,'null','',0.00,0.00),(80,'jyzs','W20210108863555331',13,'椒盐猪手',0,'',3,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010800502200000083770644','','',0.00,0,'null',0.00,'null','',0.00,0.00),(81,'cwhgfr','W20210108863555331',15,'川味回锅肉',0,'',4,140.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010800502200000083770289','','',0.00,0,'null',0.00,'null','',0.00,0.00),(82,'111','T20210108188379127',2,'山药玉米煲龙骨汤',0,'',3,126.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010800502200000083789947','','',0.00,0,'null',0.00,'null','',0.00,0.00),(83,'111','W20210108905776872',2,'山药玉米煲龙骨汤',0,'',3,126.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010800502200000083790326','','',0.00,0,'null',0.00,'null','',0.00,0.00),(84,'jyzs','W20210108905776872',13,'椒盐猪手',0,'',2,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010800502200000083790101','','',0.00,0,'null',0.00,'null','',0.00,0.00),(85,'111','W20210108665406923',2,'山药玉米煲龙骨汤',0,'',3,126.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010800502200000083790237','','',0.00,0,'null',0.00,'null','',0.00,0.00),(86,'jyzs','W20210108665406923',13,'椒盐猪手',0,'',2,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021010800502200000083790336','','',0.00,0,'null',0.00,'null','',0.00,0.00),(87,'111','T20210109273712250',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021010900502200000083872050','','',0.00,0,'null',0.00,'null','',0.00,0.00),(88,'cwhgfr','T20210109273712250',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021010900502200000083872504','','',0.00,0,'null',0.00,'null','',0.00,0.00),(89,'111','T20210115134002015',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021011500502200000084740447','','',0.00,0,'null',0.00,'null','',0.00,0.00),(90,'cwhgfr','T20210115134002015',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021011500502200000084740220','','',0.00,0,'null',0.00,'null','',0.00,0.00),(91,'111','T202101151320743375',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021011500502200000084740455','','',0.00,0,'null',0.00,'null','',0.00,0.00),(92,'cwhgfr','T202101151320743375',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021011500502200000084740635','','',0.00,0,'null',0.00,'null','',0.00,0.00),(93,'gghc','T202101151320743375',16,'口水鸡',0,'',1,0.00,'default/20201204/79bc3ce4984de1ae8336dd90f48fb8af.jpg','','2021011500502200000084740236','','',0.00,0,'null',0.00,'null','',0.00,0.00),(94,'111','T20210119797384165',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021011900502200000085084435','','',0.00,0,'null',0.00,'null','',0.00,0.00),(95,'jyzs','T20210119797384165',13,'椒盐猪手',0,'',1,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021011900502200000085084595','','',0.00,0,'null',0.00,'null','',0.00,0.00),(96,'cwhgfr','T20210119797384165',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021011900502200000085084712','','',0.00,0,'null',0.00,'null','',0.00,0.00),(97,'111','T202101191854763110',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021011900502200000085084440','','',0.00,0,'null',0.00,'null','',0.00,0.00),(98,'jyzs','T202101191854763110',13,'椒盐猪手',0,'',1,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021011900502200000085084441','','',0.00,0,'null',0.00,'null','',0.00,0.00),(99,'cwhgfr','T202101191854763110',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021011900502200000085084442','','',0.00,0,'null',0.00,'null','',0.00,0.00),(100,'bxkz','T202101191854763110',17,'不需要筷子',0,'',1,0.00,'default/20201204/6d66aef5065ff247de27668080c171f5.jpg','','2021011900502200000085084599','','',0.00,0,'null',0.00,'null','',0.00,0.00),(101,'hmjxg','T202101191854763110',12,'小份黄焖鸡+香菇（含米饭）',0,'',1,39.90,'default/20201204/11557a98fb0f20ccbd29e70cba480e4d.jpg','','2021011900502200000085084600','','',0.00,0,'null',0.00,'null','',0.00,0.00),(102,'111','T20210122843265394',2,'山药玉米煲龙骨汤',0,'',4,168.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021012200502200000085420595','','',0.00,0,'null',0.00,'null','',0.00,0.00),(103,'111','T20210122188728937',2,'山药玉米煲龙骨汤',0,'',2,84.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021012200502200000085421020','','',0.00,0,'null',0.00,'null','',0.00,0.00),(104,'111','T202102101244355993',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021000502200000087330111','','',0.00,0,'null',0.00,'null','',0.00,0.00),(105,'jyzs','T202102101244355993',13,'椒盐猪手',0,'',1,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021021000502200000087329806','','',0.00,0,'null',0.00,'null','',0.00,0.00),(106,'111','T202102101121862049',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021000502200000087329971','','',0.00,0,'null',0.00,'null','',0.00,0.00),(107,'jyzs','T202102101121862049',13,'椒盐猪手',0,'',1,0.00,'default/20201204/dbc15663a2a8292ee873e3c73e7b1a91.jpg','','2021021000502200000087330191','','',0.00,0,'null',0.00,'null','',0.00,0.00),(108,'TB007','T202102111662295184',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021100502200000087354834','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(109,'111','T202102111662295184',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021100502200000087354365','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(110,'TEST0002','T202102111662295184',10,'油炸大串',21,'小份',4,92.36,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(111,'cwhgfr','T202102111662295184',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021100502200000087354366','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(112,'TB007','T202102131423035365',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021300502200000087439589','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(113,'111','T202102131423035365',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021300502200000087439405','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(114,'TEST0001','T202102131423035365',10,'油炸大串',20,'大份',1,100.99,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(115,'TB007','T20210213243426878',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021300502200000087469524','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(116,'111','T20210213243426878',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021300502200000087469786','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(117,'TEST0001','T20210213243426878',10,'油炸大串',20,'大份',1,100.99,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(118,'111','T202102131731616633',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021300502200000087469763','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(119,'cwhgfr','T202102131731616633',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021300502200000087470129','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(120,'111','T20210213263867442',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021300502200000087498182','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(121,'cwhgfr','T20210213263867442',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021300502200000087497721','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(122,'TB007','T2021021527165104',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021500502200000087650288','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(123,'111','T2021021527165104',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021500502200000087650289','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(124,'hmjxg','T2021021527165104',12,'小份黄焖鸡+香菇（含米饭）',0,'',1,39.90,'default/20201204/11557a98fb0f20ccbd29e70cba480e4d.jpg','','2021021500502200000087650055','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(125,'TB007','T20210216614413743',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021600502200000087675723','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(126,'111','T20210216614413743',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021600502200000087675440','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(127,'TEST0001','T20210216614413743',10,'油炸大串',20,'大份',1,100.99,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(128,'cwhgfr','T20210216614413743',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021600502200000087675865','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(129,'TB007','T202102161431192715',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021600502200000087675728','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(130,'111','T202102161431192715',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021600502200000087675441','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(131,'TEST0001','T202102161431192715',10,'油炸大串',20,'大份',1,100.99,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(132,'cwhgfr','T202102161431192715',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021600502200000087675581','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(133,'TB007','T202102161480348004',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021600502200000087675775','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(134,'111','T202102161480348004',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021600502200000087675633','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(135,'TEST0001','T202102161480348004',10,'油炸大串',20,'大份',1,100.99,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(136,'cwhgfr','T202102161480348004',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021600502200000087675776','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(137,'TB007','T20210216619046756',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021600502200000087703395','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(138,'111','T20210216619046756',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021600502200000087703396','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(139,'TEST0001','T20210216619046756',10,'油炸大串',20,'大份',1,100.99,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}, {\"id\": 12, \"count\": 1, \"material_name\": \"测试加料2\", \"material_price\": 2}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(140,'cwhgfr','T20210216619046756',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021600502200000087704033','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(141,'TB007','T20210216793990477',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021600502200000087703953','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(142,'TB007','T202102161581527327',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021600502200000087704450','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(143,'111','T202102161581527327',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021600502200000087704648','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(144,'TEST0001','T202102161581527327',10,'油炸大串',20,'大份',1,100.99,'','','','','',0.00,0,'[{\"id\": 11, \"count\": 1, \"material_name\": \"测试加料1\", \"material_price\": 1}]',0.00,'[{\"attr_key\": \"温度\", \"attr_value\": \"加冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"全塘\"}]','',0.00,0.00),(145,'cwhgfr','T202102161581527327',15,'川味回锅肉',0,'',1,35.00,'default/20201204/dd1a8e873a3ee7afe905fc36dc68fab6.jpg','','2021021600502200000087704451','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(146,'TB007','T202102161156751369',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021600502200000087704297','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(147,'mxw','T202102161156751369',19,'毛血旺',0,'',1,49.00,'default/20201204/2f7c355ef9f8d859a7e21f9b31780ee6.jpg','','2021021600502200000087704298','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(148,'TB007','T202102171415828908',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021700502200000087740817','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(149,'mxw','T202102171415828908',19,'毛血旺',0,'',1,49.00,'default/20201204/2f7c355ef9f8d859a7e21f9b31780ee6.jpg','','2021021700502200000087741087','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(150,'TB007','T2021021736586665',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021700502200000087741789','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(151,'mxw','T2021021736586665',19,'毛血旺',0,'',1,49.00,'default/20201204/2f7c355ef9f8d859a7e21f9b31780ee6.jpg','','2021021700502200000087741790','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(152,'TB007','T202102171662383562',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021700502200000087742251','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(153,'mxw','T202102171662383562',19,'毛血旺',0,'',1,49.00,'default/20201204/2f7c355ef9f8d859a7e21f9b31780ee6.jpg','','2021021700502200000087742252','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(154,'TB007','T20210217975087705',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021700502200000087742025','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(155,'TB007','T202102181146849589',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021800502200000087867933','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(156,'TB007','T202102181898208725',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021800502200000087869204','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(157,'111','T202102181898208725',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021021800502200000087868791','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(158,'TB007','T20210219602395343',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000087981864','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(159,'TB007','T202102191775648211',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000087997613','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(160,'TB007','T202102192079549684',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000087997358','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(161,'TB007','T202102191258798058',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000087998616','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(162,'TB007','T202102192098592173',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000087999900','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(163,'TB007','T202102191067458544',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088001161','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(164,'TB007','T202102191745800236',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088001569','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(165,'TB007','T20210219995378874',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088001599','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(166,'TB007','T202102191642674446',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088002057','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(167,'TB007','T202102191301421369',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088002435','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(168,'TB007','T20210219320028116',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088002505','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(169,'TB007','T20210219865045395',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088002353','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(170,'TB007','T202102191715703784',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088003221','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(171,'TB007','T20210219630748132',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088004938','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(172,'TB007','T202102191447408327',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088004788','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(173,'TB007','T202102191297794183',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088004664','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(174,'TB007','T202102191557790344',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088005058','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(175,'TB007','T202102191017053882',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021021900502200000088005596','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(176,'111','T20210220563911288',2,'山药玉米煲龙骨汤',0,'',1,42.00,'default/20201130/235a65e1559686601cb721bce6659dd3.jpeg','','2021022000502200000088020344','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(177,'TB007','T202103041354485165',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021030400502200000089482489','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(178,'TB007','T20210304371666476',1,'红烧肉',0,'',1,88.00,'default/20201125/d3ac00bdfc36ead5d8b358dd9828d133.jpg','','2021030400502200000089482559','','',0.00,0,'null',0.00,'[]','',0.00,0.00),(179,'mxw','T202103061347590676',19,'毛血旺',0,'',1,49.00,'default/20201204/2f7c355ef9f8d859a7e21f9b31780ee6.jpg','','2021030600502200000089691435','','',0.00,0,'null',0.00,'[]','',0.00,0.00);
/*!40000 ALTER TABLE `cmf_food_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_sku`
--

DROP TABLE IF EXISTS `cmf_food_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_sku` (
  `sku_id` int(11) NOT NULL AUTO_INCREMENT,
  `food_id` int(11) DEFAULT NULL,
  `attr_post` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应的多选规格',
  `code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '规格唯一编号',
  `inventory` int(11) DEFAULT NULL COMMENT '库存',
  `use_member` tinyint(3) NOT NULL COMMENT '是否启用菜品会员价',
  `member_price` decimal(9,2) NOT NULL COMMENT '菜品会员价',
  `original_price` decimal(9,2) NOT NULL COMMENT '菜品原价',
  `price` decimal(9,2) NOT NULL COMMENT '规格售价',
  `volume` int(11) DEFAULT NULL COMMENT '销量',
  `default_inventory` int(11) DEFAULT NULL COMMENT '默认库存',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规格备注',
  PRIMARY KEY (`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_sku`
--

LOCK TABLES `cmf_food_sku` WRITE;
/*!40000 ALTER TABLE `cmf_food_sku` DISABLE KEYS */;
INSERT INTO `cmf_food_sku` VALUES (2,4,'2','TB001',-1,0,0.00,0.00,0.00,0,-1,NULL),(3,5,'3','TB088',-1,0,0.00,0.00,0.00,0,NULL,NULL),(4,6,'4','TB02',-1,0,0.00,0.00,0.00,0,-1,NULL),(5,6,'4','TB02',-1,0,0.00,0.00,0.00,0,NULL,NULL),(6,0,'5','TX001',0,0,0.00,0.00,0.00,0,NULL,NULL),(7,0,'6','',-1,0,0.00,0.00,0.00,0,NULL,NULL),(8,0,'7','JL01',0,1,0.00,0.00,0.00,0,NULL,NULL),(10,7,'9','T1',0,1,0.00,0.00,0.00,0,0,NULL),(12,8,'11','TEST0001',99,1,10.20,10.00,100.99,0,NULL,NULL),(13,8,'12','',99,1,10.00,11.00,23.09,11,NULL,NULL),(14,9,'13','QA123',58,1,0.00,99.00,88.00,7,58,NULL),(15,9,'14','BT12',-1,0,0.00,4.00,333.00,0,-1,NULL),(18,9,'17','QA123',58,1,0.00,99.00,88.00,7,NULL,NULL),(19,9,'18','BT12',-1,0,0.00,4.00,333.00,0,NULL,NULL),(20,10,'19','TEST0001',99,0,0.00,0.00,100.99,0,NULL,NULL),(21,10,'20','TEST0002',99,0,0.00,0.00,23.09,0,NULL,NULL),(24,21,'21','QS001',-1,0,0.00,88.00,50.00,0,NULL,NULL),(25,21,'22','',-1,0,0.00,100.00,88.00,0,NULL,NULL),(27,11,'23','FL01',-1,0,0.00,0.00,15.00,0,-1,NULL),(28,11,'24','FL02',-1,0,0.00,0.00,28.00,0,-1,NULL),(29,11,'25','FL03',80,0,0.00,0.00,22.00,0,80,NULL),(30,9,'26','QA123',58,1,0.00,99.00,88.00,7,58,NULL),(31,9,'26','BT12',-1,0,0.00,4.00,333.00,0,-1,NULL);
/*!40000 ALTER TABLE `cmf_food_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_member_card`
--

DROP TABLE IF EXISTS `cmf_member_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_member_card` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `vip_num` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员号',
  `vip_level` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员等级',
  `vip_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员名称',
  `start_at` int(11) NOT NULL COMMENT '起始时间',
  `end_at` int(11) NOT NULL COMMENT '截止时间',
  `create_at` bigint(20) NOT NULL,
  `update_at` bigint(20) NOT NULL,
  `delete_at` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '1',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_member_card`
--

LOCK TABLES `cmf_member_card` WRITE;
/*!40000 ALTER TABLE `cmf_member_card` DISABLE KEYS */;
INSERT INTO `cmf_member_card` VALUES (1,2,'202012282007733481','VIP1','普通会员',1609158072,1609158072,1609158072,1609158072,0,-1,0),(2,1,'20201228982918807','VIP1','普通会员',1609161719,1609161719,1609161719,1609161719,0,-1,0),(3,9,'2021021513007777','VIP1','普通会员',1613355842,1613355872,1613355842,1613355842,0,-1,487934091),(4,10,'202102151877345001','VIP1','普通会员',1613390373,1615982379,1613390373,1613390373,0,-1,487934091),(5,11,'20210218619145790','VIP1','普通会员',1613640709,1616232727,1613640709,1613640709,0,-1,487934091),(6,4,'202103021935432706','VIP1','普通会员',1614677969,1614677999,1614677969,1614677969,0,-1,487934091);
/*!40000 ALTER TABLE `cmf_member_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_member_card_order`
--

DROP TABLE IF EXISTS `cmf_member_card_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_member_card_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `vip_num` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员号',
  `trade_no` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝订单号',
  `vip_level` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员等级',
  `user_id` int(11) DEFAULT NULL COMMENT '下单人信息',
  `pay_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方支付类型',
  `fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '合计金额',
  `create_at` bigint(20) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  `order_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WAIT_BUYER_PAY' COMMENT '订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `vip_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员名称',
  `avatar` longtext COLLATE utf8mb4_general_ci,
  `user_login` longtext COLLATE utf8mb4_general_ci,
  `user_nickname` longtext COLLATE utf8mb4_general_ci,
  `user_real_name` longtext COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_member_card_order`
--

LOCK TABLES `cmf_member_card_order` WRITE;
/*!40000 ALTER TABLE `cmf_member_card_order` DISABLE KEYS */;
INSERT INTO `cmf_member_card_order` VALUES (1,'vip202012282007733481','202012282007733481','2020122822001421661401909176','VIP1',2,'alipay',9.90,1609158072,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(2,'vip202012281650591095','202012281650591095','2020122822001421661401626414','VIP1',2,'alipay',9.90,1609159517,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(3,'vip202012281904349073','202012281904349073','2020122822001421661401657967','VIP1',2,'alipay',9.90,1609159550,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(4,'vip202012281691912304','202012281691912304','2020122822001421661401624900','VIP1',2,'alipay',9.90,1609159752,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(5,'vip20201228666926539','20201228666926539','2020122822001421661401303654','VIP1',2,'alipay',9.90,1609160510,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(6,'vip202012281780043543','202012281780043543','2020122822001421661401983329','VIP1',2,'alipay',9.90,1609161081,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(7,'vip20201228252110546','20201228252110546','2020122822001421661401272022','VIP1',2,'alipay',9.90,1609161295,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(8,'vip20201228982918807','20201228982918807','2020122822001496711457934552','VIP1',1,'alipay',9.90,1609161719,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(9,'vip202012281686947320','202012281686947320','2020122822001496711458975212','VIP1',1,'alipay',9.90,1609162091,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(10,'vip202012281817425294','202012281817425294','2020122822001496711458211461','VIP1',1,'alipay',9.90,1609162112,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(11,'vip20201228536618586','20201228536618586','2020122822001496711458956220','VIP1',1,'alipay',9.90,1609162555,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(12,'vip20201228579992824','20201228579992824','2020122822001496711458906476','VIP1',1,'alipay',9.90,1609162800,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(13,'vip202012281402020808','202012281402020808','2020122822001421661401642832','VIP1',2,'alipay',9.90,1609163071,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(14,'vip202012281199555740','202012281199555740','2020122822001496711458935792','VIP1',1,'alipay',9.90,1609163426,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(15,'vip20201228153473222','20201228153473222','2020122822001496711458211469','VIP1',1,'alipay',9.90,1609164563,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(16,'vip20201228355513297','20201228355513297','2020122822001496711458913271','VIP1',1,'alipay',9.90,1609165433,1609170631,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(17,'vip20201228929173039','20201228929173039','2020122822001421661401653519','VIP1',2,'alipay',9.90,1609167406,1609167412,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(18,'vip20201228638549755','20201228638549755','2020122822001421661401968958','VIP1',2,'alipay',9.90,1609167849,1609167855,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(19,'vip20201229294587116','20201229294587116','2020122922001421661402314409','VIP1',2,'alipay',9.90,1609228013,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(20,'vip202012291943124780','202012291943124780','2020122922001421661402607299','VIP1',2,'alipay',9.90,1609228076,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(21,'vip2020122969996241','2020122969996241','2020122922001421661402315834','VIP1',2,'alipay',9.90,1609228084,1609228090,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(22,'vip20201229896836007','20201229896836007','2020122922001421661402275492','VIP1',2,'alipay',9.90,1609228225,1609228237,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(23,'vip20201229457937097','20201229457937097','2020122922001421661402611922','VIP1',2,'alipay',9.90,1609228426,1609228432,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(24,'vip202012291158445351','202012291158445351','2020122922001421661402603286','VIP1',2,'alipay',9.90,1609228863,1609228870,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(25,'vip202012291076734737','202012291076734737','2020122922001421661401983503','VIP1',2,'alipay',9.90,1609229168,1609229176,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(26,'vip2020123027876406','2020123027876406','2020123022001421661404241353','VIP1',2,'alipay',9.90,1609337205,0,'WAIT_BUYER_PAY',487934091,'',NULL,NULL,NULL,NULL),(27,'vip202012301936668824','202012301936668824','2020123022001421661403333270','VIP1',2,'alipay',9.90,1609337214,1609337220,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(28,'vip20201230388941374','20201230388941374','2020123022001421661403277313','VIP1',2,'alipay',9.90,1609337883,0,'TRADE_FINISHED',487934091,'',NULL,NULL,NULL,NULL),(29,'vip2021021513007777','2021021513007777','2021021522001496711436474736','VIP1',9,'alipay',9.90,1613355842,0,'WAIT_BUYER_PAY',487934091,'普通会员',NULL,NULL,NULL,NULL),(30,'vip20210215471861910','20210215471861910','2021021522001496711436549889','VIP1',9,'alipay',9.90,1613356506,1613368958,'TRADE_FINISHED',487934091,'普通会员',NULL,NULL,NULL,NULL),(31,'vip202102151830484891','202102151830484891','2021021522001496711436510959','VIP1',9,'alipay',9.90,1613356994,1613369445,'TRADE_FINISHED',487934091,'普通会员',NULL,NULL,NULL,NULL),(32,'vip20210215466919599','20210215466919599','2021021522001496711436730479','VIP1',9,'alipay',9.90,1613365861,1613366062,'TRADE_FINISHED',487934091,'普通会员',NULL,NULL,NULL,NULL),(33,'vip202102151896336371','202102151896336371','2021021522001496711436510994','VIP1',9,'alipay',9.90,1613366008,1613366045,'TRADE_FINISHED',487934091,'普通会员',NULL,NULL,NULL,NULL),(34,'vip202102151877345001','202102151877345001','2021021522001496711436603821','VIP1',10,'alipay',9.90,1613390373,1613390379,'TRADE_FINISHED',487934091,'普通会员',NULL,NULL,NULL,NULL),(35,'vip20210215830734076','202102151877345001','2021021522001496711436891374','VIP1',10,'alipay',9.90,1613393203,0,'WAIT_BUYER_PAY',487934091,'普通会员',NULL,NULL,NULL,NULL),(36,'vip20210218619145790','20210218619145790','2021021822001496711437749045','VIP1',11,'alipay',9.90,1613640709,1613640727,'TRADE_FINISHED',487934091,'普通会员',NULL,NULL,NULL,NULL),(37,'vip202103021935432706','202103021935432706','2021030222001496731449330288','VIP1',NULL,'alipay',9.90,1614677969,0,'WAIT_BUYER_PAY',487934091,'普通会员',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `cmf_member_card_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_migrate_user`
--

DROP TABLE IF EXISTS `cmf_migrate_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_migrate_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) NOT NULL DEFAULT '0',
  `gender` tinyint(2) DEFAULT '0' COMMENT '性别',
  `birthday` int(11) DEFAULT NULL,
  `last_login_at` int(11) DEFAULT NULL,
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
  `coin` bigint(20) NOT NULL DEFAULT '0' COMMENT '金币',
  `exp` bigint(20) NOT NULL DEFAULT '0' COMMENT '经验',
  `balance` decimal(10,2) NOT NULL COMMENT '余额',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT NULL,
  `user_status` tinyint(3) NOT NULL DEFAULT '1',
  `user_login` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_pass` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_nickname` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_real_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_url` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` longtext COLLATE utf8mb4_general_ci,
  `signature` longtext COLLATE utf8mb4_general_ci,
  `last_login_ip` longtext COLLATE utf8mb4_general_ci,
  `user_activation_key` longtext COLLATE utf8mb4_general_ci,
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `more` text COLLATE utf8mb4_general_ci,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_migrate_user`
--

LOCK TABLES `cmf_migrate_user` WRITE;
/*!40000 ALTER TABLE `cmf_migrate_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_migrate_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_mp_isv_auth`
--

DROP TABLE IF EXISTS `cmf_mp_isv_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_mp_isv_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(20) NOT NULL COMMENT '租户id',
  `mp_id` int(11) NOT NULL COMMENT '小程序加密编号',
  `type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权商户小程序类型',
  `user_id` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权商户的user_id',
  `auth_app_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权商户的appId',
  `app_auth_token` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用授权令牌',
  `app_refresh_token` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '刷新令牌',
  `expires_in` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用授权令牌的有效时间（从接口调用时间作为起始时间），单位到秒',
  `re_expires_in` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '刷新令牌的有效时间（从接口调用时间作为起始时间），单位到秒',
  `encrypt_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口加密类型',
  `encrypt_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口加密内容',
  `create_at` int(10) DEFAULT '0' COMMENT '创建时间',
  `update_at` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inx_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_isv_auth`
--

LOCK TABLES `cmf_mp_isv_auth` WRITE;
/*!40000 ALTER TABLE `cmf_mp_isv_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_mp_isv_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_mp_theme`
--

DROP TABLE IF EXISTS `cmf_mp_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_mp_theme` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
  `category` tinyint(3) NOT NULL DEFAULT '0' COMMENT '小程序类型分类',
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序主题名称',
  `version` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序版本',
  `thumbnail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序缩略图',
  `theme_id` int(11) NOT NULL COMMENT '小程序原主题id',
  `tenant_id` int(11) NOT NULL COMMENT '小程序所属租户id',
  `create_at` int(10) DEFAULT '0' COMMENT '创建时间',
  `update_at` int(10) DEFAULT '0' COMMENT '更新时间',
  `list_order` double DEFAULT '10000' COMMENT '排序',
  `delete_at` int(10) DEFAULT '0' COMMENT '删除时间',
  `app_logo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序应用logo图标',
  `alipay_category_ids` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '新小程序前台类目',
  `app_desc` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序应用描述，20-200个字',
  `encrypt_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序接口加密内容',
  `alipay_exp_qr_code_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝小程序体验版二维码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme`
--

LOCK TABLES `cmf_mp_theme` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme` VALUES (1,487934091,0,'码上火锅','','',0,1,1605203679,0,10000,0,'','','','xlGXShQZoLxxBj2ZOEV3AA==',''),(2,1523022340,0,'news','','',0,1,1606205782,0,10000,1609338455,'','','','',''),(3,298781836,0,'测试小程序2021001192675085','','',0,1,1606555141,0,10000,1609338453,'','','','',''),(4,887071270,0,'海底吧','','',1,1,1608556549,0,10000,1609338451,'','','','',''),(5,963051965,0,'码上火锅','','',0,1,1613882895,0,10000,1613882900,'','','','','');
/*!40000 ALTER TABLE `cmf_mp_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_mp_theme_page`
--

DROP TABLE IF EXISTS `cmf_mp_theme_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_mp_theme_page` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `theme_id` int(11) DEFAULT NULL,
  `home` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否为首页',
  `title` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '页面名称',
  `style` text COLLATE utf8mb4_general_ci COMMENT '主题文件用户公共样式',
  `config_style` text COLLATE utf8mb4_general_ci COMMENT '主题文件默认公共样式',
  `more` text COLLATE utf8mb4_general_ci COMMENT '主题文件用户配置文件',
  `config_more` text COLLATE utf8mb4_general_ci COMMENT '主题文件默认配置文件',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `file` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '页面路径',
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_page`
--

LOCK TABLES `cmf_mp_theme_page` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_page` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_page` VALUES (1,1,1,'首页','','','[{\"type\":\"swiper\",\"data\":[{\"name\":\"\",\"image\":\"http://cdn.mashangdian.cn/tenant/487934091/20210301/f899cd05c1466def1742fb965b40c74f.png!clipper\",\"file_path\":\"tenant/487934091/20210301/f899cd05c1466def1742fb965b40c74f.png\",\"link\":\"\",\"id\":35}],\"config\":{\"autoHeight\":true},\"styleObj\":{}},{\"type\":\"container\",\"child\":[{\"type\":\"grid\",\"data\":[{\"image\":\"http://cdn.mashangdian.cn/tenant/487934091/20210301/dbabd9887b67d1895b611a66dd0eeb5c.png!clipper\",\"name\":\"外卖送餐\",\"desc\":\"安心外送，超快送达\",\"id\":38,\"file_path\":\"tenant/487934091/20210301/dbabd9887b67d1895b611a66dd0eeb5c.png\",\"title\":\"外卖到家\",\"action\":{\"type\":\"func\",\"index\":1,\"name\":\"外卖送餐\",\"url\":\"pages/store/index?scene=takeout\",\"method\":\"switchTab\"}},{\"image\":\"http://cdn.mashangdian.cn/tenant/487934091/20210301/a105a2f2b43cf348b000e65a1755d534.png!clipper\",\"name\":\"到店取餐\",\"desc\":\"下单免排队\",\"id\":37,\"file_path\":\"tenant/487934091/20210301/a105a2f2b43cf348b000e65a1755d534.png\",\"title\":\"到店取餐\",\"action\":{\"type\":\"func\",\"index\":0,\"name\":\"到店取餐\",\"url\":\"pages/store/index?scene=pack\",\"method\":\"switchTab\"}},{\"image\":\"http://cdn.mashangdian.cn/tenant/487934091/20210301/a2d3aecd68a1eaa55beefa8f459c57f0.png!clipper\",\"name\":\"扫码点餐\",\"desc\":\"美味即刻上桌\",\"id\":36,\"file_path\":\"tenant/487934091/20210301/a2d3aecd68a1eaa55beefa8f459c57f0.png\",\"title\":\"扫码点餐\",\"action\":{\"type\":\"func\",\"index\":2,\"name\":\"扫码点餐\",\"url\":\"func/scan\",\"method\":\"func/scan\"}}],\"config\":{\"theme\":\"third\"},\"styleObj\":{\"theme\":\"third\",\"len\":3},\"style\":{\"borderRadius\":10,\"marginBottom\":10}},{\"type\":\"userinfo\",\"data\":[{\"image\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\",\"title\":\"我的余额\",\"number\":0,\"field\":\"balance\",\"desc\":\"余额更超值~\",\"action\":{\"type\":\"func\",\"index\":7,\"name\":\"余额储值\",\"url\":\"pages/mine/money/index\",\"method\":\"\"}}],\"config\":{},\"style\":{\"marginBottom\":10}},{\"type\":\"title\",\"data\":{\"title\":\"自定义标题\",\"value\":\"商家新鲜事\",\"action\":{}},\"config\":{\"more\":true},\"style\":{\"backgroundColor\":\"rgba(34, 25, 77, 0)\",\"backgroundColorRgb\":{\"r\":34,\"g\":25,\"b\":77,\"a\":0},\"color\":\"rgba(51, 51, 51, 1)\",\"colorRgb\":{\"r\":51,\"g\":51,\"b\":51,\"a\":1},\"paddingBottom\":10}},{\"type\":\"list\",\"data\":[],\"config\":{\"source\":{\"categoryId\":1,\"api\":\"portal/list\"}},\"style\":{}}],\"config\":{},\"style\":{\"position\":\"relative\",\"top\":-10,\"paddingLeft\":10,\"paddingRight\":10}}]','',1605203679,0,'home',487934091),(2,2,1,'首页','','','','',1606205782,0,'home',298781836),(3,3,1,'首页','','','','',1606555141,0,'home',1523022340),(4,4,1,'首页','','','','',1608556550,0,'home',887071270),(5,5,1,'首页','','','','',1613882895,0,'home',963051965);
/*!40000 ALTER TABLE `cmf_mp_theme_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_mp_theme_version`
--

DROP TABLE IF EXISTS `cmf_mp_theme_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_mp_theme_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
  `version` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序版本',
  `is_audit` tinyint(3) NOT NULL COMMENT '小程序版本审核状态',
  `status` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'wait' COMMENT '小程序版本状态(gray:灰度，wait:待审核，audit:已审核，online:已上线，offline：下架)',
  `type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权商户小程序类型',
  `create_at` int(10) DEFAULT '0' COMMENT '创建时间',
  `update_at` int(10) DEFAULT '0' COMMENT '更新时间',
  `template_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序构建模板id',
  `template_version` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序构建模板版本',
  `reject_reason` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_version`
--

LOCK TABLES `cmf_mp_theme_version` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_version` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_version` VALUES (1,487934091,'0.0.2',0,'wait','alipay',1614417618,0,'','',NULL),(2,487934091,'0.0.3',0,'wait','alipay',1614417618,0,'','',NULL),(3,487934091,'0.0.4',0,'wait','alipay',1614417618,0,'','',NULL),(4,487934091,'0.0.5',0,'wait','alipay',1614417618,0,'','',NULL),(5,487934091,'0.0.6',0,'wait','alipay',1614417618,0,'','',NULL),(6,487934091,'0.0.7',0,'wait','alipay',1614417618,0,'','',NULL),(7,487934091,'0.0.8',0,'wait','alipay',1614417618,0,'','',NULL),(8,487934091,'0.0.9',0,'wait','alipay',1614417618,0,'','',NULL),(9,487934091,'0.0.10',0,'wait','alipay',1614417618,0,'','',NULL),(10,487934091,'0.0.11',0,'wait','alipay',1614417618,0,'','',NULL),(11,487934091,'0.0.15',0,'wait','',1614697453,0,'','',NULL);
/*!40000 ALTER TABLE `cmf_mp_theme_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_option`
--

DROP TABLE IF EXISTS `cmf_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `auto_load` tinyint(3) NOT NULL DEFAULT '1',
  `option_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `option_value` text COLLATE utf8mb4_general_ci,
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_option`
--

LOCK TABLES `cmf_option` WRITE;
/*!40000 ALTER TABLE `cmf_option` DISABLE KEYS */;
INSERT INTO `cmf_option` VALUES (1,1,'site_info','{\"site_name\":\"\",\"admin_password\":\"\",\"site_seo_title\":\"\",\"site_seo_keywords\":\"\",\"site_seo_description\":\"\",\"site_icp\":\"\",\"site_gwa\":\"\",\"site_admin_email\":\"\",\"site_analytics\":\"\",\"open_registration\":\"\"}',0,0),(2,1,'upload_setting','{\"max_files\":20,\"chunk_size\":512,\"file_types\":{\"image\":{\"upload_max_file_size\":10240,\"extensions\":\"jpg,jpeg,png,gif,bmp4,svg\"},\"video\":{\"upload_max_file_size\":102400,\"extensions\":\"mp4,avi,wmv,rm,rmvb,mkv\"},\"audio\":{\"upload_max_file_size\":10240,\"extensions\":\"mp3,wma,wav\"},\"file\":{\"upload_max_file_size\":10240,\"extensions\":\"txt,pdf,doc,docx,xls,xlsx,ppt,pptx,zip,rar\"}}}',0,0),(3,1,'business_info','{\"brand_name\":\"码上云\",\"brand_logo\":\"default/20201218/f9d6070cb291a0c75159fe06fafdf6f8.jpg\",\"alipay_logo_id\":\"mo4rWTP4TReAsy4GJZoFwwAAACMAAQQD\",\"company\":\"\",\"address\":\"\",\"contact\":\"\",\"mobile\":\"400-820-8820\",\"email\":\"\",\"business_license\":\"\",\"business_scope\":\"\",\"business_expired\":\"\",\"business_photo\":\"\"}',0,487934091),(4,1,'eat_in','{\"status\":0,\"enabled_sell_clear\":0,\"sell_clear\":\"15:00\",\"sale_type\":1,\"eat_type\":0,\"surcharge_type\":1,\"surcharge\":20,\"custom_enabled\":1,\"custom_name\":\"餐盒\",\"pay_type\":0,\"enabled_appointment\":1,\"day\":0}',1,0),(5,1,'vip_info','{\"recharge_point\":1,\"consume_point\":1,\"exp_valid_period\":-1,\"level\":[{\"num\":9.9,\"get_type\":\"pay\",\"level_id\":\"VIP1\",\"level_name\":\"普通会员\",\"exp_range_start\":0,\"exp_range_end\":200,\"benefit\":{\"discount_enabled\":1,\"discount\":8,\"points_enabled\":0,\"points\":0,\"voucher_enabled\":1,\"voucher\":{\"once\":[{\"send_type\":\"once\",\"voucher_name\":\"满5减1\",\"voucher_id\":1,\"template_id\":\"\"},{\"send_type\":\"month\",\"voucher_name\":\"满10减1\",\"voucher_id\":2,\"template_id\":\"\"}],\"month\":[{\"send_type\":\"month\",\"voucher_name\":\"满2减1\",\"voucher_id\":1,\"template_id\":\"\"},{\"send_type\":\"month\",\"voucher_name\":\"满10减5\",\"voucher_id\":2,\"template_id\":\"\"}]}}},{\"num\":9.9,\"get_type\":\"pay\",\"level_id\":\"VIP2\",\"level_name\":\"黄金会员\",\"exp_range_start\":200,\"exp_range_end\":1000,\"benefit\":{\"discount_enabled\":1,\"discount\":8,\"points_enabled\":0,\"points\":0,\"voucher_enabled\":1,\"voucher\":{\"once\":[{\"send_type\":\"once\",\"voucher_name\":\"满20减10\",\"voucher_id\":1,\"template_id\":\"\"},{\"send_type\":\"month\",\"voucher_name\":\"满20减15\",\"voucher_id\":2,\"template_id\":\"\"}],\"month\":[{\"send_type\":\"month\",\"voucher_name\":\"满4减3\",\"voucher_id\":1,\"template_id\":\"\"},{\"send_type\":\"month\",\"voucher_name\":\"满10减8\",\"voucher_id\":2,\"template_id\":\"\"}]}}}]}',0,0),(6,1,'take_out','{\"status\":1,\"immediate_delivery\":0,\"enabled_appointment\":0,\"day\":0,\"enabled_sell_clear\":0,\"sell_clear\":\"23:00\",\"automatic_order\":0,\"delivery_distance\":5,\"stop_before_min\":0,\"start_km\":10,\"start_fee\":2,\"step_km\":3,\"step_fee\":1.5}',1,487934091),(7,1,'vip_info','{\"enabled_recharge\":0,\"recharge_point\":1,\"enabled_consume\":1,\"consume_point\":1,\"exp_valid_period\":-1,\"level\":[{\"num\":9.9,\"get_type\":\"pay\",\"level_id\":\"VIP1\",\"level_name\":\"普通会员\",\"exp_range_start\":0,\"exp_range_end\":200,\"benefit\":{\"enabled_discount\":1,\"discount\":8.8,\"enabled_point\":1,\"point\":90,\"enabled_voucher\":1,\"voucher\":{\"once\":[{\"send_type\":\"\",\"count\":20,\"voucher_name\":\"【测试】全场满10减2券\",\"voucher_description\":\"\",\"voucher_description_map\":null,\"voucher_id\":2,\"template_id\":\"\"}],\"month\":[{\"send_type\":\"\",\"count\":5,\"voucher_name\":\"【测试】全场满10减2券\",\"voucher_description\":\"\",\"voucher_description_map\":null,\"voucher_id\":2,\"template_id\":\"\"}]}}},{\"num\":9.9,\"get_type\":\"pay\",\"level_id\":\"VIP2\",\"level_name\":\"黄金会员\",\"exp_range_start\":200,\"exp_range_end\":1000,\"benefit\":{\"enabled_discount\":0,\"discount\":8,\"enabled_point\":0,\"point\":0,\"enabled_voucher\":1,\"voucher\":{\"once\":[{\"send_type\":\"\",\"count\":0,\"voucher_name\":\"满20减10\",\"voucher_description\":\"\",\"voucher_description_map\":null,\"voucher_id\":1,\"template_id\":\"\"},{\"send_type\":\"\",\"count\":0,\"voucher_name\":\"满20减15\",\"voucher_description\":\"\",\"voucher_description_map\":null,\"voucher_id\":2,\"template_id\":\"\"}],\"month\":[{\"send_type\":\"\",\"count\":0,\"voucher_name\":\"满4减3\",\"voucher_description\":\"\",\"voucher_description_map\":null,\"voucher_id\":1,\"template_id\":\"\"},{\"send_type\":\"\",\"count\":0,\"voucher_name\":\"满10减8\",\"voucher_description\":\"\",\"voucher_description_map\":null,\"voucher_id\":2,\"template_id\":\"\"}]}}}]}',0,487934091),(8,1,'recharge','[{\"gear\":50,\"enabled_money\":1,\"money\":5,\"enabled_score\":1,\"score\":5,\"enabled_voucher\":0,\"voucher\":null},{\"gear\":100,\"enabled_money\":1,\"money\":20,\"enabled_score\":1,\"score\":20,\"enabled_voucher\":0,\"voucher\":null},{\"gear\":200,\"enabled_money\":1,\"money\":50,\"enabled_score\":1,\"score\":50,\"enabled_voucher\":0,\"voucher\":null},{\"gear\":300,\"enabled_money\":1,\"money\":80,\"enabled_score\":1,\"score\":80,\"enabled_voucher\":0,\"voucher\":null},{\"gear\":400,\"enabled_money\":1,\"money\":120,\"enabled_score\":1,\"score\":120,\"enabled_voucher\":0,\"voucher\":null}]',0,487934091),(9,1,'score','{\"enabled_pay\":1,\"pay_score\":9,\"enabled_to_score\":1,\"to_score\":2,\"valid_period\":3}',0,487934091),(10,1,'eat_in','{\"status\":1,\"enabled_sell_clear\":0,\"sell_clear\":\"23:00\",\"sale_type\":0,\"eat_type\":1,\"surcharge_type\":0,\"surcharge\":0,\"custom_enabled\":0,\"custom_name\":\"\",\"pay_type\":0,\"enabled_appointment\":0,\"day\":0}',1,487934091);
/*!40000 ALTER TABLE `cmf_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_pay_log`
--

DROP TABLE IF EXISTS `cmf_pay_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_pay_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '系统订单号',
  `trade_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方订单号',
  `type` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付类型',
  `app_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序appId',
  `buyer_id` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付宝付款人id',
  `total_amount` decimal(9,2) NOT NULL COMMENT '本次交易支付的订单金额，单位为人民币（元）',
  `receipt_amount` decimal(9,2) DEFAULT NULL COMMENT '商家在交易中实际收到的款项，单位为人民币（元）',
  `invoice_amount` decimal(9,2) DEFAULT NULL COMMENT '用户在交易中支付的可开发票的金额',
  `buyer_pay_amount` decimal(9,2) DEFAULT NULL COMMENT '用户在交易中支付的金额',
  `point_amount` decimal(9,2) DEFAULT NULL COMMENT '使用集分宝支付的金额',
  `refund_dee` decimal(9,2) DEFAULT NULL COMMENT '退款通知中，返回总退款金额，单位为元，支持两位小数',
  `send_back_fee` decimal(9,2) DEFAULT NULL COMMENT '商户实际退款给用户的金额，单位为元，支持两位小数',
  `subject` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品的标题/交易标题/订单标题/订单关键字等，是请求时对应的参数，原样通知回来。',
  `body` varchar(400) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '该订单的备注、描述、明细等。对应请求时的 body 参数，原样通知回来。',
  `fund_bill_list` json DEFAULT NULL COMMENT '支付成功的各个渠道金额信息',
  `gmt_payment` bigint(20) DEFAULT NULL COMMENT '交易付款时间',
  `gmt_refund` bigint(20) DEFAULT NULL COMMENT '交易退款时间',
  `gmt_close` bigint(20) DEFAULT NULL COMMENT '交易结束时间',
  `trade_status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '交易状态',
  `refund_fee` decimal(9,2) DEFAULT NULL COMMENT '退款通知中，返回总退款金额，单位为元，支持两位小数',
  `user_id` int(11) DEFAULT NULL COMMENT '下单人信息',
  PRIMARY KEY (`id`),
  KEY `idx_gmt_payment` (`gmt_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_pay_log`
--

LOCK TABLES `cmf_pay_log` WRITE;
/*!40000 ALTER TABLE `cmf_pay_log` DISABLE KEYS */;
INSERT INTO `cmf_pay_log` VALUES (1,'T20201201615570852','2020120122001496715730797432','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606820744,0,0,'TRADE_SUCCESS',NULL,NULL),(2,'T20201130811216905','2020113022001496715731183585','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606743638,0,0,'TRADE_SUCCESS',NULL,NULL),(3,'T20201130427603013','2020113022001496715730719258','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606743904,0,0,'TRADE_SUCCESS',NULL,NULL),(4,'T202011301274409912','2020113022001496715730796597','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606744176,0,0,'TRADE_SUCCESS',NULL,NULL),(5,'T202011301881517503','2020113022001496715730707498','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606744669,0,0,'TRADE_SUCCESS',NULL,NULL),(6,'T20201130832673371','2020113022001496715730747321','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606745222,0,0,'TRADE_SUCCESS',NULL,NULL),(7,'T202011301771346410','2020113022001496715731183619','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606746453,0,0,'TRADE_SUCCESS',NULL,NULL),(8,'T202011301608412566','2020113022001496715731136505','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,0.00,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1606747717,0,0,'TRADE_SUCCESS',NULL,NULL),(9,'T202012071299316215','2020120722001496715738638606','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1607348968,0,0,'TRADE_SUCCESS',0.00,NULL),(10,'T20201207149421672','2020120722001496715738273870','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1607349015,0,0,'TRADE_SUCCESS',0.00,NULL),(11,'T2020121181698872','2020121122001496715742963973','alipay','2021001192675085','2088512446596714',20.11,18.10,18.10,18.10,0.00,NULL,0.00,'测试下单小程序','测试下单小程序','[{\"amount\": \"18.10\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.01\", \"fundChannel\": \"MDISCOUNT\"}]',1607656546,0,0,'TRADE_SUCCESS',0.00,NULL),(12,'vip20201219868314977','2020121922001496711450845054','alipay','2021001192675085','2088512446596714',9.90,9.90,9.90,9.90,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"9.90\", \"fundChannel\": \"PCREDIT\"}]',1608357147,0,0,'TRADE_SUCCESS',0.00,NULL),(13,'T20201220279120732','2020122022001496711450818299','alipay','2021001192675085','2088512446596714',20.11,20.11,20.11,20.11,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"20.11\", \"fundChannel\": \"PCREDIT\"}]',1608478357,0,0,'TRADE_SUCCESS',0.00,NULL),(14,'T202012211048424296','2020122122001496711451167885','alipay','2021001192675085','2088512446596714',23.09,23.09,23.09,23.09,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"23.09\", \"fundChannel\": \"PCREDIT\"}]',1608483505,0,0,'TRADE_SUCCESS',0.00,NULL),(15,'T20201221316899050','2020122122001496711451434993','alipay','2021001192675085','2088512446596714',50.00,50.00,50.00,50.00,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"50.00\", \"fundChannel\": \"PCREDIT\"}]',1608517176,0,0,'TRADE_SUCCESS',0.00,NULL),(16,'T20201221902268140','2020122122001496711451227313','alipay','2021001192675085','2088512446596714',50.00,50.00,50.00,50.00,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"50.00\", \"fundChannel\": \"PCREDIT\"}]',1608515941,0,0,'TRADE_SUCCESS',0.00,NULL),(17,'T20201221954980770','2020122122001496711451397603','alipay','2021001192675085','2088512446596714',23.09,23.09,23.09,23.09,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"23.09\", \"fundChannel\": \"PCREDIT\"}]',1608516941,0,0,'TRADE_SUCCESS',0.00,NULL),(18,'vip20201228929173039','2020122822001421661401653519','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609167411,0,0,'TRADE_SUCCESS',0.00,NULL),(19,'vip20201228638549755','2020122822001421661401968958','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609167854,0,0,'TRADE_SUCCESS',0.00,NULL),(20,'vip20201228355513297','2020122822001496711458913271','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609165474,0,0,'TRADE_SUCCESS',0.00,NULL),(21,'vip2020122969996241','2020122922001421661402315834','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609228089,0,0,'TRADE_SUCCESS',0.00,NULL),(22,'vip20201229896836007','2020122922001421661402275492','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609228236,0,0,'TRADE_SUCCESS',0.00,NULL),(23,'vip20201229457937097','2020122922001421661402611922','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609228431,0,0,'TRADE_SUCCESS',0.00,NULL),(24,'vip202012291158445351','2020122922001421661402603286','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609228869,0,0,'TRADE_SUCCESS',0.00,NULL),(25,'vip202012291076734737','2020122922001421661401983503','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609229173,0,0,'TRADE_SUCCESS',0.00,NULL),(26,'20123001502300700006130009045034','2020123022001496711400205300','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609320453,0,0,'TRADE_SUCCESS',0.00,NULL),(27,'20123001502300700006130009043488','2020123022001496711400229320','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609320466,0,0,'TRADE_SUCCESS',0.00,NULL),(28,'20123001502300700006130009055811','2020123022001496711400971344','alipay','2021001192675085','2088512446596714',5.15,5.15,5.14,5.15,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"0.01\", \"fundChannel\": \"COUPON\"}, {\"amount\": \"5.14\", \"fundChannel\": \"PCREDIT\"}]',1609320568,0,0,'TRADE_SUCCESS',0.00,NULL),(29,'20123001502300700006130009063537','2020123022001496711400269885','alipay','2021001192675085','2088512446596714',10.00,8.00,7.99,8.00,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"0.01\", \"fundChannel\": \"COUPON\"}, {\"amount\": \"7.99\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"MDISCOUNT\"}]',1609330161,0,0,'TRADE_SUCCESS',0.00,NULL),(30,'20123001502300700006130009076953','2020123022001496711400979221','alipay','2021001192675085','2088512446596714',10.00,10.00,10.00,10.00,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"10.00\", \"fundChannel\": \"PCREDIT\"}]',1609330177,0,0,'TRADE_SUCCESS',0.00,NULL),(31,'vip202012301936668824','2020123022001421661403333270','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1609337219,0,0,'TRADE_SUCCESS',0.00,NULL),(32,'20123101502300700006130009112062','2020123122001496711400976483','alipay','2021001192675085','2088512446596714',5.00,4.00,4.00,4.00,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"4.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"1.00\", \"fundChannel\": \"MDISCOUNT\"}]',1609376945,0,0,'TRADE_SUCCESS',0.00,NULL),(33,'recharge202101151183221030','2021011522001496711413175583','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1610723353,0,0,'TRADE_SUCCESS',0.00,1),(34,'recharge202101191401720272','2021011922001493311422168647','alipay','2021001192675085','2088932470093311',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1610986467,0,0,'TRADE_SUCCESS',0.00,2),(35,'recharge202101221342919137','2021012222001496711419035228','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611285034,0,0,'TRADE_SUCCESS',0.00,1),(36,'recharge202101221342919137','2021012222001496711419035228','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611285034,0,0,'TRADE_SUCCESS',0.00,1),(37,'recharge202101221342919137','2021012222001496711419035228','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611285034,0,0,'TRADE_SUCCESS',0.00,1),(38,'recharge20210122154785877','2021012222001421661422676774','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611289356,0,0,'TRADE_SUCCESS',0.00,3),(39,'recharge202101221262694305','2021012222001421661422140539','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611290342,0,0,'TRADE_SUCCESS',0.00,3),(40,'recharge202101221197195190','2021012222001421661422133442','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611290398,0,0,'TRADE_SUCCESS',0.00,3),(41,'recharge202101221049037313','2021012222001421661422779111','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611290609,0,0,'TRADE_SUCCESS',0.00,3),(42,'recharge20210122123402531','2021012222001421661422649982','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611290765,0,0,'TRADE_SUCCESS',0.00,3),(43,'recharge2021012285903387','2021012222001421661422729176','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611290852,0,0,'TRADE_SUCCESS',0.00,3),(44,'recharge202101222098131550','2021012222001421661422227853','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611291106,0,0,'TRADE_SUCCESS',0.00,3),(45,'recharge202101221684977402','2021012222001421661422204086','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611291305,0,0,'TRADE_SUCCESS',0.00,3),(46,'recharge202101222116359431','2021012222001421661422140545','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611291448,0,0,'TRADE_SUCCESS',0.00,3),(47,'recharge202101221802729686','2021012222001421661422167158','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611291571,0,0,'TRADE_SUCCESS',0.00,3),(48,'recharge20210122650609504','2021012222001421661422779114','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611291908,0,0,'TRADE_SUCCESS',0.00,3),(49,'recharge202101222043536865','2021012222001421661422658542','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611291928,0,0,'TRADE_SUCCESS',0.00,3),(50,'recharge202101221307615675','2021012222001421661422102929','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611293433,0,0,'TRADE_SUCCESS',0.00,3),(51,'recharge202101221206109899','2021012222001421661422139465','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611293512,0,0,'TRADE_SUCCESS',0.00,3),(52,'recharge20210122891830557','2021012222001421661422227859','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611293697,0,0,'TRADE_SUCCESS',0.00,3),(53,'recharge20210122732395344','2021012222001421661422168863','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611296688,0,0,'TRADE_SUCCESS',0.00,3),(54,'recharge20210122287250355','2021012222001421661422758498','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611296847,0,0,'TRADE_SUCCESS',0.00,3),(55,'recharge20210122241674889','2021012222001421661422185839','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611296986,0,0,'TRADE_SUCCESS',0.00,3),(56,'recharge202101221263231742','2021012222001421661422132098','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611297014,0,0,'TRADE_SUCCESS',0.00,3),(57,'recharge202101222090330237','2021012222001421661422102946','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611299035,0,0,'TRADE_SUCCESS',0.00,5),(58,'recharge20210122869226172','2021012222001421661421934094','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611300490,0,0,'TRADE_SUCCESS',0.00,5),(59,'recharge202101221223859494','2021012222001421661421911377','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611301178,0,0,'TRADE_SUCCESS',0.00,5),(60,'recharge202101221490265919','2021012222001421661421923693','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611301323,0,0,'TRADE_SUCCESS',0.00,5),(61,'recharge20210122686253915','2021012222001421661422139486','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611301388,0,0,'TRADE_SUCCESS',0.00,5),(62,'recharge202101221354056010','2021012222001496711419002281','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611301416,0,0,'TRADE_SUCCESS',0.00,1),(63,'recharge202101221831534744','2021012222001421661422733201','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611302797,0,0,'TRADE_SUCCESS',0.00,5),(64,'recharge20210122239558230','2021012222001421661422227885','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611302956,0,0,'TRADE_SUCCESS',0.00,5),(65,'recharge202101221975516857','2021012222001421661422658565','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611303103,0,0,'TRADE_SUCCESS',0.00,5),(66,'recharge20210122283469678','2021012222001421661422154730','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611303191,0,0,'TRADE_SUCCESS',0.00,5),(67,'recharge202101221769001073','2021012222001421661422132115','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611303381,0,0,'TRADE_SUCCESS',0.00,5),(68,'recharge202101221526184914','2021012222001421661423036198','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611303496,0,0,'TRADE_SUCCESS',0.00,5),(69,'recharge20210122843993371','2021012222001421661422661608','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611303621,0,0,'TRADE_SUCCESS',0.00,5),(70,'recharge20210122910721314','2021012222001421661423023670','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611303639,0,0,'TRADE_SUCCESS',0.00,5),(71,'recharge20210122925582821','2021012222001421661422171499','alipay','2021001192675085','2088932845621666',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611304794,0,0,'TRADE_SUCCESS',0.00,5),(72,'recharge202101271134485672','2021012722001496711423920967','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1611737420,0,0,'TRADE_SUCCESS',0.00,9),(73,'vip202102151896336371','2021021522001496711436510994','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613366044,0,0,'TRADE_SUCCESS',0.00,9),(74,'vip20210215466919599','2021021522001496711436730479','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613365878,0,0,'TRADE_SUCCESS',0.00,9),(75,'vip20210215471861910','2021021522001496711436549889','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613356511,0,0,'TRADE_SUCCESS',0.00,9),(76,'vip202102151830484891','2021021522001496711436510959','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613356999,0,0,'TRADE_SUCCESS',0.00,9),(77,'21021501502300700006130011400455','2021021522001496711436540501','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613376665,0,0,'TRADE_SUCCESS',0.00,0),(78,'21021501502300700006130011415195','2021021522001496711436523648','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613376719,0,0,'TRADE_SUCCESS',0.00,0),(79,'21021501502300700006130011418875','2021021522001496711436744661','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'IOT当面付','','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613376898,0,0,'TRADE_SUCCESS',0.00,0),(80,'T2021021527165104','2021021522001496711436942904','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613390339,0,0,'TRADE_SUCCESS',0.00,10),(81,'vip202102151877345001','2021021522001496711436603821','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613390378,0,0,'TRADE_SUCCESS',0.00,10),(82,'recharge20210215840305296','2021021522001496711436742753','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613390432,0,0,'TRADE_SUCCESS',0.00,10),(83,'recharge20210215776835250','2021021522001496711436949636','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613393962,0,0,'TRADE_SUCCESS',0.00,10),(84,'recharge20210215585520307','2021021522001496711436731610','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613394110,0,0,'TRADE_SUCCESS',0.00,10),(85,'recharge20210215309040103','2021021522001496711436911485','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613394945,0,0,'TRADE_SUCCESS',0.00,10),(86,'recharge202102161157998776','2021021622001496711436751302','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613444385,0,0,'TRADE_SUCCESS',0.00,10),(87,'recharge2021021687599144','2021021622001496711436941227','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613444687,0,0,'TRADE_SUCCESS',0.00,10),(88,'recharge2021021627481624','2021021622001496711436935183','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613444862,0,0,'TRADE_SUCCESS',0.00,10),(89,'recharge20210216388018208','2021021622001496711436926718','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613445541,0,0,'TRADE_SUCCESS',0.00,10),(90,'recharge202102161866338350','2021021622001496711437129662','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613445578,0,0,'TRADE_SUCCESS',0.00,10),(91,'T202102161480348004','2021021622001496711436752833','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613446205,0,0,'TRADE_SUCCESS',0.00,10),(92,'T202102171415828908','2021021722001496711437342126','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613491868,0,0,'TRADE_SUCCESS',0.00,10),(93,'T2021021736586665','2021021722001496711437147570','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613493723,0,0,'TRADE_SUCCESS',0.00,10),(94,'T202102171375236412','2021021722001496711437289931','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613493873,0,0,'TRADE_SUCCESS',0.00,0),(95,'T202102171662383562','2021021722001496711437355576','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613494287,0,0,'TRADE_SUCCESS',0.00,10),(96,'T20210217975087705','2021021722001496711437292774','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613494344,0,0,'TRADE_SUCCESS',0.00,10),(97,'T202102181898208725','2021021822001496711437797133','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613640688,0,0,'TRADE_SUCCESS',0.00,11),(98,'vip20210218619145790','2021021822001496711437749045','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613640726,0,0,'TRADE_SUCCESS',0.00,11),(99,'recharge202102181379988480','2021021822001496711438399215','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云开通会员卡','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613641204,0,0,'TRADE_SUCCESS',0.00,11),(100,'T202102191067458544','2021021922001496711439302397','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613744255,0,0,'TRADE_SUCCESS',0.00,1),(101,'T20210219995378874','2021021922001496711439331515','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613744519,0,0,'TRADE_SUCCESS',0.00,1),(102,'T202102191301421369','2021021922001496711438907828','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613745401,0,0,'TRADE_SUCCESS',0.00,1),(103,'T202102191642674446','2021021922001496711438931165','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1613745441,0,0,'TRADE_SUCCESS',0.00,1),(104,'T20210219865045395','2021021922001496711439287089','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云点餐','[{\"amount\": \"0.01\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1613746007,0,0,'TRADE_SUCCESS',0.00,1),(105,'recharge20210304123407359','2021030422001496711450350281','alipay','2021001192675085','2088512446596714',0.01,0.01,0.01,0.01,0.00,NULL,0.00,'码上云','码上云钱包充值','[{\"amount\": \"0.01\", \"fundChannel\": \"PCREDIT\"}]',1614868995,0,0,'TRADE_SUCCESS',0.00,3);
/*!40000 ALTER TABLE `cmf_pay_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_category`
--

DROP TABLE IF EXISTS `cmf_portal_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_portal_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `parent_id` bigint(20) NOT NULL COMMENT '父级id',
  `post_count` bigint(20) NOT NULL COMMENT '分类文章数',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_at` int(11) NOT NULL COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一名称',
  `alias` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一名称',
  `description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类描述',
  `thumbnail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '缩略图',
  `path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类层级关系',
  `seo_title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '三要素标题',
  `seo_keywords` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '三要素关键字',
  `seo_description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '三要素描述',
  `list_tpl` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类列表模板',
  `one_tpl` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类文章页模板',
  `more` tinytext COLLATE utf8mb4_general_ci COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_category`
--

LOCK TABLES `cmf_portal_category` WRITE;
/*!40000 ALTER TABLE `cmf_portal_category` DISABLE KEYS */;
INSERT INTO `cmf_portal_category` VALUES (1,487934091,0,0,1,0,10000,'商家新鲜事','','','','','','','','','','');
/*!40000 ALTER TABLE `cmf_portal_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_category_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_portal_category_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL COMMENT '文章id',
  `category_id` int(11) NOT NULL COMMENT '分类id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态,1:发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_category_post`
--

LOCK TABLES `cmf_portal_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_category_post` DISABLE KEYS */;
INSERT INTO `cmf_portal_category_post` VALUES (1,1,1,10000,1);
/*!40000 ALTER TABLE `cmf_portal_category_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_post`
--

DROP TABLE IF EXISTS `cmf_portal_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_portal_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `parent_id` int(11) NOT NULL COMMENT '父级id',
  `post_type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '类型（1:文章，2:页面）',
  `post_format` tinyint(3) NOT NULL DEFAULT '1' COMMENT '内容格式（1:html，2:md）',
  `user_id` int(11) NOT NULL COMMENT '发表者用户id',
  `post_status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态（1:已发布，0:未发布）',
  `comment_status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '评论状态（1:允许，0:不允许）',
  `is_top` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否置顶（1:置顶，0:不置顶）',
  `recommended` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否推荐（1:推荐，0:不推荐）',
  `post_hits` int(11) NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_favorites` int(11) NOT NULL DEFAULT '0' COMMENT '收藏数',
  `post_like` int(11) NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` int(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `create_at` bigint(20) NOT NULL,
  `update_at` bigint(20) NOT NULL,
  `published_at` int(11) NOT NULL COMMENT '发布时间',
  `delete_at` int(11) NOT NULL COMMENT '删除实际',
  `post_title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'post标题',
  `post_keywords` varchar(150) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'SEO关键词',
  `post_excerpt` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'post摘要',
  `post_source` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '转载文章的来源',
  `thumbnail` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '缩略图',
  `post_content` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章内容',
  `post_content_filtered` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理过的文章内容',
  `more` json NOT NULL COMMENT '扩展属性,如缩略图。格式为json',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_post`
--

LOCK TABLES `cmf_portal_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_post` DISABLE KEYS */;
INSERT INTO `cmf_portal_post` VALUES (1,487934091,0,1,1,1,1,1,0,0,0,0,0,0,1614567062,1614567062,0,0,'2021新春快乐','','','','tenant/487934091/20210301/9d4e3575cc5719d90a4f9a38473a6a35.png','<p>新年快乐，文章测试。具体以用户上传为准</p>','','{\"audio\": \"\", \"files\": [], \"other\": null, \"video\": \"\", \"photos\": [], \"extends\": {}, \"template\": \"\"}'),(2,487934091,0,1,1,1,1,1,0,0,0,0,0,0,1611664391,1611664391,0,1611664819,'2021新春快乐','','','','default/20210126/35e71bab15cb5d35ec16e5a018aacb9d.png','<section class=\"_editor\">\n<section style=\"background: #aa0c00; box-sizing: border-box;\">\n<section style=\"padding: 10px; box-sizing: border-box;\">\n<section style=\"display: flex; justify-content: space-between; padding-right: 10px; padding-left: 10px; box-sizing: border-box;\">\n<section style=\"width: 42px;\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx9m5IHyImGJOyzkzia1sal7plLDDcUJ6BPmcWacNmegiaPMzn0086IKww/640?wx_fmt=png\" data-width=\"100%\" /></section>\n<section style=\"width: 42px;\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx9m5IHyImGJOyzkzia1sal7plLDDcUJ6BPmcWacNmegiaPMzn0086IKww/640?wx_fmt=png\" data-width=\"100%\" /></section>\n</section>\n<section class=\"_editor\">\n<section style=\"display: flex; justify-content: center; margin-top: -30px;\">\n<section style=\"background: #ee2f18; padding: 5px; box-sizing: border-box; margin-right: 8px; margin-bottom: 5px; display: inline-block;\">\n<section style=\"width: 65px; height: 65px; line-height: 60px; box-sizing: border-box; border: 1px solid #ffffff;\">\n<section style=\"font-size: 50px; color: #fffdfa; text-align: center;\">新</section>\n</section>\n</section>\n<section style=\"background: #fff; padding: 5px; box-sizing: border-box; margin-right: 8px; margin-bottom: 5px; display: inline-block;\">\n<section style=\"width: 65px; height: 65px; line-height: 60px; box-sizing: border-box; border: 1px solid #c19a6b;\">\n<section style=\"font-size: 50px; color: #fffdfa; text-align: center;\"><span style=\"color: #c19a6b;\">年</span></section>\n</section>\n</section>\n</section>\n<section style=\"display: flex; justify-content: center;\">\n<section style=\"background: #fff; padding: 5px; box-sizing: border-box; margin-right: 8px; margin-bottom: 5px; display: inline-block;\">\n<section style=\"width: 65px; height: 65px; line-height: 60px; box-sizing: border-box; border: 1px solid #c19a6b;\">\n<section style=\"font-size: 50px; color: #fffdfa; text-align: center;\"><span style=\"color: #c19a6b;\">快</span></section>\n</section>\n</section>\n<section style=\"background: #ee2f18; padding: 5px; box-sizing: border-box; margin-right: 8px; margin-bottom: 5px; display: inline-block;\">\n<section style=\"width: 65px; height: 65px; line-height: 60px; box-sizing: border-box; border: 1px solid #ffffff;\">\n<section style=\"font-size: 50px; color: #fffdfa; text-align: center;\">乐</section>\n</section>\n</section>\n</section>\n</section>\n<section class=\"_editor\">\n<section style=\"display: flex; justify-content: space-between;\">\n<section style=\"width: 164px; margin-top: -20px; z-index: 0;\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx1e3QYiaaGMd6e7JGT3WyGMzYHMqcsn0EHe0fs5upe2HS30wmGeSs7HQ/640?wx_fmt=png\" data-width=\"100%\" /></section>\n<section style=\"width: 122px; z-index: 0; margin-top: -65px; transform: rotateY(-180deg); -webkit-transform: rotateY(-180deg); -moz-transform: rotateY(-180deg); -ms-transform: rotateY(-180deg); -o-transform: rotateY(-180deg);\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx1e3QYiaaGMd6e7JGT3WyGMzYHMqcsn0EHe0fs5upe2HS30wmGeSs7HQ/640?wx_fmt=png\" data-width=\"100%\" /></section>\n</section>\n<section style=\"margin-top: 22px; margin-bottom: 35px; text-align: center;\">\n<p style=\"font-size: 15px; color: #ffffff; line-height: 30px; letter-spacing: 1.5px;\">新年的钟声已经敲响</p>\n<p style=\"font-size: 15px; color: #ffffff; line-height: 30px; letter-spacing: 1.5px;\">是游子归乡的时节，是合家团圆的美满</p>\n<p style=\"font-size: 15px; color: #ffffff; line-height: 30px; letter-spacing: 1.5px;\">还有甜甜蜜蜜的暖心时刻</p>\n<p style=\"font-size: 15px; color: #ffffff; line-height: 30px; letter-spacing: 1.5px;\">将新春佳节化作更喜乐的时光</p>\n</section>\n</section>\n</section>\n<section class=\"_editor\" style=\"margin: 0px 10px;\">\n<section style=\"margin-top: 10px; margin-bottom: 10px;\">\n<section style=\"display: flex; justify-content: center; align-items: center; transform: rotate(0deg); -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg);\">\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">新</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">年</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">大</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">吉</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">大</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">利</section>\n</section>\n</section>\n</section>\n<section style=\"margin-top: -30px;\">\n<section style=\"padding: 10px; background: #d31323; border-radius: 4px; box-sizing: border-box; border: 1px solid #f5d9a7;\">\n<section style=\"display: flex; justify-content: space-between; align-items: center;\">\n<p style=\"width: 2em;\"><img style=\"display: block; width: auto;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxmV8Ism8f2kqSOyAKCJNuScd87nup2iaXryGyZfIicDIQPcvFRa0rhFgw/640?wx_fmt=png\" /></p>\n<p style=\"width: 2em; transform: rotateY(-180deg); -webkit-transform: rotateY(-180deg); -moz-transform: rotateY(-180deg); -ms-transform: rotateY(-180deg); -o-transform: rotateY(-180deg);\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxmV8Ism8f2kqSOyAKCJNuScd87nup2iaXryGyZfIicDIQPcvFRa0rhFgw/640?wx_fmt=png\" data-width=\"100%\" /></p>\n</section>\n<section style=\"text-align: center; margin-bottom: 25px;\">\n<p style=\"font-size: 15px; line-height: 30px; color: #fbe9b4; letter-spacing: 1.5px;\">鼠年正朝气蓬勃的向您走来，</p>\n<p style=\"font-size: 15px; line-height: 30px; color: #fbe9b4; letter-spacing: 1.5px;\">让我们在新的一年里，携手共进，</p>\n<p style=\"font-size: 15px; line-height: 30px; color: #fbe9b4; letter-spacing: 1.5px;\">不忘初心，砥励前行，</p>\n<p style=\"font-size: 15px; line-height: 30px; color: #fbe9b4; letter-spacing: 1.5px;\">一起开创出一片更美好的天地。</p>\n</section>\n<section style=\"margin-bottom: 25px;\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxTlOCPpxkKvTQqQNYlUkHUAG88ZZfIVsG3zYY1MZ2wic1TFdmUwNficBw/640?wx_fmt=png\" data-width=\"100%\" /></section>\n<section style=\"padding-right: 20px; padding-left: 20px; text-align: center; box-sizing: border-box;\">\n<p style=\"font-size: 15px; line-height: 30px; color: #fbe9b4; letter-spacing: 1.5px; text-align: left;\">春节期间的庆祝活动极为丰富多样， 有舞狮、飘色、耍龙、游神、押舟、年例、 逛庙会、逛花街、赏花灯、烧烟花， 也有踩高跷、跑旱船、扭秧歌等等。内容丰富，热闹喜庆，年味浓郁。春节期间贴春联、守岁、吃团年饭、拜年等 各地皆有之，但因风土人情的不同 细微处又各有其特色</p>\n</section>\n<section style=\"display: flex; justify-content: space-between; align-items: flex-end;\">\n<p style=\"width: 2em; transform: rotateZ(270deg); -webkit-transform: rotateZ(270deg); -moz-transform: rotateZ(270deg); -ms-transform: rotateZ(270deg); -o-transform: rotateZ(270deg);\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxmV8Ism8f2kqSOyAKCJNuScd87nup2iaXryGyZfIicDIQPcvFRa0rhFgw/640?wx_fmt=png\" data-width=\"100%\" /></p>\n<p style=\"width: 2em; transform: rotateZ(180deg); -webkit-transform: rotateZ(180deg); -moz-transform: rotateZ(180deg); -ms-transform: rotateZ(180deg); -o-transform: rotateZ(180deg);\"><img style=\"display: block;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxmV8Ism8f2kqSOyAKCJNuScd87nup2iaXryGyZfIicDIQPcvFRa0rhFgw/640?wx_fmt=png\" /></p>\n</section>\n</section>\n</section>\n</section>\n<section class=\"_editor\" style=\"margin: 20px 0px;\">\n<section style=\"display: flex; justify-content: center; align-items: center;\">\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">春</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">节</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">习</section>\n</section>\n<section style=\"margin-left: -8px; width: 6px; height: 21px; border-radius: 10px; background: #d21323; z-index: 3; box-sizing: border-box;\"></section>\n<section style=\"z-index: 1; width: 45px; height: 45px; background: #d21323; line-height: 45px; border-radius: 50%; display: flex; justify-content: center; align-items: center; overflow: hidden; margin-left: -6px; box-sizing: border-box; border: 2px solid #fbe9b4;\">\n<section style=\"color: #fbe9b4; font-size: 24px;\">俗</section>\n</section>\n</section>\n</section>\n<section class=\"_editor\" style=\"margin: 0px 10px;\">\n<section style=\"margin-top: 30px; margin-bottom: 30px;\">\n<section style=\"padding: 15px; background: #fbe9b4; border-radius: 4px; box-sizing: border-box; border: 1px solid #fa0000;\">\n<section style=\"display: flex; justify-content: space-between; align-items: center;\">\n<p style=\"width: 2em;\"><img style=\"display: block; width: 2em;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx0jsZaibtGPVvy9vaRW2QicZZwqiaxtczHW9KAzIntdvl1QQAfbcibxeRSA/640?wx_fmt=png\" /></p>\n<p style=\"width: 2em; transform: rotateY(-180deg); -webkit-transform: rotateY(-180deg); -moz-transform: rotateY(-180deg); -ms-transform: rotateY(-180deg); -o-transform: rotateY(-180deg);\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx0jsZaibtGPVvy9vaRW2QicZZwqiaxtczHW9KAzIntdvl1QQAfbcibxeRSA/640?wx_fmt=png\" data-width=\"100%\" /></p>\n</section>\n<section class=\"_editor\">\n<section style=\"text-align: center; font-size: 20px; color: #aa0c00; letter-spacing: 1.5px;\">开门炮仗</section>\n<p style=\"font-size: 15px; line-height: 30px; color: #d21323; letter-spacing: 1.5px; padding: 20px 10px;\">早晨，人们出门走亲探友前会先放一挂 爆竹，叫做&ldquo;开门炮仗&rdquo;。爆竹声后，碎 红满地灿若云锦，被称为&ldquo;满堂红&rdquo;。民间认为，&ldquo;开门炮仗&rdquo;放得越早越好， 象征新年万事如意、五谷丰登。</p>\n<section><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxTlOCPpxkKvTQqQNYlUkHUAG88ZZfIVsG3zYY1MZ2wic1TFdmUwNficBw/640?wx_fmt=png\" data-width=\"100%\" /> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</section>\n</section>\n<section class=\"_editor\">\n<section style=\"text-align: center; font-size: 20px; color: #aa0c00; letter-spacing: 1.5px;\">拜年</section>\n<p style=\"font-size: 15px; line-height: 30px; color: #d21323; letter-spacing: 1.5px; padding: 20px 10px;\">春节期间走访拜年是年节传统习俗之 一，是人们辞旧迎新、相互表达美好祝 愿的一种方式。初二、三就开始走亲戚 看朋友，相互拜年。</p>\n<section style=\"display: flex; justify-content: space-between;\">\n<section style=\"width: 48%; overflow: hidden;\" data-width=\"48%\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxKCfA25UlkESOHDUpuDQl8mjGz3JpFl4qDS2d6PYfF791D2YPpgKgtg/640?wx_fmt=png\" data-width=\"100%\" /></section>\n<section style=\"width: 48%; overflow: hidden;\" data-width=\"48%\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxKCfA25UlkESOHDUpuDQl8mjGz3JpFl4qDS2d6PYfF791D2YPpgKgtg/640?wx_fmt=png\" data-width=\"100%\" /> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</section>\n</section>\n</section>\n<section class=\"_editor\">\n<section style=\"text-align: center; font-size: 20px; color: #aa0c00; letter-spacing: 1.5px;\">不易扫地倒垃圾</section>\n<section style=\"margin-top: 25px;\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxTlOCPpxkKvTQqQNYlUkHUAG88ZZfIVsG3zYY1MZ2wic1TFdmUwNficBw/640?wx_fmt=png\" data-width=\"100%\" /></section>\n<p style=\"font-size: 15px; line-height: 30px; color: #d21323; letter-spacing: 1.5px; padding-right: 10px; padding-left: 10px;\">俗传正月初一为扫帚生日，这一天不能 动用扫帚，否则会扫走运气、破财，而 把&ldquo;扫帚星&rdquo;引来，招致霉运。假使非 要扫地不可，须从外头扫到里边。</p>\n</section>\n<section style=\"display: flex; justify-content: space-between; align-items: flex-end;\">\n<p style=\"width: 2em; transform: rotateZ(270deg); -webkit-transform: rotateZ(270deg); -moz-transform: rotateZ(270deg); -ms-transform: rotateZ(270deg); -o-transform: rotateZ(270deg);\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx0jsZaibtGPVvy9vaRW2QicZZwqiaxtczHW9KAzIntdvl1QQAfbcibxeRSA/640?wx_fmt=png\" data-width=\"100%\" /></p>\n<p style=\"width: 2em; transform: rotateZ(180deg); -webkit-transform: rotateZ(180deg); -moz-transform: rotateZ(180deg); -ms-transform: rotateZ(180deg); -o-transform: rotateZ(180deg);\"><img style=\"display: block; width: 3em;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqx0jsZaibtGPVvy9vaRW2QicZZwqiaxtczHW9KAzIntdvl1QQAfbcibxeRSA/640?wx_fmt=png\" /></p>\n</section>\n</section>\n</section>\n</section>\n<section class=\"_editor\">\n<section style=\"margin-top: 30px; margin-bottom: 20px; display: flex; justify-content: center;\">\n<p style=\"width: 150px;\"><img style=\"width: 100%;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxUDekcPuam2Gx5hia3xUWCEw2zBxEnr4ErnXgyEdr9Nb2bToNo6BVdbA/640?wx_fmt=png\" data-width=\"100%\" /></p>\n</section>\n<section style=\"text-align: center;\">\n<p style=\"font-size: 15px; color: #ffffff; line-height: 30px; letter-spacing: 1.5px;\">排版：96编辑器</p>\n<p style=\"font-size: 15px; color: #ffffff; line-height: 30px; letter-spacing: 1.5px;\">图/文：来自网络</p>\n<p style=\"font-size: 15px; color: #ffffff; line-height: 30px; letter-spacing: 1.5px;\">发布请替换内容</p>\n</section>\n</section>\n<section><img style=\"display: block;\" src=\"https://mmbiz.qpic.cn/mmbiz_png/Ljib4So7yuWheeawFvLtdTa9mgehdOnqxvUvFdxt5uCGqUxD8Iiaxk0ib5AJIsAOolUOTwWs7Iyjht7a0BSXaCYaA/640?wx_fmt=png\" /></section>\n</section>\n</section>\n<section class=\"_editor\">\n<p>​</p>\n</section>','','{\"audio\": \"\", \"files\": [], \"other\": null, \"video\": \"\", \"photos\": [], \"extends\": {}, \"template\": \"\"}');
/*!40000 ALTER TABLE `cmf_portal_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_tag`
--

DROP TABLE IF EXISTS `cmf_portal_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_portal_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否推荐,1:推荐',
  `post_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '标签文章数',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_tag`
--

LOCK TABLES `cmf_portal_tag` WRITE;
/*!40000 ALTER TABLE `cmf_portal_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_tag_post`
--

DROP TABLE IF EXISTS `cmf_portal_tag_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_portal_tag_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) NOT NULL COMMENT '标签id',
  `post_id` bigint(20) NOT NULL COMMENT '文章id',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_tag_post`
--

LOCK TABLES `cmf_portal_tag_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_tag_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_tag_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_printer`
--

DROP TABLE IF EXISTS `cmf_printer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_printer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备名称',
  `type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '打印机类型（cloud：云打印机）',
  `brand` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备品牌（feie：品牌）',
  `sn` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备SN号',
  `key` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备Key',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_printer`
--

LOCK TABLES `cmf_printer` WRITE;
/*!40000 ALTER TABLE `cmf_printer` DISABLE KEYS */;
INSERT INTO `cmf_printer` VALUES (1,487934091,1,'飞鹅云打印','cloud','feie','960511811','3aps6y8r',1610352820,1610352820,0);
/*!40000 ALTER TABLE `cmf_printer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_recharge_log`
--

DROP TABLE IF EXISTS `cmf_recharge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_recharge_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '所属用户id',
  `type` tinyint(3) NOT NULL COMMENT '(类型：0：增加，1：扣除)',
  `fee` varchar(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '(消费/充值)金额',
  `balance` varchar(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '剩余余额',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_at` bigint(20) DEFAULT NULL,
  `target_id` bigint(20) NOT NULL COMMENT '所属目标订单id',
  `target_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '(目标类型：0：订单)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_recharge_log`
--

LOCK TABLES `cmf_recharge_log` WRITE;
/*!40000 ALTER TABLE `cmf_recharge_log` DISABLE KEYS */;
INSERT INTO `cmf_recharge_log` VALUES (1,1,0,'520','520','余额储值（含赠送120元）',1610723356,0,0),(2,1,1,'77','443','余额支付',1610724672,0,0),(3,2,0,'520','520','余额储值（含赠送120元）',1610986468,0,0),(4,2,1,'77','443','余额支付',1610986515,0,0),(5,2,1,'116.9','326.1','余额支付',1610986536,0,0),(6,1,0,'55','498','余额储值（含赠送5元）',1611285034,0,0),(7,1,0,'55','553','余额储值（含赠送5元）',1611285255,0,0),(8,1,0,'55','608','余额储值（含赠送5元）',1611285531,0,0),(9,3,0,'120','120','余额储值（含赠送20元）',1611289357,0,0),(10,3,0,'55','175','余额储值（含赠送5元）',1611290343,0,0),(11,3,0,'120','295','余额储值（含赠送20元）',1611290399,0,0),(12,3,0,'120','415','余额储值（含赠送20元）',1611290610,0,0),(13,3,0,'23','438','余额储值（含赠送0元）',1611290766,0,0),(14,3,0,'45','483','余额储值（含赠送0元）',1611290855,0,0),(15,3,0,'70','553','余额储值（含赠送5元）',1611291107,0,0),(16,3,0,'55','608','余额储值（含赠送5元）',1611291305,0,0),(17,3,0,'45','653','余额储值（含赠送0元）',1611291449,0,0),(18,3,0,'120','773','余额储值（含赠送20元）',1611291572,0,0),(19,3,0,'47','820','余额储值（含赠送0元）',1611291909,0,0),(20,3,0,'520','1340','余额储值（含赠送120元）',1611291929,0,0),(21,3,0,'1240','2580','余额储值（含赠送240元）',1611293434,0,0),(22,3,0,'197','2777','余额储值（含赠送20元）',1611293513,0,0),(23,3,0,'143','2920','余额储值（含赠送20元）',1611293697,0,0),(24,3,0,'55','2975','余额储值（含赠送5元）',1611296688,0,0),(25,3,0,'55','3030','余额储值（含赠送5元）',1611296847,0,0),(26,3,0,'321','3351','余额储值（含赠送0元）',1611296988,0,0),(27,3,0,'640','3991','余额储值（含赠送140元）',1611297014,0,0),(28,5,0,'120','120','余额储值（含赠送20元）',1611299036,0,0),(29,5,0,'55','175','余额储值（含赠送5元）',1611300493,0,0),(30,5,0,'55','230','余额储值（含赠送5元）',1611301178,0,0),(31,5,0,'60','290','余额储值（含赠送5元）',1611301326,0,0),(32,5,0,'55','345','余额储值（含赠送5元）',1611301389,0,0),(33,1,0,'520','1128','余额储值（含赠送120元）',1611301416,0,0),(34,5,0,'55','400','余额储值（含赠送5元）',1611302798,0,0),(35,5,0,'120','520','余额储值（含赠送20元）',1611302957,0,0),(36,5,0,'5','525','余额储值（含赠送0元）',1611303104,0,0),(37,5,0,'5','530','余额储值（含赠送0元）',1611303191,0,0),(38,5,0,'12','542','余额储值（含赠送0元）',1611303382,0,0),(39,5,0,'5','547','余额储值（含赠送0元）',1611303497,0,0),(40,5,0,'2','549','余额储值（含赠送0元）',1611303622,0,0),(41,5,0,'640','1189','余额储值（含赠送140元）',1611303639,0,0),(42,5,0,'1240','2429','余额储值（含赠送240元）',1611304795,0,0),(43,9,0,'520','520','余额储值（含赠送120元）',1611737423,0,0),(44,9,1,'258.36','261.64','余额支付',1613021642,0,0),(45,10,0,'520','520','余额储值（含赠送120元）',1613390433,0,0),(46,10,0,'55','575','余额储值（含赠送5元）',1613393963,0,0),(47,10,0,'55','630','余额储值（含赠送5元）',1613394110,0,0),(48,10,0,'300','930','余额储值（含赠送0元）',1613394945,0,0),(49,10,0,'55','985','余额储值（含赠送5元）',1613444387,0,0),(50,10,0,'120','1105','余额储值（含赠送20元）',1613444688,0,0),(51,10,0,'55','1160','余额储值（含赠送5元）',1613444862,0,0),(52,10,0,'380','1540','余额储值（含赠送80元）',1613445543,0,0),(53,10,0,'55','1595','余额储值（含赠送5元）',1613445579,0,0),(54,10,1,'266.99','1328.01','余额支付',1613445855,0,0),(55,10,1,'266.99','1061.02','余额支付',1613445866,0,0),(56,10,1,'268.99','792.03','余额支付',1613467190,0,0),(57,10,1,'88','704.03','余额支付',1613467345,0,0),(58,10,1,'137','300.04','余额支付',1613467708,0,0),(59,11,0,'55','55','余额储值（含赠送5元）',1613641205,0,0),(60,3,0,'520','520','余额储值（含赠送120元）',1614868996,0,0);
/*!40000 ALTER TABLE `cmf_recharge_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_recharge_order`
--

DROP TABLE IF EXISTS `cmf_recharge_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_recharge_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `trade_no` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝订单号',
  `user_id` bigint(20) NOT NULL COMMENT '用户所属id',
  `pay_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方支付类型',
  `fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '合计金额',
  `create_at` bigint(20) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  `order_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WAIT_BUYER_PAY' COMMENT '订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `actual_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '实际金额',
  `send_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '赠送金额',
  `avatar` longtext COLLATE utf8mb4_general_ci,
  `user_login` longtext COLLATE utf8mb4_general_ci,
  `user_nickname` longtext COLLATE utf8mb4_general_ci,
  `user_real_name` longtext COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_recharge_order`
--

LOCK TABLES `cmf_recharge_order` WRITE;
/*!40000 ALTER TABLE `cmf_recharge_order` DISABLE KEYS */;
INSERT INTO `cmf_recharge_order` VALUES (1,'recharge202101041308529071','2021010422001421661406435133',0,'alipay',0.01,1609745086,0,'TRADE_FINISHED',487934091,0.01,0.00,NULL,NULL,NULL,NULL),(2,'recharge202101151183221030','2021011522001496711413175583',1,'alipay',400.00,1610723347,0,'TRADE_FINISHED',487934091,520.00,120.00,NULL,NULL,NULL,NULL),(3,'recharge202101191401720272','2021011922001493311422168647',2,'alipay',400.00,1610986461,0,'TRADE_FINISHED',487934091,520.00,120.00,NULL,NULL,NULL,NULL),(4,'recharge202101221342919137','2021012222001496711419035228',1,'alipay',50.00,1611285028,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(5,'recharge2021012222167076','2021012222001496711419042358',1,'alipay',50.00,1611285538,0,'TRADE_FINISHED',487934091,0.00,0.00,NULL,NULL,NULL,NULL),(6,'recharge20210122154785877','2021012222001421661422676774',3,'alipay',100.00,1611289254,0,'TRADE_FINISHED',487934091,120.00,20.00,NULL,NULL,NULL,NULL),(7,'recharge202101221262694305','2021012222001421661422140539',3,'alipay',50.00,1611290337,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(8,'recharge202101221197195190','2021012222001421661422133442',3,'alipay',100.00,1611290393,0,'TRADE_FINISHED',487934091,120.00,20.00,NULL,NULL,NULL,NULL),(9,'recharge202101221049037313','2021012222001421661422779111',3,'alipay',100.00,1611290559,0,'TRADE_FINISHED',487934091,120.00,20.00,NULL,NULL,NULL,NULL),(10,'recharge20210122123402531','2021012222001421661422649982',3,'alipay',23.00,1611290760,0,'TRADE_FINISHED',487934091,23.00,0.00,NULL,NULL,NULL,NULL),(11,'recharge2021012285903387','2021012222001421661422729176',3,'alipay',45.00,1611290847,0,'TRADE_FINISHED',487934091,45.00,0.00,NULL,NULL,NULL,NULL),(12,'recharge202101222098131550','2021012222001421661422227853',3,'alipay',65.00,1611291101,0,'TRADE_FINISHED',487934091,70.00,5.00,NULL,NULL,NULL,NULL),(13,'recharge202101221684977402','2021012222001421661422204086',3,'alipay',50.00,1611291300,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(14,'recharge202101222116359431','2021012222001421661422140545',3,'alipay',45.00,1611291444,0,'TRADE_FINISHED',487934091,45.00,0.00,NULL,NULL,NULL,NULL),(15,'recharge202101221802729686','2021012222001421661422167158',3,'alipay',100.00,1611291566,0,'TRADE_FINISHED',487934091,120.00,20.00,NULL,NULL,NULL,NULL),(16,'recharge20210122650609504','2021012222001421661422779114',3,'alipay',47.00,1611291903,0,'TRADE_FINISHED',487934091,47.00,0.00,NULL,NULL,NULL,NULL),(17,'recharge202101222043536865','2021012222001421661422658542',3,'alipay',400.00,1611291923,0,'TRADE_FINISHED',487934091,520.00,120.00,NULL,NULL,NULL,NULL),(18,'recharge202101221307615675','2021012222001421661422102929',3,'alipay',1000.00,1611293428,0,'TRADE_FINISHED',487934091,1240.00,240.00,NULL,NULL,NULL,NULL),(19,'recharge202101221206109899','2021012222001421661422139465',3,'alipay',177.00,1611293507,0,'TRADE_FINISHED',487934091,197.00,20.00,NULL,NULL,NULL,NULL),(20,'recharge20210122891830557','2021012222001421661422227859',3,'alipay',123.00,1611293692,0,'TRADE_FINISHED',487934091,143.00,20.00,NULL,NULL,NULL,NULL),(21,'recharge20210122732395344','2021012222001421661422168863',3,'alipay',50.00,1611296682,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(22,'recharge20210122287250355','2021012222001421661422758498',3,'alipay',50.00,1611296840,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(23,'recharge20210122241674889','2021012222001421661422185839',3,'alipay',321.00,1611296981,0,'TRADE_FINISHED',487934091,321.00,0.00,NULL,NULL,NULL,NULL),(24,'recharge202101221263231742','2021012222001421661422132098',3,'alipay',500.00,1611297005,0,'TRADE_FINISHED',487934091,640.00,140.00,NULL,NULL,NULL,NULL),(25,'recharge202101222090330237','2021012222001421661422102946',5,'alipay',100.00,1611299031,0,'TRADE_FINISHED',487934091,120.00,20.00,NULL,NULL,NULL,NULL),(26,'recharge20210122869226172','2021012222001421661421934094',5,'alipay',50.00,1611300481,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(27,'recharge202101221223859494','2021012222001421661421911377',5,'alipay',50.00,1611301170,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(28,'recharge202101221490265919','2021012222001421661421923693',5,'alipay',55.00,1611301310,0,'TRADE_FINISHED',487934091,60.00,5.00,NULL,NULL,NULL,NULL),(29,'recharge20210122128455606','2021012222001421661422655602',5,'alipay',55.00,1611301376,0,'WAIT_BUYER_PAY',487934091,0.00,0.00,NULL,NULL,NULL,NULL),(30,'recharge20210122686253915','2021012222001421661422139486',5,'alipay',50.00,1611301384,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(31,'recharge202101221354056010','2021012222001496711419002281',1,'alipay',400.00,1611301410,0,'TRADE_FINISHED',487934091,520.00,120.00,NULL,NULL,NULL,NULL),(32,'recharge202101221831534744','2021012222001421661422733201',5,'alipay',50.00,1611302791,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(33,'recharge20210122239558230','2021012222001421661422227885',5,'alipay',100.00,1611302940,0,'TRADE_FINISHED',487934091,120.00,20.00,NULL,NULL,NULL,NULL),(34,'recharge202101221975516857','2021012222001421661422658565',5,'alipay',5.00,1611303098,0,'TRADE_FINISHED',487934091,5.00,0.00,NULL,NULL,NULL,NULL),(35,'recharge20210122283469678','2021012222001421661422154730',5,'alipay',5.00,1611303186,0,'TRADE_FINISHED',487934091,5.00,0.00,NULL,NULL,NULL,NULL),(36,'recharge202101221769001073','2021012222001421661422132115',5,'alipay',12.00,1611303376,0,'TRADE_FINISHED',487934091,12.00,0.00,NULL,NULL,NULL,NULL),(37,'recharge202101221526184914','2021012222001421661423036198',5,'alipay',5.00,1611303492,0,'TRADE_FINISHED',487934091,5.00,0.00,NULL,NULL,NULL,NULL),(38,'recharge20210122843993371','2021012222001421661422661608',5,'alipay',2.00,1611303616,0,'TRADE_FINISHED',487934091,2.00,0.00,NULL,NULL,NULL,NULL),(39,'recharge20210122910721314','2021012222001421661423023670',5,'alipay',500.00,1611303634,0,'TRADE_FINISHED',487934091,640.00,140.00,NULL,NULL,NULL,NULL),(40,'recharge20210122925582821','2021012222001421661422171499',5,'alipay',1000.00,1611304784,0,'TRADE_FINISHED',487934091,1240.00,240.00,NULL,NULL,NULL,NULL),(41,'recharge202101271134485672','2021012722001496711423920967',9,'alipay',400.00,1611737413,0,'TRADE_FINISHED',487934091,520.00,120.00,NULL,NULL,NULL,NULL),(42,'recharge202102151312185167','2021021522001496711436738652',9,'alipay',50.00,1613379720,0,'WAIT_BUYER_PAY',487934091,0.00,0.00,NULL,NULL,NULL,NULL),(43,'recharge202102151913328951','2021021522001496711436730532',9,'alipay',100.00,1613379727,0,'WAIT_BUYER_PAY',487934091,0.00,0.00,NULL,NULL,NULL,NULL),(44,'recharge20210215840305296','2021021522001496711436742753',10,'alipay',400.00,1613390427,0,'TRADE_FINISHED',487934091,520.00,120.00,NULL,NULL,NULL,NULL),(45,'recharge20210215776835250','2021021522001496711436949636',10,'alipay',50.00,1613393956,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(46,'recharge20210215585520307','2021021522001496711436731610',10,'alipay',50.00,1613394104,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(47,'recharge20210215309040103','2021021522001496711436911485',10,'alipay',300.00,1613394939,0,'TRADE_FINISHED',487934091,300.00,0.00,NULL,NULL,NULL,NULL),(48,'recharge202102161157998776','2021021622001496711436751302',10,'alipay',50.00,1613444379,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(49,'recharge2021021687599144','2021021622001496711436941227',10,'alipay',100.00,1613444682,0,'TRADE_FINISHED',487934091,120.00,20.00,NULL,NULL,NULL,NULL),(50,'recharge2021021627481624','2021021622001496711436935183',10,'alipay',50.00,1613444857,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(51,'recharge20210216388018208','2021021622001496711436926718',10,'alipay',300.00,1613445536,0,'TRADE_FINISHED',487934091,380.00,80.00,NULL,NULL,NULL,NULL),(52,'recharge202102161866338350','2021021622001496711437129662',10,'alipay',50.00,1613445573,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(53,'recharge202102181379988480','2021021822001496711438399215',11,'alipay',50.00,1613641199,0,'TRADE_FINISHED',487934091,55.00,5.00,NULL,NULL,NULL,NULL),(54,'recharge202102191212110459','2021021922001430081409570853',2,'alipay',50.00,1613734140,0,'WAIT_BUYER_PAY',487934091,0.00,0.00,NULL,NULL,NULL,NULL),(55,'recharge202102201690034691','2021022022001451691447176567',2,'alipay',200.00,1613787290,0,'WAIT_BUYER_PAY',487934091,0.00,0.00,NULL,NULL,NULL,NULL),(56,'recharge20210304123407359','2021030422001496711450350281',3,'alipay',400.00,1614868990,0,'TRADE_FINISHED',487934091,520.00,120.00,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `cmf_recharge_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_role`
--

DROP TABLE IF EXISTS `cmf_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0' COMMENT '所属父类id',
  `name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `list_order` double DEFAULT '10000' COMMENT '排序',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `status` tinyint(3) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role`
--

LOCK TABLES `cmf_role` WRITE;
/*!40000 ALTER TABLE `cmf_role` DISABLE KEYS */;
INSERT INTO `cmf_role` VALUES (1,0,'超级管理员','拥有网站最高管理员权限！',10000,1606284916,1606284916,1),(2,0,'普通管理员','权限由最高管理员分配！',10000,1606284916,1606284916,1),(3,0,'收银员','收银员！',1,1614416452,1614416452,1),(4,0,'财务','财务！',2,1614416452,1614416452,1);
/*!40000 ALTER TABLE `cmf_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_role_user`
--

DROP TABLE IF EXISTS `cmf_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_role_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role_user`
--

LOCK TABLES `cmf_role_user` WRITE;
/*!40000 ALTER TABLE `cmf_role_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_score_log`
--

DROP TABLE IF EXISTS `cmf_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_score_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  `score` int(11) NOT NULL COMMENT '增加积分',
  `fee` varchar(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '合计金额',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_at` bigint(20) DEFAULT NULL,
  `type` tinyint(3) NOT NULL COMMENT '(类型：0：增加，1：扣除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_score_log`
--

LOCK TABLES `cmf_score_log` WRITE;
/*!40000 ALTER TABLE `cmf_score_log` DISABLE KEYS */;
INSERT INTO `cmf_score_log` VALUES (1,10,1233,'0.01','消费',1613494288,0),(2,10,792,'0.01','消费',1613494345,0),(3,11,1170,'0.01','消费',1613640689,0),(4,1,792,'0.01','消费',1613744256,0),(5,1,792,'0.01','消费',1613744520,0),(6,1,792,'0.01','消费',1613745402,0),(7,1,792,'0.01','消费',1613745442,0),(8,1,792,'0.01','消费',1613746008,0);
/*!40000 ALTER TABLE `cmf_score_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_store`
--

DROP TABLE IF EXISTS `cmf_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `store_number` int(11) NOT NULL COMMENT '门店唯一编号',
  `store_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店名称',
  `phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `contact_person` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人名称',
  `province` int(11) NOT NULL COMMENT '省份id',
  `province_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '省份名称',
  `city` int(11) NOT NULL COMMENT '市区id',
  `city_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '市区名称',
  `district` int(11) NOT NULL COMMENT '县区id',
  `district_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '县区名称',
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细地址',
  `store_thumbnail` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门头照片',
  `longitude` decimal(10,7) NOT NULL COMMENT '经度',
  `latitude` decimal(10,7) NOT NULL COMMENT '纬度',
  `is_closure` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否歇业',
  `notice` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公告通知',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` int(10) DEFAULT '0' COMMENT '删除时间',
  `distance` double DEFAULT NULL,
  `scene` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支持场景（0 =>全部；1=>堂食；2=>外卖）',
  `use_desk` tinyint(3) NOT NULL DEFAULT '0' COMMENT '启用桌号',
  `use_appointment` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支持堂食预约',
  `order_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请单id',
  `shop_category` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属门店id',
  `store_type` tinyint(3) NOT NULL COMMENT '门店类型（1：直营，2：加盟）',
  `top_category` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属门店顶级id',
  `audit_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'wait' COMMENT '审核状态(passed:通过,rejected:拒绝,wait:审核中)',
  `reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '拒绝愿意',
  `sell_clear` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '自定义沽清时间',
  `shop_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '蚂蚁店铺id',
  `enabled_sell_clear` tinyint(3) NOT NULL DEFAULT '0' COMMENT '启用沽清',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_store`
--

LOCK TABLES `cmf_store` WRITE;
/*!40000 ALTER TABLE `cmf_store` DISABLE KEYS */;
INSERT INTO `cmf_store` VALUES (1,487934091,1216582911,'海底捕捞（宝山百联店）','15161178721','戴',310000,'上海市',310100,'市辖区',310113,'宝山区','逸仙路殷高西路站新业坊小肥羊','default/20201113/585c553908da29c8677bb7d644691354.jpg',121.4850370,31.3199700,0,'全场大甩卖',1614418970,1614418970,0,NULL,0,1,1,'','1704',1,'S08','wait','',NULL,NULL,0),(2,487934091,1970924019,'上海第一家','15770688196','卓先生',310000,'上海市',310100,'市辖区',310101,'黄浦区','金陵东路1号 上海东方商旅精品酒店','default/20201113/585c553908da29c8677bb7d644691354.jpg',121.4928370,31.2316060,1,'123',1606998080,1606998080,0,NULL,1,1,1,'','',0,'','wait',NULL,NULL,NULL,0),(3,487934091,1178549832,'码上云第二家','15770688196','卓先生',360000,'江西省',360800,'吉安市',360881,'井冈山市','兴国路 井冈山市红星商业步行街','default/20201113/585c553908da29c8677bb7d644691354.jpg',114.2863680,26.7502750,0,'857',1605238685,1605238685,0,NULL,0,0,0,'','',0,'','wait',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `cmf_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_store_hours`
--

DROP TABLE IF EXISTS `cmf_store_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_store_hours` (
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `mon` tinyint(3) DEFAULT NULL COMMENT '周一启用状态',
  `tues` tinyint(3) DEFAULT NULL COMMENT '周二启用状态',
  `wed` tinyint(3) DEFAULT NULL COMMENT '周三启用状态',
  `thur` tinyint(3) DEFAULT NULL COMMENT '周四启用状态',
  `fri` tinyint(3) DEFAULT NULL COMMENT '周五启用状态',
  `sat` tinyint(3) DEFAULT NULL COMMENT '周六启用状态',
  `sun` tinyint(3) DEFAULT NULL COMMENT '周日启用状态',
  `start_time` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '开始时间',
  `end_time` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结束时间',
  `all_time` tinyint(3) DEFAULT NULL COMMENT '24小时营业'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_store_hours`
--

LOCK TABLES `cmf_store_hours` WRITE;
/*!40000 ALTER TABLE `cmf_store_hours` DISABLE KEYS */;
INSERT INTO `cmf_store_hours` VALUES (487934091,3,0,0,0,0,0,1,1,'07:00','20:59',0),(487934091,3,0,0,0,0,0,0,0,'00:00','00:00',0),(487934091,2,1,1,1,1,1,0,0,'07:00','22:30',0),(487934091,2,0,0,0,0,0,0,0,'00:00','00:00',0),(487934091,1,1,1,1,1,1,1,1,'00:00','23:59',1),(487934091,1,0,0,0,0,0,0,0,'00:00','00:00',0);
/*!40000 ALTER TABLE `cmf_store_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_third_part`
--

DROP TABLE IF EXISTS `cmf_third_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_third_part` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `open_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_part`
--

LOCK TABLES `cmf_third_part` WRITE;
/*!40000 ALTER TABLE `cmf_third_part` DISABLE KEYS */;
INSERT INTO `cmf_third_part` VALUES (2,487934091,'alipay-mp',0,'2088932262492289'),(5,487934091,'alipay-mp',3,'2088512446596714'),(6,487934091,'alipay-mp',4,'2088922557796730'),(7,487934091,'alipay-mp',0,'2088042489475915'),(8,487934091,'alipay-mp',0,'2088812159380261');
/*!40000 ALTER TABLE `cmf_third_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user`
--

DROP TABLE IF EXISTS `cmf_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) NOT NULL DEFAULT '0',
  `gender` tinyint(2) DEFAULT '0' COMMENT '性别',
  `birthday` int(11) DEFAULT NULL,
  `last_login_at` int(11) DEFAULT NULL,
  `score` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
  `coin` bigint(20) NOT NULL DEFAULT '0' COMMENT '金币',
  `exp` bigint(20) NOT NULL DEFAULT '0' COMMENT '经验',
  `balance` decimal(10,2) NOT NULL COMMENT '余额',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT NULL,
  `user_status` tinyint(3) NOT NULL DEFAULT '1',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_pass` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_realname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` longtext COLLATE utf8mb4_general_ci,
  `signature` longtext COLLATE utf8mb4_general_ci,
  `last_login_ip` longtext COLLATE utf8mb4_general_ci,
  `user_activation_key` longtext COLLATE utf8mb4_general_ci,
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `more` text COLLATE utf8mb4_general_ci,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `vip_level` longtext COLLATE utf8mb4_general_ci,
  `vip_name` longtext COLLATE utf8mb4_general_ci,
  `open_id` longtext COLLATE utf8mb4_general_ci,
  `vip_num` longtext COLLATE utf8mb4_general_ci,
  `start_at` bigint(20) DEFAULT NULL,
  `end_at` bigint(20) DEFAULT NULL,
  `type` longtext COLLATE utf8mb4_general_ci,
  `member_status` bigint(20) DEFAULT NULL,
  `user_real_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
INSERT INTO `cmf_user` VALUES (3,0,0,0,1615465773,0,0,120,520.00,0,0,0,1,'','','',NULL,'','','','','139.227.81.127','','17625458589','',487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,''),(4,0,0,0,1614677974,0,0,0,0.00,0,0,0,1,'','','',NULL,'','','','','42.120.75.50','','13456854748','',487934091,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `cmf_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_voucher`
--

DROP TABLE IF EXISTS `cmf_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_voucher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `voucher_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '优惠券名称，仅供商家可查看',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0.全场优惠券，1.单品优惠券',
  `voucher_type` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '券类型，详见支付宝微信',
  `publish_start_time` datetime NOT NULL COMMENT '发放开始时间',
  `publish_end_time` datetime NOT NULL COMMENT '发放结束时间',
  `voucher_valid_period` json NOT NULL COMMENT '券有效期',
  `voucher_available_time` json NOT NULL COMMENT '券可用时段',
  `voucher_description` json NOT NULL COMMENT '券使用说明',
  `voucher_quantity` int(10) DEFAULT NULL COMMENT '拟发行券的数量。单位为张',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '面额。每张代金券可以抵扣的金额。币种为人民币，单位为元。',
  `total_amount` decimal(12,2) DEFAULT NULL COMMENT '券总金额（仅用于不定额券）',
  `floor_amount` decimal(12,2) DEFAULT NULL COMMENT '最低额度。设置券使用门槛，只有订单金额大于等于最低额度时券才能使用。',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` int(10) DEFAULT '0' COMMENT '''删除时间''',
  `template_id` varchar(28) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板ID',
  `sync_to_alipay` tinyint(2) NOT NULL DEFAULT '0' COMMENT '同步到支付宝卡包',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_voucher`
--

LOCK TABLES `cmf_voucher` WRITE;
/*!40000 ALTER TABLE `cmf_voucher` DISABLE KEYS */;
INSERT INTO `cmf_voucher` VALUES (2,'【测试】全场满10减2券',0,'CASHLESS_FIX_VOUCHER','2020-12-11 12:00:00','2021-01-15 12:00:00','{\"type\": \"RELATIVE\", \"unit\": \"DAY\", \"duration\": 30}','[{\"day_rule\": \"1,2,3,4,5\", \"time_end\": \"22:00:00\", \"time_begin\": \"09:00:00\"}]','[\"1、本券不可兑换现金，不可找零。\", \"\", \"2、每个用户最多可以领取1张。\", \"3、如果订单发生退款，优惠券无法退还。\"]',1000,2.00,0.00,10.00,1607917191,1607917191,0,'20201214000730016164005VY9NF',1,1,487934091),(3,'全品核销10-5',0,'CASHLESS_FIX_VOUCHER','2021-03-02 14:35:33','2021-03-07 14:35:33','{\"type\": \"RELATIVE\", \"unit\": \"DAY\", \"duration\": 30}','[]','[\"1、本券不可兑换现金，不可找零。\", \"2、每个用户最多可以领取1张。\", \"3、如果订单发生退款，优惠券无法退还。\"]',1000,5.00,0.00,10.00,1614666939,1614666939,0,'2021030200073001616400665GDA',1,1,487934091);
/*!40000 ALTER TABLE `cmf_voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_voucher_post`
--

DROP TABLE IF EXISTS `cmf_voucher_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_voucher_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `voucher_id` int(11) NOT NULL COMMENT '所属优惠券模板id',
  `valid_start_at` int(11) NOT NULL COMMENT '发放开始时间',
  `valid_end_at` int(11) NOT NULL COMMENT '有效截止时间',
  `user_id` int(11) DEFAULT NULL COMMENT '所属人信息',
  `alipay_voucher_id` varchar(28) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付宝券id',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `voucher_type` tinyint(3) NOT NULL COMMENT '优惠券类型(0 => 全场: 1=> 单品)',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_voucher_post`
--

LOCK TABLES `cmf_voucher_post` WRITE;
/*!40000 ALTER TABLE `cmf_voucher_post` DISABLE KEYS */;
INSERT INTO `cmf_voucher_post` VALUES (1,2,1609050328,1611642328,1,'2020122700073002719607JSCXKK',1609050328,1609050328,2,0,487934091),(2,3,1614666948,1617258948,2,'2021030200073002719607ZS4P5P',1614666948,1614666948,2,0,487934091);
/*!40000 ALTER TABLE `cmf_voucher_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_voucher_store_post`
--

DROP TABLE IF EXISTS `cmf_voucher_store_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_voucher_store_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `voucher_id` int(11) NOT NULL COMMENT '魔板id',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_voucher_store_post`
--

LOCK TABLES `cmf_voucher_store_post` WRITE;
/*!40000 ALTER TABLE `cmf_voucher_store_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_voucher_store_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tenant_487934091'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `memberStatus` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-03-22 22:49:56' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card SET status = -1 WHERE end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `orderCloseStatus` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-03-22 22:49:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `orderFinishStatus` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderFinishStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-03-22 22:49:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > create_at + 43200 */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `orderStatus` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-02-27 13:28:47' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600;UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > create_at + 43200; END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `voucherPost` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucherPost` ON SCHEDULE EVERY 1 SECOND STARTS '2021-03-22 22:49:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher_post SET status = 2 WHERE valid_end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tenant_487934091'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:03:25
