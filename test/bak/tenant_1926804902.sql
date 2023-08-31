-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: tenant_1926804902
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
-- Current Database: `tenant_1926804902`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenant_1926804902` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tenant_1926804902`;

--
-- Table structure for table `cmf_address`
--

DROP TABLE IF EXISTS `cmf_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '所属用户id',
  `gender` tinyint(3) NOT NULL DEFAULT '0' COMMENT '性别',
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `province_name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省份名称',
  `city_name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市区名称',
  `district_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '县区名称',
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `longitude` decimal(10,7) NOT NULL COMMENT '经度',
  `latitude` decimal(10,7) NOT NULL COMMENT '纬度',
  `room` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '门牌号',
  `default` tinyint(3) NOT NULL COMMENT '默认',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_address`
--

LOCK TABLES `cmf_address` WRITE;
/*!40000 ALTER TABLE `cmf_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_admin_menu`
--

DROP TABLE IF EXISTS `cmf_admin_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_admin_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unique_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '唯一名称',
  `parent_id` int(11) DEFAULT '0' COMMENT '所属父类id',
  `name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由名称',
  `path` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由路径',
  `icon` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '图标名称',
  `hide_in_menu` tinyint(3) DEFAULT '0' COMMENT '菜单中隐藏',
  `list_order` double DEFAULT '10000' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_menu`
--

LOCK TABLES `cmf_admin_menu` WRITE;
/*!40000 ALTER TABLE `cmf_admin_menu` DISABLE KEYS */;
INSERT INTO `cmf_admin_menu` VALUES (1,'app/dashboard',0,'工作台','/app/:mid/dashboard','icondashboard',0,1),(2,'app/published',0,'小程序','/app/:mid/published','iconmp',0,1),(3,'app/published/dashboard',2,'小程序总览','/app/:mid/published/dashboard','',0,1),(4,'app/published/wechat',2,'微信小程序','/app/:mid/published/wechat','',0,2),(5,'app/published/alipay',2,'支付宝小程序','/app/:mid/published/alipay','',0,3),(6,'app/order/default',0,'订单管理','/app/:mid/order/default','icondetail',0,2),(7,'app/order/business',6,'业务订单','/app/:mid/order/business','',0,10000),(8,'app/order/business/list',7,'订单列表','/app/:mid/order/business/list','',1,1),(9,'app/order/business/id',7,'订单详情','/app/:mid/order/business/:id','',1,1),(10,'app/order/member',6,'会员订单','/app/:mid/order/member','',0,10000),(11,'app/order/recharge',6,'储值订单','/app/:mid/order/coupon','',0,10000),(12,'app/dishes',0,'菜单管理','/app/:mid/dishes','iconappstore',0,3),(13,'app/dishes/goods',12,'菜品管理','/app/:mid/dishes/goods','',0,10000),(14,'app/dishes/goods/index',13,'菜品列表','/app/:mid/dishes/goods/index','',1,10000),(15,'app/dishes/goods/add',13,'添加菜品','/app/:mid/dishes/goods/add','',1,10000),(16,'app/dishes/goods/edit',13,'编辑菜品','/app/:mid/dishes/goods/edit','',1,10000),(17,'app/dishes/category',12,'分类管理','/app/:mid/dishes/category','',0,10000),(18,'app/desk/default',0,'桌位管理','/app/:mid/desk/default','iconapartment',0,4),(19,'app/desk/index',18,'桌位管理','/app/:mid/desk/index','',0,10000),(20,'app/desk/category',18,'桌位类型','/app/:mid/desk/category','',0,10000),(21,'app/member/default',0,'会员管理','/app/:mid/member/default','iconcreditcard',0,5),(22,'app/member/index',21,'用户列表','/app/:mid/member/index','',0,10000),(23,'app/marketing',0,'营销管理','/app/:mid/marketing','icongift',0,70),(24,'app/marketing/card',23,'会员卡设置','/app/:mid/marketing/card','',0,10000),(25,'app/marketing/coupon',23,'优惠券管理','/app/:mid/marketing/coupon','',0,10000),(26,'app/marketing/wechat',23,'微信营销','/app/:mid/marketing/wechat','',0,10000),(27,'app/marketing/recharge',23,'储值管理','/app/:mid/marketing/recharge','',0,10000),(28,'app/marketing/score',23,'积分设置','/app/:mid/marketing/score','',0,10000),(29,'app/theme/default',0,'主题管理','/app/:mid/theme/default','iconbg-colors',0,90),(30,'app/theme/index',29,'主题设置','/app/:mid/theme/index','',0,10),(31,'app/theme/assets',29,'素材中心','/app/:mid/theme/assets','',0,10000),(32,'portal/default',0,'门户管理','/app/:mid/portal','iconfolder-add',0,91),(33,'/app/portal/index',32,'文章管理','/app/:mid/portal/index','',0,10000),(34,'/app/portal/category',32,'分类管理','/app/:mid/portal/category','',0,10000),(35,'/app/portal/category/add',34,'添加分类','/app/:mid/portal/category/add','',1,10000),(36,'/app/portal/category/edit',34,'修改分类','/app/:mid/portal/category/edit/:id','',1,10000),(37,'app/store',0,'门店管理','/app/:mid/store','iconshop',0,92),(38,'app/store/index',37,'门店列表','/app/:mid/store/index','',0,10),(39,'app/store/add',38,'添加门店','/app/:mid/store/add','',1,10000),(40,'app/store/edit',38,'修改门店','/app/:mid/store/edit/:id','',1,10000),(41,'app/store/edit_for_here',38,'堂食设置','/app/:mid/store/edit_for_here/:id','',1,10000),(42,'app/store/edit_take_out',38,'外卖设置','/app/:mid/store/edit_take_out/:id','',1,10000),(43,'app/store/printer',37,'打印机绑定','/app/:mid/store/printer','',0,30),(44,'app/user',0,'账号管理','/app/:mid/user','iconuser',0,100),(45,'app/user/settings',44,'个人设置','/app/:mid/user/settings','',1,1),(46,'app/user/index',44,'账号设置','/app/:mid/user/index','',0,1),(47,'app/user/add',46,'添加管理员','/app/:mid/user/add','',1,10000),(48,'app/user/edit',46,'编辑管理员','/app/:mid/user/edit/:id','',1,10000),(49,'app/user/role',44,'角色设置','/app/:mid/user/role','',0,10000),(50,'app/user/authorize/add',49,'角色权限添加','app/:mid/user/authorize/add','',1,10000),(51,'app/user/authorize/edit',49,'角色权限编辑','/app/:mid/user/authorize/edit/:id','',1,10000),(52,'app/settings',0,'系统设置','/app/:mid/settings','iconsetting',0,110),(53,'app/settings/index',52,'通用设置','/app/:mid/settings/index','',0,10000),(54,'app/settings/contact',52,'客服设置','/app/:mid/settings/contact','',0,10000),(55,'app/settings/logistics',52,'物流设置','/app/:mid/settings/logistics','',0,10000),(56,'app/notice',0,'消息通知','/app/:mid/notice','',1,10000),(57,'app/notice/list',56,'消息列表','/app/:mid/notice/list','',0,10000);
/*!40000 ALTER TABLE `cmf_admin_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_admin_notice`
--

DROP TABLE IF EXISTS `cmf_admin_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_admin_notice` (
  `mid` bigint(20) NOT NULL COMMENT '小程序加密编号',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知标题',
  `desc` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '通知描述',
  `target_id` bigint(20) DEFAULT NULL COMMENT '目标id',
  `create_at` bigint(20) DEFAULT '0' COMMENT '创建时间',
  `type` tinyint(3) DEFAULT '0' COMMENT '类型（0 => 堂食外卖订单）',
  `status` tinyint(3) DEFAULT '0' COMMENT '状态（0 => 未读，1 => 已读）',
  `audio` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '通知提示音',
  `is_play` tinyint(3) DEFAULT '0' COMMENT '类型（0 => 未拨放，1 => 已拨放）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_notice`
--

LOCK TABLES `cmf_admin_notice` WRITE;
/*!40000 ALTER TABLE `cmf_admin_notice` DISABLE KEYS */;
INSERT INTO `cmf_admin_notice` VALUES (110840102,1,'堂食订单通知','您有新的堂食订单，请及时处理！',1,1626855618,0,0,'https://cdn.mashangdian.cn/eatin.mp3',1),(110840102,2,'堂食订单通知','您有新的堂食订单，请及时处理！',7,1629683907,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,3,'堂食订单通知','您有新的堂食订单，请及时处理！',8,1629776502,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,4,'堂食订单通知','您有新的堂食订单，请及时处理！',9,1629776727,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,5,'堂食订单通知','您有新的堂食订单，请及时处理！',10,1629776731,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,6,'堂食订单通知','您有新的堂食订单，请及时处理！',11,1629776735,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,7,'堂食订单通知','您有新的堂食订单，请及时处理！',12,1629776753,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,8,'堂食订单通知','您有新的堂食订单，请及时处理！',13,1629776800,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,9,'打包订单通知','您有新的打包订单，请及时处理！',14,1629777017,0,0,'https://cdn.mashangdian.cn/pack.mp3',0),(110840102,10,'堂食订单通知','您有新的堂食订单，请及时处理！',15,1629777793,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,11,'堂食订单通知','您有新的堂食订单，请及时处理！',16,1629778185,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,12,'堂食订单通知','您有新的堂食订单，请及时处理！',17,1629778286,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,13,'堂食订单通知','您有新的堂食订单，请及时处理！',18,1629778329,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,14,'堂食订单通知','您有新的堂食订单，请及时处理！',19,1629778338,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,15,'堂食订单通知','您有新的堂食订单，请及时处理！',20,1629778358,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,16,'堂食订单通知','您有新的堂食订单，请及时处理！',21,1629778375,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,17,'堂食订单通知','您有新的堂食订单，请及时处理！',22,1629778386,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,18,'堂食订单通知','您有新的堂食订单，请及时处理！',23,1629778851,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,19,'堂食订单通知','您有新的堂食订单，请及时处理！',24,1629779202,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,20,'堂食订单通知','您有新的堂食订单，请及时处理！',25,1629779494,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,21,'堂食订单通知','您有新的堂食订单，请及时处理！',26,1629780131,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,22,'堂食订单通知','您有新的堂食订单，请及时处理！',27,1629781565,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,23,'堂食订单通知','您有新的堂食订单，请及时处理！',28,1629781778,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,24,'堂食订单通知','您有新的堂食订单，请及时处理！',29,1629783381,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,25,'堂食订单通知','您有新的堂食订单，请及时处理！',30,1629783653,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,26,'堂食订单通知','您有新的堂食订单，请及时处理！',31,1629802886,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,27,'堂食订单通知','您有新的堂食订单，请及时处理！',32,1629803938,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,28,'堂食订单通知','您有新的堂食订单，请及时处理！',33,1629808654,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,29,'堂食订单通知','您有新的堂食订单，请及时处理！',34,1629808762,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,30,'堂食订单通知','您有新的堂食订单，请及时处理！',35,1629863013,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,31,'堂食订单通知','您有新的堂食订单，请及时处理！',38,1629864588,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,32,'堂食订单通知','您有新的堂食订单，请及时处理！',39,1629864696,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,33,'堂食订单通知','您有新的堂食订单，请及时处理！',40,1629864707,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,34,'堂食订单通知','您有新的堂食订单，请及时处理！',41,1629864719,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,35,'堂食订单通知','您有新的堂食订单，请及时处理！',42,1629864786,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,36,'堂食订单通知','您有新的堂食订单，请及时处理！',44,1629865152,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,37,'堂食订单通知','您有新的堂食订单，请及时处理！',45,1629865831,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,38,'堂食订单通知','您有新的堂食订单，请及时处理！',46,1629865831,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,39,'堂食订单通知','您有新的堂食订单，请及时处理！',47,1629865924,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,40,'堂食订单通知','您有新的堂食订单，请及时处理！',48,1629866141,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,41,'堂食订单通知','您有新的堂食订单，请及时处理！',49,1629867243,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,42,'堂食订单通知','您有新的堂食订单，请及时处理！',50,1629886232,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,43,'堂食订单通知','您有新的堂食订单，请及时处理！',51,1629949057,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,44,'堂食订单通知','您有新的堂食订单，请及时处理！',52,1629949754,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,45,'堂食订单通知','您有新的堂食订单，请及时处理！',53,1629949927,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,46,'堂食订单通知','您有新的堂食订单，请及时处理！',54,1629949936,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,47,'堂食订单通知','您有新的堂食订单，请及时处理！',55,1629950191,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,48,'堂食订单通知','您有新的堂食订单，请及时处理！',56,1629950564,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,49,'堂食订单通知','您有新的堂食订单，请及时处理！',57,1629950596,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,50,'堂食订单通知','您有新的堂食订单，请及时处理！',58,1629950612,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,51,'堂食订单通知','您有新的堂食订单，请及时处理！',59,1629950718,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,52,'打包订单通知','您有新的打包订单，请及时处理！',60,1629950909,0,0,'https://cdn.mashangdian.cn/pack.mp3',0),(110840102,53,'堂食订单通知','您有新的堂食订单，请及时处理！',61,1629951047,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,54,'堂食订单通知','您有新的堂食订单，请及时处理！',62,1629951125,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,55,'堂食订单通知','您有新的堂食订单，请及时处理！',63,1629951206,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,56,'堂食订单通知','您有新的堂食订单，请及时处理！',64,1629951265,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,57,'堂食订单通知','您有新的堂食订单，请及时处理！',65,1629951319,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,58,'堂食订单通知','您有新的堂食订单，请及时处理！',66,1629951377,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,59,'堂食订单通知','您有新的堂食订单，请及时处理！',67,1629952060,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,60,'堂食订单通知','您有新的堂食订单，请及时处理！',68,1629952475,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,61,'堂食订单通知','您有新的堂食订单，请及时处理！',69,1629952545,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,62,'堂食订单通知','您有新的堂食订单，请及时处理！',70,1629953105,0,0,'https://cdn.mashangdian.cn/eatin.mp3',1),(110840102,63,'堂食订单通知','您有新的堂食订单，请及时处理！',71,1630036544,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,64,'堂食订单通知','您有新的堂食订单，请及时处理！',72,1630036564,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,65,'堂食订单通知','您有新的堂食订单，请及时处理！',73,1630036571,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,66,'堂食订单通知','您有新的堂食订单，请及时处理！',74,1630036672,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,67,'堂食订单通知','您有新的堂食订单，请及时处理！',75,1630037266,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,68,'堂食订单通知','您有新的堂食订单，请及时处理！',76,1630037279,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,69,'堂食订单通知','您有新的堂食订单，请及时处理！',77,1630037287,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,70,'堂食订单通知','您有新的堂食订单，请及时处理！',78,1630037346,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,71,'堂食订单通知','您有新的堂食订单，请及时处理！',79,1630037391,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,72,'堂食订单通知','您有新的堂食订单，请及时处理！',80,1630038040,0,0,'https://cdn.mashangdian.cn/eatin.mp3',1),(110840102,73,'堂食订单通知','您有新的堂食订单，请及时处理！',81,1630066433,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,74,'堂食订单通知','您有新的堂食订单，请及时处理！',82,1630067647,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,75,'堂食订单通知','您有新的堂食订单，请及时处理！',83,1630068443,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,76,'堂食订单通知','您有新的堂食订单，请及时处理！',85,1630116959,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,77,'堂食订单通知','您有新的堂食订单，请及时处理！',86,1630123876,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,78,'堂食订单通知','您有新的堂食订单，请及时处理！',87,1630123897,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,79,'堂食订单通知','您有新的堂食订单，请及时处理！',88,1630124032,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,80,'堂食订单通知','您有新的堂食订单，请及时处理！',90,1630124221,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,81,'堂食订单通知','您有新的堂食订单，请及时处理！',91,1630296550,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,82,'堂食订单通知','您有新的堂食订单，请及时处理！',92,1630296560,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,83,'堂食订单通知','您有新的堂食订单，请及时处理！',94,1630296569,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,84,'堂食订单通知','您有新的堂食订单，请及时处理！',93,1630296571,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,85,'堂食订单通知','您有新的堂食订单，请及时处理！',95,1630296972,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,86,'堂食订单通知','您有新的堂食订单，请及时处理！',96,1630297822,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0),(110840102,87,'堂食订单通知','您有新的堂食订单，请及时处理！',97,1630297939,0,1,'https://cdn.mashangdian.cn/eatin.mp3',1);
/*!40000 ALTER TABLE `cmf_admin_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_admin_user`
--

DROP TABLE IF EXISTS `cmf_admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_admin_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gender` tinyint(2) DEFAULT '0' COMMENT '性别',
  `last_login_at` int(11) DEFAULT NULL,
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT NULL,
  `user_status` tinyint(3) NOT NULL DEFAULT '1',
  `user_login` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_pass` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_nickname` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_real_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_login_ip` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `more` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_user`
--

LOCK TABLES `cmf_admin_user` WRITE;
/*!40000 ALTER TABLE `cmf_admin_user` DISABLE KEYS */;
INSERT INTO `cmf_admin_user` VALUES (1,0,0,1626332586,0,0,1,'13423336695','0d71f439d6b601c6966d9dba5d007078','13423336695','','','','','13423336695','');
/*!40000 ALTER TABLE `cmf_admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_applyment`
--

DROP TABLE IF EXISTS `cmf_applyment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_applyment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_code` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务商自定义的唯一编号',
  `applyment_id` bigint(20) NOT NULL COMMENT '微信支付分配的申请单号',
  `media_list` json DEFAULT NULL COMMENT '图片资源存储json',
  `form` json NOT NULL COMMENT '用户提交得资料',
  `origin_form` json NOT NULL COMMENT '用户提交得资料',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `sub_mchid` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '特约商户号，当申请单状态为APPLYMENT_STATE_FINISHED时才返回',
  `sign_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '微信签约二维码',
  `applyment_state` varchar(32) COLLATE utf8mb4_general_ci DEFAULT 'APPLYMENT_STATE_AUDITING' COMMENT '申请单状态',
  `applyment_state_msg` text COLLATE utf8mb4_general_ci COMMENT '申请单状态描述',
  `audit_detail` json DEFAULT NULL COMMENT '驳回原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_applyment`
--

LOCK TABLES `cmf_applyment` WRITE;
/*!40000 ALTER TABLE `cmf_applyment` DISABLE KEYS */;
INSERT INTO `cmf_applyment` VALUES (1,'1626748607',2000002201863894,'{\"indoor\": {\"name\": \"logo.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn0_E6eu_dhhiHGtXJTSLJMXQ2um_MBrrSXHOVtb_PUkh_oAfaX3LP8JltLWwuIQs-Xhsxy5yZVJ5oSbd2OZIM_mA\", \"file_name\": \"a52c45533b178344d6d1e3e38316a4f3.jpg\", \"file_path\": \"tenant/110840102/20210720/a52c45533b178344d6d1e3e38316a4f3.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/a52c45533b178344d6d1e3e38316a4f3.jpg\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"身份证前.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn063zMTa0L69cvTP1TO6ZMTDmcThTHr8qzIiQRSoeG30yytZP4tNZroQ90tr1qR0r8CAivG0TkiCkbipSJqQNAGg\", \"file_name\": \"30c6b64e1b7172e52ff8478a70474965.jpg\", \"file_path\": \"tenant/110840102/20210720/30c6b64e1b7172e52ff8478a70474965.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/30c6b64e1b7172e52ff8478a70474965.jpg\"}, \"license_copy\": {\"name\": \"营业执照.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn07IcY4l-GZFnNHecQMALiopgcD_lnDNAv1klSE1dcJ4SPLSvSmRv4Tl3AUBuaIyEn565RZrsTGMqA0j1QbJUz5A\", \"file_name\": \"03d64fd4c97dc9c4f1057f898ab08829.jpg\", \"file_path\": \"tenant/110840102/20210720/03d64fd4c97dc9c4f1057f898ab08829.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/03d64fd4c97dc9c4f1057f898ab08829.jpg\"}, \"mini_program\": [{\"name\": \"首页.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn06xAx25TNxGOdbw4L531-_EQ6o0-B79dB5qRng5RdBiMf53wg9ZniDJdcqbPwB0xx5NQnU-mWsTBJ8XMfzYd8Hs\", \"file_name\": \"2d09b1dc995ef7120607e10813adc9e5.jpg\", \"file_path\": \"tenant/110840102/20210720/2d09b1dc995ef7120607e10813adc9e5.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/2d09b1dc995ef7120607e10813adc9e5.jpg\"}], \"qualifications\": {\"name\": \"食品经营许可证.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn06bzkTs4M3dN4aFGtDnCzd2OwJa0W1MEVAeXoO_Bh9kB0ysyhNEsEMKSm77yWRC3jyX-7qZ4k88qDSc851rybG0\", \"file_name\": \"fc4efd3f6d70d5b36efafa2c289753cc.jpg\", \"file_path\": \"tenant/110840102/20210720/fc4efd3f6d70d5b36efafa2c289753cc.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/fc4efd3f6d70d5b36efafa2c289753cc.jpg\"}, \"store_entrance\": {\"name\": \"logo.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn036X2ANNBBoUS7M-cst4oWQ1IaLPUADtG14npYkLXJRZz-7E-KDShvgC7e77RPg7dDefD_4PydPLEjcBAzU3uCc\", \"file_name\": \"5a0b2695e4ae03940eb0d874ccecfc0c.jpg\", \"file_path\": \"tenant/110840102/20210720/5a0b2695e4ae03940eb0d874ccecfc0c.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/5a0b2695e4ae03940eb0d874ccecfc0c.jpg\"}, \"id_card_national\": {\"name\": \"身份证后.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn01XDEbzrKUeJqJfvuWEP4p_WbrrBMmQQ_-tJOKVr_HRaV1DTZHG75RLoMvvmEHYiVNLufMWLngKgYGjU0TgXtm8\", \"file_name\": \"376738c6c8a1546d4d54074aceb05b3e.jpg\", \"file_path\": \"tenant/110840102/20210720/376738c6c8a1546d4d54074aceb05b3e.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/376738c6c8a1546d4d54074aceb05b3e.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}','{\"MediaList\": {\"Indoor\": {\"Name\": \"logo.jpg\", \"MediaId\": \"M1-2iZYyjANSST1d6Acn0_E6eu_dhhiHGtXJTSLJMXQ2um_MBrrSXHOVtb_PUkh_oAfaX3LP8JltLWwuIQs-Xhsxy5yZVJ5oSbd2OZIM_mA\", \"FileName\": \"a52c45533b178344d6d1e3e38316a4f3.jpg\", \"FilePath\": \"tenant/110840102/20210720/a52c45533b178344d6d1e3e38316a4f3.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/a52c45533b178344d6d1e3e38316a4f3.jpg\"}, \"IdDocCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}, \"IdCardCopy\": {\"Name\": \"身份证前.jpg\", \"MediaId\": \"M1-2iZYyjANSST1d6Acn063zMTa0L69cvTP1TO6ZMTDmcThTHr8qzIiQRSoeG30yytZP4tNZroQ90tr1qR0r8CAivG0TkiCkbipSJqQNAGg\", \"FileName\": \"30c6b64e1b7172e52ff8478a70474965.jpg\", \"FilePath\": \"tenant/110840102/20210720/30c6b64e1b7172e52ff8478a70474965.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/30c6b64e1b7172e52ff8478a70474965.jpg\"}, \"LicenseCopy\": {\"Name\": \"营业执照.jpg\", \"MediaId\": \"M1-2iZYyjANSST1d6Acn07IcY4l-GZFnNHecQMALiopgcD_lnDNAv1klSE1dcJ4SPLSvSmRv4Tl3AUBuaIyEn565RZrsTGMqA0j1QbJUz5A\", \"FileName\": \"03d64fd4c97dc9c4f1057f898ab08829.jpg\", \"FilePath\": \"tenant/110840102/20210720/03d64fd4c97dc9c4f1057f898ab08829.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/03d64fd4c97dc9c4f1057f898ab08829.jpg\"}, \"MiniProgram\": [{\"Name\": \"首页.jpg\", \"MediaId\": \"M1-2iZYyjANSST1d6Acn06xAx25TNxGOdbw4L531-_EQ6o0-B79dB5qRng5RdBiMf53wg9ZniDJdcqbPwB0xx5NQnU-mWsTBJ8XMfzYd8Hs\", \"FileName\": \"2d09b1dc995ef7120607e10813adc9e5.jpg\", \"FilePath\": \"tenant/110840102/20210720/2d09b1dc995ef7120607e10813adc9e5.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/2d09b1dc995ef7120607e10813adc9e5.jpg\"}], \"StoreEntrance\": {\"Name\": \"logo.jpg\", \"MediaId\": \"M1-2iZYyjANSST1d6Acn036X2ANNBBoUS7M-cst4oWQ1IaLPUADtG14npYkLXJRZz-7E-KDShvgC7e77RPg7dDefD_4PydPLEjcBAzU3uCc\", \"FileName\": \"5a0b2695e4ae03940eb0d874ccecfc0c.jpg\", \"FilePath\": \"tenant/110840102/20210720/5a0b2695e4ae03940eb0d874ccecfc0c.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/5a0b2695e4ae03940eb0d874ccecfc0c.jpg\"}, \"IdCardNational\": {\"Name\": \"身份证后.jpg\", \"MediaId\": \"M1-2iZYyjANSST1d6Acn01XDEbzrKUeJqJfvuWEP4p_WbrrBMmQQ_-tJOKVr_HRaV1DTZHG75RLoMvvmEHYiVNLufMWLngKgYGjU0TgXtm8\", \"FileName\": \"376738c6c8a1546d4d54074aceb05b3e.jpg\", \"FilePath\": \"tenant/110840102/20210720/376738c6c8a1546d4d54074aceb05b3e.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/376738c6c8a1546d4d54074aceb05b3e.jpg\"}, \"Qualifications\": {\"Name\": \"食品经营许可证.jpg\", \"MediaId\": \"M1-2iZYyjANSST1d6Acn06bzkTs4M3dN4aFGtDnCzd2OwJa0W1MEVAeXoO_Bh9kB0ysyhNEsEMKSm77yWRC3jyX-7qZ4k88qDSc851rybG0\", \"FileName\": \"fc4efd3f6d70d5b36efafa2c289753cc.jpg\", \"FilePath\": \"tenant/110840102/20210720/fc4efd3f6d70d5b36efafa2c289753cc.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/fc4efd3f6d70d5b36efafa2c289753cc.jpg\"}, \"BusinessAddition\": [], \"OrganizationCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}}, \"contact_info\": {\"contact_name\": \"qhotTj6EvoZHUjnjog+JhN+wvB56miNfX4DG6UbeTlQP7NWlbphW1K7q21Z0GgBN+fTKrRBl1WCNshUlkYxJzgr/rGKw+f0xofRPVAjO18EI3mnD4+K4LOX5R0p9DFL77nRKsLC3mvyvr0uweRDwkFqrtBLfPDON9q48gqTJduLsI1yW8r+CF54RXhXrmrhtB//ctzlQdp640GIiLJK//eHi7R6HpyNhFJ5FtfG7we2OtFow1qjHiAOgRa9ulyVGGl2GYnt82z3cVzLjuBvMgAqyZgxkf/E0Fy+4zSnjHaPPsCvxSgAHWZAmF7P+eJRUBwI01v+mSI6St8vR5o7iqQ==\", \"mobile_phone\": \"hxia+PIYRUxGydzDtosfGkOOJDrDVA8eYNl/t5tApmToaEZu6xHH0mGpIY/eT4RtIjh8QByw2YuJLXrkVBIDI5Am3tHNR3ACx8qD5up2VvT/0hsHTqWHa5yE0ZhlCuaauHzZDjs0VCEkugfTlvkb8ubg5BCTTevLFYhSZ1LhvXKccsjJM5AUJeVa029n/JUGCcfMTolJaCXfGeQMxskPMJoKTp1u4G2TSuGKBbMryFIqdMUHu1tfTFExQZir1nq7hmnZmgYg9cXtpKmFCz4VHrpexG18nAxN6WQ9bo9KxAwMza3averbpwRqm2ixa/XibqrexUOEklKzklAnd5zqlw==\", \"contact_email\": \"R2x2fS1m5tpoYRbjXEhNZxWiLCZXutdJ74IVBr/iD2RwWqgYl99cTuGGk1Ab1vtqpgR9xM0+SMttmCysnFgsKcKuTXvBmBUdATE2NhXgy6DTtU3e9TG98xJYrXkG6gGGgMFCuz+j+pr4uHL6dhU8DkJ0RSbYkGUZIsGsVYWlIgqRMdhguzx9/hk2vvv+5GkCPVZABJfJYqBv3zqcpbd37kS2oXQkhSP7AWfhUPAGdCYnB1r3jWsB7981Dv9mTZnyNqx2p5ALMhgz3NiJqEWwY+9dqIcPzI4MXsirZg5PMozmvg+HZ2Fa1uPoZXhj8gqK7S6aZ4TFN6ybKagskG7H2A==\", \"contact_id_number\": \"apb7YvgJIkOgVSHx+HGdbGW1nMlaz8HRr6+9neKbzVUMGLFhKtGLxrHn217uwpvRM/l5MMg4f28lNxsdPF2vpBxmNkZewgy5JLL4cYQ99eTRaLVzUlxgR2xsfuWXfTOndQGIwWUDMr7hBpN6Q1M+pe5OyGsdOP6JKQaGothhdTagDfVVAj3Axj4QhtS+DLNLgA3VjVRdBsp/9OOHRiK7DC3a1e808QKJdS02xrj5/jvTy1CjSgUtVPXdCBAzUjwJIAtkSYISTxhj+lClG51truClbzdp9oewH0OI4T3vhTaQxU1ztX5/krhZQEluRzWBvao/0ZcIBYaOTk99BxIjVQ==\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"M1-2iZYyjANSST1d6Acn063zMTa0L69cvTP1TO6ZMTDmcThTHr8qzIiQRSoeG30yytZP4tNZroQ90tr1qR0r8CAivG0TkiCkbipSJqQNAGg\", \"id_card_name\": \"MjqFapeNDDQbHAR7hs14DgMTkcsruTjjT960rjArq8K5n+5WtJU6lq5L+5VL71etfpTdhbX0Y1ihPRtWUaR0kjhemzcO2iF2Ltz9rv/LzuFgUKkj2+h69fvNsawDsSBrerx00W2C3I34die+E9Gm8FjecZYE7aTY9XQBK4zeQpQg72JtX7JpwWshCnE2ItHOjyHwkJm3RC+/4Kwdbp39mFQpJ8qyU6RAqNlfdl1INN+sWGbCfCClMfvm/28pafgB3L+WNqSisBavauXTvJeX0qwBHROI7r3znwD/7gJW94x6RrM7Kg9R6BG2ZsDDthOAMMPDjD2Xja6zFDrH9QuUGw==\", \"id_card_number\": \"l/J7hw9UVQ40aV3QXLg0pr75xJGYJvDgEVUYxYRBG8/VoNQyBM70RrHIoqcpLUevEkcjfqQfYTVYzlqjvqu/Ilb8Hi1yus0z4g8JPhsCt9V0kuOVxaWwQeCY2C9jqE/UMZhv727+TgbjgedOPNU4AsOY20O5ZzCIaf27fnJJjxPBGTdJi/sxtzJ4EaFmEXWmzELAFq1/3tR/k4RuXBCGPjl+/0g++1WtmyfUzuEIE+WmLB0Ftw0msnOTFmZJCNCA+LON3Gklm3Eh0uG210Sn8Gli/+thwum3ZdNWft9p7mcwRnx2EnmeJbVWHFPcsi+aTrTU0FQzsz9rqoAiXP6SRg==\", \"card_period_end\": \"2036-10-11\", \"id_card_national\": \"M1-2iZYyjANSST1d6Acn01XDEbzrKUeJqJfvuWEP4p_WbrrBMmQQ_-tJOKVr_HRaV1DTZHG75RLoMvvmEHYiVNLufMWLngKgYGjU0TgXtm8\", \"card_period_begin\": \"2016-10-11\"}}, \"business_license_info\": {\"legal_person\": \"钟嘉欣\", \"license_copy\": \"M1-2iZYyjANSST1d6Acn07IcY4l-GZFnNHecQMALiopgcD_lnDNAv1klSE1dcJ4SPLSvSmRv4Tl3AUBuaIyEn565RZrsTGMqA0j1QbJUz5A\", \"merchant_name\": \"东莞市南城来来蒸饭餐饮店\", \"license_number\": \"92441900MA56N8DX17\"}}, \"business_code\": \"APPLYMENT_1626748607\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"M1-2iZYyjANSST1d6Acn0_E6eu_dhhiHGtXJTSLJMXQ2um_MBrrSXHOVtb_PUkh_oAfaX3LP8JltLWwuIQs-Xhsxy5yZVJ5oSbd2OZIM_mA\"], \"biz_store_name\": \"来来蒸饭\", \"BizAddressRegion\": [440000, 441900], \"biz_address_code\": \"441900\", \"biz_store_address\": \"南城街道元美东路5号169室南城街道元美东路5号169室 来来蒸饭\", \"store_entrance_pic\": [\"M1-2iZYyjANSST1d6Acn036X2ANNBBoUS7M-cst4oWQ1IaLPUADtG14npYkLXJRZz-7E-KDShvgC7e77RPg7dDefD_4PydPLEjcBAzU3uCc\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"M1-2iZYyjANSST1d6Acn06xAx25TNxGOdbw4L531-_EQ6o0-B79dB5qRng5RdBiMf53wg9ZniDJdcqbPwB0xx5NQnU-mWsTBJ8XMfzYd8Hs\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"13423336695\", \"merchant_shortname\": \"来来蒸饭\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"M1-2iZYyjANSST1d6Acn06bzkTs4M3dN4aFGtDnCzd2OwJa0W1MEVAeXoO_Bh9kB0ysyhNEsEMKSm77yWRC3jyX-7qZ4k88qDSc851rybG0\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"中信银行\", \"account_name\": \"dGMr3otwejVR0xkE5YUzp7Lzm90tk1iPuYt8f9nWeOnxXuJafs07DZeji2uyvvERzAmaNkDgkjRb7FifURVsgJsmeT3qMoQXI2ug4+LBmxh9Lp+X6UzbbfzOtlsCL9yFM0p6qftOza/PHaps4pGiRRxuGVB4G5utNIP3WPt1VPZgKaegtRDiENiOqgJ1apE3qAU3GKw3Zz+WuzY3VJFXzHXp3IN+e5CTZbKkyoIHo7/CigV7QweOEw54UolI8pilhIWJoQkfZGLIVq57RePyz9cq/YK97QGcgMm9W+5Oyqqc83y6/by8TwJd9reiSHHy7tgu39qSky6yegEXI0pkWw==\", \"account_number\": \"SpvNJMABt/rckQVOONy6yJviuEZJkM6OtfJ2dMthSNyhpKucoggkD5tdb0A/gwWwcscTjFJvWFpG8ZSuxlTNt+FDHeZKyNStBmY7CaL2RTW221VGRpt0i6aid32Fnc8p0TMAyw7WMY9FKy57rS3ps8Ohkf7ZaVCeKWkv9IGn3lIgT+2oiVr5bfkqte+X5t3gcY6QUvogFvI45+pczVxBPDrX84s/MlDAw/8pYWPj7YFy6Yee0uWULnYZnVvUvgcSMMHqJhqWm0SFOPia7+1zcgElh5818DsjTeov0NN4zGNlzFl8szXT7e5KczTwzK9BbBl1TwWBL08z8fyqiG7GaA==\", \"BankAddressRegion\": [440000, 440300, 440309], \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"440309\"}}','{\"media_list\": {\"indoor\": {\"name\": \"logo.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn0_E6eu_dhhiHGtXJTSLJMXQ2um_MBrrSXHOVtb_PUkh_oAfaX3LP8JltLWwuIQs-Xhsxy5yZVJ5oSbd2OZIM_mA\", \"file_name\": \"a52c45533b178344d6d1e3e38316a4f3.jpg\", \"file_path\": \"tenant/110840102/20210720/a52c45533b178344d6d1e3e38316a4f3.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/a52c45533b178344d6d1e3e38316a4f3.jpg\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"身份证前.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn063zMTa0L69cvTP1TO6ZMTDmcThTHr8qzIiQRSoeG30yytZP4tNZroQ90tr1qR0r8CAivG0TkiCkbipSJqQNAGg\", \"file_name\": \"30c6b64e1b7172e52ff8478a70474965.jpg\", \"file_path\": \"tenant/110840102/20210720/30c6b64e1b7172e52ff8478a70474965.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/30c6b64e1b7172e52ff8478a70474965.jpg\"}, \"license_copy\": {\"name\": \"营业执照.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn07IcY4l-GZFnNHecQMALiopgcD_lnDNAv1klSE1dcJ4SPLSvSmRv4Tl3AUBuaIyEn565RZrsTGMqA0j1QbJUz5A\", \"file_name\": \"03d64fd4c97dc9c4f1057f898ab08829.jpg\", \"file_path\": \"tenant/110840102/20210720/03d64fd4c97dc9c4f1057f898ab08829.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/03d64fd4c97dc9c4f1057f898ab08829.jpg\"}, \"mini_program\": [{\"name\": \"首页.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn06xAx25TNxGOdbw4L531-_EQ6o0-B79dB5qRng5RdBiMf53wg9ZniDJdcqbPwB0xx5NQnU-mWsTBJ8XMfzYd8Hs\", \"file_name\": \"2d09b1dc995ef7120607e10813adc9e5.jpg\", \"file_path\": \"tenant/110840102/20210720/2d09b1dc995ef7120607e10813adc9e5.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/2d09b1dc995ef7120607e10813adc9e5.jpg\"}], \"qualifications\": {\"name\": \"食品经营许可证.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn06bzkTs4M3dN4aFGtDnCzd2OwJa0W1MEVAeXoO_Bh9kB0ysyhNEsEMKSm77yWRC3jyX-7qZ4k88qDSc851rybG0\", \"file_name\": \"fc4efd3f6d70d5b36efafa2c289753cc.jpg\", \"file_path\": \"tenant/110840102/20210720/fc4efd3f6d70d5b36efafa2c289753cc.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/fc4efd3f6d70d5b36efafa2c289753cc.jpg\"}, \"store_entrance\": {\"name\": \"logo.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn036X2ANNBBoUS7M-cst4oWQ1IaLPUADtG14npYkLXJRZz-7E-KDShvgC7e77RPg7dDefD_4PydPLEjcBAzU3uCc\", \"file_name\": \"5a0b2695e4ae03940eb0d874ccecfc0c.jpg\", \"file_path\": \"tenant/110840102/20210720/5a0b2695e4ae03940eb0d874ccecfc0c.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/5a0b2695e4ae03940eb0d874ccecfc0c.jpg\"}, \"id_card_national\": {\"name\": \"身份证后.jpg\", \"media_id\": \"M1-2iZYyjANSST1d6Acn01XDEbzrKUeJqJfvuWEP4p_WbrrBMmQQ_-tJOKVr_HRaV1DTZHG75RLoMvvmEHYiVNLufMWLngKgYGjU0TgXtm8\", \"file_name\": \"376738c6c8a1546d4d54074aceb05b3e.jpg\", \"file_path\": \"tenant/110840102/20210720/376738c6c8a1546d4d54074aceb05b3e.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/110840102/20210720/376738c6c8a1546d4d54074aceb05b3e.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}, \"contact_info\": {\"contact_name\": \"钟嘉欣\", \"mobile_phone\": \"13423336695\", \"contact_email\": \"309669386@qq.com\", \"contact_id_number\": \"44150219900316112X\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_info\": {\"id_doc_copy\": \"\", \"id_doc_name\": \"\", \"id_doc_number\": \"\", \"doc_period_end\": \"\", \"doc_period_begin\": \"\"}, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"M1-2iZYyjANSST1d6Acn063zMTa0L69cvTP1TO6ZMTDmcThTHr8qzIiQRSoeG30yytZP4tNZroQ90tr1qR0r8CAivG0TkiCkbipSJqQNAGg\", \"id_card_name\": \"钟嘉欣\", \"id_card_number\": \"44150219900316112X\", \"card_period_end\": \"2036-10-11\", \"id_card_national\": \"M1-2iZYyjANSST1d6Acn01XDEbzrKUeJqJfvuWEP4p_WbrrBMmQQ_-tJOKVr_HRaV1DTZHG75RLoMvvmEHYiVNLufMWLngKgYGjU0TgXtm8\", \"card_period_begin\": \"2016-10-11\"}}, \"organization_info\": {}, \"business_license_info\": {\"legal_person\": \"钟嘉欣\", \"license_copy\": \"M1-2iZYyjANSST1d6Acn07IcY4l-GZFnNHecQMALiopgcD_lnDNAv1klSE1dcJ4SPLSvSmRv4Tl3AUBuaIyEn565RZrsTGMqA0j1QbJUz5A\", \"merchant_name\": \"东莞市南城来来蒸饭餐饮店\", \"license_number\": \"92441900MA56N8DX17\"}}, \"addition_info\": {}, \"business_code\": \"APPLYMENT_1626748607\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"M1-2iZYyjANSST1d6Acn0_E6eu_dhhiHGtXJTSLJMXQ2um_MBrrSXHOVtb_PUkh_oAfaX3LP8JltLWwuIQs-Xhsxy5yZVJ5oSbd2OZIM_mA\"], \"biz_store_name\": \"来来蒸饭\", \"biz_address_code\": \"441900\", \"biz_store_address\": \"南城街道元美东路5号169室南城街道元美东路5号169室 来来蒸饭\", \"biz_address_region\": [440000, 441900], \"store_entrance_pic\": [\"M1-2iZYyjANSST1d6Acn036X2ANNBBoUS7M-cst4oWQ1IaLPUADtG14npYkLXJRZz-7E-KDShvgC7e77RPg7dDefD_4PydPLEjcBAzU3uCc\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"M1-2iZYyjANSST1d6Acn06xAx25TNxGOdbw4L531-_EQ6o0-B79dB5qRng5RdBiMf53wg9ZniDJdcqbPwB0xx5NQnU-mWsTBJ8XMfzYd8Hs\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"13423336695\", \"merchant_shortname\": \"来来蒸饭\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"M1-2iZYyjANSST1d6Acn06bzkTs4M3dN4aFGtDnCzd2OwJa0W1MEVAeXoO_Bh9kB0ysyhNEsEMKSm77yWRC3jyX-7qZ4k88qDSc851rybG0\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"中信银行\", \"account_name\": \"钟嘉欣\", \"account_number\": \"6217730389066844\", \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"440309\", \"bank_address_region\": [440000, 440300, 440309]}}',1626748607,1626858451,'1612052077','https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFR8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyck42RDhHb3JlUjIxNUJHdk54Y3oAAgRl3fdgAwQAjScA','APPLYMENT_STATE_FINISHED','','[]');
/*!40000 ALTER TABLE `cmf_applyment` ENABLE KEYS */;
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
  `create_at` bigint(20) DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) DEFAULT '1' COMMENT '文件状态',
  `file_key` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件唯一码',
  `remark_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件备注名',
  `file_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件索引名',
  `file_path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `suffix` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件后缀',
  `type` tinyint(3) NOT NULL COMMENT '资源类型',
  `more` text COLLATE utf8mb4_general_ci COMMENT '更多配置',
  `mid` bigint(20) NOT NULL COMMENT '小程序加密编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,77550,1626338328,1,'9c6ff1a4-9691-4780-6345-1e9805a578fa','logo.jpeg','c1fc7d8e73687fb68a9b3a2ca2236893.jpeg','default/20210715/c1fc7d8e73687fb68a9b3a2ca2236893.jpeg','jpeg',0,'',0),(2,1,77550,1626400728,1,'98d68b44-5f28-4920-5454-b415100f1ee6','logo.jpeg','5293d43a9755b47886717d7b6e7c79d9.jpeg','tenant/110840102/20210716/5293d43a9755b47886717d7b6e7c79d9.jpeg','jpeg',0,'',110840102),(3,1,39453,1626403009,1,'08a29007-09e5-4be7-704a-fda9b1e4bd27','营业执照.jpg','fc974116d435c73b398a557330a9aa47.jpg','tenant/110840102/20210716/fc974116d435c73b398a557330a9aa47.jpg','jpg',0,'',110840102),(4,1,160253,1626403025,1,'3c12c1ca-53b0-490a-63fb-88ab42bed962','食品经营许可证.jpg','fd4279a2bbeb8255e2a7dbdc9add39d0.jpg','tenant/110840102/20210716/fd4279a2bbeb8255e2a7dbdc9add39d0.jpg','jpg',0,'',110840102),(5,1,77550,1626403361,1,'78cc435c-fa60-4fda-5e14-b112c460b1a7','logo.jpg','2d9d98ebe0063ff5fe7ba05fbc8ee0be.jpg','tenant/110840102/20210716/2d9d98ebe0063ff5fe7ba05fbc8ee0be.jpg','jpg',0,'',110840102),(6,1,58393,1626403376,1,'5180a3cf-2ad0-47e4-7973-ae2554ae8139','logo.jpg','82ec010054cb4c66bbc2f4b975afb254.jpg','tenant/110840102/20210716/82ec010054cb4c66bbc2f4b975afb254.jpg','jpg',0,'',110840102),(7,1,331230,1626404324,0,'16416cab-8a75-4f88-6694-02e789a86223','餐饮盖浇饭菜品上市促销海报.jpg','cdd6bd146e10210b8b3efdff81c96d76.jpg','tenant/110840102/20210716/cdd6bd146e10210b8b3efdff81c96d76.jpg','jpg',0,'',110840102),(8,1,378744,1626404363,0,'b857540e-50da-4289-5f85-dee96ca62b5a','餐饮盖浇饭菜品上市促销海报 (1).jpg','dbafb74c0cb9c1f54c4913d9fae5bd32.jpg','tenant/110840102/20210716/dbafb74c0cb9c1f54c4913d9fae5bd32.jpg','jpg',0,'',110840102),(9,1,3564,1626404401,1,'5b25db21-bd92-4f9c-602f-027cff8436fe','盒子_box (1).png','f74f4c36c4d1e5f8c19db51fce03c39a.png','tenant/110840102/20210716/f74f4c36c4d1e5f8c19db51fce03c39a.png','png',0,'',110840102),(10,1,5297,1626404401,1,'8aae8a6d-65cd-4d78-6755-45b6926f6f9e','烹饪_cooking.png','8b30c374903b78f57c5d02357eada8b0.png','tenant/110840102/20210716/8b30c374903b78f57c5d02357eada8b0.png','png',0,'',110840102),(11,1,326577,1626404521,1,'c9e6f855-b12f-444b-508f-8537ce9eeed3','餐饮盖浇饭菜品上市促销海报 (2).jpg','af477e2d83673c764d4032d8c19a47b4.jpg','tenant/110840102/20210716/af477e2d83673c764d4032d8c19a47b4.jpg','jpg',0,'',110840102),(12,1,120081,1626404633,0,'b6288006-95ec-4298-60f5-07f235a10e79','搜索框年度账单创意公众号首图 (2).jpg','0e8fc71668346a69cc908da3af492771.jpg','tenant/110840102/20210716/0e8fc71668346a69cc908da3af492771.jpg','jpg',0,'',110840102),(13,1,669766,1626404671,1,'f4f8dbfa-27c8-4321-74fc-4ada1676145b','活动海报210-297_ rgb-02.png','194b1fe8899472384573ef9785a77808.png','default/20210716/194b1fe8899472384573ef9785a77808.png','png',0,'',0),(14,1,121283,1626404776,1,'7c5bc27d-ef31-4ee3-4967-7584f129f258','搜索框年度账单创意公众号首图 (3).jpg','9e49e501bd624557b372baacc4e8c40f.jpg','tenant/110840102/20210716/9e49e501bd624557b372baacc4e8c40f.jpg','jpg',0,'',110840102),(15,1,1292139,1629638796,1,'3d712aeb-e863-41e7-50e2-fea0cb21ed19','肉饼.png','757aed83d838a0c73fba447ab1e91f4e.png','tenant/110840102/20210822/757aed83d838a0c73fba447ab1e91f4e.png','png',0,'',110840102),(16,1,18764,1629638862,1,'3f199f72-8b61-40fc-6a4e-c02874204346','咸鸭蛋.jpg','4f887ed2120311b6d6cedb2873cc28ea.jpg','tenant/110840102/20210822/4f887ed2120311b6d6cedb2873cc28ea.jpg','jpg',0,'',110840102),(17,1,37420,1629639260,1,'41c98ca2-b5ea-4efc-50c9-2c5ecf5a8337','腊肠.jpg','0c7bf21c269c2adff4a828f4c022117a.jpg','tenant/110840102/20210822/0c7bf21c269c2adff4a828f4c022117a.jpg','jpg',0,'',110840102),(18,1,14203,1629639508,1,'210c735c-d5f4-4e67-50f8-3fc2c6ac3f7c','鸡腿.jpg','ffc801d400728d7256ba2bef8a24e43d.jpg','tenant/110840102/20210822/ffc801d400728d7256ba2bef8a24e43d.jpg','jpg',0,'',110840102),(19,1,15230,1629639525,1,'7eadb9d7-f147-462e-75a7-8cc199289ae2','鸡翅.jpg','6056073c8973a587e708f08c7f37b919.jpg','tenant/110840102/20210822/6056073c8973a587e708f08c7f37b919.jpg','jpg',0,'',110840102),(20,1,52906,1629640922,1,'769021fe-ffcf-4706-4323-061ffd5f1758','FDC65362-9754-41B8-82B5-972619CD984B.jpeg','700485a8c062226af19627a479695689.jpeg','tenant/110840102/20210822/700485a8c062226af19627a479695689.jpeg','jpeg',0,'',110840102),(21,1,25551,1629640987,1,'03b12b17-0d54-4756-5b55-14e9fc2decd8','F4BC8EA7-CA46-43AD-AB87-60FA5E8D0BB5.jpeg','f7b85c359e89345807b7d7bc606c7eb3.jpeg','tenant/110840102/20210822/f7b85c359e89345807b7d7bc606c7eb3.jpeg','jpeg',0,'',110840102),(22,1,35453,1629641365,1,'1dcae1ed-83cb-48b6-6bcc-418657bc541d','765300DC-D57C-4B86-A6DB-639409517517.jpeg','b8517b16085338f6f7692e8c968bc508.jpeg','tenant/110840102/20210822/b8517b16085338f6f7692e8c968bc508.jpeg','jpeg',0,'',110840102),(23,1,24232,1629641416,1,'6e55c4e4-0877-48ef-4c62-33f9638ab2be','20E89D5C-8485-425D-A587-EA03A9770049.jpeg','9f010b34a182c0eeec15cf5320f76a14.jpeg','tenant/110840102/20210822/9f010b34a182c0eeec15cf5320f76a14.jpeg','jpeg',0,'',110840102),(24,1,16597,1629641476,1,'67bf13f4-4475-4b2d-696b-c52499406f86','0FD5FA74-0C61-4D5C-B3C9-0C3F328E60D2.jpeg','09265a1bbb7b46acb09115d250a1e653.jpeg','tenant/110840102/20210822/09265a1bbb7b46acb09115d250a1e653.jpeg','jpeg',0,'',110840102),(25,1,40138,1629641516,1,'79ea0f71-98c1-4c6a-5320-43b0814954a6','BEC7EDF1-30EB-4B75-B7EF-B358F04F9632.jpeg','78a35a00d69539cbd22e7f05784a2c7f.jpeg','tenant/110840102/20210822/78a35a00d69539cbd22e7f05784a2c7f.jpeg','jpeg',0,'',110840102),(26,1,144405,1629641628,0,'092cae3c-fccc-4024-4750-67ed3b3e9943','BF45F467-982D-4C9A-A8E5-79A2476E9048.jpeg','c269fbe2306bb8ca9c110ff9f949864c.jpeg','tenant/110840102/20210822/c269fbe2306bb8ca9c110ff9f949864c.jpeg','jpeg',0,'',110840102),(27,1,144405,1629641662,0,'b35b2363-c6d4-4e91-7c5d-8c26066b84a7','088EB31F-B503-46B5-8B65-E053DDD90D37.jpeg','d13977f07b27456206a3deda2117fbec.jpeg','tenant/110840102/20210822/d13977f07b27456206a3deda2117fbec.jpeg','jpeg',0,'',110840102),(28,1,144405,1629641749,0,'56b74454-29dc-462d-70e9-0cff1478d5af','EF2F8833-9317-4E93-912F-8E53465675EF.jpeg','d96e7d220445f225756abb756647f400.jpeg','tenant/110840102/20210822/d96e7d220445f225756abb756647f400.jpeg','jpeg',0,'',110840102),(29,1,144405,1629642480,0,'a7b2ded5-6250-4cfd-5c1d-f9e7a7b1c0dd','172DCA87-7A67-4806-83F9-C0468CD28694.jpeg','1bcd7afc8a883d50c7145fa1f27654f5.jpeg','tenant/110840102/20210822/1bcd7afc8a883d50c7145fa1f27654f5.jpeg','jpeg',0,'',110840102),(30,1,249949,1629642588,1,'892d2998-cbdf-4f7e-7562-73cb29094eab','mmexport1629642554160.jpg','67b9436c35025ff4319054682e8c7a04.jpg','tenant/110840102/20210822/67b9436c35025ff4319054682e8c7a04.jpg','jpg',0,'',110840102),(31,1,134652,1629642616,1,'7e916f2a-bb86-4db5-5df9-2be7afb16dfc','mmexport1629640527891.png','d99e8bc3ca67f5511732177669f172ee.png','tenant/110840102/20210822/d99e8bc3ca67f5511732177669f172ee.png','png',0,'',110840102),(32,1,12465,1629643122,1,'59b0707c-f014-4ece-4754-61625e0cc400','C9988873-52F2-41DC-AE62-ACB14C01ACAC.jpeg','35198581a32b124d333210337d61b489.jpeg','tenant/110840102/20210822/35198581a32b124d333210337d61b489.jpeg','jpeg',0,'',110840102),(33,1,144405,1629643184,1,'93b6dfb3-e525-42e2-5572-d3db55da168d','77F0DD58-C95D-4890-8CA7-F8356902EE9A.jpeg','a46e0cd35acf38be33906532b66d3491.jpeg','tenant/110840102/20210822/a46e0cd35acf38be33906532b66d3491.jpeg','jpeg',0,'',110840102),(34,1,144023,1629643210,1,'a20f6901-22c7-4bf6-4cd3-7e88a16156cf','AC2B6E57-A90E-4519-86D3-FA7A26EEF879.jpeg','dfcc0f187a33cd6a6e5c457d1a55e31a.jpeg','tenant/110840102/20210822/dfcc0f187a33cd6a6e5c457d1a55e31a.jpeg','jpeg',0,'',110840102),(35,1,138612,1629643415,1,'49c06897-0061-425d-644e-059d763a15e7','8A1D53A0-C833-4C07-8407-3FE693839347.jpeg','447a97f7f315e03f79152772378ecbf4.jpeg','tenant/110840102/20210822/447a97f7f315e03f79152772378ecbf4.jpeg','jpeg',0,'',110840102),(36,1,124193,1629643474,1,'347994ea-2b03-44a2-49e6-7dc9e660209c','931A39AF-899E-4B7C-8F48-9C8FA8A97BCE.jpeg','77bdcc1d237ebc004accdf91df05827b.jpeg','tenant/110840102/20210822/77bdcc1d237ebc004accdf91df05827b.jpeg','jpeg',0,'',110840102),(37,1,146950,1629643515,1,'4a8fd39d-d849-4de7-4223-bcce8c4d22dd','BBFA299C-6C92-4138-B89D-C2CBE3B42160.jpeg','46b2d457a4ae17eb4015a5ff0ccfa06e.jpeg','tenant/110840102/20210822/46b2d457a4ae17eb4015a5ff0ccfa06e.jpeg','jpeg',0,'',110840102),(38,1,130567,1629643584,1,'b8097066-bc93-46ac-6be7-dfb9240f6e8c','59533660-041F-46CF-8F57-B2FE006EB41D.jpeg','e49be5bad96007b0ac11732fc512d86c.jpeg','tenant/110840102/20210822/e49be5bad96007b0ac11732fc512d86c.jpeg','jpeg',0,'',110840102),(39,1,77468,1629643628,1,'fed41770-3ea4-4f5e-7070-b8ab83ec156e','CB81419A-61D6-474D-BD53-7D2F522FD871.jpeg','eca3623ee1373059e40865f5c94e4451.jpeg','tenant/110840102/20210822/eca3623ee1373059e40865f5c94e4451.jpeg','jpeg',0,'',110840102),(40,1,135419,1629643682,1,'2bd10a39-12d5-438e-5b9b-b8be67dca0c2','48CCE4C1-E44B-4FCA-BEE8-8F7086BF0BBD.jpeg','92e7256860e6d3aa58600dd6c2ace7bf.jpeg','tenant/110840102/20210822/92e7256860e6d3aa58600dd6c2ace7bf.jpeg','jpeg',0,'',110840102),(41,1,53182,1629644337,1,'2a845010-134d-452b-7625-214c6c2f7d29','DC2CFB07-08BA-421A-B568-3641D86B89B0.jpeg','d5fcf67b9a29e25cbec52f5d1f4f89b9.jpeg','tenant/110840102/20210822/d5fcf67b9a29e25cbec52f5d1f4f89b9.jpeg','jpeg',0,'',110840102),(42,1,128530,1629644461,1,'a3a842d5-fe1a-43e6-7a18-d9871c7a4260','D41A62CF-05DF-4BAD-8629-D4DAD4753E2A.jpeg','9bc284bffb142df8cb769b786b0865a8.jpeg','tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','jpeg',0,'',110840102),(43,1,127330,1629644538,1,'4a5ac2cf-8844-4c79-7f91-a5b673571ae7','0E62CC69-1694-41B5-A561-48E4D1658DDA.jpeg','eb7af90a83285b7945f1b2a498454317.jpeg','tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','jpeg',0,'',110840102),(44,1,148045,1629644597,1,'e1177100-5de6-46d5-591c-96a4e2f3442d','309200DD-4ECD-4A32-8E94-2512853E08C4.jpeg','125230ba0226f3069fdd0d455b04a96b.jpeg','tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','jpeg',0,'',110840102),(45,1,120279,1629644640,1,'5e86113d-22a3-430e-4626-279d3fc32069','9CC76EF1-9CE6-4343-BFA9-4F2A5D030D6C.jpeg','a89defea249d5cf32fdaa700e60ff6ba.jpeg','tenant/110840102/20210822/a89defea249d5cf32fdaa700e60ff6ba.jpeg','jpeg',0,'',110840102),(46,1,105285,1629644793,1,'f0a21737-8383-4fdd-4dd3-c4ab5dca437b','74BE2A8A-1630-4846-9002-35CAD261707A.jpeg','14651f5f485a5175b0fd22b4158a28ef.jpeg','tenant/110840102/20210822/14651f5f485a5175b0fd22b4158a28ef.jpeg','jpeg',0,'',110840102),(47,1,126404,1629644901,1,'bbb2e3bb-3003-4ea8-708f-7fbea183b9cb','AD3D5BE5-04A9-477B-96A5-21B5DDF9BE2B.jpeg','6b4be9776fbb78bf6bfc05389bb58977.jpeg','tenant/110840102/20210822/6b4be9776fbb78bf6bfc05389bb58977.jpeg','jpeg',0,'',110840102),(48,1,120622,1629645677,1,'ba24708d-f2ba-4fd7-50ef-56fe23a46ac1','A8AECB56-F292-45AB-AE06-0650354813FC.jpeg','22bac5269114aa503b6f7b93470648bd.jpeg','tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','jpeg',0,'',110840102),(49,1,104315,1629646619,1,'8207682a-feec-44fc-56e8-ae74398ee0c4','DACDDD1E-D7C9-4E20-8B1D-52A1E97589B5.png','adf90c8b8bb135c05e2db24af2c5174e.png','tenant/110840102/20210822/adf90c8b8bb135c05e2db24af2c5174e.png','png',0,'',110840102),(50,1,294668,1629646642,1,'942f971f-afd6-4409-60ce-717c1d2dda08','9A3B00E0-0EF5-4214-A08A-D44AB0DDDB00.png','42aca57b7ad77ecb609c6abce3129dfd.png','tenant/110840102/20210822/42aca57b7ad77ecb609c6abce3129dfd.png','png',0,'',110840102),(51,1,12695,1629646684,1,'2f519aae-756d-4364-58da-924de4dcc3db','FA5B9E24-30B8-487E-8B58-6974E82D42C3.jpeg','a94cf24795be851dbcc50302071ac8a3.jpeg','tenant/110840102/20210822/a94cf24795be851dbcc50302071ac8a3.jpeg','jpeg',0,'',110840102),(52,1,125181,1629957534,1,'05896a47-34c5-4b9d-5382-3417fa74e50e','CA63B916-1337-4F03-9B6C-AF03C74B202B.jpeg','f46c01489924377f495b951237b96871.jpeg','tenant/110840102/20210826/f46c01489924377f495b951237b96871.jpeg','jpeg',0,'',110840102),(53,1,129270,1629957669,1,'584fdd38-5c9b-4a99-61e1-1534b835bd96','603F9466-E5AF-4F49-9A17-8E4FC705FE67.jpeg','a2eea0713cd10a21c7688ad264b645d7.jpeg','tenant/110840102/20210826/a2eea0713cd10a21c7688ad264b645d7.jpeg','jpeg',0,'',110840102),(54,1,134104,1629963137,1,'82dcce4f-756d-4a58-797e-ed8106ddef3a','208C4DB8-F1A1-460D-A6C6-F34A06C9076B.jpeg','3b082e1251d3fb903e9508989c02668c.jpeg','tenant/110840102/20210826/3b082e1251d3fb903e9508989c02668c.jpeg','jpeg',0,'',110840102),(55,1,145144,1629963272,1,'8f65c906-9a3c-494d-5390-a2a0d7f5d3f6','484706E0-0257-487D-9C51-3E9FEA11C8BF.jpeg','e8cd32591fa9f0de02ed87541b289871.jpeg','tenant/110840102/20210826/e8cd32591fa9f0de02ed87541b289871.jpeg','jpeg',0,'',110840102),(56,1,140622,1629963372,1,'a9f283ee-1567-4bce-536f-0e2568997fe2','A35D07BB-6987-4FAA-8D3C-C1F2153DEB7C.jpeg','b8c1dea802d76f512edb67aebb587fce.jpeg','tenant/110840102/20210826/b8c1dea802d76f512edb67aebb587fce.jpeg','jpeg',0,'',110840102),(57,1,127525,1629963434,1,'ea8c5b7d-341f-471e-452e-696a45d7d5eb','E2B40564-5962-4723-A954-F10C04971C8C.jpeg','9d1120a803a745d9a868ebad49346180.jpeg','tenant/110840102/20210826/9d1120a803a745d9a868ebad49346180.jpeg','jpeg',0,'',110840102),(58,1,124839,1629963490,1,'aea064f8-3921-4393-784e-af7fe79935dd','BFDEE9BE-8ABA-4D3D-8C8B-93503F78D51B.jpeg','96e8799966ba3db60087d441768a46f0.jpeg','tenant/110840102/20210826/96e8799966ba3db60087d441768a46f0.jpeg','jpeg',0,'',110840102),(59,1,152181,1629963557,1,'1004d4fc-7532-4b8e-5d5c-7ef692ca8f29','4AF6C065-E1B0-466D-A840-AE0D21A31C5D.jpeg','3785f81ccbc11eb67d318a3eb57beb6a.jpeg','tenant/110840102/20210826/3785f81ccbc11eb67d318a3eb57beb6a.jpeg','jpeg',0,'',110840102),(60,1,137772,1629963634,1,'c227876e-0901-472d-6b70-49f03f5dbb38','F5417798-EB97-4D5F-B6B1-AE6AFB6A8C6F.jpeg','c6be8288b07349321946efe00881bf7c.jpeg','tenant/110840102/20210826/c6be8288b07349321946efe00881bf7c.jpeg','jpeg',0,'',110840102),(61,1,150067,1629963711,1,'d4b2eb23-8662-42f2-4714-0133fd2f0a1d','58C96FDB-7FC9-40C6-84C5-57B3D6C46565.jpeg','2a14073a6de00cb64e25e25740c45bf7.jpeg','tenant/110840102/20210826/2a14073a6de00cb64e25e25740c45bf7.jpeg','jpeg',0,'',110840102),(62,1,144669,1629963788,1,'dfb596bb-156b-4f1d-580f-76ec54dc146d','7DE4EC09-195E-4162-9E71-CB1AE6AA84A4.jpeg','7dc10cea56a17ab3a5814e4d24afc9ed.jpeg','tenant/110840102/20210826/7dc10cea56a17ab3a5814e4d24afc9ed.jpeg','jpeg',0,'',110840102),(63,1,148867,1629964254,1,'a2eb0f68-1c44-4718-6176-cc6a47ca9d76','E0A76C9F-F035-42B4-8ECE-A70388B35025.jpeg','5e75b43b1b9b706d2d10ad0f59fba312.jpeg','tenant/110840102/20210826/5e75b43b1b9b706d2d10ad0f59fba312.jpeg','jpeg',0,'',110840102),(64,1,127285,1629964555,1,'bd4937bd-203b-4d05-516b-437c33fe747c','598ABC65-05DF-45A0-AB21-A4F334661E41.jpeg','f981b34851af84bc756b5317fea3861c.jpeg','tenant/110840102/20210826/f981b34851af84bc756b5317fea3861c.jpeg','jpeg',0,'',110840102),(65,1,131241,1629964651,1,'d639e4d6-43f6-4883-5703-1f687793e50e','9673FFB9-50E3-49AA-8BFF-8517CD468A55.jpeg','8f5e59d9e0890bf3bbe4e40568d4df4d.jpeg','tenant/110840102/20210826/8f5e59d9e0890bf3bbe4e40568d4df4d.jpeg','jpeg',0,'',110840102),(66,1,138530,1630031051,1,'2db4d267-ee81-42d9-5618-60f4757c6a62','4C453C59-2921-409B-8F36-72918A1BC76E.jpeg','0eea951081330e763c7529640b1a9229.jpeg','tenant/110840102/20210827/0eea951081330e763c7529640b1a9229.jpeg','jpeg',0,'',110840102);
/*!40000 ALTER TABLE `cmf_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_auth_access`
--

DROP TABLE IF EXISTS `cmf_auth_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_auth_access` (
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule`
--

LOCK TABLES `cmf_auth_rule` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule` DISABLE KEYS */;
INSERT INTO `cmf_auth_rule` VALUES (1,'app/dashboard','','',1),(2,'app/published/dashboard','','',1),(3,'app/published/wechat','','',1),(4,'app/published/alipay','','',1),(5,'app/published','','',1),(6,'app/order/business/list','','',1),(7,'app/order/business/id','','',1),(8,'app/order/business','','',1),(9,'app/order/member','','',1),(10,'app/order/recharge','','',1),(11,'app/order/default','','',1),(12,'app/dishes/goods/index','','',1),(13,'app/dishes/goods/add','','',1),(14,'app/dishes/goods/edit','','',1),(15,'app/dishes/goods','','',1),(16,'app/dishes/category','','',1),(17,'app/dishes','','',1),(18,'app/desk/index','','',1),(19,'app/desk/category','','',1),(20,'app/desk/default','','',1),(21,'app/member/index','','',1),(22,'app/member/default','','',1),(23,'app/marketing/card','','',1),(24,'app/marketing/coupon','','',1),(25,'app/marketing/wechat','','',1),(26,'app/marketing/recharge','','',1),(27,'app/marketing/score','','',1),(28,'app/marketing','','',1),(29,'app/theme/index','','',1),(30,'app/theme/assets','','',1),(31,'app/theme/default','','',1),(32,'/app/portal/index','','',1),(33,'/app/portal/category/add','','',1),(34,'/app/portal/category/edit','','',1),(35,'/app/portal/category','','',1),(36,'portal/default','','',1),(37,'app/store/add','','',1),(38,'app/store/edit','','',1),(39,'app/store/edit_for_here','','',1),(40,'app/store/edit_take_out','','',1),(41,'app/store/index','','',1),(42,'app/store/printer','','',1),(43,'app/store','','',1),(44,'app/user/settings','','',1),(45,'app/user/add','','',1),(46,'app/user/edit','','',1),(47,'app/user/index','','',1),(48,'app/user/role/list','','',1),(49,'app/user/role/edit','','',1),(50,'app/user/role/delete','','',1),(51,'app/user/authorize/add','','',1),(52,'app/user/authorize/edit','','',1),(53,'app/user/role','','',1),(54,'app/user','','',1),(55,'app/settings/index','','',1),(56,'app/settings/contact','','',1),(57,'app/settings/logistics','','',1),(58,'app/settings','','',1),(59,'app/notice/list','','',1),(60,'app/notice','','',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule_api`
--

LOCK TABLES `cmf_auth_rule_api` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule_api` DISABLE KEYS */;
INSERT INTO `cmf_auth_rule_api` VALUES (1,'app/dashboard','/api/v1/admin/dashboard/analysis','',1),(2,'app/dashboard','/api/v1/admin/dashboard/sales_ranking','',1),(3,'app/order/business','/api/v1/admin/dishes/store','',1),(4,'app/order/business','/api/v1/admin/order/index','',1);
/*!40000 ALTER TABLE `cmf_auth_rule_api` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_card_template`
--

DROP TABLE IF EXISTS `cmf_card_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_card_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `card_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员卡名称',
  `card_show_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包端显示名称',
  `card_background` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡片背景图片',
  `alipay_background_id` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL COMMENT '背景图片Id',
  `valid_period` int(11) NOT NULL COMMENT '有效期',
  `benefit_info` json DEFAULT NULL COMMENT '权益说明',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT '0' COMMENT '''删除时间''',
  `template_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板ID',
  `sync_to_alipay` tinyint(2) NOT NULL DEFAULT '0' COMMENT '同步到支付宝卡包',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_card_template`
--

LOCK TABLES `cmf_card_template` WRITE;
/*!40000 ALTER TABLE `cmf_card_template` DISABLE KEYS */;
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
  `desk_number` bigint(20) NOT NULL COMMENT '桌位编号',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '座位名称',
  `category_id` int(11) NOT NULL COMMENT '对应小程序id',
  `category_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应小程序id',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '桌位状态',
  `list_order` double NOT NULL DEFAULT '10000' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_desk`
--

LOCK TABLES `cmf_desk` WRITE;
/*!40000 ALTER TABLE `cmf_desk` DISABLE KEYS */;
INSERT INTO `cmf_desk` VALUES (1,110840102,1,269594623,'1号桌',1,'座位',1,10000),(2,110840102,1,236543282,'2号桌',1,'座位',1,10000),(3,110840102,1,406595653,'3号桌',1,'座位',1,10000),(4,110840102,1,1430873561,'4号桌',1,'座位',1,10000),(5,110840102,1,795619564,'5号桌',1,'座位',1,10000),(6,110840102,1,403206722,'6号桌',1,'座位',1,10000),(7,110840102,1,1147774509,'7号桌',1,'座位',1,10000),(8,110840102,1,2096499453,'8号桌',1,'座位',1,10000),(9,110840102,1,1279229980,'9号桌',1,'座位',1,10000),(10,110840102,1,1550255675,'10号桌',1,'座位',1,10000),(11,110840102,1,766475354,'11号桌',1,'座位',1,10000),(12,110840102,1,1516210998,'12号桌',1,'座位',1,10000),(13,110840102,1,939248780,'13号桌',1,'座位',1,10000);
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
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `category_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '座位名称',
  `least_seats` int(2) NOT NULL COMMENT '最少人数',
  `maximum_seats` int(2) NOT NULL COMMENT '最多人数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_desk_category`
--

LOCK TABLES `cmf_desk_category` WRITE;
/*!40000 ALTER TABLE `cmf_desk_category` DISABLE KEYS */;
INSERT INTO `cmf_desk_category` VALUES (1,110840102,1,'座位',1,4);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_exp_log`
--

LOCK TABLES `cmf_exp_log` WRITE;
/*!40000 ALTER TABLE `cmf_exp_log` DISABLE KEYS */;
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
  `excerpt` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品摘要',
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
  `default_inventory` int(11) DEFAULT NULL COMMENT '默认库存',
  `volume` int(11) DEFAULT NULL COMMENT '销量',
  `start_sale` tinyint(3) NOT NULL DEFAULT '1' COMMENT '起售',
  `thumbnail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品缩略图',
  `alipay_material_id` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '阿里素材标识',
  `scene` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支持场景（0 =>全部；1=>堂食；2=>外卖）',
  `is_recommend` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否推荐菜',
  `content` text COLLATE utf8mb4_general_ci,
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT '0' COMMENT '删除时间',
  `weight` float DEFAULT NULL COMMENT '重量（kg）',
  `unit` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品单位',
  `dish_type` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品类型',
  `flavor` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品口味',
  `cooking_method` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品做法',
  `status` tinyint(3) NOT NULL COMMENT '菜品状态',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food`
--

LOCK TABLES `cmf_food` WRITE;
/*!40000 ALTER TABLE `cmf_food` DISABLE KEYS */;
INSERT INTO `cmf_food` VALUES (1,'110840102','','腊味+（鸡腿、鸡翅、牛肉、排骨）','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,1,'[{\"attr_key\":\"规格\",\"attr_val\":[\"腊味拼鸡腿\",\"腊味拼鸡翅\",\"腊味拼牛肉\",\"腊味拼排骨\"]}]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105',0,1,'',1629644563,1629644563,1629956298,0.1,'份','','','',1,15,1),(2,'110840102','','牛肉+（鸡腿、鸡翅、排骨）','牛肉+（鸡腿、鸡翅、排骨）',0,1,'[{\"attr_key\":\"规格\",\"attr_val\":[\"牛肉拼鸡腿\",\"牛肉拼鸡翅\",\"牛肉拼排骨\"]}]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502',0,1,'',1629644611,1629644611,1629956306,0.1,'份','','','',1,14,1),(3,'110840102','','排骨+（鸡腿、鸡翅）','排骨+（鸡腿、鸡翅）',0,1,'[{\"attr_key\":\"规格\",\"attr_val\":[\"排骨拼鸡腿\",\"排骨拼鸡翅\"]}]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/6b4be9776fbb78bf6bfc05389bb58977.jpeg','2021082200502200000017281566',0,1,'',1629644920,1629644920,1629956460,0.1,'份','','','',1,8,1),(4,'110840102','','腊肠','',0,0,'[]',0,0.00,0,0.00,4.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/d5fcf67b9a29e25cbec52f5d1f4f89b9.jpeg','2021082200502200000017280896',0,0,'',1629644386,1629644386,0,0.1,'根','','','',1,3,1),(5,'110840102','','鸡腿','',0,0,'[]',0,0.00,0,0.00,6.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/ffc801d400728d7256ba2bef8a24e43d.jpg','2021082200502200000017274520',0,0,'',1629639512,1629639512,0,0.1,'个','','','',1,0,1),(6,'110840102','','鸡翅','',0,0,'[]',0,0.00,0,0.00,6.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/6056073c8973a587e708f08c7f37b919.jpg','2021082200502200000017274758',0,0,'',1629639534,1629639534,0,0.1,'个','','','',1,2,1),(7,'110840102','','肉饼饭','',0,0,'[]',0,0.00,0,0.00,13.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','',0,0,'',1629852419,1629852419,0,0.1,'份','','','',1,18,1),(8,'110840102','','冬菇鸡','',0,0,'[]',0,0.00,0,0.00,14.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/dfcc0f187a33cd6a6e5c457d1a55e31a.jpeg','2021082200502200000017279875',0,0,'',1629643234,1629643234,0,0.2,'份','','','',1,17,1),(9,'110840102','','腊味饭','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/447a97f7f315e03f79152772378ecbf4.jpeg','2021082200502200000017279924',0,0,'',1629643445,1629643445,0,0.2,'份','','','',1,16,1),(10,'110840102','','牛肉饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/46b2d457a4ae17eb4015a5ff0ccfa06e.jpeg','',0,1,'',1629965131,1629965131,0,0.2,'份','','','',1,14,1),(11,'110840102','','排骨饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/e49be5bad96007b0ac11732fc512d86c.jpeg','',0,1,'',1629965149,1629965149,0,0.2,'份','','','',1,13,1),(12,'110840102','','怡宝','',0,0,'[]',0,0.00,0,0.00,2.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/42aca57b7ad77ecb609c6abce3129dfd.png','2021082200502200000017283064',0,0,'',1629646651,1629646651,0,0.1,'份','','','',1,120,1),(13,'110840102','','雪碧','',0,0,'[]',0,0.00,0,0.00,2.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/a94cf24795be851dbcc50302071ac8a3.jpeg','2021082200502200000017283071',0,0,'',1629646696,1629646696,0,0.1,'份','','','',1,118,1),(14,'110840102','','可乐','',0,0,'[]',0,0.00,0,0.00,2.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/9f010b34a182c0eeec15cf5320f76a14.jpeg','2021082200502200000017277839',0,0,'',1629641440,1629641440,0,0.1,'份','','','',1,116,1),(15,'110840102','','维他奶(原味)','',0,0,'[]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/09265a1bbb7b46acb09115d250a1e653.jpeg','',0,0,'',1629782541,1629782541,0,0.1,'份','','','',1,115,1),(16,'110840102','','维他柠檬茶','',0,0,'[]',0,0.00,0,0.00,3.50,0.00,-1,-1,0,1,'tenant/110840102/20210822/78a35a00d69539cbd22e7f05784a2c7f.jpeg','2021082200502200000017278136',0,0,'',1629641527,1629641527,0,0.1,'份','','','',1,114,1),(17,'110840102','','肉饼+(鸡腿、鸡翅、牛肉、排骨）','肉饼+（鸡腿、鸡翅、腊味、牛肉、排骨）',0,1,'[{\"attr_key\":\"规格\",\"attr_val\":[\"肉饼拼腊味\",\"肉饼拼鸡腿\",\"肉饼拼牛肉\",\"肉饼拼排骨\",\"肉饼拼鸡翅\"]}]',0,0.00,0,0.00,15.00,1.00,-1,-1,0,1,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','',0,1,'',1629889398,1629889398,1629956295,0.1,'份','','','',1,16,1),(18,'110840102','xyd','咸鸭蛋','',0,0,'[]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/4f887ed2120311b6d6cedb2873cc28ea.jpg','2021082200502200000017274258',0,0,'',1629639217,1629639217,0,0.2,'份','','','',1,4,1),(19,'110840102','rb','肉饼','',0,0,'[]',0,0.00,0,0.00,5.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/757aed83d838a0c73fba447ab1e91f4e.png','2021082200502200000017274326',0,0,'',1629639378,1629639378,0,0.2,'份','','','',1,1,1),(20,'110840102','','剁椒鱼','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/77bdcc1d237ebc004accdf91df05827b.jpeg','2021082200502200000017280340',0,0,'',1629643485,1629643485,0,0.2,'份','','','',0,15,1),(21,'110840102','','牛腩饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/92e7256860e6d3aa58600dd6c2ace7bf.jpeg','2021082200502200000017280398',0,0,'',1629643694,1629643694,0,0.2,'份','','','',1,7,1),(22,'110840102','','牛肉丸饼汤','',0,0,'[]',0,0.00,0,0.00,8.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/eca3623ee1373059e40865f5c94e4451.jpeg','2021082200502200000017280096',0,0,'',1629643654,1629643654,0,0.2,'份','','','',1,12,1),(23,'110840102','','牛腩+(米粉/面)','',0,1,'[{\"attr_key\":\"规格\",\"attr_val\":[\"牛腩米粉\",\"牛腩面\"]}]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/a89defea249d5cf32fdaa700e60ff6ba.jpeg','2021082600502200000018083964',0,0,'',1629956423,1629956423,0,0.2,'份','','','',1,11,1),(24,'110840102','','牛肉丸饼+(米粉/面)','',0,1,'[{\"attr_key\":\"规格\",\"attr_val\":[\"牛肉丸饼米粉\",\"牛肉丸饼面\"]}]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/110840102/20210822/14651f5f485a5175b0fd22b4158a28ef.jpeg','',0,0,'',1629956455,1629956455,0,0.2,'份','','','',1,10,1),(25,'110840102','','排骨饭(今日特惠)','',0,0,'[]',0,0.00,0,0.00,14.90,0.00,-1,-1,0,1,'tenant/110840102/20210822/e49be5bad96007b0ac11732fc512d86c.jpeg','2021082500502200000017928505',0,0,'',1629889655,1629889655,0,0.1,'份','','','',0,1,1),(26,'110840102','','肉饼鸡腿饭','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/f46c01489924377f495b951237b96871.jpeg','',0,0,'',1630117168,1630117168,0,0.1,'份','','','',1,1,1),(27,'110840102','','肉饼鸡翅饭','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/a2eea0713cd10a21c7688ad264b645d7.jpeg','',0,0,'',1629962367,1629962367,0,0.1,'份','','','',1,2,1),(28,'110840102','','肉饼腊肉饭','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/3b082e1251d3fb903e9508989c02668c.jpeg','2021082600502200000018110109',0,0,'',1629963194,1629963194,0,0.1,'份','','','',1,3,1),(29,'110840102','','肉饼牛肉饭','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/e8cd32591fa9f0de02ed87541b289871.jpeg','2021082600502200000018109959',0,0,'',1629963340,1629963340,0,0.1,'份','','','',1,4,1),(30,'110840102','','肉饼排骨饭','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/b8c1dea802d76f512edb67aebb587fce.jpeg','2021082600502200000018110304',0,0,'',1629963406,1629963406,0,0.1,'份','','','',1,5,1),(31,'110840102','','腊味鸡腿饭','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/9d1120a803a745d9a868ebad49346180.jpeg','2021082600502200000018110687',0,0,'',1629963465,1629963465,0,0.1,'份','','','',1,6,1),(32,'110840102','','腊味鸡翅饭','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/96e8799966ba3db60087d441768a46f0.jpeg','2021082600502200000018110718',0,0,'',1629963528,1629963528,0,0.1,'份','','','',1,7,1),(33,'110840102','','腊味牛肉饭','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/3785f81ccbc11eb67d318a3eb57beb6a.jpeg','2021082600502200000018110990',0,0,'',1629963589,1629963589,0,0.1,'份','','','',1,9,1),(34,'110840102','','腊味排骨饭','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/c6be8288b07349321946efe00881bf7c.jpeg','2021082600502200000018111429',0,0,'',1629963685,1629963685,0,0.1,'份','','','',1,8,1),(35,'110840102','','牛肉鸡腿饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/2a14073a6de00cb64e25e25740c45bf7.jpeg','',0,1,'',1630117103,1630117103,0,0.1,'份','','','',1,13,1),(36,'110840102','','牛肉鸡翅饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/7dc10cea56a17ab3a5814e4d24afc9ed.jpeg','2021082600502200000018112322',0,1,'',1629964207,1629964207,0,0.1,'份','','','',1,10000,1),(37,'110840102','','牛肉排骨饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/5e75b43b1b9b706d2d10ad0f59fba312.jpeg','2021082600502200000018112566',0,1,'',1629964306,1629964306,0,0.1,'份','','','',1,10,1),(38,'110840102','','排骨鸡腿饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/f981b34851af84bc756b5317fea3861c.jpeg','',0,1,'',1629964854,1629964854,0,0.1,'份','','','',1,14,1),(39,'110840102','','排骨鸡翅饭','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/110840102/20210826/8f5e59d9e0890bf3bbe4e40568d4df4d.jpeg','2021082600502200000018113690',0,1,'',1629964722,1629964722,0,0.1,'份','','','',1,11,1),(40,'110840102','','腊味饭「今日特价10.9」','',0,0,'[]',0,0.00,0,0.00,10.90,0.00,-1,-1,0,1,'tenant/110840102/20210827/0eea951081330e763c7529640b1a9229.jpeg','2021082700502200000018262310',0,0,'',1630031099,1630031099,0,0.1,'份','','','',0,1,1),(41,'110840102','','肉饼饭「每周一特价」','',0,0,'[]',0,0.00,0,0.00,9.90,0.00,-1,-1,0,1,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','',0,0,'',1630295409,1630295409,0,0.1,'份','','','',1,1,1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_key`
--

LOCK TABLES `cmf_food_attr_key` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_key` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_post`
--

LOCK TABLES `cmf_food_attr_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_post` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_value`
--

LOCK TABLES `cmf_food_attr_value` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_food_attr_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_category`
--

DROP TABLE IF EXISTS `cmf_food_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_category` (
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品分类名称',
  `icon` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品分类推荐图标',
  `is_required` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否必选品（0=>否，1=>是）',
  `scene` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支持场景（0 =>全部；1=>堂食；2=>外卖）',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT '0' COMMENT '''删除时间''',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '菜品分类状态（0 => 下架,1 => 上架）',
  `list_order` double NOT NULL DEFAULT '10000' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category`
--

LOCK TABLES `cmf_food_category` WRITE;
/*!40000 ALTER TABLE `cmf_food_category` DISABLE KEYS */;
INSERT INTO `cmf_food_category` VALUES (1,1,110840102,'单品区','',0,0,0,1629524391,1629640158,0,1,9),(1,2,110840102,'双拼区','',0,0,0,1626402245,1629640158,0,1,8),(1,3,110840102,'饮品区','',0,0,0,1626402246,1629640158,0,1,6),(1,4,110840102,'汤粉区','',0,0,0,1629618872,1629640158,0,1,7),(1,5,110840102,'特价区','',0,0,0,1629889519,1629889519,0,1,5);
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
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_post`
--

LOCK TABLES `cmf_food_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_post` DISABLE KEYS */;
INSERT INTO `cmf_food_category_post` VALUES (1,1,2,1626402246,1626402246),(2,2,2,1626402246,1626402246),(3,3,2,1626402246,1626402246),(4,4,1,1626402246,1626402246),(5,5,1,1626402246,1626402246),(6,6,1,1626402246,1626402246),(7,7,1,1626402246,1626402246),(8,8,1,1626402247,1626402247),(9,9,1,1626402247,1626402247),(10,10,1,1626402247,1626402247),(11,11,1,1626402247,1626402247),(12,12,3,1626402247,1626402247),(13,13,3,1626402247,1626402247),(14,14,3,1626402247,1626402247),(15,15,3,1626402248,1626402248),(16,16,3,1626402248,1626402248),(17,17,2,0,0),(18,18,1,0,0),(19,19,1,0,0),(20,20,1,1629640159,1629640159),(21,21,1,1629640159,1629640159),(22,22,4,1629640159,1629640159),(23,23,4,1629640159,1629640159),(24,24,4,1629640159,1629640159),(25,25,5,0,0),(26,26,2,0,0),(27,27,2,0,0),(28,28,2,0,0),(29,29,2,0,0),(30,30,2,0,0),(31,31,2,0,0),(32,32,2,0,0),(33,33,2,0,0),(34,34,2,0,0),(35,35,2,0,0),(36,36,2,0,0),(37,37,2,0,0),(38,38,2,0,0),(39,39,2,0,0),(40,40,5,0,0),(41,41,5,0,0);
/*!40000 ALTER TABLE `cmf_food_category_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_material_post`
--

DROP TABLE IF EXISTS `cmf_food_material_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_material_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `food_id` int(11) DEFAULT NULL,
  `material_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '加料名称',
  `material_price` decimal(9,2) NOT NULL COMMENT '加料加价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_material_post`
--

LOCK TABLES `cmf_food_material_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_material_post` DISABLE KEYS */;
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
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `trade_no` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝订单号',
  `queue_no` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '取餐队列号',
  `pay_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方支付类型',
  `store_id` int(11) NOT NULL COMMENT '所属门店id',
  `order_type` tinyint(3) NOT NULL COMMENT '订单类型（1 => 门店扫码就餐',
  `appointment_at` bigint(20) DEFAULT NULL COMMENT '预约取餐时间',
  `appointment_type` tinyint(3) DEFAULT '0' COMMENT '是否预约单',
  `order_detail` json NOT NULL COMMENT '订单详情',
  `box_fee` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '餐盒费',
  `delivery_fee` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '配送费',
  `coupon_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `voucher_id` int(11) DEFAULT NULL COMMENT '优惠券id',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '合计金额',
  `original_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '原价金额',
  `desk_id` int(11) DEFAULT NULL COMMENT '桌号id',
  `desk_name` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '桌位名称详情',
  `user_id` bigint(20) DEFAULT NULL COMMENT '下单人信息',
  `name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户预留姓名',
  `mobile` varchar(11) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户预留手机号',
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户预留收货地址',
  `address_id` int(11) DEFAULT NULL COMMENT '选择地址id',
  `create_at` bigint(20) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  `order_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WAIT_BUYER_PAY' COMMENT '订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用/已支付，TRADE_FINISHED=> 已完成，TRADE_REFUSED => 已拒绝，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）',
  `delivery_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运输状态（TRADE_RECEIVED => 已接单，TRADE_DELIVERY => 运输中',
  `form_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝推送formId',
  `refund_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '剩余可退金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order`
--

LOCK TABLES `cmf_food_order` WRITE;
/*!40000 ALTER TABLE `cmf_food_order` DISABLE KEYS */;
INSERT INTO `cmf_food_order` VALUES (1,110840102,'T2021072163409145','2021072122001440611445700405','1','alipay',1,2,1626855606,0,'[{\"fee\": 2, \"name\": \"怡宝\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 12, \"material\": []}, {\"fee\": 5, \"name\": \"雪碧\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 13, \"material\": []}]',0.00,0.00,0.00,0,'',7.00,7.00,1,'1号桌',5,'','13537110699','',0,1626855606,1626898807,'TRADE_FINISHED','','MjA4ODUxMjU4NDk0MDYxN18xNjI2ODU1NjA0OTc3Xzg1NA==',7.00),(2,110840102,'T20210721956041406','2021072122001496711444713659','','alipay',1,2,1626855774,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,0,'',1,'','17625458589','',0,1626855774,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjI2ODU1NzczODEwXzY4NQ==',0.00),(3,110840102,'T202107212131343464','wx21171058735081564b62b99572fa680000','','wxpay',1,2,1626858658,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,0,'',1,'','17625458589','',0,1626858658,0,'TRADE_CLOSED','','',0.00),(4,110840102,'T20210822991834936','wx22222135555248bebbba8285a5cc8f0000','','wxpay',1,2,1629642095,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,0,'',9,'','13421545056','',0,1629642095,0,'TRADE_CLOSED','','',0.00),(5,110840102,'T202108231897228444','wx23002809969768501c06691ac482be0000','','wxpay',1,2,1629649689,0,'[{\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,0,'',10,'','13421506848','',0,1629649689,0,'TRADE_CLOSED','','',0.00),(6,110840102,'T20210823439171954','wx230957588469366f70faceddee2af10000','','wxpay',1,2,1629683878,0,'[{\"fee\": 13, \"name\": \"肉饼饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',13.00,13.00,1,'1号桌',10,'','13421506848','',0,1629683878,0,'TRADE_CLOSED','','',0.00),(7,110840102,'T20210823646928682','wx2309582170338599c8dad5a781ce5d0000','1','wxpay',1,2,1629683901,0,'[{\"fee\": 13, \"name\": \"肉饼饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',13.00,13.00,1,'1号桌',9,'','13421545056','',0,1629683901,1629727102,'TRADE_FINISHED','','',13.00),(8,110840102,'T20210824938599688','wx2411413199736027965fac62c111bf0000','1','wxpay',1,2,1629776491,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',9.90,9.90,4,'4号桌',11,'','17051176298','',0,1629776491,1629819692,'TRADE_FINISHED','','',9.90),(9,110840102,'T20210824942076642','2021082422001448951412104941','2','alipay',1,2,1629776716,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',9.90,9.90,5,'5号桌',12,'','17324261087','',0,1629776716,1629819917,'TRADE_FINISHED','','MjA4ODEyMjMwMjc0ODk1NV8xNjI5Nzc2NzE1OTMwXzU4MA==',9.90),(10,110840102,'T20210824242225933','2021082422001417231419365219','3','alipay',1,2,1629776722,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,5.00,0,'',4.90,9.90,5,'5号桌',13,'','18218152318','',0,1629776722,1629819923,'TRADE_FINISHED','','MjA4ODcxMjU3MzQxNzIzNF8xNjI5Nzc2NzIwNjM1XzEwMw==',4.90),(11,110840102,'T20210824365048888','2021082422001454261421729296','4','alipay',1,2,1629776728,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',7.90,9.90,5,'5号桌',15,'','15625705217','',0,1629776728,1629819929,'TRADE_FINISHED','','MjA4ODUxMjc3MzI1NDI2MF8xNjI5Nzc2NzI2MTczXzc5Mw==',7.90),(12,110840102,'T202108242066503011','2021082422001430891431843048','5','alipay',1,2,1629776734,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,4.00,0,'',5.90,9.90,2,'2号桌',14,'','13172226366','',0,1629776734,1629819935,'TRADE_FINISHED','','MjA4ODAxMjcyNjMzMDg5M18xNjI5Nzc2NzM0MDc1XzI0OQ==',5.90),(13,110840102,'T20210824363757109','2021082422001432291425516227','6','alipay',1,2,1629776791,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',7.90,9.90,2,'2号桌',16,'','13138281142','',0,1629776791,1629819992,'TRADE_FINISHED','','MjA4ODgxMjg4NTIzMjI5NF8xNjI5Nzc2NzkwNzA1XzAwNQ==',7.90),(14,110840102,'T20210824306157354','2021082422001424951417865543','7','alipay',1,3,1629776943,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}, {\"fee\": 3, \"name\": \"咸鸭蛋\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 18, \"material\": []}]',0.00,0.00,5.00,0,'',7.90,12.90,5,'5号桌',17,'','13265234473','',0,1629776943,1629820144,'TRADE_FINISHED','','MjA4ODEyMjE0NzMyNDk1OF8xNjI5Nzc2OTQyOTM1XzAxMw==',7.90),(15,110840102,'T20210824790073749','2021082422001449221417479697','8','alipay',1,2,1629777781,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,4.00,0,'',5.90,9.90,1,'1号桌',18,'','13549294704','',0,1629777781,1629820982,'TRADE_FINISHED','','MjA4ODYwMjMxNDU0OTIyOF8xNjI5Nzc3NzgwNzQ1XzA4MA==',5.90),(16,110840102,'T20210824687575927','2021082422001445301413719465','9','alipay',1,2,1629778174,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,5.00,0,'',10.00,15.00,6,'6号桌',19,'','13728381468','',0,1629778174,1629821375,'TRADE_FINISHED','','MjA4ODQwMjM5NDA0NTMwOF8xNjI5Nzc4MTc0MjAxXzc5NA==',10.00),(17,110840102,'T20210824392645315','2021082422001459851412809239','10','alipay',1,2,1629778281,0,'[{\"fee\": 15, \"name\": \"剁椒鱼\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 20, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,3,'3号桌',20,'','18575391363','',0,1629778281,1629821482,'TRADE_FINISHED','','MjA4ODgwMjEzMDM1OTg1OF8xNjI5Nzc4MjgwNjYwXzAyNw==',15.00),(18,110840102,'T20210824711974219','2021082422001466811423907795','11','alipay',1,2,1629778319,0,'[{\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼排骨\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 15, \"name\": \"剁椒鱼\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 20, \"material\": []}]',0.00,0.00,5.00,0,'',28.00,33.00,3,'3号桌',21,'','13424832721','',0,1629778320,1629821520,'TRADE_FINISHED','','MjA4ODUwMjY1MDU2NjgxMF8xNjI5Nzc4MzE5MDAwXzAyMg==',28.00),(19,110840102,'T202108241719764452','2021082422001428811425337045','12','alipay',1,2,1629778332,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',7.90,9.90,4,'4号桌',22,'','18773931352','',0,1629778332,1629821533,'TRADE_FINISHED','','MjA4ODgwMjM0NDkyODgxMV8xNjI5Nzc4MzMyMDQ0XzA5MA==',7.90),(20,110840102,'T20210824453267112','2021082422001470281425370837','13','alipay',1,2,1629778351,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,4,'4号桌',24,'','13650345025','',0,1629778351,1629821552,'TRADE_FINISHED','','MjA4ODIyMjA3MTk3MDI4Ml8xNjI5Nzc4MzUxMzMwXzQ4MA==',15.00),(21,110840102,'T20210824865252216','2021082422001445311420892252','14','alipay',1,2,1629778366,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',7.90,9.90,4,'4号桌',25,'','15918747451','',0,1629778366,1629821567,'TRADE_FINISHED','','MjA4ODgwMjMyMTQ0NTMxNV8xNjI5Nzc4MzY1MjcxXzAyNg==',7.90),(22,110840102,'T20210824229739915','2021082422001432911429779813','15','alipay',1,2,1629778380,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,4,'4号桌',23,'','13713296514','',0,1629778380,1629821581,'TRADE_FINISHED','','MjA4ODAyMjAwNDczMjkxOF8xNjI5Nzc4Mzc5OTYzXzUyNg==',15.00),(23,110840102,'T202108241987737321','2021082422001461751413877859','16','alipay',1,2,1629778817,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 2, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',17.80,19.80,8,'8号桌',26,'','13602300800','',0,1629778817,1629822018,'TRADE_FINISHED','','MjA4ODkwMjExNDM2MTc1MV8xNjI5Nzc4ODE0NzczXzk1OA==',17.80),(24,110840102,'T202108242136819652','2021082422001446531414515695','17','alipay',1,2,1629779191,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',9.90,9.90,6,'6号桌',27,'','15252782292','',0,1629779191,1629822392,'TRADE_FINISHED','','MjA4ODEyMjU1NjM0NjUzMl8xNjI5Nzc5MTkxMjU5XzU4Mw==',9.90),(25,110840102,'T202108242007613382','wx24123128898264b6643714571acc1c0000','18','wxpay',1,2,1629779488,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}, {\"fee\": 2, \"name\": \"可乐\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 14, \"material\": []}]',0.00,0.00,0.00,0,'',11.90,11.90,2,'2号桌',28,'','13974838013','',0,1629779488,1629822689,'TRADE_FINISHED','','',11.90),(26,110840102,'T20210824474690130','2021082422001427331418082788','19','alipay',1,2,1629780123,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',7.90,9.90,5,'5号桌',29,'','13903030761','',0,1629780124,1629823324,'TRADE_FINISHED','','MjA4ODExMjQ0NjQyNzMzN18xNjI5NzgwMTIzMDg0XzA0OA==',7.90),(27,110840102,'T202108241499317886','wx2413055934449125f64ec184f70b7b0000','20','wxpay',1,2,1629781558,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 6, \"name\": \"鸡翅\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 6, \"material\": []}, {\"fee\": 3, \"name\": \"维他奶\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"原味\"}], \"sku_id\": 0, \"food_id\": 15, \"material\": []}, {\"fee\": 3, \"name\": \"维他奶\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"巧克力味\"}], \"sku_id\": 0, \"food_id\": 15, \"material\": []}]',0.00,0.00,0.00,0,'',46.00,46.00,5,'5号桌',30,'','13532439131','',0,1629781559,1629824759,'TRADE_FINISHED','','',46.00),(28,110840102,'T202108242051366201','2021082422001408891423657862','21','alipay',1,2,1629781772,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',7.90,9.90,4,'4号桌',31,'','18344306785','',0,1629781772,1629824973,'TRADE_FINISHED','','MjA4ODUyMjMwNTgwODg5MF8xNjI5NzgxNzcxODkyXzg3Ng==',7.90),(29,110840102,'T202108241982483967','2021082422001400771423045219','22','alipay',1,2,1629783368,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',9.90,9.90,2,'2号桌',32,'','13725842913','',0,1629783369,1629826569,'TRADE_FINISHED','','MjA4ODYxMjQ5MDQwMDc3NF8xNjI5NzgzMzY4NjI4XzY2OQ==',9.90),(30,110840102,'T20210824465021080','2021082422001485881424415333','23','alipay',1,2,1629783637,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,4.00,0,'',5.90,9.90,5,'5号桌',33,'','13549429244','',0,1629783637,1629826838,'TRADE_FINISHED','','MjA4ODQyMjU3OTM4NTg4M18xNjI5NzgzNjM2MTI3XzIyNQ==',5.90),(31,110840102,'T20210824687560791','2021082422001443591418189343','24','alipay',1,2,1629802879,0,'[{\"fee\": 4, \"name\": \"腊肠\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 4, \"material\": []}, {\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',13.90,13.90,5,'5号桌',34,'','15999741725','',0,1629802879,1629846080,'TRADE_FINISHED','','MjA4ODYxMjAzNjg0MzU5MV8xNjI5ODAyODc3MTY3XzM1OA==',13.90),(32,110840102,'T202108242018599104','wx24191852266024adc875e1cb864b330000','25','wxpay',1,2,1629803931,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「周一二特价9.9元」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',9.90,9.90,2,'2号桌',35,'','16602021981','',0,1629803931,1629847132,'TRADE_FINISHED','','',9.90),(33,110840102,'T2021082432919420','2021082422001402261419672038','26','alipay',1,2,1629808646,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,2.00,0,'',13.00,15.00,2,'2号桌',36,'','13129726489','',0,1629808646,1629851847,'TRADE_FINISHED','','MjA4ODkzMjMzMTgwMjI2NV8xNjI5ODA4NjQ1ODQ3Xzk3NA==',13.00),(34,110840102,'T20210824227713903','wx24203916542725af09a7e382aca3840000','27','wxpay',1,2,1629808756,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,2,'2号桌',37,'','18681169190','',0,1629808756,1629851957,'TRADE_FINISHED','','',16.00),(35,110840102,'T202108251290611858','wx251142435841871ac2afe3e1bc6b4c0000','1','wxpay',1,2,1629862963,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,5,'5号桌',11,'','17051176298','',0,1629862963,1629906164,'TRADE_FINISHED','','',16.00),(36,110840102,'T202108251379880381','wx25114250104591a2b606d8da7de73b0000','','wxpay',1,2,1629862969,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,5,'5号桌',11,'','17051176298','',0,1629862969,0,'TRADE_CLOSED','','',0.00),(37,110840102,'T202108251066600948','wx25114252302777ec9d47692af488e40000','','wxpay',1,2,1629862971,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,5,'5号桌',11,'','17051176298','',0,1629862972,0,'TRADE_CLOSED','','',0.00),(38,110840102,'T202108252100749852','2021082522001411171427979111','2','alipay',1,2,1629864578,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,2.00,0,'',30.00,32.00,1,'1号桌',39,'','13332648195','',0,1629864578,1629907779,'TRADE_FINISHED','','MjA4ODMxMjU0NTIxMTE3Ml8xNjI5ODY0NTc5NzA4XzE4OQ==',30.00),(39,110840102,'T202108251533780306','2021082522001434981433887608','3','alipay',1,2,1629864687,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,5.00,0,'',10.00,15.00,2,'2号桌',43,'','13539005809','',0,1629864687,1629907888,'TRADE_FINISHED','','MjA4ODMxMjY3MjIzNDk4NV8xNjI5ODY0Njg2Mzg4XzE5Nw==',10.00),(40,110840102,'T202108251226485806','2021082522001401691425484298','4','alipay',1,2,1629864697,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼排骨\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,5.00,0,'',10.00,15.00,2,'2号桌',40,'','13763138490','',0,1629864698,1629907898,'TRADE_FINISHED','','MjA4ODAwMjkxMzgwMTY5M18xNjI5ODY0Njk2OTE2XzM2OA==',10.00),(41,110840102,'T202108251127844673','2021082522001467211417956572','5','alipay',1,2,1629864712,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,2.00,0,'',14.00,16.00,2,'2号桌',42,'','13728202687','',0,1629864712,1629907913,'TRADE_FINISHED','','MjA4ODAyMjEwOTM2NzIxMV8xNjI5ODY0NzExNDM2XzI2Ng==',14.00),(42,110840102,'T20210825986468754','2021082522001470611420133257','6','alipay',1,2,1629864748,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,2,'2号桌',41,'','15622775293','',0,1629864748,1629907949,'TRADE_FINISHED','','MjA4ODAyMjM0Mjk3MDYxNF8xNjI5ODY0NzQ3Nzc0Xzk4OA==',15.00),(43,110840102,'T202108252109453331','2021082522001434981433301048','','alipay',1,2,1629864768,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿超值套餐\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,2,'2号桌',43,'','13539005809','',0,1629864768,0,'TRADE_CLOSED','','MjA4ODMxMjY3MjIzNDk4NV8xNjI5ODY0NzY3Mjc0Xzk4NA==',0.00),(44,110840102,'T202108251061355095','2021082522001446701406726429','7','alipay',1,2,1629865129,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼排骨\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,2.00,0,'',14.00,16.00,5,'5号桌',44,'','13412996636','',0,1629865129,1629908330,'TRADE_FINISHED','','MjA4ODExMjc2NDU0NjcwNV8xNjI5ODY1MTI4NjQwXzc5MQ==',14.00),(45,110840102,'T20210825302767742','2021082522001422471418325494','8','alipay',1,2,1629865819,0,'[{\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,4,'4号桌',45,'','15501508967','',0,1629865819,1629909020,'TRADE_FINISHED','','MjA4ODEwMjU5NTEyMjQ3MF8xNjI5ODY1ODE4ODYxXzE2MQ==',18.00),(46,110840102,'T202108252018901673','wx251230257812783e13e546bfabdf570000','9','wxpay',1,2,1629865825,0,'[{\"fee\": 14.9, \"name\": \"排骨饭「周三特价14.9」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 11, \"material\": []}]',0.00,0.00,0.00,0,'',14.90,14.90,1,'1号桌',46,'','15013021879','',0,1629865825,1629909026,'TRADE_FINISHED','','',14.90),(47,110840102,'T202108251133349336','2021082522001474051414687347','10','alipay',1,2,1629865915,0,'[{\"fee\": 14.9, \"name\": \"排骨饭「周三特价14.9」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 11, \"material\": []}]',0.00,0.00,0.00,0,'',14.90,14.90,11,'11号桌',47,'','15728711603','',0,1629865915,1629909116,'TRADE_FINISHED','','MjA4ODAyMjY3MDY3NDA1M18xNjI5ODY1OTE0OTIzXzA4Mw==',14.90),(48,110840102,'T202108251834374528','2021082522001461751415610381','11','alipay',1,2,1629866113,0,'[{\"fee\": 14.9, \"name\": \"排骨饭「周三特价14.9」\", \"count\": 2, \"tasty\": [], \"sku_id\": 0, \"food_id\": 11, \"material\": []}]',0.00,0.00,0.00,0,'',29.80,29.80,8,'8号桌',26,'','13602300800','',0,1629866114,1629909314,'TRADE_FINISHED','','MjA4ODkwMjExNDM2MTc1MV8xNjI5ODY2MTE0NDQ4XzkxNg==',29.80),(49,110840102,'T202108251191575964','2021082522001432821429457870','12','alipay',1,2,1629867213,0,'[{\"fee\": 16, \"name\": \"牛肉丸饼+(米粉/河粉/面)\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉丸饼面\"}], \"sku_id\": 0, \"food_id\": 24, \"material\": []}]',0.00,0.00,5.00,0,'',11.00,16.00,2,'2号桌',48,'','13549290390','',0,1629867213,1629910415,'TRADE_FINISHED','','MjA4ODUyMjA2ODEzMjgyM18xNjI5ODY3MjEyODM3XzA3Nw==',11.00),(50,110840102,'T20210825499680086','2021082522001450701411790654','13','alipay',1,2,1629886222,0,'[{\"fee\": 14.9, \"name\": \"排骨饭「周三特价14.9」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 11, \"material\": []}]',0.00,0.00,0.00,0,'',14.90,14.90,2,'2号桌',49,'','15798036881','',0,1629886222,1629929423,'TRADE_FINISHED','','MjA4ODgxMjIxNzU1MDcwMF8xNjI5ODg2MjIxOTY3Xzk3OA==',14.90),(51,110840102,'T202108261746069849','2021082622001471231425058801','1','alipay',1,2,1629949052,0,'[{\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,5.00,0,'',13.00,18.00,5,'5号桌',50,'','13532838233','',0,1629949052,1629992253,'TRADE_FINISHED','','MjA4ODMwMjE1NTU3MTIzMF8xNjI5OTQ5MDUxOTUzXzAzMA==',13.00),(52,110840102,'T2021082615640070','2021082622001429901418406221','2','alipay',1,2,1629949740,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}, {\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 18, \"name\": \"排骨+（鸡腿、鸡翅）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"排骨拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 3, \"material\": []}, {\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,5.00,0,'',62.00,67.00,4,'4号桌',51,'','13751230918','',0,1629949740,1629992941,'TRADE_FINISHED','','MjA4ODIwMjg5NDQyOTkwMV8xNjI5OTQ5NzQwNTgzXzczOA==',62.00),(53,110840102,'T20210826256984310','2021082622001476681414423217','3','alipay',1,2,1629949915,0,'[{\"fee\": 13, \"name\": \"肉饼饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}, {\"fee\": 3, \"name\": \"咸鸭蛋\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 18, \"material\": []}]',0.00,0.00,2.00,0,'',14.00,16.00,6,'6号桌',52,'','13538688221','',0,1629949915,1629993116,'TRADE_FINISHED','','MjA4ODgyMjg1MzE3NjY4MF8xNjI5OTQ5OTE0NTY3XzAwMg==',14.00),(54,110840102,'T202108261370331035','2021082622001486591414612515','4','alipay',1,2,1629949923,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,2.00,0,'',14.00,16.00,6,'6号桌',53,'','15989921674','',0,1629949923,1629993124,'TRADE_FINISHED','','MjA4ODIxMjE1MjM4NjU5NF8xNjI5OTQ5OTI0MTQ3XzIxMg==',14.00),(55,110840102,'T202108261357033359','2021082622001426081422243867','5','alipay',1,2,1629950182,0,'[{\"fee\": 2, \"name\": \"可乐\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 14, \"material\": []}, {\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,5.00,0,'',12.00,17.00,2,'2号桌',54,'','15392269773','',0,1629950183,1629993383,'TRADE_FINISHED','','MjA4ODcyMjUxMjMyNjA4Ml8xNjI5OTUwMTgyMDc3XzkzMg==',12.00),(56,110840102,'T20210826848586947','2021082622001445311423683014','6','alipay',1,2,1629950505,0,'[{\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,1,'1号桌',25,'','15918747451','',0,1629950505,1629993706,'TRADE_FINISHED','','MjA4ODgwMjMyMTQ0NTMxNV8xNjI5OTUwNTA0NTIxXzAyMg==',15.00),(57,110840102,'T202108261474591620','2021082622001499271418836974','7','alipay',1,2,1629950589,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,1,'1号桌',55,'','13728168527','',0,1629950589,1629993790,'TRADE_FINISHED','','MjA4ODkyMjg1MDc5OTI3NF8xNjI5OTUwNTg5MTAyXzA1Mg==',16.00),(58,110840102,'T202108261316151380','2021082622001422911433525677','8','alipay',1,2,1629950604,0,'[{\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼排骨\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,1,'1号桌',56,'','13925559681','',0,1629950604,1629993805,'TRADE_FINISHED','','MjA4ODAxMjk3NTAyMjkxMl8xNjI5OTUwNjAzNDY1XzA4NQ==',15.00),(59,110840102,'T20210826970125474','2021082622001420591417037402','9','alipay',1,2,1629950705,0,'[{\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,5.00,0,'',10.00,15.00,5,'5号桌',57,'','13242970852','',0,1629950705,1629993906,'TRADE_FINISHED','','MjA4ODgyMjEwOTMyMDU5NV8xNjI5OTUwNzAzMzgxXzMzNA==',10.00),(60,110840102,'T202108261854547414','2021082622001486591413863616','10','alipay',1,3,1629950896,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼排骨\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,6,'6号桌',53,'','15989921674','',0,1629950896,1629994097,'TRADE_FINISHED','','MjA4ODIxMjE1MjM4NjU5NF8xNjI5OTUwODk3MTc1Xzc1Ng==',16.00),(61,110840102,'T202108261012159081','wx26121039308454796846e6c4f94f720000','11','wxpay',1,2,1629951038,0,'[{\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,5,'5号桌',58,'','13662937812','',0,1629951038,1629994239,'TRADE_FINISHED','','',15.00),(62,110840102,'T202108261776147900','wx261211570806441e9fa81ebdf88c920000','12','wxpay',1,2,1629951116,0,'[{\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼排骨\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}, {\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',30.00,30.00,7,'7号桌',59,'','13712257146','',0,1629951116,1629994317,'TRADE_FINISHED','','',30.00),(63,110840102,'T202108261327545859','2021082622001415461415245937','13','alipay',1,2,1629951198,0,'[{\"fee\": 15, \"name\": \"肉饼+(鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 17, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,3,'3号桌',60,'','17817832518','',0,1629951198,1629994399,'TRADE_FINISHED','','MjA4ODQyMjIwNjExNTQ2NV8xNjI5OTUxMTk3Njc0XzA1NQ==',15.00),(64,110840102,'T20210826615451215','2021082622001428811428372119','14','alipay',1,2,1629951257,0,'[{\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,2.00,0,'',16.00,18.00,3,'3号桌',22,'','18773931352','',0,1629951258,1629994458,'TRADE_FINISHED','','MjA4ODgwMjM0NDkyODgxMV8xNjI5OTUxMjU3NDYzXzAzNw==',16.00),(65,110840102,'T20210826816290404','2021082622001438261418170611','15','alipay',1,2,1629951312,0,'[{\"fee\": 13, \"name\": \"肉饼饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,2.00,0,'',11.00,13.00,3,'3号桌',61,'','18028277791','',0,1629951313,1629994513,'TRADE_FINISHED','','MjA4ODEyMjg2MDczODI2NV8xNjI5OTUxMzEyMjk1XzA0NQ==',11.00),(66,110840102,'T202108261103955967','2021082622001483631416016387','16','alipay',1,2,1629951367,0,'[{\"fee\": 16, \"name\": \"牛肉丸饼+(米粉/河粉/面)\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉丸饼米粉\"}], \"sku_id\": 0, \"food_id\": 24, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,2,'2号桌',62,'','13925534448','',0,1629951367,1629994568,'TRADE_FINISHED','','MjA4ODIxMjA0NDg4MzYzNV8xNjI5OTUxMzY2NTIxXzU5OQ==',16.00),(67,110840102,'T20210826760679443','2021082622001461751416876703','17','alipay',1,2,1629952041,0,'[{\"fee\": 15, \"name\": \"腊味饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 9, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,11,'11号桌',26,'','13602300800','',0,1629952042,1629995242,'TRADE_FINISHED','','MjA4ODkwMjExNDM2MTc1MV8xNjI5OTUyMDQzMjcyXzM3Mw==',15.00),(68,110840102,'T20210826320652650','2021082622001464701413030460','18','alipay',1,2,1629952460,0,'[{\"fee\": 16, \"name\": \"腊味+（鸡腿、鸡翅、牛肉、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,5.00,0,'',11.00,16.00,6,'6号桌',63,'','13925810953','',0,1629952460,1629995661,'TRADE_FINISHED','','MjA4ODYxMjA3OTk2NDcwNV8xNjI5OTUyNDYxNzE3XzkwMQ==',11.00),(69,110840102,'T202108261283735741','2021082622001414811432445555','19','alipay',1,2,1629952538,0,'[{\"fee\": 18, \"name\": \"牛肉+（鸡腿、鸡翅、排骨）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡翅\"}], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,1,'1号桌',64,'','13356458980','',0,1629952538,1629995739,'TRADE_FINISHED','','MjA4ODQyMjg4ODgxNDgxMF8xNjI5OTUyNTM3ODA2XzYwNQ==',18.00),(70,110840102,'T2021082685066541','2021082622001483631415385642','20','alipay',1,2,1629953097,0,'[{\"fee\": 2, \"name\": \"可乐\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 14, \"material\": []}, {\"fee\": 16, \"name\": \"牛肉丸饼+(米粉/河粉/面)\", \"count\": 1, \"tasty\": [{\"attr_key\": \"规格\", \"attr_value\": \"牛肉丸饼米粉\"}], \"sku_id\": 0, \"food_id\": 24, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,2,'2号桌',62,'','13925534448','',0,1629953097,1629996298,'TRADE_FINISHED','','MjA4ODIxMjA0NDg4MzYzNV8xNjI5OTUzMDk3MTI3XzczMg==',18.00),(71,110840102,'T20210827830886352','2021082722001486591415448913','1','alipay',1,2,1630036533,0,'[{\"fee\": 16, \"name\": \"腊味鸡腿饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 31, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,2,'2号桌',53,'','15989921674','',0,1630036533,1630079734,'TRADE_FINISHED','','MjA4ODIxMjE1MjM4NjU5NF8xNjMwMDM2NTMyOTYxXzgzNQ==',16.00),(72,110840102,'T202108271558216584','wx271155569882897540543d968d95210000','2','wxpay',1,2,1630036556,0,'[{\"fee\": 15, \"name\": \"肉饼鸡翅饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 27, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,2,'2号桌',52,'','13538688221','',0,1630036556,1630079757,'TRADE_FINISHED','','',15.00),(73,110840102,'T202108271085614704','2021082722001466421416605744','3','alipay',1,2,1630036563,0,'[{\"fee\": 15, \"name\": \"肉饼鸡翅饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 27, \"material\": []}]',0.00,0.00,5.00,0,'',10.00,15.00,2,'2号桌',65,'','13790262776','',0,1630036563,1630079764,'TRADE_FINISHED','','MjA4ODYwMjI5MzU2NjQyM18xNjMwMDM2NTYyNzY4XzA5MQ==',10.00),(74,110840102,'T202108272030464312','wx27115747113341ea2af42af39dfb700000','4','wxpay',1,2,1630036666,0,'[{\"fee\": 18, \"name\": \"牛肉鸡腿饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 35, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,2,'2号桌',66,'','13560877200','',0,1630036666,1630079867,'TRADE_FINISHED','','',18.00),(75,110840102,'T20210827708297855','wx27120741173499c48a9f298a717d950000','5','wxpay',1,2,1630037260,0,'[{\"fee\": 15, \"name\": \"肉饼牛肉饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 29, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,4,'4号桌',21,'','13424832721','',0,1630037260,1630080461,'TRADE_FINISHED','','',15.00),(76,110840102,'T20210827131270101','wx27120753529050f5e8f811eb6b80220000','6','wxpay',1,2,1630037273,0,'[{\"fee\": 16, \"name\": \"腊味牛肉饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 33, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,4,'4号桌',20,'','18575391363','',0,1630037273,1630080474,'TRADE_FINISHED','','',16.00),(77,110840102,'T202108271832723968','wx271207595320329a9d8f7f910eafcd0000','7','wxpay',1,2,1630037279,0,'[{\"fee\": 10.9, \"name\": \"腊味饭「今日特价10.9」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 40, \"material\": []}]',0.00,0.00,0.00,0,'',10.90,10.90,6,'6号桌',67,'','15913771299','',0,1630037279,1630080480,'TRADE_FINISHED','','',10.90),(78,110840102,'T20210827228095167','2021082722001417161425937810','8','alipay',1,2,1630037321,0,'[{\"fee\": 14, \"name\": \"冬菇鸡\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 8, \"material\": []}]',0.00,0.00,0.00,0,'',14.00,14.00,6,'6号桌',68,'','15207625657','',0,1630037321,1630080523,'TRADE_FINISHED','','MjA4ODYyMjc1OTQxNzE2MF8xNjMwMDM3MzIwMTczXzg3NQ==',14.00),(79,110840102,'T202108271098419266','2021082722001411171430801841','9','alipay',1,2,1630037383,0,'[{\"fee\": 13, \"name\": \"肉饼饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}, {\"fee\": 10.9, \"name\": \"腊味饭「今日特价10.9」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 40, \"material\": []}]',0.00,0.00,0.00,0,'',23.90,23.90,5,'5号桌',39,'','13332648195','',0,1630037384,1630080584,'TRADE_FINISHED','','MjA4ODMxMjU0NTIxMTE3Ml8xNjMwMDM3Mzg0NDk5XzcxMA==',23.90),(80,110840102,'T20210827979509313','wx271220356606876ddc1ffbec7ac1750000','10','wxpay',1,2,1630038035,0,'[{\"fee\": 13, \"name\": \"肉饼饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 7, \"material\": []}]',0.00,0.00,0.00,0,'',13.00,13.00,1,'1号桌',69,'','13858488610','',0,1630038035,1630081236,'TRADE_FINISHED','','',13.00),(81,110840102,'T202108271241387559','2021082722001442181431351132','11','alipay',1,2,1630066416,0,'[{\"fee\": 15, \"name\": \"腊味饭\", \"count\": 2, \"tasty\": [], \"sku_id\": 0, \"food_id\": 9, \"material\": []}, {\"fee\": 2, \"name\": \"怡宝\", \"count\": 3, \"tasty\": [], \"sku_id\": 0, \"food_id\": 12, \"material\": []}, {\"fee\": 18, \"name\": \"牛肉鸡腿饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 35, \"material\": []}]',0.00,0.00,5.00,0,'',49.00,54.00,4,'4号桌',70,'','18890289601','',0,1630066416,1630109617,'TRADE_FINISHED','','MjA4ODkwMjAyMzI0MjE4NV8xNjMwMDY2NDE2MDA3XzA3MQ==',49.00),(82,110840102,'T20210827467755916','2021082722001459701410230381','12','alipay',1,2,1630067639,0,'[{\"fee\": 18, \"name\": \"牛肉鸡翅饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 36, \"material\": []}]',0.00,0.00,2.00,0,'',16.00,18.00,5,'5号桌',71,'','13978106494','',0,1630067640,1630110840,'TRADE_FINISHED','','MjA4ODYwMjI0MzQ1OTcwMl8xNjMwMDY3NjQwMTc3XzU5Ng==',16.00),(83,110840102,'T20210827500542568','2021082722001481911434397259','13','alipay',1,2,1630068419,0,'[{\"fee\": 18, \"name\": \"排骨鸡腿饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 38, \"material\": []}]',0.00,0.00,4.00,0,'',14.00,18.00,6,'6号桌',72,'','19864158630','',0,1630068419,1630111620,'TRADE_FINISHED','','MjA4ODIzMjk5NTQ4MTkxMV8xNjMwMDY4NDE4NDE3XzM2MQ==',14.00),(84,110840102,'T20210827209219654','2021082722001481911434330006','','alipay',1,2,1630068472,0,'[{\"fee\": 8, \"name\": \"牛肉丸饼汤\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 22, \"material\": []}]',0.00,0.00,0.00,0,'',8.00,8.00,6,'6号桌',72,'','19864158630','',0,1630068472,0,'TRADE_CLOSED','','MjA4ODIzMjk5NTQ4MTkxMV8xNjMwMDY4NDcxODIyXzM2MA==',0.00),(85,110840102,'T202108281579698112','wx28101555631460f7c7cd30ee55bf990000','1','wxpay',1,2,1630116955,0,'[{\"fee\": 15, \"name\": \"肉饼牛肉饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 29, \"material\": []}]',0.00,0.00,0.00,0,'',15.00,15.00,2,'2号桌',73,'','15348659589','',0,1630116955,1630160156,'TRADE_FINISHED','','',15.00),(86,110840102,'T20210828170495412','2021082822001408811427688631','2','alipay',1,2,1630123870,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 26, \"material\": []}]',0.00,0.00,2.00,0,'',13.00,15.00,2,'2号桌',74,'','13612737376','',0,1630123870,1630167071,'TRADE_FINISHED','','MjA4ODExMjMzMDcwODgxNl8xNjMwMTIzODY5Nzk2XzA3MQ==',13.00),(87,110840102,'T202108281741016842','2021082822001475791422276048','3','alipay',1,2,1630123883,0,'[{\"fee\": 15, \"name\": \"肉饼鸡腿饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 26, \"material\": []}]',0.00,0.00,5.00,0,'',10.00,15.00,2,'2号桌',75,'','13414605805','',0,1630123883,1630167084,'TRADE_FINISHED','','MjA4ODIxMjU5OTY3NTc5Ml8xNjMwMTIzODgxNjE0XzI3Mw==',10.00),(88,110840102,'T20210828247611829','2021082822001485041425061517','4','alipay',1,2,1630124017,0,'[{\"fee\": 18, \"name\": \"牛肉鸡腿饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 35, \"material\": []}]',0.00,0.00,5.00,0,'',13.00,18.00,6,'6号桌',77,'','13790444010','',0,1630124017,1630167218,'TRADE_FINISHED','','MjA4ODcxMjMxMDk4NTA0NF8xNjMwMTI0MDE1NzM1Xzk4Ng==',13.00),(89,110840102,'T202108281305441327','wx281213385742322295a23a3c8fc7050000','','wxpay',1,2,1630124018,0,'[{\"fee\": 18, \"name\": \"牛肉排骨饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 37, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,6,'6号桌',76,'','17707997420','',0,1630124018,0,'TRADE_CLOSED','','',0.00),(90,110840102,'T20210828802072937','2021082822001427161426440533','5','alipay',1,2,1630124211,0,'[{\"fee\": 18, \"name\": \"牛肉排骨饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 37, \"material\": []}]',0.00,0.00,5.00,0,'',13.00,18.00,6,'6号桌',76,'','17707997420','',0,1630124211,1630167412,'TRADE_FINISHED','','MjA4ODEyMjY1NzQyNzE2MV8xNjMwMTI0MjA4NTk1XzU4NQ==',13.00),(91,110840102,'T20210830141070005','2021083022001408811429862167','1','alipay',1,2,1630296544,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「每周一特价」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 41, \"material\": []}]',0.00,0.00,1.00,0,'',8.90,9.90,6,'6号桌',74,'','13612737376','',0,1630296544,1630339745,'TRADE_FINISHED','','MjA4ODExMjMzMDcwODgxNl8xNjMwMjk2NTQzNjA2XzAzNA==',8.90),(92,110840102,'T20210830366955244','2021083022001411171433296924','2','alipay',1,2,1630296546,0,'[{\"fee\": 14, \"name\": \"冬菇鸡\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 8, \"material\": []}, {\"fee\": 9.9, \"name\": \"肉饼饭「每周一特价」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 41, \"material\": []}]',0.00,0.00,0.00,0,'',23.90,23.90,5,'5号桌',39,'','13332648195','',0,1630296546,1630339747,'TRADE_FINISHED','','MjA4ODMxMjU0NTIxMTE3Ml8xNjMwMjk2NTQ1NDM1XzgxOA==',23.90),(93,110840102,'T20210830720324729','2021083022001470281431289229','4','alipay',1,2,1630296562,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「每周一特价」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 41, \"material\": []}]',0.00,0.00,0.00,0,'',9.90,9.90,6,'6号桌',24,'','13650345025','',0,1630296562,1630339763,'TRADE_FINISHED','','MjA4ODIyMjA3MTk3MDI4Ml8xNjMwMjk2NTYyNDc1XzcyOQ==',9.90),(94,110840102,'T202108301775794931','2021083022001432911436735985','3','alipay',1,2,1630296563,0,'[{\"fee\": 9.9, \"name\": \"肉饼饭「每周一特价」\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 41, \"material\": []}]',0.00,0.00,0.00,0,'',9.90,9.90,6,'6号桌',23,'','13713296514','',0,1630296563,1630339765,'TRADE_FINISHED','','MjA4ODAyMjAwNDczMjkxOF8xNjMwMjk2NTYzNzcyXzk4MQ==',9.90),(95,110840102,'T202108301147295799','wx3012160670252957ec73f1b8bcf5840000','5','wxpay',1,2,1630296966,0,'[{\"fee\": 15, \"name\": \"腊味饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 9, \"material\": []}, {\"fee\": 15, \"name\": \"剁椒鱼\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 20, \"material\": []}]',0.00,0.00,0.00,0,'',30.00,30.00,3,'3号桌',78,'','13827848469','',0,1630296966,1630340167,'TRADE_FINISHED','','',30.00),(96,110840102,'T202108301688568781','2021083022001402381429633490','6','alipay',1,2,1630297811,0,'[{\"fee\": 15, \"name\": \"肉饼排骨饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 30, \"material\": []}]',0.00,0.00,2.00,0,'',13.00,15.00,1,'1号桌',79,'','15907513582','',0,1630297811,1630341012,'TRADE_FINISHED','','MjA4ODkwMjAwMDgwMjM4OF8xNjMwMjk3ODEwMDczXzM1MA==',13.00),(97,110840102,'T202108301887985119','2021083022001446251420560284','7','alipay',1,2,1630297932,0,'[{\"fee\": 15, \"name\": \"肉饼鸡翅饭\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 27, \"material\": []}]',0.00,0.00,2.00,0,'',13.00,15.00,1,'1号桌',80,'','13113180879','',0,1630297932,1630341133,'TRADE_FINISHED','','MjA4ODYwMjI3NzU0NjI1NF8xNjMwMjk3OTMxNjExXzk2MQ==',13.00);
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
  `food_thumbnail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品缩略图',
  `alipay_material_id` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '阿里素材标识',
  `food_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品名称',
  `sku_id` int(11) NOT NULL COMMENT '所属食物规格id',
  `sku_detail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '规格详情',
  `food_remark` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '最终拼接详情',
  `use_member` tinyint(3) NOT NULL COMMENT '是否启用菜品会员价',
  `member_price` decimal(9,2) NOT NULL COMMENT '菜品会员价',
  `count` int(11) NOT NULL COMMENT '购买数量',
  `material` json NOT NULL COMMENT '加料',
  `tasty` json NOT NULL COMMENT '口味',
  `dish_type` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品类型',
  `flavor` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品口味',
  `cooking_method` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜品做法',
  `price` decimal(9,2) NOT NULL COMMENT '菜品单价',
  `total` decimal(9,2) NOT NULL COMMENT '菜品总价',
  `box_fee` decimal(9,2) NOT NULL COMMENT '餐盒费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_detail`
--

LOCK TABLES `cmf_food_order_detail` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_detail` DISABLE KEYS */;
INSERT INTO `cmf_food_order_detail` VALUES (1,'12','T2021072163409145',12,'','','怡宝',0,'','',0,0.00,1,'{}','[]','','','',2.00,2.00,0.00),(2,'13','T2021072163409145',13,'','','雪碧',0,'','',0,0.00,1,'{}','[]','','','',5.00,5.00,0.00),(3,'17','T20210721956041406',17,'','','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(4,'17','T202107212131343464',17,'','','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}]','','','',15.00,15.00,0.00),(5,'17','T20210822991834936',17,'tenant/110840102/20210822/757aed83d838a0c73fba447ab1e91f4e.png','2021082200502200000017272909','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}]','','','',15.00,15.00,0.00),(6,'2','T202108231897228444',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡翅\"}]','','','',18.00,18.00,0.00),(7,'7','T20210823439171954',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082200502200000017282490','肉饼饭',0,'','',0,0.00,1,'{}','[]','','','',13.00,13.00,0.00),(8,'7','T20210823646928682',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082200502200000017282490','肉饼饭',0,'','',0,0.00,1,'{}','[]','','','',13.00,13.00,0.00),(9,'7','T20210824938599688',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(10,'7','T20210824942076642',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(11,'7','T20210824242225933',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(12,'7','T20210824365048888',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(13,'7','T202108242066503011',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(14,'7','T20210824363757109',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(15,'7','T20210824306157354',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(16,'xyd','T20210824306157354',18,'tenant/110840102/20210822/4f887ed2120311b6d6cedb2873cc28ea.jpg','2021082200502200000017274258','咸鸭蛋',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(17,'7','T20210824790073749',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(18,'17','T20210824687575927',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}]','','','',15.00,15.00,0.00),(19,'20','T20210824392645315',20,'tenant/110840102/20210822/77bdcc1d237ebc004accdf91df05827b.jpeg','2021082200502200000017280340','剁椒鱼',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(20,'2','T20210824711974219',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼排骨\"}]','','','',18.00,18.00,0.00),(21,'20','T20210824711974219',20,'tenant/110840102/20210822/77bdcc1d237ebc004accdf91df05827b.jpeg','2021082200502200000017280340','剁椒鱼',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(22,'7','T202108241719764452',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(23,'17','T20210824453267112',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}]','','','',15.00,15.00,0.00),(24,'7','T20210824865252216',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(25,'17','T20210824229739915',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}]','','','',15.00,15.00,0.00),(26,'7','T202108241987737321',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,2,'{}','[]','','','',9.90,19.80,0.00),(27,'7','T202108242136819652',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(28,'7','T202108242007613382',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(29,'14','T202108242007613382',14,'tenant/110840102/20210822/9f010b34a182c0eeec15cf5320f76a14.jpeg','2021082200502200000017277839','可乐',0,'','',0,0.00,1,'{}','[]','','','',2.00,2.00,0.00),(30,'7','T20210824474690130',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(31,'1','T202108241499317886',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}]','','','',16.00,16.00,0.00),(32,'2','T202108241499317886',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}]','','','',18.00,18.00,0.00),(33,'6','T202108241499317886',6,'tenant/110840102/20210822/6056073c8973a587e708f08c7f37b919.jpg','2021082200502200000017274758','鸡翅',0,'','',0,0.00,1,'{}','[]','','','',6.00,6.00,0.00),(34,'15','T202108241499317886',15,'tenant/110840102/20210822/09265a1bbb7b46acb09115d250a1e653.jpeg','','维他奶',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"原味\"}]','','','',3.00,3.00,0.00),(35,'15','T202108241499317886',15,'tenant/110840102/20210822/09265a1bbb7b46acb09115d250a1e653.jpeg','','维他奶',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"巧克力味\"}]','','','',3.00,3.00,0.00),(36,'7','T202108242051366201',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(37,'7','T202108241982483967',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(38,'7','T20210824465021080',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(39,'4','T20210824687560791',4,'tenant/110840102/20210822/d5fcf67b9a29e25cbec52f5d1f4f89b9.jpeg','2021082200502200000017280896','腊肠',0,'','',0,0.00,1,'{}','[]','','','',4.00,4.00,0.00),(40,'7','T20210824687560791',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(41,'7','T202108242018599104',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','2021082300502200000017503714','肉饼饭「周一二特价9.9元」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(42,'17','T2021082432919420',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}]','','','',15.00,15.00,0.00),(43,'1','T20210824227713903',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}]','','','',16.00,16.00,0.00),(44,'1','T202108251290611858',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}]','','','',16.00,16.00,0.00),(45,'1','T202108251379880381',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}]','','','',16.00,16.00,0.00),(46,'1','T202108251066600948',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}]','','','',16.00,16.00,0.00),(47,'1','T202108252100749852',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}]','','','',16.00,16.00,0.00),(48,'1','T202108252100749852',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡腿\"}]','','','',16.00,16.00,0.00),(49,'17','T202108251533780306',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡翅\"}]','','','',15.00,15.00,0.00),(50,'17','T202108251226485806',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼排骨\"}]','','','',15.00,15.00,0.00),(51,'1','T202108251127844673',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}]','','','',16.00,16.00,0.00),(52,'17','T20210825986468754',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}]','','','',15.00,15.00,0.00),(53,'17','T202108252109453331',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','2021082200502200000017281090','肉饼鸡腿超值套餐',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼腊味\"}]','','','',15.00,15.00,0.00),(54,'1','T202108251061355095',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼排骨\"}]','','','',16.00,16.00,0.00),(55,'2','T20210825302767742',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}]','','','',18.00,18.00,0.00),(56,'11','T202108252018901673',11,'tenant/110840102/20210822/e49be5bad96007b0ac11732fc512d86c.jpeg','','排骨饭「周三特价14.9」',0,'','',0,0.00,1,'{}','[]','','','',14.90,14.90,0.00),(57,'11','T202108251133349336',11,'tenant/110840102/20210822/e49be5bad96007b0ac11732fc512d86c.jpeg','','排骨饭「周三特价14.9」',0,'','',0,0.00,1,'{}','[]','','','',14.90,14.90,0.00),(58,'11','T202108251834374528',11,'tenant/110840102/20210822/e49be5bad96007b0ac11732fc512d86c.jpeg','','排骨饭「周三特价14.9」',0,'','',0,0.00,2,'{}','[]','','','',14.90,29.80,0.00),(59,'24','T202108251191575964',24,'tenant/110840102/20210822/14651f5f485a5175b0fd22b4158a28ef.jpeg','2021082200502200000017281624','牛肉丸饼+(米粉/河粉/面)',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉丸饼面\"}]','','','',16.00,16.00,0.00),(60,'11','T20210825499680086',11,'tenant/110840102/20210822/e49be5bad96007b0ac11732fc512d86c.jpeg','','排骨饭「周三特价14.9」',0,'','',0,0.00,1,'{}','[]','','','',14.90,14.90,0.00),(61,'2','T202108261746069849',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}]','','','',18.00,18.00,0.00),(62,'1','T2021082615640070',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡翅\"}]','','','',16.00,16.00,0.00),(63,'2','T2021082615640070',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}]','','','',18.00,18.00,0.00),(64,'3','T2021082615640070',3,'tenant/110840102/20210822/6b4be9776fbb78bf6bfc05389bb58977.jpeg','2021082200502200000017281566','排骨+（鸡腿、鸡翅）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"排骨拼鸡腿\"}]','','','',18.00,18.00,0.00),(65,'17','T2021082615640070',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡翅\"}]','','','',15.00,15.00,0.00),(66,'7','T20210826256984310',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭',0,'','',0,0.00,1,'{}','[]','','','',13.00,13.00,0.00),(67,'xyd','T20210826256984310',18,'tenant/110840102/20210822/4f887ed2120311b6d6cedb2873cc28ea.jpg','2021082200502200000017274258','咸鸭蛋',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(68,'1','T202108261370331035',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼鸡腿\"}]','','','',16.00,16.00,0.00),(69,'14','T202108261357033359',14,'tenant/110840102/20210822/9f010b34a182c0eeec15cf5320f76a14.jpeg','2021082200502200000017277839','可乐',0,'','',0,0.00,1,'{}','[]','','','',2.00,2.00,0.00),(70,'17','T202108261357033359',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}]','','','',15.00,15.00,0.00),(71,'17','T20210826848586947',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}]','','','',15.00,15.00,0.00),(72,'1','T202108261474591620',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}]','','','',16.00,16.00,0.00),(73,'17','T202108261316151380',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼排骨\"}]','','','',15.00,15.00,0.00),(74,'17','T20210826970125474',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}]','','','',15.00,15.00,0.00),(75,'1','T202108261854547414',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼排骨\"}]','','','',16.00,16.00,0.00),(76,'17','T202108261012159081',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼牛肉\"}]','','','',15.00,15.00,0.00),(77,'17','T202108261776147900',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼排骨\"}]','','','',15.00,15.00,0.00),(78,'17','T202108261776147900',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}]','','','',15.00,15.00,0.00),(79,'17','T202108261327545859',17,'tenant/110840102/20210822/9bc284bffb142df8cb769b786b0865a8.jpeg','','肉饼+(鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"肉饼拼鸡腿\"}]','','','',15.00,15.00,0.00),(80,'2','T20210826615451215',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡腿\"}]','','','',18.00,18.00,0.00),(81,'7','T20210826816290404',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭',0,'','',0,0.00,1,'{}','[]','','','',13.00,13.00,0.00),(82,'24','T202108261103955967',24,'tenant/110840102/20210822/14651f5f485a5175b0fd22b4158a28ef.jpeg','2021082200502200000017281624','牛肉丸饼+(米粉/河粉/面)',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉丸饼米粉\"}]','','','',16.00,16.00,0.00),(83,'9','T20210826760679443',9,'tenant/110840102/20210822/447a97f7f315e03f79152772378ecbf4.jpeg','2021082200502200000017279924','腊味饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(84,'1','T20210826320652650',1,'tenant/110840102/20210822/eb7af90a83285b7945f1b2a498454317.jpeg','2021082200502200000017281105','腊味+（鸡腿、鸡翅、牛肉、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"腊味拼牛肉\"}]','','','',16.00,16.00,0.00),(85,'2','T202108261283735741',2,'tenant/110840102/20210822/125230ba0226f3069fdd0d455b04a96b.jpeg','2021082200502200000017281502','牛肉+（鸡腿、鸡翅、排骨）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉拼鸡翅\"}]','','','',18.00,18.00,0.00),(86,'14','T2021082685066541',14,'tenant/110840102/20210822/9f010b34a182c0eeec15cf5320f76a14.jpeg','2021082200502200000017277839','可乐',0,'','',0,0.00,1,'{}','[]','','','',2.00,2.00,0.00),(87,'24','T2021082685066541',24,'tenant/110840102/20210822/14651f5f485a5175b0fd22b4158a28ef.jpeg','2021082200502200000017281624','牛肉丸饼+(米粉/河粉/面)',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"规格\", \"attr_value\": \"牛肉丸饼米粉\"}]','','','',16.00,16.00,0.00),(88,'31','T20210827830886352',31,'tenant/110840102/20210826/9d1120a803a745d9a868ebad49346180.jpeg','2021082600502200000018110687','腊味鸡腿饭',0,'','',0,0.00,1,'{}','[]','','','',16.00,16.00,0.00),(89,'27','T202108271558216584',27,'tenant/110840102/20210826/a2eea0713cd10a21c7688ad264b645d7.jpeg','','肉饼鸡翅饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(90,'27','T202108271085614704',27,'tenant/110840102/20210826/a2eea0713cd10a21c7688ad264b645d7.jpeg','','肉饼鸡翅饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(91,'35','T202108272030464312',35,'tenant/110840102/20210826/2a14073a6de00cb64e25e25740c45bf7.jpeg','2021082600502200000018111090','牛肉鸡腿饭',0,'','',0,0.00,1,'{}','[]','','','',18.00,18.00,0.00),(92,'29','T20210827708297855',29,'tenant/110840102/20210826/e8cd32591fa9f0de02ed87541b289871.jpeg','2021082600502200000018109959','肉饼牛肉饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(93,'33','T20210827131270101',33,'tenant/110840102/20210826/3785f81ccbc11eb67d318a3eb57beb6a.jpeg','2021082600502200000018110990','腊味牛肉饭',0,'','',0,0.00,1,'{}','[]','','','',16.00,16.00,0.00),(94,'40','T202108271832723968',40,'tenant/110840102/20210827/0eea951081330e763c7529640b1a9229.jpeg','2021082700502200000018262310','腊味饭「今日特价10.9」',0,'','',0,0.00,1,'{}','[]','','','',10.90,10.90,0.00),(95,'8','T20210827228095167',8,'tenant/110840102/20210822/dfcc0f187a33cd6a6e5c457d1a55e31a.jpeg','2021082200502200000017279875','冬菇鸡',0,'','',0,0.00,1,'{}','[]','','','',14.00,14.00,0.00),(96,'7','T202108271098419266',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭',0,'','',0,0.00,1,'{}','[]','','','',13.00,13.00,0.00),(97,'40','T202108271098419266',40,'tenant/110840102/20210827/0eea951081330e763c7529640b1a9229.jpeg','2021082700502200000018262310','腊味饭「今日特价10.9」',0,'','',0,0.00,1,'{}','[]','','','',10.90,10.90,0.00),(98,'7','T20210827979509313',7,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭',0,'','',0,0.00,1,'{}','[]','','','',13.00,13.00,0.00),(99,'9','T202108271241387559',9,'tenant/110840102/20210822/447a97f7f315e03f79152772378ecbf4.jpeg','2021082200502200000017279924','腊味饭',0,'','',0,0.00,2,'{}','[]','','','',15.00,30.00,0.00),(100,'12','T202108271241387559',12,'tenant/110840102/20210822/42aca57b7ad77ecb609c6abce3129dfd.png','2021082200502200000017283064','怡宝',0,'','',0,0.00,3,'{}','[]','','','',2.00,6.00,0.00),(101,'35','T202108271241387559',35,'tenant/110840102/20210826/2a14073a6de00cb64e25e25740c45bf7.jpeg','2021082600502200000018111090','牛肉鸡腿饭',0,'','',0,0.00,1,'{}','[]','','','',18.00,18.00,0.00),(102,'36','T20210827467755916',36,'tenant/110840102/20210826/7dc10cea56a17ab3a5814e4d24afc9ed.jpeg','2021082600502200000018112322','牛肉鸡翅饭',0,'','',0,0.00,1,'{}','[]','','','',18.00,18.00,0.00),(103,'38','T20210827500542568',38,'tenant/110840102/20210826/f981b34851af84bc756b5317fea3861c.jpeg','','排骨鸡腿饭',0,'','',0,0.00,1,'{}','[]','','','',18.00,18.00,0.00),(104,'22','T20210827209219654',22,'tenant/110840102/20210822/eca3623ee1373059e40865f5c94e4451.jpeg','2021082200502200000017280096','牛肉丸饼汤',0,'','',0,0.00,1,'{}','[]','','','',8.00,8.00,0.00),(105,'29','T202108281579698112',29,'tenant/110840102/20210826/e8cd32591fa9f0de02ed87541b289871.jpeg','2021082600502200000018109959','肉饼牛肉饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(106,'26','T20210828170495412',26,'tenant/110840102/20210826/f46c01489924377f495b951237b96871.jpeg','','肉饼鸡腿饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(107,'26','T202108281741016842',26,'tenant/110840102/20210826/f46c01489924377f495b951237b96871.jpeg','','肉饼鸡腿饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(108,'35','T20210828247611829',35,'tenant/110840102/20210826/2a14073a6de00cb64e25e25740c45bf7.jpeg','','牛肉鸡腿饭',0,'','',0,0.00,1,'{}','[]','','','',18.00,18.00,0.00),(109,'37','T202108281305441327',37,'tenant/110840102/20210826/5e75b43b1b9b706d2d10ad0f59fba312.jpeg','2021082600502200000018112566','牛肉排骨饭',0,'','',0,0.00,1,'{}','[]','','','',18.00,18.00,0.00),(110,'37','T20210828802072937',37,'tenant/110840102/20210826/5e75b43b1b9b706d2d10ad0f59fba312.jpeg','2021082600502200000018112566','牛肉排骨饭',0,'','',0,0.00,1,'{}','[]','','','',18.00,18.00,0.00),(111,'41','T20210830141070005',41,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭「每周一特价」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(112,'8','T20210830366955244',8,'tenant/110840102/20210822/dfcc0f187a33cd6a6e5c457d1a55e31a.jpeg','2021082200502200000017279875','冬菇鸡',0,'','',0,0.00,1,'{}','[]','','','',14.00,14.00,0.00),(113,'41','T20210830366955244',41,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭「每周一特价」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(114,'41','T20210830720324729',41,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭「每周一特价」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(115,'41','T202108301775794931',41,'tenant/110840102/20210822/22bac5269114aa503b6f7b93470648bd.jpeg','','肉饼饭「每周一特价」',0,'','',0,0.00,1,'{}','[]','','','',9.90,9.90,0.00),(116,'9','T202108301147295799',9,'tenant/110840102/20210822/447a97f7f315e03f79152772378ecbf4.jpeg','2021082200502200000017279924','腊味饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(117,'20','T202108301147295799',20,'tenant/110840102/20210822/77bdcc1d237ebc004accdf91df05827b.jpeg','2021082200502200000017280340','剁椒鱼',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(118,'30','T202108301688568781',30,'tenant/110840102/20210826/b8c1dea802d76f512edb67aebb587fce.jpeg','2021082600502200000018110304','肉饼排骨饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00),(119,'27','T202108301887985119',27,'tenant/110840102/20210826/a2eea0713cd10a21c7688ad264b645d7.jpeg','','肉饼鸡翅饭',0,'','',0,0.00,1,'{}','[]','','','',15.00,15.00,0.00);
/*!40000 ALTER TABLE `cmf_food_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_food_order_refund`
--

DROP TABLE IF EXISTS `cmf_food_order_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_food_order_refund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '退款金额',
  `reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退款理由',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_refund`
--

LOCK TABLES `cmf_food_order_refund` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_food_order_refund` ENABLE KEYS */;
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
  `default_inventory` int(11) DEFAULT NULL COMMENT '默认库存',
  `use_member` tinyint(3) NOT NULL COMMENT '是否启用菜品会员价',
  `member_price` decimal(9,2) NOT NULL COMMENT '菜品会员价',
  `original_price` decimal(9,2) NOT NULL COMMENT '菜品原价',
  `price` decimal(9,2) NOT NULL COMMENT '规格售价',
  `volume` int(11) DEFAULT NULL COMMENT '销量',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规格备注',
  `weight` float DEFAULT NULL COMMENT '重量（kg）',
  PRIMARY KEY (`sku_id`),
  UNIQUE KEY `idx_attr_post` (`attr_post`),
  KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_sku`
--

LOCK TABLES `cmf_food_sku` WRITE;
/*!40000 ALTER TABLE `cmf_food_sku` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_food_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_immediate_delivery`
--

DROP TABLE IF EXISTS `cmf_immediate_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_immediate_delivery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `delivery_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配送公司Id',
  `delivery_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配送公司名称',
  `shopid` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配送公司开发平台app_key',
  `app_key` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配送公司开发平台app_key',
  `app_secret` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配送公司开发平台app_secret',
  `audit_result` tinyint(3) DEFAULT '0' COMMENT '审核状态',
  `is_open` tinyint(3) DEFAULT '0' COMMENT '是否开通物流权限',
  `status` tinyint(3) DEFAULT '0' COMMENT '状态（启用，停用）',
  `is_main` tinyint(3) DEFAULT '0' COMMENT '主配送公司',
  `create_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_immediate_delivery`
--

LOCK TABLES `cmf_immediate_delivery` WRITE;
/*!40000 ALTER TABLE `cmf_immediate_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_immediate_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_immediate_delivery_order`
--

DROP TABLE IF EXISTS `cmf_immediate_delivery_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_immediate_delivery_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `shop_order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流外部订单号',
  `waybill_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流运单编号',
  `delivery_token` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预下单接口token',
  `delivery_id` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '即时配送物流公司代码',
  `delivery_name` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '即时配送物流公司名称',
  `delivery_fee` decimal(7,2) DEFAULT NULL COMMENT '即时配送总费用',
  `delivery_free` decimal(7,2) DEFAULT NULL COMMENT '即时配送优惠费用',
  `buyer_pay_amount` decimal(7,2) DEFAULT NULL COMMENT '即时配送用户在交易中支付的金额',
  `create_at` bigint(20) DEFAULT NULL,
  `order_status` int(11) DEFAULT NULL COMMENT '运输状态',
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_immediate_delivery_order`
--

LOCK TABLES `cmf_immediate_delivery_order` WRITE;
/*!40000 ALTER TABLE `cmf_immediate_delivery_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_immediate_delivery_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_member_card`
--

DROP TABLE IF EXISTS `cmf_member_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_member_card` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_member_card`
--

LOCK TABLES `cmf_member_card` WRITE;
/*!40000 ALTER TABLE `cmf_member_card` DISABLE KEYS */;
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
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `vip_num` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员号',
  `trade_no` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝订单号',
  `vip_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员名称',
  `vip_level` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '会员等级',
  `pay_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方支付类型',
  `fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '合计金额',
  `create_at` bigint(20) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WAIT_BUYER_PAY' COMMENT '订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_member_card_order`
--

LOCK TABLES `cmf_member_card_order` WRITE;
/*!40000 ALTER TABLE `cmf_member_card_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_member_card_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_mp_theme`
--

DROP TABLE IF EXISTS `cmf_mp_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_mp_theme` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '小程序加密编号',
  `category` tinyint(3) NOT NULL DEFAULT '0' COMMENT '小程序类型分类',
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序主题名称',
  `thumbnail` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序缩略图',
  `theme_id` int(11) NOT NULL COMMENT '小程序原主题id',
  `tenant_id` int(11) NOT NULL COMMENT '小程序所属租户id',
  `app_logo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序应用logo图标',
  `app_desc` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序应用描述，20-200个字',
  `style` json DEFAULT NULL COMMENT '主题文件用户公共样式',
  `alipay_exp_qr_code_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝小程序体验版二维码',
  `wechat_exp_qr_code_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信小程序体验版二维码',
  `wechat_qr_code_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信小程序正式版二维码',
  `encrypt_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序接口加密内容',
  `sub_mchid` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '微信支付绑定商户号',
  `create_at` bigint(20) DEFAULT '0' COMMENT '创建时间',
  `update_at` bigint(20) DEFAULT '0' COMMENT '更新时间',
  `list_order` double DEFAULT '10000' COMMENT '排序',
  `delete_at` bigint(20) DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme`
--

LOCK TABLES `cmf_mp_theme` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme` VALUES (1,110840102,0,'来来蒸饭','',1,1926804902,'tenant/110840102/20210716/2d9d98ebe0063ff5fe7ba05fbc8ee0be.jpg','','{}','https://mobilecodec.alipay.com/show.htm?code=s4x15140t2chpctuydy5bba','tenant/110840102/wechat-exp.jpg','tenant/110840102/wechat-qrcode.jpg','AOGU63V5goAxR11F5m8KPg==','1612052077',1626338340,0,10000,0);
/*!40000 ALTER TABLE `cmf_mp_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_mp_theme_admin_user_post`
--

DROP TABLE IF EXISTS `cmf_mp_theme_admin_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_mp_theme_admin_user_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_user_id` bigint(20) NOT NULL COMMENT '管理员用户Id',
  `mid` bigint(20) NOT NULL COMMENT '小程序加密编号',
  `status` tinyint(3) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_admin_user_post`
--

LOCK TABLES `cmf_mp_theme_admin_user_post` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_admin_user_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_mp_theme_admin_user_post` ENABLE KEYS */;
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
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
  `home` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否为首页',
  `title` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '页面名称',
  `file` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '页面路径',
  `style` json DEFAULT NULL COMMENT '主题文件用户公共样式',
  `config_style` json DEFAULT NULL COMMENT '主题文件默认公共样式',
  `more` json DEFAULT NULL COMMENT '主题文件用户配置文件',
  `config_more` json DEFAULT NULL COMMENT '主题文件默认配置文件',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_page`
--

LOCK TABLES `cmf_mp_theme_page` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_page` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_page` VALUES (1,1,110840102,1,'首页','home','{}','{}','[{\"data\": [{\"id\": 11, \"link\": \"\", \"name\": \"\", \"image\": \"https://cdn.mashangdian.cn/tenant/110840102/20210716/af477e2d83673c764d4032d8c19a47b4.jpg!clipper\", \"file_path\": \"tenant/110840102/20210716/af477e2d83673c764d4032d8c19a47b4.jpg\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 10, \"desc\": \"下单免排队\", \"image\": \"https://cdn.mashangdian.cn/tenant/110840102/20210716/8b30c374903b78f57c5d02357eada8b0.png!clipper\", \"title\": \"到店就餐\", \"action\": {\"url\": \"pages/store/index?scene=eatin\", \"name\": \"堂食就餐\", \"type\": \"func\", \"extra\": {}, \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/110840102/20210716/8b30c374903b78f57c5d02357eada8b0.png\"}, {\"id\": 9, \"desc\": \"好吃又方便\", \"image\": \"https://cdn.mashangdian.cn/tenant/110840102/20210716/f74f4c36c4d1e5f8c19db51fce03c39a.png!clipper\", \"title\": \"打包外带\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"extra\": {}, \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/110840102/20210716/f74f4c36c4d1e5f8c19db51fce03c39a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"row\", \"number\": \"2\", \"divider\": true, \"iconSize\": 60}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {\"source\": {\"api\": \"portal/list\", \"categoryId\": 1}}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]',1626338340,1626338340);
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
  `template_id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序构建模板id',
  `template_version` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序构建模板版本',
  `is_audit` tinyint(3) NOT NULL COMMENT '小程序版本审核状态',
  `status` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'wait' COMMENT '小程序版本状态(gray:灰度，wait:待审核,reject:已拒绝，audit:已审核，online:已上线，offline：下架)',
  `reject_reason` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权商户小程序类型',
  `create_at` bigint(20) DEFAULT '0' COMMENT '创建时间',
  `update_at` bigint(20) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_version`
--

LOCK TABLES `cmf_mp_theme_version` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_version` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_version` VALUES (1,110840102,'0.0.1','2021001192675085','0.0.44',0,'online','','alipay',1626339816,1626426466),(2,110840102,'0.0.1','29','0.2.0',0,'online','','wechat',1626341763,1626445097),(3,110840102,'0.0.2','30','0.2.1',0,'online','','wechat',1626926436,0),(4,110840102,'0.0.2','2021001192675085','0.0.45',0,'online','','alipay',1626926441,1627565699);
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
  `option_value` json DEFAULT NULL,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `store_id` int(11) NOT NULL COMMENT '门店id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_option`
--

LOCK TABLES `cmf_option` WRITE;
/*!40000 ALTER TABLE `cmf_option` DISABLE KEYS */;
INSERT INTO `cmf_option` VALUES (1,1,'business_info','{\"email\": \"309669386@qq.com\", \"mobile\": \"13423336695\", \"address\": \"\", \"company\": \"\", \"contact\": \"\", \"app_desc\": \"来来蒸饭官方点餐小程序\", \"app_slogan\": \"来来蒸饭官方小程序\", \"brand_logo\": \"tenant/110840102/20210716/2d9d98ebe0063ff5fe7ba05fbc8ee0be.jpg\", \"brand_name\": \"来来蒸饭\", \"out_door_pic\": \"tenant/110840102/20210716/82ec010054cb4c66bbc2f4b975afb254.jpg\", \"alipay_logo_id\": \"A*rs7RTotr454AAAAAAAAAAAAADsN1AQ\", \"business_photo\": \"tenant/110840102/20210716/fc974116d435c73b398a557330a9aa47.jpg\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"tenant/110840102/20210716/fd4279a2bbeb8255e2a7dbdc9add39d0.jpg\", \"mini_category_ids\": \"XS1009_XS2074_XS3111\"}',110840102,0),(2,1,'eatin','{\"day\": 0, \"status\": 1, \"eat_type\": 1, \"pay_type\": 0, \"sale_type\": 0, \"surcharge\": 0, \"order_type\": 0, \"sell_clear\": \"\", \"custom_name\": \"\", \"custom_enabled\": 0, \"surcharge_type\": 0, \"enabled_sell_clear\": 0, \"enabled_appointment\": 0}',110840102,1);
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
  `user_id` int(11) DEFAULT NULL COMMENT '下单人信息',
  `buyer_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付宝微信付款人id',
  `total_amount` decimal(9,2) NOT NULL COMMENT '本次交易支付的订单金额，单位为人民币（元）',
  `receipt_amount` decimal(9,2) DEFAULT NULL COMMENT '商家在交易中实际收到的款项，单位为人民币（元）',
  `invoice_amount` decimal(9,2) DEFAULT NULL COMMENT '用户在交易中支付的可开发票的金额',
  `buyer_pay_amount` decimal(9,2) DEFAULT NULL COMMENT '用户在交易中支付的金额',
  `point_amount` decimal(9,2) DEFAULT NULL COMMENT '使用集分宝支付的金额',
  `refund_fee` decimal(9,2) DEFAULT NULL COMMENT '退款通知中，返回总退款金额，单位为元，支持两位小数',
  `send_back_fee` decimal(9,2) DEFAULT NULL COMMENT '商户实际退款给用户的金额，单位为元，支持两位小数',
  `subject` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品的标题/交易标题/订单标题/订单关键字等，是请求时对应的参数，原样通知回来。',
  `body` varchar(400) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '该订单的备注、描述、明细等。对应请求时的 body 参数，原样通知回来。',
  `voucher_detail_list` text COLLATE utf8mb4_general_ci COMMENT '优惠券详情',
  `fund_bill_list` json DEFAULT NULL COMMENT '支付成功的各个渠道金额信息',
  `gmt_payment` bigint(20) DEFAULT NULL COMMENT '交易付款时间',
  `gmt_refund` bigint(20) DEFAULT NULL COMMENT '交易退款时间',
  `gmt_close` bigint(20) DEFAULT NULL COMMENT '交易结束时间',
  `trade_status` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '交易状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_pay_log`
--

LOCK TABLES `cmf_pay_log` WRITE;
/*!40000 ALTER TABLE `cmf_pay_log` DISABLE KEYS */;
INSERT INTO `cmf_pay_log` VALUES (1,'T20210823646928682','4200001128202108235094156801','wxpay','wx652be1385956eb10',9,'oaBYI5cOCHLr94Srl8RSRIRLYkHg',13.00,13.00,0.00,13.00,0.00,0.00,0.00,'','','null','{}',1629683906,0,0,'TRADE_SUCCESS'),(2,'T20210824938599688','4200001144202108245861573512','wxpay','wx652be1385956eb10',11,'oaBYI5fJDFjRJiVXDWaro7V5AyTo',9.90,9.90,0.00,9.90,0.00,0.00,0.00,'','','null','{}',1629776501,0,0,'TRADE_SUCCESS'),(3,'T20210824942076642','2021082422001448951412104941','alipay','2021002156603904',12,'2088122302748955',9.90,9.90,9.90,9.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"9.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629776725,0,0,'TRADE_SUCCESS'),(4,'T20210824242225933','2021082422001417231419365219','alipay','2021002156603904',13,'2088712573417234',9.90,9.90,4.90,4.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082400073002231709IRRPMV\"}]','[{\"amount\": \"4.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629776729,0,0,'TRADE_SUCCESS'),(5,'T20210824365048888','2021082422001454261421729296','alipay','2021002156603904',15,'2088512773254260',9.90,9.90,7.90,7.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081800073002265409EDC58Z\"}]','[{\"amount\": \"7.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629776733,0,0,'TRADE_SUCCESS'),(6,'T202108242066503011','2021082422001430891431843048','alipay','2021002156603904',14,'2088012726330893',9.90,9.90,5.90,5.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"4.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"4.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082400073002893008XC60IW\"}]','[{\"amount\": \"5.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"4.00\", \"fundChannel\": \"DISCOUNT\"}]',1629776752,0,0,'TRADE_SUCCESS'),(7,'T20210824363757109','2021082422001432291425516227','alipay','2021002156603904',16,'2088812885232294',9.90,9.90,7.90,7.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210805000730022932098UONEE\"}]','[{\"amount\": \"7.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629776799,0,0,'TRADE_SUCCESS'),(8,'T20210824306157354','2021082422001424951417865543','alipay','2021002156603904',17,'2088122147324958',12.90,12.90,7.90,7.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082400073002952407Q3SPSG\"}]','[{\"amount\": \"7.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629777015,0,0,'TRADE_SUCCESS'),(9,'T20210824790073749','2021082422001449221417479697','alipay','2021002156603904',18,'2088602314549228',9.90,9.90,5.90,5.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"4.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"4.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082400073002224909HARVAJ\"}]','[{\"amount\": \"5.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"4.00\", \"fundChannel\": \"DISCOUNT\"}]',1629777791,0,0,'TRADE_SUCCESS'),(10,'T20210824687575927','2021082422001445301413719465','alipay','2021002156603904',19,'2088402394045308',15.00,15.00,10.00,10.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210824000730023045085IL2HJ\"}]','[{\"amount\": \"10.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629778183,0,0,'TRADE_SUCCESS'),(11,'T20210824392645315','2021082422001459851412809239','alipay','2021002156603904',20,'2088802130359858',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"PCREDIT\"}]',1629778285,0,0,'TRADE_SUCCESS'),(12,'T20210824711974219','2021082422001466811423907795','alipay','2021002156603904',21,'2088502650566810',33.00,33.00,28.00,28.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210824000730028166098DBBD5\"}]','[{\"amount\": \"28.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629778327,0,0,'TRADE_SUCCESS'),(13,'T202108241719764452','2021082422001428811425337045','alipay','2021002156603904',22,'2088802344928811',9.90,9.90,7.90,7.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210821000730028128097JHXUS\"}]','[{\"amount\": \"7.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629778336,0,0,'TRADE_SUCCESS'),(14,'T20210824453267112','2021082422001470281425370837','alipay','2021002156603904',24,'2088222071970282',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629778357,0,0,'TRADE_SUCCESS'),(15,'T20210824865252216','2021082422001445311420892252','alipay','2021002156603904',25,'2088802321445315',9.90,9.90,7.90,7.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210802000730023145096312A4\"}]','[{\"amount\": \"7.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629778373,0,0,'TRADE_SUCCESS'),(16,'T20210824229739915','2021082422001432911429779813','alipay','2021002156603904',23,'2088022004732918',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629778385,0,0,'TRADE_SUCCESS'),(17,'T202108241987737321','2021082422001461751413877859','alipay','2021002156603904',26,'2088902114361751',19.80,19.80,17.80,17.80,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210804000730027561086VTGMK\"}]','[{\"amount\": \"17.80\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629778850,0,0,'TRADE_SUCCESS'),(18,'T202108242136819652','2021082422001446531414515695','alipay','2021002156603904',27,'2088122556346532',9.90,9.90,9.90,9.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"9.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629779200,0,0,'TRADE_SUCCESS'),(19,'T202108242007613382','4200001125202108242670760338','wxpay','wx652be1385956eb10',28,'oaBYI5WpFTqBqXsHlziq0rT43thM',11.90,11.90,0.00,11.90,0.00,0.00,0.00,'','','null','{}',1629779493,0,0,'TRADE_SUCCESS'),(20,'T20210824474690130','2021082422001427331418082788','alipay','2021002156603904',29,'2088112446427337',9.90,9.90,7.90,7.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210819000730023327099C75MF\"}]','[{\"amount\": \"7.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629780130,0,0,'TRADE_SUCCESS'),(21,'T202108241499317886','4200001235202108248928549366','wxpay','wx652be1385956eb10',30,'oaBYI5eaXM4wn4C-lBrXWYTfWWdQ',46.00,46.00,0.00,46.00,0.00,0.00,0.00,'','','null','{}',1629781565,0,0,'TRADE_SUCCESS'),(22,'T202108242051366201','2021082422001408891423657862','alipay','2021002156603904',31,'2088522305808890',9.90,9.90,7.90,7.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081500073002890808V66LYM\"}]','[{\"amount\": \"7.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629781776,0,0,'TRADE_SUCCESS'),(23,'T202108241982483967','2021082422001400771423045219','alipay','2021002156603904',32,'2088612490400774',9.90,9.90,9.90,9.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"9.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629783380,0,0,'TRADE_SUCCESS'),(24,'T20210824465021080','2021082422001485881424415333','alipay','2021002156603904',33,'2088422579385883',9.90,9.90,5.90,5.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"4.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"4.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082400073002888508PWPXHG\"}]','[{\"amount\": \"5.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"4.00\", \"fundChannel\": \"DISCOUNT\"}]',1629783652,0,0,'TRADE_SUCCESS'),(25,'T20210824687560791','2021082422001443591418189343','alipay','2021002156603904',34,'2088612036843591',13.90,13.90,13.90,13.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"13.90\", \"fundChannel\": \"PCREDIT\"}]',1629802884,0,0,'TRADE_SUCCESS'),(26,'T202108242018599104','4200001145202108246730868290','wxpay','wx652be1385956eb10',35,'oaBYI5eAYTIl9f1QwCezPX1DV2hQ',9.90,9.90,0.00,9.90,0.00,0.00,0.00,'','','null','{}',1629803937,0,0,'TRADE_SUCCESS'),(27,'T2021082432919420','2021082422001402261419672038','alipay','2021002156603904',36,'2088932331802265',15.00,15.00,13.00,13.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081700073002260209E0QN2L\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629808653,0,0,'TRADE_SUCCESS'),(28,'T20210824227713903','4200001142202108241962776291','wxpay','wx652be1385956eb10',37,'oaBYI5ckyXcN7lzhHjc8osl0dG6A',16.00,16.00,0.00,16.00,0.00,0.00,0.00,'','','null','{}',1629808762,0,0,'TRADE_SUCCESS'),(29,'T202108251290611858','4200001127202108253306959824','wxpay','wx652be1385956eb10',11,'oaBYI5fJDFjRJiVXDWaro7V5AyTo',16.00,16.00,0.00,16.00,0.00,0.00,0.00,'','','null','{}',1629863012,0,0,'TRADE_SUCCESS'),(30,'T202108252100749852','2021082522001411171427979111','alipay','2021002156603904',39,'2088312545211172',32.00,32.00,30.00,30.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021080500073002171108VOZ3IU\"}]','[{\"amount\": \"30.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629864586,0,0,'TRADE_SUCCESS'),(31,'T202108251533780306','2021082522001434981433887608','alipay','2021002156603904',43,'2088312672234985',15.00,15.00,10.00,10.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021080400073002983408R8F25U\"}]','[{\"amount\": \"10.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629864694,0,0,'TRADE_SUCCESS'),(32,'T202108251226485806','2021082522001401691425484298','alipay','2021002156603904',40,'2088002913801693',15.00,15.00,10.00,10.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210825000730026901092ZFHHO\"}]','[{\"amount\": \"10.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629864705,0,0,'TRADE_SUCCESS'),(33,'T202108251127844673','2021082522001467211417956572','alipay','2021002156603904',42,'2088022109367211',16.00,16.00,14.00,14.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081000073002216709IAZDKY\"}]','[{\"amount\": \"14.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629864717,0,0,'TRADE_SUCCESS'),(34,'T20210825986468754','2021082522001470611420133257','alipay','2021002156603904',41,'2088022342970614',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629864785,0,0,'TRADE_SUCCESS'),(35,'T202108251061355095','2021082522001446701406726429','alipay','2021002156603904',44,'2088112764546705',16.00,16.00,14.00,14.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210813000730027046088P25SC\"}]','[{\"amount\": \"14.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629865150,0,0,'TRADE_SUCCESS'),(36,'T20210825302767742','2021082522001422471418325494','alipay','2021002156603904',45,'2088102595122470',18.00,18.00,18.00,18.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"18.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629865828,0,0,'TRADE_SUCCESS'),(37,'T202108252018901673','4200001140202108254373034552','wxpay','wx652be1385956eb10',46,'oaBYI5Y15E-1ZJwb5WCK1EkkPaSA',14.90,14.90,0.00,14.90,0.00,0.00,0.00,'','','null','{}',1629865831,0,0,'TRADE_SUCCESS'),(38,'T202108251133349336','2021082522001474051414687347','alipay','2021002156603904',47,'2088022670674053',14.90,14.90,14.90,14.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"14.90\", \"fundChannel\": \"PCREDIT\"}]',1629865922,0,0,'TRADE_SUCCESS'),(39,'T202108251834374528','2021082522001461751415610381','alipay','2021002156603904',26,'2088902114361751',29.80,29.80,29.80,29.80,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"29.80\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629866134,0,0,'TRADE_SUCCESS'),(40,'T202108251191575964','2021082522001432821429457870','alipay','2021002156603904',48,'2088522068132823',16.00,16.00,11.00,11.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210825000730028232095OCEO0\"}]','[{\"amount\": \"11.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629867241,0,0,'TRADE_SUCCESS'),(41,'T20210825499680086','2021082522001450701411790654','alipay','2021002156603904',49,'2088812217550700',14.90,14.90,14.89,14.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"0.01\", \"fundChannel\": \"COUPON\"}, {\"amount\": \"14.89\", \"fundChannel\": \"PCREDIT\"}]',1629886228,0,0,'TRADE_SUCCESS'),(42,'T202108261746069849','2021082622001471231425058801','alipay','2021002156603904',50,'2088302155571230',18.00,18.00,13.00,13.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082600073002237109JDU47L\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629949055,0,0,'TRADE_SUCCESS'),(43,'T2021082615640070','2021082622001429901418406221','alipay','2021002156603904',51,'2088202894429901',67.00,67.00,62.00,62.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081300073002902907ONZYGH\"}]','[{\"amount\": \"62.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629949752,0,0,'TRADE_SUCCESS'),(44,'T20210826256984310','2021082622001476681414423217','alipay','2021002156603904',52,'2088822853176680',16.00,16.00,14.00,14.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081700073002687608X9DXMG\"}]','[{\"amount\": \"14.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629949925,0,0,'TRADE_SUCCESS'),(45,'T202108261370331035','2021082622001486591414612515','alipay','2021002156603904',53,'2088212152386594',16.00,16.00,14.00,14.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210803000730025986087JOUL4\"}]','[{\"amount\": \"14.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629949934,0,0,'TRADE_SUCCESS'),(46,'T202108261357033359','2021082622001426081422243867','alipay','2021002156603904',54,'2088722512326082',17.00,17.00,12.00,12.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021080400073002082608Q7JBOL\"}]','[{\"amount\": \"12.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629950190,0,0,'TRADE_SUCCESS'),(47,'T20210826848586947','2021082622001445311423683014','alipay','2021002156603904',25,'2088802321445315',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"PCREDIT\"}]',1629950562,0,0,'TRADE_SUCCESS'),(48,'T202108261474591620','2021082622001499271418836974','alipay','2021002156603904',55,'2088922850799274',16.00,16.00,16.00,16.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"16.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629950594,0,0,'TRADE_SUCCESS'),(49,'T202108261316151380','2021082622001422911433525677','alipay','2021002156603904',56,'2088012975022912',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629950611,0,0,'TRADE_SUCCESS'),(50,'T20210826970125474','2021082622001420591417037402','alipay','2021002156603904',57,'2088822109320595',15.00,15.00,10.00,10.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082600073002592008CLQX9S\"}]','[{\"amount\": \"10.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629950716,0,0,'TRADE_SUCCESS'),(51,'T202108261854547414','2021082622001486591413863616','alipay','2021002156603904',53,'2088212152386594',16.00,16.00,16.00,16.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"16.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629950908,0,0,'TRADE_SUCCESS'),(52,'T202108261012159081','4200001217202108268167315146','wxpay','wx652be1385956eb10',58,'oaBYI5Z6utoDXnPqGjlqXSswUPS8',15.00,15.00,0.00,15.00,0.00,0.00,0.00,'','','null','{}',1629951046,0,0,'TRADE_SUCCESS'),(53,'T202108261776147900','4200001143202108263917730892','wxpay','wx652be1385956eb10',59,'oaBYI5YuWCYPDiEpnvpzXG3C4_50',30.00,30.00,0.00,30.00,0.00,0.00,0.00,'','','null','{}',1629951124,0,0,'TRADE_SUCCESS'),(54,'T202108261327545859','2021082622001415461415245937','alipay','2021002156603904',60,'2088422206115465',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"PCREDIT\"}]',1629951204,0,0,'TRADE_SUCCESS'),(55,'T20210826615451215','2021082622001428811428372119','alipay','2021002156603904',22,'2088802344928811',18.00,18.00,16.00,16.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210821000730028128097JZ9XO\"}]','[{\"amount\": \"16.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629951264,0,0,'TRADE_SUCCESS'),(56,'T20210826816290404','2021082622001438261418170611','alipay','2021002156603904',61,'2088122860738265',13.00,13.00,11.00,11.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081700073002263809E4AVDQ\"}]','[{\"amount\": \"11.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1629951318,0,0,'TRADE_SUCCESS'),(57,'T202108261103955967','2021082622001483631416016387','alipay','2021002156603904',62,'2088212044883635',16.00,16.00,16.00,16.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"16.00\", \"fundChannel\": \"PCREDIT\"}]',1629951375,0,0,'TRADE_SUCCESS'),(58,'T20210826760679443','2021082622001461751416876703','alipay','2021002156603904',26,'2088902114361751',15.00,15.00,15.00,15.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"15.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1629952059,0,0,'TRADE_SUCCESS'),(59,'T20210826320652650','2021082622001464701413030460','alipay','2021002156603904',63,'2088612079964705',16.00,16.00,11.00,11.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021081900073002706408A7W39N\"}]','[{\"amount\": \"11.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1629952474,0,0,'TRADE_SUCCESS'),(60,'T202108261283735741','2021082622001414811432445555','alipay','2021002156603904',64,'2088422888814810',18.00,18.00,18.00,18.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"18.00\", \"fundChannel\": \"PCREDIT\"}]',1629952543,0,0,'TRADE_SUCCESS'),(61,'T2021082685066541','2021082622001483631415385642','alipay','2021002156603904',62,'2088212044883635',18.00,18.00,18.00,18.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"18.00\", \"fundChannel\": \"PCREDIT\"}]',1629953103,0,0,'TRADE_SUCCESS'),(62,'T20210827830886352','2021082722001486591415448913','alipay','2021002156603904',53,'2088212152386594',16.00,16.00,16.00,16.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"16.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1630036543,0,0,'TRADE_SUCCESS'),(63,'T202108271558216584','4200001231202108271801572468','wxpay','wx652be1385956eb10',52,'oaBYI5RCqb3W17wnfsGJp1l-gYBo',15.00,15.00,0.00,15.00,0.00,0.00,0.00,'','','null','{}',1630036564,0,0,'TRADE_SUCCESS'),(64,'T202108271085614704','2021082722001466421416605744','alipay','2021002156603904',65,'2088602293566423',15.00,15.00,10.00,10.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082600073002426608L3LKRQ\"}]','[{\"amount\": \"10.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1630036569,0,0,'TRADE_SUCCESS'),(65,'T202108272030464312','4200001142202108273518729051','wxpay','wx652be1385956eb10',66,'oaBYI5YPuEGTkWXxvG_ZL155AXvg',18.00,18.00,0.00,18.00,0.00,0.00,0.00,'','','null','{}',1630036671,0,0,'TRADE_SUCCESS'),(66,'T20210827708297855','4200001226202108275634700361','wxpay','wx652be1385956eb10',21,'oaBYI5dOISoz0FBmP3c-86oPdLFs',15.00,15.00,0.00,15.00,0.00,0.00,0.00,'','','null','{}',1630037266,0,0,'TRADE_SUCCESS'),(67,'T20210827131270101','4200001128202108279175976119','wxpay','wx652be1385956eb10',20,'oaBYI5WZpBKOJMoM24fY-Si-LqMk',16.00,16.00,0.00,16.00,0.00,0.00,0.00,'','','null','{}',1630037278,0,0,'TRADE_SUCCESS'),(68,'T202108271832723968','4200001125202108271278351811','wxpay','wx652be1385956eb10',67,'oaBYI5RDmdUqpjhk5uxXMZxHBaz4',10.90,10.90,0.00,10.90,0.00,0.00,0.00,'','','null','{}',1630037286,0,0,'TRADE_SUCCESS'),(69,'T20210827228095167','2021082722001417161425937810','alipay','2021002156603904',68,'2088622759417160',14.00,14.00,14.00,14.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"14.00\", \"fundChannel\": \"PCREDIT\"}]',1630037345,0,0,'TRADE_SUCCESS'),(70,'T202108271098419266','2021082722001411171430801841','alipay','2021002156603904',39,'2088312545211172',23.90,23.90,23.90,23.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"23.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1630037389,0,0,'TRADE_SUCCESS'),(71,'T20210827979509313','4200001209202108274150872898','wxpay','wx652be1385956eb10',69,'oaBYI5Z9yxPxKkjiwKdH9qFxCTEE',13.00,13.00,0.00,13.00,0.00,0.00,0.00,'','','null','{}',1630038040,0,0,'TRADE_SUCCESS'),(72,'T202108271241387559','2021082722001442181431351132','alipay','2021002156603904',70,'2088902023242185',54.00,54.00,49.00,49.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210827000730021842091EWL9A\"}]','[{\"amount\": \"49.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1630066431,0,0,'TRADE_SUCCESS'),(73,'T20210827467755916','2021082722001459701410230381','alipay','2021002156603904',71,'2088602243459702',18.00,18.00,16.00,16.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"202108150007300270590894N3WQ\"}]','[{\"amount\": \"16.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1630067645,0,0,'TRADE_SUCCESS'),(74,'T20210827500542568','2021082722001481911434397259','alipay','2021002156603904',72,'2088232995481911',18.00,18.00,14.00,14.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"4.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"4.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082700073002918108X0I2HN\"}]','[{\"amount\": \"14.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"4.00\", \"fundChannel\": \"DISCOUNT\"}]',1630068441,0,0,'TRADE_SUCCESS'),(75,'T202108281579698112','4200001218202108287153478040','wxpay','wx652be1385956eb10',73,'oaBYI5SZ54AUI8o90oqyBb1C4GR0',15.00,15.00,0.00,15.00,0.00,0.00,0.00,'','','null','{}',1630116959,0,0,'TRADE_SUCCESS'),(76,'T20210828170495412','2021082822001408811427688631','alipay','2021002156603904',74,'2088112330708816',15.00,15.00,13.00,13.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"202108280007300281080997ZH4R\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1630123875,0,0,'TRADE_SUCCESS'),(77,'T202108281741016842','2021082822001475791422276048','alipay','2021002156603904',75,'2088212599675792',15.00,15.00,10.00,10.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210828000730027975093Q3EGR\"}]','[{\"amount\": \"10.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1630123895,0,0,'TRADE_SUCCESS'),(78,'T20210828247611829','2021082822001485041425061517','alipay','2021002156603904',77,'2088712310985044',18.00,18.00,13.00,13.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210828000730020485091I7K9G\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1630124030,0,0,'TRADE_SUCCESS'),(79,'T20210828802072937','2021082822001427161426440533','alipay','2021002156603904',76,'2088122657427161',18.00,18.00,13.00,13.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"5.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021082800073002162708UXHDPF\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"DISCOUNT\"}]',1630124219,0,0,'TRADE_SUCCESS'),(80,'T20210830141070005','2021083022001408811429862167','alipay','2021002156603904',74,'2088112330708816',9.90,9.90,8.90,8.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"1.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"1.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"202108280007300281080998M1LY\"}]','[{\"amount\": \"8.90\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"1.00\", \"fundChannel\": \"DISCOUNT\"}]',1630296548,0,0,'TRADE_SUCCESS'),(81,'T20210830366955244','2021083022001411171433296924','alipay','2021002156603904',39,'2088312545211172',23.90,23.90,23.90,23.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"23.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1630296558,0,0,'TRADE_SUCCESS'),(82,'T202108301775794931','2021083022001432911436735985','alipay','2021002156603904',23,'2088022004732918',9.90,9.90,9.90,9.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"9.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1630296568,0,0,'TRADE_SUCCESS'),(83,'T20210830720324729','2021083022001470281431289229','alipay','2021002156603904',24,'2088222071970282',9.90,9.90,9.90,9.90,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','','[{\"amount\": \"9.90\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1630296570,0,0,'TRADE_SUCCESS'),(84,'T202108301147295799','4200001128202108302990182584','wxpay','wx652be1385956eb10',78,'oaBYI5eXNW02m9-ytXm14s7II2tQ',30.00,30.00,0.00,30.00,0.00,0.00,0.00,'','','null','{}',1630296971,0,0,'TRADE_SUCCESS'),(85,'T202108301688568781','2021083022001402381429633490','alipay','2021002156603904',79,'2088902000802388',15.00,15.00,13.00,13.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021080500073002380208YYYYNH\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1630297820,0,0,'TRADE_SUCCESS'),(86,'T202108301887985119','2021083022001446251420560284','alipay','2021002156603904',80,'2088602277546254',15.00,15.00,13.00,13.00,0.00,0.00,0.00,'来来蒸饭','来来蒸饭点餐','[{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"20210805000730022546084DA8NH\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}]',1630297938,0,0,'TRADE_SUCCESS');
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
INSERT INTO `cmf_portal_category` VALUES (1,110840102,0,0,1,0,10000,'新鲜事','','','','','','','','','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_post`
--

LOCK TABLES `cmf_portal_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_post` DISABLE KEYS */;
INSERT INTO `cmf_portal_post` VALUES (1,110840102,0,1,1,1,1,1,0,0,10,0,0,0,1626404782,1626404782,0,0,'来来蒸饭线上点餐上线了','','','','tenant/110840102/20210716/9e49e501bd624557b372baacc4e8c40f.jpg','<p><img src=\"https://cdn.mashangdian.cn/default/20210716/194b1fe8899472384573ef9785a77808.png!clipper\" alt=\"\" width=\"100%\" /></p>','','{\"audio\": \"\", \"files\": [], \"other\": null, \"video\": \"\", \"photos\": [], \"extends\": {}, \"template\": \"\"}');
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
  `pattern` tinyint(3) NOT NULL DEFAULT '0' COMMENT '打印模式（0：全部，1：一菜一单）',
  `count` int(11) NOT NULL DEFAULT '1' COMMENT '打印联数',
  `sn` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备SN号',
  `key` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备Key',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_printer`
--

LOCK TABLES `cmf_printer` WRITE;
/*!40000 ALTER TABLE `cmf_printer` DISABLE KEYS */;
INSERT INTO `cmf_printer` VALUES (1,110840102,1,'飞鹅','cloud','feie',0,1,'922522925','v3t7qunj',1629638491,1629638491,0);
/*!40000 ALTER TABLE `cmf_printer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_qrcode_post`
--

DROP TABLE IF EXISTS `cmf_qrcode_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_qrcode_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) NOT NULL COMMENT '小程序加密编号',
  `store_id` bigint(20) NOT NULL COMMENT '门店id',
  `qrcode_code` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '二维码码值',
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '二维码名称',
  `desk_id` bigint(20) DEFAULT NULL COMMENT '绑定桌号',
  `file_path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `create_at` bigint(20) NOT NULL,
  `update_at` bigint(20) NOT NULL,
  `delete_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_qrcode_post`
--

LOCK TABLES `cmf_qrcode_post` WRITE;
/*!40000 ALTER TABLE `cmf_qrcode_post` DISABLE KEYS */;
INSERT INTO `cmf_qrcode_post` VALUES (1,110840102,1,'1208092338','1号桌',1,'qrcode/20210629/6c3efd74a6428b9a0a5cf58a8e57060f.png',1626854950,0,0),(2,110840102,1,'956272384','2号桌',2,'qrcode/20210629/7fb742072cacffceb874587307251039.png',1629731294,0,0),(3,110840102,1,'1877482712','3号桌',3,'qrcode/20210629/ad608d32920b45396cbd46a7f1181bd8.png',1629732338,0,0),(4,110840102,1,'1430127116','4号桌',4,'qrcode/20210629/951306718b9f12cd4b5d5854915e1dcd.png',1629732418,0,0),(5,110840102,1,'1096599788','5号桌',5,'qrcode/20210629/de837b629f980d2d01b1c0278220de0a.png',1629732457,0,0),(6,110840102,1,'106595537','6号桌',6,'qrcode/20210629/5fc87dc5d9632eafe43c8b2283d23e3c.png',1629732489,0,0),(7,110840102,1,'202685635','7号桌',7,'qrcode/20210629/722924779695b7084b12ce13dc3bd0f4.png',1629732588,0,0),(8,110840102,1,'1159955644','8号桌',8,'qrcode/20210629/55c05b7782019fc0f8352ed74a14a1ef.png',1629732617,0,0),(9,110840102,1,'1737822076','9号桌',9,'qrcode/20210629/c5bd65098d4581fd3979ceff3cc07508.png',1629732648,0,0),(10,110840102,1,'942180303','10号桌',10,'qrcode/20210629/dc381cf0498d9a4e6617189fa259c30b.png',1629732670,0,0),(11,110840102,1,'995091957','11号桌',11,'qrcode/20210629/7f3139988ac0edb15edde460b7affaa4.png',1629805991,0,0),(12,110840102,1,'1431829923','12号桌',12,'qrcode/20210629/9bc453ffa8a459e1a07ef23273a861b0.png',1629806006,0,0),(13,110840102,1,'200087852','13号桌',13,'qrcode/20210629/a97491a6d9753756af450e55e2ac1825.png',1629806021,0,0);
/*!40000 ALTER TABLE `cmf_qrcode_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_recharge_log`
--

DROP TABLE IF EXISTS `cmf_recharge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_recharge_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `target_id` bigint(20) NOT NULL COMMENT '所属目标订单id',
  `target_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '(目标类型：0：订单)',
  `user_id` bigint(20) NOT NULL COMMENT '所属用户id',
  `type` tinyint(3) NOT NULL COMMENT '(类型：0：增加，1：扣除)',
  `fee` varchar(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '(消费/充值)金额',
  `balance` varchar(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '剩余余额',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_recharge_log`
--

LOCK TABLES `cmf_recharge_log` WRITE;
/*!40000 ALTER TABLE `cmf_recharge_log` DISABLE KEYS */;
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
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `order_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `trade_no` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝订单号',
  `user_id` bigint(20) NOT NULL COMMENT '用户所属id',
  `pay_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方支付类型',
  `fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '支付金额',
  `actual_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '实际金额',
  `send_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '赠送金额',
  `refund_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '剩余可退金额',
  `create_at` bigint(20) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  `order_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WAIT_BUYER_PAY' COMMENT '订单状态（WAIT_BUYER_PAY => 待支付，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_recharge_order`
--

LOCK TABLES `cmf_recharge_order` WRITE;
/*!40000 ALTER TABLE `cmf_recharge_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_recharge_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_role`
--

DROP TABLE IF EXISTS `cmf_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_role` (
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0' COMMENT '所属父类id',
  `name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `list_order` double DEFAULT '10000' COMMENT '排序',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `status` tinyint(3) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role`
--

LOCK TABLES `cmf_role` WRITE;
/*!40000 ALTER TABLE `cmf_role` DISABLE KEYS */;
INSERT INTO `cmf_role` VALUES (110840102,1,0,'超级管理员','拥有网站最高管理员权限！',10000,1626338340,1626338340,1),(110840102,2,0,'收银员','收银员！',1,1626338340,1626338340,1),(110840102,3,0,'财务','财务！',2,1626338340,1626338340,1);
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
  `type` tinyint(3) NOT NULL COMMENT '(类型：0：增加，1：扣除)',
  `score` int(11) NOT NULL COMMENT '增加积分',
  `fee` varchar(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '合计金额',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_score_log`
--

LOCK TABLES `cmf_score_log` WRITE;
/*!40000 ALTER TABLE `cmf_score_log` DISABLE KEYS */;
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
  `order_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请单id',
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `store_number` int(11) NOT NULL COMMENT '门店唯一编号',
  `shop_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '蚂蚁店铺id',
  `store_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店名称',
  `store_type` tinyint(3) NOT NULL COMMENT '门店类型（1：直营，2：加盟）',
  `top_category` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属门店顶级id',
  `shop_category` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属门店id',
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
  `enabled_sell_clear` tinyint(3) NOT NULL DEFAULT '0' COMMENT '启用沽清',
  `sell_clear` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '自定义沽清时间',
  `notice` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公告通知',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT '0' COMMENT '删除时间',
  `audit_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'wait' COMMENT '审核状态(passed:通过,rejected:拒绝,wait:审核中)',
  `reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '拒绝愿意',
  `distance` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_store`
--

LOCK TABLES `cmf_store` WRITE;
/*!40000 ALTER TABLE `cmf_store` DISABLE KEYS */;
INSERT INTO `cmf_store` VALUES (1,'2021082200502000000077297395',110840102,608958810,'2021071600077000000024542770','来来蒸饭',1,'S08','1715','13423336695','店长',440000,'广东',441900,'东莞',441900004,'南城街道','南城街道元美东路5号169室南城街道元美东路5号169室 来来蒸饭','tenant/110840102/20210716/5293d43a9755b47886717d7b6e7c79d9.jpeg',113.7545260,23.0116250,0,1,'22:30','',1629645416,1629645416,0,'passed','',NULL);
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
INSERT INTO `cmf_store_hours` VALUES (110840102,1,1,1,1,1,1,1,1,'00:00','22:30',0);
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
  `open_id` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `session_key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_part`
--

LOCK TABLES `cmf_third_part` WRITE;
/*!40000 ALTER TABLE `cmf_third_part` DISABLE KEYS */;
INSERT INTO `cmf_third_part` VALUES (1,110840102,'alipay-mp',1,'2088512446596714',''),(2,110840102,'wechat-mp',0,'oaBYI5dBMC4HkAxREn6LA7NVKImc','opN65AhTiVm8Iyl7dshI4w=='),(3,110840102,'wechat-mp',0,'oaBYI5c1wn_bqmvBpG1tBbxg9IiQ','aOjMH99NTjZZ1KjB9NscGw=='),(4,110840102,'alipay-mp',0,'2088042865655966',''),(5,110840102,'wechat-mp',1,'oaBYI5QthBAf9wH6SG8KUFeuvIEE','DrACoESXrAirk0cnZozo/g=='),(6,110840102,'alipay-mp',0,'2088932072878932',''),(7,110840102,'alipay-mp',0,'2088932207171923',''),(8,110840102,'alipay-mp',0,'2088012248042131',''),(9,110840102,'wechat-mp',6,'oaBYI5YrekV2w5lYwtJwbRUhXPc0','a2vC6R6RwvGDZUfvWb+8Hw=='),(10,110840102,'alipay-mp',0,'2088622235514734',''),(11,110840102,'wechat-mp',2,'oaBYI5YoKe5nRQMcPo8ZNCp6eFgw','5phhbwPdP/iPVBDPUCl7RA=='),(12,110840102,'alipay-mp',0,'2088702732822641',''),(13,110840102,'alipay-mp',3,'2088522182110914',''),(14,110840102,'wechat-mp',4,'oaBYI5X-DYFNbuWuWgf2YkKmw9Es','FnsCsrpfGcvIKxhKCKUFIg=='),(15,370429601,'alipay-mp',0,'2088812328022921',''),(16,110840102,'alipay-mp',0,'2088702248885431',''),(17,110840102,'wechat-mp',0,'oaBYI5Xc0Q0e0hWaGV6ox4ErOB_M','TCyzDvRzNMSOSflvALzjcQ=='),(18,110840102,'wechat-mp',5,'oaBYI5dqmIG5-gM2HUW0M4wdND0k','wA8FYxWq+ZKy+ATQ9kUvrA=='),(19,110840102,'alipay-mp',5,'2088512584940617',''),(20,110840102,'wechat-mp',0,'oaBYI5W7GX0EYef4pwmPLi3r9m7A','QwnSew6/HY06z4Zb6OlNZg=='),(21,110840102,'wechat-mp',0,'oaBYI5dk8nW19e79uAXU5R4JEf4I','5Ji4CmUgxxMcI+d5OTHWDw=='),(22,110840102,'alipay-mp',0,'2088932209078428',''),(23,110840102,'wechat-mp',0,'oaBYI5QIaLf19znZewTn5gfUlGt4','XtqNIsF1huG/kTWKg/Bbzg=='),(24,110840102,'wechat-mp',0,'oaBYI5bbNy6jZuI210HW2yJaqcLg','v/9IYcIguFfyBh1ag17o9g=='),(25,110840102,'wechat-mp',0,'oaBYI5QCSDtF0eRSh6c8lpQyB9XU','IbE/EsBUl3wj+NMKrxVlUQ=='),(26,110840102,'wechat-mp',7,'oaBYI5VTncHVLW0i41JVdfTKQBGs','mMFwX07W5fOi4sDjUfVg4Q=='),(27,110840102,'wechat-mp',8,'oaBYI5enV1EZV2OYLTe537i8sT1w','HQaT1gHlpjiJb9ieJIBRKQ=='),(28,110840102,'wechat-mp',0,'oaBYI5YyDkmmY7eOze9DT8b6bayg','niAH92RlPiCgDF+eIUdBpg=='),(29,110840102,'wechat-mp',0,'oaBYI5SrBF94uxM3ZXC2G-Xi8Naw','ity4yJr6xjsLFMeKE8/wng=='),(30,110840102,'alipay-mp',0,'2088912854388783',''),(31,110840102,'wechat-mp',9,'oaBYI5cOCHLr94Srl8RSRIRLYkHg','n6+PLgAC8i+S0xZzHxdjzw=='),(32,110840102,'wechat-mp',10,'oaBYI5XeVvq80PUhQogd_fIFpbGk','Eq0wvYq/jXn7sgYf5IvmFQ=='),(33,110840102,'wechat-mp',0,'oaBYI5bwx7_fRPCTe9h3omfxind4','W5jKhDWXY3/yPcO+KMqycg=='),(34,110840102,'wechat-mp',11,'oaBYI5fJDFjRJiVXDWaro7V5AyTo','3Iy1QGEW4uz9BHcfTGTThg=='),(35,110840102,'alipay-mp',13,'2088712573417234',''),(36,110840102,'alipay-mp',12,'2088122302748955',''),(37,110840102,'alipay-mp',14,'2088012726330893',''),(38,110840102,'alipay-mp',15,'2088512773254260',''),(39,110840102,'wechat-mp',16,'oaBYI5ecpNCAcg3_pquX8fxYY9tg','iK2Cb4/ZzL1AwglATcld2g=='),(40,110840102,'alipay-mp',16,'2088812885232294',''),(41,110840102,'alipay-mp',17,'2088122147324958',''),(42,110840102,'alipay-mp',18,'2088602314549228',''),(43,110840102,'alipay-mp',19,'2088402394045308',''),(44,110840102,'alipay-mp',20,'2088802130359858',''),(45,110840102,'alipay-mp',21,'2088502650566810',''),(46,110840102,'alipay-mp',22,'2088802344928811',''),(47,110840102,'alipay-mp',23,'2088022004732918',''),(48,110840102,'alipay-mp',25,'2088802321445315',''),(49,110840102,'alipay-mp',24,'2088222071970282',''),(50,110840102,'alipay-mp',26,'2088902114361751',''),(51,110840102,'alipay-mp',27,'2088122556346532',''),(52,110840102,'wechat-mp',28,'oaBYI5WpFTqBqXsHlziq0rT43thM','U54fM+ccrBsRkiUz8e8qKA=='),(53,110840102,'alipay-mp',29,'2088112446427337',''),(54,110840102,'wechat-mp',0,'oaBYI5WTHGB5ol6ypjSe0_9HfmNY','IaS2OlrAJ3lYvpCNXwGj0A=='),(55,110840102,'alipay-mp',0,'2088812725015034',''),(56,110840102,'alipay-mp',0,'2088632076861221',''),(57,110840102,'wechat-mp',30,'oaBYI5eaXM4wn4C-lBrXWYTfWWdQ','Vit+FxCclSwmcdevjOTEjg=='),(58,110840102,'alipay-mp',31,'2088522305808890',''),(59,110840102,'alipay-mp',32,'2088612490400774',''),(60,110840102,'alipay-mp',33,'2088422579385883',''),(61,110840102,'alipay-mp',34,'2088612036843591',''),(62,110840102,'wechat-mp',35,'oaBYI5eAYTIl9f1QwCezPX1DV2hQ','Yu7hO+HlCSYpO4PU1sST1A=='),(63,110840102,'wechat-mp',37,'oaBYI5ckyXcN7lzhHjc8osl0dG6A','OXE2DVSFh1lVjyX+4cUn5A=='),(64,110840102,'alipay-mp',36,'2088932331802265',''),(65,110840102,'alipay-mp',38,'2088422350293424',''),(66,110840102,'alipay-mp',0,'2088002604108072',''),(67,110840102,'alipay-mp',39,'2088312545211172',''),(68,110840102,'alipay-mp',41,'2088022342970614',''),(69,110840102,'alipay-mp',43,'2088312672234985',''),(70,110840102,'alipay-mp',40,'2088002913801693',''),(71,110840102,'alipay-mp',42,'2088022109367211',''),(72,110840102,'alipay-mp',44,'2088112764546705',''),(73,110840102,'wechat-mp',46,'oaBYI5Y15E-1ZJwb5WCK1EkkPaSA','nnNwqUNatBe8qp/Eu4G4Vw=='),(74,110840102,'alipay-mp',45,'2088102595122470',''),(75,110840102,'alipay-mp',47,'2088022670674053',''),(76,110840102,'alipay-mp',48,'2088522068132823',''),(77,110840102,'wechat-mp',0,'oaBYI5frbt-XcR6-hi-PZLmPq0NM','hYKrvM0vc13ja1ngFjHq5A=='),(78,110840102,'alipay-mp',49,'2088812217550700',''),(79,110840102,'alipay-mp',50,'2088302155571230',''),(80,110840102,'alipay-mp',51,'2088202894429901',''),(81,110840102,'alipay-mp',0,'2088902446261831',''),(82,110840102,'alipay-mp',0,'2088202946854808',''),(83,110840102,'alipay-mp',53,'2088212152386594',''),(84,110840102,'alipay-mp',52,'2088822853176680',''),(85,110840102,'alipay-mp',54,'2088722512326082',''),(86,110840102,'alipay-mp',55,'2088922850799274',''),(87,110840102,'alipay-mp',56,'2088012975022912',''),(88,110840102,'alipay-mp',57,'2088822109320595',''),(89,110840102,'wechat-mp',58,'oaBYI5Z6utoDXnPqGjlqXSswUPS8','lI06dJwwTj8BPr1RWww2LQ=='),(90,110840102,'alipay-mp',0,'2088022619355870',''),(91,110840102,'wechat-mp',0,'oaBYI5YUItw022UmaB_r2sFYWl_U','HZVNSQmq0uhX6WGeQEr0jg=='),(92,110840102,'alipay-mp',0,'2088802050676541',''),(93,110840102,'wechat-mp',59,'oaBYI5YuWCYPDiEpnvpzXG3C4_50','4KhG4zlGKPMVLnAP9A9N0g=='),(94,110840102,'alipay-mp',0,'2088802197886166',''),(95,110840102,'alipay-mp',0,'2088822755406445',''),(96,110840102,'alipay-mp',60,'2088422206115465',''),(97,110840102,'wechat-mp',22,'oaBYI5Sc2Egzkzph4RgYizXa9y2Q','DdaxjVuubhwNVg5+Hd0KnA=='),(98,110840102,'alipay-mp',62,'2088212044883635',''),(99,110840102,'wechat-mp',0,'oaBYI5QAsphodwy_J869KBTNZIUE','/AdEXhBYKrv8PEdaX9p0Og=='),(100,110840102,'alipay-mp',61,'2088122860738265',''),(101,110840102,'alipay-mp',0,'2088002571742873',''),(102,110840102,'alipay-mp',63,'2088612079964705',''),(103,110840102,'alipay-mp',64,'2088422888814810',''),(104,110840102,'alipay-mp',0,'2088612197486147',''),(105,110840102,'alipay-mp',0,'2088812700419983',''),(106,110840102,'wechat-mp',52,'oaBYI5RCqb3W17wnfsGJp1l-gYBo','i1Ed8OHjOKq2u07X/87k1A=='),(107,110840102,'alipay-mp',65,'2088602293566423',''),(108,110840102,'wechat-mp',66,'oaBYI5YPuEGTkWXxvG_ZL155AXvg','VXbKbNcdmLUpzy4F0ROXyg=='),(109,110840102,'alipay-mp',68,'2088622759417160',''),(110,110840102,'wechat-mp',21,'oaBYI5dOISoz0FBmP3c-86oPdLFs','P4n666SWqCUp1X2+DxrIRg=='),(111,110840102,'wechat-mp',67,'oaBYI5RDmdUqpjhk5uxXMZxHBaz4','pDA8pcuv7hl+rGy51f5aSQ=='),(112,110840102,'wechat-mp',20,'oaBYI5WZpBKOJMoM24fY-Si-LqMk','HqDsrFKLk6nPEUjLjXJAtw=='),(113,110840102,'wechat-mp',69,'oaBYI5Z9yxPxKkjiwKdH9qFxCTEE','6+56FZ0aLo/dt5XTioz/4Q=='),(114,110840102,'alipay-mp',0,'2088532636361975',''),(115,110840102,'alipay-mp',70,'2088902023242185',''),(116,110840102,'alipay-mp',71,'2088602243459702',''),(117,110840102,'alipay-mp',72,'2088232995481911',''),(118,110840102,'alipay-mp',0,'2088022827160534',''),(119,110840102,'alipay-mp',0,'2088332412971732',''),(120,110840102,'wechat-mp',73,'oaBYI5SZ54AUI8o90oqyBb1C4GR0','C6FRCb6JNSEFH59GBW10Kw=='),(121,110840102,'alipay-mp',74,'2088112330708816',''),(122,110840102,'alipay-mp',75,'2088212599675792',''),(123,110840102,'wechat-mp',76,'oaBYI5XkxVVaxRsSaCSqKO3xdYzI','YulFHsotYxEL5+CKuQC5XA=='),(124,110840102,'alipay-mp',77,'2088712310985044',''),(125,110840102,'alipay-mp',76,'2088122657427161',''),(126,110840102,'alipay-mp',0,'2088922530600281',''),(127,110840102,'alipay-mp',0,'2088832764478193',''),(128,110840102,'alipay-mp',0,'2088912483688380',''),(129,110840102,'wechat-mp',0,'oaBYI5Q8BUPfGpc-AGSJ8Mhb0fmk','r6dZmsO0LJGKWzSklhf4Kw=='),(130,110840102,'alipay-mp',0,'2088802680406206',''),(131,110840102,'wechat-mp',78,'oaBYI5eXNW02m9-ytXm14s7II2tQ','N5JopFOCr4764VjEzhLoJg=='),(132,110840102,'alipay-mp',79,'2088902000802388',''),(133,110840102,'alipay-mp',80,'2088602277546254',''),(134,110840102,'wechat-mp',0,'oaBYI5YVDNtLHQSL1HSssPELEaPU','KY61ICJgZ56WABipJm04KQ=='),(135,110840102,'alipay-mp',0,'2088012797417390',''),(136,110840102,'wechat-mp',0,'oaBYI5cYBL2b_wcZQWF9Uck2BXN8','HTuQsR7GWPNmaZR2iYGTYA=='),(137,110840102,'alipay-mp',81,'2088622101579960',''),(138,110840102,'alipay-mp',0,'2088612953742977',''),(139,110840102,'alipay-mp',0,'2088422905512305',''),(140,110840102,'alipay-mp',0,'2088012365394140',''),(141,110840102,'wechat-mp',0,'oaBYI5cKgvrDD3i9hUOcUnKRacdU','FRlqQbAkJvzmPVHQcp0/Mw=='),(142,110840102,'wechat-mp',0,'oaBYI5bZtG2-WDv2YjaHIR6-EEsk','kJIB03+aoZbgWOeke+JIfQ=='),(143,110840102,'alipay-mp',0,'2088012062023895',''),(144,110840102,'wechat-mp',0,'oaBYI5apTyH8n452L5vhc81WNVmg','bmU4tIkA07TXThXYKGvEow=='),(145,110840102,'wechat-mp',0,'oaBYI5aTrgizrqwhgGx2t2J-pvC4','5u9V6sKkeQX/pJXBFBDrMA=='),(146,110840102,'alipay-mp',0,'2088622912526472',''),(147,110840102,'alipay-mp',0,'2088142816724010',''),(148,110840102,'wechat-mp',0,'oaBYI5WLpuK-ShkICxmibjXRA1Pc','wfa0Of19LwJQ8KqYheihUw=='),(149,110840102,'alipay-mp',0,'2088102977472074',''),(150,110840102,'alipay-mp',0,'2088132482534620',''),(151,110840102,'alipay-mp',0,'2088302308591294','');
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
  `balance` decimal(16,6) NOT NULL COMMENT '余额',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `delete_at` bigint(20) DEFAULT NULL,
  `user_status` tinyint(3) NOT NULL DEFAULT '1',
  `user_login` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_pass` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_nickname` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_realname` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_url` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` longtext COLLATE utf8mb4_general_ci,
  `signature` longtext COLLATE utf8mb4_general_ci,
  `last_loginip` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_activation_key` longtext COLLATE utf8mb4_general_ci,
  `mobile` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `more` text COLLATE utf8mb4_general_ci,
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
INSERT INTO `cmf_user` VALUES (1,0,0,0,1632815476,0,0,0,0.000000,1626581151,1626855768,0,1,'','','','','','','','','127.0.0.1','','17625458589','',110840102),(2,0,0,0,1630136498,0,0,0,0.000000,1626596718,1626596718,0,1,'','','','','','','','','127.0.0.1','','13038829520','',110840102),(3,0,0,0,1626664596,0,0,0,0.000000,0,0,0,1,'','','','','','','https://tfs.alipayobjects.com/images/partner/T1K9tDXflaXXXXXXXX','','127.0.0.1','','18406575068','',110840102),(4,0,0,0,1626854752,0,0,0,0.000000,1626854751,1626854751,0,1,'','','','','','','','','127.0.0.1','','13423336695','',110840102),(5,0,0,0,1626858308,0,0,0,0.000000,0,0,0,1,'','','','','','','https://tfs.alipayobjects.com/images/partner/TB1GLpYbC1EDuNjHvSuXXcVVXXa','','127.0.0.1','','13537110699','',110840102),(6,0,0,0,1632866199,0,0,0,0.000000,1627119794,1627119794,0,1,'','','','','','','','','127.0.0.1','','13713383744','',110840102),(7,0,0,0,1628419222,0,0,0,0.000000,1628419217,1628419217,0,1,'','','','','','','','','127.0.0.1','','13802943054','',110840102),(8,0,0,0,1628419259,0,0,0,0.000000,1628419254,1628419254,0,1,'','','','','','','','','127.0.0.1','','13247692192','',110840102),(9,0,0,0,1630299184,0,0,0,0.000000,1629642058,1629642058,0,1,'','','','','','','','','127.0.0.1','','13421545056','',110840102),(10,0,0,0,1630135919,0,0,0,0.000000,1629649617,1629649617,0,1,'','','','','','','','','127.0.0.1','','13421506848','',110840102),(11,0,0,0,1629863021,0,0,0,0.000000,1629776482,1629776482,0,1,'','','','','','','','','127.0.0.1','','17051176298','',110840102),(12,0,0,0,1629776765,0,0,0,0.000000,1629776698,1629776804,0,1,'','','王','王','','','','','127.0.0.1','','17324261087','',110840102),(13,0,0,0,1629776746,0,0,0,0.000000,1629776700,1629776700,0,1,'','','','','','','','','127.0.0.1','','18218152318','',110840102),(14,0,0,0,1629776721,0,0,0,0.000000,1629776709,1629776709,0,1,'','','','','','','','','127.0.0.1','','13172226366','',110840102),(15,0,0,0,1629776725,0,0,0,0.000000,1629776720,1629776720,0,1,'','','','','','','','','127.0.0.1','','15625705217','',110840102),(16,0,0,0,1629776785,0,0,0,0.000000,1629776725,1629776760,0,1,'','','','','','','','','127.0.0.1','','13138281142','',110840102),(17,0,0,0,1629776972,0,0,0,0.000000,1629776883,1629776883,0,1,'','','','','','','','','127.0.0.1','','13265234473','',110840102),(18,0,0,0,1629777776,0,0,0,0.000000,1629777769,1629777769,0,1,'','','','','','','','','127.0.0.1','','13549294704','',110840102),(19,0,0,0,1629778196,0,0,0,0.000000,1629778151,1629778151,0,1,'','','','','','','','','127.0.0.1','','13728381468','',110840102),(20,0,0,0,1630037280,0,0,0,0.000000,1629778268,1630037260,0,1,'','','','','','','','','127.0.0.1','','18575391363','',110840102),(21,0,0,0,1630037268,0,0,0,0.000000,1629778278,1630037251,0,1,'','','','','','','','','127.0.0.1','','13424832721','',110840102),(22,0,0,0,1629951265,0,0,0,0.000000,1629778323,1629951226,0,1,'','','','','','','','','127.0.0.1','','18773931352','',110840102),(23,0,0,0,1630296575,0,0,0,0.000000,1629778332,1629778332,0,1,'','','','','','','','','127.0.0.1','','13713296514','',110840102),(24,0,0,0,1630296550,0,0,0,0.000000,1629778340,1629778340,0,1,'','','','','','','','','127.0.0.1','','13650345025','',110840102),(25,0,0,0,1629950501,0,0,0,0.000000,1629778341,1629778341,0,1,'','','','','','','','','127.0.0.1','','15918747451','',110840102),(26,0,0,0,1629952133,0,0,0,0.000000,1629778741,1629778741,0,1,'','','','','','','','','127.0.0.1','','13602300800','',110840102),(27,0,0,0,1629779212,0,0,0,0.000000,1629779180,1629779180,0,1,'','','','','','','','','127.0.0.1','','15252782292','',110840102),(28,0,0,0,1629779495,0,0,0,0.000000,1629779456,1629779456,0,1,'','','','','','','','','127.0.0.1','','13974838013','',110840102),(29,0,0,0,1629780148,0,0,0,0.000000,1629780110,1629780110,0,1,'','','','','','','','','127.0.0.1','','13903030761','',110840102),(30,0,0,0,1629781569,0,0,0,0.000000,1629781453,1629781453,0,1,'','','','','','','','','127.0.0.1','','13532439131','',110840102),(31,0,0,0,1629781781,0,0,0,0.000000,1629781766,1629781766,0,1,'','','','','','','','','127.0.0.1','','18344306785','',110840102),(32,0,0,0,1629783424,0,0,0,0.000000,1629783359,1629783359,0,1,'','','','','','','','','127.0.0.1','','13725842913','',110840102),(33,0,0,0,1629783741,0,0,0,0.000000,1629783622,1629783622,0,1,'','','','','','','','','127.0.0.1','','13549429244','',110840102),(34,0,0,0,1629802875,0,0,0,0.000000,1629802845,1629802845,0,1,'','','','','','','','','127.0.0.1','','15999741725','',110840102),(35,0,0,0,1630296537,0,0,0,0.000000,1629803921,1629803921,0,1,'','','','','','','','','127.0.0.1','','16602021981','',110840102),(36,0,0,0,1629808666,0,0,0,0.000000,1629808625,1629808625,0,1,'','','','','','','','','127.0.0.1','','13129726489','',110840102),(37,0,0,0,1629808778,0,0,0,0.000000,1629808713,1629808713,0,1,'','','','','','','','','127.0.0.1','','18681169190','',110840102),(38,0,0,0,1629862990,0,0,0,0.000000,1629862942,1629862942,0,1,'','','','','','','','','127.0.0.1','','13556696350','',110840102),(39,0,0,0,1630296569,0,0,0,0.000000,1629864524,1629864524,0,1,'','','','','','','','','127.0.0.1','','13332648195','',110840102),(40,0,0,0,1629864692,0,0,0,0.000000,1629864630,1629864630,0,1,'','','','','','','','','127.0.0.1','','13763138490','',110840102),(41,0,0,0,1629864756,0,0,0,0.000000,1629864641,1629864641,0,1,'','','','','','','','','127.0.0.1','','15622775293','',110840102),(42,0,0,0,1629869134,0,0,0,0.000000,1629864643,1629864643,0,1,'','','','','','','','','127.0.0.1','','13728202687','',110840102),(43,0,0,0,1629864773,0,0,0,0.000000,1629864650,1629864650,0,1,'','','','','','','','','127.0.0.1','','13539005809','',110840102),(44,0,0,0,1629865176,0,0,0,0.000000,1629865097,1629865097,0,1,'','','','','','','','','127.0.0.1','','13412996636','',110840102),(45,0,0,0,1629865816,0,0,0,0.000000,1629865808,1629865808,0,1,'','','','','','','','','127.0.0.1','','15501508967','',110840102),(46,0,0,0,1629865836,0,0,0,0.000000,1629865816,1629865816,0,1,'','','','','','','','','127.0.0.1','','15013021879','',110840102),(47,0,0,0,1629865924,0,0,0,0.000000,1629865893,1629865893,0,1,'','','','','','','','','127.0.0.1','','15728711603','',110840102),(48,0,0,0,1629867238,0,0,0,0.000000,1629867189,1629867189,0,1,'','','','','','','','','127.0.0.1','','13549290390','',110840102),(49,0,0,0,1629886279,0,0,0,0.000000,1629886208,1629886208,0,1,'','','','','','','','','127.0.0.1','','15798036881','',110840102),(50,0,0,0,1629949057,0,0,0,0.000000,1629949026,1629949026,0,1,'','','','','','','','','127.0.0.1','','13532838233','',110840102),(51,0,0,0,1629949761,0,0,0,0.000000,1629949551,1629949551,0,1,'','','','','','','','','127.0.0.1','','13751230918','',110840102),(52,0,0,0,1630036567,0,0,0,0.000000,1629949899,1630036545,0,1,'','','','','','','','','127.0.0.1','','13538688221','',110840102),(53,0,0,0,1630036529,0,0,0,0.000000,1629949901,1629949901,0,1,'','','','','','','','','127.0.0.1','','15989921674','',110840102),(54,0,0,0,1629950201,0,0,0,0.000000,1629950146,1629950146,0,1,'','','','','','','','','127.0.0.1','','15392269773','',110840102),(55,0,0,0,1629950594,0,0,0,0.000000,1629950543,1629950543,0,1,'','','','','','','','','127.0.0.1','','13728168527','',110840102),(56,0,0,0,1629950666,0,0,0,0.000000,1629950572,1629950572,0,1,'','','','','','','','','127.0.0.1','','13925559681','',110840102),(57,0,0,0,1629950752,0,0,0,0.000000,1629950685,1629950685,0,1,'','','','','','','','','127.0.0.1','','13242970852','',110840102),(58,0,0,0,1629951049,0,0,0,0.000000,1629951022,1629951022,0,1,'','','','','','','','','127.0.0.1','','13662937812','',110840102),(59,0,0,0,1629951126,0,0,0,0.000000,1629951089,1629951089,0,1,'','','','','','','','','127.0.0.1','','13712257146','',110840102),(60,0,0,0,1629951192,0,0,0,0.000000,1629951180,1629951180,0,1,'','','','','','','','','127.0.0.1','','17817832518','',110840102),(61,0,0,0,1629951318,0,0,0,0.000000,1629951293,1629951293,0,1,'','','','','','','','','127.0.0.1','','18028277791','',110840102),(62,0,0,0,1629953309,0,0,0,0.000000,1629951322,1629951322,0,1,'','','','','','','','','127.0.0.1','','13925534448','',110840102),(63,0,0,0,1629952522,0,0,0,0.000000,1629952438,1629952438,0,1,'','','','','','','','','127.0.0.1','','13925810953','',110840102),(64,0,0,0,1629952536,0,0,0,0.000000,1629952527,1629952527,0,1,'','','','','','','','','127.0.0.1','','13356458980','',110840102),(65,0,0,0,1630036572,0,0,0,0.000000,1630036551,1630036551,0,1,'','','','','','','','','127.0.0.1','','13790262776','',110840102),(66,0,0,0,1630036674,0,0,0,0.000000,1630036650,1630036650,0,1,'','','','','','','','','127.0.0.1','','13560877200','',110840102),(67,0,0,0,1630037289,0,0,0,0.000000,1630037259,1630037259,0,1,'','','','','','','','','127.0.0.1','','15913771299','',110840102),(68,0,0,0,1630037359,0,0,0,0.000000,1630037301,1630037301,0,1,'','','','','','','','','127.0.0.1','','15207625657','',110840102),(69,0,0,0,1630038043,0,0,0,0.000000,1630038026,1630038026,0,1,'','','','','','','','','127.0.0.1','','13858488610','',110840102),(70,0,0,0,1630066431,0,0,0,0.000000,1630066290,1630066290,0,1,'','','','','','','','','127.0.0.1','','18890289601','',110840102),(71,0,0,0,1630067666,0,0,0,0.000000,1630067622,1630067622,0,1,'','','','','','','','','127.0.0.1','','13978106494','',110840102),(72,0,0,0,1630068478,0,0,0,0.000000,1630068313,1630068313,0,1,'','','','','','','','','127.0.0.1','','19864158630','',110840102),(73,0,0,0,1630116960,0,0,0,0.000000,1630116877,1630116877,0,1,'','','','','','','','','127.0.0.1','','15348659589','',110840102),(74,0,0,0,1630296586,0,0,0,0.000000,1630123853,1630123853,0,1,'','','','','','','','','127.0.0.1','','13612737376','',110840102),(75,0,0,0,1630123908,0,0,0,0.000000,1630123861,1630123861,0,1,'','','','','','','','','127.0.0.1','','13414605805','',110840102),(76,0,0,0,1630124241,0,0,0,0.000000,1630123972,1630124074,0,1,'','','','','','','','','127.0.0.1','','17707997420','',110840102),(77,0,0,0,1630124007,0,0,0,0.000000,1630123991,1630123991,0,1,'','','','','','','','','127.0.0.1','','13790444010','',110840102),(78,0,0,0,1630296974,0,0,0,0.000000,1630296953,1630296953,0,1,'','','','','','','','','127.0.0.1','','13827848469','',110840102),(79,0,0,0,1630297834,0,0,0,0.000000,1630297793,1630297793,0,1,'','','','','','','','','127.0.0.1','','15907513582','',110840102),(80,0,0,0,1630297952,0,0,0,0.000000,1630297910,1630297910,0,1,'','','','','','','','','127.0.0.1','','13113180879','',110840102),(81,0,0,0,1630319936,0,0,0,0.000000,1630319935,1630319935,0,1,'','','','','','','','','127.0.0.1','','18344073754','',110840102);
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
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
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
  `delete_at` bigint(20) DEFAULT '0' COMMENT '''删除时间''',
  `template_id` varchar(28) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板ID',
  `sync_to_alipay` tinyint(2) NOT NULL DEFAULT '0' COMMENT '同步到支付宝卡包',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_voucher`
--

LOCK TABLES `cmf_voucher` WRITE;
/*!40000 ALTER TABLE `cmf_voucher` DISABLE KEYS */;
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
  `mid` bigint(20) NOT NULL COMMENT '对应小程序id',
  `voucher_id` int(11) NOT NULL COMMENT '所属优惠券模板id',
  `voucher_type` tinyint(3) NOT NULL COMMENT '优惠券类型(0 => 全场: 1=> 单品)',
  `valid_start_at` int(11) NOT NULL COMMENT '发放开始时间',
  `valid_end_at` int(11) NOT NULL COMMENT '有效截止时间',
  `user_id` int(11) DEFAULT NULL COMMENT '所属人信息',
  `alipay_voucher_id` varchar(28) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付宝券id',
  `create_at` bigint(20) DEFAULT NULL,
  `update_at` bigint(20) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态（0：待使用,1：已使用，2：已过期）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_voucher_post`
--

LOCK TABLES `cmf_voucher_post` WRITE;
/*!40000 ALTER TABLE `cmf_voucher_post` DISABLE KEYS */;
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
-- Dumping events for database 'tenant_1926804902'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `memberOrderCloseStatus` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-15 15:03:06' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `memberStatus` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-15 15:03:06' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card SET status = -1 WHERE end_at between 0 AND UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-15 15:03:05' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderFinishStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-15 15:03:05' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > appointment_at + 43200 */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `rechargeOrderCloseStatus` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `rechargeOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-15 15:03:06' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_recharge_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `voucher` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucher` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-15 15:03:05' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher SET status = 2 WHERE UNIX_TIMESTAMP(publish_end_time) < UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucherPost` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-15 15:03:05' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher_post SET status = 2 WHERE valid_end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tenant_1926804902'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:06:47
