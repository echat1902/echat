/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50643
 Source Host           : localhost:3306
 Source Schema         : chat

 Target Server Type    : MySQL
 Target Server Version : 50643
 File Encoding         : 65001

 Date: 06/05/2019 16:35:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for error_log
-- ----------------------------
DROP TABLE IF EXISTS `error_log`;
CREATE TABLE `error_log`  (
  `err_log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `err_des` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '错误描述',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '发生时间',
  PRIMARY KEY (`err_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for group_chat_records
-- ----------------------------
DROP TABLE IF EXISTS `group_chat_records`;
CREATE TABLE `group_chat_records`  (
  `record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `send_user_id` int(11) NULL DEFAULT NULL COMMENT '发送者id',
  `group_id` int(11) NULL DEFAULT 0 COMMENT '群号码，0表示私聊',
  `recv_user_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接受者id,可能是@的谁,一个或多个',
  `content` blob NULL COMMENT '聊天内容,二进制格式存储',
  `content_type` tinyint(4) NULL DEFAULT NULL COMMENT '内容类型 1普通类型 2文件类型',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for group_files
-- ----------------------------
DROP TABLE IF EXISTS `group_files`;
CREATE TABLE `group_files`  (
  `file_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '群id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '上传者id',
  `file_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `file_path` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件目录（不含文件名）',
  `file_type` tinyint(4) NULL DEFAULT NULL COMMENT '文件类型',
  `file_size` int(11) NULL DEFAULT NULL COMMENT '文件大小',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for group_user
-- ----------------------------
DROP TABLE IF EXISTS `group_user`;
CREATE TABLE `group_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '群id',
  `user_nick_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_pic` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像地址',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for relation
-- ----------------------------
DROP TABLE IF EXISTS `relation`;
CREATE TABLE `relation`  (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pri_id` int(11) NULL DEFAULT NULL COMMENT '主用户id',
  `sub_id` int(11) NULL DEFAULT NULL COMMENT '副用户id',
  `relation_type` tinyint(4) NULL DEFAULT 1 COMMENT '关系 1好友 2拉黑 3陌生人',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '建立时间',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id号',
  `user_no` int(11) NULL DEFAULT NULL COMMENT '用户易号',
  `user_type` tinyint(4) NULL DEFAULT 1 COMMENT '用户类型 1普通用户 2管理员',
  `user_nick_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_pwd` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `user_tel` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户手机号',
  `user_email` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户email',
  `user_head_pic` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像文件目录',
  `pic_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像文件名',
  `login_ip` int(11) NULL DEFAULT NULL COMMENT '登录ip',
  `login_status` tinyint(4) NULL DEFAULT NULL COMMENT '登录状态',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 10001, 1, '唐刚', 'e10adc3949ba59abbe56e057f20f883e', '1243', NULL, NULL, NULL, NULL, NULL, 1557131587);
INSERT INTO `user` VALUES (2, 10002, 1, '孙竹鸿', 'e10adc3949ba59abbe56e057f20f883e', '12434', NULL, NULL, NULL, NULL, NULL, 1557131587);
INSERT INTO `user` VALUES (3, 10003, 1, '张寿光', 'e10adc3949ba59abbe56e057f20f883e', '12434', NULL, NULL, NULL, NULL, NULL, 1557131587);
INSERT INTO `user` VALUES (4, 10004, 1, '何海兵', 'e10adc3949ba59abbe56e057f20f883e', '12434', NULL, NULL, NULL, NULL, NULL, 1557131587);
INSERT INTO `user` VALUES (5, 10005, 1, '王相新', 'e10adc3949ba59abbe56e057f20f883e', '12434', NULL, NULL, NULL, NULL, NULL, 1557131587);

-- ----------------------------
-- Table structure for user_log
-- ----------------------------
DROP TABLE IF EXISTS `user_log`;
CREATE TABLE `user_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `des` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户行为描述 注册 登录 聊天 上传头像 修改头像  退出登录 发送文件 接收文件 ...',
  `log_type` tinyint(4) NULL DEFAULT NULL COMMENT '日志类型 1错误日志 2其他',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for yl_group
-- ----------------------------
DROP TABLE IF EXISTS `yl_group`;
CREATE TABLE `yl_group`  (
  `group_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '群id',
  `group_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '群名称',
  `group_master_id` int(11) NULL DEFAULT NULL COMMENT '群主id',
  `num` int(11) NULL DEFAULT 1 COMMENT '群成员个数',
  `notice` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '群公告',
  `add_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
