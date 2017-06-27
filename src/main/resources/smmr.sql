/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : smmr

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-06-27 20:07:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_resource`;
CREATE TABLE `t_resource` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PARENT_ID` bigint(20) DEFAULT NULL,
  `TYPE` char(1) DEFAULT NULL COMMENT '1：菜单\r\n   2：操作',
  `RESOURCE_NAME` varchar(128) DEFAULT NULL,
  `RESOURCE_URL` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=655 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_resource
-- ----------------------------
INSERT INTO `t_resource` VALUES ('1', null, '1', '用户管理', '');
INSERT INTO `t_resource` VALUES ('2', '1', '1', '用户列表', '/smmr/user/list');
INSERT INTO `t_resource` VALUES ('3', '1', '1', '添加用户', '/smmr/user/add');
INSERT INTO `t_resource` VALUES ('4', null, '1', '资源管理', null);
INSERT INTO `t_resource` VALUES ('5', '4', '1', '资源列表', '/smmr/resource/list');
INSERT INTO `t_resource` VALUES ('6', '4', '1', '添加资源', '/smmr/resource/add');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `I_ROLE_NAME` (`ROLE_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('2', '普通用户');
INSERT INTO `t_role` VALUES ('1', '管理员');

-- ----------------------------
-- Table structure for t_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_role_resource`;
CREATE TABLE `t_role_resource` (
  `ROLE_ID` bigint(20) DEFAULT NULL,
  `RESOUCE_ID` bigint(20) DEFAULT NULL,
  KEY `I_ROLE_ID` (`ROLE_ID`) USING HASH,
  KEY `I_RESOURCE_ID` (`RESOUCE_ID`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_resource
-- ----------------------------
INSERT INTO `t_role_resource` VALUES ('2', '1');
INSERT INTO `t_role_resource` VALUES ('2', '2');
INSERT INTO `t_role_resource` VALUES ('1', '1');
INSERT INTO `t_role_resource` VALUES ('1', '2');
INSERT INTO `t_role_resource` VALUES ('1', '3');
INSERT INTO `t_role_resource` VALUES ('1', '4');
INSERT INTO `t_role_resource` VALUES ('1', '5');
INSERT INTO `t_role_resource` VALUES ('1', '6');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_NO` varchar(20) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `ROLE_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `I_USER_NO` (`USER_NO`) USING BTREE,
  KEY `F_ROLE_ID` (`ROLE_ID`),
  CONSTRAINT `F_ROLE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `t_role` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('135', 'admin', 'd82494f05d6917ba02f7aaa29689ccb444bb73f20380876cb05d1f37537b7892', '1');
INSERT INTO `t_user` VALUES ('140', 'kewh', '84468101c11cc6160edaa813e8068cba404c61676f0082eff465fbf55292cb0c', '2');