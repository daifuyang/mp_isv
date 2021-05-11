/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : localhost:3306
 Source Schema         : mp_isv

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 04/04/2021 10:29:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for {prefix}takeout_category
-- ----------------------------
CREATE TABLE IF NOT EXISTS `{prefix}takeout_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(32) DEFAULT NULL COMMENT '类目名称',
  `category_type` tinyint(3) DEFAULT '0' COMMENT '类目类型',
  `parent_id` int(11) DEFAULT '0' COMMENT '类目上级父类id',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of {prefix}takeout_category
-- ----------------------------
INSERT INTO `{prefix}takeout_category` VALUES (1, '美食夜宵', 0, 0);
INSERT INTO `{prefix}takeout_category` VALUES (2, '甜品饮料', 0, 0);
INSERT INTO `{prefix}takeout_category` VALUES (3, '蛋糕', 0, 0);
INSERT INTO `{prefix}takeout_category` VALUES (4, '日用百货', 0, 0);
INSERT INTO `{prefix}takeout_category` VALUES (5, '果蔬生鲜	', 0, 0);
INSERT INTO `{prefix}takeout_category` VALUES (6, '鲜花', 0, 0);
INSERT INTO `{prefix}takeout_category` VALUES (7, '母婴', 0, 0);
INSERT INTO `{prefix}takeout_category` VALUES (8, '零食小吃', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (9, '香锅/烤鱼', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (10, '西餐', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (11, '日韩料理', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (12, '海鲜/烧烤', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (13, '快餐/地方菜', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (14, '小龙虾', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (15, '披萨', 1, 1);
INSERT INTO `{prefix}takeout_category` VALUES (16, '甜品', 1, 2);
INSERT INTO `{prefix}takeout_category` VALUES (17, '奶茶果汁', 1, 2);
INSERT INTO `{prefix}takeout_category` VALUES (18, '咖啡', 1, 2);
INSERT INTO `{prefix}takeout_category` VALUES (19, '面包/糕点', 1, 2);
INSERT INTO `{prefix}takeout_category` VALUES (20, '冰淇淋', 1, 2);
INSERT INTO `{prefix}takeout_category` VALUES (21, '蛋糕', 1, 3);
INSERT INTO `{prefix}takeout_category` VALUES (22, '便利店', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (23, '水站/奶站', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (24, '零食/干果', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (25, '五金日用', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (26, '粮油调味', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (27, '文具店', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (28, '酒水行', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (29, '地方特产', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (30, '进口食品', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (31, '宠物用品', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (32, '超市', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (33, '书店', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (34, '宠物食品用品', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (35, '办公家居用品', 1, 4);
INSERT INTO `{prefix}takeout_category` VALUES (36, '果蔬', 1, 5);
INSERT INTO `{prefix}takeout_category` VALUES (37, '海鲜水产', 1, 5);
INSERT INTO `{prefix}takeout_category` VALUES (38, '冷冻速食', 1, 5);
INSERT INTO `{prefix}takeout_category` VALUES (39, '鲜花', 1, 6);
INSERT INTO `{prefix}takeout_category` VALUES (40, '孕婴用品', 1, 7);
SET FOREIGN_KEY_CHECKS = 1;
