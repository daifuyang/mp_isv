-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: tenant_1452774253
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
-- Current Database: `tenant_1452774253`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tenant_1452774253` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tenant_1452774253`;

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_menu`
--

LOCK TABLES `cmf_admin_menu` WRITE;
/*!40000 ALTER TABLE `cmf_admin_menu` DISABLE KEYS */;
INSERT INTO `cmf_admin_menu` VALUES (1,'app/dashboard',0,'工作台','/app/:mid/dashboard','icondashboard',0,1),(2,'app/published',0,'小程序','/app/:mid/published','iconmp',0,1),(3,'app/published/dashboard',2,'小程序总览','/app/:mid/published/dashboard','',0,1),(4,'app/published/weixin',2,'微信小程序','/app/:mid/published/weixin','',0,2),(5,'app/published/alipay',2,'支付宝小程序','/app/:mid/published/alipay','',0,3),(6,'app/order/default',0,'订单管理','/app/:mid/order/default','icondetail',0,2),(7,'app/order/business',6,'业务订单','/app/:mid/order/business','',0,10000),(8,'app/order/business/list',7,'订单列表','/app/:mid/order/business/list','',1,1),(9,'app/order/business/id',7,'订单详情','/app/:mid/order/business/:id','',1,1),(10,'app/order/member',6,'会员订单','/app/:mid/order/member','',0,10000),(11,'app/order/recharge',6,'储值订单','/app/:mid/order/coupon','',0,10000),(12,'app/dishes',0,'菜单管理','/app/:mid/dishes','iconappstore',0,3),(13,'app/dishes/goods',12,'菜品管理','/app/:mid/dishes/goods','',0,10000),(14,'app/dishes/goods/index',13,'菜品列表','/app/:mid/dishes/goods/index','',1,10000),(15,'app/dishes/goods/add',13,'添加菜品','/app/:mid/dishes/goods/add','',1,10000),(16,'app/dishes/goods/edit',13,'编辑菜品','/app/:mid/dishes/goods/edit','',1,10000),(17,'app/dishes/category',12,'分类管理','/app/:mid/dishes/category','',0,10000),(18,'app/desk/default',0,'桌位管理','/app/:mid/desk/default','iconapartment',0,4),(19,'app/desk/index',18,'桌位管理','/app/:mid/desk/index','',0,10000),(20,'app/desk/category',18,'桌位类型','/app/:mid/desk/category','',0,10000),(21,'app/member/default',0,'会员管理','/app/:mid/member/default','iconcreditcard',0,5),(22,'app/member/index',21,'用户列表','/app/:mid/member/index','',0,10000),(23,'app/marketing',0,'营销管理','/app/:mid/marketing','icongift',0,70),(24,'app/marketing/card',23,'会员卡设置','/app/:mid/marketing/card','',0,10000),(25,'app/marketing/coupon',23,'优惠券管理','/app/:mid/marketing/coupon','',0,10000),(26,'app/marketing/recharge',23,'储值管理','/app/:mid/marketing/recharge','',0,10000),(27,'app/marketing/score',23,'积分设置','/app/:mid/marketing/score','',0,10000),(28,'app/theme/default',0,'主题管理','/app/:mid/theme/default','iconbg-colors',0,90),(29,'app/theme/index',28,'主题设置','/app/:mid/theme/index','',0,10),(30,'app/theme/assets',28,'素材中心','/app/:mid/theme/assets','',0,10000),(31,'portal/default',0,'门户管理','/app/:mid/portal','iconfolder-add',0,91),(32,'/app/portal/index',31,'文章管理','/app/:mid/portal/index','',0,10000),(33,'/app/portal/category',31,'分类管理','/app/:mid/portal/category','',0,10000),(34,'/app/portal/category/add',33,'添加分类','/app/:mid/portal/category/add','',1,10000),(35,'/app/portal/category/edit',33,'修改分类','/app/:mid/portal/category/edit/:id','',1,10000),(36,'app/store',0,'门店管理','/app/:mid/store','iconshop',0,92),(37,'app/store/index',36,'门店列表','/app/:mid/store/index','',0,10),(38,'app/store/add',37,'添加门店','/app/:mid/store/add','',1,10000),(39,'app/store/edit',37,'修改门店','/app/:mid/store/edit/:id','',1,10000),(40,'app/store/edit_for_here',37,'堂食设置','/app/:mid/store/edit_for_here/:id','',1,10000),(41,'app/store/edit_take_out',37,'外卖设置','/app/:mid/store/edit_take_out/:id','',1,10000),(42,'app/store/printer',36,'打印机绑定','/app/:mid/store/printer','',0,30),(43,'app/user',0,'账号管理','/app/:mid/user','iconuser',0,100),(44,'app/user/settings',43,'个人设置','/app/:mid/user/settings','',1,1),(45,'app/user/index',43,'账号设置','/app/:mid/user/index','',0,1),(46,'app/user/add',45,'添加管理员','/app/:mid/user/add','',1,10000),(47,'app/user/edit',45,'编辑管理员','/app/:mid/user/edit/:id','',1,10000),(48,'app/user/role',43,'角色设置','/app/:mid/user/role','',0,10000),(49,'app/user/authorize/add',48,'角色权限添加','app/:mid/user/authorize/add','',1,10000),(50,'app/user/authorize/edit',48,'角色权限编辑','/app/:mid/user/authorize/edit/:id','',1,10000),(51,'app/settings',0,'系统设置','/app/:mid/settings','iconsetting',0,110),(52,'app/settings/index',51,'通用设置','/app/:mid/settings/index','',0,10000),(53,'app/settings/contact',51,'客服设置','/app/:mid/settings/contact','',0,10000),(54,'app/settings/logistics',51,'物流设置','/app/:mid/settings/logistics','',0,10000),(55,'app/notice',0,'消息通知','/app/:mid/notice','',1,10000),(56,'app/notice/list',55,'消息列表','/app/:mid/notice/list','',0,10000),(57,'app/store/edit_take_out',37,'外卖设置','/app/:mid/store/edit_take_out/:id','',1,10000),(58,'app/store/printer',36,'打印机绑定','/app/:mid/store/printer','',0,30),(59,'app/user',0,'账号管理','/app/:mid/user','iconuser',0,100),(60,'app/user/settings',59,'个人设置','/app/:mid/user/settings','',1,1),(61,'app/user/index',59,'账号设置','/app/:mid/user/index','',0,1),(62,'app/user/add',61,'添加管理员','/app/:mid/user/add','',1,10000),(63,'app/user/edit',61,'编辑管理员','/app/:mid/user/edit/:id','',1,10000),(64,'app/user/role',59,'角色设置','/app/:mid/user/role','',0,10000),(65,'app/user/authorize/add',64,'角色权限添加','app/:mid/user/authorize/add','',1,10000),(66,'app/user/authorize/edit',64,'角色权限编辑','/app/:mid/user/authorize/edit/:id','',1,10000),(67,'app/settings',0,'系统设置','/app/:mid/settings','iconsetting',0,110),(68,'app/settings/index',67,'通用设置','/app/:mid/settings/index','',0,10000),(69,'app/settings/contact',67,'客服设置','/app/:mid/settings/contact','',0,10000),(70,'app/settings/logistics',67,'物流设置','/app/:mid/settings/logistics','',0,10000),(71,'app/notice',0,'消息通知','/app/:mid/notice','',1,10000),(72,'app/notice/list',71,'消息列表','/app/:mid/notice/list','',0,10000),(73,'app/user',0,'账号管理','/app/:mid/user','iconuser',0,100),(74,'app/user/settings',73,'个人设置','/app/:mid/user/settings','',1,1);
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
INSERT INTO `cmf_admin_user` VALUES (1,0,0,1618043749,0,0,1,'13042159397','3ffc0ef0ced4e6824cc61b5afdedcff4','13042159397','','','','','13042159397','');
/*!40000 ALTER TABLE `cmf_admin_user` ENABLE KEYS */;
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
  `file_key` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件惟一码',
  `remark_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件备注名',
  `file_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件索引名',
  `file_path` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `suffix` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件后缀',
  `type` tinyint(3) NOT NULL COMMENT '资源类型',
  `more` text COLLATE utf8mb4_general_ci COMMENT '更多配置',
  `mid` int(11) NOT NULL COMMENT '小程序加密编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,243356,1618043924,1,'9ae8f296-ecd1-495c-76a7-61c95bed89b6','家家香.jpeg','47b9d1c748902316f07a8433f4cb0caf.jpeg','default/20210410/47b9d1c748902316f07a8433f4cb0caf.jpeg','jpeg',0,'',0),(2,1,243356,1618119288,1,'4866d47d-813a-45e3-4991-21b9fb208695','家家香.jpeg','5de8bf9cc11a077181ba19d784ccdfe6.jpeg','tenant/1204449344/20210411/5de8bf9cc11a077181ba19d784ccdfe6.jpeg','jpeg',0,'',1204449344),(3,1,49493,1618123086,1,'1dc6f159-81d1-4c64-5aa2-93d020cbbf89','农家手抓骨.jpg','28317442e3a404db2e20e0af43e1483b.jpg','tenant/1204449344/20210411/28317442e3a404db2e20e0af43e1483b.jpg','jpg',0,'',1204449344),(4,1,4852242,1618124054,1,'ebba49d0-fb40-417b-5837-e8a5d6fb0087','手抓骨.png','e0dae14c5138449b978536056f755eb0.png','tenant/1204449344/20210411/e0dae14c5138449b978536056f755eb0.png','png',0,'',1204449344),(5,1,53279,1618147702,1,'02f2b201-02bf-406a-6e7d-b31e7c52a5d2','酸辣海带丝.jpg','7384112562b850b3aed257648e82e809.jpg','tenant/1204449344/20210411/7384112562b850b3aed257648e82e809.jpg','jpg',0,'',1204449344),(6,1,412132,1618147848,1,'b3274032-12af-4887-44c0-83f6bb814488','夫妻肺片.jpg','f88b05f5623555581bb6210163185098.jpg','tenant/1204449344/20210411/f88b05f5623555581bb6210163185098.jpg','jpg',0,'',1204449344),(7,1,34932,1618148246,1,'f6f82f05-e603-4cad-7885-2b4c0438ff4f','皮蛋豆腐.jpg','eca68fb8d0769d50efed8fee0e3db924.jpg','tenant/1204449344/20210411/eca68fb8d0769d50efed8fee0e3db924.jpg','jpg',0,'',1204449344),(8,1,61090,1618149393,1,'4ccb1a5c-2e11-4595-41a6-b829dd0abea4','萝卜皮.jpeg','fb67ceac404855582c14f7c2635cd749.jpeg','tenant/1204449344/20210411/fb67ceac404855582c14f7c2635cd749.jpeg','jpeg',0,'',1204449344),(9,1,203725,1618149546,1,'13481c6a-0ee7-4c58-511a-b84589882748','盐水花生.jpg','457f2f2cb2879e3b2d36686fd04a2308.jpg','tenant/1204449344/20210411/457f2f2cb2879e3b2d36686fd04a2308.jpg','jpg',0,'',1204449344),(10,1,36068,1618150444,1,'180fa9e3-1960-46fc-7654-c4605f7a0dcb','剁椒皮蛋.jpg','5a7ebea56202d698dd5dde4643de908d.jpg','tenant/1204449344/20210411/5a7ebea56202d698dd5dde4643de908d.jpg','jpg',0,'',1204449344),(11,1,17007,1618150660,1,'466ce663-af67-4732-6da2-e1f215812b45','红枣莲心.jpg','7d1748c4103e146dfa393d67a62386ea.jpg','tenant/1204449344/20210411/7d1748c4103e146dfa393d67a62386ea.jpg','jpg',0,'',1204449344),(12,1,548546,1618151009,1,'cc255a0b-08d9-435b-7f09-c59f25f50b26','盐水毛豆.jpg','4a26aaeee2fefa0901c562de0c09d58a.jpg','tenant/1204449344/20210411/4a26aaeee2fefa0901c562de0c09d58a.jpg','jpg',0,'',1204449344),(13,1,1828058,1618151234,1,'bf4546fc-1c20-4a11-5e89-44c0b5acbd1c','口水鸡.jpg','5a3ed1f473b308940307776f373f47a9.jpg','tenant/1204449344/20210411/5a3ed1f473b308940307776f373f47a9.jpg','jpg',0,'',1204449344),(14,1,299977,1618151324,1,'29c7e7ca-34c4-4764-6bc8-c04dfb2c4bf8','麻辣黑凤爪.jpg','70547068f5bb445fd24d1e7d1e62a3b4.jpg','tenant/1204449344/20210411/70547068f5bb445fd24d1e7d1e62a3b4.jpg','jpg',0,'',1204449344),(15,1,78831,1618151884,1,'bccad13d-766b-4556-570f-11b22697f1ff','糖醋小排.jpeg','7a23c96d9bee57a53e751c9d4681e338.jpeg','tenant/1204449344/20210411/7a23c96d9bee57a53e751c9d4681e338.jpeg','jpeg',0,'',1204449344),(16,1,50544,1618152395,1,'b8e66f00-9d54-42ec-6c3d-b53759840d47','海藻.jpg','eff48fb94558dd843331c8b98a558f39.jpg','tenant/1204449344/20210411/eff48fb94558dd843331c8b98a558f39.jpg','jpg',0,'',1204449344),(17,1,104384,1618152491,1,'faa46a16-40a1-4662-5333-18459fbfdf39','白斩鸡.jpg','a823754a1a41343d5d3791cad21b8ac0.jpg','tenant/1204449344/20210411/a823754a1a41343d5d3791cad21b8ac0.jpg','jpg',0,'',1204449344),(18,1,158611,1618386862,1,'a8a82d6f-f395-46e6-60e8-d8714ea1dc89','家家香banner.png','f0ead4539e0711c69bc4ec973670c3fc.png','tenant/1204449344/20210414/f0ead4539e0711c69bc4ec973670c3fc.png','png',0,'',1204449344),(19,1,565243,1618387259,1,'ce621dd8-0950-4d81-7bb4-14f30a153828','自定义模板.png','a912b9bdf04febc8a8d3d3dc266a7040.png','tenant/1204449344/20210414/a912b9bdf04febc8a8d3d3dc266a7040.png','png',0,'',1204449344),(20,1,549910,1618388044,1,'593aee04-6bb0-4b23-7cfc-51e485c4fccc','餐饮美食_家常菜菜单_中国风_宣传单.jpg','291069255ee2d6268a5c752597a56908.jpg','tenant/1204449344/20210414/291069255ee2d6268a5c752597a56908.jpg','jpg',0,'',1204449344),(21,1,266408,1618388322,1,'42095038-ff99-4ff8-604a-19bae2a76ff1','防疫餐饮外卖接单公众号首图.jpg','3a279d95d3d756a28fdf0d92520b245e.jpg','tenant/1204449344/20210414/3a279d95d3d756a28fdf0d92520b245e.jpg','jpg',0,'',1204449344),(22,1,31504,1618389699,1,'16658126-2b24-4a84-599a-f3c26f317fb3','waimai.png','4d50f4455fadc7138e13de4bb19db240.png','tenant/1204449344/20210414/4d50f4455fadc7138e13de4bb19db240.png','png',0,'',1204449344),(23,1,555661,1618390039,1,'6ba985cb-1b2e-4209-5121-161e05b0ec5f','餐饮美食_家常菜菜单_中国风_宣传单 (1).jpg','13bb3182da18090597eadfae2c570e13.jpg','tenant/1204449344/20210414/13bb3182da18090597eadfae2c570e13.jpg','jpg',0,'',1204449344),(24,1,30580,1618393243,1,'e3a8a13e-c1f1-49f9-4757-50b2e44f9cdd','10611618390679_.pic_hd.jpg','70b33a88cd9d7f1e1af27ccfd5b315bf.jpg','tenant/1204449344/20210414/70b33a88cd9d7f1e1af27ccfd5b315bf.jpg','jpg',0,'',1204449344),(25,1,15603,1618393248,1,'1630110f-0889-4c57-4ba4-8717d3475de3','10721618390836_.pic_hd.jpg','06201b2a63e73cfcfacb21440f25230c.jpg','tenant/1204449344/20210414/06201b2a63e73cfcfacb21440f25230c.jpg','jpg',0,'',1204449344),(26,1,19164,1618393632,1,'15564b2c-c667-46db-71c1-c0fd3f6ac327','code-fill.png','09b3d757254a5d9cd89e3d12c12b5473.png','tenant/1204449344/20210414/09b3d757254a5d9cd89e3d12c12b5473.png','png',0,'',1204449344),(27,1,16836,1618393898,1,'1684a917-ef16-401a-4521-39d0e3179e45','code-fill副本.png','33ffb9de1b2e8e32b49f70fc72e12735.png','tenant/1204449344/20210414/33ffb9de1b2e8e32b49f70fc72e12735.png','png',0,'',1204449344),(28,1,243356,1618465891,1,'b5400662-0971-47ef-470a-f590a77f029e','家家香.jpeg','f629572072d24648c372b7dad579bf8f.jpeg','tenant/1204449344/20210415/f629572072d24648c372b7dad579bf8f.jpeg','jpeg',0,'',1204449344),(29,1,13867,1618466078,1,'7cc7ada7-335d-4c5a-4b0c-0adf059ad2c3','logo.png','86585bfd4c9287c37406e09e533a19d3.png','tenant/1204449344/20210415/86585bfd4c9287c37406e09e533a19d3.png','png',0,'',1204449344),(30,1,12161,1618467138,1,'2db79836-d121-445f-7cdd-1012bf194ee3','logo.png','d73c74e180918cd0c37d90e552e2d779.png','tenant/1204449344/20210415/d73c74e180918cd0c37d90e552e2d779.png','png',0,'',1204449344),(31,1,1635573,1618467565,1,'e74d6c6c-593a-4ae9-6dda-f58b1a663d2a','家家香.png','bfe39e7dbd9beca5c1042f1ef867cee2.png','tenant/1204449344/20210415/bfe39e7dbd9beca5c1042f1ef867cee2.png','png',0,'',1204449344);
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
INSERT INTO `cmf_auth_rule` VALUES (1,'app/dashboard','','',1),(2,'app/published/dashboard','','',1),(3,'app/published/weixin','','',1),(4,'app/published/alipay','','',1),(5,'app/published','','',1),(6,'app/order/business/list','','',1),(7,'app/order/business/id','','',1),(8,'app/order/business','','',1),(9,'app/order/member','','',1),(10,'app/order/recharge','','',1),(11,'app/order/default','','',1),(12,'app/dishes/goods/index','','',1),(13,'app/dishes/goods/add','','',1),(14,'app/dishes/goods/edit','','',1),(15,'app/dishes/goods','','',1),(16,'app/dishes/category','','',1),(17,'app/dishes','','',1),(18,'app/desk/index','','',1),(19,'app/desk/category','','',1),(20,'app/desk/default','','',1),(21,'app/member/index','','',1),(22,'app/member/default','','',1),(23,'app/marketing/card','','',1),(24,'app/marketing/coupon','','',1),(25,'app/marketing/recharge','','',1),(26,'app/marketing/score','','',1),(27,'app/marketing','','',1),(28,'app/theme/index','','',1),(29,'app/theme/assets','','',1),(30,'app/theme/default','','',1),(31,'/app/portal/index','','',1),(32,'/app/portal/category/add','','',1),(33,'/app/portal/category/edit','','',1),(34,'/app/portal/category','','',1),(35,'portal/default','','',1),(36,'app/store/add','','',1),(37,'app/store/edit','','',1),(38,'app/store/edit_for_here','','',1),(39,'app/store/edit_take_out','','',1),(40,'app/store/index','','',1),(41,'app/store/printer','','',1),(42,'app/store','','',1),(43,'app/user/settings','','',1),(44,'app/user/add','','',1),(45,'app/user/edit','','',1),(46,'app/user/index','','',1),(47,'app/user/role/list','','',1),(48,'app/user/role/edit','','',1),(49,'app/user/role/delete','','',1),(50,'app/user/authorize/add','','',1),(51,'app/user/authorize/edit','','',1),(52,'app/user/role','','',1),(53,'app/user','','',1),(54,'app/settings/index','','',1),(55,'app/settings/contact','','',1),(56,'app/settings/logistics','','',1),(57,'app/settings','','',1),(58,'app/notice/list','','',1),(59,'app/notice','','',1);
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
  `store_id` int(11) NOT NULL COMMENT '门店id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food`
--

LOCK TABLES `cmf_food` WRITE;
/*!40000 ALTER TABLE `cmf_food` DISABLE KEYS */;
INSERT INTO `cmf_food` VALUES (1,'1204449344','','农家手抓骨','30元/斤',0,0,'[]',0,0.00,0,0.00,30.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/e0dae14c5138449b978536056f755eb0.png',0,1,'',1618327844,1618327844,0,0.5,'斤','','','',1,1,10000),(2,'1204449344','','香辣蟹','',0,1,'[{\"attr_key\":\"\",\"attr_val\":[]}]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,1,'',1618146852,1618146852,0,0.5,'份','','','',1,1,10000),(3,'1204449344','','牛蛙鱼','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,1,'',1618147022,1618147022,0,0.5,'份','','','',1,1,10000),(4,'1204449344','','排骨虾','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,1,'',1618147038,1618147038,0,0.5,'份','','','',1,1,10000),(5,'1204449344','','馋嘴牛蛙','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,1,'',1618147054,1618147054,0,0.5,'份','','','',1,1,10000),(6,'1204449344','','火爆肥肠','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,1,'',1618147070,1618147070,0,0.5,'份','','','',1,1,10000),(7,'1204449344','','一品虾','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,1,'',1618147130,1618147130,0,0.5,'份','','','',1,1,10000),(8,'1204449344','','鱼羊鲜','',0,0,'[]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,1,'',1618147197,1618147197,0,0.5,'份','','','',1,1,10000),(9,'1204449344','','孜然羊排','',0,0,'[]',0,0.00,0,0.00,98.00,0.00,-1,-1,0,1,'',0,1,'',1618147235,1618147235,0,0.5,'份','','','',1,1,10000),(10,'1204449344','','酸辣海带丝','',0,0,'[]',0,0.00,0,0.00,14.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/7384112562b850b3aed257648e82e809.jpg',0,0,'',1618147720,1618147720,0,0.5,'份','','','',1,1,10000),(11,'1204449344','','夫妻肺片','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/f88b05f5623555581bb6210163185098.jpg',0,0,'',1618147921,1618147921,0,0.3,'份','','','',1,1,10000),(12,'1204449344','','皮蛋豆腐','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/eca68fb8d0769d50efed8fee0e3db924.jpg',0,0,'',1618148271,1618148271,0,0.3,'份','','','',1,1,10000),(13,'1204449344','','蒜泥黄瓜','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'',0,0,'',1618148671,1618148671,0,0.3,'份','','','',1,1,10000),(14,'1204449344','','醋椒黑木耳','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'',0,0,'',1618148702,1618148702,0,0.3,'份','','','',1,1,10000),(15,'1204449344','','龙牙金针菇','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'',0,0,'',1618148866,1618148866,0,0.3,'份','','','',1,1,10000),(16,'1204449344','','炝花生','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'',0,0,'',1618148900,1618148900,0,0.3,'份','','','',1,1,10000),(17,'1204449344','','三文鱼刺身','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618148936,1618148936,0,0.3,'份','','','',1,1,10000),(18,'1204449344','','脆皮萝卜皮','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/fb67ceac404855582c14f7c2635cd749.jpeg',0,0,'',1618149420,1618149420,0,0.2,'份','','','',1,1,10000),(19,'1204449344','','盐水花生','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/457f2f2cb2879e3b2d36686fd04a2308.jpg',0,0,'',1618149657,1618149657,0,0.2,'份','','','',1,1,10000),(20,'1204449344','','剁椒皮蛋','',0,0,'[]',0,0.00,0,0.00,16.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/5a7ebea56202d698dd5dde4643de908d.jpg',0,0,'',1618150503,1618150503,0,0.2,'份','','','',1,1,10000),(21,'1204449344','','红枣莲心','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/7d1748c4103e146dfa393d67a62386ea.jpg',0,0,'',1618150681,1618150681,0,0.2,'份','','','',1,1,10000),(22,'1204449344','','水果色拉','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618150757,1618150757,0,0.2,'份','','','',1,1,10000),(23,'1204449344','','香茜鸡蛋干','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618150892,1618150892,0,0.2,'份','','','',1,1,10000),(24,'1204449344','','素鲍鱼','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618150936,1618150936,0,0.2,'份','','','',1,1,10000),(25,'1204449344','','盐水毛豆','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/4a26aaeee2fefa0901c562de0c09d58a.jpg',0,0,'',1618151022,1618151022,0,0.2,'份','','','',1,1,10000),(26,'1204449344','','泡椒藕带','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618151081,1618151081,0,0.2,'份','','','',1,1,10000),(27,'1204449344','','顺风耳片','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618151120,1618151120,0,0.2,'份','','','',1,1,10000),(28,'1204449344','','白切羊肉','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618151177,1618151177,0,0.2,'份','','','',1,1,10000),(29,'1204449344','','口水鸡','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/5a3ed1f473b308940307776f373f47a9.jpg',0,0,'',1618151260,1618151260,0,0.2,'份','','','',1,1,10000),(30,'1204449344','','麻辣黑凤爪','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/70547068f5bb445fd24d1e7d1e62a3b4.jpg',0,0,'',1618151341,1618151341,0,0.2,'份','','','',1,1,10000),(31,'1204449344','','老醋海蜇头','',0,0,'[]',0,0.00,0,0.00,35.00,0.00,-1,-1,0,1,'',0,0,'',1618151446,1618151446,0,0.2,'份','','','',1,1,10000),(32,'1204449344','','白切肚片','',0,0,'[]',0,0.00,0,0.00,42.00,0.00,-1,-1,0,1,'',0,0,'',1618151484,1618151484,0,0.2,'份','','','',1,1,10000),(33,'1204449344','','酱带鱼','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618151567,1618151567,0,0.2,'份','','','',1,1,10000),(34,'1204449344','','糟香门腔','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618151735,1618151735,0,0.2,'份','','','',1,1,10000),(35,'1204449344','','本帮熏鱼','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618151789,1618151789,0,0.2,'份','','','',1,1,10000),(36,'1204449344','','糖醋小排','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/7a23c96d9bee57a53e751c9d4681e338.jpeg',0,0,'',1618152075,1618152075,0,0.2,'份','','','',1,1,10000),(37,'1204449344','','家乡咸鸡','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618152112,1618152112,0,0.3,'份','','','',1,1,10000),(38,'1204449344','','滋味牛肉','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618152156,1618152156,0,0.3,'份','','','',1,1,10000),(39,'1204449344','','美味海藻','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/eff48fb94558dd843331c8b98a558f39.jpg',0,0,'',1618152410,1618152410,0,0.3,'份','','','',1,1,10000),(40,'1204449344','','白斩鸡','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'tenant/1204449344/20210411/a823754a1a41343d5d3791cad21b8ac0.jpg',0,0,'',1618152509,1618152509,0,0.3,'半只','','','',1,1,10000),(41,'1204449344','','腿筋骨炖玉米','',0,0,'[]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,0,'',1618319503,1618319503,0,500,'份','','','',1,1,10000),(42,'1204449344','','徽香臭桂鱼','',0,0,'[]',0,0.00,0,0.00,98.00,0.00,-1,-1,0,1,'',0,0,'',1618319549,1618319549,0,500,'份','','','',1,1,10000),(43,'1204449344','','蚕豆米扑鸡蛋','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618319585,1618319585,0,500,'份','','','',1,1,10000),(44,'1204449344','','牛鞭烧黄鳝','',0,0,'[]',0,0.00,0,0.00,118.00,0.00,-1,-1,0,1,'',0,0,'',1618319614,1618319614,0,500,'份','','','',1,1,10000),(45,'1204449344','','韵味雪菜肥肠','',0,0,'[]',0,0.00,0,0.00,66.00,0.00,-1,-1,0,1,'',0,0,'',1618319661,1618319661,0,300,'份','','','',1,1,10000),(46,'1204449344','','风味挂面圆子','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618319778,1618319778,0,300,'份','','','',1,1,10000),(47,'1204449344','','腊味合蒸','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618319814,1618319814,0,300,'份','','','',1,1,10000),(48,'1204449344','','富贵牛排','',0,0,'[]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,0,'',1618319853,1618319853,0,300,'份','','','',1,1,10000),(49,'1204449344','','咸鹅锅仔','',0,0,'[]',0,0.00,0,0.00,98.00,0.00,-1,-1,0,1,'',0,0,'',1618319907,1618319907,0,300,'份','','','',1,1,10000),(50,'1204449344','','甲鱼烧牛鞭','根据季节价格有异',0,0,'[]',0,0.00,0,0.00,128.00,0.00,-1,-1,0,1,'',0,0,'<p>根据季节价格有异</p>',1618320412,1618320412,0,300,'份','','','',1,1,10000),(51,'1204449344','','农家火靠鱼头','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618320539,1618320539,0,300,'份','','','',1,1,10000),(52,'1204449344','','虎皮蛋烧泥鳅','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618321028,1618321028,0,300,'份','','','',1,1,10000),(53,'1204449344','','干豆角焖肉','',0,0,'[]',0,0.00,0,0.00,56.00,0.00,-1,-1,0,1,'',0,0,'',1618321095,1618321095,0,300,'份','','','',1,1,10000),(54,'1204449344','','旺丫鱼烧粉皮','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618321196,1618321196,0,300,'份','','','',1,1,10000),(55,'1204449344','','剁椒昂刺鱼','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618321218,1618321218,0,300,'份','','','',1,1,10000),(56,'1204449344','','腊味荷兰豆','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618321241,1618321241,0,300,'份','','','',1,1,10000),(57,'1204449344','','菌菇烩肚条','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618321273,1618321273,0,300,'份','','','',1,1,10000),(58,'1204449344','','铁锅炖大鹅','',0,0,'[]',0,0.00,0,0.00,108.00,0.00,-1,-1,0,1,'',0,0,'',1618321294,1618321294,0,300,'份','','','',1,1,10000),(59,'1204449344','','护心肉烧馓子','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618321319,1618321319,0,300,'份','','','',1,1,10000),(60,'1204449344','','公鸡贴馍','',0,0,'[]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,0,'',1618321359,1618321359,0,300,'份','','','',1,1,10000),(61,'1204449344','','肥肠烧鱼','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618321378,1618321378,0,300,'份','','','',1,1,10000),(62,'1204449344','','韭菜沫鸡蛋','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618321834,1618321834,0,300,'份','','','',1,1,10000),(63,'1204449344','','农家一碗香','',0,0,'[]',0,0.00,0,0.00,32.00,0.00,-1,-1,0,1,'',0,0,'',1618321846,1618321846,0,300,'份','','','',1,1,10000),(64,'1204449344','','三色肚片','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618321920,1618321920,0,300,'份','','','',1,1,10000),(65,'1204449344','','云腿冬瓜','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618321903,1618321903,0,300,'份','','','',1,1,10000),(66,'1204449344','','干锅红焖猪手','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618321888,1618321888,0,300,'份','','','',1,1,10000),(67,'1204449344','','土豆粉炖牛腩','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618321871,1618321871,0,300,'份','','','',1,1,10000),(68,'1204449344','','鸭血肥肠','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618321861,1618321861,0,300,'份','','','',1,1,10000),(69,'1204449344','','家家香大盘鸡','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618322029,1618322029,0,300,'份','','','',1,1,10000),(70,'1204449344','','椒盐猪手','',0,0,'[]',0,0.00,0,0.00,8.00,0.00,-1,-1,0,1,'',0,0,'',1618322064,1618322064,0,300,'块','','','',1,1,10000),(71,'1204449344','','扬州煮干丝','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618322095,1618322095,0,300,'份','','','',1,1,10000),(72,'1204449344','','肉米粉丝煲','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618322139,1618322139,0,300,'份','','','',1,1,10000),(73,'1204449344','','蛤蜊炖蛋','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618322159,1618322159,0,300,'份','','','',1,1,10000),(74,'1204449344','','宫保鸡丁','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618322178,1618322178,0,300,'份','','','',1,1,10000),(75,'1204449344','','鱼香肉丝','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618322215,1618322215,0,300,'份','','','',1,1,10000),(76,'1204449344','','酱爆猪肝','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618322239,1618322239,0,300,'份','','','',1,1,10000),(77,'1204449344','','咸蛋黄豆腐','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618322258,1618322258,0,300,'份','','','',1,1,10000),(78,'1204449344','','芥菜香菇烩虾仁','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618322289,1618322289,0,300,'份','','','',1,1,10000),(79,'1204449344','','糖醋排条','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618322309,1618322309,0,300,'份','','','',1,1,10000),(80,'1204449344','','椒盐排条','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618322324,1618322324,0,300,'份','','','',1,1,10000),(81,'1204449344','','咸蛋黄锅巴','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618322340,1618322340,0,300,'份','','','',1,1,10000),(82,'1204449344','','三鲜锅巴','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618322365,1618322365,0,300,'份','','','',1,1,10000),(83,'1204449344','','咸蛋黄排条','',0,0,'[]',0,0.00,0,0.00,35.00,0.00,-1,-1,0,1,'',0,0,'',1618322389,1618322389,0,300,'份','','','',1,1,10000),(84,'1204449344','','红烧划水','',0,0,'[]',0,0.00,0,0.00,35.00,0.00,-1,-1,0,1,'',0,0,'',1618322411,1618322411,0,300,'份','','','',1,1,10000),(85,'1204449344','','糟溜鱼片','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618322438,1618322438,0,300,'份','','','',1,1,10000),(86,'1204449344','','响油鳝丝','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618322452,1618322452,0,300,'份','','','',1,1,10000),(87,'1204449344','','木桶群鲜烩','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618322498,1618322498,0,300,'份','','','',1,1,10000),(88,'1204449344','','小米椒恋上小公鸡','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618322524,1618322524,0,300,'份','','','',1,1,10000),(89,'1204449344','','茶树菇牛柳','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618322542,1618322542,0,300,'份','','','',1,1,10000),(90,'1204449344','','外婆红烧肉','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618322557,1618322557,0,300,'份','','','',1,1,10000),(91,'1204449344','','金罐焖牛腩','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618322580,1618322580,0,300,'份','','','',1,1,10000),(92,'1204449344','','菌皇烧牛肉粒','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618322611,1618322611,0,300,'份','','','',1,1,10000),(93,'1204449344','','水晶河虾仁','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618322629,1618322629,0,300,'份','','','',1,1,10000),(94,'1204449344','','毛蟹年糕','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618322646,1618322646,0,300,'份','','','',1,1,10000),(95,'1204449344','','小炒河虾','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618322931,1618322931,0,300,'份','','','',1,1,10000),(96,'1204449344','','虾仁跑蛋','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618322947,1618322947,0,200,'份','','','',1,1,10000),(97,'1204449344','','歌乐山辣子鸡','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618322970,1618322970,0,300,'份','','','',1,1,10000),(98,'1204449344','','老坛酸菜鱼','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618322991,1618322991,0,300,'份','','','',1,1,10000),(99,'1204449344','','山城毛血旺','',0,0,'[]',0,0.00,0,0.00,42.00,0.00,-1,-1,0,1,'',0,0,'',1618322809,1618322809,0,300,'份','','','',1,1,10000),(100,'1204449344','','山城毛血旺','',0,0,'[]',0,0.00,0,0.00,42.00,0.00,-1,-1,0,1,'',0,0,'',1618322809,1618322809,0,300,'份','','','',1,1,10000),(101,'1204449344','','酸汤肥牛','',0,0,'[]',0,0.00,0,0.00,42.00,0.00,-1,-1,0,1,'',0,0,'',1618323033,1618323033,0,300,'份','','','',1,1,10000),(102,'1204449344','','一品相思鸭','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618323082,1618323082,0,300,'份','','','',1,1,10000),(103,'1204449344','','乡村瓦块鱼','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618323123,1618323123,0,300,'份','','','',1,1,10000),(104,'1204449344','','重庆水煮牛肉','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618323152,1618323152,0,300,'份','','','',1,1,10000),(105,'1204449344','','剁椒花鲢鱼头','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618323174,1618323174,0,300,'份','','','',1,1,10000),(106,'1204449344','','金牌蒜香骨','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618323188,1618323188,0,300,'份','','','',1,1,10000),(107,'1204449344','','村夫烤黑鱼','',0,0,'[]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,0,'',1618323215,1618323215,0,300,'份','','','',1,1,10000),(108,'1204449344','','剁椒鸦片鱼头','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618323234,1618323234,0,300,'份','','','',1,1,10000),(109,'1204449344','','剁椒鸦片鱼头','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618323234,1618323234,0,300,'份','','','',1,1,10000),(110,'1204449344','','干锅花菜','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618323295,1618323295,0,300,'份','','','',1,1,10000),(111,'1204449344','','干锅手撕包菜','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618323307,1618323307,0,300,'份','','','',1,1,10000),(112,'1204449344','','干锅千页豆腐','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618323316,1618323316,0,300,'份','','','',1,1,10000),(113,'1204449344','','干锅鸡杂','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618323328,1618323328,0,300,'份','','','',1,1,10000),(114,'1204449344','','干锅鸡杂','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618323328,1618323328,0,300,'份','','','',1,1,10000),(115,'1204449344','','干锅茶树菇','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618323342,1618323342,0,300,'份','','','',1,1,10000),(116,'1204449344','','干锅手撕鸡','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618323353,1618323353,0,300,'份','','','',1,1,10000),(117,'1204449344','','干锅牛蛙','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618323371,1618323371,0,300,'份','','','',1,1,10000),(118,'1204449344','','干锅土豆片','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618323384,1618323384,0,300,'份','','','',1,1,10000),(119,'1204449344','','干锅土豆片','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618323384,1618323384,0,300,'份','','','',1,1,10000),(120,'1204449344','','干锅虾','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618323402,1618323402,0,300,'份','','','',1,1,10000),(121,'1204449344','','干锅肥肠','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618323412,1618323412,0,300,'份','','','',1,1,10000),(122,'1204449344','','干锅仔鸡','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618323429,1618323429,0,300,'份','','','',1,1,10000),(123,'1204449344','','生蚝','',0,1,'[{\"attr_key\":\"蒜蓉\",\"attr_val\":[\"豆豉\"]}]',0,0.00,0,0.00,10.00,0.00,-1,-1,0,1,'',0,0,'',1618323576,1618323576,0,300,'只','','','',1,1,10000),(124,'1204449344','','扇贝','',0,1,'[{\"attr_key\":\"蒜蓉\",\"attr_val\":[\"豆豉\"]}]',0,0.00,0,0.00,10.00,0.00,-1,-1,0,1,'',0,0,'',1618323594,1618323594,0,300,'只','','','',1,1,10000),(125,'1204449344','','河虾','',0,1,'[{\"attr_key\":\"油爆\",\"attr_val\":[\"盐水\"]},{\"attr_key\":\"白灼\",\"attr_val\":[]}]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618323686,1618323686,0,300,'份','','','',1,1,10000),(126,'1204449344','','花蛤','',0,1,'[{\"attr_key\":\"辣炒\",\"attr_val\":[\"香辣\"]},{\"attr_key\":\"\",\"attr_val\":[]}]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618323763,1618323763,0,300,'份','','','',1,1,10000),(127,'1204449344','','小黄鱼','',0,1,'[{\"attr_key\":\"红烧\",\"attr_val\":[\"干煎\"]},{\"attr_key\":\"葱姜\",\"attr_val\":[]}]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618323827,1618323827,0,300,'份','','','',1,1,10000),(128,'1204449344','','带鱼','',0,1,'[{\"attr_key\":\"红烧\",\"attr_val\":[\"干煎\"]},{\"attr_key\":\"清蒸\",\"attr_val\":[]}]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618323835,1618323835,0,300,'份','','','',1,1,10000),(129,'1204449344','','蛏子','',0,1,'[{\"attr_key\":\"姜葱\",\"attr_val\":[]},{\"attr_key\":\"清蒸\",\"attr_val\":[]}]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618323876,1618323876,0,300,'份','','','',1,1,10000),(130,'1204449344','','千岛湖胖头鱼','三吃',0,1,'[]',0,0.00,0,0.00,30.00,0.00,-1,-1,0,1,'',0,0,'',1618324187,1618324187,0,0.5,'斤','','','',1,1,10000),(131,'1204449344','','鳊鱼','',0,1,'[{\"attr_key\":\"做法\",\"attr_val\":[\"红烧\",\"清蒸\"]}]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618327650,1618327650,0,0.5,'份','','','',1,1,10000),(132,'1204449344','','鲈鱼','',0,1,'[{\"attr_key\":\"红烧\",\"attr_val\":[]},{\"attr_key\":\"清蒸\",\"attr_val\":[]},{\"attr_key\":\"\",\"attr_val\":[]}]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618324390,1618324390,0,0.5,'份','','','',1,1,10000),(133,'1204449344','','基围虾','',0,1,'[{\"attr_key\":\"椒盐\",\"attr_val\":[]},{\"attr_key\":\"香辣\",\"attr_val\":[]},{\"attr_key\":\"\",\"attr_val\":[]}]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618324445,1618324445,0,0.5,'份','','','',1,1,10000),(134,'1204449344','','鲳鱼','',0,1,'[{\"attr_key\":\"红烧\",\"attr_val\":[]},{\"attr_key\":\"清蒸\",\"attr_val\":[]},{\"attr_key\":\"油爆\",\"attr_val\":[]}]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618324486,1618324486,0,0.5,'份','','','',1,1,10000),(135,'1204449344','','大黄鱼','',0,1,'[{\"attr_key\":\"松子\",\"attr_val\":[]},{\"attr_key\":\"清蒸\",\"attr_val\":[]},{\"attr_key\":\"干煎\",\"attr_val\":[]}]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,0,'',1618324546,1618324546,0,0.5,'份','','','',1,1,10000),(136,'1204449344','','多宝鱼','',0,1,'[{\"attr_key\":\"红烧\",\"attr_val\":[]},{\"attr_key\":\"\",\"attr_val\":[]}]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,0,'',1618324669,1618324669,0,0.5,'份','','','',1,1,10000),(137,'1204449344','','梭子蟹','时价\n\n',0,1,'[{\"attr_key\":\"咸蛋黄焗\",\"attr_val\":[]},{\"attr_key\":\"香辣\",\"attr_val\":[]},{\"attr_key\":\"葱姜\",\"attr_val\":[]}]',0,0.00,0,0.00,108.00,0.00,-1,-1,0,1,'',0,0,'',1618324786,1618324786,0,0.5,'份','','','',1,1,10000),(138,'1204449344','','八爪鱼','时价\n\n',0,1,'[{\"attr_key\":\"酱爆\",\"attr_val\":[]},{\"attr_key\":\"干锅\",\"attr_val\":[]},{\"attr_key\":\"葱姜\",\"attr_val\":[]}]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618324834,1618324834,0,0.5,'份','','','',1,1,10000),(139,'1204449344','','桂鱼','\n\n',0,1,'[{\"attr_key\":\"清蒸\",\"attr_val\":[]},{\"attr_key\":\"红烧\",\"attr_val\":[]}]',0,0.00,0,0.00,98.00,0.00,-1,-1,0,1,'',0,0,'',1618324877,1618324877,0,0.5,'份','','','',1,1,10000),(140,'1204449344','','大闸蟹','时价',0,1,'[]',0,0.00,0,0.00,98.00,0.00,-1,-1,0,1,'',0,0,'',1618324912,1618324912,0,0.5,'份','','','',1,1,10000),(141,'1204449344','','香辣鲫鱼','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618325115,1618325115,0,0.5,'份','','','',1,1,10000),(142,'1204449344','','茶树菇鸡仔','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618325196,1618325196,0,0.5,'份','','','',1,1,10000),(143,'1204449344','','酱爆腰花','48元/2只\n\n',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618325229,1618325229,0,0.5,'份','','','',1,1,10000),(144,'1204449344','','回锅肉','',0,0,'[]',0,0.00,0,0.00,32.00,0.00,-1,-1,0,1,'',0,0,'',1618325353,1618325353,0,300,'份','','','',1,1,10000),(145,'1204449344','','回锅肉','',0,0,'[]',0,0.00,0,0.00,32.00,0.00,-1,-1,0,1,'',0,0,'',1618325353,1618325353,0,300,'份','','','',1,1,10000),(146,'1204449344','','农家锅巴','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618325375,1618325375,0,300,'份','','','',1,1,10000),(147,'1204449344','','小炒香干','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618325391,1618325391,0,300,'份','','','',1,1,10000),(148,'1204449344','','牛腩烩豆腐','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618325409,1618325409,0,300,'份','','','',1,1,10000),(149,'1204449344','','热炝牛百叶','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325435,1618325435,0,300,'份','','','',1,1,10000),(150,'1204449344','','海鲜面疙瘩','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618325453,1618325453,0,300,'份','','','',1,1,10000),(151,'1204449344','','铁板肥肠','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325604,1618325604,0,0.3,'份','','','',1,1,10000),(152,'1204449344','','铁板肥肠','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325604,1618325604,0,0.3,'份','','','',1,1,10000),(153,'1204449344','','铁板牛肉','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325615,1618325615,0,0.3,'份','','','',1,1,10000),(154,'1204449344','','铁板蒜香虾','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325625,1618325625,0,0.3,'份','','','',1,1,10000),(155,'1204449344','','铁板鱿鱼须','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325632,1618325632,0,0.3,'份','','','',1,1,10000),(156,'1204449344','','铁板日本豆腐','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618325646,1618325646,0,0.3,'份','','','',1,1,10000),(157,'1204449344','','农家煎豆腐','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618325689,1618325689,0,0.3,'份','','','',1,1,10000),(158,'1204449344','','农家小炒肉','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618325728,1618325728,0,0.3,'份','','','',1,1,10000),(159,'1204449344','','油浸蚕豆','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618325775,1618325775,0,0.3,'份','','','',1,1,10000),(160,'1204449344','','咸肉蒸香百叶','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618325810,1618325810,0,0.3,'份','','','',1,1,10000),(161,'1204449344','','风味咸蹄夹饼','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618325841,1618325841,0,0.3,'份','','','',1,1,10000),(162,'1204449344','','香酥蹄膀','',0,0,'[]',0,0.00,0,0.00,68.00,0.00,-1,-1,0,1,'',0,0,'',1618325860,1618325860,0,0.3,'份','','','',1,1,10000),(163,'1204449344','','农家烧蹄膀','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618325879,1618325879,0,0.3,'份','','','',1,1,10000),(164,'1204449344','','农家烧蹄膀','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618325879,1618325879,0,0.3,'份','','','',1,1,10000),(165,'1204449344','','青椒肚片','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325893,1618325893,0,0.3,'份','','','',1,1,10000),(166,'1204449344','','家乡咸鸡锅仔','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618325947,1618325947,0,0.3,'份','','','',1,1,10000),(167,'1204449344','','萝卜烧咸鸭锅仔','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618325969,1618325969,0,0.3,'份','','','',1,1,10000),(168,'1204449344','','萝卜烧咸鸭锅仔','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618325969,1618325969,0,0.3,'份','','','',1,1,10000),(169,'1204449344','','毛芋头咸鹅锅仔','',0,0,'[]',0,0.00,0,0.00,88.00,0.00,-1,-1,0,1,'',0,0,'',1618326000,1618326000,0,0.3,'份','','','',1,1,10000),(170,'1204449344','','羊肉锅仔','',0,0,'[]',0,0.00,0,0.00,98.00,0.00,-1,-1,0,1,'',0,0,'',1618326015,1618326015,0,0.3,'份','','','',1,1,10000),(171,'1204449344','','牛肉锅仔','',0,0,'[]',0,0.00,0,0.00,98.00,0.00,-1,-1,0,1,'',0,0,'',1618326021,1618326021,0,0.3,'份','','','',1,1,10000),(172,'1204449344','','酸辣土豆丝','',0,0,'[]',0,0.00,0,0.00,12.00,0.00,-1,-1,0,1,'',0,0,'',1618326053,1618326053,0,0.3,'份','','','',1,1,10000),(173,'1204449344','','蒜泥刀豆','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618326067,1618326067,0,0.3,'份','','','',1,1,10000),(174,'1204449344','','韭黄炒蛋','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618326097,1618326097,0,0.3,'份','','','',1,1,10000),(175,'1204449344','','地三鲜','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618326113,1618326113,0,0.3,'份','','','',1,1,10000),(176,'1204449344','','野荠菜山药','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618326179,1618326179,0,0.3,'份','','','',1,1,10000),(177,'1204449344','','野荠菜山药','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618326179,1618326179,0,0.3,'份','','','',1,1,10000),(178,'1204449344','','风味茄子','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618326195,1618326195,0,0.3,'份','','','',1,1,10000),(179,'1204449344','','葱油南湖菱角','',0,0,'[]',0,0.00,0,0.00,36.00,0.00,-1,-1,0,1,'',0,0,'',1618326220,1618326220,0,0.3,'份','','','',1,1,10000),(180,'1204449344','','葱油芋艿','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618326330,1618326330,0,0.3,'份','','','',1,1,10000),(181,'1204449344','','清炒时蔬','',0,0,'[]',0,0.00,0,0.00,20.00,0.00,-1,-1,0,1,'',0,0,'',1618326626,1618326626,0,0.3,'份','','','',1,1,10000),(182,'1204449344','','咸蛋黄茶树菇','',0,0,'[]',0,0.00,0,0.00,38.00,0.00,-1,-1,0,1,'',0,0,'',1618326651,1618326651,0,0.3,'份','','','',1,1,10000),(183,'1204449344','','干煸四季豆','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618326696,1618326696,0,0.3,'份','','','',1,1,10000),(184,'1204449344','','外婆菜炒蛋','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618326714,1618326714,0,0.3,'份','','','',1,1,10000),(185,'1204449344','','小炒黄牛肉','',0,0,'[]',0,0.00,0,0.00,48.00,0.00,-1,-1,0,1,'',0,0,'',1618326732,1618326732,0,0.3,'份','','','',1,1,10000),(186,'1204449344','','番茄蛋花汤','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'',0,0,'',1618413785,1618413785,0,0.5,'份','','','',1,1,10000),(187,'1204449344','','本帮酸菜汤','',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'',0,0,'',1618413805,1618413805,0,0.5,'份','','','',1,1,10000),(188,'1204449344','','荠菜肉丝豆腐羹','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618413829,1618413829,0,0.5,'份','','','',1,1,10000),(189,'1204449344','','凤凰玉米蛋花羹','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618413884,1618413884,0,0.5,'份','','','',1,1,10000),(190,'1204449344','','西湖牛肉羹','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618413896,1618413896,0,0.5,'份','','','',1,1,10000),(191,'1204449344','','三丝发财海鲜羹','',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618413933,1618413933,0,0.5,'份','','','',1,1,10000),(192,'1204449344','','酒酿圆子','',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618413948,1618413948,0,0.5,'份','','','',1,1,10000),(193,'1204449344','','青鱼头豆腐汤','',0,0,'[]',0,0.00,0,0.00,28.00,0.00,-1,-1,0,1,'',0,0,'',1618413980,1618413980,0,0.5,'份','','','',1,1,10000),(194,'1204449344','','花鲢头豆腐汤','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618414003,1618414003,0,0.5,'份','','','',1,1,10000),(195,'1204449344','','砂锅玉米排骨汤','',0,0,'[]',0,0.00,0,0.00,58.00,0.00,-1,-1,0,1,'',0,0,'',1618414027,1618414027,0,0.5,'份','','','',1,1,10000),(196,'1204449344','','毛芋扁尖老鸭汤','',0,0,'[]',0,0.00,0,0.00,78.00,0.00,-1,-1,0,1,'',0,0,'',1618414084,1618414084,0,0.5,'份','','','',1,1,10000),(197,'1204449344','','菌菇老鸡汤','',0,0,'[]',0,0.00,0,0.00,128.00,0.00,-1,-1,0,1,'',0,0,'',1618414104,1618414104,0,0.5,'份','','','',1,1,10000),(198,'1204449344','','甲鱼牛鞭汤','预定\n\n',0,0,'[]',0,0.00,0,0.00,128.00,0.00,-1,-1,0,1,'',0,0,'',1618414142,1618414142,0,0.5,'份','','','',1,1,10000),(199,'1204449344','','甲鱼牛鞭汤','预定\n\n',0,0,'[]',0,0.00,0,0.00,128.00,0.00,-1,-1,0,1,'',0,0,'',1618414142,1618414142,0,0.5,'份','','','',1,1,10000),(200,'1204449344','','外婆菜窝窝头','\n',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618414171,1618414171,0,0.5,'份','','','',1,1,10000),(201,'1204449344','','麻饼','\n',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'',0,0,'',1618414193,1618414193,0,0.3,'份','','','',1,1,10000),(202,'1204449344','','水饺','\n',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'',0,0,'',1618414205,1618414205,0,0.3,'份','','','',1,1,10000),(203,'1204449344','','春卷','\n',0,0,'[]',0,0.00,0,0.00,18.00,0.00,-1,-1,0,1,'',0,0,'',1618414276,1618414276,0,0.3,'份','','','',1,1,10000),(204,'1204449344','','炒面','\n',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'',0,0,'',1618414227,1618414227,0,0.3,'份','','','',1,1,10000),(205,'1204449344','','南瓜饼','\n',0,0,'[]',0,0.00,0,0.00,15.00,0.00,-1,-1,0,1,'',0,0,'',1618414238,1618414238,0,0.3,'份','','','',1,1,10000),(206,'1204449344','','飘香玉米烙','\n',0,0,'[]',0,0.00,0,0.00,22.00,0.00,-1,-1,0,1,'',0,0,'',1618414290,1618414290,0,0.3,'份','','','',1,1,10000);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_attr_key`
--

LOCK TABLES `cmf_food_attr_key` WRITE;
/*!40000 ALTER TABLE `cmf_food_attr_key` DISABLE KEYS */;
INSERT INTO `cmf_food_attr_key` VALUES (1,'30元/斤');
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
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category`
--

LOCK TABLES `cmf_food_category` WRITE;
/*!40000 ALTER TABLE `cmf_food_category` DISABLE KEYS */;
INSERT INTO `cmf_food_category` VALUES (1,1,1204449344,'招牌推荐',NULL,0,0,0,1618120174,1618120174,0,1,10000),(1,2,1204449344,'风味冷菜',NULL,0,0,0,1618120200,1618120200,0,1,10000),(1,3,1204449344,'徽味无穷',NULL,0,0,0,1618120222,1618120222,0,1,10000),(1,4,1204449344,'金牌小炒',NULL,0,0,0,1618120240,1618120240,0,1,10000),(1,5,1204449344,'家的味道',NULL,0,0,0,1618120259,1618120259,0,1,10000),(1,6,1204449344,'麻辣川湘',NULL,0,0,0,1618120281,1618120281,0,1,10000),(1,7,1204449344,'干锅铁板',NULL,0,0,0,1618120301,1618120301,0,1,10000),(1,8,1204449344,'河鲜海鲜',NULL,0,0,0,1618120325,1618120325,0,1,10000),(1,9,1204449344,'精品火锅',NULL,0,0,0,1618120352,1618120352,0,1,10000),(1,10,1204449344,'田园时蔬',NULL,0,0,0,1618120378,1618120378,0,1,10000),(1,11,1204449344,'精品靓汤',NULL,0,0,0,1618120398,1618120398,0,1,10000),(1,12,1204449344,'主食',NULL,0,0,0,1618120467,1618120467,0,1,10000);
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
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_food_category_post`
--

LOCK TABLES `cmf_food_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_food_category_post` DISABLE KEYS */;
INSERT INTO `cmf_food_category_post` VALUES (1,1,1,0,0),(2,2,1,0,0),(3,3,1,0,0),(4,4,1,0,0),(5,5,1,0,0),(6,6,1,0,0),(7,7,1,0,0),(8,8,1,0,0),(9,9,1,0,0),(10,10,2,0,0),(11,11,2,0,0),(12,12,2,0,0),(13,13,2,0,0),(14,14,2,0,0),(15,15,2,0,0),(16,16,2,0,0),(17,17,2,0,0),(18,18,2,0,0),(19,19,2,0,0),(20,20,2,0,0),(21,21,2,0,0),(22,22,2,0,0),(23,23,2,0,0),(24,24,2,0,0),(25,25,2,0,0),(26,26,2,0,0),(27,27,2,0,0),(28,28,2,0,0),(29,29,2,0,0),(30,30,2,0,0),(31,31,2,0,0),(32,32,2,0,0),(33,33,2,0,0),(34,34,2,0,0),(35,35,2,0,0),(36,36,2,0,0),(37,37,2,0,0),(38,38,2,0,0),(39,39,2,0,0),(40,40,2,0,0),(41,41,3,0,0),(42,42,3,0,0),(43,43,3,0,0),(44,44,3,0,0),(45,45,3,0,0),(46,46,3,0,0),(47,47,3,0,0),(48,48,3,0,0),(49,49,3,0,0),(50,50,3,0,0),(51,51,3,0,0),(52,52,3,0,0),(53,53,3,0,0),(54,54,3,0,0),(55,55,3,0,0),(56,56,3,0,0),(57,57,3,0,0),(58,58,3,0,0),(59,59,3,0,0),(60,60,3,0,0),(61,61,3,0,0),(69,62,4,0,0),(70,63,4,0,0),(71,68,4,0,0),(72,67,4,0,0),(73,66,4,0,0),(74,65,4,0,0),(75,64,4,0,0),(76,69,5,0,0),(77,70,5,0,0),(78,71,5,0,0),(79,72,5,0,0),(80,73,5,0,0),(81,74,5,0,0),(82,75,5,0,0),(83,76,5,0,0),(84,77,5,0,0),(85,78,5,0,0),(86,79,5,0,0),(87,80,5,0,0),(88,81,5,0,0),(89,82,5,0,0),(90,83,5,0,0),(91,84,5,0,0),(92,85,5,0,0),(93,86,5,0,0),(94,87,5,0,0),(95,88,5,0,0),(96,89,5,0,0),(97,90,5,0,0),(98,91,5,0,0),(99,92,5,0,0),(100,93,5,0,0),(101,94,5,0,0),(102,95,5,0,0),(103,96,5,0,0),(104,97,6,0,0),(105,98,6,0,0),(106,99,6,0,0),(107,100,6,0,0),(108,101,6,0,0),(109,102,6,0,0),(110,103,6,0,0),(111,104,6,0,0),(112,105,6,0,0),(113,106,6,0,0),(114,107,6,0,0),(115,108,6,0,0),(116,109,6,0,0),(117,110,7,0,0),(118,111,7,0,0),(119,112,7,0,0),(120,113,7,0,0),(121,114,7,0,0),(122,115,7,0,0),(123,116,7,0,0),(124,117,7,0,0),(125,118,7,0,0),(126,119,7,0,0),(127,120,7,0,0),(128,121,7,0,0),(129,122,7,0,0),(130,123,8,0,0),(131,124,8,0,0),(132,125,8,0,0),(133,126,8,0,0),(134,127,8,0,0),(135,128,8,0,0),(136,129,8,0,0),(137,130,8,0,0),(138,131,8,0,0),(139,132,8,0,0),(140,133,8,0,0),(141,134,8,0,0),(142,135,8,0,0),(143,136,8,0,0),(144,137,8,0,0),(145,138,8,0,0),(146,139,8,0,0),(147,140,8,0,0),(148,141,6,0,0),(149,142,6,0,0),(150,143,6,0,0),(151,145,6,0,0),(152,144,6,0,0),(153,146,6,0,0),(154,147,6,0,0),(155,148,6,0,0),(156,149,6,0,0),(157,150,6,0,0),(158,151,7,0,0),(159,152,7,0,0),(160,153,7,0,0),(161,154,7,0,0),(162,155,7,0,0),(163,156,7,0,0),(164,157,5,0,0),(165,158,5,0,0),(166,159,5,0,0),(167,160,5,0,0),(168,161,5,0,0),(169,162,5,0,0),(170,163,5,0,0),(171,164,5,0,0),(172,165,5,0,0),(173,166,9,0,0),(174,167,9,0,0),(175,168,9,0,0),(176,169,9,0,0),(177,170,9,0,0),(178,171,9,0,0),(179,172,10,0,0),(180,173,10,0,0),(181,174,10,0,0),(182,175,10,0,0),(183,176,10,0,0),(184,177,10,0,0),(185,178,10,0,0),(186,179,10,0,0),(187,180,10,0,0),(188,181,10,0,0),(189,182,10,0,0),(190,183,10,0,0),(191,184,10,0,0),(192,185,10,0,0),(193,186,11,0,0),(194,187,11,0,0),(195,188,11,0,0),(196,189,11,0,0),(197,190,11,0,0),(198,191,11,0,0),(199,192,11,0,0),(200,193,11,0,0),(201,194,11,0,0),(202,195,11,0,0),(203,196,11,0,0),(204,197,11,0,0),(205,198,11,0,0),(206,199,11,0,0),(207,200,12,0,0),(208,201,12,0,0),(209,202,12,0,0),(210,203,12,0,0),(211,204,12,0,0),(212,205,12,0,0),(213,206,12,0,0);
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
  `delete_at` bigint(20) DEFAULT '0' COMMENT '''删除时间''',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '菜品分类状态（0 => 下架,1 => 上架）',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
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
  UNIQUE KEY `idx_code` (`code`)
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
  `encrypt_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序接口加密内容',
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
INSERT INTO `cmf_mp_theme` VALUES (1,1204449344,0,'家家香','',0,1452774253,'tenant/1204449344/20210415/d73c74e180918cd0c37d90e552e2d779.png','','https://mobilecodec.alipay.com/show.htm?code=s4x12037ftxipgkedbwe5e1','R7LNrR3vJtDwSEVNpHkRzg==',1618043951,0,10000,0);
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
INSERT INTO `cmf_mp_theme_page` VALUES (1,1,1204449344,1,'首页','home','','','[{\"type\":\"swiper\",\"data\":[{\"name\":\"\",\"image\":\"https://cdn.mashangdian.cn/tenant/1204449344/20210414/13bb3182da18090597eadfae2c570e13.jpg!clipper\",\"file_path\":\"tenant/1204449344/20210414/13bb3182da18090597eadfae2c570e13.jpg\",\"link\":\"\",\"id\":23}],\"config\":{\"autoHeight\":true},\"style\":{\"autoHeight\":true}},{\"type\":\"container\",\"child\":[{\"type\":\"grid\",\"data\":[{\"image\":\"https://cdn.mashangdian.cn/tenant/1204449344/20210414/4d50f4455fadc7138e13de4bb19db240.png!clipper\",\"title\":\"外卖送餐\",\"desc\":\"安心外送，超快送达\",\"id\":22,\"file_path\":\"tenant/1204449344/20210414/4d50f4455fadc7138e13de4bb19db240.png\",\"action\":{\"type\":\"func\",\"index\":1,\"name\":\"外卖送餐\",\"url\":\"pages/store/index?scene=takeout\",\"method\":\"switchTab\"}},{\"image\":\"https://cdn.mashangdian.cn/tenant/1204449344/20210414/70b33a88cd9d7f1e1af27ccfd5b315bf.jpg!clipper\",\"title\":\"到店取餐\",\"desc\":\"下单免排队\",\"id\":24,\"file_path\":\"tenant/1204449344/20210414/70b33a88cd9d7f1e1af27ccfd5b315bf.jpg\",\"action\":{\"type\":\"func\",\"index\":0,\"name\":\"到店取餐\",\"url\":\"pages/store/index?scene=pack\",\"method\":\"switchTab\"}},{\"image\":\"https://cdn.mashangdian.cn/tenant/1204449344/20210414/33ffb9de1b2e8e32b49f70fc72e12735.png!clipper\",\"title\":\"扫码点餐\",\"desc\":\"美味即享\",\"id\":27,\"file_path\":\"tenant/1204449344/20210414/33ffb9de1b2e8e32b49f70fc72e12735.png\",\"action\":{\"type\":\"func\",\"index\":2,\"name\":\"扫码点餐\",\"url\":\"func/scan\",\"method\":\"func/scan\"}}],\"config\":{\"theme\":\"third\"},\"style\":{\"theme\":\"third\",\"len\":3,\"borderRadius\":6}},{\"type\":\"userinfo\",\"data\":[{\"image\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMIAAADDCAIAAABf31nDAAABS2lDQ1BERUxMIFUyNzE3RAAAKJGVjr9LAnEchp9vGtoPyOESajqoJdDQa5C2TCMCB5GiU2g4z1+h2ZfzoNoaGvoLammLCqqhKdeG9oagpLmhXXApuQYrlYboXT4PDy98XhhQDCkrbmCralup5UVVT2dUzyteFMbx4TLMmowmkwmA79uf1hMC4DFoSFkpP8Qugwvhq7ON6+hxWT343e/LcC5fM4EPoGBKywaRA6Z2bGmDOAQUS09nQJwASrHDN4CS7fA9oFirqRiIBuAzS0YOxBsQyPb4Yg9//QUYjS8lEuqaFglH4n/M/X/s/K4NENuWe9ZmsWSrUSkreXWlas4GVC2khUBPZ9ROu9lAAMLv7Trph/k4uE67LjsJdRMmhrpu+gLGdLjdl4Zl/AwQLXetMKd1eKQOg0eO01wHzwy0nx3nve447XNwvcBd6xPrkl1A9iU1iwAAAAlwSFlzAAALEwAACxMBAJqcGAAABRRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAyIDc5LjE2NDM2MCwgMjAyMC8wMi8xMy0wMTowNzoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIxLjEgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTAxLTIyVDIxOjI4OjMwKzA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0wMS0yMlQyMTozOTo0MSswODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJERUxMIFUyNzE3RCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6ODcwYzU4MzItZGI2MC00MjdhLTkzM2QtZjJhZTg4N2YxYzQzIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo4NzBjNTgzMi1kYjYwLTQyN2EtOTMzZC1mMmFlODg3ZjFjNDMiIHN0RXZ0OndoZW49IjIwMjEtMDEtMjJUMjE6Mjg6MzArMDg6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChNYWNpbnRvc2gpIi8+IDwvcmRmOlNlcT4gPC94bXBNTTpIaXN0b3J5PiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgKv0dkAAARnSURBVHic7dwhT/NaHIDxvjc3OaiiitoUqNbN1RW1qs3V8Qn4WHwDHAocDocDxRRzm6q7YglZYOMd3GeU9Tw/tSxA/glPzml7lv1ZLpeJ9P/80/UA6gMzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBPi36wH2Yj6fPz09dT3FBoPBYDgcdj0Fr4cZtW17dXXV9RSbhRAuLy+7noLXw03t9fW16xG2atv25eWl6yl4PcxIP8+MBDAjAcxIADMSwIySLMtCCF1Pcdh6+Nxod1VVjUaj1evFYnF7e/v8/NztSAcq3tWoLMu3hpIkSdO0rus0TTsc6XDFm9FgMHj3Tgjh7Oysk2EOXbwZbTzb8iLpe+LNaOOhRNu2Pz9JD8Sb0Ww2+/jm7/xcwO8Xb0YPDw/r0bRte3Nzs1gsOhzpcMV7w9+27fX1dZqmx8fHyZY9TjuKN6OVxWLx1RUohBBCcN1aF++m9m2TyeTi4iLLsq4H+UXM6GvG4/FwOAwh1HXt04E3ZvQFeZ4XRbF6nWVZ0zTdzvN7mFGSJMkuO9RgMKjr+t1vjcfjvQ11SMwoKcvyr9c6WZZNp9OP7xdFsX4wF63YM8rzvCzLJEmaptl2LhtCmE6n266Eqqo6PT3d44iHIOqMsiw7Pz9fvf6klU8KW6nrOvIbt3gzCiE0TbPeTZZlk8nk3Y+Nx+O/JvLxT8Um0oy2/eOHw+H6VXNZlm+3Zt/7g5GINKNP1piiKPI8T9Yum3aUZVlVVch4ByfGw5Cqqj7/eFpd10dHR19qaKUoirZt7+7uvj/cYYpuNcrzfJdb9KqqvrdDjUaj1WIWlbgy+vgIcR8ivHGLKKNtjxD3oWmaqEqKJaMfPkyN7ew2lowmk8kPLw8bn0L1VSx3arPZbOOHr4WIJaP7+/uuR+izWDY17ZUZCWBGApiRAD3M6OTkpOsRtgoh9PJ7sf8sl8uuZ+DN5/PHx8ff9s3GaZoWRWFG0mY93NT088xIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwEMCMBzEgAMxLAjAQwIwHMSAAzEsCMBDAjAcxIADMSwIwE+A+jtp274P/ZTwAAAABJRU5ErkJggg==\",\"title\":\"我的余额\",\"number\":0,\"field\":\"balance\",\"desc\":\"充值立享超多优惠！\",\"action\":{\"type\":\"func\",\"index\":7,\"name\":\"余额储值\",\"url\":\"pages/mine/money/index\",\"method\":\"\"}}],\"config\":{},\"style\":{\"paddingTop\":10,\"marginTop\":10,\"paddingBottom\":10}},{\"type\":\"title\",\"data\":{\"title\":\"自定义标题\",\"value\":\"商家新鲜事\"},\"config\":{},\"style\":{\"paddingTop\":0,\"paddingBottom\":10,\"paddingLeft\":10,\"marginTop\":10,\"backgroundColor\":\"rgba(255, 255, 255, 0)\",\"backgroundColorRgb\":{\"r\":255,\"g\":255,\"b\":255,\"a\":0},\"fontSize\":14}},{\"type\":\"list\",\"data\":[],\"config\":{\"source\":{\"categoryId\":1,\"api\":\"portal/list\"}},\"style\":{}}],\"config\":{},\"style\":{\"position\":\"relative\",\"top\":-15,\"paddingTop\":0,\"paddingLeft\":10,\"paddingRight\":10}}]','',1618043951,0);
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
  `status` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'wait' COMMENT '小程序版本状态(gray:灰度，wait:待审核,reject:已拒绝,audit:已审核，online:已上线，offline：下架)',
  `reject_reason` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权商户小程序类型',
  `create_at` bigint(20) DEFAULT '0' COMMENT '创建时间',
  `update_at` bigint(20) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_mp_theme_version`
--

LOCK TABLES `cmf_mp_theme_version` WRITE;
/*!40000 ALTER TABLE `cmf_mp_theme_version` DISABLE KEYS */;
INSERT INTO `cmf_mp_theme_version` VALUES (1,1204449344,'0.0.0','2021001192675085','0.0.20',0,'wait','','',1618060009,0),(2,1204449344,'0.0.1','2021001192675085','0.0.21',0,'wait','','alipay',1618060658,1618393548),(3,1204449344,'0.0.2','2021001192675085','0.0.23',0,'init','','alipay',1618393569,1632542531);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_option`
--

LOCK TABLES `cmf_option` WRITE;
/*!40000 ALTER TABLE `cmf_option` DISABLE KEYS */;
INSERT INTO `cmf_option` VALUES (1,1,'business_info','{\"email\": \"\", \"mobile\": \"13042159397\", \"address\": \"\", \"company\": \"\", \"contact\": \"张国芳\", \"app_desc\": \"家家香饭店，为您提供便捷的点餐服务\", \"app_slogan\": \"家家香饭店\", \"brand_logo\": \"tenant/1204449344/20210415/d73c74e180918cd0c37d90e552e2d779.png\", \"brand_name\": \"家家香\", \"out_door_pic\": \"tenant/1204449344/20210415/bfe39e7dbd9beca5c1042f1ef867cee2.png\", \"alipay_logo_id\": \"F7WK4VmSSH6Tya7kxCHrkAAAACMAAQQD\", \"business_photo\": \"tenant/1204449344/20210415/bfe39e7dbd9beca5c1042f1ef867cee2.png\", \"business_scope\": \"\", \"business_expired\": \"\", \"business_license\": \"宝（淞南）餐备字2020第0016号\", \"food_license_pic\": \"\", \"mini_category_ids\": \"XS1009_XS2077\"}',1204449344,0),(2,1,'eatin','{\"day\": 0, \"status\": 1, \"eat_type\": 1, \"pay_type\": 0, \"sale_type\": 0, \"surcharge\": 0, \"sell_clear\": \"\", \"custom_name\": \"\", \"custom_enabled\": 0, \"surcharge_type\": 0, \"enabled_sell_clear\": 0, \"enabled_appointment\": 0}',1204449344,1),(3,1,'takeout','{\"day\": 0, \"status\": 1, \"step_km\": 0, \"start_km\": 3, \"step_fee\": 0, \"start_fee\": 1, \"sell_clear\": \"\", \"first_class\": \"美食夜宵\", \"second_class\": \"快餐/地方菜\", \"automatic_order\": 0, \"stop_before_min\": 30, \"delivery_distance\": 3, \"enabled_sell_clear\": 0, \"immediate_delivery\": 0, \"enabled_appointment\": 0}',1204449344,1);
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
  `buyer_id` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付宝付款人id',
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
INSERT INTO `cmf_portal_category` VALUES (1,1204449344,0,0,1,0,10000,'新鲜事','','','','','','','','','','');
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
INSERT INTO `cmf_portal_post` VALUES (1,1204449344,0,1,1,1,1,1,0,0,4,0,0,0,1618388327,1618388327,0,0,'外卖上线了','','','','tenant/1204449344/20210414/3a279d95d3d756a28fdf0d92520b245e.jpg','','','{\"audio\": \"\", \"files\": [], \"other\": null, \"video\": \"\", \"photos\": [], \"extends\": {}, \"template\": \"\"}');
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
  `avatar` longtext COLLATE utf8mb4_general_ci,
  `user_login` longtext COLLATE utf8mb4_general_ci,
  `user_nickname` longtext COLLATE utf8mb4_general_ci,
  `user_real_name` longtext COLLATE utf8mb4_general_ci,
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
INSERT INTO `cmf_role` VALUES (1204449344,1,0,'超级管理员','拥有网站最高管理员权限！',10000,1618043951,1618043951,1),(1204449344,2,0,'收银员','收银员！',1,1618043951,1618043951,1),(1204449344,3,0,'财务','财务！',2,1618043951,1618043951,1);
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
INSERT INTO `cmf_store` VALUES (1,'2021041100502000000032095905',1204449344,277479342,'2021041100077000000019075055','家家香',1,'S08','1724','13042159397','张国芳',310000,'上海市',310100,'市辖区',310113,'宝山区','淞南镇长江路392号 家家香','tenant/1204449344/20210411/5de8bf9cc11a077181ba19d784ccdfe6.jpeg',121.4940870,31.3503810,0,1,'23:30','',1618120104,1618120104,0,'passed','',NULL);
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
INSERT INTO `cmf_store_hours` VALUES (1204449344,1,1,1,1,1,1,1,1,'00:00','00:00',0),(1204449344,1,0,0,0,0,0,0,0,'00:00','00:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_part`
--

LOCK TABLES `cmf_third_part` WRITE;
/*!40000 ALTER TABLE `cmf_third_part` DISABLE KEYS */;
INSERT INTO `cmf_third_part` VALUES (1,1204449344,'alipay-mp',0,'2088812917001575'),(2,1204449344,'alipay-mp',0,'2088512446596714'),(3,1204449344,'alipay-mp',0,'2088932209762772');
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
-- Dumping events for database 'tenant_1452774253'
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-04-21 14:58:19' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `memberStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-04-21 14:58:19' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_member_card SET status = -1 WHERE end_at between 0 AND UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-04-21 14:58:16' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `orderFinishStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-04-21 14:58:16' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > appointment_at + 43200 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `rechargeOrderCloseStatus` ON SCHEDULE EVERY 1 SECOND STARTS '2021-04-21 14:58:19' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_recharge_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600 */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucher` ON SCHEDULE EVERY 1 SECOND STARTS '2021-04-21 14:58:18' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher SET status = 2 WHERE UNIX_TIMESTAMP(publish_end_time) < UNIX_TIMESTAMP(NOW()) */ ;;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`mp_isv`@`%`*/ /*!50106 EVENT `voucherPost` ON SCHEDULE EVERY 1 SECOND STARTS '2021-04-21 14:58:18' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cmf_voucher_post SET status = 2 WHERE valid_end_at < UNIX_TIMESTAMP(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'tenant_1452774253'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:03:52
