-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: tenant_1442096236
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
-- Current Database: `tenant_1442096236`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenant_1442096236` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tenant_1442096236`;

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
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `longitude` decimal(10,7) NOT NULL COMMENT '经度',
  `latitude` decimal(10,7) NOT NULL COMMENT '纬度',
  `room` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '门牌号',
  `default` tinyint(3) NOT NULL COMMENT '默认',
  `province_name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省份名称',
  `district_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '县区名称',
  `city_name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市区名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_address`
--

LOCK TABLES `cmf_address` WRITE;
/*!40000 ALTER TABLE `cmf_address` DISABLE KEYS */;
INSERT INTO `cmf_address` VALUES (1,298190799,'陈',19,0,'17805595210','上海市松江区九里亭街道九城湖滨',121.3188980,31.1493220,'大门旁边的链家前台',1,'','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_notice`
--

LOCK TABLES `cmf_admin_notice` WRITE;
/*!40000 ALTER TABLE `cmf_admin_notice` DISABLE KEYS */;
INSERT INTO `cmf_admin_notice` VALUES (298190799,1,'堂食订单通知','您有新的堂食订单，请及时处理！',5,1622364438,0,1,'https://cdn.mashangdian.cn/eatin.mp3',1),(298190799,2,'堂食订单通知','您有新的堂食订单，请及时处理！',9,1622960217,0,1,'https://cdn.mashangdian.cn/eatin.mp3',0),(298190799,3,'打包订单通知','您有新的打包订单，请及时处理！',10,1622960349,0,1,'https://cdn.mashangdian.cn/pack.mp3',1),(298190799,4,'打包订单通知','您有新的打包订单，请及时处理！',15,1625026746,0,1,'https://cdn.mashangdian.cn/pack.mp3',1),(298190799,5,'堂食订单通知','您有新的堂食订单，请及时处理！',16,1626010493,0,1,'https://cdn.mashangdian.cn/eatin.mp3',1),(298190799,6,'堂食订单通知','您有新的堂食订单，请及时处理！',17,1626603413,0,1,'https://cdn.mashangdian.cn/eatin.mp3',0),(298190799,7,'堂食订单通知','您有新的堂食订单，请及时处理！',18,1626611987,0,1,'https://cdn.mashangdian.cn/eatin.mp3',0),(298190799,8,'堂食订单通知','您有新的堂食订单，请及时处理！',19,1626612016,0,1,'https://cdn.mashangdian.cn/eatin.mp3',1),(298190799,9,'堂食订单通知','您有新的堂食订单，请及时处理！',20,1626775918,0,0,'https://cdn.mashangdian.cn/eatin.mp3',1),(298190799,10,'堂食订单通知','您有新的堂食订单，请及时处理！',21,1626861888,0,0,'https://cdn.mashangdian.cn/eatin.mp3',1),(298190799,11,'堂食订单通知','您有新的堂食订单，请及时处理！',22,1627030352,0,0,'https://cdn.mashangdian.cn/eatin.mp3',1);
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
INSERT INTO `cmf_admin_user` VALUES (1,0,0,1621681264,0,0,1,'17887909742','3ffc0ef0ced4e6824cc61b5afdedcff4','17887909742','','','','','17887909742','');
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
INSERT INTO `cmf_applyment` VALUES (1,'1621914217',2000002191013147,'{\"indoor\": {\"name\": \"朕有茶门头.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZPcx9GVOkcpTHx-ZfwSfWpkBKjCxeZvEG6_zbdlvWRv9nXhjFcKMttmt7D4ic-pl56mLk9bF3gi-gbb4Sr3jx1E\", \"file_name\": \"028563360d9ede5b2b4ee1de7a1b282b.jpg\", \"file_path\": \"default/20210525/028563360d9ede5b2b4ee1de7a1b282b.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/028563360d9ede5b2b4ee1de7a1b282b.jpg\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"身份证正.jpg\", \"media_id\": \"rBSDO9YqqYbXDppANecZmC4nO0gnCv-qxLuiC5UcmrW5sM68KY2qThx5EbvjjTjDGkvGhYmqv1DKk8mUcVhoswRQDa44i6V0HxtLb_-tt2c\", \"file_name\": \"fd84bd065683753c4ac1d50d077f3850.jpg\", \"file_path\": \"default/20210526/fd84bd065683753c4ac1d50d077f3850.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210526/fd84bd065683753c4ac1d50d077f3850.jpg\"}, \"license_copy\": {\"name\": \"营业执照.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZJBDOi2omTPaYISAV28-UIND1EVyJJyG0topg4WMZ0byPN2x1eb_tZayfDDeTApo88tyhXI8wCMGWaB44hV07uU\", \"file_name\": \"89e7da27fca4a3054051d2f6559b65bf.jpg\", \"file_path\": \"default/20210525/89e7da27fca4a3054051d2f6559b65bf.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/89e7da27fca4a3054051d2f6559b65bf.jpg\"}, \"mini_program\": [{\"name\": \"小程序4.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZB3Cne32YPfU83mX1JviMBzeI0O1siIGj84j_FQ-2-8aAkUw0XbIgVuClYVwM4KCBIEl2yKAolKXRYCjwmzRs7g\", \"file_name\": \"608d8a910d47690651c67f736e834f1c.jpg\", \"file_path\": \"default/20210525/608d8a910d47690651c67f736e834f1c.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/608d8a910d47690651c67f736e834f1c.jpg\"}], \"qualifications\": {\"name\": \"食品安全.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZBa9YU55SoVvPCqDjygjizl8H8QcEDsaK7a8x27nzqrU2x_6jFBkWSTzywRyhpR88JUyszCOmKGoFkzmfVe32as\", \"file_name\": \"3e8e7c375d7a254c20c208d63d434653.jpg\", \"file_path\": \"default/20210525/3e8e7c375d7a254c20c208d63d434653.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/3e8e7c375d7a254c20c208d63d434653.jpg\"}, \"store_entrance\": {\"name\": \"朕有茶门头.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZEMq_kke1lS0iVqEs7EjdvbtcySSBja0EhCz3BLiOdHoMh8GgFCqu6qSesKBQGYKsC4sOFlKji5piE8xJ8GcYnw\", \"file_name\": \"58479ff670c37202b21c75ae2d29daff.jpg\", \"file_path\": \"default/20210525/58479ff670c37202b21c75ae2d29daff.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/58479ff670c37202b21c75ae2d29daff.jpg\"}, \"id_card_national\": {\"name\": \"身份证反.jpg\", \"media_id\": \"rBSDO9YqqYbXDppANecZmFza_y97Qnum4xAMPE8CkuFDlpObXAjProX158x7_00xPJiEfh_UiGL3sFQ8RcIDfp8zqI4gWVsdvQTHMA6Nvf0\", \"file_name\": \"a65c2689ba4cd7977eb8f12f7ad3da27.jpg\", \"file_path\": \"default/20210526/a65c2689ba4cd7977eb8f12f7ad3da27.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210526/a65c2689ba4cd7977eb8f12f7ad3da27.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}','{\"MediaList\": {\"Indoor\": {\"Name\": \"朕有茶门头.jpg\", \"MediaId\": \"RXedSuxiAEkRy27X0C6CZPcx9GVOkcpTHx-ZfwSfWpkBKjCxeZvEG6_zbdlvWRv9nXhjFcKMttmt7D4ic-pl56mLk9bF3gi-gbb4Sr3jx1E\", \"FileName\": \"028563360d9ede5b2b4ee1de7a1b282b.jpg\", \"FilePath\": \"default/20210525/028563360d9ede5b2b4ee1de7a1b282b.jpg\", \"PrevPath\": \"http://console.mashangdian.cn/uploads/default/20210525/028563360d9ede5b2b4ee1de7a1b282b.jpg\"}, \"IdDocCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}, \"IdCardCopy\": {\"Name\": \"身份证正.jpg\", \"MediaId\": \"rBSDO9YqqYbXDppANecZmC4nO0gnCv-qxLuiC5UcmrW5sM68KY2qThx5EbvjjTjDGkvGhYmqv1DKk8mUcVhoswRQDa44i6V0HxtLb_-tt2c\", \"FileName\": \"fd84bd065683753c4ac1d50d077f3850.jpg\", \"FilePath\": \"default/20210526/fd84bd065683753c4ac1d50d077f3850.jpg\", \"PrevPath\": \"http://console.mashangdian.cn/uploads/default/20210526/fd84bd065683753c4ac1d50d077f3850.jpg\"}, \"LicenseCopy\": {\"Name\": \"营业执照.jpg\", \"MediaId\": \"RXedSuxiAEkRy27X0C6CZJBDOi2omTPaYISAV28-UIND1EVyJJyG0topg4WMZ0byPN2x1eb_tZayfDDeTApo88tyhXI8wCMGWaB44hV07uU\", \"FileName\": \"89e7da27fca4a3054051d2f6559b65bf.jpg\", \"FilePath\": \"default/20210525/89e7da27fca4a3054051d2f6559b65bf.jpg\", \"PrevPath\": \"http://console.mashangdian.cn/uploads/default/20210525/89e7da27fca4a3054051d2f6559b65bf.jpg\"}, \"MiniProgram\": [{\"Name\": \"小程序4.jpg\", \"MediaId\": \"RXedSuxiAEkRy27X0C6CZB3Cne32YPfU83mX1JviMBzeI0O1siIGj84j_FQ-2-8aAkUw0XbIgVuClYVwM4KCBIEl2yKAolKXRYCjwmzRs7g\", \"FileName\": \"608d8a910d47690651c67f736e834f1c.jpg\", \"FilePath\": \"default/20210525/608d8a910d47690651c67f736e834f1c.jpg\", \"PrevPath\": \"http://console.mashangdian.cn/uploads/default/20210525/608d8a910d47690651c67f736e834f1c.jpg\"}], \"StoreEntrance\": {\"Name\": \"朕有茶门头.jpg\", \"MediaId\": \"RXedSuxiAEkRy27X0C6CZEMq_kke1lS0iVqEs7EjdvbtcySSBja0EhCz3BLiOdHoMh8GgFCqu6qSesKBQGYKsC4sOFlKji5piE8xJ8GcYnw\", \"FileName\": \"58479ff670c37202b21c75ae2d29daff.jpg\", \"FilePath\": \"default/20210525/58479ff670c37202b21c75ae2d29daff.jpg\", \"PrevPath\": \"http://console.mashangdian.cn/uploads/default/20210525/58479ff670c37202b21c75ae2d29daff.jpg\"}, \"IdCardNational\": {\"Name\": \"身份证反.jpg\", \"MediaId\": \"rBSDO9YqqYbXDppANecZmFza_y97Qnum4xAMPE8CkuFDlpObXAjProX158x7_00xPJiEfh_UiGL3sFQ8RcIDfp8zqI4gWVsdvQTHMA6Nvf0\", \"FileName\": \"a65c2689ba4cd7977eb8f12f7ad3da27.jpg\", \"FilePath\": \"default/20210526/a65c2689ba4cd7977eb8f12f7ad3da27.jpg\", \"PrevPath\": \"http://console.mashangdian.cn/uploads/default/20210526/a65c2689ba4cd7977eb8f12f7ad3da27.jpg\"}, \"Qualifications\": {\"Name\": \"食品安全.jpg\", \"MediaId\": \"RXedSuxiAEkRy27X0C6CZBa9YU55SoVvPCqDjygjizl8H8QcEDsaK7a8x27nzqrU2x_6jFBkWSTzywRyhpR88JUyszCOmKGoFkzmfVe32as\", \"FileName\": \"3e8e7c375d7a254c20c208d63d434653.jpg\", \"FilePath\": \"default/20210525/3e8e7c375d7a254c20c208d63d434653.jpg\", \"PrevPath\": \"http://console.mashangdian.cn/uploads/default/20210525/3e8e7c375d7a254c20c208d63d434653.jpg\"}, \"BusinessAddition\": [], \"OrganizationCopy\": {\"Name\": \"\", \"MediaId\": \"\", \"FileName\": \"\", \"FilePath\": \"\", \"PrevPath\": \"\"}}, \"contact_info\": {\"contact_name\": \"bRM2bpA6tc5MBpoc/qI9YSKgSf6waO/0IqJbZdjHobvf2X1l2SkoTArCbOk7wbc1rnfc1DFGOL4qqSCa71Y0MT79GmCDVp8rrTRr726VtNYRpkl0U0hMpyJ0oALhqt9Oi7gmImz4FhxFBHSOMODO4vRWvIwD/RHf1mQRqCdeTDN+79LpDvcGH6o+azzTcBmeMJtMEylDl8h27Z8z8EM43MPU83acopiU7YT3x3k1baM6Rwc4xOlGc1veIRqgLNRoxTHsoygTfdfPspSdsPp+Dky1zmxAehiYIqWXMS0Xn+o0u1s9gcPNpEs7R0WePDe4IIhheLipdDD1+Ye5RTGIAA==\", \"mobile_phone\": \"oMFBD1gVxCIwXjerjjOfZDlTaSJlrAGWFiEoDYF8i2rsdAwECdhxCTH1yrRlwAxEbp/IIVyv4aq6l/QHdg9Y+/7pdBuaiq4HxSBXfRuGS0j+c+9VMxiFKGLvwTF2mRGxSxbmAsOLCYVS/HytuIyHEn8W9Tc2MCqYeEIErvK9EmgoZXE9ZkCbJ1Re25FQU/F5AtXnJ6R09hccxpptdg9/fV+YdQg/96caI9wSIpRzeBoemW1VfD15y5wDI82SBnGewUsXnKBUjBFCkFHUhQqcM59XwPsUmBnwZH94xMwTcc9cbQI9trXRO+Je/sbwUU5JSqdpSaTjkU96s+Ktk8E9qg==\", \"contact_email\": \"gNnY2SoKOV4ex5uyTuE6cV1vmDQLp2QyaYujxFXKgOqsiz3SaRbWqgWn8SHTlwdnOx8MGAeLWgPZMyjf9RM0BQmT90CcT3gMr3OUx4EqQD1loiiUCdhOE4wb3i/QFoGj/GOX7DkRMgilK2h3stGOeQ8sUtBK8zLNzRhfkcsBC5p1faNSO2/SuHZLg3SVEE8+3ZZCuVHvksiNToGTF2bJHtxFisq1D6ZRQ5l9y9VM8Taf/DSvnCWiRjGR45Wk+BAcUsadzjVgPbt2frGVzrzBApQOrS/NOofkBuFaoYB/8HIKIhwTknhcJNHof44CW2rMC+1cn4vlVQMF2nMP7tUlbA==\", \"contact_id_number\": \"hN0Hix8Q+IzU13OeRp6LMhldVbCYHhCq0asub3bjErY9Bjs0EMz8QK2cf5IiFbJEij05znLXf/eH2fSo9a8BQVoXEjKIRy0W2OB2/X3fJFfSlWP34VoiHg5M+n9hN6BukO93rL9KuQxYgReURvd3zsAVf/61JJB69nA1pdJK9PEFkkCqVaqumuvjjVB3xSKLnL3D9CVr5smmYjrXQ1cO7BQhcPdwY3cSqsw4RWh8GPchU4tau0yr/wHv/hX2easZgssXfazQhMWHfsFMF1wY/a6/HwjAKFpkAAJUwANjLu7Vf2D5Au0E/0gRuezWPbxWpiC03j6KKDRFWMqOLGuTLw==\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"rBSDO9YqqYbXDppANecZmC4nO0gnCv-qxLuiC5UcmrW5sM68KY2qThx5EbvjjTjDGkvGhYmqv1DKk8mUcVhoswRQDa44i6V0HxtLb_-tt2c\", \"id_card_name\": \"TkjfayTwJu11h0h3vqknBguXUDHl5WjuLEfmov5vmk/j6M3n4S6xLR0Sz8aVI4k9Rj3/lzmMdO6lUF6ykrjvNaSIGz7avCKGVG+w4vVN3m1Mx6+eGECyAdh/MR8Nt/q3FyO6t7FGexmDypV0NtjfuMX42HCf+9GY8+cb2jOXE37kxlfZQhjOUjdJZSM+W9/+BsQr5HY0vHlGVOE1VoLYOksUMfphpkkxD+Gf/AwVUHW32WLYy76B6VQwcU5o9fUHCfKwEPfeWYzblVKLm5+8AGGiUCR8T9YbIXsnHI4Jr5TrkrsqzObLkEi8DpVE8O7WWZBYbP/tqlbaWAL9y79kpg==\", \"id_card_number\": \"cuqGq52VVy7br849n9iljhLuRTLkOHF6s29zCK2xwVU6kwHLGHoy49VxHuYqZNxmT4PUEZnfURfdwceO0yuDpVDtx3oDCO15IZVOrILRsDnJXimY75oRydOr3YZjI/emXWQITlpmK1qePHeWgLuVG7LeXlXorVoICXx/kZt4Bf8OS7pV3/xRf8HPaq9I/kNXb6jfXKHTBvHPOUAzg9fd7Oip02ogJC+M03tJmuN6eE5XCCrASIfONG8u4xC4mtNOnQXFYH9U4LRs+Ia41Uqh2CrKTOLJZzjAMjnJi7u03c51fAJeTzJwysTbI9ao7Ak358eS3xP06yC5WokXiF5FkQ==\", \"card_period_end\": \"2040-06-11\", \"id_card_national\": \"rBSDO9YqqYbXDppANecZmFza_y97Qnum4xAMPE8CkuFDlpObXAjProX158x7_00xPJiEfh_UiGL3sFQ8RcIDfp8zqI4gWVsdvQTHMA6Nvf0\", \"card_period_begin\": \"2020-06-11\"}}, \"business_license_info\": {\"legal_person\": \"周凤\", \"license_copy\": \"RXedSuxiAEkRy27X0C6CZJBDOi2omTPaYISAV28-UIND1EVyJJyG0topg4WMZ0byPN2x1eb_tZayfDDeTApo88tyhXI8wCMGWaB44hV07uU\", \"merchant_name\": \"上海市宝山区周凤饮品店\", \"license_number\": \"92310113MA1L1RWW24\"}}, \"business_code\": \"1621914217\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"RXedSuxiAEkRy27X0C6CZPcx9GVOkcpTHx-ZfwSfWpkBKjCxeZvEG6_zbdlvWRv9nXhjFcKMttmt7D4ic-pl56mLk9bF3gi-gbb4Sr3jx1E\"], \"biz_store_name\": \"朕有茶\", \"BizAddressRegion\": [310000, 310100, 310112], \"biz_address_code\": \"310112\", \"biz_store_address\": \"逸仙路1328号40幢 上海市宝山区逸仙路1328号40幢朕有茶\", \"store_entrance_pic\": [\"RXedSuxiAEkRy27X0C6CZEMq_kke1lS0iVqEs7EjdvbtcySSBja0EhCz3BLiOdHoMh8GgFCqu6qSesKBQGYKsC4sOFlKji5piE8xJ8GcYnw\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"RXedSuxiAEkRy27X0C6CZB3Cne32YPfU83mX1JviMBzeI0O1siIGj84j_FQ-2-8aAkUw0XbIgVuClYVwM4KCBIEl2yKAolKXRYCjwmzRs7g\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"17887909742\", \"merchant_shortname\": \"朕有茶\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"RXedSuxiAEkRy27X0C6CZBa9YU55SoVvPCqDjygjizl8H8QcEDsaK7a8x27nzqrU2x_6jFBkWSTzywRyhpR88JUyszCOmKGoFkzmfVe32as\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"兴业银行\", \"account_name\": \"iZfN57rWO6rFQGfoTamBycREnK7JUtSmCYSDmmWhgoFYttR3s5T7xoMRXgfWJs5wxE/EJgNPdEt/us/hWJ9w/+hKNpaPK/a83tjrrCZ/j/7Bu1ObC4lb7QKg+EeZOD4srfIk6Y9NU37Qllm5GgPzHCD1jrgdmhWGAvLspOQ3p+s+lJN7ex4bNusMwAtqoqQwRZCNF6P7HtVpH+U4aiVrR5DBVh7r3MznySV5uD5+6VQaIAlasz6xDrzPgoIyrSAn54amelb1vYdsbhwtVosXwIIwCZXqqUL1zRGLI84qS2ZjORSkq2dSUnU5wrocZPMNUv1WiZIS6is/JUvrhiMT1g==\", \"account_number\": \"Fs7O5jmLIe6SIju3mH5R3/q4dFT29SQ4Jz1wBWGutIU43KT+g17CDs9U5WJtdZddRQBz1vAlcoFno23kK5yOiI8ttxdSxQ7pF3CMYBcP9sYcPGr3gQc7rpIRm9cYWIp4dCXInlPSc80TgK1ox4d40ZXdefoARYBggtjaCfnNS7zONJ71jyMo0P2ws0UFfvSN+hzGPx5Qp8Q9U4T8RImw4Uik6VqmOk9Etb+F6VNiJ45JKW+iR1mqpaRF08tOAJggEFSzeHBlUh/Qnng8NIym2hbpG7fmuxHkxYMyvqLQOBPJG3mNaSS0as84T3Gekie0aRkZvcvfLgG3zNM6Yh1fQw==\", \"BankAddressRegion\": [310000, 310100, 310110], \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"310110\"}}','{\"media_list\": {\"indoor\": {\"name\": \"朕有茶门头.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZPcx9GVOkcpTHx-ZfwSfWpkBKjCxeZvEG6_zbdlvWRv9nXhjFcKMttmt7D4ic-pl56mLk9bF3gi-gbb4Sr3jx1E\", \"file_name\": \"028563360d9ede5b2b4ee1de7a1b282b.jpg\", \"file_path\": \"default/20210525/028563360d9ede5b2b4ee1de7a1b282b.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/028563360d9ede5b2b4ee1de7a1b282b.jpg\"}, \"id_doc_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}, \"id_card_copy\": {\"name\": \"身份证正.jpg\", \"media_id\": \"rBSDO9YqqYbXDppANecZmC4nO0gnCv-qxLuiC5UcmrW5sM68KY2qThx5EbvjjTjDGkvGhYmqv1DKk8mUcVhoswRQDa44i6V0HxtLb_-tt2c\", \"file_name\": \"fd84bd065683753c4ac1d50d077f3850.jpg\", \"file_path\": \"default/20210526/fd84bd065683753c4ac1d50d077f3850.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210526/fd84bd065683753c4ac1d50d077f3850.jpg\"}, \"license_copy\": {\"name\": \"营业执照.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZJBDOi2omTPaYISAV28-UIND1EVyJJyG0topg4WMZ0byPN2x1eb_tZayfDDeTApo88tyhXI8wCMGWaB44hV07uU\", \"file_name\": \"89e7da27fca4a3054051d2f6559b65bf.jpg\", \"file_path\": \"default/20210525/89e7da27fca4a3054051d2f6559b65bf.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/89e7da27fca4a3054051d2f6559b65bf.jpg\"}, \"mini_program\": [{\"name\": \"小程序4.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZB3Cne32YPfU83mX1JviMBzeI0O1siIGj84j_FQ-2-8aAkUw0XbIgVuClYVwM4KCBIEl2yKAolKXRYCjwmzRs7g\", \"file_name\": \"608d8a910d47690651c67f736e834f1c.jpg\", \"file_path\": \"default/20210525/608d8a910d47690651c67f736e834f1c.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/608d8a910d47690651c67f736e834f1c.jpg\"}], \"qualifications\": {\"name\": \"食品安全.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZBa9YU55SoVvPCqDjygjizl8H8QcEDsaK7a8x27nzqrU2x_6jFBkWSTzywRyhpR88JUyszCOmKGoFkzmfVe32as\", \"file_name\": \"3e8e7c375d7a254c20c208d63d434653.jpg\", \"file_path\": \"default/20210525/3e8e7c375d7a254c20c208d63d434653.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/3e8e7c375d7a254c20c208d63d434653.jpg\"}, \"store_entrance\": {\"name\": \"朕有茶门头.jpg\", \"media_id\": \"RXedSuxiAEkRy27X0C6CZEMq_kke1lS0iVqEs7EjdvbtcySSBja0EhCz3BLiOdHoMh8GgFCqu6qSesKBQGYKsC4sOFlKji5piE8xJ8GcYnw\", \"file_name\": \"58479ff670c37202b21c75ae2d29daff.jpg\", \"file_path\": \"default/20210525/58479ff670c37202b21c75ae2d29daff.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210525/58479ff670c37202b21c75ae2d29daff.jpg\"}, \"id_card_national\": {\"name\": \"身份证反.jpg\", \"media_id\": \"rBSDO9YqqYbXDppANecZmFza_y97Qnum4xAMPE8CkuFDlpObXAjProX158x7_00xPJiEfh_UiGL3sFQ8RcIDfp8zqI4gWVsdvQTHMA6Nvf0\", \"file_name\": \"a65c2689ba4cd7977eb8f12f7ad3da27.jpg\", \"file_path\": \"default/20210526/a65c2689ba4cd7977eb8f12f7ad3da27.jpg\", \"prev_path\": \"http://console.mashangdian.cn/uploads/default/20210526/a65c2689ba4cd7977eb8f12f7ad3da27.jpg\"}, \"organization_copy\": {\"name\": \"\", \"media_id\": \"\", \"file_name\": \"\", \"file_path\": \"\", \"prev_path\": \"\"}}, \"contact_info\": {\"contact_name\": \"周凤\", \"mobile_phone\": \"17887909742\", \"contact_email\": \"17887909742@139.com\", \"contact_id_number\": \"341126198411020925\"}, \"subject_info\": {\"subject_type\": \"SUBJECT_TYPE_INDIVIDUAL\", \"identity_info\": {\"owner\": true, \"id_doc_info\": {\"id_doc_copy\": \"\", \"id_doc_name\": \"\", \"id_doc_number\": \"\", \"doc_period_end\": \"\", \"doc_period_begin\": \"\"}, \"id_doc_type\": \"IDENTIFICATION_TYPE_IDCARD\", \"id_card_info\": {\"id_card_copy\": \"rBSDO9YqqYbXDppANecZmC4nO0gnCv-qxLuiC5UcmrW5sM68KY2qThx5EbvjjTjDGkvGhYmqv1DKk8mUcVhoswRQDa44i6V0HxtLb_-tt2c\", \"id_card_name\": \"周凤\", \"id_card_number\": \"341126198411020925\", \"card_period_end\": \"2040-06-11\", \"id_card_national\": \"rBSDO9YqqYbXDppANecZmFza_y97Qnum4xAMPE8CkuFDlpObXAjProX158x7_00xPJiEfh_UiGL3sFQ8RcIDfp8zqI4gWVsdvQTHMA6Nvf0\", \"card_period_begin\": \"2020-06-11\"}}, \"organization_info\": {}, \"business_license_info\": {\"legal_person\": \"周凤\", \"license_copy\": \"RXedSuxiAEkRy27X0C6CZJBDOi2omTPaYISAV28-UIND1EVyJJyG0topg4WMZ0byPN2x1eb_tZayfDDeTApo88tyhXI8wCMGWaB44hV07uU\", \"merchant_name\": \"上海市宝山区周凤饮品店\", \"license_number\": \"92310113MA1L1RWW24\"}}, \"addition_info\": {}, \"business_code\": \"APPLYMENT_1622027294\", \"business_info\": {\"sales_info\": {\"biz_store_info\": {\"indoor_pic\": [\"RXedSuxiAEkRy27X0C6CZPcx9GVOkcpTHx-ZfwSfWpkBKjCxeZvEG6_zbdlvWRv9nXhjFcKMttmt7D4ic-pl56mLk9bF3gi-gbb4Sr3jx1E\"], \"biz_store_name\": \"朕有茶\", \"biz_address_code\": \"310112\", \"biz_store_address\": \"逸仙路1328号40幢 上海市宝山区逸仙路1328号40幢朕有茶\", \"biz_address_region\": [310000, 310100, 310112], \"store_entrance_pic\": [\"RXedSuxiAEkRy27X0C6CZEMq_kke1lS0iVqEs7EjdvbtcySSBja0EhCz3BLiOdHoMh8GgFCqu6qSesKBQGYKsC4sOFlKji5piE8xJ8GcYnw\"]}, \"mini_program_info\": {\"mini_program_pics\": [\"RXedSuxiAEkRy27X0C6CZB3Cne32YPfU83mX1JviMBzeI0O1siIGj84j_FQ-2-8aAkUw0XbIgVuClYVwM4KCBIEl2yKAolKXRYCjwmzRs7g\"], \"mini_program_appid\": \"wx1da941c68db4f659\"}, \"sales_scenes_type\": [\"SALES_SCENES_STORE\", \"SALES_SCENES_MINI_PROGRAM\"]}, \"service_phone\": \"17887909742\", \"merchant_shortname\": \"朕有茶\"}, \"settlement_info\": {\"activities_id\": \"20191030111cff5b5e\", \"settlement_id\": \"719\", \"qualifications\": [\"RXedSuxiAEkRy27X0C6CZBa9YU55SoVvPCqDjygjizl8H8QcEDsaK7a8x27nzqrU2x_6jFBkWSTzywRyhpR88JUyszCOmKGoFkzmfVe32as\"], \"activities_rate\": \"0.38\", \"qualification_type\": \"餐饮\"}, \"bank_account_info\": {\"account_bank\": \"兴业银行\", \"account_name\": \"周凤\", \"account_number\": \"622908213057779517\", \"bank_account_type\": \"BANK_ACCOUNT_TYPE_PERSONAL\", \"bank_address_code\": \"310110\", \"bank_address_region\": [310000, 310100, 310110]}}',1621914217,1622100126,'1609876793','https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEx8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyTWo2ZzlIb3JlUjIxVU9nbHh3Y2gAAgQyA65gAwQAjScA','APPLYMENT_STATE_FINISHED','','[]');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,33787,1621681663,1,'f84eddc8-9834-4eb8-453d-844d576731a1','logo.png','6781eda52b26624c6ec1d7eecd8c323a.png','default/20210522/6781eda52b26624c6ec1d7eecd8c323a.png','png',0,'',0),(2,1,156931,1621772130,1,'5d1c95a6-dfb2-4d91-54bf-ebd5ce83aa23','logo.png','0db06e25dc7fd2ad5d2493c5ac22f5c3.png','tenant/298190799/20210523/0db06e25dc7fd2ad5d2493c5ac22f5c3.png','png',0,'',298190799),(3,1,98065,1621772174,1,'48f63f80-b9af-4262-7f1f-6303c0f20fac','营业执照.jpg','0de85ec911172a50718ec8208301c085.jpg','tenant/298190799/20210523/0de85ec911172a50718ec8208301c085.jpg','jpg',0,'',298190799),(4,1,126384,1621772224,1,'a8744e84-5a69-470e-43f5-57adc1fd71c6','朕有茶门头.jpg','7384790edc20f68586c83fef77e0b6e7.jpg','tenant/298190799/20210523/7384790edc20f68586c83fef77e0b6e7.jpg','jpg',0,'',298190799),(5,1,119130,1621772239,1,'3dbe0123-17a5-4048-525c-a91e0f001ecc','食品安全.jpg','9789972054eafa6cd30986d4b399c525.jpg','tenant/298190799/20210523/9789972054eafa6cd30986d4b399c525.jpg','jpg',0,'',298190799),(6,1,197516,1621773470,1,'3ca56be9-92d6-4ae6-63b4-81649423a154','百香暴柠果亲王.png','eaa1be9a466fd4d2d691dbff1db3c9e9.png','tenant/298190799/20210523/eaa1be9a466fd4d2d691dbff1db3c9e9.png','png',0,'',298190799),(7,1,202048,1621774389,1,'746da6e6-165a-4023-48bf-1bdbc5c22f1f','黑糖抹茶冰砖.png','277c9dc33c6566e02668303c0944f20f.png','tenant/298190799/20210523/277c9dc33c6566e02668303c0944f20f.png','png',0,'',298190799),(8,1,222992,1621999110,1,'60452a76-0d86-4f10-493e-529eb4b107e2','茶饮奶茶外卖套装美团店招.jpg','8b0673d2f33c6d9362ca5752d0c14730.jpg','tenant/298190799/20210526/8b0673d2f33c6d9362ca5752d0c14730.jpg','jpg',0,'',298190799),(9,1,5749,1621999164,1,'71b0e143-9059-44e5-5735-5e3aa468f858','果饮_juice (1).png','05219b0f2e9358497517f4dba7b6c0b4.png','tenant/298190799/20210526/05219b0f2e9358497517f4dba7b6c0b4.png','png',0,'',298190799),(10,1,8823,1621999169,1,'1cd1a764-3988-4a9f-42f1-4a1c9493e173','骑自行车_riding.png','186e6ac09bbc385dff1369f9f7b3b153.png','tenant/298190799/20210526/186e6ac09bbc385dff1369f9f7b3b153.png','png',0,'',298190799),(11,1,309935,1621999320,1,'b5a5e49e-7906-41aa-579b-1b3e45e21590','banner.png','8f351a1961263bf3e52f74b9132273ca.png','tenant/298190799/20210526/8f351a1961263bf3e52f74b9132273ca.png','png',0,'',298190799),(12,1,138579,1621999362,1,'9fdbc2c8-9546-419b-64f7-95a4ecef0eec','WechatIMG37.jpeg','610bd9022c6166d4caa0f0aaabd26dac.jpeg','default/20210526/610bd9022c6166d4caa0f0aaabd26dac.jpeg','jpeg',0,'',0),(13,1,271991,1622044567,1,'fb7af6ca-2c22-485a-64f7-8a041f4e3c1c','餐饮奶茶中国风新品上市横版海报.jpg','3f39ac675f9b07fa130dddd61873d188.jpg','tenant/298190799/20210526/3f39ac675f9b07fa130dddd61873d188.jpg','jpg',0,'',298190799),(14,1,241159,1622044825,1,'9bd81734-8f8b-45b6-47b6-38852fa7f1e5','餐饮奶茶中国风新品上市横版海报 (1).jpg','40969bb402f365097ef25f16574f7315.jpg','tenant/298190799/20210527/40969bb402f365097ef25f16574f7315.jpg','jpg',0,'',298190799),(15,1,165456,1622082692,1,'cc78e9eb-64a7-45d9-5a9f-88ae3e8dea93','翡翠豆腐茶乳（中杯）.jpg','b9aaaddc4b6e304fdf1747f66244b2f0.jpg','tenant/298190799/20210527/b9aaaddc4b6e304fdf1747f66244b2f0.jpg','jpg',0,'',298190799),(16,1,167710,1622285091,1,'f4622b8e-1a83-46c3-7a00-6f0d0d600978','餐饮奶茶中国风新品上市横版海报.png','c3fb99ebf601f2beb6ced2907c3a6fcf.png','tenant/298190799/20210529/c3fb99ebf601f2beb6ced2907c3a6fcf.png','png',0,'',298190799),(17,1,5182,1622285107,1,'3ec848a6-f067-433e-49ff-3737ab55a07c','未标题-1.png','1717b1562de25e0ee266b0f9b63eb737.png','tenant/298190799/20210529/1717b1562de25e0ee266b0f9b63eb737.png','png',0,'',298190799),(18,1,10145,1622285107,1,'7b3e5919-4e3b-482d-6834-ab4aac964577','未标题-2.png','f09050da77cd7fd0c2c53a2b9805afb6.png','tenant/298190799/20210529/f09050da77cd7fd0c2c53a2b9805afb6.png','png',0,'',298190799),(19,1,10011,1622301789,1,'0fd0a9b7-57ea-4b94-6319-13e518f24f27','2.png','d7f736e6dd0dbfc18bf010ca8d18bbd7.png','tenant/298190799/20210529/d7f736e6dd0dbfc18bf010ca8d18bbd7.png','png',0,'',298190799),(20,1,5133,1622301790,1,'72d0edb2-237d-4cff-6bfa-329143078888','1.png','963c3da9afe11837526f19825cc35aea.png','tenant/298190799/20210529/963c3da9afe11837526f19825cc35aea.png','png',0,'',298190799),(21,1,181488,1622302535,1,'a98b4b0a-1cc3-4137-6d1b-3dda3ac56e38','餐饮奶茶中国风新品上市横版海报 (1).png','9850928fa98573d9ae3fde2b7b319794.png','tenant/298190799/20210529/9850928fa98573d9ae3fde2b7b319794.png','png',0,'',298190799),(22,1,243918,1622351391,1,'f9a9cd79-adf9-4d38-4179-6118fff3b0af','淘宝现金红包使用指南公众号首图.jpg','e7f02017e308b00d49224f6f6282f584.jpg','tenant/298190799/20210530/e7f02017e308b00d49224f6f6282f584.jpg','jpg',0,'',298190799),(23,1,1578552,1622351907,1,'e99c143a-ad3c-4c3a-57f6-91d67c4f4b89','牛年春节活动营销手机海报.jpg','28160fb06bbe2d2e8f1f3a689eae5283.jpg','default/20210530/28160fb06bbe2d2e8f1f3a689eae5283.jpg','jpg',0,'',0),(24,1,199140,1622987862,1,'a7b80024-1e40-4112-5826-9251cb232f09','饮品促销_产品推广_banner横图.jpg','8da3260491a277e2ce9ec68c593a76c7.jpg','tenant/298190799/20210606/8da3260491a277e2ce9ec68c593a76c7.jpg','jpg',0,'',298190799),(25,1,148386,1622987885,1,'bad5a902-6961-4b42-5ce3-ac4732f257f5','e26b9dbc914907a4e33fea4aae3bdpng.jpeg','46cb2c4c7cfc5c938a3035e2063368af.jpeg','tenant/298190799/20210606/46cb2c4c7cfc5c938a3035e2063368af.jpeg','jpeg',0,'',298190799),(26,1,386695,1622993484,1,'ddf86acd-eee2-40ca-5640-f7038d66277b','稿定设计-1.jpg','3a97eaabcff73f7ebeb5cc5df7edf4fd.jpg','default/20210606/3a97eaabcff73f7ebeb5cc5df7edf4fd.jpg','jpg',0,'',0),(27,1,565158,1622993512,1,'e0af38e6-1549-4a0a-50c2-7fb5ab33217a','稿定设计-2.jpg','01d992f85801e1ff9837620b2ffe489b.jpg','default/20210606/01d992f85801e1ff9837620b2ffe489b.jpg','jpg',0,'',0),(28,1,579124,1622993519,1,'c80569ee-7cce-4071-4232-cd05b9a828de','稿定设计-3.jpg','81eca0d18bd1e4287952104c8afa4106.jpg','default/20210606/81eca0d18bd1e4287952104c8afa4106.jpg','jpg',0,'',0),(29,1,544266,1622993526,1,'b6ab820d-796f-48f6-4cf2-3e820accc185','稿定设计-4.jpg','1142bd05419d6dbff2ac5455fa3ce72c.jpg','default/20210606/1142bd05419d6dbff2ac5455fa3ce72c.jpg','jpg',0,'',0),(30,1,2842371,1624804829,1,'fe5ec9d5-2ff1-4919-5f08-4cc73bcdd804','虾仁.jpg','9ea47db685d131db0f0c8d58f77d1dec.jpg','tenant/1661227707/20210627/9ea47db685d131db0f0c8d58f77d1dec.jpg','jpg',0,'',1661227707),(31,1,220157,1625476405,1,'4a9ab105-03d7-4902-5ebd-677579fd1d67','打折促销_福利_简约_公众号首图.jpg','a2af316f23b0874041f596eb1f12cbbd.jpg','tenant/298190799/20210705/a2af316f23b0874041f596eb1f12cbbd.jpg','jpg',0,'',298190799);
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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food`
--

LOCK TABLES `cmf_food` WRITE;
/*!40000 ALTER TABLE `cmf_food` DISABLE KEYS */;
INSERT INTO `cmf_food` VALUES (1,'298190799','','燕麦波波茶乳（中杯）','主要原料：燕麦,珍珠粉圆,锡兰红茶,奶茶',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"无糖\"]}]',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/7a2974d1c7eef1894c8f101f59624png.png','',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1622989316,1622992239,0,0,'','','','',1,0,1),(2,'298190799','','御制烤茶乳（中杯）','主要原料：珍珠粉圆,锡兰红茶,黑糖',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"无糖\",\"多糖\"]}]',0,0.00,0,0.00,10.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/45be866ffe8eb122310c5b797bee2jpeg.jpeg','',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1622987605,1622992239,0,0,'','','','',1,0,1),(3,'298190799','','御制麻薯茶乳（中杯）','主要原料：牛奶,锡兰红茶,芝麻,麻薯风味糊',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"无糖\",\"多糖\"]}]',0,0.00,0,0.00,13.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/9328feb42df74ef43d5bac8e8b4f5png.png','',0,0,'',1622989357,1622992239,0,0,'','','','',1,0,1),(4,'298190799','','奶香豆腐茶乳（中杯）','主要原料：豆腐',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"去冰\",\"少冰\",\"标准冰\",\"多冰\",\"温\",\"热\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"无糖\",\"少糖\",\"半糖\",\"标准糖\",\"多糖\"]}]',0,0.00,0,0.00,14.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/dce2271256b1237ffbabbdc1d62c4jpeg.jpeg','2021052800502200000001318136',0,0,'',1622215348,1622992239,0,0,'','','','',1,10000,1),(5,'298190799','','御制椰果奶茶（中杯）','主要原料：椰果,奶茶',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"无糖\",\"多糖\"]}]',0,0.00,0,0.00,14.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/45be866ffe8eb122310c5b797bee2jpeg.jpeg','2021052800502200000001318047',0,0,'',1622215349,1622992239,0,0,'','','','',1,10000,1),(6,'298190799','','御制红豆茶乳（中杯）','主要原料：红豆,锡兰红茶,奶茶',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"无糖\",\"多糖\"]}]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/bdb90b56551c10db10168cae24d15jpeg.jpeg','2021052800502200000001318138',0,0,'',1622215349,1622992239,0,0,'','','','',1,10000,1),(7,'298190799','','敬献白玉茶乳（中杯）','主要原料：珍珠粉圆,奶茶',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"无糖\",\"多糖\"]}]',0,0.00,0,0.00,9.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/45be866ffe8eb122310c5b797bee2jpeg.jpeg','2021060600502200000002743287',0,0,'',1622987704,1622992239,0,0,'','','','',1,0,1),(8,'298190799','','❤️招牌热销❤️原味麻薯奶茶','主要原料：奶茶',0,1,'[{\"attr_key\":\"甜度\",\"attr_val\":[\"全糖\",\"半糖\",\"无糖\",\"少糖\",\"标准糖\",\"多糖\"]},{\"attr_key\":\"温度\",\"attr_val\":[\"热\",\"常温\",\"多冰\",\"少冰\",\"冰\"]}]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/9328feb42df74ef43d5bac8e8b4f5png.png','2021052800502200000001317922',0,0,'',1622215351,1622992239,0,0,'','','','',1,10000,1),(9,'298190799','','御赐葡萄酪乳（大杯）','主要原料：葡萄,四季春茶,晶冻,奶油芝士,晶球',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/0d50e66eedfb020728cbb2effb895png.png','',0,0,'',1622988522,1622992240,0,0,'','','','',1,0,1),(10,'298190799','','御赐桃桃酪乳（大杯）','主要原料：桃子,乌龙茶,芝士,果冻,晶球',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,19.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/74641060bd0b7af3708e2dc088d00png.png','2021052800502200000001317923',0,0,'',1622215353,1622992240,0,0,'','','','',1,10000,1),(11,'242292395','','鹌鹑蛋生蚝','主要原料：芒果,四季春茶,果冻,奶油芝士,晶球',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,8.80,0.00,-1,-1,0,1,'tenant/298190799/20210528/e92096e24d71dbdef2e86566ed2fcpng.png','2021052800502200000001317924',0,0,'',1626358616,1626358912,0,0.1,'只','','','',1,126,1),(12,'242292395','','酸汤鱿鱼鲜虾贝','主要原料：蜜瓜,芝士,四季春茶,晶球,水晶冻',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"少糖\",\"标准糖\",\"无糖\",\"半糖\"]}]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/def6e68bd68ce7f605b4457fc5d92png.png','2021052800502200000001318141',0,0,'',1626358616,1626358912,0,0.1,'碗','','','',1,125,1),(13,'242292395','','酸汤鱿鱼蚝仔鲜虾贝','主要原料：凤梨,芝士,晶球,水晶冻',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"无糖\",\"多糖\",\"少糖\"]}]',0,0.00,0,0.00,19.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/b93be1d4bde9c8f1a015c0d98a674png.png','2021052800502200000001317925',0,0,'',1626358617,1626358912,0,0.1,'碗','','','',1,124,1),(14,'242292395','','酸汤肥牛鲜虾贝','主要原料：冰砖,黑糖珍珠,抹茶粉,纯牛奶',0,1,'[{\"attr_key\":\"甜度\",\"attr_val\":[\"无糖\",\"半糖\",\"少糖\",\"多糖\",\"标准糖\"]},{\"attr_key\":\"温度\",\"attr_val\":[\"少冰\",\"标准冰\"]}]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/c7453e82a93864642391d6c991693png.png','2021052800502200000001318192',0,0,'',1626358617,1626358912,0,0.1,'碗','','','',1,123,1),(15,'242292395','','酸汤肥牛鱼片','主要原料：冰砖,黑糖珍珠,纯牛奶,可可,阿华田酷脆粉',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\",\"无糖\"]}]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'tenant/298190799/20210528/e5e2224ebadef8a781b7569d060eapng.png','2021052800502200000001318056',0,0,'',1626358912,1626358912,0,0.1,'碗','','','',1,122,1),(16,'242292395','','锡纸金针菇','主要原料：黄豆,黄豆芽,豆芽,海带,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"无糖\",\"多糖\",\"少糖\"]}]',0,0.00,0,0.00,9.90,0.00,-1,-1,0,1,'tenant/1654004179/20210713/51b0ae3ac082bc50a68fd2ec829f2jpg.jpg','2021052800502200000001317926',0,0,'',1626358912,1626358912,0,0.1,'份','','','',1,121,1),(17,'242292395','','锡纸娃娃菜','主要原料：年糕,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"标准冰\",\"少冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,9.90,0.00,-1,-1,0,1,'tenant/1654004179/20210713/a8955fd21834feafe0a0751ba519djpg.jpg','2021052800502200000001317927',0,0,'',1626358912,1626358912,0,0.1,'份','','','',1,120,1),(18,'242292395','','锡纸花甲','主要原料：土豆,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\",\"无糖\"]}]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/47daab0b4e2d2a5026af448b2a45ejpg.jpg','2021052800502200000001318143',0,0,'',1626358912,1626358912,0,0.1,'份','','','',1,119,1),(19,'242292395','','椒盐大虾串','主要原料：魔芋,酸菜,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"去冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"多糖\",\"半糖\",\"少糖\"]}]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/52b3261f3385e03b74d85cec9efd6jpg.jpg','2021052800502200000001318057',0,0,'',1626358913,1626358913,0,0.1,'份','','','',1,118,1),(20,'242292395','','牛肉饼','减脂优选\n主要原料：魔芋,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"多冰\",\"少冰\",\"热\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,9.90,0.00,-1,-1,0,1,'tenant/1654004179/20210713/784451fb5ccca7281345f691df3f0jpg.jpg','2021052800502200000001318145',0,0,'',1626358913,1626358913,0,0.1,'份','','','',1,117,1),(21,'242292395','','紫薯饼','招牌必点\n主要原料：海带,其他',0,1,'[{\"attr_key\":\"甜度\",\"attr_val\":[\"无糖\",\"半糖\",\"少糖\",\"标准糖\",\"多糖\"]},{\"attr_key\":\"温度\",\"attr_val\":[\"少冰\",\"多冰\",\"标准冰\"]}]',0,0.00,0,0.00,9.90,0.00,-1,-1,0,1,'tenant/1654004179/20210713/8559cd4c3001252c5d5ede69ca9e9jpg.jpg','2021052800502200000001318147',0,0,'',1626358913,1626358913,0,0.1,'份','','','',1,116,1),(22,'242292395','','海带丝','主要原料：海带,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/2ef32380dc8920092751ccbe7b235jpg.jpg','2021052800502200000001318148',0,0,'',1626358913,1626358913,1626358933,0,'','','','',1,1,1),(23,'1654004179','','金针菇','主要原料：金针菇,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"多冰\",\"少冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/c46c681b8f15375a344b4e2503882jpg.jpg','2021052800502200000001318149',0,0,'',1626172939,1626172939,0,0,'','','','',1,77,1),(24,'1654004179','','香菇','主要原料：香菇,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"去冰\",\"少冰\",\"标准冰\",\"多冰\",\"温\",\"热\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"无糖\",\"少糖\",\"半糖\",\"标准糖\",\"多糖\"]}]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/25624943471d0a97aaf46a0348d06jpg.jpg','2021052800502200000001318150',0,0,'',1626172940,1626172940,0,0,'','','','',1,76,1),(25,'1654004179','','平菇','主要原料：平菇,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"温\",\"热\",\"去冰\",\"少冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"少糖\",\"半糖\",\"标准糖\",\"无糖\",\"多糖\"]}]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/c9b7a7993bdd31276841a6ba6aa82jpg.jpg','2021052800502200000001318151',0,0,'',1626172941,1626172941,0,0,'','','','',1,75,1),(26,'1654004179','','翡翠莴笋','主要原料：笋,莴笋,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"去冰\",\"少冰\",\"标准冰\",\"多冰\",\"温\",\"热\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"无糖\",\"少糖\",\"半糖\",\"标准糖\",\"多糖\"]}]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/b6f2e4b35c10c602cbf094f9d20bajpg.jpg','2021052800502200000001317931',0,0,'',1626172942,1626172942,0,0,'','','','',1,74,1),(27,'1654004179','','藕滴片','主要原料：其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"去冰\",\"少冰\",\"标准冰\",\"多冰\",\"温\",\"热\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"无糖\",\"少糖\",\"半糖\",\"标准糖\",\"多糖\"]}]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/1a9615270198632618b3858a6128fjpg.jpg','',0,0,'',1626172942,1626172942,0,0,'','','','',1,73,1),(28,'1654004179','','冬笋片','主要原料：笋,海带,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"多冰\",\"少冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\",\"多糖\"]}]',0,0.00,0,0.00,4.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/6e7bb1282ee6a5c0bdba9af72d910jpg.jpg','2021052800502200000001317933',0,0,'',1626172943,1626172943,0,0,'','','','',1,72,1),(29,'1654004179','','四川空运笋尖（7条）','四川经典\n主要原料：笋,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"温\",\"热\",\"多冰\",\"去冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"多糖\",\"少糖\",\"半糖\",\"无糖\"]}]',0,0.00,0,0.00,4.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cd6a1d79368a4f5aa9aaa59c8106fjpg.jpg','2021052800502200000001317934',0,0,'',1626172944,1626172944,0,0,'','','','',1,71,1),(30,'1654004179','','有机花菜','主要原料：花菜,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"多糖\",\"无糖\",\"少糖\",\"半糖\"]}]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/8d03f38479bb21d5544040650f083jpg.jpg','2021052800502200000001318153',0,0,'',1626172944,1626172944,0,0,'','','','',1,70,1),(31,'1654004179','','冬瓜片','主要原料：冬瓜,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"多糖\",\"少糖\",\"半糖\"]}]',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/67400fde2ce9d3c0490ba41422750jpg.jpg','2021052800502200000001318196',0,0,'',1626172945,1626172945,0,0,'','','','',1,69,1),(32,'1654004179','','爆汁油面筋','主要原料：油面筋,面筋,其他,油',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"少冰\",\"温\",\"热\",\"去冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"多糖\",\"少糖\",\"半糖\"]}]',0,0.00,0,0.00,2.50,0.00,-1,-1,0,1,'tenant/1654004179/20210713/600b2e00002aa9ad4d65e687e89dfjpg.jpg','2021052800502200000001318069',0,0,'',1626172945,1626172945,0,0,'','','','',1,68,1),(33,'1654004179','','阳光玉米棒','主要原料：玉米,其他,米',0,1,'[]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/75bcad3e8ed85b54022bbfd8f0822jpg.jpg','2021062400502200000005102544',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172946,1626172946,0,0,'份','','','',1,67,1),(34,'1654004179','','山药','主要原料：山药,香菇,其他',0,1,'[]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/19e6e60f0c8b7056f951431cb4e6ajpg.jpg','2021052800502200000001318198',0,0,'',1626172947,1626172947,0,0,'份','','','',1,66,1),(35,'1654004179','','猪肚条','推荐推荐！！！\n主要原料：猪肚,其他',0,1,'[]',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/39d380faff47c39641d11b094dd7ejpg.jpg','2021052800502200000001317938',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172947,1626172947,0,0,'份','','','',1,65,1),(36,'1654004179','','牛肚','进口牛肚！推荐！\n主要原料：牛肚,其他',0,1,'[]',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/52ecbc6352ed1d1a3ded07ae91282jpg.jpg','2021052800502200000001318199',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172949,1626172949,0,0,'份','','','',1,64,1),(37,'1654004179','','牛百叶','牛百叶\n主要原料：其他',0,1,'[]',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/3ad905da58b8cc44cf7f589e4321fjpg.jpg','2021062400502200000005102254',0,0,'',1626172949,1626172949,0,0.1,'份','','','',1,63,1),(38,'1654004179','','毛肚','主要原料：毛肚,其他',0,1,'[]',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/a69057f3a295bdbe6b59a256ab495jpg.jpg','2021062400502200000005102503',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172950,1626172950,0,0,'份','','','',1,62,1),(39,'1654004179','','鱿鱼','新鲜鱿鱼\n主要原料：鱿鱼,其他,鱼',0,1,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/929d4a74387ab48cdf6d1c6600abbjpeg.jpeg','2021062400502200000005108764',0,0,'',1626172952,1626172952,0,0,'瓶','','','',1,61,1),(40,'1654004179','','巴赫的鹌鹑蛋(6个)','主要原料：鹌鹑,鹌鹑蛋,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"去冰\",\"少冰\",\"标准冰\",\"多冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"无糖\",\"少糖\",\"半糖\",\"标准糖\",\"多糖\"]}]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/17827447d4d941c810883a63f2ab5jpg.jpg','2021052800502200000001317940',0,0,'',1626172952,1626172952,0,0.3,'个','','','',1,60,1),(41,'1654004179','','肉皮','主要原料：猪肉,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"标准冰\",\"多冰\",\"少冰\",\"去冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\"]}]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/e9ed3f7cad7e5981ad8da57c84c98jpg.jpg','2021052800502200000001318159',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172953,1626172953,0,0.3,'份','','','',1,59,1),(42,'1654004179','','鸭肠','主要原料：鸭肠,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"标准冰\",\"少冰\",\"去冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\"]}]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/7159e856e7576975f061aeca07988jpg.jpg','2021052800502200000001318203',0,0,'',1626172954,1626172954,0,0.3,'半只','','','',1,58,1),(43,'1654004179','','蟹肉棒棒哒（3根）','主要原料：蟹肉,其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"多冰\",\"标准冰\",\"少冰\",\"去冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"标准糖\",\"半糖\",\"少糖\"]}]',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/922d6dde8aaf5a612264c8b8fdaafjpg.jpg','2021052800502200000001318330',0,0,'',1626172955,1626172955,0,0.3,'份','','','',1,57,1),(44,'1654004179','','鸭胗','主要原料：其他',0,1,'[{\"attr_key\":\"温度\",\"attr_val\":[\"去冰\",\"少冰\",\"多冰\",\"标准冰\"]},{\"attr_key\":\"甜度\",\"attr_val\":[\"少糖\",\"标准糖\",\"半糖\",\"多糖\"]}]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/06cb84303a19cb431382ea6b92e87jpg.jpg','2021052800502200000001318160',0,0,'',1626172956,1626172956,0,0.3,'份','','','',1,56,1),(45,'1654004179','','考式台肠','台式烤香肠\n主要原料：香肠,其他',0,1,'[]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/61f45a18a208581ca439072e78221jpg.jpg','2021070800502200000006992190',0,0,'',1626172957,1626172957,0,0.3,'份','','','',1,55,1),(46,'1654004179','','水晶包（2个）','水晶包\n主要原料：水,其他',1,1,'[]',0,0.00,0,0.00,2.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/4a8ec497ca7bc76f6496175c50548jpg.jpg','2021070800502200000006991900',0,1,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172958,1626172958,0,0.3,'份','','','',1,54,1),(47,'1654004179','','黄金粥の蛋饺（4个）','猪肉藕片黄金饺子，超级美味！！！强烈推荐！！！\n主要原料：藕,猪肉,其他',1,1,'[]',0,0.00,0,0.00,5.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/37513e385dac2c7360cac26beeb19jpg.jpg','2021070800502200000006992192',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172959,1626172959,0,0.3,'份','','','',1,53,1),(48,'1654004179','','虾糕','鲜香虾干糕\n主要原料：其他,虾',1,1,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/cb77b568f5fecf96ba11212cc32bejpg.jpg','2021070800502200000006992093',0,1,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172959,1626172959,0,0.3,'份','','','',1,52,1),(49,'1654004179','','糯米紫薯球','糯米紫薯球\n主要原料：糯米,紫薯,其他,米',0,0,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/2bfdb1429b81fa0b73662524945a2jpg.jpg','2021070800502200000006992193',0,0,'',1626172960,1626172960,0,0.3,'份','','','',1,51,1),(50,'1654004179','','鱼肉卷','鱼肉卷\n主要原料：其他,鱼,鱼肉',0,0,'[]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/13e26ae6ec7fc9389472d4dd1fae8jpg.jpg','2021070800502200000006992278',0,1,'<p><img src=\"https://cdn.mashangdian.cn/default/20210621/68465c933dac937c79de28508bed29ef.jpg!clipper\" alt=\"\" width=\"1080\" height=\"720\" /></p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172961,1626172961,0,0.3,'份','','','',1,50,1),(51,'1654004179','','潮汕牛肉丸','潮汕牛肉丸\n主要原料：牛肉,牛肉丸,其他,肉丸',0,0,'[]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/6143387dd6dd3165591b6743d7dd9jpg.jpg','2021070800502200000006992094',0,0,'<p><img src=\"https://cdn.mashangdian.cn/default/20210621/acbcc2616236f4bae8a0c0745fd05753.jpg!clipper\" alt=\"\" width=\"1080\" height=\"720\" /></p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172962,1626172962,0,0.3,'份','','','',1,49,1),(52,'1654004179','','香菇贡丸','主要原料：香菇,其他',0,0,'[]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/dd797edcf9ebc95f7cae3340cc72cjpg.jpg','2021070800502200000006992095',0,0,'<p><img src=\"https://cdn.mashangdian.cn/default/20210621/6aca985103a60a68275867f127f6ca6a.jpg!clipper\" alt=\"\" width=\"1080\" height=\"720\" /></p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172963,1626172963,0,0.3,'份','','','',1,48,1),(53,'1654004179','','爆汁鱼丸','主要原料：牛肉,牛肉丸,鱼丸,其他,鱼,肉丸',0,0,'[]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ebc2c34b2c75745b1d240a4682bf7jpg.jpg','2021052800502200000001318334',0,0,'',1626172964,1626172964,0,0.3,'份','','','',1,47,1),(54,'1654004179','','蟹籽丸（3个）','蟹籽球！！！推荐！\n主要原料：其他,虾',0,0,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/2b9b1d98a15ceea76e11ec3db93c4jpg.jpg','2021070800502200000006991904',0,0,'',1626172965,1626172965,0,0.3,'份','','','',1,46,1),(55,'1654004179','','燕饺','主要原料：牛肉,牛肉丸,其他,肉丸',0,0,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/91510d78454a83401fe8c3cb57216jpg.jpg','2021052800502200000001318335',0,0,'',1626172966,1626172966,0,0.3,'份','','','',1,45,1),(56,'1654004179','','鲍鱼片','主要原料：鲍鱼,其他,鱼,肉丸',0,0,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/832174d1620758d8e810d7d7b809cjpeg.jpeg','2021070800502200000006991905',0,0,'',1626172967,1626172967,0,0.3,'份','','','',1,44,1),(57,'1654004179','','墨鱼丸','主要原料：墨鱼,其他,鱼',0,0,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/04c3b863f43a6370367ea53ffbf7djpg.jpg','2021070800502200000006992196',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172968,1626172968,0,0.3,'份','','','',1,43,1),(58,'1654004179','','亲亲肠','亲亲肠！！！\n主要原料：牛肉,牛肉丸,其他,肉丸',0,0,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/93626b62bb5124f31cd2fec4a99bbjpg.jpg','2021070800502200000006991906',0,0,'',1626172969,1626172969,0,0.3,'份','','','',1,42,1),(59,'1654004179','','脆皮鱼豆腐','人气推荐！！！超级好吃！\n主要原料：豆腐,其他',0,0,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/688e9d8c6765d5106ef569f30abfdjpg.jpg','2021070800502200000006992096',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172970,1626172970,0,0.3,'份','','','',1,41,1),(60,'1654004179','','黑鱼片','新鲜黑鱼片！！！强烈强烈推荐！！\n主要原料：其他,鱼,黑鱼',0,0,'[]',0,0.00,0,0.00,7.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/8bf28b174928c1b51539b49a78a22jpeg.jpeg','2021052800502200000001317948',0,0,'',1626172971,1626172971,0,0.3,'份','','','',1,40,1),(61,'1654004179','','黑椒牛柳','新鲜牛柳！！！强烈推荐\n主要原料：牛肉,其他',0,0,'[]',0,0.00,0,0.00,6.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/ca5e223c635b03c9c8426213d836cjpg.jpg','2021052800502200000001318163',0,0,'',1626172971,1626172971,0,0.3,'份','','','',1,39,1),(62,'1654004179','','川香里脊肉','更大块鸡肉，更满足的肉感！\n主要原料：鸡肉,其他',0,1,'[]',0,0.00,0,0.00,4.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/734170af245f67c0e45b7ae585562jpg.jpg','2021052800502200000001318164',0,0,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172972,1626172972,0,0.3,'份','','','',1,38,1),(63,'1654004179','','骨肉相连','骨肉相连！推荐！！！\n主要原料：其他',0,1,'[]',0,0.00,0,0.00,5.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/dad5724585d40f32933b237af39efjpg.jpg','2021070800502200000006991908',0,0,'',1626172973,1626172973,0,0.3,'份','','','',1,37,1),(64,'1654004179','','美好火腿肠','火腿肠好味道！\n主要原料：火腿肠,香肠,火腿,其他',0,1,'[]',0,0.00,0,0.00,3.00,0.00,-1,-1,0,1,'tenant/1654004179/20210713/14e20f0b45d5e2f183b5094c50d6ejpg.jpg','2021070800502200000006991909',0,1,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172973,1626172973,0,0.3,'份','','','',1,36,1),(65,'1654004179','','广式腊肠','正宗四川腊肠！！强烈推荐！！！\n主要原料：腊肠,其他',0,1,'[]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/5add4603b185905e5f61c2df6d474jpg.jpg','2021070800502200000006992097',0,0,'',1626172974,1626172974,0,0.3,'份','','','',1,35,1),(66,'1654004179','','优选午餐肉','火锅专用午餐肉！强烈推荐！！！\n主要原料：午餐肉,其他',1,1,'[]',0,0.00,0,0.00,3.98,0.00,-1,-1,0,1,'tenant/1654004179/20210713/37bde6858ae282516edeafe94e121jpg.jpg','2021070800502200000006991911',0,1,'<p>&nbsp;</p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>',1626172975,1626172975,0,0.3,'份','','','',1,34,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_key`
--

LOCK TABLES `cmf_food_attr_key` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_key` DISABLE KEYS */;
INSERT INTO `cmf_food_attr_key` VALUES (1,'规格'),(2,'规格‘');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_post`
--

LOCK TABLES `cmf_food_attr_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_post` DISABLE KEYS */;
INSERT INTO `cmf_food_attr_post` VALUES (1,46,1),(2,46,2),(3,47,1),(4,47,2),(5,48,1),(6,48,2),(7,66,3),(8,66,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_value`
--

LOCK TABLES `cmf_food_attr_value` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_value` DISABLE KEYS */;
INSERT INTO `cmf_food_attr_value` VALUES (1,1,'小杯'),(2,1,'大杯'),(3,1,'中杯');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category`
--

LOCK TABLES `cmf_food_category` WRITE;
/*!40000 ALTER TABLE `cmf_food_category` DISABLE KEYS */;
INSERT INTO `cmf_food_category` VALUES (1,1,298190799,'朕有茶乳','',0,0,0,1622215345,1622992239,0,1,10000),(1,2,298190799,'朕有酪乳','',0,0,0,1622215346,1622992239,0,1,9999),(1,3,298190799,'朕有冰砖','',0,0,0,1622215346,1622992239,0,1,9998),(1,4,298190799,'朕有甘露','',0,0,0,1622215346,1622992239,0,1,9997),(1,5,298190799,'朕有雪顶','',0,0,0,1622215346,1622992239,0,1,9996),(1,6,298190799,'朕有鲜奶','',0,0,0,1622215346,1622992239,0,1,9995),(1,7,298190799,'朕有欢乐多','',0,0,0,1622215346,1622992239,0,1,9994),(1,8,298190799,'朕有鲜果','',0,0,0,1622215346,1622992239,0,1,9993),(1,9,298190799,'朕有御茶','',0,0,0,1622215346,1622992239,0,1,9992),(1,10,298190799,'朕有小料','',0,0,0,1622215346,1622992239,0,1,9991),(1,11,298190799,'朕有微醺','',0,0,0,1622215346,1622992239,0,1,9990),(1,12,298190799,'优惠福利','',0,0,0,1622259576,1622259576,0,1,10001);
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_post`
--

LOCK TABLES `cmf_food_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_post` DISABLE KEYS */;
INSERT INTO `cmf_food_category_post` VALUES (1,1,1,1622215347,1622215347),(2,2,1,1622215347,1622215347),(3,3,1,1622215348,1622215348),(4,4,1,1622215348,1622215348),(5,5,1,1622215349,1622215349),(6,6,1,1622215350,1622215350),(7,7,1,1622215350,1622215350),(8,8,1,1622215351,1622215351),(9,9,2,1622215352,1622215352),(10,10,2,1622215354,1622215354),(11,11,2,1622215355,1622215355),(12,12,2,1622215357,1622215357),(13,13,2,1622215358,1622215358),(14,14,3,1622215360,1622215360),(15,15,3,1622215361,1622215361),(16,16,3,1622215362,1622215362),(17,17,3,1622215364,1622215364),(18,18,3,1622215365,1622215365),(19,19,4,1622215367,1622215367),(20,20,4,1622215368,1622215368),(21,21,4,1622215370,1622215370),(22,22,4,1622215371,1622215371),(23,23,4,1622215373,1622215373),(24,24,5,1622215374,1622215374),(25,25,5,1622215376,1622215376),(26,26,5,1622215377,1622215377),(27,27,5,1622215379,1622215379),(28,28,6,1622215380,1622215380),(29,29,6,1622215382,1622215382),(30,30,6,1622215383,1622215383),(31,31,6,1622215384,1622215384),(32,32,6,1622215386,1622215386),(33,33,6,1622215387,1622215387),(34,34,7,1622215389,1622215389),(35,35,7,1622215390,1622215390),(36,36,7,1622215392,1622215392),(37,37,7,1622215393,1622215393),(38,38,7,1622215395,1622215395),(39,39,8,1622215396,1622215396),(40,40,8,1622215397,1622215397),(41,41,8,1622215399,1622215399),(42,42,8,1622215400,1622215400),(43,43,8,1622215402,1622215402),(44,44,8,1622215403,1622215403),(45,45,8,1622215404,1622215404),(46,46,9,1622215405,1622215405),(47,47,9,1622215406,1622215406),(48,48,9,1622215408,1622215408),(49,49,10,1622215408,1622215408),(50,50,10,1622215409,1622215409),(51,51,10,1622215409,1622215409),(52,52,10,1622215410,1622215410),(53,53,10,1622215411,1622215411),(54,54,10,1622215411,1622215411),(55,55,10,1622215412,1622215412),(56,56,10,1622215412,1622215412),(57,57,10,1622215413,1622215413),(58,58,10,1622215413,1622215413),(59,59,10,1622215414,1622215414),(60,60,10,1622215414,1622215414),(61,61,10,1622215415,1622215415),(62,62,11,1622215415,1622215415),(63,63,11,1622215415,1622215415),(64,64,11,1622215416,1622215416),(65,65,11,1622215416,1622215416),(68,66,12,0,0),(69,46,12,0,0),(70,48,12,0,0);
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
  `appointment_type` tinyint(3) DEFAULT '0' COMMENT '是否预约单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order`
--

LOCK TABLES `cmf_food_order` WRITE;
/*!40000 ALTER TABLE `cmf_food_order` DISABLE KEYS */;
INSERT INTO `cmf_food_order` VALUES (1,298190799,'T20210529297339579','2021052922001496711405079792','','alipay',1,2,1622261664,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'',19.00,19.00,0,'',6,'','17625458589','',0,1622261664,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyMjYxNjY0MzIyXzE0MA==',0.00,0),(2,298190799,'T20210529828180073','2021052922001496711405377648','','alipay',1,2,1622261989,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'',19.00,19.00,0,'',6,'','17625458589','',0,1622261989,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyMjYxOTg4NjY5XzgzNw==',0.00,0),(3,298190799,'T20210529379837304','2021052922001496711405552288','','alipay',1,2,1622273183,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"多冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'',19.00,19.00,0,'',6,'','17625458589','',0,1622273183,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyMjczMTgzMDkwXzExMQ==',0.00,0),(4,298190799,'T202105301858984909','2021053022001496711405601106','','alipay',1,2,1622343312,'[{\"fee\": 20, \"name\": \"御赐葡萄酪乳（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}], \"sku_id\": 0, \"food_id\": 9, \"material\": []}, {\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"多冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'',39.00,39.00,0,'',6,'','17625458589','',0,1622343312,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyMzQzMzExNjczXzY4MQ==',0.00,0),(5,298190799,'T202105301127518419','2021053022001496711406200425','60431','alipay',1,2,1622364429,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,6.20,0,'',12.80,19.00,0,'',6,'','17625458589','',0,1622364429,0,'TRADE_FINISHED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyMzY0NDI4Nzk4XzIyMQ==',12.80,0),(6,298190799,'T202106022083226942','wx02142405992430cf1880f743d2ceea0000','','wxpay',1,2,1622615045,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'',19.00,19.00,0,'',6,'','17625458589','',0,1622615045,0,'TRADE_CLOSED','','',0.00,0),(7,298190799,'T20210602340700913','wx02143323908781cb53efce44483cd20000','','wxpay',1,2,1622615603,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'',19.00,19.00,0,'',6,'','17625458589','',0,1622615603,0,'TRADE_CLOSED','','',0.00,0),(8,298190799,'T20210602427260685','wx02153838793376da24fbe04c55e8c60000','','wxpay',1,2,1622619518,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"多冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'',19.00,19.00,0,'',6,'','17625458589','',0,1622619518,0,'TRADE_CLOSED','','',0.00,0),(9,298190799,'T20210606878006754','2021060622001496711409569004','51411','alipay',1,2,1622960209,'[{\"fee\": 19, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,0.00,0,'测试订单',19.00,19.00,0,'',6,'','17625458589','',0,1622960209,0,'TRADE_REFUND','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyOTYwMjA4NjgxXzQ0NA==',0.00,0),(10,298190799,'T202106061055406800','2021060622001496711410065443','51545','alipay',1,3,1622960342,'[{\"fee\": 18, \"name\": \"❤️招牌热销❤️原味麻薯奶茶\", \"count\": 1, \"tasty\": [{\"attr_key\": \"甜度\", \"attr_value\": \"全糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"常温\"}], \"sku_id\": 0, \"food_id\": 8, \"material\": []}]',0.00,0.00,0.00,0,'打包订单',18.00,18.00,0,'',6,'','17625458589','',0,1622960342,0,'TRADE_REFUND','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyOTYwMzQxODg2Xzc0OQ==',0.00,0),(11,298190799,'T20210606392343393','2021060622001496711410365062','','alipay',1,2,1623033000,'[{\"fee\": 16, \"name\": \"抹香奶绿\", \"count\": 1, \"tasty\": [{\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}], \"sku_id\": 15, \"food_id\": 66, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,0,'',6,'','17625458589','',0,1622988858,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyOTg4ODU3ODI3XzgxMg==',0.00,0),(12,298190799,'T202106061544646860','2021060622001496711409918377','','alipay',1,2,1623033000,'[{\"fee\": 18, \"name\": \"抹香奶绿\", \"count\": 1, \"tasty\": [{\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}], \"sku_id\": 14, \"food_id\": 66, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,0,'',6,'','17625458589','',0,1622988928,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyOTg4OTI3OTQxXzM0MA==',0.00,0),(13,298190799,'T20210606575462388','2021060622001496711409918378','','alipay',1,2,1623033000,'[{\"fee\": 16, \"name\": \"抹香奶绿\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"少糖\"}], \"sku_id\": 15, \"food_id\": 66, \"material\": []}]',0.00,0.00,0.00,0,'',16.00,16.00,0,'',6,'','17625458589','',0,1622988999,0,'TRADE_CLOSED','','MjA4ODUxMjQ0NjU5NjcxNF8xNjIyOTg4OTk4NzI4XzQ3Ng==',0.00,0),(14,298190799,'T202106071211129184','2021060722001466911422039967','','alipay',1,2,1623119400,'[{\"fee\": 18, \"name\": \"抹香奶绿\", \"count\": 1, \"tasty\": [{\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}], \"sku_id\": 14, \"food_id\": 66, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,0,'',12,'','17768227810','',0,1623076637,0,'TRADE_CLOSED','','MjA4ODAxMjYwMDM2NjkxMl8xNjIzMDc2NjM1NDQzXzIxNQ==',0.00,0),(15,298190799,'T20210630455911532','2021063022001470711433059985','44341','alipay',1,3,1625026739,'[{\"fee\": 18, \"name\": \"黑糖抹茶冰砖（中杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"甜度\", \"attr_value\": \"少糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}], \"sku_id\": 0, \"food_id\": 14, \"material\": []}, {\"fee\": 3, \"name\": \"燕麦爆珠\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 53, \"material\": []}, {\"fee\": 3, \"name\": \"黑芝麻麻薯\", \"count\": 1, \"tasty\": [], \"sku_id\": 0, \"food_id\": 60, \"material\": []}]',0.00,0.00,0.00,0,'',24.00,24.00,0,'',16,'','18688879566','',0,1625026739,1625069940,'TRADE_FINISHED','','MjA4ODQwMjkwOTY3MDcxM18xNjI1MDI2NzM5MDg0XzAzOA==',24.00,0),(16,298190799,'T202107111796885678','2021071122001484651432993154','37802','alipay',1,2,1626057000,'[{\"fee\": 15, \"name\": \"芒芒俸鲜奶（中杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}], \"sku_id\": 0, \"food_id\": 31, \"material\": []}]',0.00,0.00,5.00,0,'',10.00,15.00,0,'',18,'','18818279706','',0,1626010484,1626100201,'TRADE_FINISHED','','MjA4ODMxMjI4NTU4NDY1N18xNjI2MDEwNDgxODI2XzIyMA==',10.00,1),(17,298190799,'T202107181250681169','wx1818164445488000d9f59e2d96d7060000','65806','wxpay',1,2,1626603404,'[{\"fee\": 14, \"name\": \"奶香豆腐茶乳（中杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"无糖\"}], \"sku_id\": 0, \"food_id\": 4, \"material\": []}, {\"fee\": 17, \"name\": \"百香暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"少糖\"}], \"sku_id\": 0, \"food_id\": 39, \"material\": []}]',0.00,0.00,5.00,0,'',26.00,31.00,0,'',20,'','18818205870','',0,1626603404,1626646605,'TRADE_FINISHED','','',26.00,0),(18,298190799,'T20210718700556753','wx182039398070241d5d093ccc0b92c40000','74382','wxpay',1,2,1626611979,'[{\"fee\": 12, \"name\": \"燕麦波波茶乳（中杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 1, \"material\": []}]',0.00,0.00,5.00,0,'',7.00,12.00,0,'',21,'','15115057186','',0,1626611979,1626655180,'TRADE_FINISHED','','',7.00,0),(19,298190799,'T202107182029485681','wx1820401073784999c53ec803407ce10000','74414','wxpay',1,2,1626612010,'[{\"fee\": 19, \"name\": \"御赐凤梨酪乳（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 13, \"material\": []}]',0.00,0.00,5.00,0,'',14.00,19.00,0,'',22,'','13026160084','',0,1626612010,1626655211,'TRADE_FINISHED','','',14.00,0),(20,298190799,'T202107201056972996','wx201811516731790ee7f2f52c8da5f90000','65513','wxpay',1,2,1626775911,'[{\"fee\": 19, \"name\": \"阿华田燕麦雪顶（中杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}], \"sku_id\": 0, \"food_id\": 25, \"material\": []}]',0.00,0.00,5.00,0,'',14.00,19.00,0,'',23,'','13501991762','',0,1626775911,1626819112,'TRADE_FINISHED','','',14.00,0),(21,298190799,'T20210721810248928','2021072122001492201448889649','1','alipay',1,2,1626861865,'[{\"fee\": 18, \"name\": \"桃桃暴柠果亲王（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}], \"sku_id\": 0, \"food_id\": 43, \"material\": []}]',0.00,0.00,7.00,0,'',11.00,18.00,0,'',24,'','15317787783','',0,1626861865,1626905066,'TRADE_FINISHED','','MjA4ODIzMjUyNDQ5MjIwNV8xNjI2ODYxODY0NzQzXzM3OQ==',11.00,0),(22,298190799,'T202107231979676996','2021072322001472881459833545','1','alipay',1,2,1627030345,'[{\"fee\": 18, \"name\": \"御赐葡萄酪乳（大杯）\", \"count\": 1, \"tasty\": [{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}], \"sku_id\": 0, \"food_id\": 9, \"material\": []}]',0.00,0.00,5.00,0,'',13.00,18.00,0,'',26,'','18512155067','',0,1627030345,1627073546,'TRADE_FINISHED','','MjA4ODAyMjQxNjM3Mjg4N18xNjI3MDMwMzQ1MzkwXzAzMQ==',13.00,0),(23,298190799,'T20210911797455960','wx11123325420541767e6dd89e189a0b0000','','wxpay',1,3,1631334805,'[{\"fee\": 18, \"name\": \"❤️招牌热销❤️原味麻薯奶茶\", \"count\": 1, \"tasty\": [{\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"常温\"}], \"sku_id\": 0, \"food_id\": 8, \"material\": []}]',0.00,0.00,0.00,0,'',18.00,18.00,0,'',37,'','13432753683','',0,1631334805,0,'TRADE_CLOSED','','',0.00,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_detail`
--

LOCK TABLES `cmf_food_order_detail` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_detail` DISABLE KEYS */;
INSERT INTO `cmf_food_order_detail` VALUES (1,'bxgnm3','T20210529297339579',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(2,'bxgnm3','T20210529828180073',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[]','','','',19.00,19.00,0.00),(3,'bxgnm3','T20210529379837304',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"多冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(4,'dpptrl','T202105301858984909',9,'tenant/298190799/20210528/0d50e66eedfb020728cbb2effb895png.png','2021052900502200000001395470','御赐葡萄酪乳（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}]','','','',20.00,20.00,0.00),(5,'bxgnm3','T202105301858984909',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"多冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(6,'bxgnm3','T202105301127518419',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(7,'bxgnm3','T202106022083226942',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(8,'bxgnm3','T20210602340700913',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(9,'bxgnm3','T20210602427260685',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"多冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}]','','','',19.00,19.00,0.00),(10,'bxgnm3','T20210606878006754',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','2021052900502200000001395885','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(11,'8','T202106061055406800',8,'tenant/298190799/20210528/9328feb42df74ef43d5bac8e8b4f5png.png','2021052800502200000001317922','❤️招牌热销❤️原味麻薯奶茶',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"甜度\", \"attr_value\": \"全糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"常温\"}]','','','',18.00,18.00,0.00),(12,'mcnl1','T20210606392343393',66,'tenant/298190799/20210606/46cb2c4c7cfc5c938a3035e2063368af.jpeg','','抹香奶绿',15,'中杯标准糖|少冰','',0,0.00,1,'{}','[{\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}]','','','',16.00,16.00,0.00),(13,'mcnl2','T202106061544646860',66,'tenant/298190799/20210606/46cb2c4c7cfc5c938a3035e2063368af.jpeg','','抹香奶绿',14,'大杯标准糖|去冰','',0,0.00,1,'{}','[{\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}]','','','',18.00,18.00,0.00),(14,'mcnl1','T20210606575462388',66,'tenant/298190799/20210606/46cb2c4c7cfc5c938a3035e2063368af.jpeg','','抹香奶绿',15,'中杯少冰|少糖','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"少糖\"}]','','','',16.00,16.00,0.00),(15,'mcnl2','T202106071211129184',66,'tenant/298190799/20210606/46cb2c4c7cfc5c938a3035e2063368af.jpeg','','抹香奶绿',14,'大杯半糖|少冰','',0,0.00,1,'{}','[{\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}]','','','',18.00,18.00,0.00),(16,'14','T20210630455911532',14,'tenant/298190799/20210528/c7453e82a93864642391d6c991693png.png','2021052800502200000001318192','黑糖抹茶冰砖（中杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"甜度\", \"attr_value\": \"少糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}]','','','',18.00,18.00,0.00),(17,'53','T20210630455911532',53,'tenant/298190799/20210528/c78683b00ee82fcced3bca7ea0986jpeg.jpeg','2021052800502200000001318334','燕麦爆珠',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(18,'60','T20210630455911532',60,'tenant/298190799/20210528/5e47728b36b7aebcc10d2314c9e27jpeg.jpeg','2021052800502200000001317948','黑芝麻麻薯',0,'','',0,0.00,1,'{}','[]','','','',3.00,3.00,0.00),(19,'31','T202107111796885678',31,'tenant/298190799/20210528/e67d364dc7d102999feb9709bcb92png.png','2021052800502200000001318196','芒芒俸鲜奶（中杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}]','','','',15.00,15.00,0.00),(20,'4','T202107181250681169',4,'tenant/298190799/20210528/dce2271256b1237ffbabbdc1d62c4jpeg.jpeg','2021052800502200000001318136','奶香豆腐茶乳（中杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"无糖\"}]','','','',14.00,14.00,0.00),(21,'39','T202107181250681169',39,'tenant/298190799/20210528/8500fb4788170ecabb1190e796eb7png.png','','百香暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"少糖\"}]','','','',17.00,17.00,0.00),(22,'1','T20210718700556753',1,'tenant/298190799/20210528/7a2974d1c7eef1894c8f101f59624png.png','','燕麦波波茶乳（中杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',12.00,12.00,0.00),(23,'13','T202107182029485681',13,'tenant/298190799/20210528/b93be1d4bde9c8f1a015c0d98a674png.png','2021052800502200000001317925','御赐凤梨酪乳（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',19.00,19.00,0.00),(24,'25','T202107201056972996',25,'tenant/298190799/20210528/bc298e262c81920c4c50f49214680png.png','2021052800502200000001318151','阿华田燕麦雪顶（中杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"去冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}]','','','',19.00,19.00,0.00),(25,'43','T20210721810248928',43,'tenant/298190799/20210528/6f7faa7078bb557588f0c6445dc68png.png','2021052800502200000001318330','桃桃暴柠果亲王（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"少冰\"}]','','','',18.00,18.00,0.00),(26,'9','T202107231979676996',9,'tenant/298190799/20210528/0d50e66eedfb020728cbb2effb895png.png','','御赐葡萄酪乳（大杯）',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"温度\", \"attr_value\": \"标准冰\"}, {\"attr_key\": \"甜度\", \"attr_value\": \"标准糖\"}]','','','',18.00,18.00,0.00),(27,'8','T20210911797455960',8,'tenant/298190799/20210528/9328feb42df74ef43d5bac8e8b4f5png.png','2021052800502200000001317922','❤️招牌热销❤️原味麻薯奶茶',0,'','',0,0.00,1,'{}','[{\"attr_key\": \"甜度\", \"attr_value\": \"半糖\"}, {\"attr_key\": \"温度\", \"attr_value\": \"常温\"}]','','','',18.00,18.00,0.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_order_refund`
--

LOCK TABLES `cmf_food_order_refund` WRITE;
/*!40000 ALTER TABLE `cmf_food_order_refund` DISABLE KEYS */;
INSERT INTO `cmf_food_order_refund` VALUES (1,298190799,'T202106061055406800',18.00,'库存不足'),(2,298190799,'T20210606878006754',19.00,'库存不足');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_sku`
--

LOCK TABLES `cmf_food_sku` WRITE;
/*!40000 ALTER TABLE `cmf_food_sku` DISABLE KEYS */;
INSERT INTO `cmf_food_sku` VALUES (1,46,'1','',-1,-1,0,0.00,0.00,8.00,0,'小杯',0),(2,46,'2','',-1,-1,0,0.00,0.00,10.00,0,'大杯',0),(3,47,'3','',-1,-1,0,0.00,0.00,8.00,0,'小杯',0),(4,47,'4','',-1,-1,0,0.00,0.00,10.00,0,'大杯',0),(5,48,'5','',-1,-1,0,0.00,0.00,8.00,0,'小杯',0),(6,48,'6','',-1,-1,0,0.00,0.00,10.00,0,'大杯',0),(14,66,'8','mcnl2',-1,-1,0,0.00,0.00,18.00,0,'大杯',0.3),(15,66,'7','mcnl1',-1,-1,0,0.00,0.00,16.00,0,'中杯',0.2);
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
  `alipay_exp_qr_code_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付宝小程序体验版二维码',
  `wechat_exp_qr_code_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信小程序体验版二维码',
  `wechat_qr_code_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信小程序正式版二维码',
  `encrypt_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序接口加密内容',
  `sub_mchid` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '微信支付绑定商户号',
  `create_at` bigint(20) DEFAULT '0' COMMENT '创建时间',
  `update_at` bigint(20) DEFAULT '0' COMMENT '更新时间',
  `list_order` double DEFAULT '10000' COMMENT '排序',
  `delete_at` bigint(20) DEFAULT '0' COMMENT '删除时间',
  `style` json DEFAULT NULL COMMENT '主题文件用户公共样式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme`
--

LOCK TABLES `cmf_mp_theme` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme` VALUES (1,298190799,0,'朕有茶','',1,1442096236,'tenant/298190799/20210523/0db06e25dc7fd2ad5d2493c5ac22f5c3.png','','https://mobilecodec.alipay.com/show.htm?code=s4x11539r6gelpcyln7iref','tenant/298190799/wechat-exp.jpg','tenant/298190799/wechat-qrcode.jpg','8gGx4IFo9EjRuo1p/qgcqA==','1609876793',1621681673,0,10000,0,'{\"color\": \"#ffffff\", \"borderColor\": \"#f5222d\", \"primaryColor\": \"#f5222d\"}');
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
  `style` text COLLATE utf8mb4_general_ci COMMENT '主题文件用户公共样式',
  `config_style` text COLLATE utf8mb4_general_ci COMMENT '主题文件默认公共样式',
  `more` text COLLATE utf8mb4_general_ci COMMENT '主题文件用户配置文件',
  `config_more` text COLLATE utf8mb4_general_ci COMMENT '主题文件默认配置文件',
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
INSERT INTO `cmf_mp_theme_page` VALUES (1,1,298190799,1,'首页','home','','','[{\"type\":\"swiper\",\"data\":[{\"name\":\"\",\"image\":\"https://cdn.mashangdian.cn/tenant/298190799/20210529/9850928fa98573d9ae3fde2b7b319794.png!clipper\",\"file_path\":\"tenant/298190799/20210529/9850928fa98573d9ae3fde2b7b319794.png\",\"link\":\"\"}],\"config\":{\"autoHeight\":true},\"style\":{\"autoHeight\":true}},{\"type\":\"container\",\"child\":[{\"type\":\"grid\",\"data\":[{\"image\":\"https://cdn.mashangdian.cn/tenant/298190799/20210529/963c3da9afe11837526f19825cc35aea.png!clipper\",\"title\":\"门店自取\",\"desc\":\"下单免排队\",\"id\":20,\"file_path\":\"tenant/298190799/20210529/963c3da9afe11837526f19825cc35aea.png\",\"action\":{\"type\":\"func\",\"index\":0,\"name\":\"堂食就餐\",\"url\":\"pages/store/index?scene=eatin\",\"method\":\"switchTab\"}},{\"image\":\"https://cdn.mashangdian.cn/tenant/298190799/20210529/d7f736e6dd0dbfc18bf010ca8d18bbd7.png!clipper\",\"title\":\"外卖送餐\",\"desc\":\"安心外送，超快送达\",\"id\":19,\"file_path\":\"tenant/298190799/20210529/d7f736e6dd0dbfc18bf010ca8d18bbd7.png\",\"action\":{\"type\":\"func\",\"index\":2,\"name\":\"外卖送餐\",\"url\":\"pages/store/index?scene=takeout\",\"method\":\"switchTab\"}}],\"config\":{\"theme\":\"row\",\"divider\":true,\"number\":\"2\",\"iconSize\":60},\"style\":{\"theme\":\"third\",\"len\":3,\"borderRadius\":10,\"paddingTop\":0,\"marginTop\":0,\"marginBottom\":0}},{\"type\":\"picture\",\"data\":[{\"name\":\"\",\"image\":\"https://cdn.mashangdian.cn/tenant/298190799/20210705/a2af316f23b0874041f596eb1f12cbbd.jpg!clipper\",\"file_path\":\"tenant/298190799/20210705/a2af316f23b0874041f596eb1f12cbbd.jpg\",\"link\":\"\",\"action\":{\"type\":\"func\",\"index\":4,\"name\":\"领券中心\",\"url\":\"pages/coupon/coupon\",\"method\":\"miniProgram\",\"extra\":{\"app_id\":\"wx654ce96a7324e76f\",\"path\":\"pages/hall?hall_code=_pkS1H6yOOq6QrraNRIp8Q&t=S2ZGjRDWhcNNFcJ_Ut6pCf9TrO8JGrGop2iZvUvmWcs\"}}}],\"config\":{},\"style\":{\"borderRadius\":5,\"marginTop\":10}},{\"type\":\"userinfo\",\"data\":[{\"image\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\",\"title\":\"我的余额\",\"number\":0,\"field\":\"balance\",\"desc\":\"充值立享超多优惠！\",\"action\":{\"type\":\"func\",\"index\":7,\"name\":\"余额储值\",\"url\":\"pages/mine/money/index\",\"method\":\"\"}}],\"config\":{},\"style\":{\"paddingTop\":20,\"marginTop\":10,\"paddingBottom\":20,\"borderRadius\":10,\"paddingLeft\":20,\"paddingRight\":20,\"marginBottom\":0,\"marginLeft\":0,\"marginRight\":0}},{\"type\":\"title\",\"data\":{\"title\":\"自定义标题\",\"value\":\"商家新鲜事\"},\"config\":{},\"style\":{\"paddingTop\":20,\"paddingBottom\":10,\"paddingLeft\":0,\"marginTop\":0,\"backgroundColor\":\"rgba(255, 255, 255, 0)\",\"backgroundColorRgb\":{\"r\":255,\"g\":255,\"b\":255,\"a\":0},\"fontSize\":18}},{\"type\":\"list\",\"data\":[],\"config\":{\"source\":{\"categoryId\":1,\"api\":\"portal/list\"}},\"style\":{\"paddingTop\":0,\"borderRadius\":10}}],\"config\":{},\"style\":{\"position\":\"relative\",\"top\":-15,\"paddingTop\":0,\"paddingLeft\":10,\"paddingRight\":10}}]','[{\"type\":\"swiper\",\"data\":[{\"name\":\"\",\"image\":\"http://cdn.mashangdian.cn/tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png!clipper\",\"file_path\":\"tenant/2100695345/20210309/8a66a4b6c14e541bf1960548143bc23c.png\",\"link\":\"\"}],\"config\":{\"autoHeight\":true},\"style\":{\"autoHeight\":true}},{\"type\":\"container\",\"child\":[{\"type\":\"grid\",\"data\":[{\"image\":\"http://cdn.mashangdian.cn/tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png!clipper\",\"title\":\"外卖送餐\",\"desc\":\"安心外送，超快送达\",\"id\":4,\"file_path\":\"tenant/2100695345/20210309/198e42f56bb34a73182003be0f5ef9ab.png\",\"action\":{\"type\":\"func\",\"index\":1,\"name\":\"外卖送餐\",\"url\":\"pages/store/index?scene=takeout\",\"method\":\"switchTab\"}},{\"image\":\"http://cdn.mashangdian.cn/tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png!clipper\",\"title\":\"到店取餐\",\"desc\":\"下单免排队\",\"id\":5,\"file_path\":\"tenant/2100695345/20210309/5bf3418e27073196d8bd715873899c3f.png\",\"action\":{\"type\":\"func\",\"index\":0,\"name\":\"到店取餐\",\"url\":\"pages/store/index?scene=pack\",\"method\":\"switchTab\"}},{\"image\":\"http://cdn.mashangdian.cn/tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png!clipper\",\"title\":\"扫码点餐\",\"desc\":\"美味即享\",\"id\":6,\"file_path\":\"tenant/2100695345/20210309/fc9ccb2a23cafc5030a898d2e2814d4a.png\",\"action\":{\"type\":\"func\",\"index\":2,\"name\":\"扫码点餐\",\"url\":\"func/scan\",\"method\":\"func/scan\"}}],\"config\":{\"theme\":\"third\"},\"style\":{\"theme\":\"third\",\"len\":3,\"borderRadius\":6}},{\"type\":\"userinfo\",\"data\":[{\"image\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\",\"title\":\"我的余额\",\"number\":0,\"field\":\"balance\",\"desc\":\"充值立享超多优惠！\",\"action\":{\"type\":\"func\",\"index\":7,\"name\":\"余额储值\",\"url\":\"pages/mine/money/index\",\"method\":\"\"}}],\"config\":{},\"style\":{\"paddingTop\":10,\"marginTop\":10,\"paddingBottom\":10}},{\"type\":\"title\",\"data\":{\"title\":\"自定义标题\",\"value\":\"商家新鲜事\"},\"config\":{},\"style\":{\"paddingTop\":0,\"paddingBottom\":10,\"paddingLeft\":10,\"marginTop\":10,\"backgroundColor\":\"rgba(255, 255, 255, 0)\",\"backgroundColorRgb\":{\"r\":255,\"g\":255,\"b\":255,\"a\":0},\"fontSize\":14}},{\"type\":\"list\",\"data\":[],\"config\":{},\"style\":{}}],\"config\":{},\"style\":{\"position\":\"relative\",\"top\":-15,\"paddingTop\":0,\"paddingLeft\":10,\"paddingRight\":10}}]',1621681673,1621681673);
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_version`
--

LOCK TABLES `cmf_mp_theme_version` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_version` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_version` VALUES (1,298190799,'0.0.1','2021001192675085','0.0.31',0,'online','','alipay',1621681933,1621848797),(2,298190799,'0.0.1','16','0.0.8',0,'wait','','wechat',1621692269,0),(3,298190799,'0.0.2','2021001192675085','0.0.32',0,'online','','alipay',1621909332,1621911981),(4,298190799,'0.0.2','17','0.0.9',0,'online','','wechat',1621999044,1622005359),(5,298190799,'0.0.3','2021001192675085','0.0.33',0,'wait','','alipay',1621999880,0),(6,298190799,'0.0.3','2021001192675085','0.0.33',0,'online','','alipay',1621999880,1622005360),(7,298190799,'0.0.3','18','0.1.0',0,'online','','wechat',1622021188,1622026383),(8,215329371,'0.0.4','2021001192675085','0.0.34',0,'online','','alipay',1622080527,1625381561),(9,215329371,'0.0.4','28','0.1.9',1,'wait','','wechat',1625214347,0),(10,298190799,'0.0.4','19','0.1.1',0,'online','','wechat',1622115763,1622161360),(11,298190799,'0.0.5','20','0.1.2',0,'wait','','wechat',1622340011,0),(12,298190799,'0.0.6','21','0.1.2',0,'wait','','wechat',1622342436,1622342956),(13,298190799,'0.0.7','22','0.1.3',0,'online','','wechat',1622342959,1622506752),(14,298190799,'0.0.5','2021001192675085','0.0.35',0,'wait','','alipay',1622345690,0),(15,298190799,'0.0.5','2021001192675085','0.0.35',0,'online','','alipay',1622345690,1622358816),(16,298190799,'0.0.8','23','0.1.4',0,'online','','wechat',1622628583,1622679199),(17,298190799,'0.0.6','2021001192675085','0.0.37',0,'wait','','alipay',1622777829,0),(18,298190799,'0.0.6','2021001192675085','0.0.37',0,'online','','alipay',1622777829,1622795793),(19,298190799,'0.0.9','24','0.1.5',0,'online','','wechat',1622955570,1622978988),(20,298190799,'0.0.7','2021001192675085','0.0.38',0,'wait','','alipay',1622955600,0),(21,298190799,'0.0.7','2021001192675085','0.0.38',0,'online','','alipay',1622955600,1622978986),(22,298190799,'0.0.10','25','0.1.6',0,'online','','wechat',1623038165,0),(23,298190799,'0.0.8','2021001192675085','0.0.39',0,'online','','alipay',1623050804,1623118953),(25,298190799,'0.0.9','2021001192675085','0.0.40',0,'wait','','alipay',1623119456,0),(26,298190799,'0.0.9','2021001192675085','0.0.40',0,'online','','alipay',1623119456,1623200244),(27,298190799,'0.0.11','26','0.1.7',0,'online','','wechat',1624668750,0),(28,298190799,'0.0.10','2021001192675085','0.0.41',0,'wait','','alipay',1624668756,0),(29,298190799,'0.0.10','2021001192675085','0.0.41',0,'online','','alipay',1624668756,1624803794),(30,298190799,'0.0.12','27','0.1.8',0,'online','','wechat',1624803796,1624803806),(31,298190799,'0.0.13','28','0.1.9',0,'online','','wechat',1625214304,0),(32,298190799,'0.0.11','2021001192675085','0.0.44',0,'wait','','alipay',1625380980,0),(33,298190799,'0.0.11','2021001192675085','0.0.44',0,'online','','alipay',1625380980,1625381534),(34,298190799,'0.0.14','29','0.2.0',0,'online','','wechat',1625381345,1625381533),(35,298190799,'0.0.15','30','0.2.1',0,'online','','wechat',1626882492,1626922554),(36,298190799,'0.0.12','2021001192675085','0.0.45',0,'wait','','alipay',1626922559,0),(37,298190799,'0.0.12','2021001192675085','0.0.45',1,'wait','','alipay',1626922559,0);
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
INSERT INTO `cmf_option` VALUES (1,1,'business_info','{\"email\": \"17887909742@139.com\", \"mobile\": \"17887909742\", \"address\": \"\", \"company\": \"\", \"contact\": \"周凤\", \"app_desc\": \"专注于国潮风茶饮为主的奶茶，让更多国人感受、欣赏、传承国潮文化的魅力。\", \"app_slogan\": \"专注于国潮风茶饮为主的奶茶\", \"brand_logo\": \"tenant/298190799/20210523/0db06e25dc7fd2ad5d2493c5ac22f5c3.png\", \"brand_name\": \"朕有茶\", \"out_door_pic\": \"tenant/298190799/20210523/7384790edc20f68586c83fef77e0b6e7.jpg\", \"alipay_logo_id\": \"A*RCuQQ7RVWJAAAAAAAAAAAAAADsN1AQ\", \"business_photo\": \"tenant/298190799/20210523/0de85ec911172a50718ec8208301c085.jpg\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"\", \"food_license_pic\": \"tenant/298190799/20210523/9789972054eafa6cd30986d4b399c525.jpg\", \"mini_category_ids\": \"XS1009_XS2074_XS3113\"}',298190799,0),(2,1,'eatin','{\"day\": 1, \"status\": 1, \"eat_type\": 1, \"pay_type\": 0, \"sale_type\": 0, \"surcharge\": 0, \"order_type\": 0, \"sell_clear\": \"\", \"custom_name\": \"\", \"custom_enabled\": 0, \"surcharge_type\": 0, \"enabled_sell_clear\": 0, \"enabled_appointment\": 1}',298190799,1),(4,1,'subscribe','{\"pay_tmp_id\": \"lTzu2WR95UjjB_dU8bO6XbphS9J4gsTSISSuKmkXuXI\", \"refund_tmp_id\": \"Za7SAllqM27C2IBJVSlpOdhrXc4fSTFQs-MkfUHNJGw\", \"finished_tmp_id\": \"xfnIm8SRKJfHZGy0p9MNz3IRCocgSXFYLH1kPW8QuBU\"}',298190799,0),(5,1,'takeout','{\"day\": 1, \"status\": 1, \"step_km\": 1, \"start_km\": 3, \"step_fee\": 1, \"min_price\": 25, \"start_fee\": 5, \"sell_clear\": \"\", \"first_class\": \"甜品饮料\", \"second_class\": \"奶茶果汁\", \"automatic_order\": 1, \"stop_before_min\": 30, \"delivery_distance\": 3, \"enabled_sell_clear\": 0, \"immediate_delivery\": 1, \"enabled_appointment\": 1}',298190799,1),(6,1,'wechat_cfav','{\"path\": \"pages/hall?hall_code=_pkS1H6yOOq6QrraNRIp8Q&t=S2ZGjRDWhcNNFcJ_Ut6pCf9TrO8JGrGop2iZvUvmWcs\", \"app_id\": \"wx654ce96a7324e76f\"}',298190799,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_pay_log`
--

LOCK TABLES `cmf_pay_log` WRITE;
/*!40000 ALTER TABLE `cmf_pay_log` DISABLE KEYS */;
INSERT INTO `cmf_pay_log` VALUES (1,'T202105301127518419','2021053022001496711406200425','alipay','2021002145653533',6,'2088512446596714',19.00,12.80,12.80,12.80,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"amount\":\"6.20\",\"merchantContribute\":\"6.20\",\"name\":\"12.80元特价券\",\"otherContribute\":\"0.00\",\"type\":\"ALIPAY_COMMON_ITEM_VOUCHER\",\"voucherId\":\"2021052900073002719608IY8M1X\"}]','[{\"amount\": \"12.80\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"6.20\", \"fundChannel\": \"MDISCOUNT\"}]',1622364436,0,0,'TRADE_SUCCESS'),(2,'T20210606878006754','2021060622001496711409569004','alipay','2021002145653533',6,'2088512446596714',19.00,19.00,19.00,19.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','','[{\"amount\": \"19.00\", \"fundChannel\": \"PCREDIT\"}]',1622960215,0,0,'TRADE_REFUND'),(3,'T202106061055406800','2021060622001496711410065443','alipay','2021002145653533',6,'2088512446596714',18.00,18.00,18.00,18.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','','[{\"amount\": \"18.00\", \"fundChannel\": \"PCREDIT\"}]',1622960347,0,0,'TRADE_REFUND'),(4,'T20210630455911532','2021063022001470711433059985','alipay','2021002145653533',16,'2088402909670713',24.00,24.00,24.00,24.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','','[{\"amount\": \"24.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}]',1625026745,0,0,'TRADE_SUCCESS'),(5,'T202107111796885678','2021071122001484651432993154','alipay','2021002145653533',18,'2088312285584657',15.00,10.00,10.00,10.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"5.00\",\"name\":\"5.00元代金券\",\"otherContribute\":\"0.00\",\"type\":\"ALIPAY_BIZ_VOUCHER\",\"voucherId\":\"2021071100073002658408315B5D\"}]','[{\"amount\": \"10.00\", \"fundChannel\": \"PCREDIT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"MDISCOUNT\"}]',1626010491,0,0,'TRADE_SUCCESS'),(6,'T202107181250681169','4200001225202107189715653646','wxpay','wx2a399074c8699036',20,'oernD4jN2ZuFR_pBccpX5LNXGIYM',31.00,31.00,0.00,26.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"coupon_id\":\"25427914375\",\"name\":\"全场满10—5\",\"scope\":\"GLOBAL\",\"type\":\"NOCASH\",\"amount\":500,\"stock_id\":\"15713130\",\"merchant_contribute\":500,\"currency\":\"CNY\"}]','{}',1626603412,0,0,'TRADE_SUCCESS'),(7,'T20210718700556753','4200001236202107180286436469','wxpay','wx2a399074c8699036',21,'oernD4jCiiV8Eysth7bF_t-M6iv8',12.00,12.00,0.00,7.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"coupon_id\":\"25432444261\",\"name\":\"全场满10—5\",\"scope\":\"GLOBAL\",\"type\":\"NOCASH\",\"amount\":500,\"stock_id\":\"15713130\",\"merchant_contribute\":500,\"currency\":\"CNY\"}]','{}',1626611986,0,0,'TRADE_SUCCESS'),(8,'T202107182029485681','4200001134202107183412408471','wxpay','wx2a399074c8699036',22,'oernD4hpGIHKX1E77QOSNyM2stw4',19.00,19.00,0.00,14.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"coupon_id\":\"25432150429\",\"name\":\"全场满10—5\",\"scope\":\"GLOBAL\",\"type\":\"NOCASH\",\"amount\":500,\"stock_id\":\"15713130\",\"merchant_contribute\":500,\"currency\":\"CNY\"}]','{}',1626612015,0,0,'TRADE_SUCCESS'),(9,'T202107201056972996','4200001235202107204744168632','wxpay','wx2a399074c8699036',23,'oernD4irF-nRHFKiM_P9yBt_2ELE',19.00,19.00,0.00,14.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"coupon_id\":\"25247936226\",\"name\":\"全场满10—5\",\"scope\":\"GLOBAL\",\"type\":\"NOCASH\",\"amount\":500,\"stock_id\":\"15713130\",\"merchant_contribute\":500,\"currency\":\"CNY\"}]','{}',1626775917,0,0,'TRADE_SUCCESS'),(10,'T20210721810248928','2021072122001492201448889649','alipay','2021002145653533',24,'2088232524492205',18.00,13.00,11.00,11.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"5.00\",\"name\":\"5.00元代金券\",\"otherContribute\":\"0.00\",\"type\":\"ALIPAY_BIZ_VOUCHER\",\"voucherId\":\"2021072100073002209207W6CJ6H\"},{\"amount\":\"2.00\",\"merchantContribute\":\"0.00\",\"name\":\"扫码点餐优惠券\",\"otherContribute\":\"2.00\",\"type\":\"ALIPAY_CASH_VOUCHER\",\"voucherId\":\"2021071900073002209207VOY4JG\"}]','[{\"amount\": \"11.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"2.00\", \"fundChannel\": \"DISCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"MDISCOUNT\"}]',1626861886,0,0,'TRADE_SUCCESS'),(11,'T202107231979676996','2021072322001472881459833545','alipay','2021002145653533',26,'2088022416372887',18.00,13.00,13.00,13.00,0.00,0.00,0.00,'朕有茶','朕有茶点餐','[{\"amount\":\"5.00\",\"merchantContribute\":\"5.00\",\"name\":\"5.00元代金券\",\"otherContribute\":\"0.00\",\"type\":\"ALIPAY_BIZ_VOUCHER\",\"voucherId\":\"2021072300073002887208IO4QSA\"}]','[{\"amount\": \"13.00\", \"fundChannel\": \"ALIPAYACCOUNT\"}, {\"amount\": \"5.00\", \"fundChannel\": \"MDISCOUNT\"}]',1627030350,0,0,'TRADE_SUCCESS');
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
INSERT INTO `cmf_portal_category` VALUES (1,298190799,0,0,1,0,10000,'新鲜事','','','','','','','','','','');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_category_post`
--

LOCK TABLES `cmf_portal_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_category_post` DISABLE KEYS */;
INSERT INTO `cmf_portal_category_post` VALUES (1,1,1,10000,1),(2,2,1,10000,1);
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
INSERT INTO `cmf_portal_post` VALUES (1,298190799,0,1,1,1,1,1,0,0,136,0,0,0,1622993656,1622993656,0,0,'朕有茶线上点餐开通了','','','','tenant/298190799/20210526/8f351a1961263bf3e52f74b9132273ca.png','<p><img src=\"https://cdn.mashangdian.cn/default/20210606/3a97eaabcff73f7ebeb5cc5df7edf4fd.jpg!clipper\" alt=\"\" width=\"1000\" height=\"1627\" /><img src=\"https://cdn.mashangdian.cn/default/20210606/01d992f85801e1ff9837620b2ffe489b.jpg!clipper\" alt=\"\" width=\"1000\" height=\"1627\" /><img src=\"https://cdn.mashangdian.cn/default/20210606/81eca0d18bd1e4287952104c8afa4106.jpg!clipper\" alt=\"\" width=\"1000\" height=\"1627\" /><img style=\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\" src=\"https://cdn.mashangdian.cn/default/20210606/1142bd05419d6dbff2ac5455fa3ce72c.jpg!clipper\" alt=\"\" width=\"1000\" height=\"1627\" /></p>','','{\"audio\": \"\", \"files\": [], \"other\": null, \"video\": \"\", \"photos\": [], \"extends\": {}, \"template\": \"\"}'),(2,298190799,0,1,1,1,1,1,0,0,108,0,0,0,1622351911,1622351911,0,0,'支付宝微信卡券使用须知','支付宝,微信,优惠券','','','tenant/298190799/20210530/e7f02017e308b00d49224f6f6282f584.jpg','<p><img src=\"https://cdn.mashangdian.cn/default/20210530/28160fb06bbe2d2e8f1f3a689eae5283.jpg!clipper\" alt=\"\" width=\"1242\" height=\"2208\" /></p>\n<p><audio style=\"display: none;\" controls=\"controls\"></audio></p>','','{\"audio\": \"\", \"files\": [], \"other\": null, \"video\": \"\", \"photos\": [], \"extends\": {}, \"template\": \"\"}');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_tag`
--

LOCK TABLES `cmf_portal_tag` WRITE;
/*!40000 ALTER TABLE `cmf_portal_tag` DISABLE KEYS */;
INSERT INTO `cmf_portal_tag` VALUES (1,1,0,0,'支付宝'),(2,1,0,0,'微信'),(3,1,0,0,'优惠券'),(4,1,0,3,''),(5,1,0,3,''),(6,1,0,3,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_tag_post`
--

LOCK TABLES `cmf_portal_tag_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_tag_post` DISABLE KEYS */;
INSERT INTO `cmf_portal_tag_post` VALUES (1,0,0,1),(2,0,0,1),(3,0,0,1);
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
  `delete_at` bigint(20) DEFAULT NULL,
  `pattern` tinyint(3) NOT NULL DEFAULT '0' COMMENT '打印模式（0：全部，1：一菜一单）',
  `count` int(11) NOT NULL DEFAULT '1' COMMENT '打印联数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_printer`
--

LOCK TABLES `cmf_printer` WRITE;
/*!40000 ALTER TABLE `cmf_printer` DISABLE KEYS */;
INSERT INTO `cmf_printer` VALUES (1,298190799,1,'飞鹅','cloud','feie','931101447','77hwj522',1622960167,1622960167,0,0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_qrcode_post`
--

LOCK TABLES `cmf_qrcode_post` WRITE;
/*!40000 ALTER TABLE `cmf_qrcode_post` DISABLE KEYS */;
INSERT INTO `cmf_qrcode_post` VALUES (1,298190799,1,'1518666184','桌号',0,'qrcode/20210403/f3ad56d05e476016a46e6b073827191f.png',1622360192,0,0),(2,298190799,1,'1012262937','桌号',0,'qrcode/20210403/d149a6e4bbf984b2bed3b1764c78f1b6.png',1622360664,0,0),(3,298190799,1,'700409379','桌号',0,'qrcode/20210403/cf434cd11b9b6e15e21ff9739935afe1.png',1622363656,0,0),(4,298190799,1,'93699334','桌号',0,'qrcode/20210403/ff796d3d109a66442a290f0aea6cbdaa.png',1622363666,0,0);
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
  `refund_fee` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '剩余可退金额',
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
INSERT INTO `cmf_role` VALUES (298190799,1,0,'超级管理员','拥有网站最高管理员权限！',10000,1621681673,1621681673,1),(298190799,2,0,'收银员','收银员！',1,1621681673,1621681673,1),(298190799,3,0,'财务','财务！',2,1621681673,1621681673,1);
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
INSERT INTO `cmf_store` VALUES (1,'2021052900502000000083400985',298190799,822693526,'2021052300077000000020920810','朕有茶(逸仙路奶茶店)',1,'S08','1757','17887909742','周凤',310000,'上海市',310100,'市辖区',310113,'宝山区','逸仙路1328号40幢 上海市宝山区逸仙路1328号40幢朕有茶','tenant/298190799/20210523/7384790edc20f68586c83fef77e0b6e7.jpg',121.4844170,31.3193950,0,1,'23:30','',1622256520,1622256520,0,'passed','',NULL);
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
INSERT INTO `cmf_store_hours` VALUES (298190799,1,1,1,1,1,1,1,1,'10:00','21:00',0),(298190799,1,0,0,0,0,0,0,0,'00:00','00:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=724 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_part`
--

LOCK TABLES `cmf_third_part` WRITE;
/*!40000 ALTER TABLE `cmf_third_part` DISABLE KEYS */;
INSERT INTO `cmf_third_part` VALUES (1,298190799,'alipay-mp',6,'2088512446596714',''),(2,298190799,'alipay-mp',0,'2088932209186765',''),(3,298190799,'alipay-mp',0,'2088142405693888',''),(4,298190799,'alipay-mp',0,'2088831869964613',''),(5,298190799,'alipay-mp',0,'2088932208961123',''),(6,298190799,'alipay-mp',0,'2088702248885431',''),(7,298190799,'alipay-mp',0,'2088712679463313',''),(8,298190799,'wechat-mp',6,'oernD4gBylF_imm-II9QLUWb9huM','n9HZ4229+9ahJ0KX2L3DQQ=='),(9,298190799,'alipay-mp',0,'2088142406155710',''),(10,298190799,'wechat-mp',0,'oernD4leUVoX6XZWdQlO7qO76ApI','BhzSInrZwcqMWsJUUbJwVg=='),(11,298190799,'wechat-mp',0,'oernD4sSAX5Lmf99MFXpxSRZeMhY','POgubCoEPGu5AY4u9X3itA=='),(12,298190799,'alipay-mp',0,'2088522576254176',''),(13,298190799,'alipay-mp',0,'2088512565166627',''),(14,298190799,'wechat-mp',0,'oernD4j8mC-XZdJ1--sUmyielxzo','nC3A0k0t/BMScjgyC2m0iw=='),(15,298190799,'alipay-mp',4,'2088932470093311',''),(16,2100695345,'alipay-mp',0,'2088022451151698',''),(17,298190799,'wechat-mp',0,'oernD4u7Bm_5xeqSvw7Rs6zEs3n0','+4MhAeNJttn/Sbp3yymd8w=='),(18,298190799,'wechat-mp',1,'oernD4nZ4jbUh4pAJatnzB-2QXYU','7MV/RaGSwr3NxZGohiBbDw=='),(19,298190799,'wechat-mp',9,'oernD4o02MF2OS0DDXho6XqLWROo','GGDcDDf4SrXN4kWhtzcZBA=='),(20,298190799,'wechat-mp',0,'oernD4orpd66dCYhQUOL4xRabqzc','Fny7IHUpqVYxC7zi++DUXA=='),(21,298190799,'wechat-mp',2,'oernD4h2I7xzXKIctLcDYloiL_7s','nY8v3nIC4PgDfvusFdvb5A=='),(22,298190799,'wechat-mp',3,'oernD4gUX_vwIC-b0gVAU7LSdy3Q','pjCjnQR3B0VQGOBaSx+AuA=='),(23,298190799,'wechat-mp',0,'oernD4ojxUsW5GK7upoUnpvU1L0Q','cUCmB+LW1bWbqFNIb+FbXw=='),(24,298190799,'wechat-mp',10,'oernD4jkbt0tpRNMFjvDbAZa-lqk','/HqgaKPDqnm411z3QIDgGA=='),(25,298190799,'wechat-mp',0,'oernD4o9fWLjvLOYek7KpR61d_YM','AmKQAU7pI7aMnXiV+laPbw=='),(26,298190799,'wechat-mp',0,'oernD4rK-_upbBmNs37uOhoZkkwA','BLyGsbzqX2v6iVgf9nkmDw=='),(27,298190799,'wechat-mp',0,'oernD4uZH1APtha35nVy1bhCpF7M','zcdVym4BiZyi+rB/M7ActQ=='),(28,298190799,'wechat-mp',0,'oernD4sxlZ-w3MLMxlkPLkmvdqU4','2KNnF+JpyE8aHNDGQ5YssQ=='),(29,298190799,'wechat-mp',0,'oernD4n4tWKZHUkdnWgZyMiXfRNc','bUBkGIG3BUQFgxu5O6n+Tg=='),(30,298190799,'wechat-mp',17,'oernD4qCPPRXMoidbkeFavVJUyNY','IireCAo0XGFzUFhNKuHA5g=='),(31,298190799,'wechat-mp',0,'oernD4jq2BG_VJbZYEC2jnU7YpfI','/A4T2emgzgJ4v1xgqF9dmg=='),(32,298190799,'wechat-mp',0,'oernD4m1kZA1XrHErzER14erCKAQ','T/9C56AT0HlNhKEprmmt2w=='),(33,298190799,'alipay-mp',0,'2088932071522191',''),(34,298190799,'alipay-mp',0,'2088932207171923',''),(35,298190799,'alipay-mp',0,'2088142406360435',''),(36,298190799,'alipay-mp',0,'2088602066785710',''),(37,298190799,'alipay-mp',0,'2088142407304625',''),(38,298190799,'wechat-mp',0,'oernD4qomnkLcz3ie2mItQovwCak','kI/LY2eEfhra7ymN2zcL4g=='),(39,298190799,'alipay-mp',7,'2088722491122031',''),(40,298190799,'alipay-mp',0,'2088302812376479',''),(41,298190799,'alipay-mp',0,'2088012527748505',''),(42,298190799,'alipay-mp',0,'2088512289844225',''),(43,298190799,'alipay-mp',0,'2088002049936920',''),(44,298190799,'alipay-mp',8,'2088702578496107',''),(45,298190799,'alipay-mp',0,'2088102551416962',''),(46,298190799,'alipay-mp',0,'2088702521118412',''),(47,298190799,'wechat-mp',0,'oernD4su5GpLV7SlEGTAc4j542Ew','UOZEVpBdRRaGyXwRLzitDw=='),(48,298190799,'alipay-mp',0,'2088922437111956',''),(49,298190799,'alipay-mp',0,'2088032456853624',''),(50,298190799,'alipay-mp',0,'2088812744293923',''),(51,298190799,'alipay-mp',0,'2088002338410755',''),(52,298190799,'alipay-mp',0,'2088002131447848',''),(53,298190799,'alipay-mp',0,'2088522289782362',''),(54,298190799,'alipay-mp',0,'2088702746387295',''),(55,298190799,'alipay-mp',0,'2088302102529040',''),(56,298190799,'alipay-mp',0,'2088522540641027',''),(57,298190799,'alipay-mp',0,'2088012871743609',''),(58,298190799,'alipay-mp',0,'2088312690301348',''),(59,298190799,'wechat-mp',0,'oernD4idnv0uipK4q4h6fJujJsoY','+aX3bQK+S4FApgCWzvXNuw=='),(60,298190799,'wechat-mp',0,'oernD4p2NnB4z90wnvw1T87H_fLs','3A3pAmiZKhKDheEnBIeYCA=='),(61,298190799,'wechat-mp',0,'oernD4jidPuEXdJ3pgbBspoX7dSI','JJz+kKhBa/MyEherrFFOog=='),(62,298190799,'wechat-mp',0,'oernD4pg990_Ha_uCbToLqBK7YuI','gyp3IL1PvrLBV1twyvZGvQ=='),(63,298190799,'alipay-mp',0,'2088002031884336',''),(64,298190799,'alipay-mp',0,'2088122091593691',''),(65,298190799,'alipay-mp',0,'2088332485789410',''),(66,298190799,'alipay-mp',0,'2088412968751504',''),(67,298190799,'alipay-mp',0,'2088702141579945',''),(68,298190799,'wechat-mp',0,'oernD4mRxbXWiHfx91uT_Vj5Me10','Z23iPJZnmhqX/CvLgra4OQ=='),(69,298190799,'alipay-mp',0,'2088002180689114',''),(70,298190799,'alipay-mp',0,'2088002038020823',''),(71,298190799,'wechat-mp',0,'oernD4pOJhAQEtPrVXl_xZYWo6_o','2wSOXbDtIZyjUfGHrl127Q=='),(72,298190799,'wechat-mp',0,'oernD4uJMjGLb75o7BIxEY48BmRM','SCSt1AZ3XY5c+A1Ug8kViQ=='),(73,298190799,'alipay-mp',0,'2088042771052507',''),(74,298190799,'alipay-mp',0,'2088522062574324',''),(75,298190799,'alipay-mp',0,'2088022821049730',''),(76,298190799,'alipay-mp',0,'2088512731241095',''),(77,298190799,'alipay-mp',0,'2088802367543338',''),(78,298190799,'alipay-mp',0,'2088202724813559',''),(79,298190799,'alipay-mp',0,'2088902524793667',''),(80,298190799,'alipay-mp',0,'2088302828450592',''),(81,298190799,'alipay-mp',0,'2088922944432575',''),(82,298190799,'alipay-mp',0,'2088002313486771',''),(83,298190799,'alipay-mp',0,'2088902013075632',''),(84,298190799,'alipay-mp',0,'2088802907404262',''),(85,298190799,'alipay-mp',11,'2088212154558496',''),(86,298190799,'alipay-mp',0,'2088142404390834',''),(87,298190799,'alipay-mp',0,'2088202883274303',''),(88,298190799,'alipay-mp',0,'2088202809255717',''),(89,298190799,'alipay-mp',0,'2088702556453762',''),(90,298190799,'alipay-mp',0,'2088122738795224',''),(91,298190799,'alipay-mp',0,'2088602250198540',''),(92,298190799,'alipay-mp',0,'2088432384490162',''),(93,298190799,'alipay-mp',0,'2088532636368976',''),(94,298190799,'wechat-mp',0,'oernD4s3rbWKStff0Q8FfOd3TD4w','MUDZmvlVPvxYD+PVDSqZqw=='),(95,298190799,'alipay-mp',0,'2088622442134918',''),(96,298190799,'alipay-mp',0,'2088912199982684',''),(97,298190799,'alipay-mp',0,'2088042583092320',''),(98,298190799,'alipay-mp',0,'2088602998955676',''),(99,298190799,'wechat-mp',0,'oernD4l-GQvHHIceXGvpUehb0-x0','Id5Po/i5NSn8g72oOuSgmQ=='),(100,298190799,'alipay-mp',0,'2088622835526139',''),(101,298190799,'alipay-mp',0,'2088422852395161',''),(102,298190799,'wechat-mp',0,'oernD4sgRI5ehN0gf7XUTRwowGAU','P9OEhb67Vq7CGgpEDh15ug=='),(103,298190799,'wechat-mp',0,'oernD4nz7ruzdzqe9Yk3uExmq9UM','jUQzZE8nRZXrmSI7UG2+jQ=='),(104,298190799,'wechat-mp',0,'oernD4gyWP9ZidY_W93sf0K3hHio','UCqw2QJQj3GXoiWWwQOJEg=='),(105,298190799,'alipay-mp',0,'2088822610681301',''),(106,298190799,'wechat-mp',0,'oernD4m55ck9r8l-qbhmh2przTZs','haP3uc/LzB98auBQQk6t9A=='),(107,298190799,'alipay-mp',0,'2088522873481402',''),(108,298190799,'wechat-mp',0,'oernD4j_YEuOyhQfPTRbftMk3ICw','hMDATMR6L7ePMLox46JzHQ=='),(109,298190799,'wechat-mp',0,'oernD4tD86eskESyuRvD3VhRZmD8','Ovr9Cw2Clv+wn4Uvy0oByQ=='),(110,298190799,'alipay-mp',0,'2088912532410867',''),(111,298190799,'wechat-mp',0,'oernD4jGh9hsSkP22f9IdLMD23Lk','xtDWgNejzIyMwiV3yTLpKg=='),(112,298190799,'alipay-mp',0,'2088122688500981',''),(113,298190799,'alipay-mp',0,'2088002894777862',''),(114,298190799,'wechat-mp',0,'oernD4miao5RxmVFSUpGEpNPUcpA','V7cNqVUnz+l1UsRTzGC9yg=='),(115,298190799,'alipay-mp',0,'2088802013341396',''),(116,298190799,'alipay-mp',0,'2088222922568727',''),(117,298190799,'alipay-mp',0,'2088522937883944',''),(118,298190799,'alipay-mp',0,'2088812699918445',''),(119,298190799,'alipay-mp',0,'2088722361314755',''),(120,298190799,'alipay-mp',12,'2088012600366912',''),(121,298190799,'alipay-mp',0,'2088802980123081',''),(122,298190799,'alipay-mp',0,'2088722658292922',''),(123,298190799,'alipay-mp',0,'2088502892125743',''),(124,298190799,'alipay-mp',0,'2088602999299296',''),(125,298190799,'alipay-mp',0,'2088512867957240',''),(126,298190799,'alipay-mp',0,'2088412174573644',''),(127,298190799,'alipay-mp',0,'2088102001668239',''),(128,298190799,'alipay-mp',0,'2088412900743783',''),(129,298190799,'alipay-mp',0,'2088932209976434',''),(130,298190799,'alipay-mp',0,'2088002697754325',''),(131,298190799,'alipay-mp',0,'2088202899530297',''),(132,298190799,'alipay-mp',0,'2088222113948125',''),(133,298190799,'alipay-mp',0,'2088002239068833',''),(134,298190799,'alipay-mp',0,'2088002100740046',''),(135,298190799,'alipay-mp',0,'2088632076042091',''),(136,298190799,'alipay-mp',0,'2088822007791844',''),(137,298190799,'alipay-mp',0,'2088002594142562',''),(138,298190799,'alipay-mp',0,'2088002006249210',''),(139,298190799,'alipay-mp',0,'2088032995828730',''),(140,298190799,'alipay-mp',0,'2088422264390701',''),(141,298190799,'alipay-mp',0,'2088712607488434',''),(142,298190799,'alipay-mp',0,'2088702014980030',''),(143,298190799,'alipay-mp',0,'2088702228864063',''),(144,298190799,'alipay-mp',13,'2088422245758573',''),(145,298190799,'alipay-mp',0,'2088202205525520',''),(146,298190799,'alipay-mp',0,'2088422522246289',''),(147,298190799,'alipay-mp',0,'2088902740936116',''),(148,298190799,'alipay-mp',0,'2088622509242233',''),(149,298190799,'alipay-mp',0,'2088532764241675',''),(150,298190799,'alipay-mp',0,'2088802506501078',''),(151,298190799,'alipay-mp',0,'2088302396125955',''),(152,298190799,'alipay-mp',0,'2088002943164762',''),(153,298190799,'alipay-mp',0,'2088702958848832',''),(154,298190799,'alipay-mp',0,'2088612557123000',''),(155,298190799,'alipay-mp',0,'2088802756996831',''),(156,298190799,'alipay-mp',0,'2088622655540102',''),(157,298190799,'alipay-mp',0,'2088022477336653',''),(158,298190799,'alipay-mp',0,'2088002437477235',''),(159,298190799,'alipay-mp',0,'2088302073136801',''),(160,298190799,'wechat-mp',0,'oernD4oSB0OC50E1tVOFH2Y4rtq0','wNkI1upKrCyH+LJ28bLMjQ=='),(161,298190799,'wechat-mp',0,'oernD4lodsQxvHHXG_VOmVj527tc','gErIbDqFhyapTz6VfnbgXA=='),(162,298190799,'alipay-mp',0,'2088512385022602',''),(163,298190799,'alipay-mp',0,'2088622634245923',''),(164,298190799,'wechat-mp',0,'oernD4ns3kChsxFeSq6pvTqNMT3E','xgDEcllvcgJgAtoRKu6gJA=='),(165,298190799,'wechat-mp',0,'oernD4nUvVmhUjTW2YPTDHHz_kQk','w0R3Yf4mN1Za/UyWbfg75g=='),(166,298190799,'wechat-mp',0,'oernD4kzRSLk4gGPitPq07U7L43Y','e8jQ590qpjP7CPjGz9fEUA=='),(167,298190799,'alipay-mp',0,'2088002127145307',''),(168,298190799,'wechat-mp',0,'oernD4ieHfeWBmkW2J9igBuxdT78','/yKK70Cs+gcnavr4iEZJDg=='),(169,298190799,'wechat-mp',0,'oernD4jncAiP1sC5yVmEKEb7r5e4','HZgQmqqTspG0nVLMOLlzvA=='),(170,298190799,'wechat-mp',0,'oernD4kkqG1HvFnyA8r16Jh9OzpM','iCasvQkfKkVNT000SWtJBQ=='),(171,298190799,'alipay-mp',0,'2088032162379803',''),(172,298190799,'alipay-mp',0,'2088732758415224',''),(173,298190799,'wechat-mp',0,'oernD4nKWgL0vgO-yOrr2_WXmNbA','VNfLkIUDA/Md98NK/0apHw=='),(174,298190799,'wechat-mp',0,'oernD4nSS-TKirjXLfHJ5-BK_jT0','lA1nteYU5VG/bEyj3M9gGg=='),(175,298190799,'wechat-mp',0,'oernD4kzE2XqbJ2iL5sC9LJBV8cU','8Hsh/UJzgdLiKe8lX1Y+EQ=='),(176,298190799,'alipay-mp',0,'2088702665892919',''),(177,298190799,'alipay-mp',0,'2088002122009118',''),(178,298190799,'wechat-mp',0,'oernD4n8PmNZiE9g2XBA1PPGp4N8','uD+7ozkWuzpDOjDYDPG7Xw=='),(179,298190799,'alipay-mp',0,'2088822572140674',''),(180,298190799,'alipay-mp',0,'2088002278346013',''),(181,298190799,'wechat-mp',0,'oernD4vqiDgVEL95BrQ_yqkUUw3I','z77273QkSvA0IRAaGC3kGQ=='),(182,298190799,'wechat-mp',0,'oernD4hcE39IQfsh62reqHeuGSGM','sd+RnXmS/l1NvxhR85DGEQ=='),(183,298190799,'wechat-mp',0,'oernD4ioDd7ga3LstSsI80VKmDII','/FS/jzJVnUTBYJx2bv1UZw=='),(184,298190799,'alipay-mp',0,'2088622578333841',''),(185,298190799,'alipay-mp',0,'2088702339784050',''),(186,298190799,'alipay-mp',0,'2088232219922772',''),(187,298190799,'alipay-mp',0,'2088122520888369',''),(188,298190799,'alipay-mp',0,'2088022304610963',''),(189,298190799,'alipay-mp',0,'2088422912159526',''),(190,298190799,'alipay-mp',0,'2088902265221458',''),(191,298190799,'alipay-mp',0,'2088202379544578',''),(192,298190799,'alipay-mp',0,'2088212426453247',''),(193,298190799,'alipay-mp',0,'2088002277515461',''),(194,298190799,'wechat-mp',0,'oernD4k7zUvKu6Jr_FP24QQ0okzI','aeOvtpBV2WpCyedFy9tRmg=='),(195,298190799,'alipay-mp',0,'2088922032450450',''),(196,298190799,'alipay-mp',0,'2088832518317705',''),(197,298190799,'wechat-mp',0,'oernD4gnNfTNeO2DHwlSD9nZEj10','Km1Pz1Lw01n71kpXNoQNKQ=='),(198,298190799,'wechat-mp',0,'oernD4ojSj2uuvMZjnz3uWDxwrnc','jq64L2y9Me4m4m8Fb5f9HQ=='),(199,298190799,'alipay-mp',0,'2088422802779225',''),(200,298190799,'alipay-mp',0,'2088002070992690',''),(201,298190799,'alipay-mp',0,'2088632631606023',''),(202,298190799,'wechat-mp',0,'oernD4kds2gyhWc9oV10_BkKlh4Y','Ze9YNRxIX++g7f3C7lXkoA=='),(203,298190799,'wechat-mp',0,'oernD4rzjco2fQcdn4b9-5z9YHcA','ITVasOznOjB8kphRxpeIyg=='),(204,298190799,'wechat-mp',0,'oernD4q6O4L-cGbh34j4AhXO6mIk','aASqO/6AAXtca94EQgoHmQ=='),(205,298190799,'wechat-mp',0,'oernD4kqCkRfOOvEmXl6COWpBnJE','W2ffuWDqNNNL9GKhuM0hQg=='),(206,298190799,'wechat-mp',0,'oernD4siPMM2GYNCqBV9-GsCRcWQ','8FGzLijOC/kwDh1GmT3/Fg=='),(207,298190799,'wechat-mp',0,'oernD4hEcUcLsQVNd0XWLT3vy8os','f2uKP30OKQ2HXy5xE1sW8A=='),(208,298190799,'wechat-mp',0,'oernD4pWWZjTOiR1EQOnVIBkN3ls','FevM9EwZC/MJTjIfUUu0Ig=='),(209,298190799,'wechat-mp',0,'oernD4lpMyq8ZYW5mTy75KhnqAhk','tk8iP6WLS90dwecpSZcVIw=='),(210,298190799,'wechat-mp',0,'oernD4q7CrzLrahiklzJXpNlYndU','I2/dkBWStJ94IpoN85lt6Q=='),(211,298190799,'wechat-mp',0,'oernD4u0QQsS7ZneNQlWeoE1y75A','/J69KNhLs0KeCn3o/giNBw=='),(212,298190799,'wechat-mp',0,'oernD4iEdxl8NbNsjgxArFHBrg2Q','IBsqy+Tv8Zs1+57P7q2e2A=='),(213,298190799,'wechat-mp',0,'oernD4saP94A0w_gazf2dXaGWT4k','L9YC2hriisbckRnE7TcV6Q=='),(214,298190799,'wechat-mp',0,'oernD4n61Alwd_kd-3UFo1_vQU0k','mULU45IwVYtw1luKL+iO+w=='),(215,298190799,'wechat-mp',0,'oernD4uxpayoEnviHNuXf7LncuLE','nfkHqjzW/TZNDRjScwMCug=='),(216,298190799,'wechat-mp',0,'oernD4gA80Joif3sxvMhhOO2-X7I','4r2RfPkLISqI3VgDq/32vw=='),(217,298190799,'wechat-mp',0,'oernD4ms9bao5ux61kroTdzmpzqE','u1VgkT6h5ZpYZrcL719xNQ=='),(218,298190799,'wechat-mp',0,'oernD4nZ8Rl2P0VX7bqa-h_Tl-Gc','abn4Yls6geisWuXLh7UUHw=='),(219,298190799,'wechat-mp',0,'oernD4rHEPMgQTKgcghVwwTDlOOI','vMfsf21nKGWfxEWae+3cIw=='),(220,298190799,'wechat-mp',0,'oernD4nN5GLCDrD_B_tcskyp6AII','x8/65uap3iaBsEM8O8gIMg=='),(221,298190799,'wechat-mp',0,'oernD4rCxqfS7aGt7b4_ZqudAYyY','ylZL/3YOOWzZSwXAOIpjcg=='),(222,298190799,'wechat-mp',0,'oernD4q-bGiI2RBt8pGD5U3DC2sA','V07WKK1iZ8z4PMSknko2+w=='),(223,298190799,'wechat-mp',0,'oernD4inHuqZFMg2fxk8eWi8l4gs','oKCwjft1lF20aTQxn6979Q=='),(224,298190799,'wechat-mp',0,'oernD4gllED6VeqmF025R4C6qovY','wsZrIWt2RPgrSquWTo+6mw=='),(225,298190799,'wechat-mp',0,'oernD4jPlPEo25_H-b_BQmSXs058','jC+PCvxx6acNIsPW7brodg=='),(226,298190799,'wechat-mp',0,'oernD4rWDY02z9bSjZ1zuN0mPo4Q','BozC7Rm2BLBkwDWWdgrAYQ=='),(227,298190799,'wechat-mp',0,'oernD4htcJNRx-RBASupeYFVb6Co','M7ofestgXS7MOsOl4A8weg=='),(228,298190799,'wechat-mp',0,'oernD4qS8PeRF-GwHDZHt-1krofM','cKsW3RyqznjsjXGqAtW0RA=='),(229,298190799,'wechat-mp',0,'oernD4gvBk8QfaLSjvPyd0Z_mlX0','i/zis7iU8K0AwXuHb6mkjw=='),(230,298190799,'wechat-mp',0,'oernD4mdH-fMJ-v3RL0H8vBj7QUk','F1mgqa+96UNYEoWGfGP/iQ=='),(231,298190799,'wechat-mp',0,'oernD4jOYzVknH0mNvdtf53r4Qc4','HiG1FdDeIBAnS+iIATCjJQ=='),(232,298190799,'wechat-mp',0,'oernD4ixwx395vE_GGDmSPl2-Z-U','CeLq87cP2Bl2UNFRjdtsCQ=='),(233,298190799,'wechat-mp',0,'oernD4gid2G7Jb-4gRzTCTy1xMOE','VYi1zOy4c+9BdSbrHkSLUQ=='),(234,298190799,'wechat-mp',0,'oernD4ggQc8PXlC6MJRnJaT_jCGI','N28TNCSH1tPmocBDVVsSNw=='),(235,298190799,'wechat-mp',0,'oernD4tdcPASeYcUG7KDmaEO9y1U','JV8/JDRWrOI4XZ1Vedt4Cg=='),(236,298190799,'wechat-mp',0,'oernD4r5qp8URt7XKG_UOLVQRYEE','AqQH4pXph68KoLSs4yX/4A=='),(237,298190799,'wechat-mp',0,'oernD4qe_PqbnxPgTJKyNwWwMr3M','Lzm2fzRuZqVK1uVFX/D0ng=='),(238,298190799,'wechat-mp',0,'oernD4vXSzcQ2UTWTXBKZKGoBdNA','JnIWlIXKC/aNDvlApfKNdw=='),(239,298190799,'wechat-mp',0,'oernD4leZ0vEZo-E8aUEA8N7Z574','xwBDrkpESqFFbPMYP/zqmA=='),(240,298190799,'wechat-mp',0,'oernD4nkjmiFDK7tpfIa5XcY2AiA','12+FMd2IeqCfQR4O5DzN1Q=='),(241,298190799,'wechat-mp',0,'oernD4kk7K-W1KSzWhHW4C3eZ49k','yxePIP7U6aIlQXJJGIPIHw=='),(242,298190799,'wechat-mp',0,'oernD4my2Uljl65mVWjPNv5WuzqE','OJRBgwGIV3/XjoYJyqsWPw=='),(243,298190799,'wechat-mp',0,'oernD4uEz3pETcWMEPWA1xk_lFdg','07oJBzG3nWioqJq1HlGE2g=='),(244,298190799,'wechat-mp',0,'oernD4uXocMCFgCboPHA6G_CowaQ','nLhj3h2oINycKSQR7BR7RQ=='),(245,298190799,'wechat-mp',0,'oernD4qjlFgRbdHjuG5kCO1qBmgY','PysDJS63sw3aH+oExes52Q=='),(246,298190799,'wechat-mp',0,'oernD4jZJZE9-BYiOgeRgxtFSeSE','XR0Ty9QGH86itM6grHJ8RQ=='),(247,298190799,'wechat-mp',0,'oernD4vf6xu5bfjoNER_olDdUaOo','4kg5x852Cx8Ojhn1s1Ba4g=='),(248,298190799,'wechat-mp',0,'oernD4paGP3CfAM31bG09-DzvMe0','r/Z45kQf1akuijur+wPizw=='),(249,298190799,'wechat-mp',0,'oernD4q4oNIoc1OJXWvkbkcjA5Ks','oGV2r18YuLe1ETJMde7VwA=='),(250,298190799,'wechat-mp',0,'oernD4vo57E3beP4ZtbcUV9MtbYc','H/RUgLCYAf/oyHp1yWhWxg=='),(251,298190799,'wechat-mp',0,'oernD4kMxH6DREvnHGJjYHSThmho','N+8bzbYt48pLyDMljZDh3g=='),(252,298190799,'wechat-mp',0,'oernD4uT7iKrEjlmd2LNAORMLYAs','I93riaewm238H1w0vjrGKg=='),(253,298190799,'wechat-mp',0,'oernD4prtF4DgPUL9j8cH07jfWHM','FqYnVKP0tT2NVBwlECm+rA=='),(254,298190799,'wechat-mp',0,'oernD4k8xQ85Fuysj19ahwGMWRhs','DmZUc108bXR010lZKWD5ww=='),(255,298190799,'wechat-mp',0,'oernD4hUP0Sh7cv8tTu1FGzx7rEM','fh1DPVbihcdj9P7cFb2Cmw=='),(256,298190799,'wechat-mp',0,'oernD4sI8XqUCwxS8V_9YtEjZ-pk','/vy5Zw2Ys1/i22LUlvNp2A=='),(257,298190799,'wechat-mp',0,'oernD4occZV4JbUcahLwiqCEgHu0','2VaQNOB/+Z2HFs+jOsS+hg=='),(258,298190799,'wechat-mp',14,'oernD4oth0RljNKQNrptrY47u8oY','r7qf06KXDphsLRQNmyNlgQ=='),(259,298190799,'alipay-mp',0,'2088902136566471',''),(260,298190799,'alipay-mp',0,'2088532646586043',''),(261,298190799,'alipay-mp',0,'2088802124060201',''),(262,298190799,'wechat-mp',0,'oernD4nDBCSqXPW0MbEAHzgdmTCc','ZecsAEg8MjN5rMrB7tZToQ=='),(263,298190799,'wechat-mp',0,'oernD4mT8_gTXm8NeHjy4HNtNdx8','OtKAKPQyOUahIgZl2uslqw=='),(264,298190799,'wechat-mp',0,'oernD4pF1IsSaHOhrFgc9BOSbNtQ','E7Jdsk4YpMTuUF8rGkbw2g=='),(265,298190799,'wechat-mp',0,'oernD4ms-DaXmWO0v2v9u9DTzYYk','rCOz1knwR4GCTYw3ceHWVQ=='),(266,298190799,'wechat-mp',0,'oernD4peh9Gb03lQ71wfKmUc9QF4','i01NoYCdBum1hMd8jdhlHw=='),(267,298190799,'wechat-mp',0,'oernD4jKmdaVIEcDcFJ2UGFe6Noo','ODISV1bItQ84pUvgwPIJUA=='),(268,298190799,'wechat-mp',0,'oernD4leK0bGrCJ6Ivwz9AwVHPtA','lx8pqZVE1oRkK82zeCL1IA=='),(269,298190799,'wechat-mp',0,'oernD4t-OsIhK7DPuX53mGRIgm9s','qhSepZqtjkP9gi2yjoWkNw=='),(270,298190799,'wechat-mp',0,'oernD4on35uTZXBulwXSF6kJHvqk','CVgMEt4grLOxQZPmKDAoNg=='),(271,298190799,'wechat-mp',0,'oernD4qdZDasgehYXT5vnSJjl3Ms','XhRNJxrrrgWIjGj9d3othg=='),(272,298190799,'wechat-mp',0,'oernD4t-tGYC-1mvKMSNtEtBC6bU','aRLWiKWGX7qPnF7PJicebw=='),(273,298190799,'wechat-mp',0,'oernD4uGgHZdsovdcn_wVeH2zDLw','xa3ZUa4QYVyn5YqvcWD8Lg=='),(274,298190799,'wechat-mp',0,'oernD4iMyyIkuz7qzGsJqKeCNw2c','Qr10Fo6Iqt2R4hn0MBcH8A=='),(275,298190799,'wechat-mp',0,'oernD4pmH1AOiVpLqC0d79hEWFh8','6n5G5JKvgT/fNDF1HQGdMQ=='),(276,298190799,'wechat-mp',0,'oernD4h-Dd1zPfcN2kgCrzNoEXNc','qNP6Phyw5IkOTJ/6m/f09A=='),(277,298190799,'wechat-mp',0,'oernD4r9hDIDy-KgQRx94ldZdEWw','2bOpTSulZaQonBMDyUT+mQ=='),(278,298190799,'wechat-mp',0,'oernD4g2FeUvuFnNYuPpGn5Yf094','G57qew3Z6QoMx+SmXZBVYg=='),(279,298190799,'wechat-mp',0,'oernD4revWAYD-ykJVVRXY8-rB6w','ks4gZN+PoCLInyKDNCuSIA=='),(280,298190799,'wechat-mp',0,'oernD4vvVPGYatdXBPumhOg4srWM','dltXsDrywXYUd1IiYM1TBQ=='),(281,298190799,'wechat-mp',0,'oernD4oAFrbhILVtTvtE_LlZSdvY','qGnCprdDdMu6QisV/qQYmQ=='),(282,298190799,'wechat-mp',0,'oernD4stth0lG9ZJh1lCFOCcV8Rs','o+LZJFNiJiFPRHvqlKKLOA=='),(283,298190799,'wechat-mp',0,'oernD4vOZTNsptDD7u5ab9FUPBHw','DMWEOwJGpPZaAsjwhv4gxA=='),(284,298190799,'wechat-mp',0,'oernD4vbJ_-3y_QIrgrE8-D2A6RY','lnsJTVaFgdiaIhwhXKj7CA=='),(285,298190799,'wechat-mp',0,'oernD4lstkscS2u5EtRjmjyLfGqc','p4uqIID7gYXnZeafbIDzYg=='),(286,298190799,'wechat-mp',0,'oernD4kqSxnaEyfBrthyWo45pl2U','XBg5+VCwJ+UjZTbVhktuEA=='),(287,298190799,'wechat-mp',0,'oernD4qHuoBuyqrjTi5cYIU1coWE','Rx9Pw0FniG6eOagwGF8xrA=='),(288,298190799,'wechat-mp',0,'oernD4r5SdrhJD5NVC-0jPpUk0Dw','vQ8D3E2o3MQ4mObuLl4QWA=='),(289,298190799,'wechat-mp',0,'oernD4gYUmqNDgC91XOkmWcDe68g','GOf/vKkOlzAsirfEBm0/3A=='),(290,298190799,'wechat-mp',0,'oernD4m3NQ3imteICKCthg1mNAZ4','Iyxx9PlUCLu6l8YdWPVG0w=='),(291,298190799,'wechat-mp',0,'oernD4qhFwgwbjT0YO2JKXlsoj6c','mlIYhTc7HEwrUkhd03/DSA=='),(292,298190799,'wechat-mp',0,'oernD4uy2aP84-AnULIWcX3vKBEI','IGm9U95h8AVy0jilPN7h6Q=='),(293,298190799,'wechat-mp',0,'oernD4vtHJ6FPbAs4b7cwgQbOd7E','30tr4fSlmfxESkH1xjUb+Q=='),(294,298190799,'wechat-mp',0,'oernD4rpXL7cHwJX6waCc35W6eGw','Xuy9G1TOW+EeTBn1Yr1iOA=='),(295,298190799,'wechat-mp',0,'oernD4gk2qTXTeXA33_Q_RZRu4X4','dhmHTDL9FIIOfnLNXOpxLQ=='),(296,298190799,'wechat-mp',0,'oernD4mF6-tZ0lYk6BgVl63u8DLE','Mq/usZt/zKbGCTfz1hsm1w=='),(297,298190799,'wechat-mp',0,'oernD4sXx0_ES9TFobUqDO9IXbec','AkduqaGRx/E6p5ft7Kcylg=='),(298,298190799,'wechat-mp',0,'oernD4kxMMOUJEQMwb0E2KXR70ys','cYeM4JuJcP8QOu/c/lFseg=='),(299,298190799,'alipay-mp',15,'2088402735822782',''),(300,298190799,'alipay-mp',0,'2088802062237802',''),(301,298190799,'alipay-mp',0,'2088702226331743',''),(302,298190799,'alipay-mp',0,'2088702928314594',''),(303,298190799,'wechat-mp',0,'oernD4jk5_Angv3B47-LgnSUQrwI','NlV1QUde/sH/E//VmF//qQ=='),(304,298190799,'alipay-mp',0,'2088902567880993',''),(305,298190799,'alipay-mp',0,'2088612147433652',''),(306,298190799,'alipay-mp',16,'2088402909670713',''),(307,298190799,'wechat-mp',0,'oernD4gFoekvX6X_B52aniOdljWM','1IR1CJbsFl8F/SWYKZ+16w=='),(308,298190799,'alipay-mp',0,'2088302464112564',''),(309,298190799,'alipay-mp',0,'2088042731423192',''),(310,298190799,'alipay-mp',0,'2088132626216656',''),(311,298190799,'alipay-mp',0,'2088002674398430',''),(312,298190799,'alipay-mp',0,'2088922603907505',''),(313,298190799,'alipay-mp',0,'2088302724673145',''),(314,298190799,'alipay-mp',0,'2088522613398346',''),(315,298190799,'alipay-mp',0,'2088102139783053',''),(316,298190799,'alipay-mp',0,'2088832257636293',''),(317,298190799,'alipay-mp',0,'2088422238186246',''),(318,298190799,'alipay-mp',0,'2088002580613229',''),(319,298190799,'alipay-mp',0,'2088822533959695',''),(320,298190799,'alipay-mp',0,'2088422895849142',''),(321,298190799,'wechat-mp',0,'oernD4jO88bpKIyI-j-ol5KuLHok','gFy++UGtInQSKnNhgd8hiA=='),(322,298190799,'wechat-mp',0,'oernD4g6Ubqc2CKeG_CtQ4b3qRK0','VrfoGxVih35aDl9BzaDMEQ=='),(323,298190799,'wechat-mp',0,'oernD4vtgFqJ4OldCkjyd29rO4gU','jZvXH9wK7JnrjaDeRGYAaQ=='),(324,298190799,'wechat-mp',0,'oernD4rQ9PxpVFCK7wN4YvWnX4I4','0Dp55e3ZL0yoRF11mIpibA=='),(325,298190799,'wechat-mp',0,'oernD4pKJ5rYN6ChiJLZFCHLauMo','uJM/my/CAm6p/DkDPcwfsQ=='),(326,298190799,'wechat-mp',0,'oernD4h3HpZJzKZA_3_xlczl-KhA','jhyXysHbfKw4BlJyF7VT/w=='),(327,298190799,'wechat-mp',0,'oernD4t00fRcXC25gAGaQKUtKhew','AeykmkPMqYOtdaByr+UABQ=='),(328,298190799,'wechat-mp',0,'oernD4osTMGJDC9T3Upvnc3Z9d6g','0dt/CaX1SfcVvJpk5vknbg=='),(329,298190799,'wechat-mp',0,'oernD4pThDZ1eHIb1y1kAFJwAq7Y','8/hcGKIfkzelIvEThzqwVA=='),(330,298190799,'wechat-mp',0,'oernD4v90LbC-4Nxx_9nSKC3nBS4','cl5uJt50MpMGd8Su5/V38g=='),(331,298190799,'wechat-mp',0,'oernD4oU5BjjeO2HTBgfJT5JbWVU','MUwAeDQEiP2ZmtMhreLQUw=='),(332,298190799,'wechat-mp',0,'oernD4tiP_n9w3a_0l7N8SNU9Q34','wCoAIP7yw7piSyzcsyu9Bw=='),(333,298190799,'wechat-mp',0,'oernD4tPX59EbXDHcQBpsGqBYkT4','AH6MdsyGR6iCbCjctUrbrA=='),(334,298190799,'wechat-mp',0,'oernD4oHlYhZRsVwXkK1p186klhc','QltVr7n0bG+jl5Jtpo2lIQ=='),(335,298190799,'wechat-mp',0,'oernD4p-oMtZOIxILP7PMQNpISvs','ZtQ4AJcydhqtragdK+ywRg=='),(336,298190799,'wechat-mp',0,'oernD4mkAAWx5Sw4uH07-DQYxGt8','frx/GclP7VQT/SmOT5UqIw=='),(337,298190799,'wechat-mp',0,'oernD4sGQhMx5K1Az6hNUO8ON74s','YfJ2bgqVvEvlROKG1OPdQw=='),(338,298190799,'wechat-mp',0,'oernD4og69pfPdT_o8Y3RmVG8SXo','uLYOlTCYlGvC6ivKiaJi3Q=='),(339,298190799,'wechat-mp',0,'oernD4ipo_Qa-KqRKteiK1Ivetu8','rj/8fc+bs/r14paINoeJDw=='),(340,298190799,'wechat-mp',0,'oernD4npvp6AH_oQeAtl2yhBgaLM','TMxRK2x/tJNQTqsv5UkgTw=='),(341,298190799,'wechat-mp',0,'oernD4rMge_hW6chH8orAigWFIUI','jCi3E1s38rGTIspxMeMeiA=='),(342,298190799,'wechat-mp',0,'oernD4ssKDFGEkhijVlo1uqnIUxI','EV7tp0pnPA/wceXXNN8L+Q=='),(343,298190799,'wechat-mp',0,'oernD4pJHoaFSv9z2ft2YS2U8szU','+RKwSbFz6tCxLnMt3prToA=='),(344,298190799,'wechat-mp',0,'oernD4vUIYPuWpXBqRZbeczGyBOE','AJ1wws5Bk7ogipnwFKjuOg=='),(345,298190799,'wechat-mp',0,'oernD4t4xv-WZpNjpIGqlsE4BbP0','VpenFH/y35410PJiximFFg=='),(346,298190799,'wechat-mp',0,'oernD4rDaCP0oDWKi3kBe70idjQ0','BGuKnZ1pugfSkKdjtUFlgw=='),(347,298190799,'wechat-mp',0,'oernD4ob5OSHOj7uKiADYqQdvQRA','PsROxGAouRNsm0HP7VpdpQ=='),(348,298190799,'wechat-mp',0,'oernD4rnMUKezpmgkX5TcTOv73FY','nempjPbWml7Xc6FE/1t9tA=='),(349,298190799,'wechat-mp',0,'oernD4tYCCAWC_RXLdYs0oxX5h8M','cbiY22HrIuOcTDL/Yjhq2g=='),(350,298190799,'wechat-mp',0,'oernD4u_QA8166LeuZTzwrcBvITk','mvpgVOLMHubT90ayw93Iuw=='),(351,298190799,'wechat-mp',0,'oernD4mSWzL-jBUZxMoKZtNa4kmY','fO6vkyMYvZqjy5q1m2S1mw=='),(352,298190799,'wechat-mp',0,'oernD4rAiHHfIKu0823Dvy64gE3M','5N9FZCOWOpRbLmiTHi9QzA=='),(353,298190799,'wechat-mp',0,'oernD4sg5-4gbrsh_9QAt_1nTDlU','Ts2TtOWjJTfz1j36od62fg=='),(354,298190799,'wechat-mp',0,'oernD4tRuoYUs7QZ4lUiDPU-Vtd8','XiRWIaY62w9Ls6/o5izvVw=='),(355,298190799,'wechat-mp',0,'oernD4kbTIpZ7RjTzfYVDX3BZ7Uk','k7RLHPKDWjdJfQ9WSDyDoQ=='),(356,298190799,'wechat-mp',0,'oernD4rufrc3V68015VYrqYdg1Rg','SKZ2k3uqfHEfSBizTuVakw=='),(357,298190799,'alipay-mp',0,'2088142406629275',''),(358,298190799,'alipay-mp',0,'2088532636361975',''),(359,298190799,'wechat-mp',0,'oernD4i3K9H4PgBIeNwyIFy8JapU','GsBzt3J/3Hd/7DsIkPgZjg=='),(360,298190799,'wechat-mp',0,'oernD4sps3JEkc7FPAy5Uvju714E','ZTJiu9n1TO6PfmqioiJo4A=='),(361,298190799,'wechat-mp',0,'oernD4kG_M-3QFoMgOvgqInm5J7M','bhlclB+fjaTPYKvh9S9lwQ=='),(362,298190799,'wechat-mp',0,'oernD4jxHbQB3QDT5ViiZNxt_K58','hF6tRs3VA9FCvzC6f5hkIA=='),(363,298190799,'wechat-mp',0,'oernD4m2Kxq_Ro9OYzz1j0vCMwNs','uC0XJjxKJD0i0UwWMiWIMw=='),(364,298190799,'wechat-mp',0,'oernD4vdWrZSd8qN72WGsSXixorE','8kFjBGpd2qx+N4YOXWIj8g=='),(365,298190799,'wechat-mp',0,'oernD4v-jsDQBTHwqlljMP9T5QYw','6UUQmuHUyIoI+zEvEfFRVA=='),(366,298190799,'wechat-mp',0,'oernD4p_dvoc242o8L61UEscEnvs','1yV3y7GHyU8jCd03EnmVXg=='),(367,298190799,'wechat-mp',0,'oernD4spEAEeN2fTnTyGU5W8zSts','UYljPojnSaMSZ4SCx1Ir4Q=='),(368,298190799,'wechat-mp',0,'oernD4hQw9-cqOh03ySiWgAS0c7c','cWHu+iRHwNgesg7K3zlcMA=='),(369,298190799,'wechat-mp',0,'oernD4nsOY3vZkrMZOKEknlq1ZHI','zJEER/Rl//8/NxZxU57O8w=='),(370,298190799,'wechat-mp',0,'oernD4ig3v5_7KBQ6dHKYgI_921Q','0hnYshwBZWdOUcSnNmlkYA=='),(371,298190799,'wechat-mp',0,'oernD4tTdbU5JxSh5WmWHjA5MTjM','JRTXzNhHMG6KOm3DVxI9Pw=='),(372,298190799,'wechat-mp',0,'oernD4p-YP2KgDYGry8RuKU17WOQ','c2d7ex15xVlvbuaJhpdNQA=='),(373,298190799,'wechat-mp',0,'oernD4u1YAq42TekDfM9kmUYgGM0','i4qgTKdAeVJvvNtkpla2TA=='),(374,298190799,'wechat-mp',0,'oernD4qkEL0NQQ3pI2HDCU-5v2bs','iVyBCs47x8Ogg7Xhag/RTg=='),(375,298190799,'wechat-mp',0,'oernD4mvmMkrrWY8gds9AksqW4OE','rFU6hzWFwZUqexecSKQjsg=='),(376,298190799,'wechat-mp',0,'oernD4hpAw0iyPsKQq4sMb-LQYEk','tq1olHjNK9kRB45mvqVYSg=='),(377,298190799,'wechat-mp',0,'oernD4iukQW64-5etDbyYnkfNhA4','kMaxmbN4yz4dQ24l9nD5Ig=='),(378,298190799,'wechat-mp',0,'oernD4qKG9o_4lAm9g5BaW4oBxlA','FADNfCKzGJQ2AkrDiND/kQ=='),(379,298190799,'wechat-mp',0,'oernD4i7aO4q6bZmuNOXJpnu_7DQ','ilhBtYKa8yWXRtIgWB1VEQ=='),(380,298190799,'wechat-mp',0,'oernD4vf7G2KKoh-Pl6fbxfrdIZM','mkLG3i7Q3BDDmzx79Y7oCg=='),(381,298190799,'wechat-mp',0,'oernD4r3P9Tjubd5YYZtYDMGIVhg','/qi4tz1MTrsiLZAl1WQ7FA=='),(382,1661227707,'wechat-mp',0,'orGm04lCzBVhH0R11OtySuV6xj60','pCqWUxIQP4+EhnRN7ONmzg=='),(383,298190799,'wechat-mp',0,'oernD4vy427LKiXV1h_Uk71jiuKQ','QxpOtq/GpaQ0IAQVD+iIrQ=='),(384,298190799,'wechat-mp',0,'oernD4iInvZzBL5ue6xOhGudDYzs','7Fx78TC+3WvkI5UjEgTHzA=='),(385,298190799,'wechat-mp',0,'oernD4hsOzZW5u_N2D0TK-I-fCeE','FaYnZedSQL85VDU58nLaIA=='),(386,298190799,'wechat-mp',0,'oernD4lL2linIZe-SHe6CsYzQEsg','Xvh3IJGL59FZ2AFdgRnRHw=='),(387,298190799,'wechat-mp',0,'oernD4rPSvs54PUop4YqfqkEhT2s','B5wRUV/bZlYVUuHViV90OA=='),(388,298190799,'wechat-mp',0,'oernD4q0PX-kH4pQrVQ10RxO-5p4','yJzxpK74k+6qeriL2qmNuQ=='),(389,298190799,'wechat-mp',0,'oernD4kzdsae0xryd15GdAl80eOQ','ggW1bD44P5j/Boq7jTXS1g=='),(390,298190799,'wechat-mp',0,'oernD4j9DqcCQNsUVmRMSQZOsKsw','iEhYeAUWBaXCvRjOq0Q5wA=='),(391,298190799,'wechat-mp',0,'oernD4lcWXNQi1dm_OY8TDdHSic4','U52cvAIbiyCSQEAHPcLzWQ=='),(392,298190799,'wechat-mp',0,'oernD4pccYv44JzMEZf7tETmbiSk','w/Md1X4toMGf9wnkiY/2Ow=='),(393,298190799,'wechat-mp',0,'oernD4qfr8QovlmSzVgEyvKCQbrQ','hnFfxKjPKuVqgwQZrDsmOw=='),(394,298190799,'wechat-mp',0,'oernD4oPz4xkTvSoRnM-hmIGHuiA','J6EnH6xFaNLyZatlyjyWFA=='),(395,298190799,'wechat-mp',0,'oernD4mJB8INe0oQz52dmOw-L9ek','kPrcsiPrTXdC22j44gEErQ=='),(396,298190799,'wechat-mp',0,'oernD4mA4DthOejfCqi2C3lG49UM','ZQZK8OJwDVZ1cr+0aCZz/Q=='),(397,298190799,'wechat-mp',0,'oernD4lvEqU78gLXNnzHyk9_-ObU','1ZjABszZSZ+otYomCPor2A=='),(398,298190799,'wechat-mp',0,'oernD4osbWWGwAE_hKz9ic6H7BGY','PRVcHNXyYYGaXuwzA+sqPA=='),(399,298190799,'wechat-mp',0,'oernD4gPQM8fMp9SMRW7609JvBKA','ZOQ0YG9vcPD/NC9g1uOGVA=='),(400,298190799,'wechat-mp',0,'oernD4kLZk3VDtJu8HZuGGtxlyxs','F5HYNK7s+ZGQuxcLirA9+g=='),(401,298190799,'wechat-mp',0,'oernD4lhP_IYzfVdL0YDwpxX_0hk','+bQRfQ+qWAOKREYADpmLRA=='),(402,298190799,'wechat-mp',0,'oernD4t1mWWVihOMjc-l_O_Q6C58','4XVDqOEG4SqiWSZmcfnQRw=='),(403,298190799,'wechat-mp',0,'oernD4k9jI1FM80_BTBLnET9Qg_c','Ditp/lLYx72y50KyYzMFTA=='),(404,298190799,'wechat-mp',0,'oernD4r9TWqFcrgFA-GrkPETJ4BA','BD+bWJ6kA3qiFPNv122YOA=='),(405,298190799,'wechat-mp',0,'oernD4gCqj9AJTpfBvMXizbPl6Lk','or0sNhUMmxsjhwWWAPNgkA=='),(406,298190799,'wechat-mp',0,'oernD4rMkV3uXaDkLswunh_xuS10','52T33B2qfNZvDQoCBzG9Yw=='),(407,298190799,'wechat-mp',0,'oernD4pYvBcW74zbVzJl-9I6BlFw','egCZ9SVEe0eWT23r2oN7BA=='),(408,298190799,'wechat-mp',0,'oernD4i3kyy3PQ0zA2bpK46-f5zc','lzCT4Kpe+9+zefiMt+d/OA=='),(409,298190799,'wechat-mp',0,'oernD4kpzF5ECRMPG28UM9d2IT94','F94lrjp9ohXpSeAB/c54dg=='),(410,298190799,'alipay-mp',0,'2088012861048112',''),(411,298190799,'wechat-mp',0,'oernD4h8hF7kI-PdO-iL0y83CLjE','r8OCY8XxT8H4Wo4Y+40+Kg=='),(412,298190799,'alipay-mp',0,'2088202885283721',''),(413,298190799,'alipay-mp',0,'2088612217610985',''),(414,298190799,'alipay-mp',0,'2088612427816272',''),(415,298190799,'alipay-mp',0,'2088912922084452',''),(416,298190799,'wechat-mp',0,'oernD4mPsb5T4wdUie0SpkwyjLQo','EY9HcT5NOhcNq2rilidgqw=='),(417,298190799,'wechat-mp',23,'oernD4irF-nRHFKiM_P9yBt_2ELE','MH9iEWZCpkzPWju+lcG3ug=='),(418,298190799,'alipay-mp',18,'2088312285584657',''),(419,298190799,'alipay-mp',0,'2088922234806707',''),(420,298190799,'wechat-mp',0,'oernD4gk7IrfeUZvgBKlvYQTOcDY','QhqTyC1l3A/6ULrjv9cOJw=='),(421,298190799,'wechat-mp',0,'oernD4vIga6UG2N220f0UNcM9wQc','fubARKfQHssSp7v/IORxTg=='),(422,298190799,'alipay-mp',0,'2088902280163564',''),(423,298190799,'alipay-mp',0,'2088902352100862',''),(424,298190799,'alipay-mp',0,'2088822767271211',''),(425,298190799,'alipay-mp',0,'2088232240260962',''),(426,298190799,'alipay-mp',0,'2088102115544483',''),(427,298190799,'alipay-mp',0,'2088222766829675',''),(428,298190799,'alipay-mp',0,'2088502846053412',''),(429,298190799,'alipay-mp',0,'2088212467448097',''),(430,298190799,'wechat-mp',0,'oernD4r1oMP8GKIPXnkbFQDggJrQ','/UPZsNp2SXbglLGVxS1Hdg=='),(431,298190799,'alipay-mp',0,'2088102313225432',''),(432,298190799,'alipay-mp',0,'2088532012456121',''),(433,298190799,'alipay-mp',0,'2088002435704032',''),(434,298190799,'alipay-mp',0,'2088042865655966',''),(435,298190799,'alipay-mp',19,'2088422272070840',''),(436,298190799,'alipay-mp',0,'2088422420030425',''),(437,298190799,'alipay-mp',0,'2088522401289706',''),(438,298190799,'alipay-mp',0,'2088722577838344',''),(439,298190799,'wechat-mp',0,'oernD4hG4Ce2CQL3dEO_RZ8DCXmg','uFOonLOHxmI6OcxSQGMGOQ=='),(440,298190799,'alipay-mp',0,'2088802393303890',''),(441,298190799,'alipay-mp',0,'2088602267358991',''),(442,298190799,'alipay-mp',0,'2088902654975566',''),(443,298190799,'wechat-mp',0,'oernD4hd3HYt3rG2kWmkDmNbTGkg','Rsci2CJFXXQ57p+x06pbUQ=='),(444,298190799,'alipay-mp',0,'2088502848612567',''),(445,298190799,'alipay-mp',0,'2088722435680119',''),(446,298190799,'alipay-mp',0,'2088422399240113',''),(447,298190799,'alipay-mp',0,'2088302063732660',''),(448,298190799,'alipay-mp',0,'2088902364411815',''),(449,298190799,'wechat-mp',20,'oernD4jN2ZuFR_pBccpX5LNXGIYM','Pg2wgFlYRdEio6QHC59WIw=='),(450,298190799,'wechat-mp',22,'oernD4hpGIHKX1E77QOSNyM2stw4','rlzp6ZHieExBClkojOiS5Q=='),(451,298190799,'wechat-mp',21,'oernD4jCiiV8Eysth7bF_t-M6iv8','Iz1Fg+Kt9gevYN/Zu6l7ww=='),(452,298190799,'alipay-mp',0,'2088822910776334',''),(453,298190799,'wechat-mp',0,'oernD4ujr85QY4PoQRQO-VrH8HEY','JVQLOql+QPScn5fVlTAIrw=='),(454,298190799,'wechat-mp',0,'oernD4hn2ns9rAedx6EJumV1UM0k','O2wtPWUse1Y95tvfAsycQQ=='),(455,298190799,'alipay-mp',0,'2088222353987751',''),(456,298190799,'alipay-mp',0,'2088902996061697',''),(457,298190799,'wechat-mp',0,'oernD4ks-RXN2RbvH6X9zFcHUu2g','Gzh+NTqQdMVRmEZYnh9k/w=='),(458,298190799,'wechat-mp',0,'oernD4pHQW2S7FBFSZidT94xQHA8','X1qbyGSwg3vvN2Met8OmWw=='),(459,298190799,'alipay-mp',0,'2088932451550785',''),(460,298190799,'wechat-mp',0,'oernD4gXGlRFn_twUZotIke0kaUY','/BVubZHWTfLBdG9YJpp70w=='),(461,298190799,'alipay-mp',24,'2088232524492205',''),(462,298190799,'alipay-mp',0,'2088932209078428',''),(463,298190799,'alipay-mp',0,'2088902404934481',''),(464,298190799,'wechat-mp',0,'oernD4lNXwY0UzBPcrTXHwzzIuxQ','sGq0TLdyawR1AKNF+i73dQ=='),(465,298190799,'alipay-mp',0,'2088142815458437',''),(466,298190799,'alipay-mp',0,'2088002341293563',''),(467,298190799,'alipay-mp',0,'2088002168050352',''),(468,298190799,'alipay-mp',0,'2088212920378466',''),(469,298190799,'alipay-mp',0,'2088702088657553',''),(470,298190799,'alipay-mp',0,'2088412617041819',''),(471,298190799,'alipay-mp',25,'2088022799037607',''),(472,298190799,'alipay-mp',26,'2088022416372887',''),(473,298190799,'alipay-mp',0,'2088312079604086',''),(474,298190799,'wechat-mp',27,'oernD4slyznVPhFvAZbQzco-A-4Q','XWpdnUDgk6BUQpy9Vw8uiA=='),(475,298190799,'alipay-mp',0,'2088502859230990',''),(476,298190799,'alipay-mp',0,'2088002127339711',''),(477,298190799,'wechat-mp',28,'oernD4m0uNmtKJgY81WwMmwb6njk','hYXL9Wwq2zU7+DhMwPC6rw=='),(478,298190799,'alipay-mp',0,'2088002532864105',''),(479,298190799,'alipay-mp',0,'2088612957058843',''),(480,298190799,'alipay-mp',0,'2088312164768954',''),(481,298190799,'alipay-mp',0,'2088002000468073',''),(482,298190799,'alipay-mp',29,'2088532518128821',''),(483,298190799,'wechat-mp',0,'oernD4hKcNa5aEjGnlIJnKqOUn08','el6M9ikRQscdY9zIW1mxUA=='),(484,298190799,'alipay-mp',0,'2088822451245502',''),(485,298190799,'alipay-mp',0,'2088702893069192',''),(486,298190799,'alipay-mp',0,'2088302794201749',''),(487,298190799,'wechat-mp',0,'oernD4soh0hKW02h4CjLlYDWDT1M','yh+LhGoYjHCV2ANlHji0og=='),(488,298190799,'alipay-mp',0,'2088612701827060',''),(489,298190799,'wechat-mp',0,'oernD4r9mXJFnn8GYm4YzEf5P7Mw','1rT3oqEA/MTWo2Rp2QPujA=='),(490,298190799,'alipay-mp',0,'2088922373239192',''),(491,298190799,'wechat-mp',30,'oernD4lzH43ScEddA8NQeEMIqr_g','PFnK01kaw/JUNEhphLJiYQ=='),(492,298190799,'alipay-mp',0,'2088522704991971',''),(493,298190799,'alipay-mp',0,'2088512969203863',''),(494,298190799,'alipay-mp',0,'2088902229385235',''),(495,298190799,'alipay-mp',0,'2088702778117484',''),(496,298190799,'alipay-mp',0,'2088002527821045',''),(497,298190799,'alipay-mp',0,'2088302232434355',''),(498,298190799,'alipay-mp',0,'2088312472905500',''),(499,298190799,'alipay-mp',0,'2088722509053261',''),(500,298190799,'alipay-mp',0,'2088902009788823',''),(501,298190799,'alipay-mp',0,'2088602136219945',''),(502,298190799,'alipay-mp',0,'2088912970083269',''),(503,298190799,'alipay-mp',0,'2088502341939831',''),(504,298190799,'wechat-mp',0,'oernD4vtDeJXodD8BRcx_auJBHeY','HBYR73b6zxAtAN+OQffnag=='),(505,298190799,'alipay-mp',0,'2088922432523073',''),(506,298190799,'alipay-mp',0,'2088242111417182',''),(507,298190799,'alipay-mp',0,'2088142270634032',''),(508,298190799,'alipay-mp',0,'2088422677271217',''),(509,298190799,'wechat-mp',31,'oernD4rhLsd9xsyV0ygNHV6o4Uzw','CIKyaijGQ/Odcfp9YB90DQ=='),(510,298190799,'alipay-mp',0,'2088602246186786',''),(511,298190799,'alipay-mp',0,'2088722127127731',''),(512,298190799,'alipay-mp',0,'2088612123280148',''),(513,298190799,'alipay-mp',0,'2088702065102676',''),(514,298190799,'alipay-mp',0,'2088202823421673',''),(515,298190799,'alipay-mp',0,'2088602302321564',''),(516,298190799,'alipay-mp',0,'2088702046972559',''),(517,298190799,'alipay-mp',0,'2088902910254453',''),(518,298190799,'wechat-mp',0,'oernD4r0ihrKWBmTZCKSXKsfUgNY','AXwfm7gsW4kTTKKufVyzGQ=='),(519,298190799,'alipay-mp',0,'2088302125518605',''),(520,298190799,'wechat-mp',0,'oernD4qDmbtxae3H-uEb2O9BuLZ8','Y4+xCjuxOJLhpA4N3basDA=='),(521,298190799,'alipay-mp',0,'2088912683851768',''),(522,298190799,'alipay-mp',0,'2088122954745287',''),(523,298190799,'alipay-mp',0,'2088032401181394',''),(524,298190799,'alipay-mp',0,'2088142903082126',''),(525,298190799,'alipay-mp',0,'2088122324722089',''),(526,298190799,'alipay-mp',0,'2088002079872683',''),(527,298190799,'alipay-mp',0,'2088632280060362',''),(528,298190799,'alipay-mp',0,'2088712877898337',''),(529,298190799,'alipay-mp',0,'2088002099444394',''),(530,298190799,'alipay-mp',0,'2088712883887288',''),(531,298190799,'alipay-mp',0,'2088912598127484',''),(532,298190799,'alipay-mp',0,'2088002370299521',''),(533,298190799,'alipay-mp',0,'2088002655324012',''),(534,298190799,'alipay-mp',0,'2088122545940749',''),(535,298190799,'alipay-mp',0,'2088122980239183',''),(536,298190799,'alipay-mp',0,'2088402975762161',''),(537,298190799,'wechat-mp',0,'oernD4jxaQnT0APnXmkn-mdxI5ko','H+XAiSPwAbEK+RhSRlGOFw=='),(538,298190799,'alipay-mp',0,'2088002009394698',''),(539,298190799,'alipay-mp',0,'2088112575672859',''),(540,298190799,'alipay-mp',0,'2088202353940381',''),(541,298190799,'alipay-mp',0,'2088122994053975',''),(542,298190799,'alipay-mp',0,'2088102095221873',''),(543,298190799,'alipay-mp',0,'2088002476871139',''),(544,298190799,'alipay-mp',0,'2088112266171234',''),(545,298190799,'alipay-mp',0,'2088702158446232',''),(546,298190799,'alipay-mp',0,'2088002615208723',''),(547,298190799,'alipay-mp',0,'2088332580783964',''),(548,298190799,'alipay-mp',32,'2088012055776153',''),(549,298190799,'alipay-mp',0,'2088522003031413',''),(550,298190799,'alipay-mp',0,'2088002207127625',''),(551,298190799,'alipay-mp',0,'2088422995760516',''),(552,298190799,'alipay-mp',0,'2088902754183913',''),(553,298190799,'alipay-mp',0,'2088802232867945',''),(554,298190799,'alipay-mp',0,'2088802837552701',''),(555,298190799,'alipay-mp',0,'2088722387191000',''),(556,298190799,'alipay-mp',0,'2088702267723763',''),(557,298190799,'alipay-mp',0,'2088702269914035',''),(558,298190799,'alipay-mp',0,'2088722695038284',''),(559,298190799,'alipay-mp',0,'2088702083647382',''),(560,298190799,'alipay-mp',0,'2088702708755401',''),(561,298190799,'alipay-mp',0,'2088912854388783',''),(562,298190799,'alipay-mp',0,'2088012991844651',''),(563,298190799,'alipay-mp',0,'2088002781425872',''),(564,298190799,'alipay-mp',0,'2088002010168295',''),(565,298190799,'alipay-mp',0,'2088922302836744',''),(566,298190799,'alipay-mp',0,'2088612470522032',''),(567,298190799,'alipay-mp',33,'2088722331739854',''),(568,298190799,'alipay-mp',0,'2088102919553810',''),(569,298190799,'alipay-mp',0,'2088002351109995',''),(570,298190799,'alipay-mp',0,'2088002921089661',''),(571,298190799,'alipay-mp',0,'2088802599904716',''),(572,298190799,'alipay-mp',0,'2088002015041652',''),(573,298190799,'alipay-mp',0,'2088802256682384',''),(574,298190799,'alipay-mp',0,'2088002000564520',''),(575,298190799,'alipay-mp',0,'2088912740571877',''),(576,298190799,'alipay-mp',0,'2088022374115195',''),(577,298190799,'alipay-mp',0,'2088602340816510',''),(578,298190799,'alipay-mp',0,'2088802847793482',''),(579,298190799,'alipay-mp',0,'2088112434954612',''),(580,298190799,'alipay-mp',0,'2088702791452670',''),(581,298190799,'alipay-mp',0,'2088302997993412',''),(582,298190799,'wechat-mp',0,'oernD4vrNBKvHtbY1oPgl4EBzmiM','KB9RW97JHlYEq1lPXfLLYQ=='),(583,298190799,'alipay-mp',0,'2088932554195485',''),(584,298190799,'alipay-mp',0,'2088802287905797',''),(585,298190799,'alipay-mp',0,'2088802143178842',''),(586,298190799,'alipay-mp',0,'2088002309391346',''),(587,298190799,'alipay-mp',0,'2088612031411706',''),(588,298190799,'alipay-mp',0,'2088532636835319',''),(589,298190799,'alipay-mp',0,'2088002008909130',''),(590,298190799,'alipay-mp',0,'2088002956933164',''),(591,298190799,'alipay-mp',0,'2088532353563845',''),(592,298190799,'alipay-mp',0,'2088202198279187',''),(593,298190799,'alipay-mp',0,'2088222633861571',''),(594,298190799,'alipay-mp',0,'2088002190557852',''),(595,298190799,'alipay-mp',0,'2088002582361865',''),(596,298190799,'alipay-mp',0,'2088632496823531',''),(597,298190799,'alipay-mp',0,'2088032299608483',''),(598,298190799,'alipay-mp',0,'2088312354823119',''),(599,298190799,'alipay-mp',0,'2088422420653527',''),(600,298190799,'alipay-mp',0,'2088002009544693',''),(601,298190799,'alipay-mp',0,'2088802312180771',''),(602,298190799,'wechat-mp',0,'oernD4pbopV7cGKhiXRESNhKDwCs','sO/2oBjjCa0WTxFvhDpUsQ=='),(603,298190799,'alipay-mp',34,'2088822593976728',''),(604,298190799,'wechat-mp',34,'oernD4tALKFHNNCw1LC3vLm2OtvE','W+dMysac46iNwfgL92Lpzg=='),(605,298190799,'alipay-mp',0,'2088422827520323',''),(606,298190799,'alipay-mp',0,'2088522209999681',''),(607,298190799,'alipay-mp',0,'2088522431223972',''),(608,298190799,'wechat-mp',0,'oernD4uK2umVc0SfJ0ok-DxBweM0','pU8h4jDYQ+zk2Ki2AOqmdA=='),(609,298190799,'alipay-mp',0,'2088002039890579',''),(610,298190799,'alipay-mp',0,'2088902479009468',''),(611,298190799,'wechat-mp',0,'oernD4n026wcdGm5BDCFVJkfCdaE','t1jtrMWLpcbA0n49U+LSjw=='),(612,298190799,'alipay-mp',0,'2088022298070897',''),(613,298190799,'alipay-mp',0,'2088002405183045',''),(614,298190799,'alipay-mp',35,'2088422846007265',''),(615,298190799,'alipay-mp',0,'2088002044893901',''),(616,298190799,'alipay-mp',0,'2088112053536776',''),(617,298190799,'alipay-mp',0,'2088002060999324',''),(618,298190799,'alipay-mp',0,'2088802568936122',''),(619,298190799,'alipay-mp',0,'2088022307067997',''),(620,298190799,'alipay-mp',0,'2088132810805897',''),(621,298190799,'alipay-mp',0,'2088922742022275',''),(622,298190799,'alipay-mp',0,'2088312014623921',''),(623,298190799,'alipay-mp',0,'2088302579281605',''),(624,298190799,'alipay-mp',0,'2088212885283870',''),(625,298190799,'wechat-mp',0,'oernD4k4Xr7iCCek13LxMTTfiQgw','3Jm0QszLTeCQoJDStkZhSA=='),(626,298190799,'alipay-mp',0,'2088822421362468',''),(627,298190799,'alipay-mp',0,'2088602090814484',''),(628,298190799,'wechat-mp',0,'oernD4muyQ15osN3kezVtcPItF7s','RnympdixTyF++0v3G5fuHQ=='),(629,298190799,'alipay-mp',0,'2088522299507632',''),(630,298190799,'wechat-mp',0,'oernD4k7YcxUmBjGs-h74MNYwnDM','6EcLx1ltXtD6iaN3OGmTsQ=='),(631,298190799,'alipay-mp',0,'2088002346496802',''),(632,298190799,'alipay-mp',0,'2088102564561051',''),(633,298190799,'alipay-mp',0,'2088202766923135',''),(634,298190799,'wechat-mp',0,'oernD4mFfEQkP-PpePFabXbSWBnI','Kps3xumtPmO/i69oj13q2g=='),(635,298190799,'wechat-mp',0,'oernD4vgF0sHkGym5dnXa67FrjCo','3WX/Yw1AMC65V/CEJ5rGjg=='),(636,298190799,'alipay-mp',0,'2088102538192913',''),(637,298190799,'wechat-mp',0,'oernD4ix2pMLW22aWZLTK3K3P7Sg','wZEyWqAzAw2j116qT9I4JA=='),(638,298190799,'alipay-mp',0,'2088812195377490',''),(639,298190799,'wechat-mp',0,'oernD4sPBCsju5J-Q1nGpHmnJ1qU','RtJfyfO7d6TcvAbrAOGoTw=='),(640,298190799,'wechat-mp',0,'oernD4v38uaQQa_qRd10UtR4CezQ','YkbYMeC1xY7SJlvNgElKlg=='),(641,298190799,'alipay-mp',0,'2088922547524952',''),(642,298190799,'alipay-mp',0,'2088241465989541',''),(643,298190799,'alipay-mp',0,'2088022667187724',''),(644,298190799,'alipay-mp',0,'2088922295146060',''),(645,298190799,'alipay-mp',0,'2088002121988487',''),(646,298190799,'alipay-mp',0,'2088402394115593',''),(647,298190799,'alipay-mp',0,'2088002314294283',''),(648,298190799,'wechat-mp',36,'oernD4vk0V1HNhl04rYJZ3J1pXI8','KSXs3GMhXZm6Bgd6WubbPg=='),(649,298190799,'wechat-mp',0,'oernD4roN9i3ToYu0o-dqgdDWHGo','gxv/LZILreKTlVl85gUqSg=='),(650,298190799,'wechat-mp',0,'oernD4t0G7OvirArOTxs6PPvj5R8','RwdebSR79XIlvZHgPjlbpA=='),(651,298190799,'wechat-mp',0,'oernD4shreASEW06S5nyOlLKd7os','rUjDKna/7o3GrZbV9v81og=='),(652,298190799,'alipay-mp',0,'2088002317700031',''),(653,298190799,'wechat-mp',0,'oernD4l41yjLP2SFurMq0W-LtrBo','VH7gc3tgoxdCDOvWFivnHg=='),(654,298190799,'wechat-mp',37,'oernD4tiRwxSfD4JUhGRG8woyV1c','hTePFmqYBmxw5IJFClK7Jg=='),(655,298190799,'alipay-mp',0,'2088912666073659',''),(656,298190799,'alipay-mp',0,'2088802696011607',''),(657,298190799,'alipay-mp',0,'2088602320377664',''),(658,298190799,'alipay-mp',0,'2088722896563080',''),(659,298190799,'alipay-mp',0,'2088222126732793',''),(660,298190799,'alipay-mp',0,'2088532019710228',''),(661,298190799,'wechat-mp',0,'oernD4nyjeNkL2yWv979ExQJE03o','gLdrN6MwPmPjpGdTr5SI9g=='),(662,298190799,'alipay-mp',0,'2088002393901054',''),(663,298190799,'alipay-mp',0,'2088802291398154',''),(664,298190799,'wechat-mp',0,'oernD4ix7j9qI5rj-Dh519kbiB-s','1KvbILdNX6sNET19bitHtg=='),(665,298190799,'alipay-mp',0,'2088012516172034',''),(666,298190799,'wechat-mp',0,'oernD4lKxZ7LPt6RG0wDfEDu2fD0','khFIEtn5he5T5KDrswLKvQ=='),(667,298190799,'alipay-mp',0,'2088902346266082',''),(668,298190799,'alipay-mp',0,'2088002406292759',''),(669,298190799,'alipay-mp',0,'2088502550154984',''),(670,298190799,'wechat-mp',0,'oernD4hW9LzQkgxkPEofGZksqwqQ','Jqb/zepEU5FR7/9LAJN+/w=='),(671,298190799,'alipay-mp',0,'2088502601933045',''),(672,298190799,'alipay-mp',0,'2088912110474179',''),(673,298190799,'alipay-mp',0,'2088142816724010',''),(674,298190799,'wechat-mp',0,'oernD4mCqOa7RJ3Dm_zasvRx9QpU','4+Gpd6UKTEWGU0uNR+F1uA=='),(675,298190799,'wechat-mp',0,'oernD4syK8f_49Qe7f0Revgn33Eg','umvhwYvtd35wPTO21yybTg=='),(676,298190799,'alipay-mp',0,'2088902621501705',''),(677,298190799,'alipay-mp',0,'2088002973407907',''),(678,298190799,'alipay-mp',38,'2088522023122292',''),(679,298190799,'alipay-mp',0,'2088112511281358',''),(680,298190799,'alipay-mp',0,'2088112095918701',''),(681,298190799,'alipay-mp',0,'2088002489902411',''),(682,298190799,'alipay-mp',0,'2088002314294632',''),(683,298190799,'alipay-mp',0,'2088112444375681',''),(684,298190799,'alipay-mp',0,'2088902619585708',''),(685,298190799,'alipay-mp',0,'2088002010051252',''),(686,298190799,'alipay-mp',0,'2088112168250020',''),(687,298190799,'alipay-mp',0,'2088212513330352',''),(688,298190799,'alipay-mp',0,'2088102098266442',''),(689,298190799,'alipay-mp',0,'2088902174395860',''),(690,298190799,'alipay-mp',0,'2088502841036269',''),(691,298190799,'alipay-mp',0,'2088912110992352',''),(692,298190799,'alipay-mp',0,'2088002318812331',''),(693,298190799,'alipay-mp',0,'2088002587175632',''),(694,298190799,'alipay-mp',0,'2088702235492185',''),(695,298190799,'alipay-mp',0,'2088202570169884',''),(696,298190799,'alipay-mp',0,'2088102056798501',''),(697,298190799,'alipay-mp',0,'2088002304101744',''),(698,298190799,'alipay-mp',0,'2088522456130585',''),(699,298190799,'alipay-mp',0,'2088012787347669',''),(700,298190799,'alipay-mp',0,'2088702126316006',''),(701,298190799,'alipay-mp',0,'2088002433227955',''),(702,298190799,'wechat-mp',0,'oernD4iwSocSZn4va4QFI8rFF-Qc','bvg1EiQkA988YYMu7TsxVA=='),(703,298190799,'wechat-mp',0,'oernD4iEXy-W5m0HN6OJ5EpbT1W8','xaNpXGhNuFwQH+y2Cl5BoA=='),(704,298190799,'alipay-mp',0,'2088032850418692',''),(705,298190799,'wechat-mp',39,'oernD4p2Gj8XZ2BdvTSHKngyCaJA','JlqQ4ZJynKFBgPopRjBVyg=='),(706,298190799,'alipay-mp',0,'2088102922210100',''),(707,298190799,'alipay-mp',0,'2088502781591204',''),(708,298190799,'alipay-mp',0,'2088412453777671',''),(709,298190799,'wechat-mp',0,'oernD4gkvzja4VP7S3A3D8yGrxHo','TcG3I8rXd76X38EG7xK4Lw=='),(710,298190799,'alipay-mp',0,'2088102336310252',''),(711,298190799,'wechat-mp',0,'oernD4m9-5vzpAww_9Z98JZViU1g','HKArz6vMoYmN20dKRUtAVw=='),(712,298190799,'wechat-mp',40,'oernD4k07vQPepGPmCEHtAyi8lJo','X/TkwzA99d1db6KyGCTCHw=='),(713,298190799,'wechat-mp',0,'oernD4qaFKT-GoP0qupKpx4eNXDg','PCfEez/QAVc9zySaAqQ51Q=='),(714,298190799,'alipay-mp',0,'2088032611353390',''),(715,298190799,'wechat-mp',0,'oernD4nkCl1J3XLQVgggjSQxUBPA','aWCi0AQoe3UH6OyAIkb/ZQ=='),(716,298190799,'alipay-mp',0,'2088202823145803',''),(717,298190799,'wechat-mp',0,'oernD4rkHY-zxAY0mP2KPch9jUJU','R+H4YDQOMtNuI79Ym9w/6Q=='),(718,298190799,'alipay-mp',0,'2088302367465457',''),(719,298190799,'alipay-mp',0,'2088222441693322',''),(720,298190799,'alipay-mp',0,'2088532939014381',''),(721,298190799,'alipay-mp',0,'2088222916213608',''),(722,298190799,'wechat-mp',0,'oernD4mSDKUB97zOZkLBPGswYB1Q','kLo5jIbnppES9WoVt+oWkA=='),(723,298190799,'alipay-mp',0,'2088012108921103','');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
INSERT INTO `cmf_user` VALUES (1,0,0,0,1622021319,0,0,0,0.000000,0,0,0,1,'','','','','','','https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epTLLaOTYK4DgjicC49BeicXVk2F0MHTnt0iaWib46faOe2rkjXX56AMyYvsxCiav7XGRFKI6lkwWH8Clw/132','','127.0.0.1','','15269630147','',298190799),(2,0,0,0,1622021703,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','15357363513','',298190799),(3,0,0,0,1622252627,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','17717280559','',298190799),(4,0,0,0,1623053551,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','15161178722','',298190799),(5,0,0,0,1622024700,0,0,0,0.000000,0,0,0,1,'','','','','','','https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqWQpJ1xMMKEXicInK1OmSOdVdTLCOYYysw3tibMwxtnickRcllN5pMQL2Db8JkfO4WpG3Vq2ibn9ukVQ/132','','127.0.0.1','','18321277411','',298190799),(6,0,0,0,1627968677,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','17625458589','',298190799),(7,0,0,0,1622171884,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','17621690560','',298190799),(8,0,0,0,1622178837,0,0,0,0.000000,0,0,0,1,'','','','','','','https://tfs.alipayobjects.com/images/partner/T1gKRuXjheXXXXXXXX','','127.0.0.1','','13918521433','',298190799),(9,0,0,0,1622992882,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','15770688196','',298190799),(10,0,0,0,1622285906,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','13016978898','',298190799),(11,0,0,0,1622429952,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','15773281057','',298190799),(12,0,0,0,1623076645,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','17768227810','',298190799),(13,0,0,0,1623315211,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','18570747429','',298190799),(14,0,0,0,1624850085,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','13453701221','',298190799),(15,0,0,0,1624959346,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','13703113101','',298190799),(16,0,0,0,1625026736,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','18688879566','',298190799),(17,0,0,0,1626928679,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','13802943054','',298190799),(18,0,0,0,1626010482,0,0,0,0.000000,0,0,0,1,'','','','','','','','','127.0.0.1','','18818279706','',298190799),(19,0,0,0,1626248839,0,0,0,0.000000,1626248125,1626248125,0,1,'','','','','','','','','127.0.0.1','','17805595210','',298190799),(20,0,0,0,1626603417,0,0,0,0.000000,1626603358,1626603358,0,1,'','','','','','','','','127.0.0.1','','18818205870','',298190799),(21,0,0,0,1626611988,0,0,0,0.000000,1626611941,1626611941,0,1,'','','','','','','','','127.0.0.1','','15115057186','',298190799),(22,0,0,0,1626612018,0,0,0,0.000000,1626611954,1626611954,0,1,'','','','','','','','','127.0.0.1','','13026160084','',298190799),(23,0,0,0,1626775920,0,0,0,0.000000,1626775795,1626775795,0,1,'','','','','','','','','127.0.0.1','','13501991762','',298190799),(24,0,0,0,1626861850,0,0,0,0.000000,1626861795,1626861795,0,1,'','','','','','','','','127.0.0.1','','15317787783','',298190799),(25,0,0,0,1627027964,0,0,0,0.000000,0,0,0,1,'','','','','','','https://tfs.alipayobjects.com/images/partner/ATdN8ETaKPwpAAAAAAAAAAAAAADtl2AA','','127.0.0.1','','18779692741','',298190799),(26,0,0,0,1627030351,0,0,0,0.000000,1627030254,1627030254,0,1,'','','','','','','','','127.0.0.1','','18512155067','',298190799),(27,0,0,0,1627059563,0,0,0,0.000000,1627059542,1627059542,0,1,'','','','','','','','','127.0.0.1','','13190777725','',298190799),(28,0,0,0,1627106422,0,0,0,0.000000,1627106421,1627106421,0,1,'','','','','','','','','127.0.0.1','','13564357179','',298190799),(29,0,0,0,1627312046,0,0,0,0.000000,1627312045,1627312045,0,1,'','','','','','','','','127.0.0.1','','18773830790','',298190799),(30,0,0,0,1627540239,0,0,0,0.000000,1627540180,1627540180,0,1,'','','','','','','','','127.0.0.1','','13482260867','',298190799),(31,0,0,0,1630547605,0,0,0,0.000000,1627968721,1627968721,0,1,'','','','','','','','','127.0.0.1','','17069888880','',298190799),(32,0,0,0,1628447596,0,0,0,0.000000,1628447587,1628447587,0,1,'','','','','','','','','127.0.0.1','','15027937385','',298190799),(33,0,0,0,1628669338,0,0,0,0.000000,1628577982,1628577982,0,1,'','','','','','','','','127.0.0.1','','18531189961','',298190799),(34,0,0,0,1629137507,0,0,0,0.000000,1629135207,1629135504,0,1,'','','','','','','','','127.0.0.1','','15729573615','',298190799),(35,0,0,0,1629619384,0,0,0,0.000000,1629619383,1629619383,0,1,'','','','','','','','','127.0.0.1','','18368312535','',298190799),(36,0,0,0,1630926904,0,0,0,0.000000,1630926904,1630926904,0,1,'','','','','','','','','127.0.0.1','','13765226489','',298190799),(37,0,0,0,1631334845,0,0,0,0.000000,1631334775,1631334775,0,1,'','','','','','','','','127.0.0.1','','13432753683','',298190799),(38,0,0,0,1632737524,0,0,0,0.000000,1632737523,1632737523,0,1,'','','','','','','','','127.0.0.1','','17891860466','',298190799),(39,0,0,0,1633194396,0,0,0,0.000000,1633194395,1633194395,0,1,'','','','','','','','','127.0.0.1','','18392714452','',298190799),(40,0,0,0,1633940733,0,0,0,0.000000,1633940733,1633940733,0,1,'','','','','','','','','127.0.0.1','','15181623937','',298190799);
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
-- Dumping events for database 'tenant_1442096236'
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-29 21:33:04' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-29 21:33:04' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card SET status = -1 WHERE end_at between 0 AND UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-29 21:33:02' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderFinishStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-29 21:33:02' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > appointment_at + 43200 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `rechargeOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-29 21:33:04' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_recharge_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucher` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-29 21:33:04' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher SET status = 2 WHERE UNIX_TIMESTAMP(publish_end_time) < UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucherPost` ON SCHEDULE EVERY 1 SECOND STARTS '2021-07-29 21:33:04' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher_post SET status = 2 WHERE valid_end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tenant_1442096236'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:04:54
