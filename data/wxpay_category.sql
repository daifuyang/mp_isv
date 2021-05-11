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

 Date: 27/04/2021 14:33:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for {prefix}wxpay_category
-- ----------------------------
CREATE TABLE IF NOT EXISTS  `{prefix}wxpay_category` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(48) NOT NULL COMMENT '类目名称',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '(0=>全部,1=>个体,2=>企业 )',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of {prefix}wxpay_category
-- ----------------------------
INSERT INTO `{prefix}wxpay_category` VALUES (1, '餐饮', 0);
INSERT INTO `{prefix}wxpay_category` VALUES (2, '食品生鲜	', 0);
INSERT INTO `{prefix}wxpay_category` VALUES (3, '零售批发/生活娱乐/其他', 1);
INSERT INTO `{prefix}wxpay_category` VALUES (4, '零售批发/生活娱乐/网上商城/其他', 2);

SET FOREIGN_KEY_CHECKS = 1;
