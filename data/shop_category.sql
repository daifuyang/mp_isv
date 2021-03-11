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

 Date: 20/12/2020 14:39:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for {prefix}shop_category
-- ----------------------------
DROP TABLE IF EXISTS `{prefix}shop_category`;
CREATE TABLE `{prefix}shop_category`
(
    `category_id`   varchar(20) NOT NULL,
    `category_name` varchar(20) NOT NULL COMMENT '类目名称',
    `category_type` tinyint(3)  NOT NULL COMMENT '类目类型',
    `parent_id`     varchar(20) NOT NULL DEFAULT '0' COMMENT '类目上级父类id',
    `top_id`        varchar(20) NOT NULL DEFAULT '0' COMMENT '类目顶级父类id',
    PRIMARY KEY (`category_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ----------------------------
-- Records of {prefix}shop_category
-- ----------------------------
BEGIN;
INSERT INTO `{prefix}shop_category`
VALUES ('1001', '便利店', 2, 'P0101', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1002', '超市', 2, 'P0102', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1003', '个人护理', 2, 'P0103', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1004', '母婴零售', 2, 'P0104', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1005', '烟草专卖', 2, 'P0105', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1006', '烟酒杂货', 2, 'P0106', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1007', '自动售卖机', 2, 'P0107', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1008', '综合', 2, 'P0108', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1009', '大卖场', 2, 'P0109', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1010', '其他', 2, 'P0110', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('1701', '蛋糕', 2, 'P0801', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1702', '面包', 2, 'P0801', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1703', '其它烘焙糕点', 2, 'P0801', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1704', '川味/重庆火锅', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1705', '豆捞', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1706', '港式火锅', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1707', '韩式火锅', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1708', '老北京涮羊肉', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1709', '麻辣烫', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1710', '其它火锅', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1711', '炭火锅', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1712', '羊蝎子', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1713', '鱼火锅', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1714', '云南火锅', 2, 'P0802', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1715', '快餐', 2, 'P0803', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1716', '茶餐厅', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1717', '创意菜', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1718', '东南亚菜', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1719', '农家乐', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1720', '其他餐饮美食', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1721', '清真菜', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1722', '日韩料理', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1723', '素食', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1724', '土菜/农家菜', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1725', '西餐', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1726', '自助餐', 2, 'P0804', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1727', '韩式烧烤', 2, 'P0805', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1728', '拉美烧烤', 2, 'P0805', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1729', '其它烧烤', 2, 'P0805', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1730', '日式烧烤', 2, 'P0805', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1731', '铁板烧', 2, 'P0805', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1732', '中式烧烤', 2, 'P0805', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1733', '粮油米面店', 2, 'P0806', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1734', '肉食店', 2, 'P0806', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1735', '蔬菜店', 2, 'P0806', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1736', '水产店', 2, 'P0806', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1737', '水果店', 2, 'P0806', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1738', '调味杂货', 2, 'P0806', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1739', '其它', 2, 'P0807', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1740', '砂锅', 2, 'P0807', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1741', '汤', 2, 'P0807', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1742', '粥', 2, 'P0807', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1743', '企业团餐', 2, 'P0808', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1744', '校园团餐', 2, 'P0808', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1745', '医院团餐', 2, 'P0808', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1746', '园区团餐', 2, 'P0808', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1747', '政府机关团餐', 2, 'P0808', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1748', '美食广场', 2, 'P0808', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1749', '其他', 2, 'P0808', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1750', '米粉米线', 2, 'P0809', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1751', '面点', 2, 'P0809', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1752', '其它小吃', 2, 'P0809', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1753', '熟食', 2, 'P0809', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1754', '酒吧', 2, 'P0810', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1755', '咖啡厅', 2, 'P0810', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1756', '冷饮', 2, 'P0810', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1757', '奶茶', 2, 'P0810', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1758', '饮品', 2, 'P0810', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1759', '零食', 2, 'P0811', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1760', '其它休闲食品', 2, 'P0811', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1761', '特产', 2, 'P0811', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1762', '川菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1763', '东北菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1764', '贵州菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1765', '海南菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1766', '海鲜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1767', '湖北菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1768', '淮扬菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1769', '徽菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1770', '江浙菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1771', '晋菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1772', '鲁菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1773', '闽菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1774', '其它地方菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1775', '上海本帮菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1776', '台湾菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1777', '西北菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1778', '香锅/烤鱼', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1779', '湘菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1780', '新疆菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1781', '豫菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1782', '粤菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1783', '云南菜', 2, 'P0812', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1784', '煲类', 2, 'P0807', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('1785', '炖菜', 2, 'P0807', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0101', '便利店', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0102', '超市', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0103', '个人护理', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0104', '母婴零售', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0105', '烟草专卖', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0106', '烟酒杂货', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0107', '自动售卖机', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0108', '综合', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0109', '大卖场', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0110', '其他', 1, 'S01', 'S01');
INSERT INTO `{prefix}shop_category`
VALUES ('P0801', '烘焙糕点', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0802', '火锅', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0803', '快餐', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0804', '其他美食', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0805', '烧烤', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0806', '生鲜疏果', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0807', '汤/粥/煲/砂锅/炖菜', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0808', '团餐', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0809', '小吃', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0810', '休闲茶饮', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0811', '休闲食品', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('P0812', '中餐', 1, 'S08', 'S08');
INSERT INTO `{prefix}shop_category`
VALUES ('S01', '超市便利店', 0, '0', '0');
INSERT INTO `{prefix}shop_category`
VALUES ('S08', '美食', 0, '0', '0');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
