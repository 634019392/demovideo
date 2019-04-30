/*
Navicat MySQL Data Transfer

Source Server         : phpstudy
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : video

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-04-30 15:11:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `truename` varchar(20) NOT NULL COMMENT '真实姓名',
  `gid` int(10) NOT NULL COMMENT '角色id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态：0正常，1禁用',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES ('1', 'admin', 'a66abb5684c45962d887564f08346e8d', '系统管理员', '1', '0', '1855424214');
INSERT INTO `admins` VALUES ('2', 'test', '123', '124', '1', '1', '0');
INSERT INTO `admins` VALUES ('3', '151', '208c8dc913df75f645bd991f6bebde1a', '125', '1', '1', '0');
INSERT INTO `admins` VALUES ('6', '一叶O_O', '0703d62cfb46ac43138bb1555fce8c20', '测试ll4', '2', '0', '0');
INSERT INTO `admins` VALUES ('7', '18872774595', 'ab41cc98a19dcd1de548ea4b939d821f', '125', '1', '1', '1539507239');

-- ----------------------------
-- Table structure for admin_groups
-- ----------------------------
DROP TABLE IF EXISTS `admin_groups`;
CREATE TABLE `admin_groups` (
  `gid` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `title` varchar(20) NOT NULL COMMENT '角色名称',
  `rights` text NOT NULL COMMENT '角色权限，json',
  PRIMARY KEY (`gid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_groups
-- ----------------------------
INSERT INTO `admin_groups` VALUES ('1', '系统管理', '[1,4,12,13,5,6,2,14,15,3,16,17,7,8,18,19,20,21,22,23,24,25,26,27,28,29,30,31]');

-- ----------------------------
-- Table structure for admin_menus
-- ----------------------------
DROP TABLE IF EXISTS `admin_menus`;
CREATE TABLE `admin_menus` (
  `mid` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `ord` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `title` varchar(20) NOT NULL COMMENT '菜单名称',
  `controller` varchar(30) NOT NULL COMMENT '控制器名称',
  `method` varchar(30) NOT NULL COMMENT '菜单名称',
  `ishidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否隐藏：0正常显示，1隐藏',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态：0正常，1禁用',
  PRIMARY KEY (`mid`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_menus
-- ----------------------------
INSERT INTO `admin_menus` VALUES ('1', '0', '0', '管理员管理', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('2', '0', '0', '权限管理', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('3', '0', '0', '系统设置', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('4', '1', '0', '管理员列表', 'Admin', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('5', '1', '0', '管理员添加', 'Admin', 'add', '1', '0');
INSERT INTO `admin_menus` VALUES ('6', '1', '0', '管理员保存', 'Admin', 'save', '1', '0');
INSERT INTO `admin_menus` VALUES ('7', '0', '0', '标签管理', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('8', '7', '0', '频道标签', 'Labels', 'channel', '0', '0');
INSERT INTO `admin_menus` VALUES ('12', '4', '0', '管理测试', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('13', '12', '0', '测试中测试', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('14', '2', '0', '菜单管理', 'Menu', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('15', '2', '0', '角色管理', 'Roles', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('16', '3', '0', '网站设置', 'Site', 'Index', '0', '0');
INSERT INTO `admin_menus` VALUES ('17', '3', '0', '网站保存设置', 'Site', 'Save', '1', '0');
INSERT INTO `admin_menus` VALUES ('18', '7', '0', '资费标签', 'Labels', 'charge', '0', '0');
INSERT INTO `admin_menus` VALUES ('19', '7', '0', '地区标签', 'Labels', 'area', '0', '0');
INSERT INTO `admin_menus` VALUES ('20', '0', '0', '影片管理', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('21', '20', '0', '影片列表', 'Video', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('22', '20', '0', '添加影片', 'Video', 'add', '1', '0');
INSERT INTO `admin_menus` VALUES ('23', '20', '0', '保存影片', 'Video', 'save', '1', '0');
INSERT INTO `admin_menus` VALUES ('24', '20', '0', '图片上传', 'Video', 'upload_img', '1', '0');
INSERT INTO `admin_menus` VALUES ('25', '0', '0', '幻灯片管理', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('26', '25', '0', '首页首屏', 'Slide', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('27', '25', '0', '幻灯片保存', 'Slide', 'save', '1', '0');
INSERT INTO `admin_menus` VALUES ('28', '25', '0', '今日焦点轮播', 'Slide', 'index_today_focus', '0', '0');
INSERT INTO `admin_menus` VALUES ('29', '25', '0', '今日焦点轮播保存', 'Slide', 'save_today_focus', '1', '0');
INSERT INTO `admin_menus` VALUES ('30', '25', '0', '综艺轮播', 'Slide', 'index_variety', '0', '0');
INSERT INTO `admin_menus` VALUES ('31', '25', '0', '综艺轮播保存', 'Slide', 'save_variety', '1', '0');

-- ----------------------------
-- Table structure for note
-- ----------------------------
DROP TABLE IF EXISTS `note`;
CREATE TABLE `note` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `note_name` text NOT NULL COMMENT '备注名称',
  `note_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '备注时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of note
-- ----------------------------
INSERT INTO `note` VALUES ('1', '第8章 电影列表 第1节开始', '2019-01-21 16:35:36');
INSERT INTO `note` VALUES ('2', '第8章 电影列表 第4节开始(图片上传)', '2019-01-21 16:35:52');
INSERT INTO `note` VALUES ('3', '第8章 电影列表 第5节开始(影片保存、编辑)', '2019-01-24 17:29:51');
INSERT INTO `note` VALUES ('4', '第8章 电影列表 第6节开始(影片分页)', '2019-01-25 17:50:23');
INSERT INTO `note` VALUES ('5', '第8章 电影列表 第7节开始(搜索)', '2019-01-25 21:29:56');
INSERT INTO `note` VALUES ('6', '第9章 幻灯片管理 第1节开始(建立幻灯图数据表及幻灯图列表)', '2019-01-26 16:58:39');
INSERT INTO `note` VALUES ('7', '第10章 网站前台 第1节开始(渲染首页幻灯片)', '2019-02-02 17:02:26');
INSERT INTO `note` VALUES ('8', '第10章 网站前台 第2节开始(渲染首页导航标签)', '2019-02-11 17:52:16');
INSERT INTO `note` VALUES ('9', '第10章 网站前台 第4节开始(影片列表)', '2019-02-17 22:19:31');
INSERT INTO `note` VALUES ('10', '第10章 网站前台 第6节开始(分页具体实现)', '2019-02-19 11:17:09');
INSERT INTO `note` VALUES ('11', '第11章 视频播放 第1节开始(视频播放页面抓取)', '2019-02-20 17:21:26');
INSERT INTO `note` VALUES ('12', '完结撒花，自行优化项目', '2019-02-21 21:21:23');

-- ----------------------------
-- Table structure for sites
-- ----------------------------
DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `names` varchar(50) NOT NULL,
  `values` text NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sites
-- ----------------------------
INSERT INTO `sites` VALUES ('site', '\"\\u54ce\\u89c6\\u9891\"', '0');

-- ----------------------------
-- Table structure for slide
-- ----------------------------
DROP TABLE IF EXISTS `slide`;
CREATE TABLE `slide` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '类型：0首页首屏，1今日焦点，2综艺（此地方为轮播）',
  `ord` tinyint(2) NOT NULL,
  `title` varchar(30) NOT NULL COMMENT '标题',
  `url` varchar(255) NOT NULL COMMENT '链接地址',
  `img` varchar(255) NOT NULL COMMENT '图片地址',
  `descript` varchar(255) NOT NULL COMMENT '介绍',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of slide
-- ----------------------------
INSERT INTO `slide` VALUES ('1', '0', '0', '演员的品格:张开泰获周冬雨大赞', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\5910734f1d67a9bcc6c249cfc6ec3221.jpg', '');
INSERT INTO `slide` VALUES ('2', '0', '0', '知否：顾廷烨提出与明兰和离', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\c121dead53290eb9b6751255d5e5443e.jpg', '');
INSERT INTO `slide` VALUES ('3', '0', '0', '青春有你：邓超元公演第一', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\f598a468a263e828886330e69dcf067c.jpg', '');
INSERT INTO `slide` VALUES ('4', '0', '0', '招摇：白鹿许凯肖燕仙侠蜜恋', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\b1fca0329b235db6ca3fc14fd1a365bb.jpg', '');
INSERT INTO `slide` VALUES ('5', '0', '0', '声临其境第2季:倪萍化身容嬷嬷', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\6e8d979243b12f7deefa4fc9c129798d.jpg', '');
INSERT INTO `slide` VALUES ('6', '0', '0', '龙猫：宫崎骏大师经典作品重映', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\6301b9817b543abe5c4bf01b985c0573.jpg', '');
INSERT INTO `slide` VALUES ('7', '0', '0', '独孤皇后：今晚20点全网首播', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\0ec8f057de5150a6f838b4bd0ce20fc8.jpg', '');
INSERT INTO `slide` VALUES ('8', '0', '0', '空中勇士：地表最强战机揭秘', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\36453c821727978850cd00c62ab7f9f6.jpg', '');
INSERT INTO `slide` VALUES ('9', '0', '0', '王牌4：王源华晨宇致敬四大名著', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\d62b33abd3d8252790bce6e14c064bbc.jpg', '');
INSERT INTO `slide` VALUES ('10', '0', '0', '鹿晗的欧洲冒险之旅：全集上线', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190211\\55c32a97b3d15ee462a213a819ae6897.jpg', '');
INSERT INTO `slide` VALUES ('13', '1', '0', '独家专访《声临其境》刘敏涛', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190217\\7b3f02ed5028c9e03515b1f69466b3ed.jpg', '今日');
INSERT INTO `slide` VALUES ('14', '1', '0', '时尚巅峰', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190217\\434c1d9e849b43d84d05aa579b1c7f21.jpg', '焦点');
INSERT INTO `slide` VALUES ('15', '1', '0', '第69届柏林电影节闭幕', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190217\\53a260d225a9a2dc56060d79a4fc70ed.jpg', '1');
INSERT INTO `slide` VALUES ('16', '1', '0', '电影：一吻定情', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190217\\8654966cfb8f6618ec944f35516b27d4.jpg', '2');
INSERT INTO `slide` VALUES ('17', '2', '1', '综艺轮播：第一1', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190217\\8654966cfb8f6618ec944f35516b27d4.jpg', '这是综艺轮播的介绍');
INSERT INTO `slide` VALUES ('18', '2', '0', '综艺轮播：two', 'http://www.php.demo/index.php/index/index/video?id=1', '/uploads/20190217\\434c1d9e849b43d84d05aa579b1c7f21.jpg', '综合轮播介绍22222');

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) NOT NULL COMMENT '频道（看video_label表的id）',
  `charge_id` int(10) NOT NULL COMMENT '资费（看video_label表的id）',
  `area_id` int(10) NOT NULL COMMENT '地区（看video_label表的id）',
  `title` varchar(50) NOT NULL COMMENT '影片名称',
  `keywords` varchar(255) NOT NULL COMMENT '关键字',
  `desc` varchar(255) NOT NULL COMMENT '描述',
  `img` varchar(255) NOT NULL COMMENT '封面图url',
  `url` varchar(255) NOT NULL COMMENT '影片地址url',
  `pv` int(10) NOT NULL DEFAULT '0' COMMENT '播放量',
  `score` int(3) NOT NULL DEFAULT '0' COMMENT '影片评分',
  `is_vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否vip才能看：0否，1是',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态：0下线，1正常',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  `descript` varchar(255) NOT NULL DEFAULT '' COMMENT '影片简介',
  `mark` int(10) NOT NULL DEFAULT '0' COMMENT '标志（0：无，1：自制，1：独播）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES ('1', '1', '11', '13', '初中生购写字机器人写作业', '222', '333', '/uploads/20190217\\76c7f13a3c2ea5294dd3bddbf1d7cf1a.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '181', '0', '0', '1', '1548406119', '', '0');
INSERT INTO `video` VALUES ('2', '2', '11', '13', '加拿大举办\"冻发大赛\"', '22', '33', '/uploads/20190217\\1f4671590d119f8aa5433e67cd053df5.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548406608', '', '0');
INSERT INTO `video` VALUES ('3', '21', '11', '13', '戏剧公演！董钒忘词崩溃', 'hyxhn', '狐妖', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '1', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('5', '2', '11', '13', '章子怡汪峰被醒宝萌化', '124', '124', '/uploads/20190217\\1e1408f1ba641ffee0086ce066ef814c.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550388844', '', '0');
INSERT INTO `video` VALUES ('6', '2', '11', '13', '青春有你：嘉羿用脸拔河', '124', '124', '/uploads/20190217\\bc2e1bdbfaf2823e93dba4ee25218eb7.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550388867', '', '0');
INSERT INTO `video` VALUES ('7', '2', '11', '13', '满满韵味的经典粤语歌', '124', '124', '/uploads/20190217\\28717a95bd693c4d84e5fccbdfb1b743.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550388867', '', '0');
INSERT INTO `video` VALUES ('8', '2', '11', '13', '李沁秦海璐搞事现场玩双簧', '124', '124', '/uploads/20190217\\17e48da9c0e36014b7cb8c854b8bf030.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550388867', '', '0');
INSERT INTO `video` VALUES ('9', '2', '11', '13', '2019年网络大过年', '22', '33', '/uploads/20190217\\7af35a5e6d3b099b7b6d5d08f1ee57f2.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550389128', '', '0');
INSERT INTO `video` VALUES ('10', '2', '11', '13', '爱青春剧场：独家记忆', '123', '124', '/uploads/20190217\\8c20dff34228fdb61b2e43e006f78613.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391173', '', '0');
INSERT INTO `video` VALUES ('11', '2', '11', '13', '2019时装周搭配新灵感', '123', '124', '/uploads/20190217\\a94c0ba32a415c0ca4298ffd24e957a1.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391210', '', '0');
INSERT INTO `video` VALUES ('12', '2', '11', '13', '奇悬疑剧场：原生之罪', '125', '125', '/uploads/20190217\\f2a262d4a99c585c82448a04d212d4c9.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391253', '', '0');
INSERT INTO `video` VALUES ('13', '2', '11', '13', '周末来一场说唱狂欢', '125', '125', '/uploads/20190217\\93e19a9023182a1e17999e4034691d90.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391293', '', '0');
INSERT INTO `video` VALUES ('14', '2', '11', '13', '忆英雄剧场：致敬峥嵘岁月', '125', '125', '/uploads/20190217\\8efd60882b8a2ed8bb3b94a681ecb545.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391334', '', '0');
INSERT INTO `video` VALUES ('15', '2', '11', '13', '《流浪地球》就该这么玩', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('16', '2', '11', '13', '16', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('17', '2', '11', '13', '17', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('18', '2', '11', '13', '18', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('19', '2', '11', '13', '19', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('20', '2', '11', '13', '20', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('21', '2', '11', '13', '21', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('22', '2', '11', '13', '22', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('23', '2', '11', '13', '23', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('24', '2', '11', '13', '24', '125', '125', '/uploads/20190217\\67ac1a67f904fd30372dc5b9e09de8b0.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1550391374', '', '0');
INSERT INTO `video` VALUES ('25', '3', '11', '13', '综艺片25', '影片关键字', '影片描述', '/uploads/20190303\\ce60c02055ab75acc503f12259d23681.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1551594995', '', '0');
INSERT INTO `video` VALUES ('26', '3', '11', '13', '综艺片26', '影片关键字26', '影片描述', '/uploads/20190303\\ce60c02055ab75acc503f12259d23681.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '3', '0', '0', '1', '1551594995', '', '0');
INSERT INTO `video` VALUES ('27', '3', '11', '13', '综艺片27', '影片关键字', '影片描述', '/uploads/20190303\\ce60c02055ab75acc503f12259d23681.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1551594995', '', '0');
INSERT INTO `video` VALUES ('28', '3', '11', '13', '综艺片28', '影片关键字26', '影片描述', '/uploads/20190303\\ce60c02055ab75acc503f12259d23681.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1551594995', '', '0');
INSERT INTO `video` VALUES ('29', '3', '11', '13', '综艺片29', '影片关键字', '影片描述', '/uploads/20190303\\ce60c02055ab75acc503f12259d23681.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '1', '0', '0', '1', '1551594995', '', '0');
INSERT INTO `video` VALUES ('30', '3', '11', '13', '综艺片30', '影片关键字26', '影片描述', '/uploads/20190303\\ce60c02055ab75acc503f12259d23681.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1551594995', '', '0');
INSERT INTO `video` VALUES ('31', '21', '11', '13', '电影31', '电影关键字31', '电影31描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('32', '21', '11', '13', '电影32', '电影关键字32', '电影32描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('33', '21', '11', '13', '电影33', '电影关键字33', '电影33描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('34', '21', '11', '13', '电影34', '电影关键字34', '电影34描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('35', '21', '11', '13', '电影35', '电影关键字35', '电影35描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('36', '21', '11', '13', '电影31', '电影关键字31', '电影31描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '1', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('37', '21', '11', '13', '电影32', '电影关键字32', '电影32描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('38', '21', '11', '13', '电影33', '电影关键字33', '电影33描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('39', '21', '11', '13', '电影34', '电影关键字34', '电影34描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('40', '21', '11', '13', '电影35', '电影关键字35', '电影35描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('41', '21', '11', '13', '电影31', '电影关键字31', '电影31描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('42', '21', '11', '13', '电影32', '电影关键字32', '电影32描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('43', '21', '11', '13', '电影33', '电影关键字33', '电影33描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('44', '21', '11', '13', '电影34', '电影关键字34', '电影34描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('45', '21', '11', '13', '电影35', '电影关键字35', '电影35描述', '/uploads/20190217\\31955555ad800f831daee1a06de54779.jpg', 'CK:5saYWL8KFsB0g2od2TvYUOB6jy/vBm4o9Hako0kAPHFwhxGqyzwFig==', '0', '0', '0', '1', '1548409293', '', '0');
INSERT INTO `video` VALUES ('46', '1', '11', '13', 'w20test', '', '', '/uploads/20190430\\9deaec10760a699ac8b09ed8d569457d.jpg', 'http://video.w20.top/zone_uploads/20190430/1556607372.m3u8', '0', '0', '0', '0', '1556607401', '', '0');

-- ----------------------------
-- Table structure for video_label
-- ----------------------------
DROP TABLE IF EXISTS `video_label`;
CREATE TABLE `video_label` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ord` int(3) NOT NULL DEFAULT '0' COMMENT '排序',
  `title` varchar(50) NOT NULL COMMENT '标签标题',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态：0正常，1禁用',
  `flag` varchar(50) NOT NULL COMMENT '标签分类标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video_label
-- ----------------------------
INSERT INTO `video_label` VALUES ('1', '0', '电视剧', '0', 'channel');
INSERT INTO `video_label` VALUES ('2', '0', '今日焦点', '0', 'channel');
INSERT INTO `video_label` VALUES ('3', '0', '综艺', '0', 'channel');
INSERT INTO `video_label` VALUES ('4', '0', '动漫', '0', 'channel');
INSERT INTO `video_label` VALUES ('5', '0', '纪录片', '0', 'channel');
INSERT INTO `video_label` VALUES ('6', '0', '游戏', '0', 'channel');
INSERT INTO `video_label` VALUES ('7', '0', '资讯', '0', 'channel');
INSERT INTO `video_label` VALUES ('8', '0', '娱乐', '0', 'channel');
INSERT INTO `video_label` VALUES ('9', '0', '财经', '0', 'channel');
INSERT INTO `video_label` VALUES ('10', '0', '网络电影', '0', 'channel');
INSERT INTO `video_label` VALUES ('11', '0', '免费', '0', 'charge');
INSERT INTO `video_label` VALUES ('12', '0', '付费', '0', 'charge');
INSERT INTO `video_label` VALUES ('13', '0', '华语', '0', 'area');
INSERT INTO `video_label` VALUES ('14', '0', '香港', '0', 'area');
INSERT INTO `video_label` VALUES ('15', '0', '美国', '0', 'area');
INSERT INTO `video_label` VALUES ('16', '0', '欧洲', '0', 'area');
INSERT INTO `video_label` VALUES ('17', '0', '韩国', '0', 'area');
INSERT INTO `video_label` VALUES ('18', '0', '日本', '0', 'area');
INSERT INTO `video_label` VALUES ('19', '0', '泰国', '0', 'area');
INSERT INTO `video_label` VALUES ('20', '0', '其他', '0', 'area');
INSERT INTO `video_label` VALUES ('21', '0', '电影', '0', 'channel');

-- ----------------------------
-- Table structure for zone_uploads
-- ----------------------------
DROP TABLE IF EXISTS `zone_uploads`;
CREATE TABLE `zone_uploads` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '上传文件名称',
  `path` varchar(255) NOT NULL DEFAULT '0' COMMENT '上传路径',
  `sha1` varchar(255) NOT NULL DEFAULT '0' COMMENT '合并后文件路径的hash名称',
  `guid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'webuploader中的guid',
  `md5` varchar(255) NOT NULL DEFAULT '0' COMMENT '分片临时文件夹名称（webupadler是以md5来命名）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zone_uploads
-- ----------------------------
INSERT INTO `zone_uploads` VALUES ('3', '1556607368.mp4', 'E:\\phpstudy\\WWW\\video\\public\\zone_uploads\\20190430\\1556607368.mp4', '993ed4583693a4adb51b27c642e7d2c244221843', '', '1447fe953d79f5dd0debfb46af935f95');
SET FOREIGN_KEY_CHECKS=1;
