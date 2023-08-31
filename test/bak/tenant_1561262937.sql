-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: tenant_1561262937
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
-- Current Database: `tenant_1561262937`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenant_1561262937` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tenant_1561262937`;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_address`
--

LOCK TABLES `cmf_address` WRITE;
/*!40000 ALTER TABLE `cmf_address` DISABLE KEYS */;
INSERT INTO `cmf_address` VALUES (1,1654004179,'马',2,1,'18052722480','','','','江苏省无锡市新吴区泰伯花苑泰伯花苑一区',120.4372580,31.5460230,'1',1),(2,1654004179,'马',2,0,'18052722480','','','','江苏省无锡市新吴区梅育路与梅西路交汇处梅里花苑5区2期',120.4257360,31.5393320,'一单元2045',0),(3,1654004179,'戴富阳',4,0,'15161178722','','','','江苏省无锡市新吴区梅里新村一幢3号冒菜行家',120.4313650,31.5425960,'22-1001',0),(4,1654004179,'马梦磊',2,0,'18921358133','','','','江苏省无锡市新吴区新吴区里路与新韵南路交叉口的西南角梅荆花苑六区',120.4462160,31.5350630,'22563',0),(5,1654004179,'马',2,1,'18921358133','','','','江苏省无锡市新吴区无锡梅村服务区',120.4337520,31.5226050,'出口处',0);
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
INSERT INTO `cmf_admin_menu` VALUES (1,'app/dashboard',0,'工作台','/app/:mid/dashboard','icondashboard',0,1),(2,'app/published',0,'小程序','/app/:mid/published','iconmp',0,1),(3,'app/published/dashboard',2,'小程序总览','/app/:mid/published/dashboard','',0,1),(4,'app/published/wechat',2,'微信小程序','/app/:mid/published/wechat','',0,2),(5,'app/published/alipay',2,'支付宝小程序','/app/:mid/published/alipay','',0,3),(6,'app/order/default',0,'订单管理','/app/:mid/order/default','icondetail',0,2),(7,'app/order/business',6,'业务订单','/app/:mid/order/business','',0,10000),(8,'app/order/business/list',7,'订单列表','/app/:mid/order/business/list','',1,1),(9,'app/order/business/id',7,'订单详情','/app/:mid/order/business/:id','',1,1),(10,'app/order/member',6,'会员订单','/app/:mid/order/member','',0,10000),(11,'app/order/recharge',6,'储值订单','/app/:mid/order/coupon','',0,10000),(12,'app/dishes',0,'菜单管理','/app/:mid/dishes','iconappstore',0,3),(13,'app/dishes/goods',12,'菜品管理','/app/:mid/dishes/goods','',0,10000),(14,'app/dishes/goods/index',13,'菜品列表','/app/:mid/dishes/goods/index','',1,10000),(15,'app/dishes/goods/add',13,'添加菜品','/app/:mid/dishes/goods/add','',1,10000),(16,'app/dishes/goods/edit',13,'编辑菜品','/app/:mid/dishes/goods/edit','',1,10000),(17,'app/dishes/category',12,'分类管理','/app/:mid/dishes/category','',0,10000),(18,'app/desk/default',0,'桌位管理','/app/:mid/desk/default','iconapartment',0,4),(19,'app/desk/index',18,'桌位管理','/app/:mid/desk/index','',0,10000),(20,'app/desk/category',18,'桌位类型','/app/:mid/desk/category','',0,10000),(21,'app/member/default',0,'会员管理','/app/:mid/member/default','iconcreditcard',0,5),(22,'app/member/index',21,'用户列表','/app/:mid/member/index','',0,10000),(23,'app/marketing',0,'营销管理','/app/:mid/marketing','icongift',0,70),(24,'app/marketing/card',23,'会员卡设置','/app/:mid/marketing/card','',0,10000),(25,'app/marketing/coupon',23,'优惠券管理','/app/:mid/marketing/coupon','',0,10000),(26,'app/marketing/wechat',23,'微信营销','/app/:mid/marketing/wechat','',0,10000),(27,'app/marketing/recharge',23,'储值管理','/app/:mid/marketing/recharge','',0,10000),(28,'app/marketing/score',23,'积分设置','/app/:mid/marketing/score','',0,10000),(29,'app/theme/default',0,'主题管理','/app/:mid/theme/default','iconbg-colors',0,90),(30,'app/theme/index',29,'主题设置','/app/:mid/theme/index','',0,10),(31,'app/theme/assets',29,'素材中心','/app/:mid/theme/assets','',0,10000),(32,'portal/default',0,'门户管理','/app/:mid/portal','iconfolder-add',0,91),(33,'/app/portal/index',32,'文章管理','/app/:mid/portal/index','',0,10000),(34,'/app/portal/category',32,'分类管理','/app/:mid/portal/category','',0,10000),(35,'/app/portal/category/add',34,'添加分类','/app/:mid/portal/category/add','',1,10000),(36,'/app/portal/category/edit',34,'修改分类','/app/:mid/portal/category/edit/:id','',1,10000),(37,'app/store',0,'门店管理','/app/:mid/store','iconshop',0,92),(38,'app/store/index',37,'门店列表','/app/:mid/store/index','',0,10),(39,'app/store/add',38,'添加门店','/app/:mid/store/add','',1,10000),(40,'app/store/edit',38,'修改门店','/app/:mid/store/edit/:id','',1,10000),(41,'app/store/edit_for_here',38,'堂食设置','/app/:mid/store/edit_for_here/:id','',1,10000),(42,'app/store/edit_take_out',38,'外卖设置','/app/:mid/store/edit_take_out/:id','',1,10000),(43,'app/store/printer',37,'打印机绑定','/app/:mid/store/printer','',0,30),(44,'app/user',0,'账号管理','/app/:mid/user','iconuser',0,100),(45,'app/user/settings',44,'个人设置','/app/:mid/user/settings','',1,1),(46,'app/user/index',44,'账号设置','/app/:mid/user/index','',0,1),(47,'app/user/add',46,'添加管理员','/app/:mid/user/add','',1,10000),(48,'app/user/edit',46,'编辑管理员','/app/:mid/user/edit/:id','',1,10000),(49,'app/user/role',44,'角色设置','/app/:mid/user/role','',0,10000),(50,'app/user/authorize/add',49,'角色权限添加','app/:mid/user/authorize/add','',1,10000),(51,'app/user/authorize/edit',49,'角色权限编辑','/app/:mid/user/authorize/edit/:id','',1,10000),(52,'app/settings',0,'系统设置','/app/:mid/settings','iconsetting',0,110),(53,'app/settings/index',52,'通用设置','/app/:mid/settings/index','',0,10000),(54,'app/settings/contact',52,'客服设置','/app/:mid/settings/contact','',0,10000),(55,'app/settings/delivery',52,'物流设置','/app/:mid/settings/delivery','',0,10000),(56,'app/notice',0,'消息通知','/app/:mid/notice','',1,10000),(57,'app/notice/list',56,'消息列表','/app/:mid/notice/list','',0,10000);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_notice`
--

LOCK TABLES `cmf_admin_notice` WRITE;
/*!40000 ALTER TABLE `cmf_admin_notice` DISABLE KEYS */;
INSERT INTO `cmf_admin_notice` VALUES (1654004179,5,'外卖订单提醒','您有新的外卖订单，请及时处理！',7,1629211087,0,1,'https://cdn.mashangdian.cn/takeout.mp3',1),(1654004179,6,'外卖订单提醒','您有新的外卖订单，请及时处理！',8,1629253855,0,1,'https://cdn.mashangdian.cn/takeout.mp3',1),(1654004179,7,'外卖订单提醒','您有新的外卖订单，请及时处理！',10,1629264219,0,1,'https://cdn.mashangdian.cn/takeout.mp3',1);
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
INSERT INTO `cmf_admin_user` VALUES (1,0,NULL,NULL,NULL,0,1,'18168821617','1f5b3cac55696698981080bf2b1b1710',NULL,NULL,NULL,NULL,NULL,'18168821617',NULL);
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
INSERT INTO `cmf_applyment` VALUES (1,'1628947429',2000002206974325,'{\"indoor\": {\"name\": \"1.png\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt8313i4njLvot71s8a2SlXGhNC_frWtRADQhyYkJ0jiUC4agB3NU716EFGz4w-5IR5x0yybab2kxtoUN6Av2_lU\", \"file_name\": \"f3bead50b0abb99100a04f9e268b7810.png\", \"file_path\": \"tenant/1654004179/20210814/f3bead50b0abb99100a04f9e268b7810.png\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/f3bead50b0abb99100a04f9e268b7810.png\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"李.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt_gD6wouEC1Wl9D98NrlTVrHW6bs5eeZT5NSG42daLNne5n3n75n5nIYVaKF2a9fHIHdlbuzlaL8k3musBYjk-o\", \"file_name\": \"9961e793352bfef1ad602325f368df95.jpg\", \"file_path\": \"tenant/1654004179/20210814/9961e793352bfef1ad602325f368df95.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/9961e793352bfef1ad602325f368df95.jpg\"}, \"license_copy\": {\"name\": \"1.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqtxR3AnwDoJmhsp0WPQiwJcrpt5xiDTj-xchrhW_7JDqqBwg3ofa7GXPr-QM_kFVkd8O2CIphbYw2ujU3b-d7q5Q\", \"file_name\": \"cc7cc48bbe3506d6fffa99895e8ac42a.jpg\", \"file_path\": \"tenant/1654004179/20210814/cc7cc48bbe3506d6fffa99895e8ac42a.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/cc7cc48bbe3506d6fffa99895e8ac42a.jpg\"}, \"mini_program\": [{\"name\": \"1.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt0oyCmR_883RgBLpICKR_JZNH80rZJxXms8dFirvXekL8rbnimL2p7tDd90BhBXOJa9ghkWvyoM7xbAiY4YUzDM\", \"file_name\": \"5b80ad7db6317758f0be81d7558fe04b.jpg\", \"file_path\": \"tenant/1654004179/20210814/5b80ad7db6317758f0be81d7558fe04b.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/5b80ad7db6317758f0be81d7558fe04b.jpg\"}], \"qualifications\": {\"name\": \"1.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt5ffbobYSeaVBp_Op9_oVfbd0VBFZaBHD-1Vz-MVN_05u0sZDIAlJB4Thy48qNU5qqVrfMoSSDfP4yyBJA643D0\", \"file_name\": \"da2101641f3fe3467c902eb550b81ba9.jpg\", \"file_path\": \"tenant/1654004179/20210814/da2101641f3fe3467c902eb550b81ba9.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/da2101641f3fe3467c902eb550b81ba9.jpg\"}, \"store_entrance\": {\"name\": \"1.png\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt9db2q3ZKLXhsTcFssbh_OkqQGU0XOseQR_APt9r2n4FOFp-1myuOD_eUnt_CKpcK37yw5CZ9qnhW7GH3AcWRjw\", \"file_name\": \"8c580e620f06b6365a0796d6bd2eec8e.png\", \"file_path\": \"tenant/1654004179/20210814/8c580e620f06b6365a0796d6bd2eec8e.png\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/8c580e620f06b6365a0796d6bd2eec8e.png\"}, \"id_card_national\": {\"name\": \"李.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt_w0p_fpujfoO1FjdHnqzuKBLijmHLL09vsbiNTQZe8dTGiIrMCjBRjgyo2-nG7IyA_CuiXOEyNad0nernvPwmY\", \"file_name\": \"e07e15232a498fa91229eadc9ceca1d2.jpg\", \"file_path\": \"tenant/1654004179/20210814/e07e15232a498fa91229eadc9ceca1d2.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/e07e15232a498fa91229eadc9ceca1d2.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}','{\"MediaList\": {\"Indoor\": {\"Name\": \"1.png\", \"MediaId\": \"6B5LT-i1XN5gyD4_n7xqt8313i4njLvot71s8a2SlXGhNC_frWtRADQhyYkJ0jiUC4agB3NU716EFGz4w-5IR5x0yybab2kxtoUN6Av2_lU\", \"FileName\": \"f3bead50b0abb99100a04f9e268b7810.png\", \"FilePath\": \"tenant/1654004179/20210814/f3bead50b0abb99100a04f9e268b7810.png\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/f3bead50b0abb99100a04f9e268b7810.png\"}, \"IdDocCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}, \"IdCardCopy\": {\"Name\": \"李.jpg\", \"MediaId\": \"6B5LT-i1XN5gyD4_n7xqt_gD6wouEC1Wl9D98NrlTVrHW6bs5eeZT5NSG42daLNne5n3n75n5nIYVaKF2a9fHIHdlbuzlaL8k3musBYjk-o\", \"FileName\": \"9961e793352bfef1ad602325f368df95.jpg\", \"FilePath\": \"tenant/1654004179/20210814/9961e793352bfef1ad602325f368df95.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/9961e793352bfef1ad602325f368df95.jpg\"}, \"LicenseCopy\": {\"Name\": \"1.jpg\", \"MediaId\": \"6B5LT-i1XN5gyD4_n7xqtxR3AnwDoJmhsp0WPQiwJcrpt5xiDTj-xchrhW_7JDqqBwg3ofa7GXPr-QM_kFVkd8O2CIphbYw2ujU3b-d7q5Q\", \"FileName\": \"cc7cc48bbe3506d6fffa99895e8ac42a.jpg\", \"FilePath\": \"tenant/1654004179/20210814/cc7cc48bbe3506d6fffa99895e8ac42a.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/cc7cc48bbe3506d6fffa99895e8ac42a.jpg\"}, \"MiniProgram\": [{\"Name\": \"1.jpg\", \"MediaId\": \"6B5LT-i1XN5gyD4_n7xqt0oyCmR_883RgBLpICKR_JZNH80rZJxXms8dFirvXekL8rbnimL2p7tDd90BhBXOJa9ghkWvyoM7xbAiY4YUzDM\", \"FileName\": \"5b80ad7db6317758f0be81d7558fe04b.jpg\", \"FilePath\": \"tenant/1654004179/20210814/5b80ad7db6317758f0be81d7558fe04b.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/5b80ad7db6317758f0be81d7558fe04b.jpg\"}], \"StoreEntrance\": {\"Name\": \"1.png\", \"MediaId\": \"6B5LT-i1XN5gyD4_n7xqt9db2q3ZKLXhsTcFssbh_OkqQGU0XOseQR_APt9r2n4FOFp-1myuOD_eUnt_CKpcK37yw5CZ9qnhW7GH3AcWRjw\", \"FileName\": \"8c580e620f06b6365a0796d6bd2eec8e.png\", \"FilePath\": \"tenant/1654004179/20210814/8c580e620f06b6365a0796d6bd2eec8e.png\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/8c580e620f06b6365a0796d6bd2eec8e.png\"}, \"IdCardNational\": {\"Name\": \"李.jpg\", \"MediaId\": \"6B5LT-i1XN5gyD4_n7xqt_w0p_fpujfoO1FjdHnqzuKBLijmHLL09vsbiNTQZe8dTGiIrMCjBRjgyo2-nG7IyA_CuiXOEyNad0nernvPwmY\", \"FileName\": \"e07e15232a498fa91229eadc9ceca1d2.jpg\", \"FilePath\": \"tenant/1654004179/20210814/e07e15232a498fa91229eadc9ceca1d2.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/e07e15232a498fa91229eadc9ceca1d2.jpg\"}, \"Qualifications\": {\"Name\": \"1.jpg\", \"MediaId\": \"6B5LT-i1XN5gyD4_n7xqt5ffbobYSeaVBp_Op9_oVfbd0VBFZaBHD-1Vz-MVN_05u0sZDIAlJB4Thy48qNU5qqVrfMoSSDfP4yyBJA643D0\", \"FileName\": \"da2101641f3fe3467c902eb550b81ba9.jpg\", \"FilePath\": \"tenant/1654004179/20210814/da2101641f3fe3467c902eb550b81ba9.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/da2101641f3fe3467c902eb550b81ba9.jpg\"}, \"BusinessAddition\": [], \"OrganizationCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}}, \"contact_info\": {\"contact_name\": \"Buwffv3mIQWnly5r/WISEaiGviL/KXxDSTjFhoReonX7hLL4yoZK7LLD9M+aG9f8NpKCJumNwwtJcSYeZ0DV6VNWEdtTblkPnIYr3sWkSRwtnoNSYvWtrLPLfjxJ9go/MWr1Nzk/z4FgjVPYry2YsOtQFZuzlHYeRBrTKQ8SvgPIXEDEk/HIRI77sHhllDVyhYL/v3oqhpCXHnVZR1RZH/QUvOfEP7pF/F6/Dmc3P/FTimTAraf3fP30Py+3H1BvKGSpMMAO9t+jQzOpotSjx40mYnK556Uu5lN4FqvxvgNSmgnhUcWtRcfjqryD95IuUQYtWk6Bz88siff4vTGWOg==\", \"mobile_phone\": \"AsaFf8Sr12JnWRnmGwIdHPHUyqAGkQFY/xkr8M+Nhm3IlMH+l6jdaDhVZxEq7RTq9lUNVogvGZYB6iTBnd2O1D9zV+/06BelgDiBcn4HrSelCrPh9Bpi6hchgfp1eTLhG315o1f2SRT9/nL0SxKoz0aKRM0d76OXP6hqWOVPb+hqUXgbaUuEYqiH/t0EuD9698I++zHxDXmbYYXtiMn+5YrHKeWDtAAs53YDXT6bVjXH7VSEuPvsTh5yuwLFGjQOjppNm+1pnzZthG+4XbZAepW+EQk7yeYkCf4CHVnfG1dzclzv4Rr0sjPLDuAHtbANRkynoc2VW965MxHEb/dSsQ==\", \"contact_email\": \"iV1ZO1HpCx4ENXmv+3oxK5wKtSQgE8WKjM2NiFb5OM4dpDjKi/vhiAd+/zTC6xcozMhB3jXqQ87IcXrCMJiDE0zia60YCLrf53pM7KCZdyEylAkAl4dWYIbHb3b34PmUHMZrpi+udliBcYSlwNK8gfNdt2pwIjNiVzSPhT68k5vs45Pomoq0yZnuRWxGJs/ogqJouBSvMTD1C4kdmI0RqyBrpLLWNWlsJpo9OkJt6tgqadJnlFfkyvCvtYrjVd/936Rybcmev/VvuL1VEEP2/t59no11Jv/oVY9X5xA8FWyGrPQG+9lRlfncr8T3cBx/rtmHLB8ZqSEWVnQZmaRsKg==\", \"contact_id_number\": \"M+SXOuythrOuqY1+ngs6NKy+4+cpsQHkduLrn18HuLXIGZbBX/5SdO+wKjY9JWx1hlqRHxnnCBmOh1nOYVtWb5CkZY/0kDUeAVxYIIavwkeXty78DvJ0YJt/CturoWz/rs8jzFh1ys8vt5XUlTP4m3l/MtL7Zsal42vGZDIzEf1wCFJoPP1+XnkSr11d6NNv5lHav5KvqrS6d0Szw8OkxWxY3QZNjaaXmNtBSJWETYuodnMa7TzHkf2OQhNjZAjazcv5uUqXbH0gL+5KQsvJ+WpWXcCsGl3OB/URd486TiAU1InEV1dLfsxzXmlOgg9JAZPwptQK8LvE2FiYVSx8HQ==\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"6B5LT-i1XN5gyD4_n7xqt_gD6wouEC1Wl9D98NrlTVrHW6bs5eeZT5NSG42daLNne5n3n75n5nIYVaKF2a9fHIHdlbuzlaL8k3musBYjk-o\", \"id_card_name\": \"L5Fb/A78KatkPuBo70x668jUZy7KfLtMX3LUjkDPSpsXxSxdurHpz2HFeCemvx3qeTfdyW1xcEv5lYWj0CfO2C43Ka247Js1dimHUxg0VSELfx+Pv3kYG4q/H88iyvL9MIGrfUTOk6YFI67eNHXTcEmonKy3R4bwTXkkpTKv0BHV0fyMWHw0uCmqG0kBaBPZXwBgqEb3QTfIL2aTMNF9d1ejxE380zstAZGjoFKzN5OWhV7InsBkdy4iiq5+rl52DTvv/7V+AmyvXS5eJ3WscOCfSQyMxsJtNkiW9CFEMyifiXZHAxaDZg6JZYjSfJvuH2szrdEoCtgQ5ANcrdieSA==\", \"id_card_number\": \"JAHhYaqXWbADAa10ZEhcCaP8j9gfzwqG7Y7Z5JOkkO0n6ja8b7SVlml6FGdWGGrny7KIm1pzcW4lRJ7H4ewqrq0A9LVQjxoYmFGpAAwsGSc0J3UomLVgpdl5XZTXb/FS+1XqAKGkPsUaCRmaAC7M+RiRvhFP9NzWLO7+RLBIgJPyKH+4C/279fPVN5D6SUEbvAJqnRl867ESO2hIO4fXNuQfLnqf+54VJBtWBQteu1MwFuRfcaLOWg0a0qCO+ADMd1NXHGydmgBoLQiKOJ7bA2lUKNJQHpokkv7e1JI0/QeLEkdzAXDqsoz8oVnUg0RBuNmhCylw1eNAxn9xSsssLQ==\", \"card_period_end\": \"长期\", \"id_card_national\": \"6B5LT-i1XN5gyD4_n7xqt_w0p_fpujfoO1FjdHnqzuKBLijmHLL09vsbiNTQZe8dTGiIrMCjBRjgyo2-nG7IyA_CuiXOEyNad0nernvPwmY\", \"card_period_begin\": \"2021-04-29\"}}, \"business_license_info\": {\"legal_person\": \"李云侠\", \"license_copy\": \"6B5LT-i1XN5gyD4_n7xqtxR3AnwDoJmhsp0WPQiwJcrpt5xiDTj-xchrhW_7JDqqBwg3ofa7GXPr-QM_kFVkd8O2CIphbYw2ujU3b-d7q5Q\", \"merchant_name\": \"新吴区云侠饭店\", \"license_number\": \"92320214MA269F9H2C\"}}, \"business_code\": \"APPLYMENT_1628947428\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"6B5LT-i1XN5gyD4_n7xqt8313i4njLvot71s8a2SlXGhNC_frWtRADQhyYkJ0jiUC4agB3NU716EFGz4w-5IR5x0yybab2kxtoUN6Av2_lU\"], \"biz_store_name\": \"冒菜行家\", \"BizAddressRegion\": [320000, 320200, 320214], \"biz_address_code\": \"320214\", \"biz_store_address\": \"梅里新村一幢3号 冒菜行家\", \"store_entrance_pic\": [\"6B5LT-i1XN5gyD4_n7xqt9db2q3ZKLXhsTcFssbh_OkqQGU0XOseQR_APt9r2n4FOFp-1myuOD_eUnt_CKpcK37yw5CZ9qnhW7GH3AcWRjw\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"6B5LT-i1XN5gyD4_n7xqt0oyCmR_883RgBLpICKR_JZNH80rZJxXms8dFirvXekL8rbnimL2p7tDd90BhBXOJa9ghkWvyoM7xbAiY4YUzDM\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"13151012071\", \"merchant_shortname\": \"冒菜行家\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"6B5LT-i1XN5gyD4_n7xqt5ffbobYSeaVBp_Op9_oVfbd0VBFZaBHD-1Vz-MVN_05u0sZDIAlJB4Thy48qNU5qqVrfMoSSDfP4yyBJA643D0\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"建设银行\", \"account_name\": \"XjYrHr50C1I8z1h4S09Uu0rf6lolu27ifpw8k/Mfddo0qVMtMFmNvndz6OOgAn2JI81YmKHVWB705qAfAJNwhhNFS4/uw2siprUZwMUYfqTMzJXc+UUxdMruk3hQMg/uvQo2JAg7aInipOiehZkoFSG8zUawDlT73e956fjlNoKD0qOHUhYtzi429ttxsO5tLxigZXywtMlWTSmKWLSMLCOCSJtvtWyiYRDqDcSTsfzAM462yMHzdDYosMpC3JkQXOMiMnHGBmdx9ht5lEdkOAeAWVaXmXuy9ghMsT2JjIF4Qjh98Cpev9Nyt25CrYie66PykVtz2GmIm/5Qcalbog==\", \"account_number\": \"cYWqik+I/h3/aFR5KxnJypu9qn/X5PPG8A3xHyV1BCa0f1AGXTPQenNlj6vri93SRB6SrZgfy6XIloHO//aSnpxavTcAENhSRHbA03eHXVyooIYK9SY4KerAFStOqLOldOuyJ3y1quV1hzlVJIyAinxOeEYMpIlmeaStIgvh1EbCNOCODRzKoz5o8Jalilyo1A7De61WtUjdkc5bP6LTDIBl2+7qofURy/AHgRHAwHj67TnoziP15MJ/WeL2FKGidGkbpPNBFs6Stcu2rxWEeeS2SSG6R8436Jc/62uxw381mGZA05P5wv8Sq0QtX+eNfXV4uk1NZieo2uCeSFHKHA==\", \"BankAddressRegion\": [320000, 320400, 320412], \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"320412\"}}','{\"media_list\": {\"indoor\": {\"name\": \"1.png\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt8313i4njLvot71s8a2SlXGhNC_frWtRADQhyYkJ0jiUC4agB3NU716EFGz4w-5IR5x0yybab2kxtoUN6Av2_lU\", \"file_name\": \"f3bead50b0abb99100a04f9e268b7810.png\", \"file_path\": \"tenant/1654004179/20210814/f3bead50b0abb99100a04f9e268b7810.png\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/f3bead50b0abb99100a04f9e268b7810.png\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"李.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt_gD6wouEC1Wl9D98NrlTVrHW6bs5eeZT5NSG42daLNne5n3n75n5nIYVaKF2a9fHIHdlbuzlaL8k3musBYjk-o\", \"file_name\": \"9961e793352bfef1ad602325f368df95.jpg\", \"file_path\": \"tenant/1654004179/20210814/9961e793352bfef1ad602325f368df95.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/9961e793352bfef1ad602325f368df95.jpg\"}, \"license_copy\": {\"name\": \"1.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqtxR3AnwDoJmhsp0WPQiwJcrpt5xiDTj-xchrhW_7JDqqBwg3ofa7GXPr-QM_kFVkd8O2CIphbYw2ujU3b-d7q5Q\", \"file_name\": \"cc7cc48bbe3506d6fffa99895e8ac42a.jpg\", \"file_path\": \"tenant/1654004179/20210814/cc7cc48bbe3506d6fffa99895e8ac42a.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/cc7cc48bbe3506d6fffa99895e8ac42a.jpg\"}, \"mini_program\": [{\"name\": \"1.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt0oyCmR_883RgBLpICKR_JZNH80rZJxXms8dFirvXekL8rbnimL2p7tDd90BhBXOJa9ghkWvyoM7xbAiY4YUzDM\", \"file_name\": \"5b80ad7db6317758f0be81d7558fe04b.jpg\", \"file_path\": \"tenant/1654004179/20210814/5b80ad7db6317758f0be81d7558fe04b.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/5b80ad7db6317758f0be81d7558fe04b.jpg\"}], \"qualifications\": {\"name\": \"1.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt5ffbobYSeaVBp_Op9_oVfbd0VBFZaBHD-1Vz-MVN_05u0sZDIAlJB4Thy48qNU5qqVrfMoSSDfP4yyBJA643D0\", \"file_name\": \"da2101641f3fe3467c902eb550b81ba9.jpg\", \"file_path\": \"tenant/1654004179/20210814/da2101641f3fe3467c902eb550b81ba9.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/da2101641f3fe3467c902eb550b81ba9.jpg\"}, \"store_entrance\": {\"name\": \"1.png\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt9db2q3ZKLXhsTcFssbh_OkqQGU0XOseQR_APt9r2n4FOFp-1myuOD_eUnt_CKpcK37yw5CZ9qnhW7GH3AcWRjw\", \"file_name\": \"8c580e620f06b6365a0796d6bd2eec8e.png\", \"file_path\": \"tenant/1654004179/20210814/8c580e620f06b6365a0796d6bd2eec8e.png\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/8c580e620f06b6365a0796d6bd2eec8e.png\"}, \"id_card_national\": {\"name\": \"李.jpg\", \"media_id\": \"6B5LT-i1XN5gyD4_n7xqt_w0p_fpujfoO1FjdHnqzuKBLijmHLL09vsbiNTQZe8dTGiIrMCjBRjgyo2-nG7IyA_CuiXOEyNad0nernvPwmY\", \"file_name\": \"e07e15232a498fa91229eadc9ceca1d2.jpg\", \"file_path\": \"tenant/1654004179/20210814/e07e15232a498fa91229eadc9ceca1d2.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/1654004179/20210814/e07e15232a498fa91229eadc9ceca1d2.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}, \"contact_info\": {\"contact_name\": \"李云侠\", \"mobile_phone\": \"18168821617\", \"contact_email\": \"18168821617@163.com\", \"contact_id_number\": \"342130196706074820\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_info\": {\"id_doc_copy\": \"\", \"id_doc_name\": \"\", \"id_doc_number\": \"\", \"doc_period_end\": \"\", \"doc_period_begin\": \"\"}, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"6B5LT-i1XN5gyD4_n7xqt_gD6wouEC1Wl9D98NrlTVrHW6bs5eeZT5NSG42daLNne5n3n75n5nIYVaKF2a9fHIHdlbuzlaL8k3musBYjk-o\", \"id_card_name\": \"李云侠\", \"id_card_number\": \"342130196706074820\", \"card_period_end\": \"长期\", \"id_card_national\": \"6B5LT-i1XN5gyD4_n7xqt_w0p_fpujfoO1FjdHnqzuKBLijmHLL09vsbiNTQZe8dTGiIrMCjBRjgyo2-nG7IyA_CuiXOEyNad0nernvPwmY\", \"card_period_begin\": \"2021-04-29\"}}, \"organization_info\": {}, \"business_license_info\": {\"legal_person\": \"李云侠\", \"license_copy\": \"6B5LT-i1XN5gyD4_n7xqtxR3AnwDoJmhsp0WPQiwJcrpt5xiDTj-xchrhW_7JDqqBwg3ofa7GXPr-QM_kFVkd8O2CIphbYw2ujU3b-d7q5Q\", \"merchant_name\": \"新吴区云侠饭店\", \"license_number\": \"92320214MA269F9H2C\"}}, \"addition_info\": {}, \"business_code\": \"APPLYMENT_1628947428\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"6B5LT-i1XN5gyD4_n7xqt8313i4njLvot71s8a2SlXGhNC_frWtRADQhyYkJ0jiUC4agB3NU716EFGz4w-5IR5x0yybab2kxtoUN6Av2_lU\"], \"biz_store_name\": \"冒菜行家\", \"biz_address_code\": \"320214\", \"biz_store_address\": \"梅里新村一幢3号 冒菜行家\", \"biz_address_region\": [320000, 320200, 320214], \"store_entrance_pic\": [\"6B5LT-i1XN5gyD4_n7xqt9db2q3ZKLXhsTcFssbh_OkqQGU0XOseQR_APt9r2n4FOFp-1myuOD_eUnt_CKpcK37yw5CZ9qnhW7GH3AcWRjw\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"6B5LT-i1XN5gyD4_n7xqt0oyCmR_883RgBLpICKR_JZNH80rZJxXms8dFirvXekL8rbnimL2p7tDd90BhBXOJa9ghkWvyoM7xbAiY4YUzDM\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"13151012071\", \"merchant_shortname\": \"冒菜行家\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"6B5LT-i1XN5gyD4_n7xqt5ffbobYSeaVBp_Op9_oVfbd0VBFZaBHD-1Vz-MVN_05u0sZDIAlJB4Thy48qNU5qqVrfMoSSDfP4yyBJA643D0\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"建设银行\", \"account_name\": \"李云侠\", \"account_number\": \"6217001260004532258\", \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"320412\", \"bank_address_region\": [320000, 320400, 320412]}}',1628947429,1629090470,'1612976011','https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQF28DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyNVlYQzhVb3JlUjIxbmtyMXh4Y2MAAgTUzhlhAwQAjScA','APPLYMENT_STATE_FINISHED','','[]');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,53418,1625984602,1,'cf041cc4-6598-4b81-6b98-4529d1c83bef','冒菜行家.jpg','6bd0c17f3c7e221070d022b66da4d312.jpg','default/20210711/6bd0c17f3c7e221070d022b66da4d312.jpg','jpg',0,'',0),(2,1,130358,1625985697,1,'8d532801-790f-448c-775d-36842a0eec9b','冒菜行家副本.jpg','ac0d1ba6fbe4d474ae85f53c418c86c0.jpg','tenant/1654004179/20210711/ac0d1ba6fbe4d474ae85f53c418c86c0.jpg','jpg',0,'',1654004179),(3,1,361859,1626014150,1,'1f604252-af0e-453f-6355-d17e8ee4613d','食品生鲜海鲜虾蟹小程序封面图.jpg','8ebfb073dc9ae2ca79c6cdaa45f80e69.jpg','tenant/1654004179/20210711/8ebfb073dc9ae2ca79c6cdaa45f80e69.jpg','jpg',0,'',1654004179),(4,1,2711303,1626016006,1,'c0cdbf9f-5e34-4dea-5319-6267dd06ceb2','maocai.png','1dbe09cbe9e9641b594365b039d12d77.png','tenant/1654004179/20210711/1dbe09cbe9e9641b594365b039d12d77.png','png',0,'',1654004179),(5,1,424750,1626016316,1,'0216f966-4896-42e5-7f43-6ad7c47c1dc6','图怪兽_cf95c393248420731806b450d8f87613_88555.jpg','03215c349297dc84246585f6d62999de.jpg','tenant/1654004179/20210711/03215c349297dc84246585f6d62999de.jpg','jpg',0,'',1654004179),(6,1,8723,1626017185,1,'6deb5efc-49e0-438e-7923-4d1517cba4d3','堂食.png','6636881af32570fdc60b0f02d68c4e8b.png','tenant/1654004179/20210711/6636881af32570fdc60b0f02d68c4e8b.png','png',0,'',1654004179),(7,1,30011,1626017244,1,'9b91ba82-3bc1-42c1-5b51-d3fc8dc77939','ts.png','3f966c7c2c77981e5761cc7b7a807c2e.png','tenant/1654004179/20210711/3f966c7c2c77981e5761cc7b7a807c2e.png','png',0,'',1654004179),(8,1,16533,1626017752,1,'e8a6363c-af6b-40cf-577c-3609c5fd49a4','ws.png','ce3170ae763cfdfa1c974f41ab1ba11b.png','tenant/1654004179/20210711/ce3170ae763cfdfa1c974f41ab1ba11b.png','png',0,'',1654004179),(9,1,116545,1626018270,1,'803ac4db-feef-443e-5825-88c294cbae64','橙色店铺满减优惠券.png','0baa3b67efb22f088629c9e871ecc5e8.png','tenant/1654004179/20210711/0baa3b67efb22f088629c9e871ecc5e8.png','png',0,'',1654004179),(10,1,220157,1626018511,1,'2827a23c-8685-42ea-7fde-3e1129dfa559','打折促销_福利_简约_公众号首图.jpg','1312c69855d5a5cae7ff684f06d398f8.jpg','tenant/1654004179/20210711/1312c69855d5a5cae7ff684f06d398f8.jpg','jpg',0,'',1654004179),(11,1,441196,1626018746,1,'89405837-8cff-42f3-67e3-c760c5812821','进群.jpg','c435e40f09a441a6482481297b97ef27.jpg','tenant/1654004179/20210711/c435e40f09a441a6482481297b97ef27.jpg','jpg',0,'',1654004179),(12,1,324622,1626018860,1,'703f0f1e-db4a-4449-5f21-61bedee9d37d','打折促销_福利_简约_公众号首图 (1).jpg','d26ea187adc4ad3f9e98b47cc84882af.jpg','tenant/1654004179/20210711/d26ea187adc4ad3f9e98b47cc84882af.jpg','jpg',0,'',1654004179),(13,1,275892,1626019230,1,'abd5e07f-45ea-41e3-565d-bd21b32a04bd','外卖.jpg','d94ebf1972806a2b4ab6713ea9cc0a57.jpg','tenant/1654004179/20210712/d94ebf1972806a2b4ab6713ea9cc0a57.jpg','jpg',0,'',1654004179),(14,1,1709959,1626019446,1,'9afe62f5-88ae-4092-564c-d1e7f0d39b9d','餐饮线上营业外卖菜单长图海报.jpg','1dac55df4eadac0abb76c86ced5d06c5.jpg','default/20210712/1dac55df4eadac0abb76c86ced5d06c5.jpg','jpg',0,'',0),(15,1,60642,1626175900,1,'77199ae7-e1a5-4b97-6667-a0346917b9f1','冒菜.jpg','745408e8a99b8f10f15844381c955937.jpg','tenant/1654004179/20210713/745408e8a99b8f10f15844381c955937.jpg','jpg',0,'',1654004179),(16,1,15295,1626176356,1,'d2ee292d-e36e-41a0-485a-6767b04d1f0f','店招.jpg','f4be28d9591a24cd5e15abe8f51925c7.jpg','tenant/1654004179/20210713/f4be28d9591a24cd5e15abe8f51925c7.jpg','jpg',0,'',1654004179),(17,1,141183,1628830297,1,'b6f0ffd9-5850-4a0f-4256-efeea0173b63','微信图片_20210813124954.jpg','a534d10b3fcf62d70e97a653b81d294b.jpg','tenant/1654004179/20210813/a534d10b3fcf62d70e97a653b81d294b.jpg','jpg',0,'',1654004179);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule`
--

LOCK TABLES `cmf_auth_rule` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule_api`
--

LOCK TABLES `cmf_auth_rule_api` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule_api` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_exp_log`
--

LOCK TABLES `cmf_exp_log` WRITE;
/*!40000 ALTER TABLE `cmf_exp_log` DISABLE KEYS */;
INSERT INTO `cmf_exp_log` VALUES (1,2,0,'6.00','消费',1629211087),(2,2,0,'5.99','消费',1629253855),(3,2,0,'5.99','消费',1629264219);
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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food`
--

LOCK TABLES `cmf_food` WRITE;
/*!40000 ALTER TABLE `cmf_food` DISABLE KEYS */;
INSERT INTO `cmf_food` VALUES (1,'1654004179','','秘制微微辣','',0,0,'',0,0.00,0,0.00,0.00,0.00,-1,-1,0,1,'','',0,0,'',1626012177,1626012177,1629262373,0.1,'碗','','','',1,138,1),(2,'1654004179','','手工新鲜小鱼丸','鲜活的草鱼肉现做现卖！强烈推荐！！！\n主要原料：鱼丸,其他,鱼,鱼肉',0,0,'',0,0.00,0,0.00,2.99,0.00,-1,-1,0,1,'tenant/1654004179/20210713/f6822af4261d89d368033f53bae4ajpg.jpg','',0,0,'',1626172921,1626172925,0,0,'','','','',1,94,1),(3,'1654004179','','单人套餐（2荤多素）','贡丸，燕饺，亲亲肠，鲍鱼片，香肠，黄豆芽、海带丝等菜品，商家随机分配\n主要原料：黄豆,黄豆芽,豆芽,海带,香肠,鲍鱼,其他,鱼,肉丸',0,0,'',0,0.00,0,0.00,14.76,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ffdd6cc9687c9f495cb7aa7eeb2a6jpg.jpg','',0,0,'',1626172922,1626172923,0,0,'','','','',1,97,1),(4,'1654004179','','冒菜锅底','主要原料：香菜,芝麻,其他',0,1,'[{\"attr_key\":\"秘制口味\",\"attr_val\":[\"秘制骨汤不辣\",\"秘制微微辣\",\"秘制微辣\",\"秘制中辣\",\"秘制重辣\"]},{\"attr_key\":\"调料\",\"attr_val\":[\"香菜芝麻\",\"不加香菜\"]}]',0,0.00,0,0.00,0.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/31c917601d352a38193378f1b2e62jpg.jpg','',0,0,'',1629262052,1629262052,0,0,'份','','','',1,98,1),(5,'1654004179','','双人套餐（4荤多素）','亲亲肠，燕饺，黄豆芽，油面筋，贡丸，鲍鱼片，土豆，脆皮鱼豆腐等等，具体商家随机搭配。\n主要原料：面筋,土豆,黄豆,豆腐,豆芽,鲍鱼,其他,油,鱼,肉丸',0,0,'',0,0.00,0,0.00,25.84,0.00,-1,-1,0,1,'tenant/1654004179/20210713/32c29e070e7e86868bbcfa1297727jpg.jpg','',0,0,'',1626172924,1626172924,0,0,'','','','',1,96,1),(6,'1654004179','','3-4人套餐（6荤多素）','牛柳，里脊肉，火腿肠，亲亲肠，燕饺，平菇，黄豆芽，油面筋，贡丸，鲍鱼片，土豆，脆皮鱼豆腐等等，具体商家随机搭配！\n主要原料：面筋,土豆,黄豆,豆芽,平菇,火腿,鲍鱼,其他,油,鱼',0,0,'',0,0.00,0,0.00,39.44,0.00,-1,-1,0,1,'tenant/1654004179/20210713/7d85fa49a515f3c0a4800f9c0222fjpg.jpg','',0,0,'',1626172925,1626172925,0,0,'','','','',1,95,1),(7,'1654004179','','猪肘子扣肉','猪肘子！强烈推荐！！！\n主要原料：其他',0,0,'',0,0.00,0,0.00,5.99,0.00,-1,-1,0,1,'tenant/1654004179/20210713/662d87fb3e87afb5f3086ed5c1554jpg.jpg','',0,0,'',1626172926,1626172926,0,0,'','','','',1,93,1),(8,'1654004179','','鲜活基围虾','鲜活基尾虾！强烈推荐！！！\n主要原料：其他',0,0,'',0,0.00,0,0.00,3.99,0.00,-1,-1,0,1,'tenant/1654004179/20210713/0ca723dd7dc5f0bdc30979bc97d20jpg.jpg','',0,0,'',1626172928,1626172928,0,0,'','','','',1,92,1),(9,'1654004179','','暗送秋波','主要原料：菠菜,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/d5a5eb3f5d45f32819f19bb3bc298jpg.jpg','',0,0,'',1626172928,1626172928,0,0,'','','','',1,91,1),(10,'1654004179','','香菜','主要原料：菠菜,香菜,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cbf404717c332b1ddb4e37b3b85bejpg.jpg','',0,0,'',1626172929,1626172929,0,0,'','','','',1,90,1),(11,'1654004179','','小青菜儿','主要原料：青菜,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ffdf71b1ee31dc570219a32385412jpg.jpg','',0,0,'',1626172930,1626172930,0,0,'','','','',1,89,1),(12,'1654004179','','沙拉拉生菜','主要原料：生菜,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/73fada6789943ef017c8a58d9c23ejpg.jpg','',0,0,'',1626172931,1626172931,0,0,'','','','',1,88,1),(13,'1654004179','','娃娃菜菜','新鲜娃娃菜\n主要原料：其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/9130dbb549ae8df87d4d10cbc766djpg.jpg','',0,0,'',1626172931,1626172931,0,0,'','','','',1,87,1),(14,'1654004179','','鲜小木耳','黑木耳\n主要原料：木耳,黑木耳,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/e2f2a2978d451dcb8f1ceee7e2723jpg.jpg','',0,0,'',1626172932,1626172932,0,0,'','','','',1,86,1),(15,'1654004179','','冒菜鸭血（5片）','人气推荐\n主要原料：鸭血,其他',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/fda3f1731fcac9096003facb16b07jpg.jpg','',0,0,'',1626172933,1626172933,0,0,'','','','',1,85,1),(16,'1654004179','','鲜黄豆芽','主要原料：黄豆,黄豆芽,豆芽,海带,其他',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/51b0ae3ac082bc50a68fd2ec829f2jpg.jpg','',0,0,'',1626172934,1626172934,0,0,'','','','',1,84,1),(17,'1654004179','','年糕','主要原料：年糕,其他',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/a8955fd21834feafe0a0751ba519djpg.jpg','',0,0,'',1626172935,1626172935,0,0,'','','','',1,83,1),(18,'1654004179','','土豆片','主要原料：土豆,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/47daab0b4e2d2a5026af448b2a45ejpg.jpg','',0,0,'',1626172936,1626172936,0,0,'','','','',1,82,1),(19,'1654004179','','老谭酸菜','主要原料：魔芋,酸菜,其他',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/52b3261f3385e03b74d85cec9efd6jpg.jpg','',0,0,'',1626172936,1626172936,0,0,'','','','',1,81,1),(20,'1654004179','','魔芋块','减脂优选\n主要原料：魔芋,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/784451fb5ccca7281345f691df3f0jpg.jpg','',0,0,'',1626172937,1626172937,0,0,'','','','',1,80,1),(21,'1654004179','','海带结','招牌必点\n主要原料：海带,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/8559cd4c3001252c5d5ede69ca9e9jpg.jpg','',0,0,'',1626172938,1626172938,0,0,'','','','',1,79,1),(22,'1654004179','','海带丝','主要原料：海带,其他',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/2ef32380dc8920092751ccbe7b235jpg.jpg','',0,0,'',1626172939,1626172939,0,0,'','','','',1,78,1),(23,'1654004179','','金针菇','主要原料：金针菇,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/c46c681b8f15375a344b4e2503882jpg.jpg','',0,0,'',1626172939,1626172939,0,0,'','','','',1,77,1),(24,'1654004179','','香菇','主要原料：香菇,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/25624943471d0a97aaf46a0348d06jpg.jpg','',0,0,'',1626172940,1626172940,0,0,'','','','',1,76,1),(25,'1654004179','','平菇','主要原料：平菇,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/c9b7a7993bdd31276841a6ba6aa82jpg.jpg','',0,0,'',1626172941,1626172941,0,0,'','','','',1,75,1),(26,'1654004179','','翡翠莴笋','主要原料：笋,莴笋,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/b6f2e4b35c10c602cbf094f9d20bajpg.jpg','',0,0,'',1626172942,1626172942,0,0,'','','','',1,74,1),(27,'1654004179','','藕滴片','主要原料：其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/1a9615270198632618b3858a6128fjpg.jpg','',0,0,'',1626172942,1626172942,0,0,'','','','',1,73,1),(28,'1654004179','','冬笋片','主要原料：笋,海带,其他',0,0,'',0,0.00,0,0.00,4.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/6e7bb1282ee6a5c0bdba9af72d910jpg.jpg','',0,0,'',1626172943,1626172943,0,0,'','','','',1,72,1),(29,'1654004179','','四川空运笋尖（7条）','四川经典\n主要原料：笋,其他',0,0,'',0,0.00,0,0.00,4.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cd6a1d79368a4f5aa9aaa59c8106fjpg.jpg','',0,0,'',1626172944,1626172944,0,0,'','','','',1,71,1),(30,'1654004179','','有机花菜','主要原料：花菜,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/8d03f38479bb21d5544040650f083jpg.jpg','',0,0,'',1626172944,1626172944,0,0,'','','','',1,70,1),(31,'1654004179','','冬瓜片','主要原料：冬瓜,其他',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/67400fde2ce9d3c0490ba41422750jpg.jpg','',0,0,'',1626172945,1626172945,0,0,'','','','',1,69,1),(32,'1654004179','','爆汁油面筋','主要原料：油面筋,面筋,其他,油',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/600b2e00002aa9ad4d65e687e89dfjpg.jpg','',0,0,'',1626172945,1626172945,0,0,'','','','',1,68,1),(33,'1654004179','','阳光玉米棒','主要原料：玉米,其他,米',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/75bcad3e8ed85b54022bbfd8f0822jpg.jpg','',0,0,'',1626172946,1626172946,0,0,'','','','',1,67,1),(34,'1654004179','','山药','主要原料：山药,香菇,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/19e6e60f0c8b7056f951431cb4e6ajpg.jpg','',0,0,'',1626172947,1626172947,0,0,'','','','',1,66,1),(35,'1654004179','','猪肚条','推荐推荐！！！\n主要原料：猪肚,其他',0,0,'',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/39d380faff47c39641d11b094dd7ejpg.jpg','',0,0,'',1626172947,1626172947,0,0,'','','','',1,65,1),(36,'1654004179','','牛肚','进口牛肚！推荐！\n主要原料：牛肚,其他',0,0,'',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/52ecbc6352ed1d1a3ded07ae91282jpg.jpg','',0,0,'',1626172949,1626172949,0,0,'','','','',1,64,1),(37,'1654004179','','牛百叶','牛百叶\n主要原料：其他',0,0,'',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/3ad905da58b8cc44cf7f589e4321fjpg.jpg','',0,0,'',1626172949,1626172949,0,0,'','','','',1,63,1),(38,'1654004179','','毛肚','主要原料：毛肚,其他',0,0,'',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/a69057f3a295bdbe6b59a256ab495jpg.jpg','',0,0,'',1626172950,1626172950,0,0,'','','','',1,62,1),(39,'1654004179','','鱿鱼','新鲜鱿鱼\n主要原料：鱿鱼,其他,鱼',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/929d4a74387ab48cdf6d1c6600abbjpeg.jpeg','',0,0,'',1626172952,1626172952,0,0,'','','','',1,61,1),(40,'1654004179','','巴赫的鹌鹑蛋(6个)','主要原料：鹌鹑,鹌鹑蛋,其他',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/17827447d4d941c810883a63f2ab5jpg.jpg','',0,0,'',1626172952,1626172952,0,0,'','','','',1,60,1),(41,'1654004179','','肉皮','主要原料：猪肉,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/e9ed3f7cad7e5981ad8da57c84c98jpg.jpg','',0,0,'',1626172953,1626172953,0,0,'','','','',1,59,1),(42,'1654004179','','鸭肠','主要原料：鸭肠,其他',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/7159e856e7576975f061aeca07988jpg.jpg','',0,0,'',1626172954,1626172954,0,0,'','','','',1,58,1),(43,'1654004179','','蟹肉棒棒哒（3根）','主要原料：蟹肉,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/922d6dde8aaf5a612264c8b8fdaafjpg.jpg','',0,0,'',1626172955,1626172955,0,0,'','','','',1,57,1),(44,'1654004179','','鸭胗','主要原料：其他',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/06cb84303a19cb431382ea6b92e87jpg.jpg','',0,0,'',1626172956,1626172956,0,0,'','','','',1,56,1),(45,'1654004179','','考式台肠','台式烤香肠\n主要原料：香肠,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/61f45a18a208581ca439072e78221jpg.jpg','',0,0,'',1626172957,1626172957,0,0,'','','','',1,55,1),(46,'1654004179','','水晶包（2个）','水晶包\n主要原料：水,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/4a8ec497ca7bc76f6496175c50548jpg.jpg','',0,0,'',1626172958,1626172958,0,0,'','','','',1,54,1),(47,'1654004179','','黄金粥の蛋饺（4个）','猪肉藕片黄金饺子，超级美味！！！强烈推荐！！！\n主要原料：藕,猪肉,其他',0,0,'',0,0.00,0,0.00,5.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/37513e385dac2c7360cac26beeb19jpg.jpg','',0,0,'',1626172959,1626172959,0,0,'','','','',1,53,1),(48,'1654004179','','虾糕','鲜香虾干糕\n主要原料：其他,虾',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cb77b568f5fecf96ba11212cc32bejpg.jpg','',0,0,'',1626172959,1626172959,0,0,'','','','',1,52,1),(49,'1654004179','','糯米紫薯球','糯米紫薯球\n主要原料：糯米,紫薯,其他,米',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/2bfdb1429b81fa0b73662524945a2jpg.jpg','',0,0,'',1626172960,1626172960,0,0,'','','','',1,51,1),(50,'1654004179','','鱼肉卷','鱼肉卷\n主要原料：其他,鱼,鱼肉',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/13e26ae6ec7fc9389472d4dd1fae8jpg.jpg','',0,0,'',1626172961,1626172961,0,0,'','','','',1,50,1),(51,'1654004179','','潮汕牛肉丸','潮汕牛肉丸\n主要原料：牛肉,牛肉丸,其他,肉丸',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/6143387dd6dd3165591b6743d7dd9jpg.jpg','',0,0,'',1626172962,1626172962,0,0,'','','','',1,49,1),(52,'1654004179','','香菇贡丸','主要原料：香菇,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/dd797edcf9ebc95f7cae3340cc72cjpg.jpg','',0,0,'',1626172963,1626172963,0,0,'','','','',1,48,1),(53,'1654004179','','爆汁鱼丸','主要原料：牛肉,牛肉丸,鱼丸,其他,鱼,肉丸',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ebc2c34b2c75745b1d240a4682bf7jpg.jpg','',0,0,'',1626172964,1626172964,0,0,'','','','',1,47,1),(54,'1654004179','','蟹籽丸（3个）','蟹籽球！！！推荐！\n主要原料：其他,虾',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/2b9b1d98a15ceea76e11ec3db93c4jpg.jpg','',0,0,'',1626172965,1626172965,0,0,'','','','',1,46,1),(55,'1654004179','','燕饺','主要原料：牛肉,牛肉丸,其他,肉丸',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/91510d78454a83401fe8c3cb57216jpg.jpg','',0,0,'',1626172966,1626172966,0,0,'','','','',1,45,1),(56,'1654004179','','鲍鱼片','主要原料：鲍鱼,其他,鱼,肉丸',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/832174d1620758d8e810d7d7b809cjpeg.jpeg','',0,0,'',1626172967,1626172967,0,0,'','','','',1,44,1),(57,'1654004179','','墨鱼丸','主要原料：墨鱼,其他,鱼',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/04c3b863f43a6370367ea53ffbf7djpg.jpg','',0,0,'',1626172968,1626172968,0,0,'','','','',1,43,1),(58,'1654004179','','亲亲肠','亲亲肠！！！\n主要原料：牛肉,牛肉丸,其他,肉丸',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/93626b62bb5124f31cd2fec4a99bbjpg.jpg','',0,0,'',1626172969,1626172969,0,0,'','','','',1,42,1),(59,'1654004179','','脆皮鱼豆腐','人气推荐！！！超级好吃！\n主要原料：豆腐,其他',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/688e9d8c6765d5106ef569f30abfdjpg.jpg','',0,0,'',1626172970,1626172970,0,0,'','','','',1,41,1),(60,'1654004179','','黑鱼片','新鲜黑鱼片！！！强烈强烈推荐！！\n主要原料：其他,鱼,黑鱼',0,0,'',0,0.00,0,0.00,7.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/8bf28b174928c1b51539b49a78a22jpeg.jpeg','',0,0,'',1626172971,1626172971,0,0,'','','','',1,40,1),(61,'1654004179','','黑椒牛柳','新鲜牛柳！！！强烈推荐\n主要原料：牛肉,其他',0,0,'',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ca5e223c635b03c9c8426213d836cjpg.jpg','',0,0,'',1626172971,1626172971,0,0,'','','','',1,39,1),(62,'1654004179','','川香里脊肉','更大块鸡肉，更满足的肉感！\n主要原料：鸡肉,其他',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/734170af245f67c0e45b7ae585562jpg.jpg','',0,0,'',1626172972,1626172972,0,0,'','','','',1,38,1),(63,'1654004179','','骨肉相连','骨肉相连！推荐！！！\n主要原料：其他',0,0,'',0,0.00,0,0.00,5.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/dad5724585d40f32933b237af39efjpg.jpg','',0,0,'',1626172973,1626172973,0,0,'','','','',1,37,1),(64,'1654004179','','美好火腿肠','火腿肠好味道！\n主要原料：火腿肠,香肠,火腿,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/14e20f0b45d5e2f183b5094c50d6ejpg.jpg','',0,0,'',1626172973,1626172973,0,0,'','','','',1,36,1),(65,'1654004179','','广式腊肠','正宗四川腊肠！！强烈推荐！！！\n主要原料：腊肠,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/5add4603b185905e5f61c2df6d474jpg.jpg','',0,0,'',1626172974,1626172974,0,0,'','','','',1,35,1),(66,'1654004179','','优选午餐肉','火锅专用午餐肉！强烈推荐！！！\n主要原料：午餐肉,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/37bde6858ae282516edeafe94e121jpg.jpg','',0,0,'',1626172975,1626172975,0,0,'','','','',1,34,1),(67,'1654004179','','雪花培根肉','雪花培根好味道！！！\n主要原料：培根,其他',0,0,'',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/63762485515e6fbc0224c4103cf04jpg.jpg','',0,0,'',1626172975,1626172975,0,0,'','','','',1,33,1),(68,'1654004179','','大红肠','大红肠\n主要原料：猪肉,其他',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/96dde5e2e4c296daa920587c83708jpg.jpg','',0,0,'',1626172976,1626172976,0,0,'','','','',1,32,1),(69,'1654004179','','香甜撩胃玉米肠','主要原料：玉米,其他,米',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/7efd755be48dbb271bf454b647d73jpg.jpg','',0,0,'',1626172977,1626172977,0,0,'','','','',1,31,1),(70,'1654004179','','咸五花肉','百分百新鲜五花肉腌制！！！强烈推荐！！\n主要原料：猪肉,五花肉,其他',0,0,'',0,0.00,0,0.00,5.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/99b2853c83ea7de813d8beb9af356jpg.jpg','',0,0,'',1626172978,1626172978,0,0,'','','','',1,30,1),(71,'1654004179','','四川腊肉','四川熏肉！！！强烈推荐！\n主要原料：腊肉,其他',0,0,'',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/2e5a3af2fe528066bcdd0bc1946b1jpg.jpg','',0,0,'',1626172979,1626172979,0,0,'','','','',1,29,1),(72,'1654004179','','小酥肉','鲜五花肉油炸！！！强烈强烈推荐！！！\n主要原料：猪肉,五花肉,其他,油',0,0,'',0,0.00,0,0.00,7.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ce0a180e7ba29534d9a3038ac81e9jpg.jpg','',0,0,'',1626172980,1626172980,0,0,'','','','',1,28,1),(73,'1654004179','','肥牛卷','主要原料：其他',0,0,'',0,0.00,0,0.00,7.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ca243aa869e64263a9a762c0b70aejpg.jpg','',0,0,'',1626172981,1626172981,0,0,'','','','',1,27,1),(74,'1654004179','','乌鸡卷','好味道！！！！\n主要原料：其他',0,0,'',0,0.00,0,0.00,7.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/0e37c3954527ed4f5e72515418c8djpg.jpg','',0,0,'',1626172982,1626172982,0,0,'','','','',1,26,1),(75,'1654004179','','暴走雪花肥羊（7大卷）','肥牛！牛牛牛！\n主要原料：其他',0,0,'',0,0.00,0,0.00,7.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/8befed143342fa3890f4b895f53bbjpg.jpg','',0,0,'',1626172983,1626172983,0,0,'','','','',1,25,1),(76,'1654004179','','农家老豆腐（5片）','农家老豆腐！！！\n主要原料：豆腐,老豆腐,其他',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cb4895364727338031df750b1bfe4jpg.jpg','',0,0,'',1626172983,1626172983,0,0,'','','','',1,24,1),(77,'1654004179','','百叶丝','主要原料：千张,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/c8c18a1afa0fb4ffdc8f405c7b648jpg.jpg','',0,0,'',1626172984,1626172984,0,0,'','','','',1,23,1),(78,'1654004179','','中粮精制腐竹','主要原料：腐竹,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/f829d5463cd9a640cd0e6bd430419jpg.jpg','',0,0,'',1626172985,1626172985,0,0,'','','','',1,22,1),(79,'1654004179','','老家手工油豆皮','老家手工油豆皮！！！\n主要原料：豆皮,油豆皮,其他,油',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/04a5174a7e55604163aa61c339b94jpg.jpg','',0,0,'',1626172986,1626172986,0,0,'','','','',1,21,1),(80,'1654004179','','千叶豆腐','千页豆腐\n主要原料：豆腐,其他',0,0,'',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/329cfa4e8d93d2082798352cd4418jpg.jpg','',0,0,'',1626172986,1626172986,0,0,'','','','',1,20,1),(81,'1654004179','','油面筋','主要原料：油面筋,面筋,其他,油',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cc62a679973863ad404cdd543a715jpg.jpg','',0,0,'',1626172987,1626172987,0,0,'','','','',1,19,1),(82,'1654004179','','私房油豆腐','油面腐！！！\n主要原料：面筋,豆腐,油豆腐,其他,油',0,0,'',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/f8b11571eaf90e4f9863d34b754b1jpg.jpg','',0,0,'',1626172988,1626172988,0,0,'','','','',1,18,1),(83,'1654004179','','米饭（单点）','主要原料：大米,米饭,其他,米',0,0,'',0,0.00,0,0.00,1.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ab40c0aee16845729b97085048498jpg.jpg','',0,0,'',1626172989,1626172989,0,0,'','','','',1,17,1),(84,'1654004179','','方便面','主要原料：鸡蛋,方便面,其他',0,0,'',0,0.00,0,0.00,2.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/5f9d811045b285592d3c93d9bc16cjpg.jpg','',0,0,'',1626172990,1626172990,0,0,'','','','',1,16,1),(85,'1654004179','','无明矾油条','油条！赞！\n主要原料：油条,面粉,其他,油',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/705580a7d30430c98576d474c937djpg.jpg','',0,0,'',1626172990,1626172990,0,0,'','','','',1,15,1),(86,'1654004179','','龙口粉丝','主要原料：米粉,粉丝,其他,米',0,0,'',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/4d4c7375fe9e89ca2d33c2bca8edcjpg.jpg','',0,0,'',1626172991,1626172991,0,0,'','','','',1,14,1),(87,'1654004179','','火锅宽粉','火锅宽粉！！赞赞赞！！\n主要原料：粉条,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/5c779c032aade51236ddc636734f4jpg.jpg','',0,0,'',1626172991,1626172991,0,0,'','','','',1,13,1),(88,'1654004179','','宽粉皮','宽粉皮！！\n主要原料：面粉,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/a03e684727d8b9bfbb1094fc1bebdjpg.jpg','',0,0,'',1626172992,1626172992,0,0,'','','','',1,12,1),(89,'1654004179','','土豆粉','主要原料：面粉,土豆,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/645c6e31ba368d6ebca4974d7623ejpg.jpg','',0,0,'',1626172993,1626172993,0,0,'','','','',1,11,1),(90,'1654004179','','山芋粉丝','正宗山芋粉丝！！\n主要原料：粉丝,其他',0,0,'',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/0f424e51ac9169155144c622832c2jpg.jpg','',0,0,'',1626172994,1626172994,0,0,'','','','',1,10,1),(91,'1654004179','','～～蛮爱吃醋','我的酸，专为麻辣烫而生\n主要原料：其他',0,0,'',0,0.00,0,0.00,0.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cc420c0636c118ee085888f122f8djpg.jpg','',0,0,'',1626172995,1626172995,0,0,'','','','',1,9,1),(92,'1654004179','','秘制芝麻酱','来包辣干碟，万物皆可蘸\n主要原料：芝麻,其他,芝麻酱',0,0,'',0,0.00,0,0.00,0.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/9f3c81c52c79780af2745a2515810jpg.jpg','',0,0,'',1626172996,1626172996,0,0,'','','','',1,8,1),(93,'1654004179','','芝麻香油','主要原料：香油,芝麻,其他,油',0,0,'',0,0.00,0,0.00,0.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/a5a2a970b248d54b17354605f0458jpg.jpg','',0,0,'',1626172997,1626172997,0,0,'','','','',1,7,1),(94,'1654004179','','～～秘制油辣子','一勺辣不够！你的麻辣烫，让别人眼红\n主要原料：其他',0,0,'',0,0.00,0,0.00,0.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/286d1d18ed1b22161524d5b8c11ecjpg.jpg','',0,0,'',1626172998,1626172998,0,0,'','','','',1,6,1),(95,'1654004179','','～～蒜泥','主要原料：其他',0,0,'',0,0.00,0,0.00,0.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/a4e86846f5a0b610c9ac462db5a52jpg.jpg','',0,0,'',1626172998,1626172998,0,0,'','','','',1,5,1),(96,'1654004179','','～～小葱葱','主要原料：葱,其他',0,0,'',0,0.00,0,0.00,0.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/f43a78d09a0b82146be912ffc8a5fjpg.jpg','',0,0,'',1626172999,1626172999,0,0,'','','','',1,4,1),(97,'1654004179','','～～可乐','主要原料：可乐,其他',0,0,'',0,0.00,0,0.00,4.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/c90a9b1e9b75213759995c0c28c2bjpg.jpg','',0,0,'',1626173000,1626173000,0,0,'','','','',1,3,1),(98,'1654004179','','雪碧','主要原料：其他,雪碧',0,0,'',0,0.00,0,0.00,4.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/1c0b5d1fa099d161e76f7831ab04fjpg.jpg','',0,0,'',1626173001,1626173001,0,0,'','','','',1,2,1),(99,'1654004179','','雪花原汁麦（550ml）','主要原料：其他',0,0,'',0,0.00,0,0.00,5.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/bc6208c79382d212af61729ec3c92jpg.jpg','',0,0,'',1626173001,1626173001,0,0,'','','','',1,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category`
--

LOCK TABLES `cmf_food_category` WRITE;
/*!40000 ALTER TABLE `cmf_food_category` DISABLE KEYS */;
INSERT INTO `cmf_food_category` VALUES (1,1,1654004179,'匠心研制（必选）','',1,0,0,1629262556,1629262556,0,1,10),(1,2,1654004179,'人气新品','',0,0,0,1626012176,1626172920,0,1,7),(1,3,1654004179,'健康时蔬','',0,0,0,1626012176,1626172920,0,1,6),(1,4,1654004179,'品质肉肉','',0,0,0,1626012176,1626172920,0,1,5),(1,5,1654004179,'浓香豆类','',0,0,0,1626012176,1626172920,0,1,4),(1,6,1654004179,'能量主食','',0,0,0,1626012177,1626172920,0,1,3),(1,7,1654004179,'超值套餐不含米饭','',0,0,0,1626012177,1626172920,0,1,8),(1,8,1654004179,'超级小料','',0,0,0,1626012177,1626172920,0,1,2),(1,9,1654004179,'解辣饮品','',0,0,0,1626012177,1626172920,0,1,1),(1,10,1654004179,'',NULL,0,0,0,1626012177,1626012177,1626012226,1,1),(1,11,1654004179,'必选品',NULL,0,0,0,1626172920,1626172920,1629262562,1,9);
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_post`
--

LOCK TABLES `cmf_food_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_post` DISABLE KEYS */;
INSERT INTO `cmf_food_category_post` VALUES (1,1,1,1626012177,1626012177),(3,3,7,1626172923,1626172923),(4,5,7,1626172924,1626172924),(5,6,7,1626172925,1626172925),(6,2,2,1626172925,1626172925),(7,7,2,1626172926,1626172926),(8,8,2,1626172928,1626172928),(9,9,3,1626172928,1626172928),(10,10,3,1626172929,1626172929),(11,11,3,1626172930,1626172930),(12,12,3,1626172931,1626172931),(13,13,3,1626172931,1626172931),(14,14,3,1626172932,1626172932),(15,15,3,1626172933,1626172933),(16,16,3,1626172934,1626172934),(17,17,3,1626172935,1626172935),(18,18,3,1626172936,1626172936),(19,19,3,1626172936,1626172936),(20,20,3,1626172937,1626172937),(21,21,3,1626172938,1626172938),(22,22,3,1626172939,1626172939),(23,23,3,1626172939,1626172939),(24,24,3,1626172940,1626172940),(25,25,3,1626172941,1626172941),(26,26,3,1626172942,1626172942),(27,27,3,1626172942,1626172942),(28,28,3,1626172943,1626172943),(29,29,3,1626172944,1626172944),(30,30,3,1626172944,1626172944),(31,31,3,1626172945,1626172945),(32,32,3,1626172945,1626172945),(33,33,3,1626172946,1626172946),(34,34,3,1626172947,1626172947),(35,35,4,1626172947,1626172947),(36,36,4,1626172949,1626172949),(37,37,4,1626172949,1626172949),(38,38,4,1626172951,1626172951),(39,39,4,1626172952,1626172952),(40,40,4,1626172952,1626172952),(41,41,4,1626172953,1626172953),(42,42,4,1626172954,1626172954),(43,43,4,1626172955,1626172955),(44,44,4,1626172956,1626172956),(45,45,4,1626172957,1626172957),(46,46,4,1626172958,1626172958),(47,47,4,1626172959,1626172959),(48,48,4,1626172960,1626172960),(49,49,4,1626172960,1626172960),(50,50,4,1626172961,1626172961),(51,51,4,1626172962,1626172962),(52,52,4,1626172963,1626172963),(53,53,4,1626172964,1626172964),(54,54,4,1626172965,1626172965),(55,55,4,1626172966,1626172966),(56,56,4,1626172967,1626172967),(57,57,4,1626172968,1626172968),(58,58,4,1626172969,1626172969),(59,59,4,1626172970,1626172970),(60,60,4,1626172971,1626172971),(61,61,4,1626172971,1626172971),(62,62,4,1626172972,1626172972),(63,63,4,1626172973,1626172973),(64,64,4,1626172973,1626172973),(65,65,4,1626172974,1626172974),(66,66,4,1626172975,1626172975),(67,67,4,1626172975,1626172975),(68,68,4,1626172976,1626172976),(69,69,4,1626172977,1626172977),(70,70,4,1626172978,1626172978),(71,71,4,1626172979,1626172979),(72,72,4,1626172980,1626172980),(73,73,4,1626172981,1626172981),(74,74,4,1626172982,1626172982),(75,75,4,1626172983,1626172983),(76,76,5,1626172983,1626172983),(77,77,5,1626172984,1626172984),(78,78,5,1626172985,1626172985),(79,79,5,1626172986,1626172986),(80,80,5,1626172986,1626172986),(81,81,5,1626172987,1626172987),(82,82,5,1626172988,1626172988),(83,83,6,1626172989,1626172989),(84,84,6,1626172990,1626172990),(85,85,6,1626172990,1626172990),(86,86,6,1626172991,1626172991),(87,87,6,1626172992,1626172992),(88,88,6,1626172992,1626172992),(89,89,6,1626172993,1626172993),(90,90,6,1626172994,1626172994),(91,91,8,1626172995,1626172995),(92,92,8,1626172996,1626172996),(93,93,8,1626172997,1626172997),(94,94,8,1626172998,1626172998),(95,95,8,1626172998,1626172998),(96,96,8,1626172999,1626172999),(97,97,9,1626173000,1626173000),(98,98,9,1626173001,1626173001),(99,99,9,1626173001,1626173001),(100,4,1,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order`
--

LOCK TABLES `cmf_food_order` WRITE;
/*!40000 ALTER TABLE `cmf_food_order` DISABLE KEYS */;
INSERT INTO `cmf_food_order` VALUES (1,1654004179,'T202108161812391659','wx16130838788363b75e22e30c55db580000','','wxpay',1,2,1629090518,0,'[{\"fee\": 14.76, \"name\": \"单人套餐（2荤多素）\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 3, \"material\": []}]',0.00,0.00,0.00,0,'',14.76,14.76,0,'',4,'','17625458589','',0,1629090518,0,'TRADE_CLOSED','','',0.00),(2,1654004179,'T202108164781395','wx1617481386398676c55ecb3a1fec670000','','wxpay',1,3,1629107293,0,'[{\"fee\": 14.76, \"name\": \"单人套餐（2荤多素）\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 3, \"material\": []}]',0.00,0.00,0.00,0,'',14.76,14.76,0,'',2,'','18052722480','',0,1629107293,0,'TRADE_CLOSED','','',0.00),(3,1654004179,'T20210816851476019','wx1617494934641615aa02b2580627c60000','','wxpay',1,3,1629107388,0,'[{\"fee\": 3, \"name\": \"暗送秋波\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 9, \"material\": []}]',0.00,0.00,0.00,0,'',3.00,3.00,0,'',2,'','18052722480','',0,1629107389,0,'TRADE_CLOSED','','',0.00),(4,1654004179,'T202108171084892259','wx17141608396565b1aea3d7496f69de0000','','wxpay',1,2,1629180967,0,'[{\"fee\": 3, \"name\": \"沙拉拉生菜\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 12, \"material\": []}]',0.00,0.00,0.00,0,'',3.00,3.00,0,'',2,'','18052722480','',0,1629180968,0,'TRADE_CLOSED','','',0.00),(5,1654004179,'T202108171090196950','wx1719101526897251ccb604eb6496ab0000','','wxpay',1,2,1629198614,0,'[{\"fee\": 2.99, \"name\": \"手工新鲜小鱼丸\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,0.00,0.00,0,'',2.99,2.99,0,'',2,'','18052722480','',0,1629198614,0,'TRADE_CLOSED','','',0.00),(6,1654004179,'W20210817681818618','wx17191418357101eece19c7fbe860910000','','wxpay',1,4,1629198857,0,'[{\"fee\": 3, \"name\": \"小青菜儿\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 11, \"material\": []}]',0.00,3.00,0.00,0,'',6.00,6.00,0,'',2,'马梦磊','18921358133','江苏省无锡市新吴区新吴区里路与新韵南路交叉口的西南角梅荆花苑六区22563',4,1629198858,0,'TRADE_CLOSED','','',0.00),(7,1654004179,'W202108171294435006','wx17191436712371803dec477b6e22f40000','2','wxpay',1,4,1629198876,0,'[{\"fee\": 3, \"name\": \"小青菜儿\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 11, \"material\": []}]',0.00,3.00,0.00,0,'',6.00,6.00,0,'',2,'马梦磊','18921358133','江苏省无锡市新吴区新吴区里路与新韵南路交叉口的西南角梅荆花苑六区22563',4,1629198876,0,'TRADE_REFUND','','',0.00),(8,1654004179,'W202108181582509621','wx18103048584944e840e25b67054a8f0000','1','wxpay',1,4,1629253848,0,'[{\"fee\": 2.99, \"name\": \"手工新鲜小鱼丸\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}]',0.00,3.00,0.00,0,'',5.99,5.99,0,'',2,'马','18921358133','江苏省无锡市新吴区无锡梅村服务区出口处',5,1629253848,0,'TRADE_FINISHED','','',5.99),(9,1654004179,'W20210818615044077','wx18132214510678c80cb3c71b06209a0000','','wxpay',1,4,1629264134,0,'[{\"fee\": 14.76, \"name\": \"单人套餐（2荤多素）\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 3, \"material\": []}, {\"fee\": 0, \"name\": \"冒菜锅底\", \"count\": 1, \"tasty\": [{\"attr_key\": \"调料\", \"attr_value\": \"香菜芝麻\"}, {\"attr_key\": \"秘制口味\", \"attr_value\": \"秘制骨汤不辣\"}], \"sku_id\": 0, \"food_id\": 4, \"material\": []}]',0.00,3.00,0.00,0,'',17.76,17.76,0,'',4,'戴富阳','15161178722','江苏省无锡市新吴区梅里新村一幢3号冒菜行家22-1001',3,1629264134,0,'TRADE_CLOSED','','',0.00),(10,1654004179,'W202108181428630726','wx181323323193721233fb6591a488e80000','1','wxpay',1,4,1629264211,0,'[{\"fee\": 2.99, \"name\": \"手工新鲜小鱼丸\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 2, \"material\": []}, {\"fee\": 0, \"name\": \"冒菜锅底\", \"count\": 1, \"tasty\": [{\"attr_key\": \"秘制口味\", \"attr_value\": \"秘制微微辣\"}, {\"attr_key\": \"调料\", \"attr_value\": \"香菜芝麻\"}], \"sku_id\": 0, \"food_id\": 4, \"material\": []}]',0.00,3.00,0.00,0,'',5.99,5.99,0,'',2,'马梦磊','18921358133','江苏省无锡市新吴区新吴区里路与新韵南路交叉口的西南角梅荆花苑六区22563',4,1629264212,1629307412,'TRADE_FINISHED','','',5.99);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_detail`
--

LOCK TABLES `cmf_food_order_detail` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_detail` DISABLE KEYS */;
INSERT INTO `cmf_food_order_detail` VALUES (1,'3','T202108161812391659',3,'tenant/1654004179/20210713/ffdd6cc9687c9f495cb7aa7eeb2a6jpg.jpg','','单人套餐（2荤多素）',0,'','',0,0.00,1,'{}','[]','','','',14.76,14.76,0.00),(2,'3','T202108164781395',3,'tenant/1654004179/20210713/ffdd6cc9687c9f495cb7aa7eeb2a6jpg.jpg','','单人套餐（2荤多素）',0,'','',0,0.00,1,'{}','[]','','','',14.76,14.76,0.00),(3,'9','T20210816851476019',9,'tenant/1654004179/20210713/d5a5eb3f5d45f32819f19bb3bc298jpg.jpg','','暗送秋波',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(4,'12','T202108171084892259',12,'tenant/1654004179/20210713/73fada6789943ef017c8a58d9c23ejpg.jpg','','沙拉拉生菜',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(5,'2','T202108171090196950',2,'tenant/1654004179/20210713/f6822af4261d89d368033f53bae4ajpg.jpg','','手工新鲜小鱼丸',0,'','',0,0.00,1,'{}','[]','','','',2.99,2.99,0.00),(6,'11','W20210817681818618',11,'tenant/1654004179/20210713/ffdf71b1ee31dc570219a32385412jpg.jpg','','小青菜儿',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(7,'11','W202108171294435006',11,'tenant/1654004179/20210713/ffdf71b1ee31dc570219a32385412jpg.jpg','','小青菜儿',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(8,'2','W202108181582509621',2,'tenant/1654004179/20210713/f6822af4261d89d368033f53bae4ajpg.jpg','','手工新鲜小鱼丸',0,'','',0,0.00,1,'{}','[]','','','',2.99,2.99,0.00),(9,'3','W20210818615044077',3,'tenant/1654004179/20210713/ffdd6cc9687c9f495cb7aa7eeb2a6jpg.jpg','','单人套餐（2荤多素）',0,'','',0,0.00,1,'{}','[]','','','',14.76,14.76,0.00),(10,'4','W20210818615044077',4,'tenant/1654004179/20210713/31c917601d352a38193378f1b2e62jpg.jpg','','冒菜锅底',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"调料\", \"attr_value\": \"香菜芝麻\"}, {\"attr_key\": \"秘制口味\", \"attr_value\": \"秘制骨汤不辣\"}]','','','',0.00,0.00,0.00),(11,'2','W202108181428630726',2,'tenant/1654004179/20210713/f6822af4261d89d368033f53bae4ajpg.jpg','','手工新鲜小鱼丸',0,'','',0,0.00,1,'{}','[]','','','',2.99,2.99,0.00),(12,'4','W202108181428630726',4,'tenant/1654004179/20210713/31c917601d352a38193378f1b2e62jpg.jpg','','冒菜锅底',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"秘制口味\", \"attr_value\": \"秘制微微辣\"}, {\"attr_key\": \"调料\", \"attr_value\": \"香菜芝麻\"}]','','','',0.00,0.00,0.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_refund`
--

LOCK TABLES `cmf_food_order_refund` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_refund` DISABLE KEYS */;
INSERT INTO `cmf_food_order_refund` VALUES (1,1654004179,'W202108171294435006',6.00,'库存不足');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_immediate_delivery`
--

LOCK TABLES `cmf_immediate_delivery` WRITE;
/*!40000 ALTER TABLE `cmf_immediate_delivery` DISABLE KEYS */;
INSERT INTO `cmf_immediate_delivery` VALUES (1,'DADA','达达','dadad6c244b981576c1','dadad6c244b981576c1','07ad639f59f0263b093b078c919f70e2',0,0,1,1,1629246414);
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
INSERT INTO `cmf_mp_theme` VALUES (1,1654004179,0,'冒菜行家','',1,1561262937,'tenant/1654004179/20210711/ac0d1ba6fbe4d474ae85f53c418c86c0.jpg','','{}','https://mobilecodec.alipay.com/show.htm?code=s4x13407l4r44jbsof2p59a','tenant/1654004179/wechat-exp.jpg','tenant/1654004179/wechat-qrcode.jpg','Gdr4gbnjUyt+kT9LLDqY1Q==','1612976011',1625985527,0,10000,0);
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
INSERT INTO `cmf_mp_theme_page` VALUES (1,1,1654004179,1,'首页','home','{}','{}','[{\"data\": [{\"id\": 5, \"link\": \"\", \"name\": \"\", \"image\": \"https://cdn.mashangdian.cn/tenant/1654004179/20210711/03215c349297dc84246585f6d62999de.jpg!clipper\", \"file_path\": \"tenant/1654004179/20210711/03215c349297dc84246585f6d62999de.jpg\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 8, \"desc\": \"\", \"image\": \"https://cdn.mashangdian.cn/tenant/1654004179/20210711/ce3170ae763cfdfa1c974f41ab1ba11b.png!clipper\", \"title\": \"\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/1654004179/20210711/ce3170ae763cfdfa1c974f41ab1ba11b.png\"}, {\"id\": 7, \"desc\": \"\", \"image\": \"https://cdn.mashangdian.cn/tenant/1654004179/20210711/3f966c7c2c77981e5761cc7b7a807c2e.png!clipper\", \"title\": \"\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/1654004179/20210711/3f966c7c2c77981e5761cc7b7a807c2e.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"row\", \"number\": \"2\", \"divider\": true, \"iconSize\": 120}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"borderRadius\": 5, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {\"source\": {\"api\": \"portal/list\", \"categoryId\": 1}}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]',1625985527,1625985527);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_version`
--

LOCK TABLES `cmf_mp_theme_version` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_version` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_version` VALUES (2,1654004179,'0.0.1','29','0.2.0',0,'reject','1:服务类目\"餐饮-点评与推荐_\"与你提交代码审核时设置的功能页面内容不一致:<br>(1):你好，你的小程序涉及个体餐饮场所提供点餐、外卖服务，请补充选择：餐饮 - 餐饮服务场所/餐饮服务管理企业类目。<br>','wechat',1625986748,1626238519),(3,1654004179,'0.0.1','2021001192675085','0.0.44',0,'reject','1. 特殊行业资质: 当前小程序内容涉及餐饮服务，需提交：《食品经营许可证》。如果是餐饮管理公司统一入驻（小程序内有多个门店提供服务），需提交以下材料（2选1）：1-供小程序内实际提供服务的门店list（盖章），门店营业执照+《食品经营许可证》（提交3家以上门店证照；如门店不足3家的，提供实际提供服务门店的证照）。2-提供该品牌的商标注册证（如商标持有人不是管理公司的，需要提交商标持有人和管理公司的关系证明，比如商标授权或关联公司关系等）。请您按规范提交内容或补全资质文件，且资质要求为清晰完整的拍摄件/扫描件/加盖红色企业公章的复印件。服务及资质规范请参考https://opendocs.alipay.com/mini/operation/standard/category/material<br> ','alipay',1626245000,1626315413),(4,1654004179,'0.0.2','30','0.2.1',0,'online','','wechat',1628830306,0),(5,1654004179,'0.0.2','2021001192675085','0.0.45',0,'online','','alipay',1628830312,1628865955);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_option`
--

LOCK TABLES `cmf_option` WRITE;
/*!40000 ALTER TABLE `cmf_option` DISABLE KEYS */;
INSERT INTO `cmf_option` VALUES (1,1,'business_info','{\"email\": \"13151012071@163.com\", \"mobile\": \"13151012071\", \"address\": \"\", \"company\": \"\", \"contact\": \"李云侠\", \"app_desc\": \"冒菜行家官方小程序，点餐更优惠\", \"app_slogan\": \"冒菜行家官方小程序\", \"brand_logo\": \"tenant/1654004179/20210711/ac0d1ba6fbe4d474ae85f53c418c86c0.jpg\", \"brand_name\": \"冒菜行家\", \"out_door_pic\": \"tenant/1654004179/20210713/f4be28d9591a24cd5e15abe8f51925c7.jpg\", \"alipay_logo_id\": \"A*zkJITayRRFgAAAAAAAAAAAAADsN1AQ\", \"business_photo\": \"tenant/1654004179/20210713/745408e8a99b8f10f15844381c955937.jpg\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"tenant/1654004179/20210813/a534d10b3fcf62d70e97a653b81d294b.jpg\", \"mini_category_ids\": \"XS1009_XS2074_XS3115\"}',1654004179,0),(2,1,'eatin','{\"day\": 0, \"status\": 0, \"eat_type\": 1, \"pay_type\": 0, \"sale_type\": 0, \"surcharge\": 0, \"order_type\": 0, \"sell_clear\": \"\", \"custom_name\": \"\", \"custom_enabled\": 0, \"surcharge_type\": 0, \"enabled_sell_clear\": 0, \"enabled_appointment\": 0}',1654004179,1),(3,1,'score','{\"to_score\": 0, \"pay_score\": 1, \"enabled_pay\": 1, \"valid_period\": -1, \"enabled_to_score\": 0}',1654004179,0),(4,1,'takeout','{\"day\": 0, \"status\": 1, \"step_km\": 1, \"start_km\": 10, \"step_fee\": 0, \"min_price\": 0, \"start_fee\": 3, \"sell_clear\": \"\", \"first_class\": \"美食夜宵\", \"second_class\": \"快餐/地方菜\", \"delivery_times\": [{\"end_time\": \"23:59\", \"start_time\": \"00:00\"}], \"automatic_order\": 0, \"stop_before_min\": 30, \"delivery_percent\": 5, \"delivery_distance\": 30, \"enabled_sell_clear\": 0, \"immediate_delivery\": 0, \"enabled_appointment\": 0}',1654004179,1),(5,1,'subscribe','{\"pay_tmp_id\": \"gSPs_m2Z0XUBGK8Tw0RoXaCgeaW34z4or3oapa598u4\", \"take_tmp_id\": \"9rtnrjmfS2Wt7qBmRdFrhTIMFm0YNj0QCWZX6c4izjo\", \"refund_tmp_id\": \"X-tYcLhtSxYe3dV0Qss1Ksm1SHYQEy3hz9CF0EM2pms\", \"finished_tmp_id\": \"inAIlKvDFodDNpwwWcU96kxm3Xo_gSA4cmr5gM6xBEs\"}',1654004179,0),(6,1,'wechat_work_group','{\"plugid\": \"53a2aa904040a1e3524912ad34059d57\"}',1654004179,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_pay_log`
--

LOCK TABLES `cmf_pay_log` WRITE;
/*!40000 ALTER TABLE `cmf_pay_log` DISABLE KEYS */;
INSERT INTO `cmf_pay_log` VALUES (1,'W202108171294435006','4200001232202108176501389845','wxpay','wxf341d54e36c85268',2,'o2lhv5P1RW4bUjA9bSAxrJlX96wI',6.00,6.00,0.00,6.00,0.00,0.00,0.00,'','','null','{}',1629198883,0,0,'TRADE_REFUND'),(2,'W202108181582509621','4200001203202108186934084407','wxpay','wxf341d54e36c85268',2,'o2lhv5P1RW4bUjA9bSAxrJlX96wI',5.99,5.99,0.00,5.99,0.00,0.00,0.00,'','','null','{}',1629253854,0,0,'TRADE_SUCCESS'),(3,'W202108181428630726','4200001145202108182726130257','wxpay','wxf341d54e36c85268',2,'o2lhv5P1RW4bUjA9bSAxrJlX96wI',5.99,5.99,0.00,5.99,0.00,0.00,0.00,'','','null','{}',1629264218,0,0,'TRADE_SUCCESS');
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
INSERT INTO `cmf_portal_category` VALUES (1,1654004179,0,0,1,0,10000,'新鲜事','','','','','','','','','','');
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
INSERT INTO `cmf_portal_post` VALUES (1,1654004179,0,1,1,1,1,1,0,0,17,0,0,0,1626019450,1626019450,0,0,'冒菜行家外送小程序上线了','','','','tenant/1654004179/20210712/d94ebf1972806a2b4ab6713ea9cc0a57.jpg','<p><img src=\"https://cdn.mashangdian.cn/default/20210712/1dac55df4eadac0abb76c86ced5d06c5.jpg!clipper\" alt=\"\" width=\"800\" height=\"2000\" /></p>','','{\"audio\": \"\", \"files\": [], \"other\": null, \"video\": \"\", \"photos\": [], \"extends\": {}, \"template\": \"\"}');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role`
--

LOCK TABLES `cmf_role` WRITE;
/*!40000 ALTER TABLE `cmf_role` DISABLE KEYS */;
INSERT INTO `cmf_role` VALUES (1654004179,1,0,'超级管理员','拥有网站最高管理员权限！',10000,1625985527,1625985527,1),(1654004179,2,0,'收银员','收银员！',1,1625985527,1625985527,1),(1654004179,3,0,'财务','财务！',2,1625985527,1625985527,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_score_log`
--

LOCK TABLES `cmf_score_log` WRITE;
/*!40000 ALTER TABLE `cmf_score_log` DISABLE KEYS */;
INSERT INTO `cmf_score_log` VALUES (1,2,0,6,'6.00','消费',1629211087),(2,2,1,6,'6.00','退款',1629212674),(3,2,0,5,'5.99','消费',1629253855),(4,2,0,5,'5.99','消费',1629264219);
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
INSERT INTO `cmf_store` VALUES (1,'2021071200502000000027088249',1654004179,2135050174,'','冒菜行家',1,'S08','1709','13151012071','店长',320000,'江苏',320200,'无锡',320214,'新吴区','梅里新村一幢3号 冒菜行家','tenant/1654004179/20210711/ac0d1ba6fbe4d474ae85f53c418c86c0.jpg',120.4313650,31.5425960,0,1,'23:30','',1626019572,1626019572,0,'passed','',NULL);
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
INSERT INTO `cmf_store_hours` VALUES (1654004179,1,1,1,1,1,1,1,1,'10:00','21:30',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_part`
--

LOCK TABLES `cmf_third_part` WRITE;
/*!40000 ALTER TABLE `cmf_third_part` DISABLE KEYS */;
INSERT INTO `cmf_third_part` VALUES (1,1654004179,'wechat-mp',4,'o2lhv5HBfxSRQiVsUICjIa-S18dk','k+saFENEmSTDxqF+kPcjqA=='),(2,1654004179,'wechat-mp',2,'o2lhv5P1RW4bUjA9bSAxrJlX96wI','WyOwghY549lHJdAWWXxoHw=='),(3,1654004179,'wechat-mp',0,'o2lhv5Gp-rXRB_sDQbAw6TDVT35c','WWrx2pszLcoj2guDiTeHZQ=='),(4,1654004179,'wechat-mp',0,'o2lhv5IRamTSwZdBPQaqFeLSUVJ8','+hKikf04to9vfGnOoKum3A=='),(5,1654004179,'wechat-mp',3,'o2lhv5N6fePYSTqQdVX8ssqIWh2I','FFBMjrlWQoP8y65kbCBW+Q=='),(6,1654004179,'alipay-mp',0,'2088042865655966',''),(7,1654004179,'alipay-mp',0,'2088932207171923',''),(8,1654004179,'wechat-mp',0,'o2lhv5IVvmrc-XgtWejeI_wTKug8','Rg3rAoEo5qJB2n9eXiYbmw=='),(9,1654004179,'alipay-mp',0,'2088142902411514',''),(10,1654004179,'wechat-mp',0,'o2lhv5OoQ3qntNEs2s3eiEhfOF6I','/yVUNnX6uy0aAjbPnynVgA=='),(11,1654004179,'wechat-mp',0,'o2lhv5GAc1EP6VZmO35zpSxjX3pc','RaIag0Mhxwf/O/FvY4FWWg=='),(12,1654004179,'wechat-mp',0,'o2lhv5J6Wt2xuwBGgNsBu8WG32LM','xjaXyJOyzth4WPqaPjIazw=='),(13,1654004179,'alipay-mp',0,'2088512446596714',''),(14,1654004179,'alipay-mp',2,'2088612226408973',''),(15,1654004179,'alipay-mp',0,'2088332802119355',''),(16,1654004179,'alipay-mp',0,'2088122305347757',''),(17,1654004179,'alipay-mp',5,'2088222446463531',''),(18,1654004179,'alipay-mp',0,'2088022835065197',''),(19,1654004179,'wechat-mp',0,'o2lhv5Kl8GULqKi-tJ7bw_28coKI','GhepuG01nuUlnl9imaeLnQ=='),(20,1654004179,'wechat-mp',6,'o2lhv5L4I0pOax8AF1ZemMZ7EohA','SCvumKtH2vwqKKyQjsXa/Q=='),(21,1654004179,'alipay-mp',0,'2088532636361975',''),(22,1654004179,'wechat-mp',0,'o2lhv5PGTJInG27QiS9Mmtp37Luw','2aBj6E6U//iPDPR8+3x+Uw=='),(23,1654004179,'wechat-mp',7,'o2lhv5FC_qXhNuLVUFqTRcZ7yHeo','LXK1bmqdTaQFlzYR6c+p6Q=='),(24,1654004179,'alipay-mp',0,'2088122924297743',''),(25,1654004179,'wechat-mp',0,'o2lhv5EyaJ5uRIE35NJlJaUTK8uw','vX/Sbr6/SVJ/QjrqrjFUPw=='),(26,1654004179,'wechat-mp',0,'o2lhv5MB6q2qyHM7qGywO_FnB3Xs','3aOkEqHOvwsYaIdQhjbwug=='),(27,1654004179,'wechat-mp',0,'o2lhv5L9wlDFQjeHU9kR69xGTINc','cyT267xRE7KttL5tSuEHUQ=='),(28,1654004179,'alipay-mp',8,'2088232137379292',''),(29,1654004179,'wechat-mp',0,'o2lhv5PhoEybcXisZwALPs4HOB6Q','Y0RgBKZ2IVRe9ErkeSiGpA=='),(30,1654004179,'alipay-mp',0,'2088022646500560',''),(31,1654004179,'wechat-mp',0,'o2lhv5JCnaheXCVn4-XeFvHUCs6c','XFCwbDHz+Tfwf3cvMcws3A=='),(32,1654004179,'wechat-mp',0,'o2lhv5CrW23FemAQNweOq85QcHQ0','eLqyIbTaWi4p/WTa/f7k6g=='),(33,1654004179,'alipay-mp',0,'2088902627636393',''),(34,1654004179,'wechat-mp',0,'o2lhv5FA8Rvs1Cuf6Pefgc-y3rf0','G3oXmwTUunw6PoDw1HKJQw==');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
INSERT INTO `cmf_user` VALUES (2,0,0,0,1636192804,16,0,0,0.000000,1626173517,1628866250,0,1,'','','','','','','','','127.0.0.1','','18052722480','',1654004179),(3,0,0,0,1628920420,0,0,0,0.000000,1626243568,1626243568,0,1,'','','','','','','','','127.0.0.1','','13802943054','',1654004179),(4,0,0,0,1629986400,0,0,0,0.000000,1629090434,1629090434,0,1,'','','','','','','','','127.0.0.1','','17625458589','',1654004179),(5,0,0,0,1629097042,0,0,0,0.000000,1629097042,1629097042,0,1,'','','','','','','','','127.0.0.1','','18657298361','',1654004179),(6,0,0,0,1630045827,0,0,0,0.000000,1630045827,1630045827,0,1,'','','','','','','','','127.0.0.1','','15238118990','',1654004179),(7,0,0,0,1630558276,0,0,0,0.000000,1630558030,1630558030,0,1,'','','','','','','','','127.0.0.1','','17882055576','',1654004179),(8,0,0,0,1632125285,0,0,0,0.000000,1632125285,1632125285,0,1,'','','','','','','','','127.0.0.1','','15593284749','',1654004179);
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
-- Dumping events for database 'tenant_1561262937'
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-11 21:25:46' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-11 21:25:46' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card SET status = -1 WHERE end_at between 0 AND UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-11 21:25:44' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderFinishStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-11 21:25:44' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > appointment_at + 43200 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `rechargeOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-11 21:25:46' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_recharge_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucher` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-11 21:25:45' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher SET status = 2 WHERE UNIX_TIMESTAMP(publish_end_time) < UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucherPost` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-11 21:25:45' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher_post SET status = 2 WHERE valid_end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tenant_1561262937'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:06:18
