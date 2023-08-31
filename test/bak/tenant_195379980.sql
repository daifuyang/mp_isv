-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: tenant_195379980
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
-- Current Database: `tenant_195379980`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenant_195379980` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tenant_195379980`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_notice`
--

LOCK TABLES `cmf_admin_notice` WRITE;
/*!40000 ALTER TABLE `cmf_admin_notice` DISABLE KEYS */;
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
INSERT INTO `cmf_admin_user` VALUES (1,0,0,1624897123,0,0,1,'15529271507','21938e43496cfce26b875f4779abd9da','15529271507','','','','','15529271507','');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_applyment`
--

LOCK TABLES `cmf_applyment` WRITE;
/*!40000 ALTER TABLE `cmf_applyment` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,1946718,1624897210,1,'e069d5fe-46c3-4a53-48c9-7ff779e92f29','dd61f33e34f8d1ab1e8d3c108ebdeafe.jpg','10a709045606a7bbb3557b89d4603134.jpg','default/20210629/10a709045606a7bbb3557b89d4603134.jpg','jpg',0,'',0),(2,1,78898,1624897441,1,'fc968251-2360-43cf-5863-910d5d4a2e02','part-00523-1394.jpg','b261326ff08ef464af9da1b46e5cb971.jpg','default/20210629/b261326ff08ef464af9da1b46e5cb971.jpg','jpg',0,'',0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_desk`
--

LOCK TABLES `cmf_desk` WRITE;
/*!40000 ALTER TABLE `cmf_desk` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_desk_category`
--

LOCK TABLES `cmf_desk_category` WRITE;
/*!40000 ALTER TABLE `cmf_desk_category` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food`
--

LOCK TABLES `cmf_food` WRITE;
/*!40000 ALTER TABLE `cmf_food` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category`
--

LOCK TABLES `cmf_food_category` WRITE;
/*!40000 ALTER TABLE `cmf_food_category` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_post`
--

LOCK TABLES `cmf_food_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_post` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order`
--

LOCK TABLES `cmf_food_order` WRITE;
/*!40000 ALTER TABLE `cmf_food_order` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_detail`
--

LOCK TABLES `cmf_food_order_detail` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_detail` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme`
--

LOCK TABLES `cmf_mp_theme` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme` VALUES (1,372924724,0,'只能点一点点','',1,195379980,'default/20210629/b261326ff08ef464af9da1b46e5cb971.jpg','','{}','','','','','',1624897445,0,10000,1625533176),(4,2011759632,0,'ddd','',1,195379980,'default/20210629/b261326ff08ef464af9da1b46e5cb971.jpg','','{}','','','','','',1625533229,0,10000,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_page`
--

LOCK TABLES `cmf_mp_theme_page` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_page` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_page` VALUES (1,1,372924724,1,'首页','home','{}','{}','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 2, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]',1624897445,1624897445),(2,4,2011759632,1,'首页','home','{}','{}','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]',1625533229,1625533229);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_version`
--

LOCK TABLES `cmf_mp_theme_version` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_version` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_option`
--

LOCK TABLES `cmf_option` WRITE;
/*!40000 ALTER TABLE `cmf_option` DISABLE KEYS */;
INSERT INTO `cmf_option` VALUES (1,1,'business_info','{\"email\": \"\", \"mobile\": \"\", \"address\": \"\", \"company\": \"\", \"contact\": \"\", \"app_desc\": \"\", \"app_slogan\": \"\", \"brand_logo\": \"default/20210629/b261326ff08ef464af9da1b46e5cb971.jpg\", \"brand_name\": \"只能点一点点\", \"out_door_pic\": \"\", \"alipay_logo_id\": \"\", \"business_photo\": \"\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"\", \"mini_category_ids\": \"XS1020_XS2168\"}',372924724,0),(2,1,'business_info','{\"email\": \"\", \"mobile\": \"\", \"address\": \"\", \"company\": \"\", \"contact\": \"\", \"app_desc\": \"\", \"app_slogan\": \"\", \"brand_logo\": \"default/20210629/b261326ff08ef464af9da1b46e5cb971.jpg\", \"brand_name\": \"点点点\", \"out_door_pic\": \"\", \"alipay_logo_id\": \"\", \"business_photo\": \"\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"\", \"mini_category_ids\": \"XS1009_XS2075\"}',1327176225,0),(3,1,'business_info','{\"email\": \"\", \"mobile\": \"\", \"address\": \"\", \"company\": \"\", \"contact\": \"\", \"app_desc\": \"\", \"app_slogan\": \"\", \"brand_logo\": \"default/20210629/b261326ff08ef464af9da1b46e5cb971.jpg\", \"brand_name\": \"点点单单\", \"out_door_pic\": \"\", \"alipay_logo_id\": \"\", \"business_photo\": \"\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"\", \"mini_category_ids\": \"XS1009_XS2075\"}',441303738,0),(4,1,'business_info','{\"email\": \"\", \"mobile\": \"\", \"address\": \"\", \"company\": \"\", \"contact\": \"\", \"app_desc\": \"\", \"app_slogan\": \"\", \"brand_logo\": \"default/20210629/b261326ff08ef464af9da1b46e5cb971.jpg\", \"brand_name\": \"ddd\", \"out_door_pic\": \"\", \"alipay_logo_id\": \"\", \"business_photo\": \"\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"\", \"mini_category_ids\": \"XS1009_XS2075\"}',2011759632,0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_pay_log`
--

LOCK TABLES `cmf_pay_log` WRITE;
/*!40000 ALTER TABLE `cmf_pay_log` DISABLE KEYS */;
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
INSERT INTO `cmf_portal_category` VALUES (1,372924724,0,0,1,0,10000,'新鲜事','','','','','','','','','','');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_category_post`
--

LOCK TABLES `cmf_portal_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_category_post` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_post`
--

LOCK TABLES `cmf_portal_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_post` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_printer`
--

LOCK TABLES `cmf_printer` WRITE;
/*!40000 ALTER TABLE `cmf_printer` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_qrcode_post`
--

LOCK TABLES `cmf_qrcode_post` WRITE;
/*!40000 ALTER TABLE `cmf_qrcode_post` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role`
--

LOCK TABLES `cmf_role` WRITE;
/*!40000 ALTER TABLE `cmf_role` DISABLE KEYS */;
INSERT INTO `cmf_role` VALUES (372924724,1,0,'超级管理员','拥有网站最高管理员权限！',10000,1624897445,1624897445,1),(372924724,2,0,'收银员','收银员！',1,1624897445,1624897445,1),(372924724,3,0,'财务','财务！',2,1624897445,1624897445,1),(2011759632,4,0,'超级管理员','拥有网站最高管理员权限！',10000,1625533229,1625533229,1),(2011759632,5,0,'收银员','收银员！',1,1625533229,1625533229,1),(2011759632,6,0,'财务','财务！',2,1625533229,1625533229,1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_store`
--

LOCK TABLES `cmf_store` WRITE;
/*!40000 ALTER TABLE `cmf_store` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_part`
--

LOCK TABLES `cmf_third_part` WRITE;
/*!40000 ALTER TABLE `cmf_third_part` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
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
-- Dumping events for database 'tenant_195379980'
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-06 09:01:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-06 09:01:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card SET status = -1 WHERE end_at between 0 AND UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-06 09:01:53' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderFinishStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-06 09:01:53' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > appointment_at + 43200 */ ;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `rechargeOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-06 09:01:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_recharge_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucher` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-06 09:01:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher SET status = 2 WHERE UNIX_TIMESTAMP(publish_end_time) < UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucherPost` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-06 09:01:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher_post SET status = 2 WHERE valid_end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tenant_195379980'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:06:00
