-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: rm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com    Database: msd_web
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
-- Current Database: `msd_web`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `msd_web` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `msd_web`;

--
-- Table structure for table `cmf_admin_menu`
--

DROP TABLE IF EXISTS `cmf_admin_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;1:显示,0:不显示',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `app` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parent_id` (`parent_id`),
  KEY `controller` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='后台菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_menu`
--

LOCK TABLES `cmf_admin_menu` WRITE;
/*!40000 ALTER TABLE `cmf_admin_menu` DISABLE KEYS */;
INSERT INTO `cmf_admin_menu` VALUES (1,0,0,1,20,'admin','Plugin','default','','插件中心','cloud','插件中心'),(2,1,1,1,10000,'admin','Hook','index','','钩子管理','','钩子管理'),(3,2,1,0,10000,'admin','Hook','plugins','','钩子插件管理','','钩子插件管理'),(4,2,2,0,10000,'admin','Hook','pluginListOrder','','钩子插件排序','','钩子插件排序'),(5,2,1,0,10000,'admin','Hook','sync','','同步钩子','','同步钩子'),(6,0,0,1,0,'admin','Setting','default','','设置','cogs','系统设置入口'),(7,6,1,1,50,'admin','Link','index','','友情链接','','友情链接管理'),(8,7,1,0,10000,'admin','Link','add','','添加友情链接','','添加友情链接'),(9,7,2,0,10000,'admin','Link','addPost','','添加友情链接提交保存','','添加友情链接提交保存'),(10,7,1,0,10000,'admin','Link','edit','','编辑友情链接','','编辑友情链接'),(11,7,2,0,10000,'admin','Link','editPost','','编辑友情链接提交保存','','编辑友情链接提交保存'),(12,7,2,0,10000,'admin','Link','delete','','删除友情链接','','删除友情链接'),(13,7,2,0,10000,'admin','Link','listOrder','','友情链接排序','','友情链接排序'),(14,7,2,0,10000,'admin','Link','toggle','','友情链接显示隐藏','','友情链接显示隐藏'),(15,6,1,1,10,'admin','Mailer','index','','邮箱配置','','邮箱配置'),(16,15,2,0,10000,'admin','Mailer','indexPost','','邮箱配置提交保存','','邮箱配置提交保存'),(17,15,1,0,10000,'admin','Mailer','template','','邮件模板','','邮件模板'),(18,15,2,0,10000,'admin','Mailer','templatePost','','邮件模板提交','','邮件模板提交'),(19,15,1,0,10000,'admin','Mailer','test','','邮件发送测试','','邮件发送测试'),(20,6,1,0,10000,'admin','Menu','index','','后台菜单','','后台菜单管理'),(21,20,1,0,10000,'admin','Menu','lists','','所有菜单','','后台所有菜单列表'),(22,20,1,0,10000,'admin','Menu','add','','后台菜单添加','','后台菜单添加'),(23,20,2,0,10000,'admin','Menu','addPost','','后台菜单添加提交保存','','后台菜单添加提交保存'),(24,20,1,0,10000,'admin','Menu','edit','','后台菜单编辑','','后台菜单编辑'),(25,20,2,0,10000,'admin','Menu','editPost','','后台菜单编辑提交保存','','后台菜单编辑提交保存'),(26,20,2,0,10000,'admin','Menu','delete','','后台菜单删除','','后台菜单删除'),(27,20,2,0,10000,'admin','Menu','listOrder','','后台菜单排序','','后台菜单排序'),(28,20,1,0,10000,'admin','Menu','getActions','','导入新后台菜单','','导入新后台菜单'),(29,6,1,1,30,'admin','Nav','index','','导航管理','','导航管理'),(30,29,1,0,10000,'admin','Nav','add','','添加导航','','添加导航'),(31,29,2,0,10000,'admin','Nav','addPost','','添加导航提交保存','','添加导航提交保存'),(32,29,1,0,10000,'admin','Nav','edit','','编辑导航','','编辑导航'),(33,29,2,0,10000,'admin','Nav','editPost','','编辑导航提交保存','','编辑导航提交保存'),(34,29,2,0,10000,'admin','Nav','delete','','删除导航','','删除导航'),(35,29,1,0,10000,'admin','NavMenu','index','','导航菜单','','导航菜单'),(36,35,1,0,10000,'admin','NavMenu','add','','添加导航菜单','','添加导航菜单'),(37,35,2,0,10000,'admin','NavMenu','addPost','','添加导航菜单提交保存','','添加导航菜单提交保存'),(38,35,1,0,10000,'admin','NavMenu','edit','','编辑导航菜单','','编辑导航菜单'),(39,35,2,0,10000,'admin','NavMenu','editPost','','编辑导航菜单提交保存','','编辑导航菜单提交保存'),(40,35,2,0,10000,'admin','NavMenu','delete','','删除导航菜单','','删除导航菜单'),(41,35,2,0,10000,'admin','NavMenu','listOrder','','导航菜单排序','','导航菜单排序'),(42,1,1,1,10000,'admin','Plugin','index','','插件列表','','插件列表'),(43,42,2,0,10000,'admin','Plugin','toggle','','插件启用禁用','','插件启用禁用'),(44,42,1,0,10000,'admin','Plugin','setting','','插件设置','','插件设置'),(45,42,2,0,10000,'admin','Plugin','settingPost','','插件设置提交','','插件设置提交'),(46,42,2,0,10000,'admin','Plugin','install','','插件安装','','插件安装'),(47,42,2,0,10000,'admin','Plugin','update','','插件更新','','插件更新'),(48,42,2,0,10000,'admin','Plugin','uninstall','','卸载插件','','卸载插件'),(49,110,0,1,10000,'admin','User','default','','管理组','','管理组'),(50,49,1,1,10000,'admin','Rbac','index','','角色管理','','角色管理'),(51,50,1,0,10000,'admin','Rbac','roleAdd','','添加角色','','添加角色'),(52,50,2,0,10000,'admin','Rbac','roleAddPost','','添加角色提交','','添加角色提交'),(53,50,1,0,10000,'admin','Rbac','roleEdit','','编辑角色','','编辑角色'),(54,50,2,0,10000,'admin','Rbac','roleEditPost','','编辑角色提交','','编辑角色提交'),(55,50,2,0,10000,'admin','Rbac','roleDelete','','删除角色','','删除角色'),(56,50,1,0,10000,'admin','Rbac','authorize','','设置角色权限','','设置角色权限'),(57,50,2,0,10000,'admin','Rbac','authorizePost','','角色授权提交','','角色授权提交'),(58,0,1,0,10000,'admin','RecycleBin','index','','回收站','','回收站'),(59,58,2,0,10000,'admin','RecycleBin','restore','','回收站还原','','回收站还原'),(60,58,2,0,10000,'admin','RecycleBin','delete','','回收站彻底删除','','回收站彻底删除'),(61,6,1,1,10000,'admin','Route','index','','URL美化','','URL规则管理'),(62,61,1,0,10000,'admin','Route','add','','添加路由规则','','添加路由规则'),(63,61,2,0,10000,'admin','Route','addPost','','添加路由规则提交','','添加路由规则提交'),(64,61,1,0,10000,'admin','Route','edit','','路由规则编辑','','路由规则编辑'),(65,61,2,0,10000,'admin','Route','editPost','','路由规则编辑提交','','路由规则编辑提交'),(66,61,2,0,10000,'admin','Route','delete','','路由规则删除','','路由规则删除'),(67,61,2,0,10000,'admin','Route','ban','','路由规则禁用','','路由规则禁用'),(68,61,2,0,10000,'admin','Route','open','','路由规则启用','','路由规则启用'),(69,61,2,0,10000,'admin','Route','listOrder','','路由规则排序','','路由规则排序'),(70,61,1,0,10000,'admin','Route','select','','选择URL','','选择URL'),(71,6,1,1,0,'admin','Setting','site','','网站信息','','网站信息'),(72,71,2,0,10000,'admin','Setting','sitePost','','网站信息设置提交','','网站信息设置提交'),(73,6,1,0,10000,'admin','Setting','password','','密码修改','','密码修改'),(74,73,2,0,10000,'admin','Setting','passwordPost','','密码修改提交','','密码修改提交'),(75,6,1,1,10000,'admin','Setting','upload','','上传设置','','上传设置'),(76,75,2,0,10000,'admin','Setting','uploadPost','','上传设置提交','','上传设置提交'),(77,6,1,0,10000,'admin','Setting','clearCache','','清除缓存','','清除缓存'),(78,6,1,1,40,'admin','Slide','index','','幻灯片管理','','幻灯片管理'),(79,78,1,0,10000,'admin','Slide','add','','添加幻灯片','','添加幻灯片'),(80,78,2,0,10000,'admin','Slide','addPost','','添加幻灯片提交','','添加幻灯片提交'),(81,78,1,0,10000,'admin','Slide','edit','','编辑幻灯片','','编辑幻灯片'),(82,78,2,0,10000,'admin','Slide','editPost','','编辑幻灯片提交','','编辑幻灯片提交'),(83,78,2,0,10000,'admin','Slide','delete','','删除幻灯片','','删除幻灯片'),(84,78,1,0,10000,'admin','SlideItem','index','','幻灯片页面列表','','幻灯片页面列表'),(85,84,1,0,10000,'admin','SlideItem','add','','幻灯片页面添加','','幻灯片页面添加'),(86,84,2,0,10000,'admin','SlideItem','addPost','','幻灯片页面添加提交','','幻灯片页面添加提交'),(87,84,1,0,10000,'admin','SlideItem','edit','','幻灯片页面编辑','','幻灯片页面编辑'),(88,84,2,0,10000,'admin','SlideItem','editPost','','幻灯片页面编辑提交','','幻灯片页面编辑提交'),(89,84,2,0,10000,'admin','SlideItem','delete','','幻灯片页面删除','','幻灯片页面删除'),(90,84,2,0,10000,'admin','SlideItem','ban','','幻灯片页面隐藏','','幻灯片页面隐藏'),(91,84,2,0,10000,'admin','SlideItem','cancelBan','','幻灯片页面显示','','幻灯片页面显示'),(92,84,2,0,10000,'admin','SlideItem','listOrder','','幻灯片页面排序','','幻灯片页面排序'),(93,6,1,1,10000,'admin','Storage','index','','文件存储','','文件存储'),(94,93,2,0,10000,'admin','Storage','settingPost','','文件存储设置提交','','文件存储设置提交'),(95,6,1,1,20,'admin','Theme','index','','模板管理','','模板管理'),(96,95,1,0,10000,'admin','Theme','install','','安装模板','','安装模板'),(97,95,2,0,10000,'admin','Theme','uninstall','','卸载模板','','卸载模板'),(98,95,2,0,10000,'admin','Theme','installTheme','','模板安装','','模板安装'),(99,95,2,0,10000,'admin','Theme','update','','模板更新','','模板更新'),(100,95,2,0,10000,'admin','Theme','active','','启用模板','','启用模板'),(101,95,1,0,10000,'admin','Theme','files','','模板文件列表','','启用模板'),(102,95,1,0,10000,'admin','Theme','fileSetting','','模板文件设置','','模板文件设置'),(103,95,1,0,10000,'admin','Theme','fileArrayData','','模板文件数组数据列表','','模板文件数组数据列表'),(104,95,2,0,10000,'admin','Theme','fileArrayDataEdit','','模板文件数组数据添加编辑','','模板文件数组数据添加编辑'),(105,95,2,0,10000,'admin','Theme','fileArrayDataEditPost','','模板文件数组数据添加编辑提交保存','','模板文件数组数据添加编辑提交保存'),(106,95,2,0,10000,'admin','Theme','fileArrayDataDelete','','模板文件数组数据删除','','模板文件数组数据删除'),(107,95,2,0,10000,'admin','Theme','settingPost','','模板文件编辑提交保存','','模板文件编辑提交保存'),(108,95,1,0,10000,'admin','Theme','dataSource','','模板文件设置数据源','','模板文件设置数据源'),(109,95,1,0,10000,'admin','Theme','design','','模板设计','','模板设计'),(110,0,0,1,10,'user','AdminIndex','default','','用户管理','group','用户管理'),(111,49,1,1,10000,'admin','User','index','','管理员','','管理员管理'),(112,111,1,0,10000,'admin','User','add','','管理员添加','','管理员添加'),(113,111,2,0,10000,'admin','User','addPost','','管理员添加提交','','管理员添加提交'),(114,111,1,0,10000,'admin','User','edit','','管理员编辑','','管理员编辑'),(115,111,2,0,10000,'admin','User','editPost','','管理员编辑提交','','管理员编辑提交'),(116,111,1,0,10000,'admin','User','userInfo','','个人信息','','管理员个人信息修改'),(117,111,2,0,10000,'admin','User','userInfoPost','','管理员个人信息修改提交','','管理员个人信息修改提交'),(118,111,2,0,10000,'admin','User','delete','','管理员删除','','管理员删除'),(119,111,2,0,10000,'admin','User','ban','','停用管理员','','停用管理员'),(120,111,2,0,10000,'admin','User','cancelBan','','启用管理员','','启用管理员'),(121,0,1,0,10000,'user','AdminAsset','index','','资源管理','file','资源管理列表'),(122,121,2,0,10000,'user','AdminAsset','delete','','删除文件','','删除文件'),(123,110,0,1,10000,'user','AdminIndex','default1','','用户组','','用户组'),(124,123,1,1,10000,'user','AdminIndex','index','','本站用户','','本站用户'),(125,124,2,0,10000,'user','AdminIndex','ban','','本站用户拉黑','','本站用户拉黑'),(126,124,2,0,10000,'user','AdminIndex','cancelBan','','本站用户启用','','本站用户启用'),(127,123,1,1,10000,'user','AdminOauth','index','','第三方用户','','第三方用户'),(128,127,2,0,10000,'user','AdminOauth','delete','','删除第三方用户绑定','','删除第三方用户绑定'),(129,6,1,1,10000,'user','AdminUserAction','index','','用户操作管理','','用户操作管理'),(130,129,1,0,10000,'user','AdminUserAction','edit','','编辑用户操作','','编辑用户操作'),(131,129,2,0,10000,'user','AdminUserAction','editPost','','编辑用户操作提交','','编辑用户操作提交'),(132,129,1,0,10000,'user','AdminUserAction','sync','','同步用户操作','','同步用户操作'),(162,0,0,1,30,'portal','AdminIndex','default','','门户管理','th','门户管理'),(163,162,1,1,10000,'portal','AdminArticle','index','','文章管理','','文章列表'),(164,163,1,0,10000,'portal','AdminArticle','add','','添加文章','','添加文章'),(165,163,2,0,10000,'portal','AdminArticle','addPost','','添加文章提交','','添加文章提交'),(166,163,1,0,10000,'portal','AdminArticle','edit','','编辑文章','','编辑文章'),(167,163,2,0,10000,'portal','AdminArticle','editPost','','编辑文章提交','','编辑文章提交'),(168,163,2,0,10000,'portal','AdminArticle','delete','','文章删除','','文章删除'),(169,163,2,0,10000,'portal','AdminArticle','publish','','文章发布','','文章发布'),(170,163,2,0,10000,'portal','AdminArticle','top','','文章置顶','','文章置顶'),(171,163,2,0,10000,'portal','AdminArticle','recommend','','文章推荐','','文章推荐'),(172,163,2,0,10000,'portal','AdminArticle','listOrder','','文章排序','','文章排序'),(173,162,1,1,10000,'portal','AdminCategory','index','','分类管理','','文章分类列表'),(174,173,1,0,10000,'portal','AdminCategory','add','','添加文章分类','','添加文章分类'),(175,173,2,0,10000,'portal','AdminCategory','addPost','','添加文章分类提交','','添加文章分类提交'),(176,173,1,0,10000,'portal','AdminCategory','edit','','编辑文章分类','','编辑文章分类'),(177,173,2,0,10000,'portal','AdminCategory','editPost','','编辑文章分类提交','','编辑文章分类提交'),(178,173,1,0,10000,'portal','AdminCategory','select','','文章分类选择对话框','','文章分类选择对话框'),(179,173,2,0,10000,'portal','AdminCategory','listOrder','','文章分类排序','','文章分类排序'),(180,173,2,0,10000,'portal','AdminCategory','toggle','','文章分类显示隐藏','','文章分类显示隐藏'),(181,173,2,0,10000,'portal','AdminCategory','delete','','删除文章分类','','删除文章分类'),(182,162,1,1,10000,'portal','AdminPage','index','','页面管理','','页面管理'),(183,182,1,0,10000,'portal','AdminPage','add','','添加页面','','添加页面'),(184,182,2,0,10000,'portal','AdminPage','addPost','','添加页面提交','','添加页面提交'),(185,182,1,0,10000,'portal','AdminPage','edit','','编辑页面','','编辑页面'),(186,182,2,0,10000,'portal','AdminPage','editPost','','编辑页面提交','','编辑页面提交'),(187,182,2,0,10000,'portal','AdminPage','delete','','删除页面','','删除页面'),(188,162,1,1,10000,'portal','AdminTag','index','','文章标签','','文章标签'),(189,188,1,0,10000,'portal','AdminTag','add','','添加文章标签','','添加文章标签'),(190,188,2,0,10000,'portal','AdminTag','addPost','','添加文章标签提交','','添加文章标签提交'),(191,188,2,0,10000,'portal','AdminTag','upStatus','','更新标签状态','','更新标签状态'),(192,188,2,0,10000,'portal','AdminTag','delete','','删除文章标签','','删除文章标签'),(193,58,2,0,10000,'admin','RecycleBin','clear','','清空回收站','','一键清空回收站');
/*!40000 ALTER TABLE `cmf_admin_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_asset`
--

DROP TABLE IF EXISTS `cmf_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,35631,1620396005,1,0,'983401c6ec8e6426e3d38f2234d95f29721953ae7b12e7b8213e446fbc493bca','logo.png','default/20210507/ef007386300ac8ccb2671ae1812b01ff.png','983401c6ec8e6426e3d38f2234d95f29','c327594ed95b6337da14b5fa4ecdcfe3f45b46bd','png',NULL),(2,1,10398,1620396025,1,0,'05e30f222fc049055e63b5350f37af4636d25309337986b5020e7333cc9b7b95','资源 2@2x.png','default/20210507/6520b5a8baed66f0805aab72e40708c6.png','05e30f222fc049055e63b5350f37af46','1f008c1aaf97645ab68c71f9923f9bb9acf3fbe5','png',NULL),(3,1,755256,1620396086,1,0,'faf3bd8afac57a8f92d2242bd304fab2322271e53a7613f67fd47f9006e0b41a','banner.jpg','default/20210507/3873aa21dee34e640fc25fdd1be8d830.jpg','faf3bd8afac57a8f92d2242bd304fab2','94f6edaa812b93850fc68475c58f792481dc1400','jpg',NULL),(4,1,49603,1620396826,1,0,'e4adc93b06649b760967188e5c0261c8c8a2d446d31a533bdf02bbf4f2156490','mini-progrom.jpeg','default/20210507/55450e2741b9181097339743a3d0abf4.jpeg','e4adc93b06649b760967188e5c0261c8','47072e2ae4bb280a3ce0daedd72b625042dcb631','jpeg',NULL),(5,1,6463,1620396862,1,0,'ca7cc519b77bbe7358d0d48001a652fc7ff8b32d59df6cbc6f199881d94bfa97','scan.png','default/20210507/2511930a02b0625bc62358f4f9569db0.png','ca7cc519b77bbe7358d0d48001a652fc','3252c399b4e6a1e6d60ceb35a3f25f1a10e32cc6','png',NULL),(6,1,29884,1620396908,1,0,'ce2265f8470f26c27145f1f3c82566a7500ead182f592bb23aee68965454b6ff','waimai.png','default/20210507/6923fb56125866ba49a53ae1f4970ad8.png','ce2265f8470f26c27145f1f3c82566a7','88cf915880282fea96fb1b74227e2cbe9e9bcc15','png',NULL),(7,1,33680,1620396948,1,0,'52079efcb1dcdf1b261d3aa446bfe7e2a7e7ce519c748508ab699591de3ef20c','hyyx.png','default/20210507/e60a384e50d35d2353deb7e71d69c276.png','52079efcb1dcdf1b261d3aa446bfe7e2','944829cabf3b3f619bd5ffc60324330330968b75','png',NULL);
/*!40000 ALTER TABLE `cmf_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_auth_access`
--

DROP TABLE IF EXISTS `cmf_auth_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_auth_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限授权表';
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
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(40) NOT NULL DEFAULT '' COMMENT '规则所属app',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `module` (`app`,`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='权限规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule`
--

LOCK TABLES `cmf_auth_rule` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule` DISABLE KEYS */;
INSERT INTO `cmf_auth_rule` VALUES (1,1,'admin','admin_url','admin/Hook/index','','钩子管理',''),(2,1,'admin','admin_url','admin/Hook/plugins','','钩子插件管理',''),(3,1,'admin','admin_url','admin/Hook/pluginListOrder','','钩子插件排序',''),(4,1,'admin','admin_url','admin/Hook/sync','','同步钩子',''),(5,1,'admin','admin_url','admin/Link/index','','友情链接',''),(6,1,'admin','admin_url','admin/Link/add','','添加友情链接',''),(7,1,'admin','admin_url','admin/Link/addPost','','添加友情链接提交保存',''),(8,1,'admin','admin_url','admin/Link/edit','','编辑友情链接',''),(9,1,'admin','admin_url','admin/Link/editPost','','编辑友情链接提交保存',''),(10,1,'admin','admin_url','admin/Link/delete','','删除友情链接',''),(11,1,'admin','admin_url','admin/Link/listOrder','','友情链接排序',''),(12,1,'admin','admin_url','admin/Link/toggle','','友情链接显示隐藏',''),(13,1,'admin','admin_url','admin/Mailer/index','','邮箱配置',''),(14,1,'admin','admin_url','admin/Mailer/indexPost','','邮箱配置提交保存',''),(15,1,'admin','admin_url','admin/Mailer/template','','邮件模板',''),(16,1,'admin','admin_url','admin/Mailer/templatePost','','邮件模板提交',''),(17,1,'admin','admin_url','admin/Mailer/test','','邮件发送测试',''),(18,1,'admin','admin_url','admin/Menu/index','','后台菜单',''),(19,1,'admin','admin_url','admin/Menu/lists','','所有菜单',''),(20,1,'admin','admin_url','admin/Menu/add','','后台菜单添加',''),(21,1,'admin','admin_url','admin/Menu/addPost','','后台菜单添加提交保存',''),(22,1,'admin','admin_url','admin/Menu/edit','','后台菜单编辑',''),(23,1,'admin','admin_url','admin/Menu/editPost','','后台菜单编辑提交保存',''),(24,1,'admin','admin_url','admin/Menu/delete','','后台菜单删除',''),(25,1,'admin','admin_url','admin/Menu/listOrder','','后台菜单排序',''),(26,1,'admin','admin_url','admin/Menu/getActions','','导入新后台菜单',''),(27,1,'admin','admin_url','admin/Nav/index','','导航管理',''),(28,1,'admin','admin_url','admin/Nav/add','','添加导航',''),(29,1,'admin','admin_url','admin/Nav/addPost','','添加导航提交保存',''),(30,1,'admin','admin_url','admin/Nav/edit','','编辑导航',''),(31,1,'admin','admin_url','admin/Nav/editPost','','编辑导航提交保存',''),(32,1,'admin','admin_url','admin/Nav/delete','','删除导航',''),(33,1,'admin','admin_url','admin/NavMenu/index','','导航菜单',''),(34,1,'admin','admin_url','admin/NavMenu/add','','添加导航菜单',''),(35,1,'admin','admin_url','admin/NavMenu/addPost','','添加导航菜单提交保存',''),(36,1,'admin','admin_url','admin/NavMenu/edit','','编辑导航菜单',''),(37,1,'admin','admin_url','admin/NavMenu/editPost','','编辑导航菜单提交保存',''),(38,1,'admin','admin_url','admin/NavMenu/delete','','删除导航菜单',''),(39,1,'admin','admin_url','admin/NavMenu/listOrder','','导航菜单排序',''),(40,1,'admin','admin_url','admin/Plugin/default','','插件中心',''),(41,1,'admin','admin_url','admin/Plugin/index','','插件列表',''),(42,1,'admin','admin_url','admin/Plugin/toggle','','插件启用禁用',''),(43,1,'admin','admin_url','admin/Plugin/setting','','插件设置',''),(44,1,'admin','admin_url','admin/Plugin/settingPost','','插件设置提交',''),(45,1,'admin','admin_url','admin/Plugin/install','','插件安装',''),(46,1,'admin','admin_url','admin/Plugin/update','','插件更新',''),(47,1,'admin','admin_url','admin/Plugin/uninstall','','卸载插件',''),(48,1,'admin','admin_url','admin/Rbac/index','','角色管理',''),(49,1,'admin','admin_url','admin/Rbac/roleAdd','','添加角色',''),(50,1,'admin','admin_url','admin/Rbac/roleAddPost','','添加角色提交',''),(51,1,'admin','admin_url','admin/Rbac/roleEdit','','编辑角色',''),(52,1,'admin','admin_url','admin/Rbac/roleEditPost','','编辑角色提交',''),(53,1,'admin','admin_url','admin/Rbac/roleDelete','','删除角色',''),(54,1,'admin','admin_url','admin/Rbac/authorize','','设置角色权限',''),(55,1,'admin','admin_url','admin/Rbac/authorizePost','','角色授权提交',''),(56,1,'admin','admin_url','admin/RecycleBin/index','','回收站',''),(57,1,'admin','admin_url','admin/RecycleBin/restore','','回收站还原',''),(58,1,'admin','admin_url','admin/RecycleBin/delete','','回收站彻底删除',''),(59,1,'admin','admin_url','admin/Route/index','','URL美化',''),(60,1,'admin','admin_url','admin/Route/add','','添加路由规则',''),(61,1,'admin','admin_url','admin/Route/addPost','','添加路由规则提交',''),(62,1,'admin','admin_url','admin/Route/edit','','路由规则编辑',''),(63,1,'admin','admin_url','admin/Route/editPost','','路由规则编辑提交',''),(64,1,'admin','admin_url','admin/Route/delete','','路由规则删除',''),(65,1,'admin','admin_url','admin/Route/ban','','路由规则禁用',''),(66,1,'admin','admin_url','admin/Route/open','','路由规则启用',''),(67,1,'admin','admin_url','admin/Route/listOrder','','路由规则排序',''),(68,1,'admin','admin_url','admin/Route/select','','选择URL',''),(69,1,'admin','admin_url','admin/Setting/default','','设置',''),(70,1,'admin','admin_url','admin/Setting/site','','网站信息',''),(71,1,'admin','admin_url','admin/Setting/sitePost','','网站信息设置提交',''),(72,1,'admin','admin_url','admin/Setting/password','','密码修改',''),(73,1,'admin','admin_url','admin/Setting/passwordPost','','密码修改提交',''),(74,1,'admin','admin_url','admin/Setting/upload','','上传设置',''),(75,1,'admin','admin_url','admin/Setting/uploadPost','','上传设置提交',''),(76,1,'admin','admin_url','admin/Setting/clearCache','','清除缓存',''),(77,1,'admin','admin_url','admin/Slide/index','','幻灯片管理',''),(78,1,'admin','admin_url','admin/Slide/add','','添加幻灯片',''),(79,1,'admin','admin_url','admin/Slide/addPost','','添加幻灯片提交',''),(80,1,'admin','admin_url','admin/Slide/edit','','编辑幻灯片',''),(81,1,'admin','admin_url','admin/Slide/editPost','','编辑幻灯片提交',''),(82,1,'admin','admin_url','admin/Slide/delete','','删除幻灯片',''),(83,1,'admin','admin_url','admin/SlideItem/index','','幻灯片页面列表',''),(84,1,'admin','admin_url','admin/SlideItem/add','','幻灯片页面添加',''),(85,1,'admin','admin_url','admin/SlideItem/addPost','','幻灯片页面添加提交',''),(86,1,'admin','admin_url','admin/SlideItem/edit','','幻灯片页面编辑',''),(87,1,'admin','admin_url','admin/SlideItem/editPost','','幻灯片页面编辑提交',''),(88,1,'admin','admin_url','admin/SlideItem/delete','','幻灯片页面删除',''),(89,1,'admin','admin_url','admin/SlideItem/ban','','幻灯片页面隐藏',''),(90,1,'admin','admin_url','admin/SlideItem/cancelBan','','幻灯片页面显示',''),(91,1,'admin','admin_url','admin/SlideItem/listOrder','','幻灯片页面排序',''),(92,1,'admin','admin_url','admin/Storage/index','','文件存储',''),(93,1,'admin','admin_url','admin/Storage/settingPost','','文件存储设置提交',''),(94,1,'admin','admin_url','admin/Theme/index','','模板管理',''),(95,1,'admin','admin_url','admin/Theme/install','','安装模板',''),(96,1,'admin','admin_url','admin/Theme/uninstall','','卸载模板',''),(97,1,'admin','admin_url','admin/Theme/installTheme','','模板安装',''),(98,1,'admin','admin_url','admin/Theme/update','','模板更新',''),(99,1,'admin','admin_url','admin/Theme/active','','启用模板',''),(100,1,'admin','admin_url','admin/Theme/files','','模板文件列表',''),(101,1,'admin','admin_url','admin/Theme/fileSetting','','模板文件设置',''),(102,1,'admin','admin_url','admin/Theme/fileArrayData','','模板文件数组数据列表',''),(103,1,'admin','admin_url','admin/Theme/fileArrayDataEdit','','模板文件数组数据添加编辑',''),(104,1,'admin','admin_url','admin/Theme/fileArrayDataEditPost','','模板文件数组数据添加编辑提交保存',''),(105,1,'admin','admin_url','admin/Theme/fileArrayDataDelete','','模板文件数组数据删除',''),(106,1,'admin','admin_url','admin/Theme/settingPost','','模板文件编辑提交保存',''),(107,1,'admin','admin_url','admin/Theme/dataSource','','模板文件设置数据源',''),(108,1,'admin','admin_url','admin/Theme/design','','模板设计',''),(109,1,'admin','admin_url','admin/User/default','','管理组',''),(110,1,'admin','admin_url','admin/User/index','','管理员',''),(111,1,'admin','admin_url','admin/User/add','','管理员添加',''),(112,1,'admin','admin_url','admin/User/addPost','','管理员添加提交',''),(113,1,'admin','admin_url','admin/User/edit','','管理员编辑',''),(114,1,'admin','admin_url','admin/User/editPost','','管理员编辑提交',''),(115,1,'admin','admin_url','admin/User/userInfo','','个人信息',''),(116,1,'admin','admin_url','admin/User/userInfoPost','','管理员个人信息修改提交',''),(117,1,'admin','admin_url','admin/User/delete','','管理员删除',''),(118,1,'admin','admin_url','admin/User/ban','','停用管理员',''),(119,1,'admin','admin_url','admin/User/cancelBan','','启用管理员',''),(120,1,'user','admin_url','user/AdminAsset/index','','资源管理',''),(121,1,'user','admin_url','user/AdminAsset/delete','','删除文件',''),(122,1,'user','admin_url','user/AdminIndex/default','','用户管理',''),(123,1,'user','admin_url','user/AdminIndex/default1','','用户组',''),(124,1,'user','admin_url','user/AdminIndex/index','','本站用户',''),(125,1,'user','admin_url','user/AdminIndex/ban','','本站用户拉黑',''),(126,1,'user','admin_url','user/AdminIndex/cancelBan','','本站用户启用',''),(127,1,'user','admin_url','user/AdminOauth/index','','第三方用户',''),(128,1,'user','admin_url','user/AdminOauth/delete','','删除第三方用户绑定',''),(129,1,'user','admin_url','user/AdminUserAction/index','','用户操作管理',''),(130,1,'user','admin_url','user/AdminUserAction/edit','','编辑用户操作',''),(131,1,'user','admin_url','user/AdminUserAction/editPost','','编辑用户操作提交',''),(132,1,'user','admin_url','user/AdminUserAction/sync','','同步用户操作',''),(162,1,'portal','admin_url','portal/AdminArticle/index','','文章管理',''),(163,1,'portal','admin_url','portal/AdminArticle/add','','添加文章',''),(164,1,'portal','admin_url','portal/AdminArticle/addPost','','添加文章提交',''),(165,1,'portal','admin_url','portal/AdminArticle/edit','','编辑文章',''),(166,1,'portal','admin_url','portal/AdminArticle/editPost','','编辑文章提交',''),(167,1,'portal','admin_url','portal/AdminArticle/delete','','文章删除',''),(168,1,'portal','admin_url','portal/AdminArticle/publish','','文章发布',''),(169,1,'portal','admin_url','portal/AdminArticle/top','','文章置顶',''),(170,1,'portal','admin_url','portal/AdminArticle/recommend','','文章推荐',''),(171,1,'portal','admin_url','portal/AdminArticle/listOrder','','文章排序',''),(172,1,'portal','admin_url','portal/AdminCategory/index','','分类管理',''),(173,1,'portal','admin_url','portal/AdminCategory/add','','添加文章分类',''),(174,1,'portal','admin_url','portal/AdminCategory/addPost','','添加文章分类提交',''),(175,1,'portal','admin_url','portal/AdminCategory/edit','','编辑文章分类',''),(176,1,'portal','admin_url','portal/AdminCategory/editPost','','编辑文章分类提交',''),(177,1,'portal','admin_url','portal/AdminCategory/select','','文章分类选择对话框',''),(178,1,'portal','admin_url','portal/AdminCategory/listOrder','','文章分类排序',''),(179,1,'portal','admin_url','portal/AdminCategory/toggle','','文章分类显示隐藏',''),(180,1,'portal','admin_url','portal/AdminCategory/delete','','删除文章分类',''),(181,1,'portal','admin_url','portal/AdminIndex/default','','门户管理',''),(182,1,'portal','admin_url','portal/AdminPage/index','','页面管理',''),(183,1,'portal','admin_url','portal/AdminPage/add','','添加页面',''),(184,1,'portal','admin_url','portal/AdminPage/addPost','','添加页面提交',''),(185,1,'portal','admin_url','portal/AdminPage/edit','','编辑页面',''),(186,1,'portal','admin_url','portal/AdminPage/editPost','','编辑页面提交',''),(187,1,'portal','admin_url','portal/AdminPage/delete','','删除页面',''),(188,1,'portal','admin_url','portal/AdminTag/index','','文章标签',''),(189,1,'portal','admin_url','portal/AdminTag/add','','添加文章标签',''),(190,1,'portal','admin_url','portal/AdminTag/addPost','','添加文章标签提交',''),(191,1,'portal','admin_url','portal/AdminTag/upStatus','','更新标签状态',''),(192,1,'portal','admin_url','portal/AdminTag/delete','','删除文章标签',''),(193,1,'admin','admin_url','admin/RecycleBin/clear','','清空回收站','');
/*!40000 ALTER TABLE `cmf_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_comment`
--

DROP TABLE IF EXISTS `cmf_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `dislike_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '不喜欢数',
  `floor` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼层数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text COMMENT '原文地址',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '评论内容',
  `more` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `table_id_status` (`table_name`,`object_id`,`status`),
  KEY `object_id` (`object_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_comment`
--

LOCK TABLES `cmf_comment` WRITE;
/*!40000 ALTER TABLE `cmf_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_hook`
--

DROP TABLE IF EXISTS `cmf_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子;4:后台模板钩子)',
  `once` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统钩子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_hook`
--

LOCK TABLES `cmf_hook` WRITE;
/*!40000 ALTER TABLE `cmf_hook` DISABLE KEYS */;
INSERT INTO `cmf_hook` VALUES (2,1,0,'应用开始','app_begin','cmf','应用开始'),(3,1,0,'模块初始化','module_init','cmf','模块初始化'),(4,1,0,'控制器开始','action_begin','cmf','控制器开始'),(5,1,0,'视图输出过滤','view_filter','cmf','视图输出过滤'),(6,1,0,'应用结束','app_end','cmf','应用结束'),(7,1,0,'日志write方法','log_write','cmf','日志write方法'),(8,1,0,'输出结束','response_end','cmf','输出结束'),(9,1,0,'后台控制器初始化','admin_init','cmf','后台控制器初始化'),(10,1,0,'前台控制器初始化','home_init','cmf','前台控制器初始化'),(11,1,1,'发送手机验证码','send_mobile_verification_code','cmf','发送手机验证码'),(12,3,0,'模板 body标签开始','body_start','','模板 body标签开始'),(13,3,0,'模板 head标签结束前','before_head_end','','模板 head标签结束前'),(14,3,0,'模板底部开始','footer_start','','模板底部开始'),(15,3,0,'模板底部开始之前','before_footer','','模板底部开始之前'),(16,3,0,'模板底部结束之前','before_footer_end','','模板底部结束之前'),(17,3,0,'模板 body 标签结束之前','before_body_end','','模板 body 标签结束之前'),(18,3,0,'模板左边栏开始','left_sidebar_start','','模板左边栏开始'),(19,3,0,'模板左边栏结束之前','before_left_sidebar_end','','模板左边栏结束之前'),(20,3,0,'模板右边栏开始','right_sidebar_start','','模板右边栏开始'),(21,3,0,'模板右边栏结束之前','before_right_sidebar_end','','模板右边栏结束之前'),(22,3,1,'评论区','comment','','评论区'),(23,3,1,'留言区','guestbook','','留言区'),(24,2,0,'后台首页仪表盘','admin_dashboard','admin','后台首页仪表盘'),(25,4,0,'后台模板 head标签结束前','admin_before_head_end','','后台模板 head标签结束前'),(26,4,0,'后台模板 body 标签结束之前','admin_before_body_end','','后台模板 body 标签结束之前'),(27,2,0,'后台登录页面','admin_login','admin','后台登录页面'),(28,1,1,'前台模板切换','switch_theme','cmf','前台模板切换'),(29,3,0,'主要内容之后','after_content','','主要内容之后'),(32,2,1,'获取上传界面','fetch_upload_view','user','获取上传界面'),(33,3,0,'主要内容之前','before_content','cmf','主要内容之前'),(34,1,0,'日志写入完成','log_write_done','cmf','日志写入完成'),(35,1,1,'后台模板切换','switch_admin_theme','cmf','后台模板切换'),(36,1,1,'验证码图片','captcha_image','cmf','验证码图片'),(37,2,1,'后台模板设计界面','admin_theme_design_view','admin','后台模板设计界面'),(38,2,1,'后台设置网站信息界面','admin_setting_site_view','admin','后台设置网站信息界面'),(39,2,1,'后台清除缓存界面','admin_setting_clear_cache_view','admin','后台清除缓存界面'),(40,2,1,'后台导航管理界面','admin_nav_index_view','admin','后台导航管理界面'),(41,2,1,'后台友情链接管理界面','admin_link_index_view','admin','后台友情链接管理界面'),(42,2,1,'后台幻灯片管理界面','admin_slide_index_view','admin','后台幻灯片管理界面'),(43,2,1,'后台管理员列表界面','admin_user_index_view','admin','后台管理员列表界面'),(44,2,1,'后台角色管理界面','admin_rbac_index_view','admin','后台角色管理界面'),(49,2,1,'用户管理本站用户列表界面','user_admin_index_view','user','用户管理本站用户列表界面'),(50,2,1,'资源管理列表界面','user_admin_asset_index_view','user','资源管理列表界面'),(51,2,1,'用户管理第三方用户列表界面','user_admin_oauth_index_view','user','用户管理第三方用户列表界面'),(52,2,1,'后台首页界面','admin_index_index_view','admin','后台首页界面'),(53,2,1,'后台回收站界面','admin_recycle_bin_index_view','admin','后台回收站界面'),(54,2,1,'后台菜单管理界面','admin_menu_index_view','admin','后台菜单管理界面'),(55,2,1,'后台自定义登录是否开启钩子','admin_custom_login_open','admin','后台自定义登录是否开启钩子'),(64,2,1,'后台幻灯片页面列表界面','admin_slide_item_index_view','admin','后台幻灯片页面列表界面'),(65,2,1,'后台幻灯片页面添加界面','admin_slide_item_add_view','admin','后台幻灯片页面添加界面'),(66,2,1,'后台幻灯片页面编辑界面','admin_slide_item_edit_view','admin','后台幻灯片页面编辑界面'),(67,2,1,'后台管理员添加界面','admin_user_add_view','admin','后台管理员添加界面'),(68,2,1,'后台管理员编辑界面','admin_user_edit_view','admin','后台管理员编辑界面'),(69,2,1,'后台角色添加界面','admin_rbac_role_add_view','admin','后台角色添加界面'),(70,2,1,'后台角色编辑界面','admin_rbac_role_edit_view','admin','后台角色编辑界面'),(71,2,1,'后台角色授权界面','admin_rbac_authorize_view','admin','后台角色授权界面'),(72,2,0,'演示钩子','demo_hook_test','demo','演示钩子');
/*!40000 ALTER TABLE `cmf_hook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_hook_plugin`
--

DROP TABLE IF EXISTS `cmf_hook_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_hook_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(50) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统钩子插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_hook_plugin`
--

LOCK TABLES `cmf_hook_plugin` WRITE;
/*!40000 ALTER TABLE `cmf_hook_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_hook_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_link`
--

DROP TABLE IF EXISTS `cmf_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='友情链接表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_link`
--

LOCK TABLES `cmf_link` WRITE;
/*!40000 ALTER TABLE `cmf_link` DISABLE KEYS */;
INSERT INTO `cmf_link` VALUES (1,1,1,8,'thinkcmf官网','http://www.thinkcmf.com','ThinkCMF','','_blank','');
/*!40000 ALTER TABLE `cmf_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_nav`
--

DROP TABLE IF EXISTS `cmf_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_main` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='前台导航位置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_nav`
--

LOCK TABLES `cmf_nav` WRITE;
/*!40000 ALTER TABLE `cmf_nav` DISABLE KEYS */;
INSERT INTO `cmf_nav` VALUES (1,1,'主导航','主导航'),(2,0,'底部导航','');
/*!40000 ALTER TABLE `cmf_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_nav_menu`
--

DROP TABLE IF EXISTS `cmf_nav_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_nav_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='前台导航菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_nav_menu`
--

LOCK TABLES `cmf_nav_menu` WRITE;
/*!40000 ALTER TABLE `cmf_nav_menu` DISABLE KEYS */;
INSERT INTO `cmf_nav_menu` VALUES (1,1,0,1,0,'首页','','home','','0-1');
/*!40000 ALTER TABLE `cmf_nav_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_option`
--

DROP TABLE IF EXISTS `cmf_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_option` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoload` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='全站配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_option`
--

LOCK TABLES `cmf_option` WRITE;
/*!40000 ALTER TABLE `cmf_option` DISABLE KEYS */;
INSERT INTO `cmf_option` VALUES (1,1,'site_info','{\"site_name\":\"码上点智慧门店餐饮小程序\",\"site_seo_title\":\"码上点智慧门店餐饮小程序\",\"site_seo_keywords\":\"小程序,码上点,智慧门店\",\"site_seo_description\":\"码上点-助力商户快速实现数字化，最专业的小程序SaaS运营商，为餐企提供独立外卖、堂食、电商、营销、运营等工具及服务\"}');
/*!40000 ALTER TABLE `cmf_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_plugin`
--

DROP TABLE IF EXISTS `cmf_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_plugin`
--

LOCK TABLES `cmf_plugin` WRITE;
/*!40000 ALTER TABLE `cmf_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_category`
--

DROP TABLE IF EXISTS `cmf_portal_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_portal_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(255) NOT NULL DEFAULT '',
  `list_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类文章页模板',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='portal应用 文章分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_category`
--

LOCK TABLES `cmf_portal_category` WRITE;
/*!40000 ALTER TABLE `cmf_portal_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_category_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_portal_category_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 分类文章对应表';
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:已发布;0:未发布;',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_favorites` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `published_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `post_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` text COMMENT '文章内容',
  `post_content_filtered` text COMMENT '处理过的文章内容',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  KEY `parent_id` (`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='portal应用 文章表';
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
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签文章数',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='portal应用 文章标签表';
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
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签 id',
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 标签文章对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_tag_post`
--

LOCK TABLES `cmf_portal_tag_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_tag_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_tag_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_recycle_bin`
--

DROP TABLE IF EXISTS `cmf_recycle_bin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_recycle_bin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT=' 回收站';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_recycle_bin`
--

LOCK TABLES `cmf_recycle_bin` WRITE;
/*!40000 ALTER TABLE `cmf_recycle_bin` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_recycle_bin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_role`
--

DROP TABLE IF EXISTS `cmf_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role`
--

LOCK TABLES `cmf_role` WRITE;
/*!40000 ALTER TABLE `cmf_role` DISABLE KEYS */;
INSERT INTO `cmf_role` VALUES (1,0,1,1329633709,1329633709,0,'超级管理员','拥有网站最高管理员权限！'),(2,0,1,1329633709,1329633709,0,'普通管理员','权限由最高管理员分配！');
/*!40000 ALTER TABLE `cmf_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_role_user`
--

DROP TABLE IF EXISTS `cmf_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色 id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role_user`
--

LOCK TABLES `cmf_role_user` WRITE;
/*!40000 ALTER TABLE `cmf_role_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_route`
--

DROP TABLE IF EXISTS `cmf_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '实际显示的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='url路由表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_route`
--

LOCK TABLES `cmf_route` WRITE;
/*!40000 ALTER TABLE `cmf_route` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_slide`
--

DROP TABLE IF EXISTS `cmf_slide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='幻灯片表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_slide`
--

LOCK TABLES `cmf_slide` WRITE;
/*!40000 ALTER TABLE `cmf_slide` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_slide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_slide_item`
--

DROP TABLE IF EXISTS `cmf_slide_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_slide_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT '0' COMMENT '幻灯片id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '幻灯片内容',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `slide_id` (`slide_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='幻灯片子项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_slide_item`
--

LOCK TABLES `cmf_slide_item` WRITE;
/*!40000 ALTER TABLE `cmf_slide_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_slide_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_theme`
--

DROP TABLE IF EXISTS `cmf_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后升级时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_theme`
--

LOCK TABLES `cmf_theme` WRITE;
/*!40000 ALTER TABLE `cmf_theme` DISABLE KEYS */;
INSERT INTO `cmf_theme` VALUES (1,0,0,0,0,'default','default','1.0.0','http://demo.thinkcmf.com','','ThinkCMF','http://www.thinkcmf.com','zh-cn','ThinkCMF默认模板','ThinkCMF默认模板'),(2,0,0,0,0,'HjDesign001','火箭源码','1.0.0','http://exam.hji5.com/network/001/public/','','告白气球','http://www.hji5.com','zh-cn','【响应式网络设计公司】火箭源码','响应式网络设计资源共享类企业网站(自适应手机端)-火箭源码');
/*!40000 ALTER TABLE `cmf_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_theme_file`
--

DROP TABLE IF EXISTS `cmf_theme_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_theme_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_public` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text COMMENT '模板更多配置,用户临时保存的配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_theme_file`
--

LOCK TABLES `cmf_theme_file` WRITE;
/*!40000 ALTER TABLE `cmf_theme_file` DISABLE KEYS */;
INSERT INTO `cmf_theme_file` VALUES (1,0,5,'default','首页','demo/Index/index','demo/index','首页模板文件','{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}','{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}',NULL),(2,0,6,'HjDesign001','关于我们','portal/Page/index','portal/about','关于我们模板文件','{\"vars\":{\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u4e00\\u7ad9\\u5f0f\\u670d\\u52a1\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u865a\\u6000\\u82e5\\u8c37\\uff0c\\u4e0a\\u5584\\u82e5\\u6c34\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"about\":{\"title\":\"\\u5c55\\u793a\\u6d88\\u606f\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u5c55\\u793a\\u6d88\\u606f\",\"value\":[{\"title\":\"\\u5173\\u4e8e\\u6211\\u4eec\",\"more\":\"\\u4e00\\u4e2a\\u4e13\\u6ce8\\u4e8e\\u9ad8\\u7aef\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\\u3001\\u7f51\\u7ad9\\u4f18\\u5316\\u8fd0\\u8425\\u3001\\u7f51\\u7edc\\u54c1\\u724c\\u7b56\\u5212\\u53ca\\u878d\\u5408\\u8425\\u9500\\u4f20\\u64ad\\u7684\\u56e2\\u961f\\u3002\",\"content\":\"\\u5e38\\u5dde\\u8c6a\\u9a8f\\u7f51\\u7edc\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\\uff0c\\u6210\\u7acb\\u4e8e2017\\u5e74\\uff0c\\u81ea\\u521b\\u59cb\\u4e4b\\u65e5\\u8d77\\u81f3\\u4eca\\uff0c\\u59cb\\u7ec8\\u4fdd\\u6301\\u8d85\\u4e4e\\u5bfb\\u5e38\\u7684\\u6210\\u957f\\u901f\\u5ea6\\uff0c\\u5df2\\u4e3a\\u591a\\u5bb6\\u4f01\\u4e1a\\u5b9e\\u73b0\\u89c6\\u89c9\\u548c\\u54c1\\u724c\\u7684\\u63d0\\u5347\\uff0c\\u79ef\\u7d2f\\u4e86\\u4e30\\u5bcc\\u7684\\u7ecf\\u9a8c\\u3002\\u8c6a\\u9a8f\\u662f\\u4e00\\u652f\\u878d\\u54c1\\u724c\\u578b\\/\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\\uff0c\\u7f51\\u7ad9\\u8fd0\\u8425\\u670d\\u52a1\\uff0c\\u7f51\\u7edc\\u8425\\u9500\\u670d\\u52a1\\uff0c\\u7f51\\u7ad9\\u4f18\\u5316\\u91cd\\u6784\\uff0c\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\\uff0c\\u641c\\u7d22\\u5f15\\u64ce\\u4f18\\u5316\\uff08SEO\\uff09\\uff0c\\u4ea4\\u4e92\\u8bbe\\u8ba1\\u3001\\u53ca\\u7f51\\u7edc\\u54c1\\u724c\\u7b56\\u5212\\u3001\\u521b\\u65b0\\u3001\\u89c6\\u89c9\\u8bbe\\u8ba1\\u4e8e\\u4e00\\u4f53\\u7684\\u4e13\\u4e1a\\u8bbe\\u8ba1\\u4e0e\\u7b56\\u5212\\u56e2\\u961f\\uff0c\\u9f0e\\u529b\\u4e3a\\u56fd\\u5185\\u5916\\u4f01\\u4e1a\\u63d0\\u4f9b\\u5168\\u65b9\\u4f4d\\u7684\\u4e92\\u8054\\u7f51\\u53ca\\u79fb\\u52a8\\u4e92\\u8054\\u7f51\\u7cbe\\u51c6\\u5168\\u7f51\\u8425\\u9500\\u670d\\u52a1\\u89e3\\u51b3\\u65b9\\u6848\\u3002\"},{\"title\":\"\\u56e2\\u961f\\u6587\\u5316\",\"more\":\"\\u79d1\\u6280\\u3001\\u4eba\\u6587\\u3001\\u683c\\u5c40\\u51b3\\u5b9a\\u7ed3\\u5c40\",\"content\":\"\\u84dd\\uff1a\\u79d1\\u6280\\u3001\\u672a\\u6765\\u3001\\u6c89\\u7a33 | \\u601d\\uff1a\\u521b\\u65b0\\u3001\\u601d\\u60f3\\u3001\\u4eba\\u6587 | \\u683c\\uff1a\\u4e13\\u4e1a\\u3001\\u89c4\\u8303\\u3001\\u683c\\u5c40\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"more\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"team\":{\"title\":\"\\u56e2\\u961f\\u6210\\u5458\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\\u56e2\\u7ed3\\u3001\\u5411\\u4e0a\\u3001\\u4e3a\\u68a6\\u60f3\\u800c\\u751f\",\"type\":\"text\",\"rule\":{\"require\":true}},\"join_us\":{\"title\":\"\\u52a0\\u5165\\u6211\\u4eecURL\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u6dfb\\u52a0\\u804c\\u4e1a\",\"value\":[{\"name\":\"L.REN\",\"avatar\":\"\",\"job\":\"\\u521b\\u59cb\\u4eba\\/\\u8425\\u9500\\u7b56\\u5212\\u5e08\"}],\"type\":\"array\",\"item\":{\"name\":{\"title\":\"\\u59d3\\u540d\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"avatar\":{\"title\":\"\\u5934\\u50cf\",\"value\":\"\",\"type\":\"image\",\"rule\":{\"require\":true}},\"job\":{\"title\":\"\\u804c\\u4e1a\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"rightpic\":{\"title\":\"\\u53f3\\u56fe\\u5c55\\u793a\",\"display\":\"1\",\"vars\":{\"image\":{\"title\":\"\\u53f3\\u56fe\\u5c55\\u793a\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u56fe\\u7247\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u56fe\\u7247\"}}}}}','{\"vars\":{\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u4e00\\u7ad9\\u5f0f\\u670d\\u52a1\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u865a\\u6000\\u82e5\\u8c37\\uff0c\\u4e0a\\u5584\\u82e5\\u6c34\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"about\":{\"title\":\"\\u5c55\\u793a\\u6d88\\u606f\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u5c55\\u793a\\u6d88\\u606f\",\"value\":[{\"title\":\"\\u5173\\u4e8e\\u6211\\u4eec\",\"more\":\"\\u4e00\\u4e2a\\u4e13\\u6ce8\\u4e8e\\u9ad8\\u7aef\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\\u3001\\u7f51\\u7ad9\\u4f18\\u5316\\u8fd0\\u8425\\u3001\\u7f51\\u7edc\\u54c1\\u724c\\u7b56\\u5212\\u53ca\\u878d\\u5408\\u8425\\u9500\\u4f20\\u64ad\\u7684\\u56e2\\u961f\\u3002\",\"content\":\"\\u5e38\\u5dde\\u8c6a\\u9a8f\\u7f51\\u7edc\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\\uff0c\\u6210\\u7acb\\u4e8e2017\\u5e74\\uff0c\\u81ea\\u521b\\u59cb\\u4e4b\\u65e5\\u8d77\\u81f3\\u4eca\\uff0c\\u59cb\\u7ec8\\u4fdd\\u6301\\u8d85\\u4e4e\\u5bfb\\u5e38\\u7684\\u6210\\u957f\\u901f\\u5ea6\\uff0c\\u5df2\\u4e3a\\u591a\\u5bb6\\u4f01\\u4e1a\\u5b9e\\u73b0\\u89c6\\u89c9\\u548c\\u54c1\\u724c\\u7684\\u63d0\\u5347\\uff0c\\u79ef\\u7d2f\\u4e86\\u4e30\\u5bcc\\u7684\\u7ecf\\u9a8c\\u3002\\u8c6a\\u9a8f\\u662f\\u4e00\\u652f\\u878d\\u54c1\\u724c\\u578b\\/\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\\uff0c\\u7f51\\u7ad9\\u8fd0\\u8425\\u670d\\u52a1\\uff0c\\u7f51\\u7edc\\u8425\\u9500\\u670d\\u52a1\\uff0c\\u7f51\\u7ad9\\u4f18\\u5316\\u91cd\\u6784\\uff0c\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\\uff0c\\u641c\\u7d22\\u5f15\\u64ce\\u4f18\\u5316\\uff08SEO\\uff09\\uff0c\\u4ea4\\u4e92\\u8bbe\\u8ba1\\u3001\\u53ca\\u7f51\\u7edc\\u54c1\\u724c\\u7b56\\u5212\\u3001\\u521b\\u65b0\\u3001\\u89c6\\u89c9\\u8bbe\\u8ba1\\u4e8e\\u4e00\\u4f53\\u7684\\u4e13\\u4e1a\\u8bbe\\u8ba1\\u4e0e\\u7b56\\u5212\\u56e2\\u961f\\uff0c\\u9f0e\\u529b\\u4e3a\\u56fd\\u5185\\u5916\\u4f01\\u4e1a\\u63d0\\u4f9b\\u5168\\u65b9\\u4f4d\\u7684\\u4e92\\u8054\\u7f51\\u53ca\\u79fb\\u52a8\\u4e92\\u8054\\u7f51\\u7cbe\\u51c6\\u5168\\u7f51\\u8425\\u9500\\u670d\\u52a1\\u89e3\\u51b3\\u65b9\\u6848\\u3002\"},{\"title\":\"\\u56e2\\u961f\\u6587\\u5316\",\"more\":\"\\u79d1\\u6280\\u3001\\u4eba\\u6587\\u3001\\u683c\\u5c40\\u51b3\\u5b9a\\u7ed3\\u5c40\",\"content\":\"\\u84dd\\uff1a\\u79d1\\u6280\\u3001\\u672a\\u6765\\u3001\\u6c89\\u7a33 | \\u601d\\uff1a\\u521b\\u65b0\\u3001\\u601d\\u60f3\\u3001\\u4eba\\u6587 | \\u683c\\uff1a\\u4e13\\u4e1a\\u3001\\u89c4\\u8303\\u3001\\u683c\\u5c40\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"more\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"team\":{\"title\":\"\\u56e2\\u961f\\u6210\\u5458\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\\u56e2\\u7ed3\\u3001\\u5411\\u4e0a\\u3001\\u4e3a\\u68a6\\u60f3\\u800c\\u751f\",\"type\":\"text\",\"rule\":{\"require\":true}},\"join_us\":{\"title\":\"\\u52a0\\u5165\\u6211\\u4eecURL\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u6dfb\\u52a0\\u804c\\u4e1a\",\"value\":[{\"name\":\"L.REN\",\"avatar\":\"\",\"job\":\"\\u521b\\u59cb\\u4eba\\/\\u8425\\u9500\\u7b56\\u5212\\u5e08\"}],\"type\":\"array\",\"item\":{\"name\":{\"title\":\"\\u59d3\\u540d\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"avatar\":{\"title\":\"\\u5934\\u50cf\",\"value\":\"\",\"type\":\"image\",\"rule\":{\"require\":true}},\"job\":{\"title\":\"\\u804c\\u4e1a\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"rightpic\":{\"title\":\"\\u53f3\\u56fe\\u5c55\\u793a\",\"display\":\"1\",\"vars\":{\"image\":{\"title\":\"\\u53f3\\u56fe\\u5c55\\u793a\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u56fe\\u7247\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u56fe\\u7247\"}}}}}',NULL),(3,0,10,'HjDesign001','文章详情页','portal/Article/index','portal/article','文章详情页模板文件','{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}','{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}',NULL),(4,0,7,'HjDesign001','联系我们','portal/Page/index','portal/contacts','联系我们模板文件','{\"vars\":{\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u4e13\\u4e1a\\u63d0\\u4f9b\\u7092\\u7c73\\u7c89\\u6781\\u54c1\\u6a21\\u677f\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\\uff0c\\u83b7\\u5f97\\u4e13\\u4e1a\\u7684\\u652f\\u6301\\u548c\\u670d\\u52a1\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"rule\":{\"require\":true}}}},\"map\":{\"title\":\"\\u5730\\u56fe\\u56fe\\u7247\",\"display\":\"1\",\"vars\":{\"background\":{\"title\":\"\\u5730\\u56fe\\u56fe\\u7247\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5730\\u56fe\\u56fe\\u7247\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u5730\\u56fe\\u56fe\\u7247\",\"rule\":{\"require\":true}}}},\"about\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\\u6211\\u4eec\\u5df2\\u7ecf\\u51c6\\u5907\\u597d\\u4e86\\uff0c\\u968f\\u65f6\\u4e3a\\u60a8\\u63d0\\u4f9b\\u4e13\\u4e1a\\u7684\\u652f\\u6301\\u3002\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eecURL\",\"value\":\"http:\\/\\/wpa.qq.com\\/msgrd?v=3&uin=1140444693&site=qq&menu=yes\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link_btn\":{\"title\":\"\\u6309\\u94ae\\u6587\\u5b57\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u83b7\\u53d6\\u62a5\\u4ef7\\u4fe1\\u606f\",\"type\":\"text\",\"rule\":{\"require\":true}},\"address\":{\"title\":\"\\u8be6\\u7ec6\\u5730\\u5740\",\"value\":\"\\u6c5f\\u82cf\\u7701\\u5e38\\u5dde\\u5e02\\u6b66\\u8fdb\\u533a\\u79d1\\u6559\\u4f1a\\u5802\",\"type\":\"text\",\"tip\":\"\\u8be6\\u7ec6\\u5730\\u5740\"},\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u4eba\",\"value\":\"\\u6234\\u7ecf\\u7406\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u4eba\"},\"email\":{\"title\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\\uff1a\",\"value\":\"1140444693@qq.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\"},\"tel\":{\"title\":\"\\u8054\\u7cfb\\u7535\\u8bdd\",\"value\":\"+86 151 6117 8722\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u7535\\u8bdd\"},\"QQ\":{\"title\":\"QQ\\u53f7\\u7801\",\"value\":\"1140444693\",\"type\":\"text\",\"tip\":\"QQ\\u53f7\\u7801\"}}}}}','{\"vars\":{\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u4e13\\u4e1a\\u63d0\\u4f9b\\u7092\\u7c73\\u7c89\\u6781\\u54c1\\u6a21\\u677f\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\\uff0c\\u83b7\\u5f97\\u4e13\\u4e1a\\u7684\\u652f\\u6301\\u548c\\u670d\\u52a1\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"rule\":{\"require\":true}}}},\"map\":{\"title\":\"\\u5730\\u56fe\\u56fe\\u7247\",\"display\":\"1\",\"vars\":{\"background\":{\"title\":\"\\u5730\\u56fe\\u56fe\\u7247\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5730\\u56fe\\u56fe\\u7247\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u5730\\u56fe\\u56fe\\u7247\",\"rule\":{\"require\":true}}}},\"about\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\\u6211\\u4eec\\u5df2\\u7ecf\\u51c6\\u5907\\u597d\\u4e86\\uff0c\\u968f\\u65f6\\u4e3a\\u60a8\\u63d0\\u4f9b\\u4e13\\u4e1a\\u7684\\u652f\\u6301\\u3002\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eecURL\",\"value\":\"http:\\/\\/wpa.qq.com\\/msgrd?v=3&uin=1140444693&site=qq&menu=yes\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link_btn\":{\"title\":\"\\u6309\\u94ae\\u6587\\u5b57\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u83b7\\u53d6\\u62a5\\u4ef7\\u4fe1\\u606f\",\"type\":\"text\",\"rule\":{\"require\":true}},\"address\":{\"title\":\"\\u8be6\\u7ec6\\u5730\\u5740\",\"value\":\"\\u6c5f\\u82cf\\u7701\\u5e38\\u5dde\\u5e02\\u6b66\\u8fdb\\u533a\\u79d1\\u6559\\u4f1a\\u5802\",\"type\":\"text\",\"tip\":\"\\u8be6\\u7ec6\\u5730\\u5740\"},\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u4eba\",\"value\":\"\\u6234\\u7ecf\\u7406\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u4eba\"},\"email\":{\"title\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\\uff1a\",\"value\":\"1140444693@qq.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\"},\"tel\":{\"title\":\"\\u8054\\u7cfb\\u7535\\u8bdd\",\"value\":\"+86 151 6117 8722\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u7535\\u8bdd\"},\"QQ\":{\"title\":\"QQ\\u53f7\\u7801\",\"value\":\"1140444693\",\"type\":\"text\",\"tip\":\"QQ\\u53f7\\u7801\"}}}}}',NULL),(5,0,2,'HjDesign001','首页','portal/Index/index','portal/index','首页模板文件','{\"vars\":{\"features_header\":{\"title\":\"\\u9996\\u9875\\u6309\\u94aeURL\",\"value\":\"https:\\/\\/console.mashangdian.cn\",\"type\":\"text\",\"tip\":\"\\u9996\\u9875\\u6309\\u94aeURL\",\"rule\":{\"require\":false}},\"our_services\":{\"title\":\"\\u6211\\u4eec\\u7684\\u670d\\u52a1URL\",\"value\":\"https:\\/\\/console.mashangdian.cn\",\"type\":\"text\",\"tip\":\"\\u6211\\u4eec\\u7684\\u670d\\u52a1URL\",\"rule\":{\"require\":false}},\"our_works\":{\"title\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1URL\",\"value\":\"https:\\/\\/console.mashangdian.cn\",\"type\":\"text\",\"tip\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1URL\",\"rule\":{\"require\":false}},\"packages\":{\"title\":\"\\u670d\\u52a1\\u5957\\u9910URL\",\"value\":\"https:\\/\\/console.mashangdian.cn\",\"type\":\"text\",\"tip\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1URL\",\"rule\":{\"require\":false}}},\"widgets\":{\"features\":{\"title\":\"\\u4e00\\u7ad9\\u5f0f\\u667a\\u6167\\u95e8\\u5e97\\u5c0f\\u7a0b\\u5e8f\",\"display\":1,\"vars\":{\"sub_title\":{\"title\":\"\\u8bbe\\u7f6e\\u6309\\u94ae\",\"value\":\"\\u514d\\u8d39\\u4f53\\u9a8c\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"default\\/20210507\\/3873aa21dee34e640fc25fdd1be8d830.jpg\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"services\":{\"title\":\"\\u6211\\u4eec\\u7684\\u670d\\u52a1 Our Services\",\"display\":1,\"vars\":{\"features\":{\"title\":\"\\u670d\\u52a1\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"\\u5c0f\\u7a0b\\u5e8f\",\"etitle\":\"Mini Progrom\",\"icon\":\"default\\/20210507\\/55450e2741b9181097339743a3d0abf4.jpeg\",\"content\":\"\\u5c0f\\u7a0b\\u5e8f\\u6210\\u4e3a\\u65b0\\u4e00\\u8f6e\\u7ebf\\u4e0a\\u8425\\u9500\\u5229\\u5668\\uff0c\\u501f\\u529b\\u751f\\u6001\\u5185\\u81ea\\u8eab\\u7528\\u6237\\uff0c\\u5c0f\\u7a0b\\u5e8f\\u7528\\u6237\\u6570\\u91cf\\u6301\\u7eed\\u589e\\u957f\\uff0c\\u5e02\\u573a\\u7a7a\\u95f4\\u5de8\\u5927\\u3002\\u652f\\u6301\\u652f\\u4ed8\\u5b9d\\u5fae\\u4fe1\\u5c0f\\u7a0b\\u5e8f\\u4e00\\u952e\\u63a5\\u5165\"},{\"title\":\"\\u626b\\u7801\\u70b9\\u9910\",\"etitle\":\"Scan Qrcode\",\"icon\":\"default\\/20210507\\/2511930a02b0625bc62358f4f9569db0.png\",\"content\":\"\\u626b\\u7801\\u70b9\\u9910\\uff0c\\u987e\\u5ba2\\u5230\\u5e97\\u65e0\\u9700\\u7b49\\u5f85\\u670d\\u52a1\\u5458\\u83dc\\u5355\\u70b9\\u83dc\\uff0c\\u987e\\u5ba2\\u5165\\u5ea7\\u5373\\u53ef\\u626b\\u7801\\u70b9\\u9910\\uff0c\\u70b9\\u9910\\u81ea\\u52a9\\u4ed8\\u6b3e\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u63a5\\u5355\\u6253\\u5370\\uff0c\\u8282\\u7ea6\\u4eba\\u529b\\u6210\\u672c\\uff0c\\u63d0\\u9ad8\\u670d\\u52a1\\u6548\\u7387\\u3002\"},{\"title\":\"\\u81ea\\u8425\\u5916\\u5356\",\"etitle\":\"Member takeaway\",\"icon\":\"default\\/20210507\\/6923fb56125866ba49a53ae1f4970ad8.png\",\"content\":\"\\t\\u987e\\u5ba2\\u53ef\\u67e5\\u770b\\u83dc\\u5355\\u53ca\\u5373\\u65f6\\u4e0b\\u5355\\uff0c\\u81ea\\u52a8\\u901a\\u77e5\\u5546\\u5bb6\\u5546\\u5bb6\\u968f\\u65f6\\u67e5\\u770b\\/\\u4fee\\u6539\\/\\u5ba1\\u6838\\u8ba2\\u5355\\u4fe1\\u606f\\uff0c\\u56de\\u590d\\u901a\\u77e5\\u987e\\u5ba2\\u907f\\u514d\\u987e\\u5ba2\\u70b9\\u9910\\u9ad8\\u5cf0\\u671f\\u7535\\u8bdd\\u96be\\u62e8\\u901a\\uff0c\\u964d\\u4f4e\\u5546\\u5bb6\\u6f0f\\u5355\\uff0c\\u9519\\u5355\\u72b6\\u51b5\"},{\"title\":\"\\u4f1a\\u5458\\u8425\\u9500\",\"etitle\":\"Affiliate marketing\",\"icon\":\"default\\/20210507\\/e60a384e50d35d2353deb7e71d69c276.png\",\"content\":\"\\t\\u628a\\u63e1\\u5230\\u5e97\\u6d41\\u91cf\\uff0c\\u591a\\u79cd\\u8425\\u9500\\u5de5\\u5177\\uff0c\\u591a\\u5e97\\u5171\\u4eab\\u4f1a\\u5458\\uff0c\\u5b9a\\u671f\\u63a8\\u9001\\u5404\\u7c7b\\u6d3b\\u52a8\\u5230\\u987e\\u5ba2\\uff0c\\u62c9\\u65b0\\u5956\\u52b1\\u3001\\u81ea\\u52a8\\u53d1\\u9001\\uff0c\\u4f1a\\u5458\\u81ea\\u52a8\\u4eab\\u53d7\\u5bf9\\u5e94\\u4f1a\\u5458\\u6298\\u6263\\u3001\\u4f1a\\u5458\\u4ef7\\u3001\\u4f18\\u60e0\\u5238\\u6d3b\\u52a8\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u82f1\\u6587\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"advantages\":{\"title\":\"\\u6211\\u4eec\\u7684\\u4f18\\u52bf Our Advantages\",\"display\":0,\"vars\":{\"features\":{\"title\":\"\\u4f18\\u52bf\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"\\u8bbe\\u8ba1\\uff1a\\u7b80\\u6d01\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u8303\\u513f\\uff0c\\u4ece\\u6b64\\u5c31\\u9ad8\\u5927\\u4e0a\\u4e86\",\"pic\":\"\",\"content\":\"\\u5584\\u4e8e\\u505a\\u51cf\\u6cd5\\uff0c\\u5c11\\u5373\\u662f\\u591a\\uff0c\\u4e00\\u53e5\\u89e6\\u52a8\\u5fc3\\u5f26\\u7684\\u8bdd\\u8bed\\uff0c\\u8fdc\\u80dc\\u4e8e\\u957f\\u7bc7\\u5927\\u8bba\\u3002\\u8bbe\\u8ba1\\u6e05\\u65b0\\u8131\\u4fd7\\uff0c\\u7ed3\\u6784\\u6e05\\u6670\\u660e\\u4e86\\uff0c\\u8ba9\\u7528\\u6237\\u7b2c\\u4e00\\u65f6\\u95f4\\u627e\\u5230\\u60f3\\u8981\\u7684\\u5185\\u5bb9\\uff0c\\u63d0\\u9ad8\\u7f51\\u7ad9\\u7c98\\u5ea6\\u3001\\u83b7\\u53d6\\u7528\\u6237\\u4fe1\\u4efb\\uff0c\\u4ee5\\u6fc0\\u53d1\\u7528\\u6237\\u8f6c\\u5316\\u3002\"},{\"title\":\"\\u683c\\u5c40\\uff1a\\u56fd\\u9645\\u54cd\\u5e94\\u5f0f\\u7f51\\u9875\\u7ec8\\u7aef\\uff0c\\u6ee1\\u8db3\\u5f53\\u4e0b\\uff0c\\u517c\\u5bb9\\u672a\\u6765\",\"pic\":\"\",\"content\":\"\\u56fd\\u9645\\u6700\\u65b0\\u7684HMTL5+CSS3\\u67b6\\u6784\\uff0c\\u54cd\\u5e94\\u5f0f\\u7f51\\u9875\\u6280\\u672f\\uff0c\\u5b8c\\u7f8e\\u9002\\u5e94PC\\u3001\\u5e73\\u677f\\u3001\\u624b\\u673a\\u7b49\\u591a\\u4e2a\\u7ec8\\u7aef\\uff0c\\u6240\\u6709\\u8bbe\\u5907\\u4e00\\u4e2a\\u8bbf\\u95ee\\u7f51\\u5740\\uff0c\\u9762\\u5411\\u7528\\u6237\\u548c\\u641c\\u7d22\\u5f15\\u64ce\\u53cb\\u597d\\uff0c\\u5229\\u4e8eSEO\\uff0c\\u5f3a\\u5316\\u4f01\\u4e1a\\u54c1\\u724c\\u6548\\u5e94\\u3002\"},{\"title\":\"\\u8fd0\\u7ef4\\uff1a\\u5168\\u7f51\\u8425\\u9500\\u8fd0\\u8425\\u63a8\\u5e7f\\u89e3\\u51b3\\u65b9\\u6848\\uff0c\\u8f6f\\u4ef6\\u4e0e\\u786c\\u4ef6\\u7ed3\\u5408\\uff0c\\u52a9\\u529b\\u4f01\\u4e1a\\u6210\\u529f\",\"pic\":\"\",\"content\":\"\\u4e3a\\u4f01\\u4e1a\\u6253\\u9020\\u4f18\\u79c0\\u7684\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5e73\\u53f0\\uff0c\\u540c\\u65f6\\u63d0\\u4f9b\\u540e\\u7eed\\u7684\\u8fd0\\u8425\\u63a8\\u5e7f\\u53ca\\u5168\\u7f51\\u8425\\u9500\\u652f\\u6301\\uff0c\\u589e\\u5f3a\\u4f01\\u4e1a\\u8f6f\\u5b9e\\u529b\\uff0c\\u8f6f\\u786c\\u517c\\u5907\\uff0c\\u8ba9\\u4f01\\u4e1a\\u4ece\\u4e00\\u5f00\\u59cb\\u5c31\\u907f\\u514d\\u8d70\\u5f2f\\u8def\\uff0c\\u5feb\\u901f\\u901a\\u5411\\u6210\\u529f\\u7684\\u5f7c\\u5cb8\\uff0c\\u5b9e\\u73b0\\u53cc\\u65b9\\u5171\\u8d62\\u3002\"},{\"title\":\"\\u76ee\\u6807\\uff1a\\u5c55\\u793a\\u54c1\\u724c\\uff0c\\u5f3a\\u5316\\u8425\\u9500\\uff0c\\u63d0\\u5347\\u7528\\u6237\\u5f52\\u5c5e\",\"pic\":\"\",\"content\":\"\\u54c1\\u724c\\u578b\\u7f51\\u7ad9\\/\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\\u5408\\u4e8c\\u4e3a\\u4e00\\uff0c\\u7cbe\\u51c6\\u8425\\u9500\\u5b9e\\u73b0\\u8425\\u9500\\u76ee\\u6807\\u7684\\u540c\\u65f6\\u66f4\\u52a0\\u6ce8\\u91cd\\u54c1\\u724c\\u7684\\u4f20\\u64ad\\u548c\\u5c55\\u73b0\\u529b\\u3002\\u805a\\u5408\\u7528\\u6237\\u4f53\\u9a8c\\uff0c\\u589e\\u8fdb\\u7528\\u6237\\u5f52\\u5c5e\\u548c\\u4fe1\\u8d56\\u3002\"},{\"title\":\"\\u589e\\u503c\\uff1a\\u60a8\\u80fd\\u60f3\\u5230\\u7684\\uff0c\\u6211\\u4eec\\u5df2\\u7ecf\\u5168\\u90e8\\u5e2e\\u60a8\\u60f3\\u5230\\u4e86\",\"pic\":\"\",\"content\":\"\\u6210\\u529f\\u5728\\u4e8e\\u5bf9\\u7ec6\\u8282\\u7684\\u628a\\u63a7\\uff0c\\u5168\\u5957\\u670d\\u52a1\\u4e3a\\u60a8\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u529e\\u516c\\u573a\\u5730\\u3001\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u771f\\u6b63\\u7ad9\\u5728\\u4f01\\u4e1a\\u7684\\u89d2\\u5ea6\\u53bb\\u601d\\u8003\\uff0c\\u5728\\u8425\\u9500\\u5e73\\u53f0\\u4e0a\\u5168\\u9762\\u63d0\\u5347\\u4f01\\u4e1a\\u6574\\u4f53\\u5f62\\u8c61\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"pic\":{\"title\":\"\\u56fe\\u7247\",\"value\":\"\",\"type\":\"image\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"process\":{\"title\":\"\\u670d\\u52a1\\u6d41\\u7a0b Service Process\",\"display\":1,\"vars\":{\"features\":{\"title\":\"\\u4f18\\u52bf\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"\\u9700\\u6c42\\u6316\\u6398\",\"etitle\":\"Demand\"},{\"title\":\"\\u5b9a\\u5236\\u7b56\\u5212\",\"etitle\":\"Plan\"},{\"title\":\"\\u754c\\u9762\\u5e03\\u5c40\",\"etitle\":\"Layout\"},{\"title\":\"\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"etitle\":\"Design\"},{\"title\":\"\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"etitle\":\"Program\"},{\"title\":\"\\u4f18\\u5316\\u6d4b\\u8bd5\",\"etitle\":\"Optimization\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"features_modal\":{\"title\":\"\\u670d\\u52a1\\u6d41\\u7a0b\\u8be6\\u60c5\",\"display\":1,\"vars\":{\"sub_title\":{\"title\":\"\\u5f39\\u6846\\u63cf\\u8ff0\",\"value\":\"6\\u6b65\\u4e3a\\u60a8\\u6253\\u9020\\u4e00\\u4e2a\\u4f18\\u79c0\\u7684\\u8425\\u9500\\u5e73\\u53f0\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8bbe\\u7f6e\\u5f39\\u6846\\u63cf\\u8ff0\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u5f39\\u6846\\u8be6\\u7ec6\\u63cf\\u8ff0\",\"value\":[{\"title\":\"1\\u3001\\u6838\\u5fc3\\u9700\\u6c42\\u6316\\u6398\",\"content\":\"\\u786e\\u5b9a\\u5408\\u4f5c\\u540e\\u9996\\u5148\\u4e0e\\u4f01\\u4e1a\\u8d1f\\u8d23\\u4eba\\u6df1\\u5ea6\\u6c9f\\u901a\\uff0c\\u5bf9\\u6574\\u4f53\\u8425\\u9500\\u6838\\u5fc3\\u7684\\u76ee\\u6807\\u8fbe\\u6210\\u3001\\u4f01\\u4e1a\\u54c1\\u724c\\u6587\\u5316\\u5c55\\u793a\\u3001\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\u5b9a\\u4f4d\\u7b49\\u8fdb\\u884c\\u6316\\u6398\\uff0c\\u534f\\u52a9\\u4f01\\u4e1a\\u6316\\u6398\\u6f5c\\u5728\\u7684\\u8425\\u9500\\u673a\\u4f1a\\uff0c\\u8fdb\\u884c\\u8425\\u9500\\u548c\\u54c1\\u724c\\u7684\\u521b\\u65b0\\u3002\"},{\"title\":\"2\\u3001\\u7f51\\u7ad9\\u6574\\u4f53\\u7b56\\u5212\",\"content\":\"\\u4f9d\\u636e\\u76ee\\u6807\\u548c\\u5b9a\\u4f4d\\u8fdb\\u884c\\u5206\\u6790\\u548c\\u7b56\\u5212\\uff0c\\u8fdb\\u884c\\u5185\\u5bb9\\u91cd\\u7ec4\\u3001\\u6587\\u6848\\u7b56\\u5212\\u3001\\u7f51\\u7ad9\\u7ed3\\u6784\\u7b56\\u5212\\uff0c\\u6316\\u6398\\u4f01\\u4e1a\\u7684\\u6587\\u5316\\u6838\\u5fc3\\u548c\\u7adf\\u4e89\\u4f18\\u52bf\\uff0c\\u5f70\\u663e\\u4f01\\u4e1a\\u72ec\\u6709\\u7684\\u54c1\\u724c\\u9b45\\u529b\\uff0c\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u7684\\u529e\\u516c\\u573a\\u666f\\u53ca\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u63d0\\u5347\\u6574\\u4f53\\u89c6\\u89c9\\u3002\"},{\"title\":\"3\\u3001\\u754c\\u9762\\u7ed3\\u6784\\u5e03\\u5c40\",\"content\":\"\\u6839\\u636e\\u7f51\\u7ad9\\u5185\\u5bb9\\u7684\\u91cd\\u8981\\u5c42\\u6b21\\uff0c\\u9762\\u5411\\u76ee\\u6807\\u5ba2\\u6237\\u7fa4\\u4f53\\uff0c\\u7ed3\\u5408\\u7528\\u6237\\u7684\\u6d4f\\u89c8\\u4e60\\u60ef\\u3001\\u7528\\u6237\\u5173\\u6ce8\\u5ea6\\u3001\\u51b3\\u7b56\\u4f9d\\u636e\\u7b49\\u5c5e\\u6027\\uff0c\\u5bf9\\u7f51\\u7ad9\\u5185\\u5bb9\\u6a21\\u5757\\u8fdb\\u884c\\u79d1\\u5b66\\u7684\\u5206\\u5e03\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u5173\\u5fc3\\u91cd\\u70b9\\uff0c\\u5c06\\u4f01\\u4e1a\\u6838\\u5fc3\\u670d\\u52a1\\u3001\\u54c1\\u724c\\u6587\\u5316\\u7b49\\u6eb6\\u4e8e\\u65b9\\u5bf8\\u4e4b\\u95f4\\u3002\"},{\"title\":\"4\\u3001\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"content\":\"\\u7ed3\\u5408\\u4f01\\u4e1a\\u54c1\\u724c\\u89c6\\u89c9\\u7cfb\\u7edf\\uff0c\\u4e3a\\u4f01\\u4e1a\\u6253\\u9020\\u4e13\\u5c5e\\u7684\\u79c1\\u5bb6\\u5f62\\u8c61\\uff0c\\u7b80\\u7ea6\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u5316\\u7684\\u8bbe\\u8ba1\\uff0c\\u800c\\u53c8\\u4e0d\\u5931\\u4f18\\u96c5\\u548c\\u5e73\\u548c\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\\uff0c\\u8ba9\\u7528\\u6237\\u6709\\u826f\\u597d\\u7684\\u89c6\\u89c9\\u4f53\\u9a8c\\uff0c\\u7b2c\\u4e00\\u773c\\u5c31\\u7231\\u4e0a\\uff0c\\u5b9e\\u73b0\\u4f01\\u4e1a\\u7684\\u54c1\\u724c\\u89c6\\u89c9\\u4f20\\u64ad\\u3002\"},{\"title\":\"5\\u3001\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"content\":\"\\u4e00\\u5207\\u4ee5\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u4e3a\\u4e3b\\u8981\\u65b9\\u5411\\uff0c\\u8fc7\\u591a\\u7684\\u529f\\u80fd\\u4f1a\\u7ed9\\u7528\\u6237\\u548c\\u670d\\u52a1\\u5668\\u9020\\u6210\\u538b\\u529b\\uff0c\\u7f51\\u7ad9\\u5e76\\u4e0d\\u662f\\u529f\\u80fd\\u8d8a\\u591a\\u8d8a\\u597d\\uff0c\\u6613\\u7528\\u3001\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u624d\\u662f\\u6838\\u5fc3\\uff0c\\u7f51\\u7ad9\\u5feb\\u901f\\u54cd\\u5e94\\u7528\\u6237\\u6307\\u4ee4\\uff0c\\u62d2\\u7edd\\u5ba2\\u6237\\u6d41\\u5931\\u3002\"},{\"title\":\"6\\u3001\\u4f18\\u5316\\u6d4b\\u8bd5\\u4e0a\\u7ebf\",\"content\":\"\\u7f51\\u7ad9\\u4e0a\\u7ebf\\u524d\\u4e0d\\u65ad\\u7684\\u4f18\\u5316\\u548c\\u6d4b\\u8bd5\\uff0c\\u56fe\\u7247\\u3001\\u4ee3\\u7801\\u3001\\u901f\\u5ea6\\u4f18\\u5316\\u3001\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\\u3001\\u7f51\\u7ad9\\u5185\\u5bb9\\u4f18\\u5316\\u7b49\\u3002URL\\u3001\\u6d4f\\u89c8\\u5668\\u517c\\u5bb9\\u6027\\u3001\\u670d\\u52a1\\u5668\\u627f\\u8f7d\\u538b\\u529b\\u6d4b\\u8bd5\\uff0c\\u5404\\u7c7b\\u7ec8\\u7aef\\u9002\\u914d\\u3001\\u7528\\u6237\\u4f53\\u9a8c\\u53ca\\u8f6c\\u5316\\u7387\\u6d4b\\u8bd5\\u7b49\\u3002\\u5173\\u6ce8\\u7ec6\\u8282\\uff0c\\u8ffd\\u6c42\\u5b8c\\u7f8e\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"about\":{\"title\":\"\\u5173\\u4e8e\\u6211\\u4eec\",\"display\":1,\"vars\":{\"sub_content\":{\"title\":\"\\u5173\\u4e8e\\u6211\\u4eec\\u4ecb\\u7ecd\",\"value\":\"\\u7801\\u4e0a\\u4e91\\u7f51\\u7edc\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\\u6210\\u7acb\\u4e8e2020\\u5e74\\uff0c\\u5750\\u843d\\u5728\\u7ecf\\u6d4e\\u53d1\\u8fbe\\u7684\\u4e0a\\u6d77\\uff0c\\u7531\\u4e00\\u6279\\u5e74\\u8f7b\\u3001\\u5bcc\\u6709\\u6d3b\\u529b\\u7684\\u7f51\\u7edc\\u7cbe\\u82f1\\u7ec4\\u6210\\uff0c\\u6ce8\\u5b9a\\u4e00\\u5f00\\u59cb\\u5c31\\u662f\\u4e00\\u5bb6\\u6210\\u719f\\u7684\\u7f51\\u7edc\\u79d1\\u6280\\u516c\\u53f8\\uff0c\\u4e13\\u4e1a\\u4ece\\u4e8b\\u7f51\\u7ad9\\u5efa\\u8bbe\\u3001\\u7f51\\u7ad9\\u63a8\\u5e7f\\u3001APP\\u5b9a\\u5236\\u5f00\\u53d1\\u3001\\u5fae\\u4fe1\\u5f00\\u53d1\\u548c\\u7f51\\u7edc\\u8425\\u9500\\u7684\\u591a\\u5143\\u5316\\u8f6f\\u4ef6\\u6280\\u672f\\u670d\\u52a1\\u3002\\u6211\\u4eec\\u59cb\\u7ec8\\u575a\\u6301\\u4ee5\\u5ba2\\u6237\\u4e3a\\u5bfc\\u5411\\uff0c\\u4e3a\\u8ffd\\u6c42\\u5ba2\\u6237\\u4f53\\u9a8c\\u8bbe\\u8ba1\\uff0c\\u63d0\\u4f9b\\u6709\\u9488\\u5bf9\\u6027\\u7684\\u9879\\u76ee\\u89e3\\u51b3\\u65b9\\u6848\\uff0c\\u8c6a\\u9a8f\\u4eba\\u4e0d\\u65ad\\u8d85\\u8d8a\\u81ea\\u6211\\uff0c\\u8ffd\\u6c42\\u5353\\u8d8a\\u3002\",\"type\":\"textarea\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u5173\\u4e8e\\u6211\\u4eec\\u4ecb\\u7ecd\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"energy\":{\"title\":\"\\u56e2\\u961f\\u80fd\\u91cf\\u503c Energy value\",\"display\":1,\"vars\":{\"features\":{\"title\":\"\\u56e2\\u961f\\u80fd\\u91cf\\u503c\",\"value\":[{\"title\":\"\\u5185\\u5bb9\\u7b56\\u5212\\uff1a\",\"color\":\"#3498db\",\"size\":\"92\",\"content\":\"\\u6293\\u4f4f\\u4ef7\\u503c\\u4f20\\u9012\\uff0c\\u7a81\\u51fa\\u91cd\\u70b9\\u5f31\\u5316\\u5468\\u8fb9\\u3002\"},{\"title\":\"\\u754c\\u9762\\u8bbe\\u8ba1\\uff1a\",\"color\":\"#f8b551\",\"size\":\"90\",\"content\":\"\\u5c3d\\u663e\\u7b80\\u7ea6\\u4e4b\\u7f8e\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\\u3002\"},{\"title\":\"\\u7a0b\\u5e8f\\u5f00\\u53d1\\uff1a\",\"color\":\"#73bf3a\",\"size\":\"88\",\"content\":\"\\u7b80\\u5355\\u5feb\\u901f\\uff0c\\u4e3a\\u7528\\u6237\\u548c\\u641c\\u7d22\\u5f15\\u64ce\\u800c\\u751f\\u3002\"},{\"title\":\"\\u7f51\\u7ad9\\u8fd0\\u8425\\uff1a\",\"color\":\"#ff6050\",\"size\":\"92\",\"content\":\"\\u5584\\u4e8e\\u53d1\\u73b0\\uff0c\\u4ee5\\u6570\\u636e\\u8d8b\\u52a8\\u51b3\\u7b56\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"color\":{\"title\":\"\\u989c\\u8272\",\"value\":\"\",\"type\":\"color\",\"rule\":{\"require\":true}},\"size\":{\"title\":\"\\u5927\\u5c0f\",\"value\":\"\",\"type\":\"number\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"biaoyu\":{\"title\":\"\\u6807\\u8bed\",\"display\":1,\"vars\":{\"features\":{\"title\":\"\\u6807\\u8bed\",\"value\":[{\"title\":\"\\u7cbe\\u54c1\\u4e0e\\u5e73\\u51e1\\u4e4b\\u95f4\\uff0c\\u53ea\\u662f\\u5dee\\u4e86\\u4e9b\\u8bb8\\u7684\\u8010\\u5fc3\\u548c\\u5bf9\\u5de5\\u4f5c\\u7684\\u631a\\u7231\\u3002\",\"etitle\":\"Between fine and ordinary, just patience and love to work not quite the point.\"},{\"title\":\"\\u65f6\\u95f4\\u662f\\u4e00\\u5207\\u8d22\\u5bcc\\u4e2d\\u6700\\u5b9d\\u8d35\\u7684\\u8d22\\u5bcc\\uff0c\\u60a8\\u662f\\u5426\\u8fd8\\u5728\\u5b88\\u7740\\u5e73\\u51e1\\u7684\\u8425\\u9500\\u5de5\\u5177\\u6d6a\\u8d39\\u65f6\\u95f4\\u3002\",\"etitle\":\"Time is the most valuable asset of all wealth, if you are still guarding the extraordinary marketing tool waste of time.\"},{\"title\":\"\\u4e16\\u754c\\u4e0a\\u4e00\\u6210\\u4e0d\\u53d8\\u7684\\u4e1c\\u897f\\uff0c\\u53ea\\u6709\\u201c\\u4efb\\u4f55\\u4e8b\\u7269\\u90fd\\u662f\\u5728\\u4e0d\\u65ad\\u53d8\\u5316\\u7684\\u201d\\u8fd9\\u4e00\\u6761\\u771f\\u7406\\u3002\",\"etitle\":\"World immutable things, only \'everything is constantly changing,\' this truth.\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"packages\":{\"title\":\"\\u670d\\u52a1\\u5957\\u9910 Packages\",\"display\":1,\"vars\":{\"first_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u6210\\u957f\\u578b\\u5957\\u9910\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6807\\u9898\\u5185\\u5bb9\"},\"features_first\":{\"title\":\"\\u6210\\u957f\\u578b\\u5957\\u9910\",\"value\":[{\"title\":\"\\u7cbe\\u7ec6\\u5316\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe1\\u4e2a\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u67b6\\u6784\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u7f51\\u9875\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"class\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u591a\\u7ec8\\u7aef\\u54cd\\u5e94\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8d44\\u6599\\u586b\\u5145\",\"class\":\"no\"},{\"title\":\"\\u7f51\\u7ad9\\u4e2a\\u6027\\u5185\\u5bb9\\u8bbe\\u8ba1\",\"class\":\"no\"},{\"title\":\"\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\",\"class\":\"no\"},{\"title\":\"\\u4e07\\u7f51\\u7a7a\\u95f4\\/\\u57df\\u540d1\\u5e74\",\"class\":\"\"},{\"title\":\"\\u5efa\\u7ad9\\u5468\\u671f1\\u4e2a\\u6708\",\"class\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"class\":{\"title\":\"\\u662f\\u5426\\u542f\\u7528\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u5173\\u95ed\\u4e3ano,\\u5426\\u5219\\u4e3a\\u7a7a\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"second_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u4e13\\u4e1a\\u578b\\u5957\\u9910\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6807\\u9898\\u5185\\u5bb9\"},\"features_second\":{\"title\":\"\\u4e13\\u4e1a\\u578b\\u5957\\u9910\",\"value\":[{\"title\":\"\\u7cbe\\u7ec6\\u5316\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe1\\u4e2a\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u67b6\\u6784\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u7f51\\u9875\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"class\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u591a\\u7ec8\\u7aef\\u54cd\\u5e94\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8d44\\u6599\\u586b\\u5145\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u4e2a\\u6027\\u5185\\u5bb9\\u8bbe\\u8ba1\",\"class\":\"no\"},{\"title\":\"\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\",\"class\":\"no\"},{\"title\":\"\\u4e07\\u7f51\\u7a7a\\u95f4\\/\\u57df\\u540d1\\u5e74\",\"class\":\"\"},{\"title\":\"\\u5efa\\u7ad9\\u5468\\u671f1\\u4e2a\\u6708\",\"class\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"class\":{\"title\":\"\\u662f\\u5426\\u542f\\u7528\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u5173\\u95ed\\u4e3ano,\\u5426\\u5219\\u4e3a\\u7a7a\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"third_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u9ad8\\u7aef\\u578b\\u5957\\u9910\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6807\\u9898\\u5185\\u5bb9\"},\"features_third\":{\"title\":\"\\u9ad8\\u7aef\\u578b\\u5957\\u9910\",\"value\":[{\"title\":\"\\u7cbe\\u7ec6\\u5316\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe1\\u4e2a\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u67b6\\u6784\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u7f51\\u9875\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"class\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u591a\\u7ec8\\u7aef\\u54cd\\u5e94\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8d44\\u6599\\u586b\\u5145\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u4e2a\\u6027\\u5185\\u5bb9\\u8bbe\\u8ba1\",\"class\":\"no\"},{\"title\":\"\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u4e07\\u7f51\\u7a7a\\u95f4\\/\\u57df\\u540d1\\u5e74\",\"class\":\"\"},{\"title\":\"\\u5efa\\u7ad9\\u5468\\u671f1\\u4e2a\\u6708\",\"class\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"class\":{\"title\":\"\\u662f\\u5426\\u542f\\u7528\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u5173\\u95ed\\u4e3ano,\\u5426\\u5219\\u4e3a\\u7a7a\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"our_works\":{\"title\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1 Our Works\",\"display\":0,\"vars\":{\"our_works_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true},\"valueText\":\"\"}}}}}','{\"vars\":{\"features_header\":{\"title\":\"\\u9996\\u9875\\u6309\\u94aeURL\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u9996\\u9875\\u6309\\u94aeURL\",\"rule\":{\"require\":false}},\"our_services\":{\"title\":\"\\u6211\\u4eec\\u7684\\u670d\\u52a1URL\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u6211\\u4eec\\u7684\\u670d\\u52a1URL\",\"rule\":{\"require\":false}},\"our_works\":{\"title\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1URL\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1URL\",\"rule\":{\"require\":false}},\"packages\":{\"title\":\"\\u670d\\u52a1\\u5957\\u9910URL\",\"value\":\"http:\\/\\/www.hji5.com\",\"type\":\"text\",\"tip\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1URL\",\"rule\":{\"require\":false}}},\"widgets\":{\"features\":{\"title\":\"\\u7092\\u7c73\\u7c89\\u6781\\u54c1\\u6a21\\u677f\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u8bbe\\u7f6e\\u6309\\u94ae\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"services\":{\"title\":\"\\u6211\\u4eec\\u7684\\u670d\\u52a1 Our Services\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u670d\\u52a1\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\",\"etitle\":\"Website Construction\",\"icon\":\"\",\"content\":\"\\u7cbe\\u7ec6\\u5316\\u54c1\\u724c\\u578b\\/\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\\uff0c\\u56fd\\u9645\\u5316\\u8bbe\\u8ba1\\uff0chtml5\\u56fd\\u9645\\u6807\\u51c6\\u3002\\u9762\\u5411\\u641c\\u7d22\\u5f15\\u64ce\\/\\u7528\\u6237\\u53cb\\u597d\\uff0c\\u63d0\\u5347\\u7f51\\u7ad9\\u5c55\\u793a\\u7387\\u53ca\\u5173\\u6ce8\\u5ea6\\u3002\\u4e0d\\u53ea\\u662f\\u597d\\u770b\\uff0c\\u91cd\\u8981\\u7684\\u662f\\u5b9e\\u7528\\uff0c\\u4ee5\\u7528\\u6237\\u4e3a\\u4e2d\\u5fc3\\u3002\"},{\"title\":\"\\u7f51\\u7ad9\\u8fd0\\u8425\\u63a8\\u5e7f\",\"etitle\":\"Website operators\",\"icon\":\"\",\"content\":\"\\u4e00\\u4f53\\u5316\\u7684\\u5168\\u7a0b\\u76d1\\u63a7\\u53ca\\u8fd0\\u8425\\u3002\\u6570\\u636e\\u76d1\\u63a7\\u5206\\u6790\\u3001\\u76ee\\u6807\\u7528\\u6237\\u884c\\u4e3a\\u7814\\u7a76\\u3001\\u7f51\\u7ad9\\u65e5\\u5e38\\u66f4\\u65b0\\u53ca\\u5185\\u5bb9\\u7f16\\u8f91\\u6807\\u51c6\\u5316\\u3001\\u7f51\\u7ad9\\u7b56\\u5212\\u53ca\\u63a8\\u5e7f\\u3001\\u7f51\\u7ad9\\u8fd0\\u8425\\u6d41\\u7a0b\\u4f18\\u5316\\u3001\\u7528\\u6237\\u7814\\u7a76\\u7ba1\\u7406\\u7b49\\u3002\"},{\"title\":\"\\u7f51\\u7edc\\u8425\\u9500\\u7b56\\u5212\",\"etitle\":\"Marketing Communication\",\"icon\":\"\",\"content\":\"\\u4e92\\u8054\\u7f51\\/\\u79fb\\u52a8\\u4e92\\u8054\\u5168\\u7f51\\u8425\\u9500\\u4f20\\u64ad\\uff0c\\u521b\\u9020\\u3001\\u5ba3\\u4f20\\u3001\\u4f20\\u9012\\u5ba2\\u6237\\u4ef7\\u503c\\uff0c\\u7ba1\\u7406\\u5ba2\\u6237\\u5173\\u7cfb\\uff0c\\u53d1\\u73b0\\u3001\\u6ee1\\u8db3\\u6216\\u521b\\u9020\\u987e\\u5ba2\\u9700\\u6c42\\uff0c\\u6709\\u6548\\u63d0\\u5347\\u4f01\\u4e1a\\u8ba2\\u5355\\u589e\\u957f\\u53ca\\u4f01\\u4e1a\\u54c1\\u724c\\u5f71\\u54cd\\u529b\\u3002\"},{\"title\":\"\\u7f51\\u7edc\\u54c1\\u724c\\u7ba1\\u7406\",\"etitle\":\"Brand Manage\",\"icon\":\"\",\"content\":\"\\u534f\\u52a9\\u4f01\\u4e1a\\u5bf9\\u54c1\\u724c\\u91cd\\u65b0\\u5b9a\\u4e49\\uff0c\\u6316\\u6398\\u54c1\\u724c\\u4ef7\\u503c\\u3001\\u63d0\\u5347\\u54c1\\u724c\\u8d44\\u4ea7\\u53ca\\u5185\\u90e8\\u7ba1\\u7406\\u6548\\u7387\\uff0c\\u5236\\u5b9a\\u4ee5\\u54c1\\u724c\\u6838\\u5fc3\\u4ef7\\u503c\\u4e3a\\u4e2d\\u5fc3\\u7684\\u54c1\\u724c\\u8bc6\\u522b\\u7cfb\\u7edf\\uff0c\\u4f18\\u9009\\u54c1\\u724c\\u5316\\u6218\\u7565\\u4e0e\\u54c1\\u724c\\u67b6\\u6784\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u82f1\\u6587\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"advantages\":{\"title\":\"\\u6211\\u4eec\\u7684\\u4f18\\u52bf Our Advantages\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u4f18\\u52bf\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"\\u8bbe\\u8ba1\\uff1a\\u7b80\\u6d01\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u8303\\u513f\\uff0c\\u4ece\\u6b64\\u5c31\\u9ad8\\u5927\\u4e0a\\u4e86\",\"pic\":\"\",\"content\":\"\\u5584\\u4e8e\\u505a\\u51cf\\u6cd5\\uff0c\\u5c11\\u5373\\u662f\\u591a\\uff0c\\u4e00\\u53e5\\u89e6\\u52a8\\u5fc3\\u5f26\\u7684\\u8bdd\\u8bed\\uff0c\\u8fdc\\u80dc\\u4e8e\\u957f\\u7bc7\\u5927\\u8bba\\u3002\\u8bbe\\u8ba1\\u6e05\\u65b0\\u8131\\u4fd7\\uff0c\\u7ed3\\u6784\\u6e05\\u6670\\u660e\\u4e86\\uff0c\\u8ba9\\u7528\\u6237\\u7b2c\\u4e00\\u65f6\\u95f4\\u627e\\u5230\\u60f3\\u8981\\u7684\\u5185\\u5bb9\\uff0c\\u63d0\\u9ad8\\u7f51\\u7ad9\\u7c98\\u5ea6\\u3001\\u83b7\\u53d6\\u7528\\u6237\\u4fe1\\u4efb\\uff0c\\u4ee5\\u6fc0\\u53d1\\u7528\\u6237\\u8f6c\\u5316\\u3002\"},{\"title\":\"\\u683c\\u5c40\\uff1a\\u56fd\\u9645\\u54cd\\u5e94\\u5f0f\\u7f51\\u9875\\u7ec8\\u7aef\\uff0c\\u6ee1\\u8db3\\u5f53\\u4e0b\\uff0c\\u517c\\u5bb9\\u672a\\u6765\",\"pic\":\"\",\"content\":\"\\u56fd\\u9645\\u6700\\u65b0\\u7684HMTL5+CSS3\\u67b6\\u6784\\uff0c\\u54cd\\u5e94\\u5f0f\\u7f51\\u9875\\u6280\\u672f\\uff0c\\u5b8c\\u7f8e\\u9002\\u5e94PC\\u3001\\u5e73\\u677f\\u3001\\u624b\\u673a\\u7b49\\u591a\\u4e2a\\u7ec8\\u7aef\\uff0c\\u6240\\u6709\\u8bbe\\u5907\\u4e00\\u4e2a\\u8bbf\\u95ee\\u7f51\\u5740\\uff0c\\u9762\\u5411\\u7528\\u6237\\u548c\\u641c\\u7d22\\u5f15\\u64ce\\u53cb\\u597d\\uff0c\\u5229\\u4e8eSEO\\uff0c\\u5f3a\\u5316\\u4f01\\u4e1a\\u54c1\\u724c\\u6548\\u5e94\\u3002\"},{\"title\":\"\\u8fd0\\u7ef4\\uff1a\\u5168\\u7f51\\u8425\\u9500\\u8fd0\\u8425\\u63a8\\u5e7f\\u89e3\\u51b3\\u65b9\\u6848\\uff0c\\u8f6f\\u4ef6\\u4e0e\\u786c\\u4ef6\\u7ed3\\u5408\\uff0c\\u52a9\\u529b\\u4f01\\u4e1a\\u6210\\u529f\",\"pic\":\"\",\"content\":\"\\u4e3a\\u4f01\\u4e1a\\u6253\\u9020\\u4f18\\u79c0\\u7684\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5e73\\u53f0\\uff0c\\u540c\\u65f6\\u63d0\\u4f9b\\u540e\\u7eed\\u7684\\u8fd0\\u8425\\u63a8\\u5e7f\\u53ca\\u5168\\u7f51\\u8425\\u9500\\u652f\\u6301\\uff0c\\u589e\\u5f3a\\u4f01\\u4e1a\\u8f6f\\u5b9e\\u529b\\uff0c\\u8f6f\\u786c\\u517c\\u5907\\uff0c\\u8ba9\\u4f01\\u4e1a\\u4ece\\u4e00\\u5f00\\u59cb\\u5c31\\u907f\\u514d\\u8d70\\u5f2f\\u8def\\uff0c\\u5feb\\u901f\\u901a\\u5411\\u6210\\u529f\\u7684\\u5f7c\\u5cb8\\uff0c\\u5b9e\\u73b0\\u53cc\\u65b9\\u5171\\u8d62\\u3002\"},{\"title\":\"\\u76ee\\u6807\\uff1a\\u5c55\\u793a\\u54c1\\u724c\\uff0c\\u5f3a\\u5316\\u8425\\u9500\\uff0c\\u63d0\\u5347\\u7528\\u6237\\u5f52\\u5c5e\",\"pic\":\"\",\"content\":\"\\u54c1\\u724c\\u578b\\u7f51\\u7ad9\\/\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe\\u5408\\u4e8c\\u4e3a\\u4e00\\uff0c\\u7cbe\\u51c6\\u8425\\u9500\\u5b9e\\u73b0\\u8425\\u9500\\u76ee\\u6807\\u7684\\u540c\\u65f6\\u66f4\\u52a0\\u6ce8\\u91cd\\u54c1\\u724c\\u7684\\u4f20\\u64ad\\u548c\\u5c55\\u73b0\\u529b\\u3002\\u805a\\u5408\\u7528\\u6237\\u4f53\\u9a8c\\uff0c\\u589e\\u8fdb\\u7528\\u6237\\u5f52\\u5c5e\\u548c\\u4fe1\\u8d56\\u3002\"},{\"title\":\"\\u589e\\u503c\\uff1a\\u60a8\\u80fd\\u60f3\\u5230\\u7684\\uff0c\\u6211\\u4eec\\u5df2\\u7ecf\\u5168\\u90e8\\u5e2e\\u60a8\\u60f3\\u5230\\u4e86\",\"pic\":\"\",\"content\":\"\\u6210\\u529f\\u5728\\u4e8e\\u5bf9\\u7ec6\\u8282\\u7684\\u628a\\u63a7\\uff0c\\u5168\\u5957\\u670d\\u52a1\\u4e3a\\u60a8\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u529e\\u516c\\u573a\\u5730\\u3001\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u771f\\u6b63\\u7ad9\\u5728\\u4f01\\u4e1a\\u7684\\u89d2\\u5ea6\\u53bb\\u601d\\u8003\\uff0c\\u5728\\u8425\\u9500\\u5e73\\u53f0\\u4e0a\\u5168\\u9762\\u63d0\\u5347\\u4f01\\u4e1a\\u6574\\u4f53\\u5f62\\u8c61\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"pic\":{\"title\":\"\\u56fe\\u7247\",\"value\":\"\",\"type\":\"image\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"process\":{\"title\":\"\\u670d\\u52a1\\u6d41\\u7a0b Service Process\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u4f18\\u52bf\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"\\u9700\\u6c42\\u6316\\u6398\",\"etitle\":\"Demand\"},{\"title\":\"\\u5b9a\\u5236\\u7b56\\u5212\",\"etitle\":\"Plan\"},{\"title\":\"\\u754c\\u9762\\u5e03\\u5c40\",\"etitle\":\"Layout\"},{\"title\":\"\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"etitle\":\"Design\"},{\"title\":\"\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"etitle\":\"Program\"},{\"title\":\"\\u4f18\\u5316\\u6d4b\\u8bd5\",\"etitle\":\"Optimization\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"features_modal\":{\"title\":\"\\u670d\\u52a1\\u6d41\\u7a0b\\u8be6\\u60c5\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5f39\\u6846\\u63cf\\u8ff0\",\"value\":\"6\\u6b65\\u4e3a\\u60a8\\u6253\\u9020\\u4e00\\u4e2a\\u4f18\\u79c0\\u7684\\u8425\\u9500\\u5e73\\u53f0\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8bbe\\u7f6e\\u5f39\\u6846\\u63cf\\u8ff0\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u5f39\\u6846\\u8be6\\u7ec6\\u63cf\\u8ff0\",\"value\":[{\"title\":\"1\\u3001\\u6838\\u5fc3\\u9700\\u6c42\\u6316\\u6398\",\"content\":\"\\u786e\\u5b9a\\u5408\\u4f5c\\u540e\\u9996\\u5148\\u4e0e\\u4f01\\u4e1a\\u8d1f\\u8d23\\u4eba\\u6df1\\u5ea6\\u6c9f\\u901a\\uff0c\\u5bf9\\u6574\\u4f53\\u8425\\u9500\\u6838\\u5fc3\\u7684\\u76ee\\u6807\\u8fbe\\u6210\\u3001\\u4f01\\u4e1a\\u54c1\\u724c\\u6587\\u5316\\u5c55\\u793a\\u3001\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\u5b9a\\u4f4d\\u7b49\\u8fdb\\u884c\\u6316\\u6398\\uff0c\\u534f\\u52a9\\u4f01\\u4e1a\\u6316\\u6398\\u6f5c\\u5728\\u7684\\u8425\\u9500\\u673a\\u4f1a\\uff0c\\u8fdb\\u884c\\u8425\\u9500\\u548c\\u54c1\\u724c\\u7684\\u521b\\u65b0\\u3002\"},{\"title\":\"2\\u3001\\u7f51\\u7ad9\\u6574\\u4f53\\u7b56\\u5212\",\"content\":\"\\u4f9d\\u636e\\u76ee\\u6807\\u548c\\u5b9a\\u4f4d\\u8fdb\\u884c\\u5206\\u6790\\u548c\\u7b56\\u5212\\uff0c\\u8fdb\\u884c\\u5185\\u5bb9\\u91cd\\u7ec4\\u3001\\u6587\\u6848\\u7b56\\u5212\\u3001\\u7f51\\u7ad9\\u7ed3\\u6784\\u7b56\\u5212\\uff0c\\u6316\\u6398\\u4f01\\u4e1a\\u7684\\u6587\\u5316\\u6838\\u5fc3\\u548c\\u7adf\\u4e89\\u4f18\\u52bf\\uff0c\\u5f70\\u663e\\u4f01\\u4e1a\\u72ec\\u6709\\u7684\\u54c1\\u724c\\u9b45\\u529b\\uff0c\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u7684\\u529e\\u516c\\u573a\\u666f\\u53ca\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u63d0\\u5347\\u6574\\u4f53\\u89c6\\u89c9\\u3002\"},{\"title\":\"3\\u3001\\u754c\\u9762\\u7ed3\\u6784\\u5e03\\u5c40\",\"content\":\"\\u6839\\u636e\\u7f51\\u7ad9\\u5185\\u5bb9\\u7684\\u91cd\\u8981\\u5c42\\u6b21\\uff0c\\u9762\\u5411\\u76ee\\u6807\\u5ba2\\u6237\\u7fa4\\u4f53\\uff0c\\u7ed3\\u5408\\u7528\\u6237\\u7684\\u6d4f\\u89c8\\u4e60\\u60ef\\u3001\\u7528\\u6237\\u5173\\u6ce8\\u5ea6\\u3001\\u51b3\\u7b56\\u4f9d\\u636e\\u7b49\\u5c5e\\u6027\\uff0c\\u5bf9\\u7f51\\u7ad9\\u5185\\u5bb9\\u6a21\\u5757\\u8fdb\\u884c\\u79d1\\u5b66\\u7684\\u5206\\u5e03\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u5173\\u5fc3\\u91cd\\u70b9\\uff0c\\u5c06\\u4f01\\u4e1a\\u6838\\u5fc3\\u670d\\u52a1\\u3001\\u54c1\\u724c\\u6587\\u5316\\u7b49\\u6eb6\\u4e8e\\u65b9\\u5bf8\\u4e4b\\u95f4\\u3002\"},{\"title\":\"4\\u3001\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"content\":\"\\u7ed3\\u5408\\u4f01\\u4e1a\\u54c1\\u724c\\u89c6\\u89c9\\u7cfb\\u7edf\\uff0c\\u4e3a\\u4f01\\u4e1a\\u6253\\u9020\\u4e13\\u5c5e\\u7684\\u79c1\\u5bb6\\u5f62\\u8c61\\uff0c\\u7b80\\u7ea6\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u5316\\u7684\\u8bbe\\u8ba1\\uff0c\\u800c\\u53c8\\u4e0d\\u5931\\u4f18\\u96c5\\u548c\\u5e73\\u548c\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\\uff0c\\u8ba9\\u7528\\u6237\\u6709\\u826f\\u597d\\u7684\\u89c6\\u89c9\\u4f53\\u9a8c\\uff0c\\u7b2c\\u4e00\\u773c\\u5c31\\u7231\\u4e0a\\uff0c\\u5b9e\\u73b0\\u4f01\\u4e1a\\u7684\\u54c1\\u724c\\u89c6\\u89c9\\u4f20\\u64ad\\u3002\"},{\"title\":\"5\\u3001\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"content\":\"\\u4e00\\u5207\\u4ee5\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u4e3a\\u4e3b\\u8981\\u65b9\\u5411\\uff0c\\u8fc7\\u591a\\u7684\\u529f\\u80fd\\u4f1a\\u7ed9\\u7528\\u6237\\u548c\\u670d\\u52a1\\u5668\\u9020\\u6210\\u538b\\u529b\\uff0c\\u7f51\\u7ad9\\u5e76\\u4e0d\\u662f\\u529f\\u80fd\\u8d8a\\u591a\\u8d8a\\u597d\\uff0c\\u6613\\u7528\\u3001\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u624d\\u662f\\u6838\\u5fc3\\uff0c\\u7f51\\u7ad9\\u5feb\\u901f\\u54cd\\u5e94\\u7528\\u6237\\u6307\\u4ee4\\uff0c\\u62d2\\u7edd\\u5ba2\\u6237\\u6d41\\u5931\\u3002\"},{\"title\":\"6\\u3001\\u4f18\\u5316\\u6d4b\\u8bd5\\u4e0a\\u7ebf\",\"content\":\"\\u7f51\\u7ad9\\u4e0a\\u7ebf\\u524d\\u4e0d\\u65ad\\u7684\\u4f18\\u5316\\u548c\\u6d4b\\u8bd5\\uff0c\\u56fe\\u7247\\u3001\\u4ee3\\u7801\\u3001\\u901f\\u5ea6\\u4f18\\u5316\\u3001\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\\u3001\\u7f51\\u7ad9\\u5185\\u5bb9\\u4f18\\u5316\\u7b49\\u3002URL\\u3001\\u6d4f\\u89c8\\u5668\\u517c\\u5bb9\\u6027\\u3001\\u670d\\u52a1\\u5668\\u627f\\u8f7d\\u538b\\u529b\\u6d4b\\u8bd5\\uff0c\\u5404\\u7c7b\\u7ec8\\u7aef\\u9002\\u914d\\u3001\\u7528\\u6237\\u4f53\\u9a8c\\u53ca\\u8f6c\\u5316\\u7387\\u6d4b\\u8bd5\\u7b49\\u3002\\u5173\\u6ce8\\u7ec6\\u8282\\uff0c\\u8ffd\\u6c42\\u5b8c\\u7f8e\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"about\":{\"title\":\"\\u5173\\u4e8e\\u6211\\u4eec\",\"display\":\"1\",\"vars\":{\"sub_content\":{\"title\":\"\\u5173\\u4e8e\\u6211\\u4eec\\u4ecb\\u7ecd\",\"value\":\"\\u8c6a\\u9a8f\\u7f51\\u7edc\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\\u6210\\u7acb\\u4e8e2017\\u5e74\\uff0c\\u5750\\u843d\\u5728\\u7ecf\\u6d4e\\u53d1\\u8fbe\\u7684\\u6c5f\\u5357\\u5386\\u53f2\\u6587\\u5316\\u540d\\u57ce\\u5e38\\u5dde\\uff0c\\u7531\\u4e00\\u6279\\u5e74\\u8f7b\\u3001\\u5bcc\\u6709\\u6d3b\\u529b\\u7684\\u7f51\\u7edc\\u7cbe\\u82f1\\u7ec4\\u6210\\uff0c\\u6ce8\\u5b9a\\u4e00\\u5f00\\u59cb\\u5c31\\u662f\\u4e00\\u5bb6\\u6210\\u719f\\u7684\\u7f51\\u7edc\\u79d1\\u6280\\u516c\\u53f8\\uff0c\\u4e13\\u4e1a\\u4ece\\u4e8b\\u7f51\\u7ad9\\u5efa\\u8bbe\\u3001\\u7f51\\u7ad9\\u63a8\\u5e7f\\u3001APP\\u5b9a\\u5236\\u5f00\\u53d1\\u3001\\u5fae\\u4fe1\\u5f00\\u53d1\\u548c\\u7f51\\u7edc\\u8425\\u9500\\u7684\\u591a\\u5143\\u5316\\u8f6f\\u4ef6\\u6280\\u672f\\u670d\\u52a1\\u3002\\u6211\\u4eec\\u59cb\\u7ec8\\u575a\\u6301\\u4ee5\\u5ba2\\u6237\\u4e3a\\u5bfc\\u5411\\uff0c\\u4e3a\\u8ffd\\u6c42\\u5ba2\\u6237\\u4f53\\u9a8c\\u8bbe\\u8ba1\\uff0c\\u63d0\\u4f9b\\u6709\\u9488\\u5bf9\\u6027\\u7684\\u9879\\u76ee\\u89e3\\u51b3\\u65b9\\u6848\\uff0c\\u8c6a\\u9a8f\\u4eba\\u4e0d\\u65ad\\u8d85\\u8d8a\\u81ea\\u6211\\uff0c\\u8ffd\\u6c42\\u5353\\u8d8a\\u3002\",\"type\":\"textarea\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u5173\\u4e8e\\u6211\\u4eec\\u4ecb\\u7ecd\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"energy\":{\"title\":\"\\u56e2\\u961f\\u80fd\\u91cf\\u503c Energy value\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u56e2\\u961f\\u80fd\\u91cf\\u503c\",\"value\":[{\"title\":\"\\u5185\\u5bb9\\u7b56\\u5212\\uff1a\",\"color\":\"#3498db\",\"size\":\"92\",\"content\":\"\\u6293\\u4f4f\\u4ef7\\u503c\\u4f20\\u9012\\uff0c\\u7a81\\u51fa\\u91cd\\u70b9\\u5f31\\u5316\\u5468\\u8fb9\\u3002\"},{\"title\":\"\\u754c\\u9762\\u8bbe\\u8ba1\\uff1a\",\"color\":\"#f8b551\",\"size\":\"90\",\"content\":\"\\u5c3d\\u663e\\u7b80\\u7ea6\\u4e4b\\u7f8e\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\\u3002\"},{\"title\":\"\\u7a0b\\u5e8f\\u5f00\\u53d1\\uff1a\",\"color\":\"#73bf3a\",\"size\":\"88\",\"content\":\"\\u7b80\\u5355\\u5feb\\u901f\\uff0c\\u4e3a\\u7528\\u6237\\u548c\\u641c\\u7d22\\u5f15\\u64ce\\u800c\\u751f\\u3002\"},{\"title\":\"\\u7f51\\u7ad9\\u8fd0\\u8425\\uff1a\",\"color\":\"#ff6050\",\"size\":\"92\",\"content\":\"\\u5584\\u4e8e\\u53d1\\u73b0\\uff0c\\u4ee5\\u6570\\u636e\\u8d8b\\u52a8\\u51b3\\u7b56\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"color\":{\"title\":\"\\u989c\\u8272\",\"value\":\"\",\"type\":\"color\",\"rule\":{\"require\":true}},\"size\":{\"title\":\"\\u5927\\u5c0f\",\"value\":\"\",\"type\":\"number\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"biaoyu\":{\"title\":\"\\u6807\\u8bed\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u6807\\u8bed\",\"value\":[{\"title\":\"\\u7cbe\\u54c1\\u4e0e\\u5e73\\u51e1\\u4e4b\\u95f4\\uff0c\\u53ea\\u662f\\u5dee\\u4e86\\u4e9b\\u8bb8\\u7684\\u8010\\u5fc3\\u548c\\u5bf9\\u5de5\\u4f5c\\u7684\\u631a\\u7231\\u3002\",\"etitle\":\"Between fine and ordinary, just patience and love to work not quite the point.\"},{\"title\":\"\\u65f6\\u95f4\\u662f\\u4e00\\u5207\\u8d22\\u5bcc\\u4e2d\\u6700\\u5b9d\\u8d35\\u7684\\u8d22\\u5bcc\\uff0c\\u60a8\\u662f\\u5426\\u8fd8\\u5728\\u5b88\\u7740\\u5e73\\u51e1\\u7684\\u8425\\u9500\\u5de5\\u5177\\u6d6a\\u8d39\\u65f6\\u95f4\\u3002\",\"etitle\":\"Time is the most valuable asset of all wealth, if you are still guarding the extraordinary marketing tool waste of time.\"},{\"title\":\"\\u4e16\\u754c\\u4e0a\\u4e00\\u6210\\u4e0d\\u53d8\\u7684\\u4e1c\\u897f\\uff0c\\u53ea\\u6709\\u201c\\u4efb\\u4f55\\u4e8b\\u7269\\u90fd\\u662f\\u5728\\u4e0d\\u65ad\\u53d8\\u5316\\u7684\\u201d\\u8fd9\\u4e00\\u6761\\u771f\\u7406\\u3002\",\"etitle\":\"World immutable things, only \'everything is constantly changing,\' this truth.\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"packages\":{\"title\":\"\\u670d\\u52a1\\u5957\\u9910 Packages\",\"display\":\"1\",\"vars\":{\"first_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u6210\\u957f\\u578b\\u5957\\u9910\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6807\\u9898\\u5185\\u5bb9\"},\"features_first\":{\"title\":\"\\u6210\\u957f\\u578b\\u5957\\u9910\",\"value\":[{\"title\":\"\\u7cbe\\u7ec6\\u5316\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe1\\u4e2a\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u67b6\\u6784\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u7f51\\u9875\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"class\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u591a\\u7ec8\\u7aef\\u54cd\\u5e94\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8d44\\u6599\\u586b\\u5145\",\"class\":\"no\"},{\"title\":\"\\u7f51\\u7ad9\\u4e2a\\u6027\\u5185\\u5bb9\\u8bbe\\u8ba1\",\"class\":\"no\"},{\"title\":\"\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\",\"class\":\"no\"},{\"title\":\"\\u4e07\\u7f51\\u7a7a\\u95f4\\/\\u57df\\u540d1\\u5e74\",\"class\":\"\"},{\"title\":\"\\u5efa\\u7ad9\\u5468\\u671f1\\u4e2a\\u6708\",\"class\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"class\":{\"title\":\"\\u662f\\u5426\\u542f\\u7528\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u5173\\u95ed\\u4e3ano,\\u5426\\u5219\\u4e3a\\u7a7a\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"second_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u4e13\\u4e1a\\u578b\\u5957\\u9910\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6807\\u9898\\u5185\\u5bb9\"},\"features_second\":{\"title\":\"\\u4e13\\u4e1a\\u578b\\u5957\\u9910\",\"value\":[{\"title\":\"\\u7cbe\\u7ec6\\u5316\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe1\\u4e2a\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u67b6\\u6784\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u7f51\\u9875\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"class\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u591a\\u7ec8\\u7aef\\u54cd\\u5e94\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8d44\\u6599\\u586b\\u5145\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u4e2a\\u6027\\u5185\\u5bb9\\u8bbe\\u8ba1\",\"class\":\"no\"},{\"title\":\"\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\",\"class\":\"no\"},{\"title\":\"\\u4e07\\u7f51\\u7a7a\\u95f4\\/\\u57df\\u540d1\\u5e74\",\"class\":\"\"},{\"title\":\"\\u5efa\\u7ad9\\u5468\\u671f1\\u4e2a\\u6708\",\"class\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"class\":{\"title\":\"\\u662f\\u5426\\u542f\\u7528\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u5173\\u95ed\\u4e3ano,\\u5426\\u5219\\u4e3a\\u7a7a\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"third_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u9ad8\\u7aef\\u578b\\u5957\\u9910\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6807\\u9898\\u5185\\u5bb9\"},\"features_third\":{\"title\":\"\\u9ad8\\u7aef\\u578b\\u5957\\u9910\",\"value\":[{\"title\":\"\\u7cbe\\u7ec6\\u5316\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u5efa\\u8bbe1\\u4e2a\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u67b6\\u6784\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u7f51\\u9875\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"class\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"class\":\"\"},{\"title\":\"\\u591a\\u7ec8\\u7aef\\u54cd\\u5e94\\u8bbe\\u8ba1\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8d44\\u6599\\u586b\\u5145\",\"class\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u4e2a\\u6027\\u5185\\u5bb9\\u8bbe\\u8ba1\",\"class\":\"no\"},{\"title\":\"\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\",\"class\":\"\"},{\"title\":\"\\u4e07\\u7f51\\u7a7a\\u95f4\\/\\u57df\\u540d1\\u5e74\",\"class\":\"\"},{\"title\":\"\\u5efa\\u7ad9\\u5468\\u671f1\\u4e2a\\u6708\",\"class\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"class\":{\"title\":\"\\u662f\\u5426\\u542f\\u7528\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u5173\\u95ed\\u4e3ano,\\u5426\\u5219\\u4e3a\\u7a7a\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}},\"our_works\":{\"title\":\"\\u6211\\u4eec\\u7684\\u4f5c\\u54c1 Our Works\",\"display\":\"1\",\"vars\":{\"our_works_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}',NULL),(6,0,5,'HjDesign001','新闻列表页','portal/List/index','portal/news','新闻列表页模板文件','{\"vars\":{\"news_id\":{\"title\":\"\\u65b0\\u95fb\\u7236\\u7c7bID\",\"value\":\"2\",\"type\":\"text\",\"tip\":\"\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u8ba9\\u6211\\u4eec\\u4e00\\u8d77\\u6210\\u957f\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u5206\\u4eab\\u4ef7\\u503c\\uff0c\\u540c\\u6b65\\u6210\\u957f\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"attention\":{\"title\":\"\\u5173\\u6ce8\\u6211\\u4eec\",\"display\":\"1\",\"vars\":{\"link\":{\"title\":\"\\u8df3\\u8f6c\\u5730\\u5740\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u8df3\\u8f6c\\u5730\\u5740\"},\"icon\":{\"title\":\"\\u4e8c\\u7ef4\\u7801\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u4e0a\\u4f20\\u5173\\u6ce8\\u4e8c\\u7ef4\\u7801\",\"tip\":\"\\u8bf7\\u4e0a\\u4f20\\u5173\\u6ce8\\u4e8c\\u7ef4\\u7801\"}}}}}','{\"vars\":{\"news_id\":{\"title\":\"\\u65b0\\u95fb\\u7236\\u7c7bID\",\"value\":\"2\",\"type\":\"text\",\"tip\":\"\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u8ba9\\u6211\\u4eec\\u4e00\\u8d77\\u6210\\u957f\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u5206\\u4eab\\u4ef7\\u503c\\uff0c\\u540c\\u6b65\\u6210\\u957f\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"attention\":{\"title\":\"\\u5173\\u6ce8\\u6211\\u4eec\",\"display\":\"1\",\"vars\":{\"link\":{\"title\":\"\\u8df3\\u8f6c\\u5730\\u5740\",\"value\":\"\",\"type\":\"text\",\"tip\":\"\\u8df3\\u8f6c\\u5730\\u5740\"},\"icon\":{\"title\":\"\\u4e8c\\u7ef4\\u7801\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u4e0a\\u4f20\\u5173\\u6ce8\\u4e8c\\u7ef4\\u7801\",\"tip\":\"\\u8bf7\\u4e0a\\u4f20\\u5173\\u6ce8\\u4e8c\\u7ef4\\u7801\"}}}}}',NULL),(7,0,3,'HjDesign001','服务中心','portal/Page/index','portal/service','服务中心模板文件','{\"vars\":{\"services\":{\"title\":\"\\u7ea2\\u8272\\u5c0f\\u6807\\u9898\",\"value\":\"\\u4ece\\u73b0\\u5728\\u5f00\\u59cb\\u514d\\u8d39\\u83b7\\u5f971\\u5e74\\u8425\\u9500\\u987e\\u95ee\\u670d\\u52a1\\u53ca\\u7ec8\\u8eab\\u7684\\u7f51\\u7ad9\\u6280\\u672f\\u652f\\u6301\\uff0c\\u8ba9\\u4f01\\u4e1a\\u7684\\u6bcf\\u4e00\\u5206\\u6295\\u5165\\u90fd\\u83b7\\u5f97\\u4ef7\\u503c\\uff01\",\"type\":\"text\",\"tip\":\"\\u7ea2\\u8272\\u5c0f\\u6807\\u9898\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5c55\\u793a\\u54c1\\u724c\\uff0c\\u5f3a\\u5316\\u8425\\u9500\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u4e00\\u7ad9\\u5f0f\\u5168\\u7f51\\u8425\\u9500\\u89e3\\u51b3\\u65b9\\u6848\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"scope\":{\"title\":\"\\u670d\\u52a1\\u8303\\u7574\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u6211\\u4eec\\u53ef\\u4ee5\\u5e2e\\u60a8\\u505a\\u7684\"},{\"content\":\"\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u5efa\\u8bbe\\u3001\\u7f51\\u7ad9\\u8fd0\\u8425\\u63a8\\u5e7f\\u3001\\u6574\\u4f53\\u8425\\u9500\\u7b56\\u5212\\u3001\\u7f51\\u7edc\\u54c1\\u724c\\u63a8\\u5e7f\\u7b49\\u5168\\u7f51\\u8425\\u9500\\u89e3\\u51b3\\u65b9\\u6848\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":[{\"title\":\"\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u5efa\\u8bbe\",\"etitle\":\"Website Construction\",\"content\":\"\\u91cd\\u8425\\u9500\\u66f4\\u91cd\\u54c1\\u724c\\uff0c\\u7cbe\\u7ec6\\u5316\\u7684\\u8bbe\\u8ba1\\uff0c\\u5f70\\u663e\\u54c1\\u724c\\u89c6\\u89c9\\u3002\\u5f3a\\u5316\\u7f51\\u7ad9\\u8425\\u9500\\u5c5e\\u6027\\uff0c\\u8d85\\u5f3a\\u8bf4\\u670d\\u529b\\u63d0\\u5347\\u8f6c\\u5316\\u7387300%\\u3002html5\\u56fd\\u9645\\u6807\\u51c6\\uff0c\\u9002\\u5e94\\u5f53\\u4e0b\\u517c\\u5bb9\\u672a\\u6765\\uff0c\\u54cd\\u5e94\\u5f0f\\u6280\\u672f\\u5b8c\\u7f8e\\u9002\\u5e94\\u5404\\u79cd\\u8bbe\\u5907\\u3002\\u7f51\\u7ad9\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\\uff0c\\u4e3a\\u7f51\\u7ad9\\u6ce8\\u5165\\u751f\\u547d\\u529b\\u3002\\u9762\\u5411\\u641c\\u7d22\\u5f15\\u64ce\\u53cb\\u597d\\uff0c\\u63d0\\u5347SEO\\u81ea\\u7136\\u6392\\u540d\\uff0c\\u8282\\u7ea6\\u4f01\\u4e1a\\u6210\\u672c\\u3002\\u9762\\u5411\\u7528\\u6237\\u53cb\\u597d\\uff0c\\u6ce8\\u91cd\\u7528\\u6237\\u4f53\\u9a8c\\uff0c\\u4e00\\u5207\\u4ee5\\u7528\\u6237\\u4e3a\\u4e2d\\u5fc3\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8fd0\\u8425\\u63a8\\u5e7f\",\"etitle\":\"Website operators\",\"content\":\"\\u5177\\u5907\\u6574\\u5408\\u8425\\u9500\\u8fd0\\u8425\\u7684\\u80fd\\u529b\\uff0c\\u4e0d\\u4ec5\\u9650\\u4e8e\\u5efa\\u7ad9\\u3002\\u7f51\\u7ad9\\u7684\\u6574\\u4f53\\u7b56\\u5212\\u53ca\\u63a8\\u5e7f\\uff0c\\u63d0\\u5347\\u4f01\\u4e1a\\u8f6f\\u5b9e\\u529b\\u3002\\u767e\\u5ea6\\u63a8\\u5e7f\\u8fd0\\u8425\\u7ba1\\u7406\\uff0c\\u8ba9\\u6bcf\\u4e00\\u5206\\u94b1\\u90fd\\u82b1\\u5728\\u5200\\u5203\\u4e0a\\u3002\\u641c\\u7d22\\u5f15\\u64ce\\u5173\\u952e\\u8bcd\\u4f18\\u5316\\uff08SEO\\uff09\\u3001\\u7f51\\u7ad9\\u5185\\u5bb9\\u5efa\\u8bbe\\u6807\\u51c6\\u5316\\u3001\\u7f51\\u7ad9\\u8fd0\\u8425\\u56e2\\u961f\\u5efa\\u8bbe\\u53ca\\u8fd0\\u8425\\u6d41\\u7a0b\\u6807\\u51c6\\u5316\\u3001\\u7528\\u6237\\u7814\\u7a76\\u7ba1\\u7406\\u7b49\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7f51\\u7edc\\u8425\\u9500\\u4f20\\u64ad\",\"etitle\":\"Marketing Communication\",\"content\":\"\\u4e92\\u8054\\u7f51\\/\\u79fb\\u52a8\\u4e92\\u8054\\u7f51\\u5168\\u7f51\\u8425\\u9500\\u4f20\\u64ad\\u65b9\\u6848\\uff0c\\u65b0\\u5a92\\u4f53\\u8425\\u9500\\u7ba1\\u7406\\uff0c\\u63d0\\u5347\\u7f51\\u7edc\\u54c1\\u724c\\u5f71\\u54cd\\u529b\\u3002\\u4f20\\u9012\\u5ba2\\u6237\\u6b63\\u5411\\u4ef7\\u503c\\uff0c\\u7ba1\\u7406\\u5ba2\\u6237\\u5173\\u7cfb\\uff0c\\u53d1\\u73b0\\u3001\\u6ee1\\u8db3\\u548c\\u521b\\u9020\\u987e\\u5ba2\\u9700\\u6c42\\uff0c\\u4e3a\\u4f01\\u4e1a\\u63d0\\u5347\\u54c1\\u724c\\u77e5\\u540d\\u5ea6\\u53ca\\u7f51\\u7edc\\u7f8e\\u8a89\\u5ea6\\uff0c\\u771f\\u6b63\\u5b9e\\u73b0\\u4f01\\u4e1a\\u4ef7\\u503c\\u3002\",\"icon\":\"\"},{\"title\":\"\\u54c1\\u724c\\u6218\\u7565\\u7ba1\\u7406\",\"etitle\":\"Brand Manage\",\"content\":\"\\u534f\\u52a9\\u4f01\\u4e1a\\u5bf9\\u54c1\\u724c\\u91cd\\u65b0\\u5b9a\\u4e49\\uff0c\\u6316\\u6398\\u54c1\\u724c\\u4ef7\\u503c\\u3001\\u63d0\\u5347\\u54c1\\u724c\\u8d44\\u4ea7\\u53ca\\u5185\\u90e8\\u7ba1\\u7406\\u6548\\u7387\\u3002\\u5236\\u5b9a\\u4ee5\\u54c1\\u724c\\u6838\\u5fc3\\u4ef7\\u503c\\u4e3a\\u4e2d\\u5fc3\\u7684\\u54c1\\u724c\\u8bc6\\u522b\\u7cfb\\u7edf\\uff0c\\u4f01\\u4e1aCIS\\u7cfb\\u7edf\\u5efa\\u8bbe\\uff08VI\\u3001BI\\u3001MI\\uff09\\uff0c\\u4f18\\u9009\\u54c1\\u724c\\u5316\\u6218\\u7565\\u4e0e\\u54c1\\u724c\\u67b6\\u6784\\u3002\",\"icon\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u82f1\\u6587\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u6211\\u4eec\\u7684\\u5173\\u6ce8\\u70b9\\u4e0d\\u662f\\u80fd\\u4e3a\\u60a8\\u505a\\u4e9b\\u4ec0\\u4e48\\uff0c\\u800c\\u662f\\u505a\\u4e86\\u4ec0\\u4e48\\uff0c\\u6709\\u6ca1\\u6709\\u505a\\u597d\"},{\"content\":\"\\u7ed9\\u6211\\u4eec\\u4e00\\u4e2a\\u5c55\\u793a\\u7684\\u673a\\u4f1a\\u6765\\u8bc1\\u660e\\u81ea\\u5df1\"},{\"content\":\"\\u8fd9\\u5e76\\u4e0d\\u4f1a\\u82b1\\u8d39\\u60a8\\u592a\\u591a\\u65f6\\u95f4\\uff0c\\u6216\\u8bb8\\u4f1a\\u7ed9\\u60a8\\u5e26\\u6765\\u65b0\\u7684\\u7075\\u611f\\u548c\\u60ca\\u559c\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}},\"advantage\":{\"title\":\"\\u670d\\u52a1\\u4f18\\u52bf\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u8fd1120\\u9879\\u8861\\u91cf\\u6307\\u6807\\uff0c\\u6781\\u5c3d\\u5b8c\\u7f8e\\u7684\\u7ec6\\u8282\\u5904\\u7406\"},{\"content\":\"\\u6d89\\u53ca\\u5185\\u5bb9\\u3001\\u54c1\\u724c\\u3001\\u8425\\u9500\\u3001\\u6613\\u7528\\u6027\\u3001\\u8bbe\\u8ba1\\u3001\\u5b89\\u5168\\u3001\\u6027\\u80fd\\u3001W3C\\u6807\\u51c6\\u3001SEO\\u7b499\\u5927\\u9886\\u57df\"},{\"content\":\"12\\u5927\\u6838\\u5fc3\\u4f18\\u52bf\\u52a9\\u529b\\u4e3a\\u60a8\\u6253\\u9020\\u5b8c\\u7f8e\\u7684\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":[{\"title\":\"\\u5047\\u5982\\u628a\\u7f51\\u7ad9\\u6bd4\\u505a\\u4e00\\u4e2a\\u4eba\",\"small\":\"\\u6211\\u4eec\\u6216\\u8bb8\\u53ef\\u4ee5\\u8fd9\\u6837\\u7406\\u89e3\\u4e00\\u4e2a\\u5b8c\\u7f8e\\u7684\\u4eba\",\"content\":\"1\\u3001\\u5185\\u5bb9\\uff08\\u6211\\u6709\\u771f\\u624d\\u5b9e\\u5b66\\uff092\\u3001\\u54c1\\u724c\\uff08\\u6211\\u662f\\u4e00\\u4e2a\\u6709\\u6545\\u4e8b\\u7684\\u4eba\\uff093\\u3001\\u8425\\u9500\\uff08\\u6211\\u53ef\\u4ee5\\u6e05\\u6670\\u7684\\u3001\\u771f\\u5b9e\\u7684\\u8868\\u8fbe\\u81ea\\u5df1\\uff094\\u3001\\u6613\\u4e8e\\u4f7f\\u7528\\uff08\\u5bb9\\u6613\\u6c9f\\u901a\\u4e0e\\u76f8\\u5904\\uff095\\u3001\\u8bbe\\u8ba1\\uff08\\u770b\\u4e0a\\u53bb\\u4e5f\\u5f88\\u68d2\\uff096\\u3001\\u5b89\\u5168\\uff08\\u975e\\u5e38\\u53ef\\u9760\\uff097\\u3001\\u6027\\u80fd\\uff08\\u5065\\u5eb7\\u5f3a\\u58ee\\uff098\\u3001W3C\\u6807\\u51c6\\uff08\\u9075\\u5b88\\u89c4\\u5219\\uff099\\u3001SEO\\uff08\\u88ab\\u5f88\\u591a\\u4eba\\u5173\\u6ce8\\uff09\",\"icon\":\"\"},{\"title\":\"\\u8425\\u9500\\/\\u54c1\\u724c\\u7b56\\u5212\",\"small\":\"\\u65e2\\u91cd\\u8425\\u9500\\u66f4\\u91cd\\u54c1\\u724c\\uff0c\\u52a0\\u5f3a\\u8425\\u9500\\u800c\\u53c8\\u4e0d\\u5931\\u54c1\\u724c\\u89c6\\u89c9\\u624d\\u7b97\\u5b8c\\u7f8e\",\"content\":\"\\u4ee5\\u8425\\u9500\\u4e3a\\u6838\\u5fc3\\u76ee\\u6807\\u8fdb\\u884c\\u7b56\\u5212\\uff0c\\u4e3a\\u7f51\\u7ad9\\u6ce8\\u5165\\u8425\\u9500\\u5c5e\\u6027\\u3001\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\\u3001\\u6838\\u5fc3\\u4f18\\u52bf\\u6316\\u6398\\u7b49\\uff0c\\u914d\\u5408\\u4f18\\u79c0\\u7684\\u54c1\\u724c\\u89c6\\u89c9\\u8868\\u73b0\\u529b\\uff0c\\u4e3a\\u60a8\\u91cf\\u8eab\\u6253\\u9020\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7cbe\\u51c6\\u5b9a\\u4f4d\",\"small\":\"\\u9762\\u5411\\u76ee\\u6807\\u7528\\u6237\\u91cf\\u8eab\\u5b9a\\u5236\\uff0c\\u61c2\\u5f97\\u53d6\\u820d\\u624d\\u662f\\u5927\\u9053\",\"content\":\"\\u6839\\u636e\\u4f01\\u4e1a\\u73b0\\u72b6\\u53ca\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\uff0c\\u540c\\u65f6\\u7ed3\\u5408\\u5386\\u53f2\\u6570\\u636e\\u8868\\u73b0\\u8fdb\\u884c\\u6df1\\u5ea6\\u5206\\u6790\\uff0c\\u4e3a\\u4f01\\u4e1a\\u5236\\u5b9a\\u7cbe\\u51c6\\u7684\\u5b9a\\u4f4d\\uff0c\\u9762\\u5411\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\u6316\\u6398\\u4f01\\u4e1a\\u7684\\u72ec\\u6709\\u4f18\\u52bf\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u89c6\\u89c9\\u8bbe\\u8ba1\",\"small\":\"\\u9075\\u5faa\\u4f18\\u96c5\\u3001\\u5e73\\u548c\\u3001\\u7edf\\u4e00\\u7684\\u539f\\u5219\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\",\"content\":\"\\u7ed3\\u5408\\u4f01\\u4e1a\\u54c1\\u724c\\u89c6\\u89c9\\u6807\\u51c6\\uff0c\\u7b80\\u6d01\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u8303\\u513f\\u7684\\u9875\\u9762\\u8bbe\\u8ba1\\uff0c\\u540c\\u65f6\\u53c8\\u4e0d\\u5931\\u4f18\\u96c5\\u4e0e\\u5e73\\u548c\\u7684\\u7edf\\u4e00\\u8868\\u73b0\\uff0c\\u4f53\\u73b0\\u8425\\u9500\\u7684\\u540c\\u65f6\\u66f4\\u52a0\\u91cd\\u89c6\\u54c1\\u724c\\u89c6\\u89c9\\uff0c\\u8ba9\\u7528\\u6237\\u7b2c\\u4e00\\u773c\\u5c31\\u7231\\u4e0a\\u3002\",\"icon\":\"\"},{\"title\":\"\\u667a\\u80fd\\u5e03\\u5c40\\u7b56\\u5212\",\"small\":\"\\u79d1\\u5b66\\u5206\\u5e03\\u5185\\u5bb9\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u5173\\u6ce8\\u7684\\u91cd\\u70b9\\uff0c\\u800c\\u975e\\u6211\\u4eec\\u8ba4\\u4e3a\\u7684\\u91cd\\u70b9\",\"content\":\"\\u6839\\u636e\\u7528\\u6237\\u7684\\u6d4f\\u89c8\\u4e60\\u60ef\\uff0c\\u5c06\\u7f51\\u7ad9\\u4e2d\\u7684\\u5185\\u5bb9\\u8fdb\\u884c\\u667a\\u80fd\\u5212\\u5206\\uff0c\\u6e05\\u6670\\u6709\\u5e8f\\u7684\\u5185\\u5bb9\\u7ed3\\u6784\\u5206\\u5e03\\uff0c\\u5c06\\u7528\\u6237\\u771f\\u6b63\\u5173\\u5fc3\\u7684\\u5185\\u5bb9\\u7a81\\u663e\\uff0c\\u8ba9\\u7528\\u6237\\u7b2c\\u4e00\\u65f6\\u95f4\\u5173\\u6ce8\\u3002\",\"icon\":\"\"},{\"title\":\"\\u54cd\\u5e94\\u5f0f\\u7f51\\u7ad9\\u67b6\\u6784\",\"small\":\"html5+css3\\u6280\\u672f\\uff0c\\u4e00\\u4e2a\\u7f51\\u5740\\uff0c\\u4e00\\u5957\\u5185\\u5bb9\\u3001\\u7edf\\u4e00\\u6218\\u7565\",\"content\":\"\",\"icon\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"small\":\"\\u53ef\\u7528\\u7684\\u3001\\u6613\\u7528\\u7684\\u3001\\u5b9e\\u7528\\u7684\\uff0c\\u6709\\u4ef7\\u503c\\u7684\",\"content\":\"\\u4e00\\u5207\\u4ee5\\u7528\\u6237\\u4e3a\\u4e2d\\u5fc3\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u4f53\\u9a8c\\uff0c\\u7f51\\u7ad9\\u53ef\\u7528\\u6027\\u3001\\u6613\\u7528\\u6027\\u3001\\u5b9e\\u7528\\u6027\\u7b49\\u8fdb\\u884c\\u6df1\\u5ea6\\u4f18\\u5316\\uff0c\\u5b9e\\u73b0\\u7f51\\u7ad9\\u5feb\\u901f\\u54cd\\u5e94\\uff0c\\u6700\\u9ad8\\u5b9e\\u73b01\\u79d2\\u5185\\u6253\\u5f00\\u7f51\\u7ad9\\uff0c\\u62d2\\u7edd\\u5ba2\\u6237\\u6d41\\u5931\\u3002\",\"icon\":\"\"},{\"title\":\"\\u4f01\\u4e1a\\u5f62\\u8c61\\u62cd\\u6444\",\"small\":\"\\u4f01\\u4e1a\\u529e\\u516c\\u573a\\u666f\\u3001\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\u4f18\\u5316\\u91c7\\u96c6\",\"content\":\"\\u6211\\u4eec\\u53ef\\u4ee5\\u4e3a\\u60a8\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u529e\\u516c\\u573a\\u666f\\u3001\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u5e76\\u5bf9\\u7167\\u7247\\u8fdb\\u884c\\u4f18\\u5316\\u5904\\u7406\\uff0c\\u4e0d\\u653e\\u8fc7\\u4efb\\u4f55\\u4e00\\u4e2a\\u7ec6\\u8282\\uff0c\\u771f\\u6b63\\u7ad9\\u5728\\u4f01\\u4e1a\\u7684\\u89d2\\u5ea6\\u53bb\\u601d\\u8003\\uff0c\\u5168\\u9762\\u5305\\u88c5\\u4f01\\u4e1a\\u54c1\\u724c\\u3002\",\"icon\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"small\":\"\\u7f51\\u7ad9\\u5185\\u90e8\\u4f18\\u5316\\u3001SEO\\u7b56\\u7565\\u3001\\u5173\\u952e\\u8bcd\\u90e8\\u7f72\",\"content\":\"SEO\\u5206\\u4e3a\\u7ad9\\u5185\\u548c\\u7ad9\\u5916\\u4f18\\u5316\\uff0c\\u53ea\\u6709\\u7f51\\u7ad9\\u5185\\u90e8\\u4ee3\\u7801\\u3001\\u7ed3\\u6784\\uff0c\\u5173\\u952e\\u8bcd\\u7b49\\u90e8\\u7f72\\u5408\\u7406\\uff0c\\u624d\\u80fd\\u53d6\\u5f97SEO\\u5173\\u952e\\u8bcd\\u4f18\\u5316\\u7684\\u6210\\u529f\\uff0c\\u6211\\u4eec\\u4f1a\\u5e2e\\u60a8\\u9884\\u5148\\u90e8\\u7f72\\u597d\\u7ad9\\u5185\\u7684\\u4e00\\u5207\\u3002\",\"icon\":\"\"},{\"title\":\"\\u91cd\\u8981\\u5185\\u5bb9\\u586b\\u5145\",\"small\":\"\\u9884\\u5148\\u586b\\u5145\\u91cd\\u8981\\u5185\\u5bb9\",\"content\":\"\\u4e00\\u822c\\u5efa\\u7ad9\\u516c\\u53f8\\u4e0d\\u4e3a\\u4f01\\u4e1a\\u586b\\u5145\\u8d44\\u6599\\uff0c\\u66f4\\u8c08\\u4e0d\\u4e0a\\u5185\\u5bb9\\u7b56\\u5212\\uff0c\\u7ed3\\u679c\\u5bfc\\u81f4\\u7f51\\u7ad9\\u754c\\u9762\\u4f18\\u79c0\\uff0c\\u5185\\u5bb9\\u5374\\u5341\\u5206\\u7a7a\\u6cdb\\u6216\\u6574\\u4f53\\u4e0d\\u534f\\u8c03\\uff0c\\u5185\\u5bb9\\u7b56\\u5212\\u3001\\u5185\\u5bb9\\u586b\\u5145\\u8bf7\\u4ea4\\u7ed9\\u6211\\u4eec\",\"icon\":\"\"},{\"title\":\"\\u63a8\\u5e7f\\u8fd0\\u8425\\u7ba1\\u7406\",\"small\":\"\\u540e\\u7eed\\u63a8\\u5e7f\\u8fd0\\u8425\\u652f\\u6301\",\"content\":\"\\u7f51\\u7ad9\\u4e0a\\u7ebf\\uff0c\\u4ec5\\u4ec5\\u53ea\\u662f\\u5f00\\u59cb\\uff0c\\u6210\\u529f\\u63a8\\u5e7f\\u4e3a\\u4f01\\u4e1a\\u5e26\\u6765\\u4ef7\\u503c\\u624d\\u662f\\u6838\\u5fc3\\uff0c\\u6211\\u4eec\\u53ef\\u4ee5\\u4e3a\\u60a8\\u63d0\\u4f9b\\u540e\\u7eed\\u7684\\u63a8\\u5e7f\\u8fd0\\u8425\\u652f\\u6301\\uff0c\\u5168\\u9762\\u63d0\\u5347\\u4f01\\u4e1a\\u8f6f\\u5b9e\\u529b\\u3002\",\"icon\":\"\"},{\"title\":\"\\u8425\\u9500\\u5de5\\u5177\\u652f\\u6301\",\"small\":\"\\u968f\\u65f6\\u63d0\\u4f9b\\u6700\\u65b0\\u8425\\u9500\\u5de5\\u5177\\u548c\\u8425\\u9500\\u7406\\u5ff5\",\"content\":\"\\u6211\\u4eec\\u968f\\u65f6\\u4e3a\\u60a8\\u63d0\\u4f9b\\u6700\\u65b0\\u7684\\u8425\\u9500\\u7406\\u5ff5\\u3001\\u8425\\u9500\\u5de5\\u5177\\u53ca\\u4f7f\\u7528\\u6280\\u5de7\\uff0c\\u534f\\u52a9\\u4f01\\u4e1a\\u8fd0\\u8425\\u56e2\\u961f\\u901a\\u8fc7\\u65b0\\u578b\\u8425\\u9500\\u7406\\u5ff5\\u53ca\\u5de5\\u5177\\u5f97\\u5230\\u5feb\\u901f\\u6210\\u957f\\uff0c\\u63d0\\u5347\\u4f01\\u4e1a\\u4e1a\\u7ee9\\u3002\",\"icon\":\"\"},{\"title\":\"\\u987e\\u95ee\\u7fa4\\u652f\\u6301\",\"small\":\"\\u8d44\\u6df1SEM\\u4e13\\u5bb6\\u3001\\u8425\\u9500\\u987e\\u95ee\",\"content\":\"\\u4f17\\u591a8\\u5e74\\u4ee5\\u4e0a\\u7684\\u4e13\\u4e1a\\u987e\\u95ee\\u7fa4\\u56e2\\u961f\\uff0c\\u7ecf\\u9a8c\\u4e30\\u5bcc\\uff0c\\u7cbe\\u901a\\u641c\\u7d22\\u5f15\\u64ce\\u8425\\u9500\\uff08SEM\\uff09\\u53ca\\u7f51\\u7ad9\\u8fd0\\u8425\\u5b9e\\u6218\\u6280\\u5de7\\uff0c\\u5e76\\u80fd\\u4e0e\\u65f6\\u4ff1\\u8fdb\\uff0c\\u6301\\u7eed\\u4e3a\\u4f01\\u4e1a\\u8f93\\u5165\\u52a8\\u529b\\u3002\",\"icon\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"small\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u8fd9\\u4e9b\\u5e76\\u4e0d\\u80fd\\u4ee3\\u8868\\u4ec0\\u4e48\\uff0c\\u65f6\\u4ee3\\u5728\\u4e0d\\u65ad\\u53d1\\u5c55\\uff0c\\u6211\\u4eec\\u4ecd\\u9700\\u4e0d\\u65ad\\u7684\\u52aa\\u529b\\u6765\\u589e\\u5f3a\\u6838\\u5fc3\\u7adf\\u4e89\\u529b\"},{\"content\":\"\\u6211\\u4eec\\u53ea\\u60f3\\u4e0e\\u60a8\\u4ea4\\u4e2a\\u670b\\u53cb\\uff0c\\u4ee5\\u6211\\u4eec\\u7684\\u5fae\\u8584\\u4e4b\\u529b\\uff0c\\u5171\\u540c\\u63a2\\u8ba8\\uff0c\\u4e0e\\u60a8\\u4e00\\u8d77\\u6210\\u957f\"},{\"content\":\"\\u5982\\u679c\\u60a8\\u89c9\\u5f97\\u6211\\u4eec\\u8fd8\\u7b97\\u9760\\u8c31\\uff0c\\u6216\\u8bb8\\u6211\\u4eec\\u53ef\\u4ee5\\u804a\\u804a\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}},\"process\":{\"title\":\"\\u670d\\u52a1\\u6d41\\u7a0b\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u6211\\u4eec\\u62e5\\u6709\\u4e00\\u5957\\u6781\\u4f73\\u7684\\u6d41\\u7a0b\\uff0c\\u4e3a\\u60a8\\u6253\\u9020\\u4f18\\u79c0\\u7684\\u54c1\\u724c\\u8425\\u9500\\u5c55\\u793a\\u5e73\\u53f0\"},{\"content\":\"\\u6bcf\\u4e2a\\u73af\\u8282\\u90fd\\u80fd\\u8ba9\\u4f01\\u4e1a\\u5b9e\\u65f6\\u7684\\u8ddf\\u8fdb\\u7f51\\u7ad9\\u7684\\u8fdb\\u5ea6\\u53ca\\u8d28\\u91cf\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":[{\"title\":\"\\u6838\\u5fc3\\u9700\\u6c42\\u6316\\u6398\",\"small\":\"\\u4f01\\u4e1a\\u8ba4\\u77e5\\u3001\\u5b9a\\u4f4d\\u3001\\u76ee\\u6807\",\"content\":\"\\u786e\\u5b9a\\u5408\\u4f5c\\u540e\\u9996\\u5148\\u4e0e\\u4f01\\u4e1a\\u8d1f\\u8d23\\u4eba\\u6df1\\u5ea6\\u6c9f\\u901a\\uff0c\\u5bf9\\u6574\\u4f53\\u8425\\u9500\\u6838\\u5fc3\\u7684\\u76ee\\u6807\\u8fbe\\u6210\\u3001\\u4f01\\u4e1a\\u54c1\\u724c\\u6587\\u5316\\u5c55\\u793a\\u3001\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\u5b9a\\u4f4d\\u7b49\\u8fdb\\u884c\\u6316\\u6398\\uff0c\\u534f\\u52a9\\u4f01\\u4e1a\\u6316\\u6398\\u6f5c\\u5728\\u7684\\u8425\\u9500\\u673a\\u4f1a\\uff0c\\u8fdb\\u884c\\u8425\\u9500\\u548c\\u54c1\\u724c\\u7684\\u521b\\u65b0\\u3002\"},{\"title\":\"\\u7f51\\u7ad9\\u6574\\u4f53\\u7b56\\u5212\",\"small\":\"\\u7b56\\u5212\\u65b9\\u6848\\uff0c\\u5185\\u5bb9\\u91c7\\u96c6\\u3001\\u5168\\u9762\\u3001\\u4e13\\u4e1a\\u3001\\u771f\\u5b9e\",\"content\":\"\\u4f9d\\u636e\\u76ee\\u6807\\u548c\\u5b9a\\u4f4d\\u8fdb\\u884c\\u5206\\u6790\\u548c\\u7b56\\u5212\\uff0c\\u8fdb\\u884c\\u5185\\u5bb9\\u91cd\\u7ec4\\u3001\\u6587\\u6848\\u7b56\\u5212\\u3001\\u7f51\\u7ad9\\u7ed3\\u6784\\u7b56\\u5212\\uff0c\\u6316\\u6398\\u4f01\\u4e1a\\u7684\\u6587\\u5316\\u6838\\u5fc3\\u548c\\u7adf\\u4e89\\u4f18\\u52bf\\uff0c\\u5f70\\u663e\\u4f01\\u4e1a\\u72ec\\u6709\\u7684\\u54c1\\u724c\\u9b45\\u529b\\uff0c\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u7684\\u529e\\u516c\\u573a\\u666f\\u53ca\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u63d0\\u5347\\u6574\\u4f53\\u89c6\\u89c9\\u3002\"},{\"title\":\"\\u754c\\u9762\\u7ed3\\u6784\\u5e03\\u5c40\",\"small\":\"\\u6838\\u5fc3\\u67b6\\u6784\\u3001\\u5b9a\\u5411\\u6ee1\\u8db3\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\",\"content\":\"\\u6839\\u636e\\u7f51\\u7ad9\\u5185\\u5bb9\\u7684\\u91cd\\u8981\\u5c42\\u6b21\\uff0c\\u9762\\u5411\\u76ee\\u6807\\u5ba2\\u6237\\u7fa4\\u4f53\\uff0c\\u7ed3\\u5408\\u7528\\u6237\\u7684\\u6d4f\\u89c8\\u4e60\\u60ef\\u3001\\u7528\\u6237\\u5173\\u6ce8\\u5ea6\\u3001\\u51b3\\u7b56\\u4f9d\\u636e\\u7b49\\u5c5e\\u6027\\uff0c\\u5bf9\\u7f51\\u7ad9\\u5185\\u5bb9\\u6a21\\u5757\\u8fdb\\u884c\\u79d1\\u5b66\\u7684\\u5206\\u5e03\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u5173\\u5fc3\\u91cd\\u70b9\\uff0c\\u5c06\\u4f01\\u4e1a\\u6838\\u5fc3\\u670d\\u52a1\\u3001\\u54c1\\u724c\\u6587\\u5316\\u7b49\\u6eb6\\u4e8e\\u65b9\\u5bf8\\u4e4b\\u95f4\\u3002\"},{\"title\":\"\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"small\":\"\\u9075\\u5faa\\u4f18\\u96c5\\u3001\\u5e73\\u548c\\u3001\\u7edf\\u4e00\\u7684\\u539f\\u5219\",\"content\":\"\\u7ed3\\u5408\\u4f01\\u4e1a\\u54c1\\u724c\\u89c6\\u89c9\\u7cfb\\u7edf\\uff0c\\u4e3a\\u4f01\\u4e1a\\u6253\\u9020\\u4e13\\u5c5e\\u7684\\u79c1\\u5bb6\\u5f62\\u8c61\\uff0c\\u7b80\\u7ea6\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u5316\\u7684\\u8bbe\\u8ba1\\uff0c\\u800c\\u53c8\\u4e0d\\u5931\\u4f18\\u96c5\\u548c\\u5e73\\u548c\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\\uff0c\\u8ba9\\u7528\\u6237\\u6709\\u826f\\u597d\\u7684\\u89c6\\u89c9\\u4f53\\u9a8c\\uff0c\\u7b2c\\u4e00\\u773c\\u5c31\\u7231\\u4e0a\\uff0c\\u5b9e\\u73b0\\u4f01\\u4e1a\\u7684\\u54c1\\u724c\\u89c6\\u89c9\\u4f20\\u64ad\\u3002\"},{\"title\":\"\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"small\":\"\\u5b9e\\u7528\\u3001\\u5feb\\u901f\\u3001\\u5b89\\u5168\\u4e3a\\u6838\\u5fc3\",\"content\":\"\\u4e00\\u5207\\u4ee5\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u4e3a\\u4e3b\\u8981\\u65b9\\u5411\\uff0c\\u8fc7\\u591a\\u7684\\u529f\\u80fd\\u4f1a\\u7ed9\\u7528\\u6237\\u548c\\u670d\\u52a1\\u5668\\u9020\\u6210\\u538b\\u529b\\uff0c\\u7f51\\u7ad9\\u5e76\\u4e0d\\u662f\\u529f\\u80fd\\u8d8a\\u591a\\u8d8a\\u597d\\uff0c\\u6613\\u7528\\u3001\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u624d\\u662f\\u6838\\u5fc3\\uff0c\\u7f51\\u7ad9\\u5feb\\u901f\\u54cd\\u5e94\\u7528\\u6237\\u6307\\u4ee4\\uff0c\\u62d2\\u7edd\\u5ba2\\u6237\\u6d41\\u5931\\u3002\"},{\"title\":\"\\u4f18\\u5316\\u6d4b\\u8bd5\\u4e0a\\u7ebf\",\"small\":\"\\u7ec6\\u8282\\u3001\\u7ec6\\u8282\\u3001\\u8fd8\\u662f\\u7ec6\\u8282\",\"content\":\"\\u7f51\\u7ad9\\u4e0a\\u7ebf\\u524d\\u4e0d\\u65ad\\u7684\\u4f18\\u5316\\u548c\\u6d4b\\u8bd5\\uff0c\\u56fe\\u7247\\u3001\\u4ee3\\u7801\\u3001\\u901f\\u5ea6\\u4f18\\u5316\\u3001\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\\u3001\\u7f51\\u7ad9\\u5185\\u5bb9\\u4f18\\u5316\\u7b49\\u3002URL\\u3001\\u6d4f\\u89c8\\u5668\\u517c\\u5bb9\\u6027\\u3001\\u670d\\u52a1\\u5668\\u627f\\u8f7d\\u538b\\u529b\\u6d4b\\u8bd5\\uff0c\\u5404\\u7c7b\\u7ec8\\u7aef\\u9002\\u914d\\u3001\\u7528\\u6237\\u4f53\\u9a8c\\u53ca\\u8f6c\\u5316\\u7387\\u6d4b\\u8bd5\\u7b49\\u3002\\u5173\\u6ce8\\u7ec6\\u8282\\uff0c\\u8ffd\\u6c42\\u5b8c\\u7f8e\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"small\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u4e00\\u4e2a\\u4f18\\u79c0\\u7684\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u9700\\u8981\\u53cc\\u65b9\\u5408\\u529b\\u53bb\\u6253\\u9020\"},{\"content\":\"\\u7ecf\\u8fc7\\u4ee5\\u4e0a6\\u4e2a\\u6b65\\u9aa4\\uff0c\\u786e\\u4fdd\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u7b26\\u5408\\u4f01\\u4e1a\\u7684\\u9884\\u671f\"},{\"content\":\"\\u770b\\u5f97\\u89c1\\uff0c\\u6478\\u7684\\u7740\\uff0c\\u63a7\\u5236\\u8fd4\\u5de5\\uff0c\\u8282\\u7ea6\\u65f6\\u95f4\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}},\"combo\":{\"title\":\"\\u670d\\u52a1\\u5957\\u9910\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u4ef7\\u683c\\u76f8\\u540c\\uff0c\\u4ef7\\u503c\\u5374\\u4e0d\\u540c\"},{\"content\":\"\\u6211\\u4eec\\u53ef\\u4ee5\\u8ba9\\u60a8\\u7684\\u4f01\\u4e1a\\u77ed\\u65f6\\u95f4\\u5185\\u62e5\\u6709\\u4e0e\\u9876\\u5c16\\u540c\\u884c\\u540c\\u6837\\u7684\\u7f51\\u7edc\\u8425\\u9500\\u6c34\\u51c6\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\",\"type\":\"textarea\",\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u6bcf\\u4e2a\\u5957\\u9910\\u6211\\u4eec\\u90fd\\u4f1a\\u5168\\u529b\\u6253\\u9020\\uff0c\\u56e0\\u4e3a\\u6211\\u4eec\\u66f4\\u52a0\\u6ce8\\u91cd\\u60a8\\u7684\\u53e3\\u7891\\uff0c\\u53ea\\u4e3a\\u5408\\u4f5c\\u4e4b\\u540e\\u60a8\\u80fd\\u4e3a\\u6211\\u4eec\\u70b9\\u8d5e\"},{\"content\":\"\\u6211\\u4eec\\u63a8\\u8350\\u60a8\\u9009\\u62e9\\u4e13\\u4e1a\\u578b\\u4ee5\\u4e0a\\u5957\\u9910\\uff0c\\u4e00\\u52b3\\u6c38\\u9038\\uff0c\\u4ee5\\u6211\\u4eec\\u7684\\u8fd0\\u8425\\u7ecf\\u9a8c\\u6765\\u907f\\u514d\\u4f01\\u4e1a\\u5c11\\u8d70\\u5f2f\\u8def\"},{\"content\":\"21\\u4e16\\u7eaa\\u7684\\u5f53\\u4e0b\\uff0c\\u65f6\\u95f4\\u6210\\u672c\\u6216\\u8bb8\\u662f\\u6211\\u4eec\\u6700\\u5927\\u7684\\u6210\\u672c\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}}}}','{\"vars\":{\"services\":{\"title\":\"\\u7ea2\\u8272\\u5c0f\\u6807\\u9898\",\"value\":\"\\u4ece\\u73b0\\u5728\\u5f00\\u59cb\\u514d\\u8d39\\u83b7\\u5f971\\u5e74\\u8425\\u9500\\u987e\\u95ee\\u670d\\u52a1\\u53ca\\u7ec8\\u8eab\\u7684\\u7f51\\u7ad9\\u6280\\u672f\\u652f\\u6301\\uff0c\\u8ba9\\u4f01\\u4e1a\\u7684\\u6bcf\\u4e00\\u5206\\u6295\\u5165\\u90fd\\u83b7\\u5f97\\u4ef7\\u503c\\uff01\",\"type\":\"text\",\"tip\":\"\\u7ea2\\u8272\\u5c0f\\u6807\\u9898\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5c55\\u793a\\u54c1\\u724c\\uff0c\\u5f3a\\u5316\\u8425\\u9500\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u4e00\\u7ad9\\u5f0f\\u5168\\u7f51\\u8425\\u9500\\u89e3\\u51b3\\u65b9\\u6848\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"scope\":{\"title\":\"\\u670d\\u52a1\\u8303\\u7574\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u6211\\u4eec\\u53ef\\u4ee5\\u5e2e\\u60a8\\u505a\\u7684\"},{\"content\":\"\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u5efa\\u8bbe\\u3001\\u7f51\\u7ad9\\u8fd0\\u8425\\u63a8\\u5e7f\\u3001\\u6574\\u4f53\\u8425\\u9500\\u7b56\\u5212\\u3001\\u7f51\\u7edc\\u54c1\\u724c\\u63a8\\u5e7f\\u7b49\\u5168\\u7f51\\u8425\\u9500\\u89e3\\u51b3\\u65b9\\u6848\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":[{\"title\":\"\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u5efa\\u8bbe\",\"etitle\":\"Website Construction\",\"content\":\"\\u91cd\\u8425\\u9500\\u66f4\\u91cd\\u54c1\\u724c\\uff0c\\u7cbe\\u7ec6\\u5316\\u7684\\u8bbe\\u8ba1\\uff0c\\u5f70\\u663e\\u54c1\\u724c\\u89c6\\u89c9\\u3002\\u5f3a\\u5316\\u7f51\\u7ad9\\u8425\\u9500\\u5c5e\\u6027\\uff0c\\u8d85\\u5f3a\\u8bf4\\u670d\\u529b\\u63d0\\u5347\\u8f6c\\u5316\\u7387300%\\u3002html5\\u56fd\\u9645\\u6807\\u51c6\\uff0c\\u9002\\u5e94\\u5f53\\u4e0b\\u517c\\u5bb9\\u672a\\u6765\\uff0c\\u54cd\\u5e94\\u5f0f\\u6280\\u672f\\u5b8c\\u7f8e\\u9002\\u5e94\\u5404\\u79cd\\u8bbe\\u5907\\u3002\\u7f51\\u7ad9\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\\uff0c\\u4e3a\\u7f51\\u7ad9\\u6ce8\\u5165\\u751f\\u547d\\u529b\\u3002\\u9762\\u5411\\u641c\\u7d22\\u5f15\\u64ce\\u53cb\\u597d\\uff0c\\u63d0\\u5347SEO\\u81ea\\u7136\\u6392\\u540d\\uff0c\\u8282\\u7ea6\\u4f01\\u4e1a\\u6210\\u672c\\u3002\\u9762\\u5411\\u7528\\u6237\\u53cb\\u597d\\uff0c\\u6ce8\\u91cd\\u7528\\u6237\\u4f53\\u9a8c\\uff0c\\u4e00\\u5207\\u4ee5\\u7528\\u6237\\u4e3a\\u4e2d\\u5fc3\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u8fd0\\u8425\\u63a8\\u5e7f\",\"etitle\":\"Website operators\",\"content\":\"\\u5177\\u5907\\u6574\\u5408\\u8425\\u9500\\u8fd0\\u8425\\u7684\\u80fd\\u529b\\uff0c\\u4e0d\\u4ec5\\u9650\\u4e8e\\u5efa\\u7ad9\\u3002\\u7f51\\u7ad9\\u7684\\u6574\\u4f53\\u7b56\\u5212\\u53ca\\u63a8\\u5e7f\\uff0c\\u63d0\\u5347\\u4f01\\u4e1a\\u8f6f\\u5b9e\\u529b\\u3002\\u767e\\u5ea6\\u63a8\\u5e7f\\u8fd0\\u8425\\u7ba1\\u7406\\uff0c\\u8ba9\\u6bcf\\u4e00\\u5206\\u94b1\\u90fd\\u82b1\\u5728\\u5200\\u5203\\u4e0a\\u3002\\u641c\\u7d22\\u5f15\\u64ce\\u5173\\u952e\\u8bcd\\u4f18\\u5316\\uff08SEO\\uff09\\u3001\\u7f51\\u7ad9\\u5185\\u5bb9\\u5efa\\u8bbe\\u6807\\u51c6\\u5316\\u3001\\u7f51\\u7ad9\\u8fd0\\u8425\\u56e2\\u961f\\u5efa\\u8bbe\\u53ca\\u8fd0\\u8425\\u6d41\\u7a0b\\u6807\\u51c6\\u5316\\u3001\\u7528\\u6237\\u7814\\u7a76\\u7ba1\\u7406\\u7b49\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7f51\\u7edc\\u8425\\u9500\\u4f20\\u64ad\",\"etitle\":\"Marketing Communication\",\"content\":\"\\u4e92\\u8054\\u7f51\\/\\u79fb\\u52a8\\u4e92\\u8054\\u7f51\\u5168\\u7f51\\u8425\\u9500\\u4f20\\u64ad\\u65b9\\u6848\\uff0c\\u65b0\\u5a92\\u4f53\\u8425\\u9500\\u7ba1\\u7406\\uff0c\\u63d0\\u5347\\u7f51\\u7edc\\u54c1\\u724c\\u5f71\\u54cd\\u529b\\u3002\\u4f20\\u9012\\u5ba2\\u6237\\u6b63\\u5411\\u4ef7\\u503c\\uff0c\\u7ba1\\u7406\\u5ba2\\u6237\\u5173\\u7cfb\\uff0c\\u53d1\\u73b0\\u3001\\u6ee1\\u8db3\\u548c\\u521b\\u9020\\u987e\\u5ba2\\u9700\\u6c42\\uff0c\\u4e3a\\u4f01\\u4e1a\\u63d0\\u5347\\u54c1\\u724c\\u77e5\\u540d\\u5ea6\\u53ca\\u7f51\\u7edc\\u7f8e\\u8a89\\u5ea6\\uff0c\\u771f\\u6b63\\u5b9e\\u73b0\\u4f01\\u4e1a\\u4ef7\\u503c\\u3002\",\"icon\":\"\"},{\"title\":\"\\u54c1\\u724c\\u6218\\u7565\\u7ba1\\u7406\",\"etitle\":\"Brand Manage\",\"content\":\"\\u534f\\u52a9\\u4f01\\u4e1a\\u5bf9\\u54c1\\u724c\\u91cd\\u65b0\\u5b9a\\u4e49\\uff0c\\u6316\\u6398\\u54c1\\u724c\\u4ef7\\u503c\\u3001\\u63d0\\u5347\\u54c1\\u724c\\u8d44\\u4ea7\\u53ca\\u5185\\u90e8\\u7ba1\\u7406\\u6548\\u7387\\u3002\\u5236\\u5b9a\\u4ee5\\u54c1\\u724c\\u6838\\u5fc3\\u4ef7\\u503c\\u4e3a\\u4e2d\\u5fc3\\u7684\\u54c1\\u724c\\u8bc6\\u522b\\u7cfb\\u7edf\\uff0c\\u4f01\\u4e1aCIS\\u7cfb\\u7edf\\u5efa\\u8bbe\\uff08VI\\u3001BI\\u3001MI\\uff09\\uff0c\\u4f18\\u9009\\u54c1\\u724c\\u5316\\u6218\\u7565\\u4e0e\\u54c1\\u724c\\u67b6\\u6784\\u3002\",\"icon\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u82f1\\u6587\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u6211\\u4eec\\u7684\\u5173\\u6ce8\\u70b9\\u4e0d\\u662f\\u80fd\\u4e3a\\u60a8\\u505a\\u4e9b\\u4ec0\\u4e48\\uff0c\\u800c\\u662f\\u505a\\u4e86\\u4ec0\\u4e48\\uff0c\\u6709\\u6ca1\\u6709\\u505a\\u597d\"},{\"content\":\"\\u7ed9\\u6211\\u4eec\\u4e00\\u4e2a\\u5c55\\u793a\\u7684\\u673a\\u4f1a\\u6765\\u8bc1\\u660e\\u81ea\\u5df1\"},{\"content\":\"\\u8fd9\\u5e76\\u4e0d\\u4f1a\\u82b1\\u8d39\\u60a8\\u592a\\u591a\\u65f6\\u95f4\\uff0c\\u6216\\u8bb8\\u4f1a\\u7ed9\\u60a8\\u5e26\\u6765\\u65b0\\u7684\\u7075\\u611f\\u548c\\u60ca\\u559c\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}},\"advantage\":{\"title\":\"\\u670d\\u52a1\\u4f18\\u52bf\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u8fd1120\\u9879\\u8861\\u91cf\\u6307\\u6807\\uff0c\\u6781\\u5c3d\\u5b8c\\u7f8e\\u7684\\u7ec6\\u8282\\u5904\\u7406\"},{\"content\":\"\\u6d89\\u53ca\\u5185\\u5bb9\\u3001\\u54c1\\u724c\\u3001\\u8425\\u9500\\u3001\\u6613\\u7528\\u6027\\u3001\\u8bbe\\u8ba1\\u3001\\u5b89\\u5168\\u3001\\u6027\\u80fd\\u3001W3C\\u6807\\u51c6\\u3001SEO\\u7b499\\u5927\\u9886\\u57df\"},{\"content\":\"12\\u5927\\u6838\\u5fc3\\u4f18\\u52bf\\u52a9\\u529b\\u4e3a\\u60a8\\u6253\\u9020\\u5b8c\\u7f8e\\u7684\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":[{\"title\":\"\\u5047\\u5982\\u628a\\u7f51\\u7ad9\\u6bd4\\u505a\\u4e00\\u4e2a\\u4eba\",\"small\":\"\\u6211\\u4eec\\u6216\\u8bb8\\u53ef\\u4ee5\\u8fd9\\u6837\\u7406\\u89e3\\u4e00\\u4e2a\\u5b8c\\u7f8e\\u7684\\u4eba\",\"content\":\"1\\u3001\\u5185\\u5bb9\\uff08\\u6211\\u6709\\u771f\\u624d\\u5b9e\\u5b66\\uff092\\u3001\\u54c1\\u724c\\uff08\\u6211\\u662f\\u4e00\\u4e2a\\u6709\\u6545\\u4e8b\\u7684\\u4eba\\uff093\\u3001\\u8425\\u9500\\uff08\\u6211\\u53ef\\u4ee5\\u6e05\\u6670\\u7684\\u3001\\u771f\\u5b9e\\u7684\\u8868\\u8fbe\\u81ea\\u5df1\\uff094\\u3001\\u6613\\u4e8e\\u4f7f\\u7528\\uff08\\u5bb9\\u6613\\u6c9f\\u901a\\u4e0e\\u76f8\\u5904\\uff095\\u3001\\u8bbe\\u8ba1\\uff08\\u770b\\u4e0a\\u53bb\\u4e5f\\u5f88\\u68d2\\uff096\\u3001\\u5b89\\u5168\\uff08\\u975e\\u5e38\\u53ef\\u9760\\uff097\\u3001\\u6027\\u80fd\\uff08\\u5065\\u5eb7\\u5f3a\\u58ee\\uff098\\u3001W3C\\u6807\\u51c6\\uff08\\u9075\\u5b88\\u89c4\\u5219\\uff099\\u3001SEO\\uff08\\u88ab\\u5f88\\u591a\\u4eba\\u5173\\u6ce8\\uff09\",\"icon\":\"\"},{\"title\":\"\\u8425\\u9500\\/\\u54c1\\u724c\\u7b56\\u5212\",\"small\":\"\\u65e2\\u91cd\\u8425\\u9500\\u66f4\\u91cd\\u54c1\\u724c\\uff0c\\u52a0\\u5f3a\\u8425\\u9500\\u800c\\u53c8\\u4e0d\\u5931\\u54c1\\u724c\\u89c6\\u89c9\\u624d\\u7b97\\u5b8c\\u7f8e\",\"content\":\"\\u4ee5\\u8425\\u9500\\u4e3a\\u6838\\u5fc3\\u76ee\\u6807\\u8fdb\\u884c\\u7b56\\u5212\\uff0c\\u4e3a\\u7f51\\u7ad9\\u6ce8\\u5165\\u8425\\u9500\\u5c5e\\u6027\\u3001\\u5185\\u5bb9\\u6587\\u6848\\u7b56\\u5212\\u3001\\u6838\\u5fc3\\u4f18\\u52bf\\u6316\\u6398\\u7b49\\uff0c\\u914d\\u5408\\u4f18\\u79c0\\u7684\\u54c1\\u724c\\u89c6\\u89c9\\u8868\\u73b0\\u529b\\uff0c\\u4e3a\\u60a8\\u91cf\\u8eab\\u6253\\u9020\\u54c1\\u724c\\u8425\\u9500\\u578b\\u7f51\\u7ad9\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7cbe\\u51c6\\u5b9a\\u4f4d\",\"small\":\"\\u9762\\u5411\\u76ee\\u6807\\u7528\\u6237\\u91cf\\u8eab\\u5b9a\\u5236\\uff0c\\u61c2\\u5f97\\u53d6\\u820d\\u624d\\u662f\\u5927\\u9053\",\"content\":\"\\u6839\\u636e\\u4f01\\u4e1a\\u73b0\\u72b6\\u53ca\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\uff0c\\u540c\\u65f6\\u7ed3\\u5408\\u5386\\u53f2\\u6570\\u636e\\u8868\\u73b0\\u8fdb\\u884c\\u6df1\\u5ea6\\u5206\\u6790\\uff0c\\u4e3a\\u4f01\\u4e1a\\u5236\\u5b9a\\u7cbe\\u51c6\\u7684\\u5b9a\\u4f4d\\uff0c\\u9762\\u5411\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\u6316\\u6398\\u4f01\\u4e1a\\u7684\\u72ec\\u6709\\u4f18\\u52bf\\u3002\",\"icon\":\"\"},{\"title\":\"\\u7f51\\u7ad9\\u89c6\\u89c9\\u8bbe\\u8ba1\",\"small\":\"\\u9075\\u5faa\\u4f18\\u96c5\\u3001\\u5e73\\u548c\\u3001\\u7edf\\u4e00\\u7684\\u539f\\u5219\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\",\"content\":\"\\u7ed3\\u5408\\u4f01\\u4e1a\\u54c1\\u724c\\u89c6\\u89c9\\u6807\\u51c6\\uff0c\\u7b80\\u6d01\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u8303\\u513f\\u7684\\u9875\\u9762\\u8bbe\\u8ba1\\uff0c\\u540c\\u65f6\\u53c8\\u4e0d\\u5931\\u4f18\\u96c5\\u4e0e\\u5e73\\u548c\\u7684\\u7edf\\u4e00\\u8868\\u73b0\\uff0c\\u4f53\\u73b0\\u8425\\u9500\\u7684\\u540c\\u65f6\\u66f4\\u52a0\\u91cd\\u89c6\\u54c1\\u724c\\u89c6\\u89c9\\uff0c\\u8ba9\\u7528\\u6237\\u7b2c\\u4e00\\u773c\\u5c31\\u7231\\u4e0a\\u3002\",\"icon\":\"\"},{\"title\":\"\\u667a\\u80fd\\u5e03\\u5c40\\u7b56\\u5212\",\"small\":\"\\u79d1\\u5b66\\u5206\\u5e03\\u5185\\u5bb9\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u5173\\u6ce8\\u7684\\u91cd\\u70b9\\uff0c\\u800c\\u975e\\u6211\\u4eec\\u8ba4\\u4e3a\\u7684\\u91cd\\u70b9\",\"content\":\"\\u6839\\u636e\\u7528\\u6237\\u7684\\u6d4f\\u89c8\\u4e60\\u60ef\\uff0c\\u5c06\\u7f51\\u7ad9\\u4e2d\\u7684\\u5185\\u5bb9\\u8fdb\\u884c\\u667a\\u80fd\\u5212\\u5206\\uff0c\\u6e05\\u6670\\u6709\\u5e8f\\u7684\\u5185\\u5bb9\\u7ed3\\u6784\\u5206\\u5e03\\uff0c\\u5c06\\u7528\\u6237\\u771f\\u6b63\\u5173\\u5fc3\\u7684\\u5185\\u5bb9\\u7a81\\u663e\\uff0c\\u8ba9\\u7528\\u6237\\u7b2c\\u4e00\\u65f6\\u95f4\\u5173\\u6ce8\\u3002\",\"icon\":\"\"},{\"title\":\"\\u54cd\\u5e94\\u5f0f\\u7f51\\u7ad9\\u67b6\\u6784\",\"small\":\"html5+css3\\u6280\\u672f\\uff0c\\u4e00\\u4e2a\\u7f51\\u5740\\uff0c\\u4e00\\u5957\\u5185\\u5bb9\\u3001\\u7edf\\u4e00\\u6218\\u7565\",\"content\":\"\",\"icon\":\"\"},{\"title\":\"\\u7528\\u6237\\u4f53\\u9a8c\\u4f18\\u5316\",\"small\":\"\\u53ef\\u7528\\u7684\\u3001\\u6613\\u7528\\u7684\\u3001\\u5b9e\\u7528\\u7684\\uff0c\\u6709\\u4ef7\\u503c\\u7684\",\"content\":\"\\u4e00\\u5207\\u4ee5\\u7528\\u6237\\u4e3a\\u4e2d\\u5fc3\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u4f53\\u9a8c\\uff0c\\u7f51\\u7ad9\\u53ef\\u7528\\u6027\\u3001\\u6613\\u7528\\u6027\\u3001\\u5b9e\\u7528\\u6027\\u7b49\\u8fdb\\u884c\\u6df1\\u5ea6\\u4f18\\u5316\\uff0c\\u5b9e\\u73b0\\u7f51\\u7ad9\\u5feb\\u901f\\u54cd\\u5e94\\uff0c\\u6700\\u9ad8\\u5b9e\\u73b01\\u79d2\\u5185\\u6253\\u5f00\\u7f51\\u7ad9\\uff0c\\u62d2\\u7edd\\u5ba2\\u6237\\u6d41\\u5931\\u3002\",\"icon\":\"\"},{\"title\":\"\\u4f01\\u4e1a\\u5f62\\u8c61\\u62cd\\u6444\",\"small\":\"\\u4f01\\u4e1a\\u529e\\u516c\\u573a\\u666f\\u3001\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\u4f18\\u5316\\u91c7\\u96c6\",\"content\":\"\\u6211\\u4eec\\u53ef\\u4ee5\\u4e3a\\u60a8\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u529e\\u516c\\u573a\\u666f\\u3001\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u5e76\\u5bf9\\u7167\\u7247\\u8fdb\\u884c\\u4f18\\u5316\\u5904\\u7406\\uff0c\\u4e0d\\u653e\\u8fc7\\u4efb\\u4f55\\u4e00\\u4e2a\\u7ec6\\u8282\\uff0c\\u771f\\u6b63\\u7ad9\\u5728\\u4f01\\u4e1a\\u7684\\u89d2\\u5ea6\\u53bb\\u601d\\u8003\\uff0c\\u5168\\u9762\\u5305\\u88c5\\u4f01\\u4e1a\\u54c1\\u724c\\u3002\",\"icon\":\"\"},{\"title\":\"\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\",\"small\":\"\\u7f51\\u7ad9\\u5185\\u90e8\\u4f18\\u5316\\u3001SEO\\u7b56\\u7565\\u3001\\u5173\\u952e\\u8bcd\\u90e8\\u7f72\",\"content\":\"SEO\\u5206\\u4e3a\\u7ad9\\u5185\\u548c\\u7ad9\\u5916\\u4f18\\u5316\\uff0c\\u53ea\\u6709\\u7f51\\u7ad9\\u5185\\u90e8\\u4ee3\\u7801\\u3001\\u7ed3\\u6784\\uff0c\\u5173\\u952e\\u8bcd\\u7b49\\u90e8\\u7f72\\u5408\\u7406\\uff0c\\u624d\\u80fd\\u53d6\\u5f97SEO\\u5173\\u952e\\u8bcd\\u4f18\\u5316\\u7684\\u6210\\u529f\\uff0c\\u6211\\u4eec\\u4f1a\\u5e2e\\u60a8\\u9884\\u5148\\u90e8\\u7f72\\u597d\\u7ad9\\u5185\\u7684\\u4e00\\u5207\\u3002\",\"icon\":\"\"},{\"title\":\"\\u91cd\\u8981\\u5185\\u5bb9\\u586b\\u5145\",\"small\":\"\\u9884\\u5148\\u586b\\u5145\\u91cd\\u8981\\u5185\\u5bb9\",\"content\":\"\\u4e00\\u822c\\u5efa\\u7ad9\\u516c\\u53f8\\u4e0d\\u4e3a\\u4f01\\u4e1a\\u586b\\u5145\\u8d44\\u6599\\uff0c\\u66f4\\u8c08\\u4e0d\\u4e0a\\u5185\\u5bb9\\u7b56\\u5212\\uff0c\\u7ed3\\u679c\\u5bfc\\u81f4\\u7f51\\u7ad9\\u754c\\u9762\\u4f18\\u79c0\\uff0c\\u5185\\u5bb9\\u5374\\u5341\\u5206\\u7a7a\\u6cdb\\u6216\\u6574\\u4f53\\u4e0d\\u534f\\u8c03\\uff0c\\u5185\\u5bb9\\u7b56\\u5212\\u3001\\u5185\\u5bb9\\u586b\\u5145\\u8bf7\\u4ea4\\u7ed9\\u6211\\u4eec\",\"icon\":\"\"},{\"title\":\"\\u63a8\\u5e7f\\u8fd0\\u8425\\u7ba1\\u7406\",\"small\":\"\\u540e\\u7eed\\u63a8\\u5e7f\\u8fd0\\u8425\\u652f\\u6301\",\"content\":\"\\u7f51\\u7ad9\\u4e0a\\u7ebf\\uff0c\\u4ec5\\u4ec5\\u53ea\\u662f\\u5f00\\u59cb\\uff0c\\u6210\\u529f\\u63a8\\u5e7f\\u4e3a\\u4f01\\u4e1a\\u5e26\\u6765\\u4ef7\\u503c\\u624d\\u662f\\u6838\\u5fc3\\uff0c\\u6211\\u4eec\\u53ef\\u4ee5\\u4e3a\\u60a8\\u63d0\\u4f9b\\u540e\\u7eed\\u7684\\u63a8\\u5e7f\\u8fd0\\u8425\\u652f\\u6301\\uff0c\\u5168\\u9762\\u63d0\\u5347\\u4f01\\u4e1a\\u8f6f\\u5b9e\\u529b\\u3002\",\"icon\":\"\"},{\"title\":\"\\u8425\\u9500\\u5de5\\u5177\\u652f\\u6301\",\"small\":\"\\u968f\\u65f6\\u63d0\\u4f9b\\u6700\\u65b0\\u8425\\u9500\\u5de5\\u5177\\u548c\\u8425\\u9500\\u7406\\u5ff5\",\"content\":\"\\u6211\\u4eec\\u968f\\u65f6\\u4e3a\\u60a8\\u63d0\\u4f9b\\u6700\\u65b0\\u7684\\u8425\\u9500\\u7406\\u5ff5\\u3001\\u8425\\u9500\\u5de5\\u5177\\u53ca\\u4f7f\\u7528\\u6280\\u5de7\\uff0c\\u534f\\u52a9\\u4f01\\u4e1a\\u8fd0\\u8425\\u56e2\\u961f\\u901a\\u8fc7\\u65b0\\u578b\\u8425\\u9500\\u7406\\u5ff5\\u53ca\\u5de5\\u5177\\u5f97\\u5230\\u5feb\\u901f\\u6210\\u957f\\uff0c\\u63d0\\u5347\\u4f01\\u4e1a\\u4e1a\\u7ee9\\u3002\",\"icon\":\"\"},{\"title\":\"\\u987e\\u95ee\\u7fa4\\u652f\\u6301\",\"small\":\"\\u8d44\\u6df1SEM\\u4e13\\u5bb6\\u3001\\u8425\\u9500\\u987e\\u95ee\",\"content\":\"\\u4f17\\u591a8\\u5e74\\u4ee5\\u4e0a\\u7684\\u4e13\\u4e1a\\u987e\\u95ee\\u7fa4\\u56e2\\u961f\\uff0c\\u7ecf\\u9a8c\\u4e30\\u5bcc\\uff0c\\u7cbe\\u901a\\u641c\\u7d22\\u5f15\\u64ce\\u8425\\u9500\\uff08SEM\\uff09\\u53ca\\u7f51\\u7ad9\\u8fd0\\u8425\\u5b9e\\u6218\\u6280\\u5de7\\uff0c\\u5e76\\u80fd\\u4e0e\\u65f6\\u4ff1\\u8fdb\\uff0c\\u6301\\u7eed\\u4e3a\\u4f01\\u4e1a\\u8f93\\u5165\\u52a8\\u529b\\u3002\",\"icon\":\"\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"small\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u8fd9\\u4e9b\\u5e76\\u4e0d\\u80fd\\u4ee3\\u8868\\u4ec0\\u4e48\\uff0c\\u65f6\\u4ee3\\u5728\\u4e0d\\u65ad\\u53d1\\u5c55\\uff0c\\u6211\\u4eec\\u4ecd\\u9700\\u4e0d\\u65ad\\u7684\\u52aa\\u529b\\u6765\\u589e\\u5f3a\\u6838\\u5fc3\\u7adf\\u4e89\\u529b\"},{\"content\":\"\\u6211\\u4eec\\u53ea\\u60f3\\u4e0e\\u60a8\\u4ea4\\u4e2a\\u670b\\u53cb\\uff0c\\u4ee5\\u6211\\u4eec\\u7684\\u5fae\\u8584\\u4e4b\\u529b\\uff0c\\u5171\\u540c\\u63a2\\u8ba8\\uff0c\\u4e0e\\u60a8\\u4e00\\u8d77\\u6210\\u957f\"},{\"content\":\"\\u5982\\u679c\\u60a8\\u89c9\\u5f97\\u6211\\u4eec\\u8fd8\\u7b97\\u9760\\u8c31\\uff0c\\u6216\\u8bb8\\u6211\\u4eec\\u53ef\\u4ee5\\u804a\\u804a\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}},\"process\":{\"title\":\"\\u670d\\u52a1\\u6d41\\u7a0b\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u6211\\u4eec\\u62e5\\u6709\\u4e00\\u5957\\u6781\\u4f73\\u7684\\u6d41\\u7a0b\\uff0c\\u4e3a\\u60a8\\u6253\\u9020\\u4f18\\u79c0\\u7684\\u54c1\\u724c\\u8425\\u9500\\u5c55\\u793a\\u5e73\\u53f0\"},{\"content\":\"\\u6bcf\\u4e2a\\u73af\\u8282\\u90fd\\u80fd\\u8ba9\\u4f01\\u4e1a\\u5b9e\\u65f6\\u7684\\u8ddf\\u8fdb\\u7f51\\u7ad9\\u7684\\u8fdb\\u5ea6\\u53ca\\u8d28\\u91cf\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":[{\"title\":\"\\u6838\\u5fc3\\u9700\\u6c42\\u6316\\u6398\",\"small\":\"\\u4f01\\u4e1a\\u8ba4\\u77e5\\u3001\\u5b9a\\u4f4d\\u3001\\u76ee\\u6807\",\"content\":\"\\u786e\\u5b9a\\u5408\\u4f5c\\u540e\\u9996\\u5148\\u4e0e\\u4f01\\u4e1a\\u8d1f\\u8d23\\u4eba\\u6df1\\u5ea6\\u6c9f\\u901a\\uff0c\\u5bf9\\u6574\\u4f53\\u8425\\u9500\\u6838\\u5fc3\\u7684\\u76ee\\u6807\\u8fbe\\u6210\\u3001\\u4f01\\u4e1a\\u54c1\\u724c\\u6587\\u5316\\u5c55\\u793a\\u3001\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\\u5b9a\\u4f4d\\u7b49\\u8fdb\\u884c\\u6316\\u6398\\uff0c\\u534f\\u52a9\\u4f01\\u4e1a\\u6316\\u6398\\u6f5c\\u5728\\u7684\\u8425\\u9500\\u673a\\u4f1a\\uff0c\\u8fdb\\u884c\\u8425\\u9500\\u548c\\u54c1\\u724c\\u7684\\u521b\\u65b0\\u3002\"},{\"title\":\"\\u7f51\\u7ad9\\u6574\\u4f53\\u7b56\\u5212\",\"small\":\"\\u7b56\\u5212\\u65b9\\u6848\\uff0c\\u5185\\u5bb9\\u91c7\\u96c6\\u3001\\u5168\\u9762\\u3001\\u4e13\\u4e1a\\u3001\\u771f\\u5b9e\",\"content\":\"\\u4f9d\\u636e\\u76ee\\u6807\\u548c\\u5b9a\\u4f4d\\u8fdb\\u884c\\u5206\\u6790\\u548c\\u7b56\\u5212\\uff0c\\u8fdb\\u884c\\u5185\\u5bb9\\u91cd\\u7ec4\\u3001\\u6587\\u6848\\u7b56\\u5212\\u3001\\u7f51\\u7ad9\\u7ed3\\u6784\\u7b56\\u5212\\uff0c\\u6316\\u6398\\u4f01\\u4e1a\\u7684\\u6587\\u5316\\u6838\\u5fc3\\u548c\\u7adf\\u4e89\\u4f18\\u52bf\\uff0c\\u5f70\\u663e\\u4f01\\u4e1a\\u72ec\\u6709\\u7684\\u54c1\\u724c\\u9b45\\u529b\\uff0c\\u62cd\\u6444\\u9ad8\\u8d28\\u91cf\\u7684\\u529e\\u516c\\u573a\\u666f\\u53ca\\u56e2\\u961f\\u5f62\\u8c61\\u7167\\u7247\\uff0c\\u63d0\\u5347\\u6574\\u4f53\\u89c6\\u89c9\\u3002\"},{\"title\":\"\\u754c\\u9762\\u7ed3\\u6784\\u5e03\\u5c40\",\"small\":\"\\u6838\\u5fc3\\u67b6\\u6784\\u3001\\u5b9a\\u5411\\u6ee1\\u8db3\\u76ee\\u6807\\u7528\\u6237\\u7fa4\\u4f53\",\"content\":\"\\u6839\\u636e\\u7f51\\u7ad9\\u5185\\u5bb9\\u7684\\u91cd\\u8981\\u5c42\\u6b21\\uff0c\\u9762\\u5411\\u76ee\\u6807\\u5ba2\\u6237\\u7fa4\\u4f53\\uff0c\\u7ed3\\u5408\\u7528\\u6237\\u7684\\u6d4f\\u89c8\\u4e60\\u60ef\\u3001\\u7528\\u6237\\u5173\\u6ce8\\u5ea6\\u3001\\u51b3\\u7b56\\u4f9d\\u636e\\u7b49\\u5c5e\\u6027\\uff0c\\u5bf9\\u7f51\\u7ad9\\u5185\\u5bb9\\u6a21\\u5757\\u8fdb\\u884c\\u79d1\\u5b66\\u7684\\u5206\\u5e03\\uff0c\\u5f3a\\u5316\\u7528\\u6237\\u5173\\u5fc3\\u91cd\\u70b9\\uff0c\\u5c06\\u4f01\\u4e1a\\u6838\\u5fc3\\u670d\\u52a1\\u3001\\u54c1\\u724c\\u6587\\u5316\\u7b49\\u6eb6\\u4e8e\\u65b9\\u5bf8\\u4e4b\\u95f4\\u3002\"},{\"title\":\"\\u5f62\\u8c61\\u8bbe\\u8ba1\",\"small\":\"\\u9075\\u5faa\\u4f18\\u96c5\\u3001\\u5e73\\u548c\\u3001\\u7edf\\u4e00\\u7684\\u539f\\u5219\",\"content\":\"\\u7ed3\\u5408\\u4f01\\u4e1a\\u54c1\\u724c\\u89c6\\u89c9\\u7cfb\\u7edf\\uff0c\\u4e3a\\u4f01\\u4e1a\\u6253\\u9020\\u4e13\\u5c5e\\u7684\\u79c1\\u5bb6\\u5f62\\u8c61\\uff0c\\u7b80\\u7ea6\\u3001\\u65f6\\u5c1a\\u3001\\u56fd\\u9645\\u5316\\u7684\\u8bbe\\u8ba1\\uff0c\\u800c\\u53c8\\u4e0d\\u5931\\u4f18\\u96c5\\u548c\\u5e73\\u548c\\uff0c\\u7b80\\u7ea6\\u800c\\u4e0d\\u7b80\\u5355\\uff0c\\u8ba9\\u7528\\u6237\\u6709\\u826f\\u597d\\u7684\\u89c6\\u89c9\\u4f53\\u9a8c\\uff0c\\u7b2c\\u4e00\\u773c\\u5c31\\u7231\\u4e0a\\uff0c\\u5b9e\\u73b0\\u4f01\\u4e1a\\u7684\\u54c1\\u724c\\u89c6\\u89c9\\u4f20\\u64ad\\u3002\"},{\"title\":\"\\u7a0b\\u5e8f\\u5f00\\u53d1\",\"small\":\"\\u5b9e\\u7528\\u3001\\u5feb\\u901f\\u3001\\u5b89\\u5168\\u4e3a\\u6838\\u5fc3\",\"content\":\"\\u4e00\\u5207\\u4ee5\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u4e3a\\u4e3b\\u8981\\u65b9\\u5411\\uff0c\\u8fc7\\u591a\\u7684\\u529f\\u80fd\\u4f1a\\u7ed9\\u7528\\u6237\\u548c\\u670d\\u52a1\\u5668\\u9020\\u6210\\u538b\\u529b\\uff0c\\u7f51\\u7ad9\\u5e76\\u4e0d\\u662f\\u529f\\u80fd\\u8d8a\\u591a\\u8d8a\\u597d\\uff0c\\u6613\\u7528\\u3001\\u5b9e\\u7528\\u3001\\u5b89\\u5168\\u3001\\u7a33\\u5b9a\\u624d\\u662f\\u6838\\u5fc3\\uff0c\\u7f51\\u7ad9\\u5feb\\u901f\\u54cd\\u5e94\\u7528\\u6237\\u6307\\u4ee4\\uff0c\\u62d2\\u7edd\\u5ba2\\u6237\\u6d41\\u5931\\u3002\"},{\"title\":\"\\u4f18\\u5316\\u6d4b\\u8bd5\\u4e0a\\u7ebf\",\"small\":\"\\u7ec6\\u8282\\u3001\\u7ec6\\u8282\\u3001\\u8fd8\\u662f\\u7ec6\\u8282\",\"content\":\"\\u7f51\\u7ad9\\u4e0a\\u7ebf\\u524d\\u4e0d\\u65ad\\u7684\\u4f18\\u5316\\u548c\\u6d4b\\u8bd5\\uff0c\\u56fe\\u7247\\u3001\\u4ee3\\u7801\\u3001\\u901f\\u5ea6\\u4f18\\u5316\\u3001\\u641c\\u7d22\\u5f15\\u64ce\\u9884\\u4f18\\u5316\\u3001\\u7f51\\u7ad9\\u5185\\u5bb9\\u4f18\\u5316\\u7b49\\u3002URL\\u3001\\u6d4f\\u89c8\\u5668\\u517c\\u5bb9\\u6027\\u3001\\u670d\\u52a1\\u5668\\u627f\\u8f7d\\u538b\\u529b\\u6d4b\\u8bd5\\uff0c\\u5404\\u7c7b\\u7ec8\\u7aef\\u9002\\u914d\\u3001\\u7528\\u6237\\u4f53\\u9a8c\\u53ca\\u8f6c\\u5316\\u7387\\u6d4b\\u8bd5\\u7b49\\u3002\\u5173\\u6ce8\\u7ec6\\u8282\\uff0c\\u8ffd\\u6c42\\u5b8c\\u7f8e\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"small\":{\"title\":\"\\u5c0f\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u4e00\\u4e2a\\u4f18\\u79c0\\u7684\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u9700\\u8981\\u53cc\\u65b9\\u5408\\u529b\\u53bb\\u6253\\u9020\"},{\"content\":\"\\u7ecf\\u8fc7\\u4ee5\\u4e0a6\\u4e2a\\u6b65\\u9aa4\\uff0c\\u786e\\u4fdd\\u54c1\\u724c\\u8425\\u9500\\u7f51\\u7ad9\\u7b26\\u5408\\u4f01\\u4e1a\\u7684\\u9884\\u671f\"},{\"content\":\"\\u770b\\u5f97\\u89c1\\uff0c\\u6478\\u7684\\u7740\\uff0c\\u63a7\\u5236\\u8fd4\\u5de5\\uff0c\\u8282\\u7ea6\\u65f6\\u95f4\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}},\"combo\":{\"title\":\"\\u670d\\u52a1\\u5957\\u9910\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u5934\\u90e8\\u6807\\u9898\",\"value\":[{\"content\":\"\\u4ef7\\u683c\\u76f8\\u540c\\uff0c\\u4ef7\\u503c\\u5374\\u4e0d\\u540c\"},{\"content\":\"\\u6211\\u4eec\\u53ef\\u4ee5\\u8ba9\\u60a8\\u7684\\u4f01\\u4e1a\\u77ed\\u65f6\\u95f4\\u5185\\u62e5\\u6709\\u4e0e\\u9876\\u5c16\\u540c\\u884c\\u540c\\u6837\\u7684\\u7f51\\u7edc\\u8425\\u9500\\u6c34\\u51c6\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_content\":{\"title\":\"\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\",\"type\":\"textarea\",\"tip\":\"\"},\"bot_tips\":{\"title\":\"\\u5e95\\u90e8\\u63d0\\u793a\",\"value\":[{\"content\":\"\\u6bcf\\u4e2a\\u5957\\u9910\\u6211\\u4eec\\u90fd\\u4f1a\\u5168\\u529b\\u6253\\u9020\\uff0c\\u56e0\\u4e3a\\u6211\\u4eec\\u66f4\\u52a0\\u6ce8\\u91cd\\u60a8\\u7684\\u53e3\\u7891\\uff0c\\u53ea\\u4e3a\\u5408\\u4f5c\\u4e4b\\u540e\\u60a8\\u80fd\\u4e3a\\u6211\\u4eec\\u70b9\\u8d5e\"},{\"content\":\"\\u6211\\u4eec\\u63a8\\u8350\\u60a8\\u9009\\u62e9\\u4e13\\u4e1a\\u578b\\u4ee5\\u4e0a\\u5957\\u9910\\uff0c\\u4e00\\u52b3\\u6c38\\u9038\\uff0c\\u4ee5\\u6211\\u4eec\\u7684\\u8fd0\\u8425\\u7ecf\\u9a8c\\u6765\\u907f\\u514d\\u4f01\\u4e1a\\u5c11\\u8d70\\u5f2f\\u8def\"},{\"content\":\"21\\u4e16\\u7eaa\\u7684\\u5f53\\u4e0b\\uff0c\\u65f6\\u95f4\\u6210\\u672c\\u6216\\u8bb8\\u662f\\u6211\\u4eec\\u6700\\u5927\\u7684\\u6210\\u672c\"}],\"type\":\"array\",\"item\":{\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\",\"rule\":{\"require\":true}}},\"tip\":\"\"},\"sub_btn\":{\"title\":\"\\u6309\\u94ae\\u6807\\u9898\",\"value\":\"\\u8054\\u7cfb\\u6211\\u4eec\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u6807\\u9898\"},\"sub_btn_link\":{\"title\":\"\\u6309\\u94ae\\u94fe\\u63a5\",\"value\":\"\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\",\"tip\":\"\\u8bf7\\u8f93\\u5165\\u6309\\u94ae\\u94fe\\u63a5\"}}}}}',NULL),(8,0,4,'HjDesign001','产品列表页','portal/List/index','portal/works','产品中心模板文件','{\"vars\":{\"works_id\":{\"title\":\"\\u4ea7\\u54c1\\u7236\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u4e0e\\u65f6\\u4ff1\\u8fdb\\uff0c\\u4f20\\u64ad\\u4ef7\\u503c\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u505a\\u4ef7\\u503c\\u7684\\u4f20\\u64ad\\u8005\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"main_content\":{\"title\":\"\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u706b\\u7bad\\u6e90\\u7801-\\u4f18\\u79c0\\u6848\\u4f8b\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u586b\\u5199\\u6807\\u9898\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"sub_tips\":{\"title\":\"\\u5c0f\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u6211\\u4eec\\u81f4\\u4e3a\\u4e8e\\u6253\\u9020\\u4f18\\u79c0\\u7684\\u5efa\\u7ad9\\u8d44\\u6e90\\u5171\\u4eab\\u5e73\\u53f0\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u586b\\u5199\\u5c0f\\u6807\\u9898\\u5185\\u5bb9\",\"rule\":{\"require\":true}}}}}}','{\"vars\":{\"works_id\":{\"title\":\"\\u4ea7\\u54c1\\u7236\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u4e0e\\u65f6\\u4ff1\\u8fdb\\uff0c\\u4f20\\u64ad\\u4ef7\\u503c\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"value\":\"\\u505a\\u4ef7\\u503c\\u7684\\u4f20\\u64ad\\u8005\",\"type\":\"text\",\"tip\":\"\\u6309\\u94ae\\u8be6\\u7ec6\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"background\":{\"title\":\"\\u80cc\\u666f\\u56fe\",\"value\":\"\",\"type\":\"image\",\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\",\"tip\":\"\\u8bf7\\u9009\\u62e9\\u80cc\\u666f\\u56fe\"}}},\"main_content\":{\"title\":\"\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u706b\\u7bad\\u6e90\\u7801-\\u4f18\\u79c0\\u6848\\u4f8b\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u586b\\u5199\\u6807\\u9898\\u5185\\u5bb9\",\"rule\":{\"require\":true}},\"sub_tips\":{\"title\":\"\\u5c0f\\u6807\\u9898\\u5185\\u5bb9\",\"value\":\"\\u6211\\u4eec\\u81f4\\u4e3a\\u4e8e\\u6253\\u9020\\u4f18\\u79c0\\u7684\\u5efa\\u7ad9\\u8d44\\u6e90\\u5171\\u4eab\\u5e73\\u53f0\",\"type\":\"text\",\"tip\":\"\\u8bf7\\u586b\\u5199\\u5c0f\\u6807\\u9898\\u5185\\u5bb9\",\"rule\":{\"require\":true}}}}}}',NULL),(9,1,8,'HjDesign001','底部导航','public/Footer','public/footer','底部模板文件','{\"vars\":{\"QQ\":{\"title\":\"QQ\\u8054\\u7cfbURL\",\"value\":\"http:\\/\\/wpa.qq.com\\/msgrd?v=3&amp;uin=1140444693&amp;site=qq&amp;menu=yes\",\"type\":\"text\",\"tip\":\"QQ\\u8054\\u7cfbURL\",\"rule\":{\"require\":true}}},\"widgets\":{\"sns\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u66f4\\u591a\",\"display\":1,\"vars\":{\"features\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u66f4\\u591a\",\"value\":[],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8bbf\\u95eeURL\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"},\"address\":{\"title\":\"\\u8be6\\u7ec6\\u5730\\u5740\",\"value\":\"\\u6c5f\\u82cf\\u7701\\u5e38\\u5dde\\u5e02\\u6b66\\u8fdb\\u533a\\u79d1\\u6559\\u4f1a\\u5802\",\"type\":\"text\",\"tip\":\"\\u8be6\\u7ec6\\u5730\\u5740\"},\"email\":{\"title\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\\uff1a\",\"value\":\"1140444693@qq.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\"},\"tel\":{\"title\":\"\\u8054\\u7cfb\\u7535\\u8bdd\",\"value\":\"+86 171 777 23588\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u7535\\u8bdd\"},\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u4eba\",\"value\":\"\\u6234\\u7ecf\\u7406\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u4eba\"},\"company\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"value\":\"\\u7801\\u4e0a\\u4e91\\u7f51\\u7edc\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\",\"type\":\"text\",\"tip\":\"\\u516c\\u53f8\\u540d\\u79f0\"},\"icp\":{\"title\":\"icp\\u5907\\u6848\\u53f7\",\"value\":\"\\u6d59ICP\\u59072020040312\\u53f7\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u4eba\"}}},\"wechat\":{\"title\":\"\\u5fae\\u4fe1\\u626b\\u4e00\\u626b\\uff0c\\u5173\\u6ce8\\u6211\\u4eec\",\"display\":0,\"vars\":{\"image\":{\"title\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\",\"value\":\"\",\"type\":\"image\",\"tip\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\\u63cf\\u8ff0\",\"value\":\"\\u6253\\u5f00\\u5fae\\u4fe1\\uff0c\\u4f7f\\u7528\\u626b\\u4e00\\u626b\\u5373\\u53ef\\u5173\\u6ce8\\u6211\\u4eec\\u3002\",\"type\":\"text\",\"tip\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\\u63cf\\u8ff0\",\"rule\":{\"require\":true}}}},\"kefu\":{\"title\":\"\\u4fa7\\u8fb9\\u680f\\u5ba2\\u670d\",\"display\":0,\"vars\":{\"features\":{\"title\":\"\\u4fa7\\u8fb9\\u680f\\u5ba2\\u670d\",\"value\":[],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8bbf\\u95eeURL\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"}}}}}','{\"vars\":{\"QQ\":{\"title\":\"QQ\\u8054\\u7cfbURL\",\"value\":\"http:\\/\\/wpa.qq.com\\/msgrd?v=3&uin=1140444693&site=qq&menu=yes\",\"type\":\"text\",\"tip\":\"QQ\\u8054\\u7cfbURL\",\"rule\":{\"require\":true}}},\"widgets\":{\"sns\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u66f4\\u591a\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u8054\\u7cfb\\u6211\\u4eec\\u66f4\\u591a\",\"value\":[],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8bbf\\u95eeURL\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"},\"address\":{\"title\":\"\\u8be6\\u7ec6\\u5730\\u5740\",\"value\":\"\\u6c5f\\u82cf\\u7701\\u5e38\\u5dde\\u5e02\\u6b66\\u8fdb\\u533a\\u79d1\\u6559\\u4f1a\\u5802\",\"type\":\"text\",\"tip\":\"\\u8be6\\u7ec6\\u5730\\u5740\"},\"email\":{\"title\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\\uff1a\",\"value\":\"1140444693@qq.com\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u90ae\\u7bb1\"},\"tel\":{\"title\":\"\\u8054\\u7cfb\\u7535\\u8bdd\",\"value\":\"+86 151 6117 8722\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u7535\\u8bdd\"},\"contacts\":{\"title\":\"\\u8054\\u7cfb\\u4eba\",\"value\":\"\\u6234\\u7ecf\\u7406\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u4eba\"},\"company\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"value\":\"\\u5e38\\u5dde\\u8c6a\\u9a8f\\u7f51\\u7edc\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\",\"type\":\"text\",\"tip\":\"\\u516c\\u53f8\\u540d\\u79f0\"},\"icp\":{\"title\":\"icp\\u5907\\u6848\\u53f7\",\"value\":\"\\u82cfICP\\u590716008291\\u53f7\",\"type\":\"text\",\"tip\":\"\\u8054\\u7cfb\\u4eba\"}}},\"wechat\":{\"title\":\"\\u5fae\\u4fe1\\u626b\\u4e00\\u626b\\uff0c\\u5173\\u6ce8\\u6211\\u4eec\",\"display\":\"1\",\"vars\":{\"image\":{\"title\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\",\"value\":\"\",\"type\":\"image\",\"tip\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\",\"rule\":{\"require\":true}},\"content\":{\"title\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\\u63cf\\u8ff0\",\"value\":\"\\u6253\\u5f00\\u5fae\\u4fe1\\uff0c\\u4f7f\\u7528\\u626b\\u4e00\\u626b\\u5373\\u53ef\\u5173\\u6ce8\\u6211\\u4eec\\u3002\",\"type\":\"text\",\"tip\":\"\\u5fae\\u4fe1\\u4e8c\\u7ef4\\u7801\\u63cf\\u8ff0\",\"rule\":{\"require\":true}}}},\"kefu\":{\"title\":\"\\u4fa7\\u8fb9\\u680f\\u5ba2\\u670d\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u4fa7\\u8fb9\\u680f\\u5ba2\\u670d\",\"value\":[],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8bbf\\u95eeURL\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"image\"}},\"tip\":\"\"}}}}}',NULL),(10,1,1,'HjDesign001','导航栏','public/Nav','public/nav','导航栏模板文件','{\"vars\":{\"logo\":{\"title\":\"\\u7f51\\u7ad9LOGO\",\"value\":\"default\\/20210507\\/6520b5a8baed66f0805aab72e40708c6.png\",\"type\":\"image\",\"tip\":\"\\u7f51\\u7ad9LOGO\",\"rule\":{\"require\":true}}},\"widgets\":{\"nav\":{\"title\":\"\\u5bfc\\u822a\\u680f\\u7ec4\\u4ef6\",\"display\":1,\"vars\":{\"features\":{\"title\":\"\\u6dfb\\u52a0\\u5bfc\\u822a\\u680f\",\"value\":[],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u82f1\\u6587\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8bbf\\u95eeURL\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}}}}','{\"vars\":{\"logo\":{\"title\":\"\\u7f51\\u7ad9LOGO\",\"value\":\"\",\"type\":\"image\",\"tip\":\"\\u7f51\\u7ad9LOGO\",\"rule\":{\"require\":true}}},\"widgets\":{\"nav\":{\"title\":\"\\u5bfc\\u822a\\u680f\\u7ec4\\u4ef6\",\"display\":\"1\",\"vars\":{\"features\":{\"title\":\"\\u6dfb\\u52a0\\u5bfc\\u822a\\u680f\",\"value\":[],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"etitle\":{\"title\":\"\\u82f1\\u6587\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"link\":{\"title\":\"\\u8bbf\\u95eeURL\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}}},\"tip\":\"\"}}}}}',NULL);
/*!40000 ALTER TABLE `cmf_theme_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_third_party_user`
--

DROP TABLE IF EXISTS `cmf_third_party_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_third_party_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方唯一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='第三方用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_party_user`
--

LOCK TABLES `cmf_third_party_user` WRITE;
/*!40000 ALTER TABLE `cmf_third_party_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_third_party_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user`
--

DROP TABLE IF EXISTS `cmf_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `user_login` (`user_login`),
  KEY `user_nickname` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
INSERT INTO `cmf_user` VALUES (1,1,0,0,1620396397,0,0,0.00,1620358458,1,'admin','###7c1f4c4c5ba7d56065526c1147fa2372','admin','1140444693@qq.com','','','','115.174.178.3','','',NULL);
/*!40000 ALTER TABLE `cmf_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_action`
--

DROP TABLE IF EXISTS `cmf_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户操作表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_action`
--

LOCK TABLES `cmf_user_action` WRITE;
/*!40000 ALTER TABLE `cmf_user_action` DISABLE KEYS */;
INSERT INTO `cmf_user_action` VALUES (1,1,1,1,2,1,'用户登录','login','user',''),(2,1,0,1,1,1,'用户行为演示','demo_test','demo','{\"action\":\"demo\\/Test\\/test\",\"param\":{\"id\":1}}');
/*!40000 ALTER TABLE `cmf_user_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_action_log`
--

DROP TABLE IF EXISTS `cmf_user_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user_id`,`object`,`action`),
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='访问记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_action_log`
--

LOCK TABLES `cmf_user_action_log` WRITE;
/*!40000 ALTER TABLE `cmf_user_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_balance_log`
--

DROP TABLE IF EXISTS `cmf_user_balance_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_balance_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `change` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改余额',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改后余额',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户余额变更日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_balance_log`
--

LOCK TABLES `cmf_user_balance_log` WRITE;
/*!40000 ALTER TABLE `cmf_user_balance_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_balance_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_favorite`
--

DROP TABLE IF EXISTS `cmf_user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_favorite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，JSON格式',
  `description` text COMMENT '收藏内容的描述',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) unsigned DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_favorite`
--

LOCK TABLES `cmf_user_favorite` WRITE;
/*!40000 ALTER TABLE `cmf_user_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_like`
--

DROP TABLE IF EXISTS `cmf_user_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_like` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '内容原来的主键id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '内容以前所在表,不带前缀',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容的原文地址，不带域名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `description` text COMMENT '内容的描述',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户点赞表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_like`
--

LOCK TABLES `cmf_user_like` WRITE;
/*!40000 ALTER TABLE `cmf_user_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_login_attempt`
--

DROP TABLE IF EXISTS `cmf_user_login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_login_attempt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_login_attempt`
--

LOCK TABLES `cmf_user_login_attempt` WRITE;
/*!40000 ALTER TABLE `cmf_user_login_attempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_login_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_score_log`
--

DROP TABLE IF EXISTS `cmf_user_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户操作积分等奖励日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_score_log`
--

LOCK TABLES `cmf_user_score_log` WRITE;
/*!40000 ALTER TABLE `cmf_user_score_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_score_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_token`
--

DROP TABLE IF EXISTS `cmf_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_user_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户客户端登录 token 表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_token`
--

LOCK TABLES `cmf_user_token` WRITE;
/*!40000 ALTER TABLE `cmf_user_token` DISABLE KEYS */;
INSERT INTO `cmf_user_token` VALUES (1,1,1635910578,1620358578,'ae6e5bebf75c1258032e7d8625e76aa6436d12ca708dd9d28314b6e94aa8a753','web');
/*!40000 ALTER TABLE `cmf_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_verification_code`
--

DROP TABLE IF EXISTS `cmf_verification_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cmf_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='手机邮箱数字验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_verification_code`
--

LOCK TABLES `cmf_verification_code` WRITE;
/*!40000 ALTER TABLE `cmf_verification_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_verification_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'msd_web'
--

--
-- Dumping routines for database 'msd_web'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-07 15:03:15
