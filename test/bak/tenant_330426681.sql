-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: tenant_330426681
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
-- Current Database: `tenant_330426681`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenant_330426681` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tenant_330426681`;

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_menu`
--

LOCK TABLES `cmf_admin_menu` WRITE;
/*!40000 ALTER TABLE `cmf_admin_menu` DISABLE KEYS */;
INSERT INTO `cmf_admin_menu` VALUES (1,'app/dashboard',0,'工作台','/app/:mid/dashboard','icondashboard',0,1),(2,'app/published',0,'小程序','/app/:mid/published','iconmp',0,1),(3,'app/published/dashboard',2,'小程序总览','/app/:mid/published/dashboard','',0,1),(4,'app/published/wechat',2,'微信小程序','/app/:mid/published/wechat','',0,2),(5,'app/published/alipay',2,'支付宝小程序','/app/:mid/published/alipay','',0,3),(6,'app/order/default',0,'订单管理','/app/:mid/order/default','icondetail',0,2),(7,'app/order/business',6,'业务订单','/app/:mid/order/business','',0,10000),(8,'app/order/business/list',7,'订单列表','/app/:mid/order/business/list','',1,1),(9,'app/order/business/id',7,'订单详情','/app/:mid/order/business/:id','',1,1),(10,'app/order/member',6,'会员订单','/app/:mid/order/member','',0,10000),(11,'app/order/recharge',6,'储值订单','/app/:mid/order/coupon','',0,10000),(12,'app/dishes',0,'菜单管理','/app/:mid/dishes','iconappstore',0,3),(13,'app/dishes/goods',12,'菜品管理','/app/:mid/dishes/goods','',0,10000),(14,'app/dishes/goods/index',13,'菜品列表','/app/:mid/dishes/goods/index','',1,10000),(15,'app/dishes/goods/add',13,'添加菜品','/app/:mid/dishes/goods/add','',1,10000),(16,'app/dishes/goods/edit',13,'编辑菜品','/app/:mid/dishes/goods/edit','',1,10000),(17,'app/dishes/category',12,'分类管理','/app/:mid/dishes/category','',0,10000),(18,'app/desk/default',0,'桌位管理','/app/:mid/desk/default','iconapartment',0,4),(19,'app/desk/index',18,'桌位管理','/app/:mid/desk/index','',0,10000),(20,'app/desk/category',18,'桌位类型','/app/:mid/desk/category','',0,10000),(21,'app/member/default',0,'会员管理','/app/:mid/member/default','iconcreditcard',0,5),(22,'app/member/index',21,'用户列表','/app/:mid/member/index','',0,10000),(23,'app/marketing',0,'营销管理','/app/:mid/marketing','icongift',0,70),(24,'app/marketing/card',23,'会员卡设置','/app/:mid/marketing/card','',0,10000),(25,'app/marketing/coupon',23,'优惠券管理','/app/:mid/marketing/coupon','',0,10000),(26,'app/marketing/recharge',23,'储值管理','/app/:mid/marketing/recharge','',0,10000),(27,'app/marketing/score',23,'积分设置','/app/:mid/marketing/score','',0,10000),(28,'app/theme/default',0,'主题管理','/app/:mid/theme/default','iconbg-colors',0,90),(29,'app/theme/index',28,'主题设置','/app/:mid/theme/index','',0,10),(30,'app/theme/assets',28,'素材中心','/app/:mid/theme/assets','',0,10000),(31,'portal/default',0,'门户管理','/app/:mid/portal','iconfolder-add',0,91),(32,'/app/portal/index',31,'文章管理','/app/:mid/portal/index','',0,10000),(33,'/app/portal/category',31,'分类管理','/app/:mid/portal/category','',0,10000),(34,'/app/portal/category/add',33,'添加分类','/app/:mid/portal/category/add','',1,10000),(35,'/app/portal/category/edit',33,'修改分类','/app/:mid/portal/category/edit/:id','',1,10000),(36,'app/store',0,'门店管理','/app/:mid/store','iconshop',0,92),(37,'app/store/index',36,'门店列表','/app/:mid/store/index','',0,10),(38,'app/store/add',37,'添加门店','/app/:mid/store/add','',1,10000),(39,'app/store/edit',37,'修改门店','/app/:mid/store/edit/:id','',1,10000),(40,'app/store/edit_for_here',37,'堂食设置','/app/:mid/store/edit_for_here/:id','',1,10000),(41,'app/store/edit_take_out',37,'外卖设置','/app/:mid/store/edit_take_out/:id','',1,10000),(42,'app/store/printer',36,'打印机绑定','/app/:mid/store/printer','',0,30),(43,'app/user',0,'账号管理','/app/:mid/user','iconuser',0,100),(44,'app/user/settings',43,'个人设置','/app/:mid/user/settings','',1,1),(45,'app/user/index',43,'账号设置','/app/:mid/user/index','',0,1),(46,'app/user/add',45,'添加管理员','/app/:mid/user/add','',1,10000),(47,'app/user/edit',45,'编辑管理员','/app/:mid/user/edit/:id','',1,10000),(48,'app/user/role',43,'角色设置','/app/:mid/user/role','',0,10000),(49,'app/user/authorize/add',48,'角色权限添加','app/:mid/user/authorize/add','',1,10000),(50,'app/user/authorize/edit',48,'角色权限编辑','/app/:mid/user/authorize/edit/:id','',1,10000),(51,'app/settings',0,'系统设置','/app/:mid/settings','iconsetting',0,110),(52,'app/settings/index',51,'通用设置','/app/:mid/settings/index','',0,10000),(53,'app/settings/contact',51,'客服设置','/app/:mid/settings/contact','',0,10000),(54,'app/settings/logistics',51,'物流设置','/app/:mid/settings/logistics','',0,10000),(55,'app/notice',0,'消息通知','/app/:mid/notice','',1,10000),(56,'app/notice/list',55,'消息列表','/app/:mid/notice/list','',0,10000);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_notice`
--

LOCK TABLES `cmf_admin_notice` WRITE;
/*!40000 ALTER TABLE `cmf_admin_notice` DISABLE KEYS */;
INSERT INTO `cmf_admin_notice` VALUES (215329371,1,'堂食订单通知','您有新的堂食订单，请及时处理！',122,1627721255,0,0,'https://cdn.mashangdian.cn/eatin.mp3',0);
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
INSERT INTO `cmf_admin_user` VALUES (1,0,0,1624534855,0,0,1,'18217316822','8b0fdb0534d6a13dd416eeaaae4298f5','18217316822','','','','','18217316822','');
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
INSERT INTO `cmf_applyment` VALUES (1,'1626149639',2000002200539773,'{\"indoor\": {\"name\": \"尼可蛋糕店.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiKDVv2cp71-jEMUUp3btNQD0eFSJZ0Sw_RhNObyzUwdevj-DNmi3AdsMtUZ2v7jNYyT0qTXRQIMOPUCNr2wiuS4\", \"file_name\": \"b3af9753f5f9988e25595659cab86feb.jpg\", \"file_path\": \"tenant/853571152/20210713/b3af9753f5f9988e25595659cab86feb.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/b3af9753f5f9988e25595659cab86feb.jpg\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"身份证正面.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiEa4dGtgboN1p9icf8n1lpGBukwjwK6YCiGXJAZ4TCckZbA7p1EORQm4lb6Uj7INGe6GqT7ddiCeGdBzKmbBGx8\", \"file_name\": \"d366323ead176de0cd7ae6e9b48c9003.jpg\", \"file_path\": \"tenant/853571152/20210713/d366323ead176de0cd7ae6e9b48c9003.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/d366323ead176de0cd7ae6e9b48c9003.jpg\"}, \"license_copy\": {\"name\": \"尼可营业执照.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiB-KlEkf4XhDexlrZbwPDKuCDhU1gvGSt46fzeeuTP6d3JA4nPas7UmTwJKX_l22S1Pvv8QdDhqz0bncrC574RE\", \"file_name\": \"8c90030c1fa4f76f106e11e84a8bf472.jpg\", \"file_path\": \"tenant/853571152/20210713/8c90030c1fa4f76f106e11e84a8bf472.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/8c90030c1fa4f76f106e11e84a8bf472.jpg\"}, \"mini_program\": [{\"name\": \"首页.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiCuhvLilMCJz7hCFrR9dzpOAa2tSsSwk8sBq1yYImOMncWJLlESdLdjLOsxPJylJ9oS6uUpYHtw8_LIQk1bqk1M\", \"file_name\": \"8268ea79cdfcbbd77bd08a5618f9ab81.jpg\", \"file_path\": \"tenant/853571152/20210713/8268ea79cdfcbbd77bd08a5618f9ab81.jpg\", \"prev_path\": \"https://cdn.mashangdian.cn/tenant/853571152/20210713/8268ea79cdfcbbd77bd08a5618f9ab81.jpg!clipper\"}], \"qualifications\": {\"name\": \"尼可卫生.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiPM4HYgctnA6nSQAI5P8PNGqgEMfc2VEs3Cj1Wv_yxoLZziziesonFoT1cQdxsmd92KJ_C6hndq0Dq0YNdV8C6w\", \"file_name\": \"d01d3547abaff27ea24785b6fcdc11fd.jpg\", \"file_path\": \"tenant/853571152/20210713/d01d3547abaff27ea24785b6fcdc11fd.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/d01d3547abaff27ea24785b6fcdc11fd.jpg\"}, \"store_entrance\": {\"name\": \"尼可蛋糕店.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiPCjq76PJ_w4_Y1KHTBen383Zfx_Gj2-K-TdW83TnDNjswEMSbto_T3oEck4TLzOUrO-9_lXdGfPwi5MPV7EZFU\", \"file_name\": \"f2a260a4c6c2be14375812a3e19877fb.jpg\", \"file_path\": \"tenant/853571152/20210713/f2a260a4c6c2be14375812a3e19877fb.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/f2a260a4c6c2be14375812a3e19877fb.jpg\"}, \"id_card_national\": {\"name\": \"身份证背面.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiPONlt2uhMyHuYrC1TYfAeTw06osqlPcGqjUDOi7aCVz5iC6Dr_5UlYt1lkTfnZnnCicsRZMITn3xEgBABKLfG0\", \"file_name\": \"3dc481665d2c3742022c3ea572c3cd7f.jpg\", \"file_path\": \"tenant/853571152/20210713/3dc481665d2c3742022c3ea572c3cd7f.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/3dc481665d2c3742022c3ea572c3cd7f.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}','{\"MediaList\": {\"Indoor\": {\"Name\": \"尼可蛋糕店.jpg\", \"MediaId\": \"6e5uXjk20GtIwYcXCz_qiKDVv2cp71-jEMUUp3btNQD0eFSJZ0Sw_RhNObyzUwdevj-DNmi3AdsMtUZ2v7jNYyT0qTXRQIMOPUCNr2wiuS4\", \"FileName\": \"b3af9753f5f9988e25595659cab86feb.jpg\", \"FilePath\": \"tenant/853571152/20210713/b3af9753f5f9988e25595659cab86feb.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/b3af9753f5f9988e25595659cab86feb.jpg\"}, \"IdDocCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}, \"IdCardCopy\": {\"Name\": \"身份证正面.jpg\", \"MediaId\": \"6e5uXjk20GtIwYcXCz_qiEa4dGtgboN1p9icf8n1lpGBukwjwK6YCiGXJAZ4TCckZbA7p1EORQm4lb6Uj7INGe6GqT7ddiCeGdBzKmbBGx8\", \"FileName\": \"d366323ead176de0cd7ae6e9b48c9003.jpg\", \"FilePath\": \"tenant/853571152/20210713/d366323ead176de0cd7ae6e9b48c9003.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/d366323ead176de0cd7ae6e9b48c9003.jpg\"}, \"LicenseCopy\": {\"Name\": \"尼可营业执照.jpg\", \"MediaId\": \"6e5uXjk20GtIwYcXCz_qiB-KlEkf4XhDexlrZbwPDKuCDhU1gvGSt46fzeeuTP6d3JA4nPas7UmTwJKX_l22S1Pvv8QdDhqz0bncrC574RE\", \"FileName\": \"8c90030c1fa4f76f106e11e84a8bf472.jpg\", \"FilePath\": \"tenant/853571152/20210713/8c90030c1fa4f76f106e11e84a8bf472.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/8c90030c1fa4f76f106e11e84a8bf472.jpg\"}, \"MiniProgram\": [{\"Name\": \"首页.jpg\", \"MediaId\": \"6e5uXjk20GtIwYcXCz_qiCuhvLilMCJz7hCFrR9dzpOAa2tSsSwk8sBq1yYImOMncWJLlESdLdjLOsxPJylJ9oS6uUpYHtw8_LIQk1bqk1M\", \"FileName\": \"8268ea79cdfcbbd77bd08a5618f9ab81.jpg\", \"FilePath\": \"tenant/853571152/20210713/8268ea79cdfcbbd77bd08a5618f9ab81.jpg\", \"PrevPath\": \"https://cdn.mashangdian.cn/tenant/853571152/20210713/8268ea79cdfcbbd77bd08a5618f9ab81.jpg!clipper\"}], \"StoreEntrance\": {\"Name\": \"尼可蛋糕店.jpg\", \"MediaId\": \"6e5uXjk20GtIwYcXCz_qiPCjq76PJ_w4_Y1KHTBen383Zfx_Gj2-K-TdW83TnDNjswEMSbto_T3oEck4TLzOUrO-9_lXdGfPwi5MPV7EZFU\", \"FileName\": \"f2a260a4c6c2be14375812a3e19877fb.jpg\", \"FilePath\": \"tenant/853571152/20210713/f2a260a4c6c2be14375812a3e19877fb.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/f2a260a4c6c2be14375812a3e19877fb.jpg\"}, \"IdCardNational\": {\"Name\": \"身份证背面.jpg\", \"MediaId\": \"6e5uXjk20GtIwYcXCz_qiPONlt2uhMyHuYrC1TYfAeTw06osqlPcGqjUDOi7aCVz5iC6Dr_5UlYt1lkTfnZnnCicsRZMITn3xEgBABKLfG0\", \"FileName\": \"3dc481665d2c3742022c3ea572c3cd7f.jpg\", \"FilePath\": \"tenant/853571152/20210713/3dc481665d2c3742022c3ea572c3cd7f.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/3dc481665d2c3742022c3ea572c3cd7f.jpg\"}, \"Qualifications\": {\"Name\": \"尼可卫生.jpg\", \"MediaId\": \"6e5uXjk20GtIwYcXCz_qiPM4HYgctnA6nSQAI5P8PNGqgEMfc2VEs3Cj1Wv_yxoLZziziesonFoT1cQdxsmd92KJ_C6hndq0Dq0YNdV8C6w\", \"FileName\": \"d01d3547abaff27ea24785b6fcdc11fd.jpg\", \"FilePath\": \"tenant/853571152/20210713/d01d3547abaff27ea24785b6fcdc11fd.jpg\", \"PrevPath\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/d01d3547abaff27ea24785b6fcdc11fd.jpg\"}, \"BusinessAddition\": [], \"OrganizationCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}}, \"contact_info\": {\"contact_name\": \"e+Paw773XKUXAaQSio8r0uQWiGjZPATbnumFWKRjKgPEVuvKTVh4qTyBEuOf2ZIfqYdn6yAcMzFRGCivhb143T2WyMGqchYHJg+FWOxFqpfUtEyq2L48enuL+JYvujGCgredIBoSh0O3+ecaU9hLntxVCaIul9eu2rLna9rp41fMW6abz9fMHBCKp92BnvkkSaJdXAuVrfyeLMfDuYLJom4w5xV87mEKEwmnU5lMm6FEfjWtKZi24wzI0QGM/p0aT8QlOVLCtBb1YxUeJS7gxod6G640KnpLc8NmQZ4U+cWEe8An7u2t8XUR4nwVlmg9O7rXZi18InTtHryuWstnXQ==\", \"mobile_phone\": \"JIoZEJFO/nynjdeFkmyFcrhuxAS9gUyCYQG1S3mfd8kEEsARxsavoEoqDsIhn0dD7v0tJgiIaeOi7HVdZhEuUOhJ2/B82DJYG2/pbU5C0GempuEdHdRQm4VgImFpr5zLFx+IZprGquDJws2+veslPEqWWk3R78hDAu/K2Z1X9zLBsclQwPvgixIkn7H+O/A02dDzKIhgvLBx2LASSOYi/+BMiKYm0TEAe2oXx0j51Bra2gITJMVlJagLaOw8EuwKe4zz1T72EESqwrFWNjc78ZtmygTewTsqlfgI41nha5792GYM3t2bJXrMoq7UXl+DoIVgEY904qdIRmvOl/SsCw==\", \"contact_email\": \"eTlCKv9GKcZ0/lej0uiz9oZhuh+9RcPCqY2+jHLGRRrnw2ns3CGCPYmgfIEKYINcQnAHJ3LW1zP69i9CgDCHWe0A0sViFJBDg/cbHgizY7cMgj3W0RJU9mQzbtuFyEfk6JZi7Rpm2G07MgzYYPhGDKizkBA5z4FvmubReVZxI8J6ttaux1UFDiOsNYbgVHBXmMHCF/4i8+B9hCZT3GnkvgdGoKlZAa3b+6wuwnuGXLqWlIdZm2Ig9UxFN/LxBIBZJQ4xO33rYvMG2SKo0EfsMfZ2juaPrY1pLTuATx4OG6otlszEH6WzLvFl6lQ6XmS6v0U7qOBkyPYdCPVNUndqeA==\", \"contact_id_number\": \"lsiw3anDVli4JMBmpYirhmDZImiy7XdX0sRxC2bQ+UzxNNR5VtwVg4ocxmFlaSJXe93f7NgrwBYNV2b7SLxfR8VKNI4g9UvziolKt+W5j7296fwdPXeSzZOZbnSxbEoPOx5JIq0+mq5af2hjYZoyXCCVdWEKBHn5gtpby7zA5pxGPKHFKl11xZTekPuxx4gmPS9GB8xF/dC3Fs26sIYEKbQjbOxEg3d8qMW+S3lKX7L3pATu+t6YmNqrN2bCN+smfwm6DIUdH7A870DuZ+vg/Ve0uVAxQv7C0FZ/mYC0U2bVJLEWYbMeKh80nR2n8HrY6zLN8ZOtl2569HnOBOWUkw==\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"6e5uXjk20GtIwYcXCz_qiEa4dGtgboN1p9icf8n1lpGBukwjwK6YCiGXJAZ4TCckZbA7p1EORQm4lb6Uj7INGe6GqT7ddiCeGdBzKmbBGx8\", \"id_card_name\": \"LLvP8WRtTYsBw4oUGSsmwjOui3XSjD5t8LKXTPVoybLcyDiWFh8Gr12r3Ohg61qVFKvFy+vm9uUTbomulcmLoQsAlySUrC32YddZCyWYlSj4v0OH8qEWllpB+r2974msRK9TSMuYkL0pCxK/GxS4Ivr0E3qU1zaDmWbXEfLTl4viMBFt6rT5kN5ISepeTik3RO8Pb1vMRWyJwWQ8IAWSe2S+XeM5MhJ2WCa/s9N3h0HdlMBPn2S/4CjAQG07VH33soq7gIkawVOAc55tvZzpSaxB84NBBWvaLdX5+euiNbOlozRup2t+t1UTdPfZSVTgEcGCFJG2G96Wts/Yy1eh8A==\", \"id_card_number\": \"QNrufRpi2JszKddH0o/sbhCUTQ5nHnur965lCKHJI3klzGZ317CtE1zfIHKuon60rW2R+nvajA4F46PoRdFSJG1Zmb1yK3vjdayCQ2jl9JV2uaTpxVO2jqsbQRnH5ZhffUOiSFLaHN1TNiEEaWADR/7Jiuh5Qbqh3KwuPLoDgD1GVYxt25T2JnZK3/11QpVSzsrU4XQSskso6z1dKU/nI+jn7Yeap52ucMOTYsyHrzUDF6xnKeExNwhF2Vp7xAlWbCoZwiY+d8cMHvUQCrIAWV1nr9KyA6WYvumca/9DAuWm18b7ByOVL5jp5n+V1kytwYzvxA/yb1V56ss7wdkCqg==\", \"card_period_end\": \"2027-04-05\", \"id_card_national\": \"6e5uXjk20GtIwYcXCz_qiPONlt2uhMyHuYrC1TYfAeTw06osqlPcGqjUDOi7aCVz5iC6Dr_5UlYt1lkTfnZnnCicsRZMITn3xEgBABKLfG0\", \"card_period_begin\": \"2017-04-05\"}}, \"business_license_info\": {\"legal_person\": \"钱昱\", \"license_copy\": \"6e5uXjk20GtIwYcXCz_qiB-KlEkf4XhDexlrZbwPDKuCDhU1gvGSt46fzeeuTP6d3JA4nPas7UmTwJKX_l22S1Pvv8QdDhqz0bncrC574RE\", \"merchant_name\": \"上海市虹口区尼可蛋糕店\", \"license_number\": \"92310109MA1KML8U0N\"}}, \"business_code\": \"1626149639\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"6e5uXjk20GtIwYcXCz_qiKDVv2cp71-jEMUUp3btNQD0eFSJZ0Sw_RhNObyzUwdevj-DNmi3AdsMtUZ2v7jNYyT0qTXRQIMOPUCNr2wiuS4\"], \"biz_store_name\": \"尼可蛋糕店\", \"BizAddressRegion\": [310000, 310100, 310109, 310109019], \"biz_address_code\": \"310109\", \"biz_store_address\": \"上海市虹口区广粤路591-2号\", \"store_entrance_pic\": [\"6e5uXjk20GtIwYcXCz_qiPCjq76PJ_w4_Y1KHTBen383Zfx_Gj2-K-TdW83TnDNjswEMSbto_T3oEck4TLzOUrO-9_lXdGfPwi5MPV7EZFU\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"6e5uXjk20GtIwYcXCz_qiCuhvLilMCJz7hCFrR9dzpOAa2tSsSwk8sBq1yYImOMncWJLlESdLdjLOsxPJylJ9oS6uUpYHtw8_LIQk1bqk1M\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"18217316822\", \"merchant_shortname\": \"尼可蛋糕店\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"6e5uXjk20GtIwYcXCz_qiPM4HYgctnA6nSQAI5P8PNGqgEMfc2VEs3Cj1Wv_yxoLZziziesonFoT1cQdxsmd92KJ_C6hndq0Dq0YNdV8C6w\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"农业银行\", \"account_name\": \"ExcaR0ELuD+JnUnMk5CLpaqxy1Lhqp5Dayx7Arold2A1LSMnA2mOs0poHAWOZS9Xgr4DPzEyROK0dzanINcpDO6YUSn/Z0P4IAFzzSuN4wxfn950vIH68roX1XstarYy1vUT8w0iD1ANaeWUiPiG7Loup9TyDeqjas2F4bOKqtq+OQB6ed3ZuQjPf5351H4CTboD9gi0amQGmoamUuDrszN29fWOXjZYkfPfoB3ZddrHa6hcjzZzjJiZN137aEav+VMg1sbuYSCwAx+L+d5NaDTtlYUpi1KwkrLDUx+J/yRTkBiL+4bp4pzs+pKN47gevXNrawZxFhbsu4Kk73dt2g==\", \"account_number\": \"Zsu0T19N8u9eaeQex1dTf90TxvnIxs7LMO9k0csvcCJC5OMSCLXSSL0Gal/tCovfh0fb4aA/Dh5ZxZfh56dPUtuSabAM23eDIzqcnj9ic+mTxsRGvXijwcUStPCmpypCvwupdiC26Zb1c89Dv/GgbEzz6jCK/rIL7CbGIahpufQABts2v6tbGp+xcX0WkGMDQbDBH0nCrUXlMc+f5TZ5G1Oy8sTvnhUrGHgx9VizmwI3TbfkZQ4I0h7wzSaZAY/188lr4soThFnhsmCwz9BbKGk543PX8KEym9GKB6JwgWq715OWyZf86EVWB01wX+yGIzvFqjfaCmqzVwM4zz+UGg==\", \"BankAddressRegion\": [320000, 320600, 320684, 320684417], \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"320684\"}}','{\"media_list\": {\"indoor\": {\"name\": \"尼可蛋糕店.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiKDVv2cp71-jEMUUp3btNQD0eFSJZ0Sw_RhNObyzUwdevj-DNmi3AdsMtUZ2v7jNYyT0qTXRQIMOPUCNr2wiuS4\", \"file_name\": \"b3af9753f5f9988e25595659cab86feb.jpg\", \"file_path\": \"tenant/853571152/20210713/b3af9753f5f9988e25595659cab86feb.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/b3af9753f5f9988e25595659cab86feb.jpg\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"身份证正面.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiEa4dGtgboN1p9icf8n1lpGBukwjwK6YCiGXJAZ4TCckZbA7p1EORQm4lb6Uj7INGe6GqT7ddiCeGdBzKmbBGx8\", \"file_name\": \"d366323ead176de0cd7ae6e9b48c9003.jpg\", \"file_path\": \"tenant/853571152/20210713/d366323ead176de0cd7ae6e9b48c9003.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/d366323ead176de0cd7ae6e9b48c9003.jpg\"}, \"license_copy\": {\"name\": \"尼可营业执照.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiB-KlEkf4XhDexlrZbwPDKuCDhU1gvGSt46fzeeuTP6d3JA4nPas7UmTwJKX_l22S1Pvv8QdDhqz0bncrC574RE\", \"file_name\": \"8c90030c1fa4f76f106e11e84a8bf472.jpg\", \"file_path\": \"tenant/853571152/20210713/8c90030c1fa4f76f106e11e84a8bf472.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/8c90030c1fa4f76f106e11e84a8bf472.jpg\"}, \"mini_program\": [{\"name\": \"首页.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiCuhvLilMCJz7hCFrR9dzpOAa2tSsSwk8sBq1yYImOMncWJLlESdLdjLOsxPJylJ9oS6uUpYHtw8_LIQk1bqk1M\", \"file_name\": \"8268ea79cdfcbbd77bd08a5618f9ab81.jpg\", \"file_path\": \"tenant/853571152/20210713/8268ea79cdfcbbd77bd08a5618f9ab81.jpg\", \"prev_path\": \"https://cdn.mashangdian.cn/tenant/853571152/20210713/8268ea79cdfcbbd77bd08a5618f9ab81.jpg!clipper\"}], \"qualifications\": {\"name\": \"尼可卫生.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiPM4HYgctnA6nSQAI5P8PNGqgEMfc2VEs3Cj1Wv_yxoLZziziesonFoT1cQdxsmd92KJ_C6hndq0Dq0YNdV8C6w\", \"file_name\": \"d01d3547abaff27ea24785b6fcdc11fd.jpg\", \"file_path\": \"tenant/853571152/20210713/d01d3547abaff27ea24785b6fcdc11fd.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/d01d3547abaff27ea24785b6fcdc11fd.jpg\"}, \"store_entrance\": {\"name\": \"尼可蛋糕店.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiPCjq76PJ_w4_Y1KHTBen383Zfx_Gj2-K-TdW83TnDNjswEMSbto_T3oEck4TLzOUrO-9_lXdGfPwi5MPV7EZFU\", \"file_name\": \"f2a260a4c6c2be14375812a3e19877fb.jpg\", \"file_path\": \"tenant/853571152/20210713/f2a260a4c6c2be14375812a3e19877fb.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/f2a260a4c6c2be14375812a3e19877fb.jpg\"}, \"id_card_national\": {\"name\": \"身份证背面.jpg\", \"media_id\": \"6e5uXjk20GtIwYcXCz_qiPONlt2uhMyHuYrC1TYfAeTw06osqlPcGqjUDOi7aCVz5iC6Dr_5UlYt1lkTfnZnnCicsRZMITn3xEgBABKLfG0\", \"file_name\": \"3dc481665d2c3742022c3ea572c3cd7f.jpg\", \"file_path\": \"tenant/853571152/20210713/3dc481665d2c3742022c3ea572c3cd7f.jpg\", \"prev_path\": \"https://console.mashangdian.cn/uploads/tenant/853571152/20210713/3dc481665d2c3742022c3ea572c3cd7f.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}, \"contact_info\": {\"contact_name\": \"钱旻\", \"mobile_phone\": \"18217316822\", \"contact_email\": \"2825333791@qq.com\", \"contact_id_number\": \"320684199612267183\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_info\": {\"id_doc_copy\": \"\", \"id_doc_name\": \"\", \"id_doc_number\": \"\", \"doc_period_end\": \"\", \"doc_period_begin\": \"\"}, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"6e5uXjk20GtIwYcXCz_qiEa4dGtgboN1p9icf8n1lpGBukwjwK6YCiGXJAZ4TCckZbA7p1EORQm4lb6Uj7INGe6GqT7ddiCeGdBzKmbBGx8\", \"id_card_name\": \"钱昱\", \"id_card_number\": \"320684199612267183\", \"card_period_end\": \"2027-04-05\", \"id_card_national\": \"6e5uXjk20GtIwYcXCz_qiPONlt2uhMyHuYrC1TYfAeTw06osqlPcGqjUDOi7aCVz5iC6Dr_5UlYt1lkTfnZnnCicsRZMITn3xEgBABKLfG0\", \"card_period_begin\": \"2017-04-05\"}}, \"organization_info\": {}, \"business_license_info\": {\"legal_person\": \"钱昱\", \"license_copy\": \"6e5uXjk20GtIwYcXCz_qiB-KlEkf4XhDexlrZbwPDKuCDhU1gvGSt46fzeeuTP6d3JA4nPas7UmTwJKX_l22S1Pvv8QdDhqz0bncrC574RE\", \"merchant_name\": \"上海市虹口区尼可蛋糕店\", \"license_number\": \"92310109MA1KML8U0N\"}}, \"addition_info\": {}, \"business_code\": \"APPLYMENT_1626151425\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"6e5uXjk20GtIwYcXCz_qiKDVv2cp71-jEMUUp3btNQD0eFSJZ0Sw_RhNObyzUwdevj-DNmi3AdsMtUZ2v7jNYyT0qTXRQIMOPUCNr2wiuS4\"], \"biz_store_name\": \"尼可蛋糕店\", \"biz_address_code\": \"310109\", \"biz_store_address\": \"上海市虹口区广粤路591-2号\", \"biz_address_region\": [310000, 310100, 310109, 310109019], \"store_entrance_pic\": [\"6e5uXjk20GtIwYcXCz_qiPCjq76PJ_w4_Y1KHTBen383Zfx_Gj2-K-TdW83TnDNjswEMSbto_T3oEck4TLzOUrO-9_lXdGfPwi5MPV7EZFU\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"6e5uXjk20GtIwYcXCz_qiCuhvLilMCJz7hCFrR9dzpOAa2tSsSwk8sBq1yYImOMncWJLlESdLdjLOsxPJylJ9oS6uUpYHtw8_LIQk1bqk1M\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"18217316822\", \"merchant_shortname\": \"尼可蛋糕店\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"6e5uXjk20GtIwYcXCz_qiPM4HYgctnA6nSQAI5P8PNGqgEMfc2VEs3Cj1Wv_yxoLZziziesonFoT1cQdxsmd92KJ_C6hndq0Dq0YNdV8C6w\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"农业银行\", \"account_name\": \"钱昱\", \"account_number\": \"6230520420028249975\", \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"320684\", \"bank_address_region\": [320000, 320600, 320684, 320684417]}}',1626149639,1626684751,'','https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFr7zwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAycHN1Tjhqb3JlUjIxY0Zhc2h4Y0wAAgQpPfVgAwQAjScA','APPLYMENT_STATE_REJECTED','','[{\"reject_reason\": \"填写的身份证件与银行卡开户时预留的身份证件不一致，请检查身份证姓名、身份证号码、银行卡号是否均填写正确\"}]');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,52668,1624681100,1,'e3e3db2f-4c2f-49d7-79e1-36d23f93c7d2','尼克.jpeg','d8c0d0a305f7b385d48b5cc73edb6be6.jpeg','default/20210626/d8c0d0a305f7b385d48b5cc73edb6be6.jpeg','jpeg',0,'',0),(2,1,2935689,1625213484,1,'88f3444c-46e1-456e-4fc5-fbb221476f92','mmexport1623665467853.jpg','5b64d55dbe71f751cd9b20da686220f6.jpg','tenant/853571152/20210702/5b64d55dbe71f751cd9b20da686220f6.jpg','jpg',0,'',853571152),(3,1,2626102,1625368037,1,'f84e55ec-f0a6-454b-4282-5ce558a444e8','WechatIMG118.jpg','4699cc7e5a32fb8a26427d2dc3af61c4.jpg','tenant/853571152/20210704/4699cc7e5a32fb8a26427d2dc3af61c4.jpg','jpg',0,'',853571152),(4,1,286647,1625481614,1,'c41b5e6c-c74b-4c82-6d99-fd0e226f103a','IMG_20210615_164510.jpg','af5e5fe71d9062fa3095929346865e98.jpg','tenant/853571152/20210705/af5e5fe71d9062fa3095929346865e98.jpg','jpg',0,'',853571152),(5,1,382406,1625481650,1,'f8982129-6340-4497-65a1-f98418ada115','IMG_20210615_164518.jpg','a7663c1e5002a337a498567dc40cd4a2.jpg','tenant/853571152/20210705/a7663c1e5002a337a498567dc40cd4a2.jpg','jpg',0,'',853571152),(6,1,52668,1625548140,0,'1da2e2e3-40aa-4b8b-6dec-9ab2e8514b48','d8c0d0a305f7b385d48b5cc73edb6be6.jpeg','e5dbb1ea68116b8782e651074fc36f2b.jpeg','tenant/853571152/20210706/e5dbb1ea68116b8782e651074fc36f2b.jpeg','jpeg',0,'',853571152),(7,1,33711,1625548229,1,'0c797ddf-b346-4e83-452e-ab9aeb2ad06c','d8c0d0a305f7b385d48b5cc73edb6be6.jpeg','a4dce5988b1b647b05b5a77c7039fe74.jpeg','tenant/853571152/20210706/a4dce5988b1b647b05b5a77c7039fe74.jpeg','jpeg',0,'',853571152),(8,1,185423,1625548605,1,'a84b1c5d-6d0d-45d5-6c80-1a8e73e5ca1a','尼可营业执照.jpg','4436afc01be42187be400e66504a9989.jpg','tenant/853571152/20210706/4436afc01be42187be400e66504a9989.jpg','jpg',0,'',853571152),(9,1,382176,1625548655,0,'639acfc4-0d90-41bc-6ccc-9a764e8bf1a9','尼可卫生.jpg','3f773097aa69f711e7aaa7ef9a4d2f98.jpg','tenant/853571152/20210706/3f773097aa69f711e7aaa7ef9a4d2f98.jpg','jpg',0,'',853571152),(10,1,477359,1625548784,1,'55910372-9f5a-40c7-742a-16fe78ababcb','尼可蛋糕店.jpg','05cda50036c2e1654585a29a37578287.jpg','tenant/853571152/20210706/05cda50036c2e1654585a29a37578287.jpg','jpg',0,'',853571152),(11,1,190662,1625548906,1,'7560b0ce-5429-41ea-53f9-cf94c35c20df','尼可卫生.jpg','c0efde4c1c30e750ff6d20d287f8763b.jpg','tenant/853571152/20210706/c0efde4c1c30e750ff6d20d287f8763b.jpg','jpg',0,'',853571152);
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule`
--

LOCK TABLES `cmf_auth_rule` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule` DISABLE KEYS */;
INSERT INTO `cmf_auth_rule` VALUES (1,'app/dashboard','','',1),(2,'app/published/dashboard','','',1),(3,'app/published/wechat','','',1),(4,'app/published/alipay','','',1),(5,'app/published','','',1),(6,'app/order/business/list','','',1),(7,'app/order/business/id','','',1),(8,'app/order/business','','',1),(9,'app/order/member','','',1),(10,'app/order/recharge','','',1),(11,'app/order/default','','',1),(12,'app/dishes/goods/index','','',1),(13,'app/dishes/goods/add','','',1),(14,'app/dishes/goods/edit','','',1),(15,'app/dishes/goods','','',1),(16,'app/dishes/category','','',1),(17,'app/dishes','','',1),(18,'app/desk/index','','',1),(19,'app/desk/category','','',1),(20,'app/desk/default','','',1),(21,'app/member/index','','',1),(22,'app/member/default','','',1),(23,'app/marketing/card','','',1),(24,'app/marketing/coupon','','',1),(25,'app/marketing/recharge','','',1),(26,'app/marketing/score','','',1),(27,'app/marketing','','',1),(28,'app/theme/index','','',1),(29,'app/theme/assets','','',1),(30,'app/theme/default','','',1),(31,'/app/portal/index','','',1),(32,'/app/portal/category/add','','',1),(33,'/app/portal/category/edit','','',1),(34,'/app/portal/category','','',1),(35,'portal/default','','',1),(36,'app/store/add','','',1),(37,'app/store/edit','','',1),(38,'app/store/edit_for_here','','',1),(39,'app/store/edit_take_out','','',1),(40,'app/store/index','','',1),(41,'app/store/printer','','',1),(42,'app/store','','',1),(43,'app/user/settings','','',1),(44,'app/user/add','','',1),(45,'app/user/edit','','',1),(46,'app/user/index','','',1),(47,'app/user/role/list','','',1),(48,'app/user/role/edit','','',1),(49,'app/user/role/delete','','',1),(50,'app/user/authorize/add','','',1),(51,'app/user/authorize/edit','','',1),(52,'app/user/role','','',1),(53,'app/user','','',1),(54,'app/settings/index','','',1),(55,'app/settings/contact','','',1),(56,'app/settings/logistics','','',1),(57,'app/settings','','',1),(58,'app/notice/list','','',1),(59,'app/notice','','',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food`
--

LOCK TABLES `cmf_food` WRITE;
/*!40000 ALTER TABLE `cmf_food` DISABLE KEYS */;
INSERT INTO `cmf_food` VALUES (1,'853571152','','❤️芒果雪媚娘','',0,0,'',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'','',0,0,'',1626054807,1626054864,0,0,'个','','','',1,138,1),(2,'853571152','','火龙果雪媚娘','',0,0,'',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'','',0,0,'',1626054807,1626054864,0,0,'个','','','',1,137,1),(3,'853571152','','蜜桃雪媚娘','',0,0,'',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'个','','','',1,136,1),(4,'853571152','','草莓雪媚娘','',0,0,'',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'个','','','',1,135,1),(5,'853571152','','❤️榴莲雪媚娘','',0,0,'',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'个','','','',1,134,1),(6,'853571152','','❤️芒果千层','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'个','','','',1,133,1),(7,'853571152','','❤️❤️榴莲千层','',0,0,'',0,0.00,0,0.00,36.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'个','','','',1,132,1),(8,'853571152','','❤️❤️三色毛巾卷','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'条','','','',1,131,1),(9,'853571152','','奥利奥巧克力毛巾卷','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'条','','','',1,130,1),(10,'853571152','','芒果原味毛巾卷','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'条','','','',1,129,1),(11,'853571152','','抹茶蜜豆毛巾卷','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'条','','','',1,128,1),(12,'853571152','','❤️❤️榴莲毛巾卷','',0,0,'',0,0.00,0,0.00,36.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'条','','','',1,127,1),(13,'853571152','','芒果班戟','',0,0,'',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054864,0,0,'个','','','',1,126,1),(14,'853571152','','❤️榴莲班戟','',0,0,'',0,0.00,0,0.00,19.00,0.00,-1,-1,0,1,'','',0,0,'',1626054808,1626054865,0,0,'个','','','',1,125,1),(15,'853571152','','❤️酥皮水果大泡芙','',0,0,'',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'个','','','',1,124,1),(16,'853571152','','酥皮外交官奶酱大泡芙','',0,0,'',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'个','','','',1,123,1),(17,'853571152','','酥皮奥利奥大泡芙','',0,0,'',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'个','','','',1,122,1),(18,'853571152','','海苔肉松盒子便当','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'盒','','','',1,121,1),(19,'853571152','','❤️芒果盒子便当','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'盒','','','',1,120,1),(20,'853571152','','❤️奥利奥盒子便当','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'盒','','','',1,119,1),(21,'853571152','','抹茶盒子便当','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'盒','','','',1,118,1),(22,'853571152','','四寸水果ins风蛋糕','',0,0,'',0,0.00,0,0.00,39.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'个','','','',1,117,1),(23,'853571152','','❤️四寸红丝绒蛋糕','',0,0,'',0,0.00,0,0.00,39.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'个','','','',1,116,1),(24,'853571152','','肉松小贝两个装','',0,0,'',0,0.00,0,0.00,19.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'盒','','','',1,115,1),(25,'853571152','','❤️北海道戚风杯','',0,0,'',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'','',0,0,'',1626054809,1626054865,0,0,'盒','','','',1,114,1),(26,'853571152','','慕斯杯','',0,0,'',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'杯','','','',1,113,1),(27,'853571152','','可可洛可切块','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'块','','','',1,112,1),(28,'853571152','','蜜桃百香果切块','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'块','','','',1,111,1),(29,'853571152','','抹茶覆盆子切块','',0,0,'',0,0.00,0,0.00,29.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'块','','','',1,110,1),(30,'853571152','','罗马盾牌饼干','',0,0,'',0,0.00,0,0.00,19.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'瓶','','','',1,109,1),(31,'853571152','','蔓越莓饼干','',0,0,'',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'盒','','','',1,106,1),(32,'853571152','','曲奇饼干','',0,0,'',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'盒','','','',1,105,1),(33,'853571152','','纸杯蛋糕','一盒六个',0,0,'',0,0.00,0,0.00,69.00,0.00,-1,-1,0,1,'','',0,0,'',1626054810,1626054866,0,0,'盒','','','',1,102,1);
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
INSERT INTO `cmf_food_category` VALUES (1,1,853571152,'雪媚娘蛋糕','',0,0,0,1626054807,1626054863,0,1,11),(1,2,853571152,'千层蛋糕','',0,0,0,1626054807,1626054863,0,1,10),(1,3,853571152,'毛巾卷','',0,0,0,1626054807,1626054863,0,1,9),(1,4,853571152,'班戟','',0,0,0,1626054807,1626054863,0,1,8),(1,5,853571152,'便当','',0,0,0,1626054807,1626054863,0,1,7),(1,6,853571152,'泡芙蛋糕','',0,0,0,1626054807,1626054863,0,1,6),(1,7,853571152,'四寸蛋糕','',0,0,0,1626054807,1626054863,0,1,5),(1,8,853571152,'切块蛋糕','',0,0,0,1626054807,1626054863,0,1,4),(1,9,853571152,'纸杯蛋糕','',0,0,0,1626054807,1626054863,0,1,3),(1,10,853571152,'饼干蛋糕','',0,0,0,1626054807,1626054863,0,1,2),(1,11,853571152,'','',0,0,0,1626054807,1626054863,1626055189,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_post`
--

LOCK TABLES `cmf_food_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_post` DISABLE KEYS */;
INSERT INTO `cmf_food_category_post` VALUES (1,1,1,1626054807,1626054807),(2,2,1,1626054808,1626054808),(3,3,1,1626054808,1626054808),(4,4,1,1626054808,1626054808),(5,5,1,1626054808,1626054808),(6,6,2,1626054808,1626054808),(7,7,2,1626054808,1626054808),(8,8,3,1626054808,1626054808),(9,9,3,1626054808,1626054808),(10,10,3,1626054808,1626054808),(11,11,3,1626054808,1626054808),(12,12,3,1626054808,1626054808),(13,13,4,1626054808,1626054808),(14,14,4,1626054809,1626054809),(15,15,6,1626054809,1626054809),(16,16,6,1626054809,1626054809),(17,17,6,1626054809,1626054809),(18,18,5,1626054809,1626054809),(19,19,5,1626054809,1626054809),(20,20,5,1626054809,1626054809),(21,21,5,1626054809,1626054809),(22,22,7,1626054809,1626054809),(23,23,7,1626054809,1626054809),(24,24,7,1626054809,1626054809),(25,25,9,1626054809,1626054809),(26,26,8,1626054810,1626054810),(27,27,8,1626054810,1626054810),(28,28,8,1626054810,1626054810),(29,29,8,1626054810,1626054810),(30,30,10,1626054810,1626054810),(31,31,10,1626054810,1626054810),(32,32,10,1626054810,1626054810),(33,33,9,1626054810,1626054810);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme`
--

LOCK TABLES `cmf_mp_theme` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme` VALUES (1,853571152,0,'尼可烘焙','',1,330426681,'tenant/853571152/20210706/a4dce5988b1b647b05b5a77c7039fe74.jpeg','','{}','','tenant/853571152/wechat-exp.jpg','tenant/853571152/wechat-qrcode.jpg','','',1624681103,0,10000,0);
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
INSERT INTO `cmf_mp_theme_page` VALUES (1,1,853571152,1,'首页','home','{}','{}','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]','[{\"data\": [{\"link\": \"\", \"name\": \"\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\", \"file_path\": \"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\"}], \"type\": \"swiper\", \"style\": {\"autoHeight\": true}, \"config\": {\"autoHeight\": true}}, {\"type\": \"container\", \"child\": [{\"data\": [{\"id\": 4, \"desc\": \"安心外送，超快送达\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\", \"title\": \"外卖送餐\", \"action\": {\"url\": \"pages/store/index?scene=takeout\", \"name\": \"外卖送餐\", \"type\": \"func\", \"index\": 1, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\"}, {\"id\": 5, \"desc\": \"下单免排队\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\", \"title\": \"到店取餐\", \"action\": {\"url\": \"pages/store/index?scene=pack\", \"name\": \"到店取餐\", \"type\": \"func\", \"index\": 0, \"method\": \"switchTab\"}, \"file_path\": \"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\"}, {\"id\": 6, \"desc\": \"美味即享\", \"image\": \"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\", \"title\": \"扫码点餐\", \"action\": {\"url\": \"func/scan\", \"name\": \"扫码点餐\", \"type\": \"func\", \"index\": 2, \"method\": \"func/scan\"}, \"file_path\": \"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\"}], \"type\": \"grid\", \"style\": {\"len\": 3, \"theme\": \"third\", \"borderRadius\": 6}, \"config\": {\"theme\": \"third\"}}, {\"data\": [{\"desc\": \"充值立享超多优惠！\", \"field\": \"balance\", \"image\": \"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\", \"title\": \"我的余额\", \"action\": {\"url\": \"pages/mine/money/index\", \"name\": \"余额储值\", \"type\": \"func\", \"index\": 7, \"method\": \"\"}, \"number\": 0}], \"type\": \"userinfo\", \"style\": {\"marginTop\": 10, \"paddingTop\": 10, \"paddingBottom\": 10}, \"config\": {}}, {\"data\": {\"title\": \"自定义标题\", \"value\": \"商家新鲜事\"}, \"type\": \"title\", \"style\": {\"fontSize\": 14, \"marginTop\": 10, \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingBottom\": 10, \"backgroundColor\": \"rgba(255, 255, 255, 0)\", \"backgroundColorRgb\": {\"a\": 0, \"b\": 255, \"g\": 255, \"r\": 255}}, \"config\": {}}, {\"data\": [], \"type\": \"list\", \"style\": {}, \"config\": {}}], \"style\": {\"top\": -15, \"position\": \"relative\", \"paddingTop\": 0, \"paddingLeft\": 10, \"paddingRight\": 10}, \"config\": {}}]',1624681103,1624681103);
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
INSERT INTO `cmf_mp_theme_version` VALUES (2,2059868464,'0.0.1','27','0.1.8',1,'wait','1:小程序内容不符合规则:<br>(1):你好，小程序【点餐】页面无具体运营内容，请上架正式内容或商品（非测试）后重新提交审核。<br>','wechat',1624951713,1625108650),(4,853571152,'0.0.1','29','0.2.0',0,'online','','wechat',1625547879,1626090444);
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
INSERT INTO `cmf_option` VALUES (1,1,'business_info','{\"email\": \"2825333791@qq.com\", \"mobile\": \"18217316822\", \"address\": \"\", \"company\": \"\", \"contact\": \"钱旻\", \"app_desc\": \"100%动物奶油新鲜水果手工制作\", \"app_slogan\": \"生日蛋糕甜品预订\", \"brand_logo\": \"tenant/853571152/20210706/a4dce5988b1b647b05b5a77c7039fe74.jpeg\", \"brand_name\": \"尼可烘焙\", \"out_door_pic\": \"tenant/853571152/20210706/05cda50036c2e1654585a29a37578287.jpg\", \"alipay_logo_id\": \"A*0VQMTY0qkqEAAAAAAAAAAAAADsN1AQ\", \"business_photo\": \"tenant/853571152/20210706/4436afc01be42187be400e66504a9989.jpg\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"tenant/853571152/20210706/c0efde4c1c30e750ff6d20d287f8763b.jpg\", \"mini_category_ids\": \"XS1009_XS2074_XS3113\"}',853571152,0),(2,1,'subscribe','{\"pay_tmp_id\": \"8XmNLIvO6gQt6SEklIQ97m4P85sS8-_CwaCU_UE8cU0\", \"refund_tmp_id\": \"1nJmMntQnBN7wLodM3B9jaJYwhRswMDxCxV77KVxx2Q\", \"finished_tmp_id\": \"sO7iI5csMPVR2gLP39sr68VTFkGK6wLCAFD2jQoyLeo\"}',853571152,0),(3,1,'eatin','{\"day\": 0, \"status\": 1, \"eat_type\": 1, \"pay_type\": 0, \"sale_type\": 0, \"surcharge\": 0, \"order_type\": 0, \"sell_clear\": \"\", \"custom_name\": \"\", \"custom_enabled\": 0, \"surcharge_type\": 0, \"enabled_sell_clear\": 0, \"enabled_appointment\": 0}',853571152,1),(4,1,'takeout','{\"day\": 0, \"status\": 1, \"step_km\": 2, \"start_km\": 2, \"step_fee\": 2, \"min_price\": 30, \"start_fee\": 2, \"sell_clear\": \"\", \"first_class\": \"蛋糕\", \"second_class\": \"蛋糕\", \"delivery_times\": [{\"end_time\": \"21:00\", \"start_time\": \"10:00\"}], \"automatic_order\": 1, \"stop_before_min\": 30, \"delivery_percent\": 80, \"delivery_distance\": 10, \"enabled_sell_clear\": 0, \"immediate_delivery\": 1, \"enabled_appointment\": 1}',853571152,1);
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
INSERT INTO `cmf_portal_category` VALUES (1,853571152,0,0,1,0,10000,'新鲜事','','','','','','','','','','');
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
INSERT INTO `cmf_role` VALUES (853571152,1,0,'超级管理员','拥有网站最高管理员权限！',10000,1624681103,1624681103,1),(853571152,2,0,'收银员','收银员！',1,1624681103,1624681103,1),(853571152,3,0,'财务','财务！',2,1624681103,1624681103,1);
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
INSERT INTO `cmf_store` VALUES (1,'2021070400502000000020295356',853571152,1571836940,'2021070400077000000023765992','尼可蛋糕店',1,'S08','1701','18217316822','店长',310000,'上海市',310100,'市辖区',310109,'虹口区','广粤路591-2号 尼可蛋糕店','tenant/853571152/20210704/4699cc7e5a32fb8a26427d2dc3af61c4.jpg',121.4674650,31.2943740,0,0,'','',1625368047,1625368047,0,'passed','',NULL);
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
INSERT INTO `cmf_store_hours` VALUES (853571152,1,1,1,1,1,1,1,1,'10:00','22:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_part`
--

LOCK TABLES `cmf_third_part` WRITE;
/*!40000 ALTER TABLE `cmf_third_part` DISABLE KEYS */;
INSERT INTO `cmf_third_part` VALUES (1,853571152,'wechat-mp',0,'osqml4ugmhk263YMKUwYWiZ_pnCQ','76CQFkblu3NowEbAViB1Zg=='),(2,853571152,'wechat-mp',0,'osqml4lZG8NxqMXcLMTKU5NNUvYI','T8ZZermQKp6VqxIJ+lluUw=='),(3,853571152,'alipay-mp',0,'2088042865655966',''),(4,853571152,'alipay-mp',0,'2088142405693888',''),(5,853571152,'wechat-mp',0,'osqml4qhbWiXcsO_u-ccTxEK6Ru0','EcXw9oh4yOozAPMeJhoiQQ=='),(6,853571152,'alipay-mp',0,'2088712679463313',''),(7,853571152,'alipay-mp',0,'2088312109529477',''),(8,853571152,'wechat-mp',0,'osqml4uBU8SDpjLRCfwjShZ4fzfA','FTUf/LTBWlnjzrmLTjAO7A=='),(9,853571152,'wechat-mp',0,'osqml4lxe__14ldxtbKDg7dHI9Ho','Y0JUBZCoMjAB6/CsKAXydg=='),(10,853571152,'wechat-mp',0,'osqml4o_tNG4B29Es0cvNQ3lS1JM','Dfa5CnHqI/zFoxoCh5NdFg=='),(11,853571152,'wechat-mp',1,'osqml4ogio7vn6KQueIoJMAdNcEA','yY3tW/ON6HWt0TNNKtQ3QQ=='),(12,853571152,'wechat-mp',0,'osqml4qh7u8efbPx5aoPMTMh-CS4','uTsdGdsVmGvsma2DjSiFXg=='),(13,853571152,'alipay-mp',0,'2088512446596714',''),(14,853571152,'wechat-mp',0,'osqml4inVOJ5CxTEOQ4NvaqbSqOw','+Bm5TR6SzF96exAPSaoOWg=='),(15,853571152,'wechat-mp',0,'osqml4iORdJsJ6zVWCSdOjBKKInk','ftw7KDalHPo9T8SUFHTAlQ=='),(16,853571152,'alipay-mp',0,'2088532636361975',''),(17,853571152,'wechat-mp',0,'osqml4pr458luKL1d0zmmJCPDdBo','xvwIrzhh64pZVm69uqNZUw=='),(18,853571152,'wechat-mp',0,'osqml4spxLNpQROn7omApiktC07o','yp1kVUrZEFnUCqj6rBqVKA=='),(19,853571152,'wechat-mp',0,'osqml4i4GoXioHVsao-_LWmjyOEw','NtLBnCDu1gb3e1JFJfomhg=='),(20,853571152,'wechat-mp',0,'osqml4hYkPl1700tlBnXQZ3-eooQ','WPs2s9nUZWEv8pgHmstqDQ=='),(21,853571152,'alipay-mp',0,'2088902952540143',''),(22,853571152,'wechat-mp',0,'osqml4psq5atvdYQXWLmF_jFNvUM','1fuyQz2VL3Gpgcf16AX1Gw=='),(23,853571152,'wechat-mp',0,'osqml4qHu3fBMHlWe1aICeoIlNq0','4IsHv2Wi+c2vKOCkhM5t2Q=='),(24,853571152,'wechat-mp',0,'osqml4tON7BV1nuXnLdLtEEYQSKw','0lWUbK6oEN2YpcgiLRctAA=='),(25,853571152,'wechat-mp',2,'osqml4mgfy2JHRHEBmj4M3ul4S_A','9MmjNavOfKWAI7jqfGhgyQ=='),(26,853571152,'wechat-mp',0,'osqml4t0EQCMq3CN87HVW93bNPLQ','q7xBBxOFqE89k8rU8EotGw=='),(27,853571152,'wechat-mp',0,'osqml4u-V6dV0lentnyy-rHrxFOI','d3Ej1KkstT55K4f7RLkOXQ=='),(28,853571152,'alipay-mp',0,'2088822819100450',''),(29,853571152,'alipay-mp',0,'2088822264971948',''),(30,853571152,'wechat-mp',0,'osqml4m04vA1kS-aF9DT8ECTxbDE','dUtKwux4Ty9u/qvrsfUOnQ=='),(31,853571152,'wechat-mp',0,'osqml4gyWRho10QnF4iNmLb5sIJY','em/0rM0Jo5erqr+x1TWzvg=='),(32,853571152,'alipay-mp',0,'2088422993473014','');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
INSERT INTO `cmf_user` VALUES (1,0,0,0,1629634121,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','18217316822','',853571152),(2,0,0,0,1633927111,0,0,0,0.000000,1631159611,1631159611,0,1,'','','','','','','','','127.0.0.1','','13482793656','',853571152);
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
-- Dumping events for database 'tenant_330426681'
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-06-24 19:40:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-06-24 19:40:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card SET status = -1 WHERE end_at between 0 AND UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-06-24 19:40:53' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderFinishStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-06-24 19:40:53' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > appointment_at + 43200 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `rechargeOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-06-24 19:40:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_recharge_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucher` ON SCHEDULE EVERY 1 SECOND STARTS '2021-06-24 19:40:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher SET status = 2 WHERE UNIX_TIMESTAMP(publish_end_time) < UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucherPost` ON SCHEDULE EVERY 1 SECOND STARTS '2021-06-24 19:40:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher_post SET status = 2 WHERE valid_end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tenant_330426681'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:05:32
