/*
Navicat MySQL Data Transfer

Source Server         : 10.0.1.227
Source Server Version : 50629
Source Host           : 10.0.1.227:3306
Source Database       : sap3.0

Target Server Type    : MYSQL
Target Server Version : 50629
File Encoding         : 65001

Date: 2016-03-07 13:51:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `hibernate_unique_key`
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_unique_key`;
CREATE TABLE `hibernate_unique_key` (
  `next_hi` bigint(20) DEFAULT '0' COMMENT '最高值',
  `name` varchar(21) CHARACTER SET utf8 DEFAULT NULL COMMENT '名称'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='高低算法最高值数据表';

-- ----------------------------
-- Records of hibernate_unique_key
-- ----------------------------
INSERT INTO `hibernate_unique_key` VALUES ('19345', '序列');

-- ----------------------------
-- Table structure for `sap_business`
-- ----------------------------
DROP TABLE IF EXISTS `sap_business`;
CREATE TABLE `sap_business` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '业务id',
  `name` varchar(256) NOT NULL COMMENT '业务名称',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `organization_id` bigint(20) DEFAULT NULL COMMENT '所属部门',
  `form_id` bigint(20) DEFAULT NULL COMMENT '评分表id',
  `media_type` varchar(64) DEFAULT NULL COMMENT '媒体类型，有效值为audio、text、video',
  `remark` varchar(256) DEFAULT NULL COMMENT '业务描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=628948993 DEFAULT CHARSET=utf8 COMMENT='座席业务表';

-- ----------------------------
-- Table structure for `sap_category`
-- ----------------------------
DROP TABLE IF EXISTS `sap_category`;
CREATE TABLE `sap_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(64) NOT NULL COMMENT '关键词类别名称',
  `color` varchar(20) DEFAULT NULL,
  `remark` varchar(256) DEFAULT NULL COMMENT '关键词类别描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=629997582 DEFAULT CHARSET=utf8 COMMENT='关键词类型表';

-- ----------------------------
-- Table structure for `sap_data_source`
-- ----------------------------
DROP TABLE IF EXISTS `sap_data_source`;
CREATE TABLE `sap_data_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `extension` varchar(32) DEFAULT NULL COMMENT '交换机分机',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=629571585 DEFAULT CHARSET=utf8 COMMENT='授权质检座席表';

-- ----------------------------
-- Table structure for `sap_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `sap_dictionary`;
CREATE TABLE `sap_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(64) NOT NULL COMMENT '编码',
  `TEXT` varchar(256) NOT NULL COMMENT '值',
  `order` tinyint(1) NOT NULL DEFAULT '0' COMMENT '排序',
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,1启用，0停用',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='数据字典';

-- ----------------------------
-- Records of sap_dictionary
-- ----------------------------
INSERT INTO `sap_dictionary` VALUES ('1', 'AUDIO_FORMAT', '-1', '0', '0', '1', '录音文件的音频格式。有效取值如下：\n0=PCM8K16BIT\n1=VOX6K4BIT\n2=VOX8K4BIT\n3=ALAW8K\n4=ULAW8K');
INSERT INTO `sap_dictionary` VALUES ('2', 'AUDIO_EXT', '.wav', '5', '0', '1', '录音文件的扩展名hh');
INSERT INTO `sap_dictionary` VALUES ('3', 'VOICE_FILE_DIR', '/home/hcicloud/cloud/data/asr_trans/trans_dir', '2', '1', '1', '指定录音文件所在目录');
INSERT INTO `sap_dictionary` VALUES ('5', 'ASR_TRANS_SERVER', '10.0.1.216:20006', '4', '1', '1', '指定语音转写服务的IP和端口，格式：ip:port');
INSERT INTO `sap_dictionary` VALUES ('6', 'HOME_STAT_PEROID', '90', '3', '0', '1', '指定统计周期，单位为天。多大');
INSERT INTO `sap_dictionary` VALUES ('7', 'SILENSE_DURATION', '3', '6', '0', '1', '静音判断下限aa');
INSERT INTO `sap_dictionary` VALUES ('8', 'AUDIO_CHANNEL', '0', '7', '1', '1', '语音文件的声道，0是双声道，1是单声道');
INSERT INTO `sap_dictionary` VALUES ('9', 'VOICE_EXTRACTED', '/home/hcicloud/cloud/data/asr_trans/voice_dir', '8', '1', '1', '抽检后录音存放目录');
INSERT INTO `sap_dictionary` VALUES ('10', 'VOICE_SOURCE', '/home/hcicloud/cloud/data/asr_trans/source_dir', '9', '0', '1', '待抽检录音文件存放目录gg');
INSERT INTO `sap_dictionary` VALUES ('11', 'FILE_DELETE', '0', '10', '1', '1', '抽检后是否删除source_dir下文件,1删除，0不删除');

-- ----------------------------
-- Table structure for `sap_form`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form`;
CREATE TABLE `sap_form` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评分表id',
  `name` varchar(128) DEFAULT NULL COMMENT '名称',
  `state` int(11) DEFAULT NULL COMMENT '评分表状态，0建设中，1未发布，2发布，3停用',
  `version` int(11) DEFAULT NULL COMMENT '当前版本号',
  `form_type_id` bigint(11) DEFAULT NULL COMMENT '评分表类型id',
  `calc_method` int(11) DEFAULT NULL COMMENT '得分方法，0段落总和，1段落平均值',
  `min_score` float DEFAULT NULL COMMENT '最低得分',
  `max_score` float DEFAULT NULL COMMENT '最高得分',
  `pass_score` float DEFAULT NULL COMMENT '及格分',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '评分表创建时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建时间者',
  `state_change_time` timestamp NULL DEFAULT NULL COMMENT '预设时间，表示当前状态切换为下一状态的时间点',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最近更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最近更新者',
  `remark` varchar(256) DEFAULT NULL COMMENT '描述信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=631865349 DEFAULT CHARSET=utf8 COMMENT='质检评分表';

-- ----------------------------
-- Table structure for `sap_form_node`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_node`;
CREATE TABLE `sap_form_node` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '节点id',
  `form_id` bigint(20) DEFAULT NULL COMMENT '所属评分表id',
  `parent_node_id` bigint(20) DEFAULT NULL COMMENT '上级节点id，如果是段落节点，此列为NULL',
  `name` varchar(128) DEFAULT NULL COMMENT '节点名称',
  `calc_method` int(11) DEFAULT NULL COMMENT '得分方法，0总和，1平均值',
  `node_type` int(11) DEFAULT NULL COMMENT '节点类型，1段落，2章节，3题目',
  `min_score` float DEFAULT NULL COMMENT '最高得分',
  `max_score` float DEFAULT NULL COMMENT '最低得分',
  `order` int(11) DEFAULT NULL COMMENT '在同类型节点中的排序',
  `remark` varchar(256) DEFAULT NULL COMMENT '描述信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=631898134 DEFAULT CHARSET=utf8 COMMENT='质检评分表节点表';

-- ----------------------------
-- Table structure for `sap_form_node_rule`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_node_rule`;
CREATE TABLE `sap_form_node_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rule_name` varchar(64) DEFAULT NULL COMMENT '规则名称',
  `form_id` bigint(20) DEFAULT NULL COMMENT '所属评分表id',
  `if_node_id` bigint(20) DEFAULT NULL COMMENT 'if节点id',
  `if_operator` int(11) DEFAULT NULL COMMENT 'if操作符，0等于，1小于，2大于，3闭区间',
  `lower_score` float DEFAULT NULL COMMENT '区间下边界，如果if_operator不为闭区间(0,1,2)，此列存放具体值',
  `upper_score` float DEFAULT NULL COMMENT '区间上边界，如果if_operator不为闭区间(0,1,2)，此列为NULL',
  `then_node_id` bigint(11) DEFAULT NULL COMMENT 'then节点id',
  `then_operator` int(11) DEFAULT NULL COMMENT 'then操作符，0设置值，1增加值，2减少值',
  `score` float DEFAULT NULL COMMENT '分数',
  `remark` varchar(256) DEFAULT NULL COMMENT '规则描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='质检评分表节点得分规则表';

-- ----------------------------
-- Table structure for `sap_form_question`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_question`;
CREATE TABLE `sap_form_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_node_id` bigint(20) DEFAULT NULL COMMENT '评分表题目id',
  `title` varchar(256) DEFAULT NULL COMMENT '题目文本信息',
  `full_score` int(11) DEFAULT NULL COMMENT '此题目的满分值',
  `min_score` int(11) DEFAULT NULL COMMENT '此题目的最低分值',
  `auto_add_note` int(11) DEFAULT NULL COMMENT '此题目是否自动添加评语，0不添加，１添加',
  `include_in_calc` int(11) DEFAULT NULL COMMENT '此题目是否参与评分表最终得分计算,1参与，0不参与',
  `standard_type` int(11) DEFAULT NULL COMMENT '此题目的标准类型，0关键词标准，1预定义标准，2导入标准',
  `standard_field_id` bigint(20) DEFAULT NULL COMMENT '使用自定义标准时的映射字段id。如果使用关键词标准时，此列为NULL',
  `remark` varchar(256) DEFAULT NULL COMMENT '此题目的描述信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=631930890 DEFAULT CHARSET=utf8 COMMENT='质检评分表题目节点详表';

-- ----------------------------
-- Table structure for `sap_form_question_custom_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_question_custom_detail`;
CREATE TABLE `sap_form_question_custom_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_question_id` bigint(20) DEFAULT NULL COMMENT '评分表的题目id',
  `lower_bound` varchar(32) DEFAULT NULL COMMENT '范围下边界，闭区间，如果为普通值类型，此列存放值,如果为区间类型，需要判断此值是否为数值类型',
  `upper_bound` varchar(32) DEFAULT NULL COMMENT '范围上边界，闭区间，如果为普通值类型，此列为NULL',
  `score` float DEFAULT NULL COMMENT '分值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=629964813 DEFAULT CHARSET=utf8 COMMENT='题目节点自定义得分标准详表';

-- ----------------------------
-- Table structure for `sap_form_question_keyword_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_question_keyword_detail`;
CREATE TABLE `sap_form_question_keyword_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_question_id` bigint(20) DEFAULT NULL COMMENT '评分表的题目id',
  `keyword_id` bigint(20) DEFAULT NULL COMMENT '关键词id',
  `weight` int(11) DEFAULT NULL COMMENT '权重',
  `min_frequence` int(11) DEFAULT NULL COMMENT '分析频次，大于或等于此频次时，参与计算',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=631963650 DEFAULT CHARSET=utf8 COMMENT='题目节点关键词得分标准详表';

-- ----------------------------
-- Table structure for `sap_form_question_query_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_question_query_detail`;
CREATE TABLE `sap_form_question_query_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `form_question_id` bigint(20) DEFAULT NULL COMMENT '问题ID',
  `query` varchar(512) DEFAULT NULL COMMENT '根据关键词组成的查询',
  `weight` int(11) DEFAULT NULL COMMENT '该项设置影响问题结果计算权重',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `sap_form_question_standard`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_question_standard`;
CREATE TABLE `sap_form_question_standard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL COMMENT '显示在题目选项列表中的字段名',
  `actual_field` varchar(64) DEFAULT NULL COMMENT '录音流水表中，对应的实际字段',
  `is_default` int(11) DEFAULT NULL COMMENT '是否为预定义字段，1预定义字段，0为voice表中的字段',
  `value_type` int(11) DEFAULT NULL COMMENT '对应的实际字段值的类型，0普通值类型，1区间类型，枚举类型也用值类型表示',
  `remark` varchar(256) DEFAULT NULL COMMENT '题目选项列的描述信息',
  `enum_value` varchar(256) DEFAULT NULL COMMENT '枚举类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='题目节点自定义得分标准字段映射表';

-- ----------------------------
-- Records of sap_form_question_standard
-- ----------------------------
INSERT INTO `sap_form_question_standard` VALUES ('1', '静音时长占比大于', 'DEFINE_TOTAL_SILENCE_PERCENT', '1', '4', '预定义录音数据，静音时长占比超过某一阀值', null);
INSERT INTO `sap_form_question_standard` VALUES ('2', '某段静音时长超过(s)', 'DEFINE_SILENCE_SEGMENT', '1', '1', '预定义录音数据，某段静音时长超过某一阀值', null);
INSERT INTO `sap_form_question_standard` VALUES ('4', '总静音时长超过(s)', 'DEFINE_SILENCE_DURATION', '1', '1', '预定义录音数据，总静音时长超过某一阀值', null);
INSERT INTO `sap_form_question_standard` VALUES ('5', '总通话时长超过(s)', 'DEFINE_DURATION', '1', '1', '预定义录音数据，总通话时长超过某一阀值', null);
INSERT INTO `sap_form_question_standard` VALUES ('6', '座席说话语速', 'DEFINE_SPEED', '1', '1', '预定义录音数据，说话语速超过某一阀值', null);
INSERT INTO `sap_form_question_standard` VALUES ('7', '自定义字段0', 'custom0', '0', '0', '自定义字段0', null);
INSERT INTO `sap_form_question_standard` VALUES ('8', '自定义字段1', 'custom1', '0', '0', '自定义字段1', null);
INSERT INTO `sap_form_question_standard` VALUES ('9', '自定义字段2', 'custom2', '0', '0', '自定义字段2', null);
INSERT INTO `sap_form_question_standard` VALUES ('10', '自定义字段3', 'custom3', '0', '0', '自定义字段3', null);
INSERT INTO `sap_form_question_standard` VALUES ('11', '自定义字段4', 'custom4', '0', '0', '自定义字段4', null);
INSERT INTO `sap_form_question_standard` VALUES ('12', '自定义字段5', 'custom5', '0', '0', '自定义字段5', null);
INSERT INTO `sap_form_question_standard` VALUES ('13', '自定义字段6', 'custom6', '0', '0', '自定义字段6', null);
INSERT INTO `sap_form_question_standard` VALUES ('14', '自定义字段7', 'custom7', '0', '0', '自定义字段7', null);
INSERT INTO `sap_form_question_standard` VALUES ('15', '自定义字段8', 'custom8', '0', '0', '自定义字段8', null);
INSERT INTO `sap_form_question_standard` VALUES ('16', '自定义字段9', 'custom9', '0', '0', '自定义字段9', null);
INSERT INTO `sap_form_question_standard` VALUES ('17', '自定义字段10', 'custom10', '0', '0', '自定义字段10', null);
INSERT INTO `sap_form_question_standard` VALUES ('18', '自定义字段11', 'custom11', '0', '0', '自定义字段11', null);
INSERT INTO `sap_form_question_standard` VALUES ('19', '自定义字段12', 'custom12', '0', '0', '自定义字段12', null);
INSERT INTO `sap_form_question_standard` VALUES ('20', '自定义字段13', 'custom13', '0', '0', '自定义字段13', null);
INSERT INTO `sap_form_question_standard` VALUES ('21', '自定义字段14', 'custom14', '0', '0', '自定义字段14', null);
INSERT INTO `sap_form_question_standard` VALUES ('22', '自定义字段15', 'custom15', '0', '0', '自定义字段15', null);
INSERT INTO `sap_form_question_standard` VALUES ('23', '自定义字段16', 'custom16', '0', '0', '自定义字段16', null);
INSERT INTO `sap_form_question_standard` VALUES ('24', '自定义字段17', 'custom17', '0', '0', '自定义字段17', null);
INSERT INTO `sap_form_question_standard` VALUES ('25', '自定义字段18', 'custom18', '0', '0', '自定义字段18', null);
INSERT INTO `sap_form_question_standard` VALUES ('26', '自定义字段19', 'custom19', '0', '0', '自定义字段19', null);
INSERT INTO `sap_form_question_standard` VALUES ('100', '欢迎语检测', 'DEFINE_START_WORD', '2', '2', '检测录音开始的时间的关键词检测', null);
INSERT INTO `sap_form_question_standard` VALUES ('101', '结束语检测', 'DEFINE_END_WORD', '2', '3', '检测录音结束的时间的关键词检测', null);
INSERT INTO `sap_form_question_standard` VALUES ('102', '客户单边静音', 'DEFINE_CUTSTOM_SILIENCE_WORD', '2', '-1', '当客户没有说话时关键词检测', null);

-- ----------------------------
-- Table structure for `sap_form_shortcut_question`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_shortcut_question`;
CREATE TABLE `sap_form_shortcut_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) DEFAULT NULL COMMENT '题目文本信息',
  `full_score` int(11) DEFAULT NULL COMMENT '此题目的满分值',
  `min_score` int(11) DEFAULT NULL COMMENT '此题目的最低分值',
  `auto_add_note` int(11) DEFAULT NULL COMMENT '此题目是否自动添加评语，0不添加，１添加',
  `include_in_calc` int(11) DEFAULT NULL COMMENT '此题目是否参与评分表最终得分计算,1参与，0不参与',
  `standard_type` int(11) DEFAULT NULL COMMENT '此题目的标准类型，0关键词标准，1预定义标准，2导入标准',
  `standard_field_id` bigint(20) DEFAULT NULL COMMENT '使用自定义标准时的映射字段id。如果使用关键词标准时，此列为NULL',
  `remark` varchar(256) DEFAULT NULL COMMENT '此题目的描述信息',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建时间者',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最近更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '最近更新者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=626851845 DEFAULT CHARSET=utf8 COMMENT='快捷操作的节点详表';

-- ----------------------------
-- Records of sap_form_shortcut_question
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_form_shortcut_question_custom_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_shortcut_question_custom_detail`;
CREATE TABLE `sap_form_shortcut_question_custom_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_shortcut_question_id` bigint(20) DEFAULT NULL COMMENT '快捷操作的题目id',
  `lower_bound` varchar(32) DEFAULT NULL COMMENT '范围下边界，闭区间，如果为普通值类型，此列存放值,如果为区间类型，需要判断此值是否为数值类型',
  `upper_bound` varchar(32) DEFAULT NULL COMMENT '范围上边界，闭区间，如果为普通值类型，此列为NULL',
  `score` float DEFAULT NULL COMMENT '分值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=625901572 DEFAULT CHARSET=utf8 COMMENT='快捷自定义得分标准详表';

-- ----------------------------
-- Records of sap_form_shortcut_question_custom_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_form_shortcut_question_keyword_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_shortcut_question_keyword_detail`;
CREATE TABLE `sap_form_shortcut_question_keyword_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_shortcut_question_id` bigint(20) DEFAULT NULL COMMENT '快捷操作的题目id',
  `keyword_id` bigint(20) DEFAULT NULL COMMENT '关键词id',
  `weight` int(11) DEFAULT NULL COMMENT '权重',
  `min_frequence` int(11) DEFAULT NULL COMMENT '分析频次，大于或等于此频次时，参与计算',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=626884612 DEFAULT CHARSET=utf8 COMMENT='快捷操作的关键词得分标准详表';

-- ----------------------------
-- Records of sap_form_shortcut_question_keyword_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_form_shortcut_question_query_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_shortcut_question_query_detail`;
CREATE TABLE `sap_form_shortcut_question_query_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `form_shortcut_question_id` bigint(20) DEFAULT NULL COMMENT '快捷操作的问题ID',
  `query` varchar(512) CHARACTER SET latin1 DEFAULT NULL COMMENT '根据关键词组成的查询',
  `weight` int(11) DEFAULT NULL COMMENT '该项设置影响问题结果计算权重',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=627605507 DEFAULT CHARSET=utf8 COMMENT='快捷操作的关键词查询详表';

-- ----------------------------
-- Records of sap_form_shortcut_question_query_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_form_type`
-- ----------------------------
DROP TABLE IF EXISTS `sap_form_type`;
CREATE TABLE `sap_form_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评分表类型id',
  `form_type` varchar(128) DEFAULT NULL COMMENT '评分表类型',
  `remark` varchar(256) DEFAULT NULL COMMENT '描述信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=628555777 DEFAULT CHARSET=utf8 COMMENT='评分表的类型';

-- ----------------------------
-- Table structure for `sap_keyword`
-- ----------------------------
DROP TABLE IF EXISTS `sap_keyword`;
CREATE TABLE `sap_keyword` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(64) NOT NULL COMMENT '关键词',
  `frequence` int(11) DEFAULT NULL COMMENT '关键词总频次',
  `is_default` int(11) DEFAULT NULL COMMENT '是否为索引服务分析出的关键词（不可删除），1是，0是户添加',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword` (`keyword`)
) ENGINE=InnoDB AUTO_INCREMENT=631406593 DEFAULT CHARSET=utf8 COMMENT='关键词表';

-- ----------------------------
-- Table structure for `sap_keyword_category`
-- ----------------------------
DROP TABLE IF EXISTS `sap_keyword_category`;
CREATE TABLE `sap_keyword_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `keyword_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=631439361 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `sap_log`
-- ----------------------------
DROP TABLE IF EXISTS `sap_log`;
CREATE TABLE `sap_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `log` varchar(255) DEFAULT NULL,
  `operate_type` varchar(255) DEFAULT NULL,
  `operate_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sap_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_organization`
-- ----------------------------
DROP TABLE IF EXISTS `sap_organization`;
CREATE TABLE `sap_organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `code` varchar(128) DEFAULT NULL COMMENT '部门编号',
  `name` varchar(256) DEFAULT NULL COMMENT '部门名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父部门ID，如果此列为NULL，表示顶级部门',
  `address` varchar(256) DEFAULT NULL COMMENT '部门地址',
  `tel` varchar(64) DEFAULT NULL COMMENT '部门电话',
  `icon` varchar(128) DEFAULT NULL COMMENT '节点图标',
  `order` int(11) DEFAULT NULL COMMENT '同一个部门内的排序',
  `default_role_id` bigint(20) DEFAULT NULL COMMENT '默认角色id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `remark` varchar(256) DEFAULT NULL COMMENT '部门描述',
  PRIMARY KEY (`id`),
  KEY `FKFA967A70960A0B20` (`parent_id`),
  KEY `FKFA967A707142C212` (`create_by`),
  KEY `FKFA967A7093846511` (`default_role_id`),
  CONSTRAINT `FKFA967A707142C212` FOREIGN KEY (`create_by`) REFERENCES `sap_user` (`id`),
  CONSTRAINT `FKFA967A7093846511` FOREIGN KEY (`default_role_id`) REFERENCES `sap_role` (`id`),
  CONSTRAINT `FKFA967A70960A0B20` FOREIGN KEY (`parent_id`) REFERENCES `sap_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=630292482 DEFAULT CHARSET=utf8 COMMENT='组织机构表';

-- ----------------------------
-- Records of sap_organization
-- ----------------------------
INSERT INTO `sap_organization` VALUES ('1', 'gdyh', '总公司', null, '中国北京', '', 'icon_company', '0', null, '2014-04-29 19:01:16', null, 'aaa');

-- ----------------------------
-- Table structure for `sap_organization_business`
-- ----------------------------
DROP TABLE IF EXISTS `sap_organization_business`;
CREATE TABLE `sap_organization_business` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  `business_id` bigint(20) DEFAULT NULL COMMENT '业务id',
  `is_default` int(11) DEFAULT NULL COMMENT '是否为部门的默认业务',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sap_organization_business
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_organization_role`
-- ----------------------------
DROP TABLE IF EXISTS `sap_organization_role`;
CREATE TABLE `sap_organization_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `is_default` int(11) DEFAULT NULL COMMENT '是否为部门的默认角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sap_organization_role
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_organization_skill_group`
-- ----------------------------
DROP TABLE IF EXISTS `sap_organization_skill_group`;
CREATE TABLE `sap_organization_skill_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  `skill_group_id` bigint(20) DEFAULT NULL COMMENT '技能组id',
  `is_default` int(11) DEFAULT NULL COMMENT '是否为部门的默认技能',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sap_organization_skill_group
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `sap_privilege`;
CREATE TABLE `sap_privilege` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL COMMENT '权限名称',
  `url` varchar(256) DEFAULT NULL COMMENT '对应url',
  `order` int(11) DEFAULT NULL COMMENT '同一权限下，用于排序',
  `state` int(11) NOT NULL COMMENT '是否启用, 1启用，0停用',
  `parent_id` bigint(11) DEFAULT NULL COMMENT '父节点',
  `privilege_type` int(11) DEFAULT NULL COMMENT '权限类型，0菜单,1按扭',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `icon` varchar(256) DEFAULT NULL COMMENT '显示图标',
  `remark` varchar(256) DEFAULT NULL COMMENT '相关描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='系统权限定义表';

-- ----------------------------
-- Records of sap_privilege
-- ----------------------------
INSERT INTO `sap_privilege` VALUES ('1', '系统管理', '', '7', '0', null, '0', '2014-02-19 01:00:00', 'icon_sys', '系统管理');
INSERT INTO `sap_privilege` VALUES ('2', '系统菜单管理', '/privilege/manager', '0', '1', '1', '0', '2014-02-19 01:00:00', 'icon_privilege', '');
INSERT INTO `sap_privilege` VALUES ('3', '角色管理', '/role/manager', '1', '0', '36', '0', '2014-02-19 01:00:00', 'icon_role', '');
INSERT INTO `sap_privilege` VALUES ('4', '用户管理', '/user/manager', '3', '0', '36', '0', '2014-02-19 01:00:00', 'icon_user', '');
INSERT INTO `sap_privilege` VALUES ('5', '系统权限列表', '/privilege/treeGrid', '0', '0', '2', '1', '2014-02-19 01:00:00', 'icon_privilege', '');
INSERT INTO `sap_privilege` VALUES ('6', '添加', '/privilege/add', '0', '0', '2', '1', '2014-02-19 01:00:00', 'icon_privilege', '资源添加');
INSERT INTO `sap_privilege` VALUES ('7', '编辑', '/privilege/edit', '0', '0', '2', '1', '2014-02-19 01:00:00', 'icon_resource', '资源编辑');
INSERT INTO `sap_privilege` VALUES ('8', '删除', '/privilege/delete', '0', '0', '2', '1', '2014-02-19 01:00:00', 'icon_privilege', '资源删除');
INSERT INTO `sap_privilege` VALUES ('10', '角色列表', '/role/dataGrid', '0', '0', '3', '1', '2014-02-19 01:00:00', 'icon_role', '角色列表');
INSERT INTO `sap_privilege` VALUES ('11', '添加', '/role/add', '0', '0', '3', '1', '2014-02-19 01:00:00', 'icon_role', '角色添加');
INSERT INTO `sap_privilege` VALUES ('12', '编辑', '/role/edit', '0', '0', '3', '1', '2014-02-19 01:00:00', 'icon_role', '角色编辑');
INSERT INTO `sap_privilege` VALUES ('13', '删除', '/role/delete', '0', '0', '3', '1', '2014-02-19 01:00:00', 'icon_role', '角色删除');
INSERT INTO `sap_privilege` VALUES ('14', '授权', '/role/grant', '0', '0', '3', '1', '2014-02-19 01:00:00', 'icon_role', '角色授权');
INSERT INTO `sap_privilege` VALUES ('15', '用户列表', '/user/dataGrid', '0', '0', '4', '1', '2014-02-19 01:00:00', 'icon_user', '用户列表');
INSERT INTO `sap_privilege` VALUES ('16', '添加', '/user/add', '0', '0', '4', '1', '2014-02-19 01:00:00', 'icon_user', '用户添加');
INSERT INTO `sap_privilege` VALUES ('17', '编辑', '/user/edit', '0', '0', '4', '1', '2014-02-19 01:00:00', 'icon_user', '用户编辑');
INSERT INTO `sap_privilege` VALUES ('18', '删除', '/user/delete', '0', '0', '4', '1', '2014-02-19 01:00:00', 'icon_user', '用户删除');
INSERT INTO `sap_privilege` VALUES ('20', '部门管理', '/organization/manager', '0', '0', '36', '0', '2014-02-19 01:00:00', 'icon_org', '');
INSERT INTO `sap_privilege` VALUES ('21', '部门列表', '/organization/treeGrid', '0', '0', '20', '1', '2014-02-19 01:00:00', 'icon_org', '用户列表');
INSERT INTO `sap_privilege` VALUES ('22', '添加', '/organization/add', '0', '0', '20', '1', '2014-02-19 01:00:00', 'icon_org', '部门添加');
INSERT INTO `sap_privilege` VALUES ('23', '编辑', '/organization/edit', '0', '0', '20', '1', '2014-02-19 01:00:00', 'icon_org', '部门编辑');
INSERT INTO `sap_privilege` VALUES ('24', '删除', '/organization/delete', '0', '0', '20', '1', '2014-02-19 01:00:00', 'icon_org', '部门删除');
INSERT INTO `sap_privilege` VALUES ('26', '系统参数管理', '/dictionary/manager', '1', '0', '1', '0', '2014-02-19 01:00:00', 'icon_dic', null);
INSERT INTO `sap_privilege` VALUES ('27', '字典列表', '/dictionary/dataGrid', '0', '0', '26', '1', '2014-02-19 01:00:00', 'icon_dic', '字典列表');
INSERT INTO `sap_privilege` VALUES ('29', '添加', '/dictionary/add', '0', '0', '26', '1', '2014-02-19 01:00:00', 'icon_dic', '字典添加');
INSERT INTO `sap_privilege` VALUES ('30', '编辑', '/dictionary/edit', '0', '0', '26', '1', '2014-02-19 01:00:00', 'icon_dic', '字典编辑');
INSERT INTO `sap_privilege` VALUES ('31', '删除', '/dictionary/delete', '0', '0', '26', '1', '2014-02-19 01:00:00', 'icon_dic', '字典删除');
INSERT INTO `sap_privilege` VALUES ('32', '质检报表管理', '', '1', '0', null, '0', '2014-02-19 01:00:00', 'icon_sys', null);
INSERT INTO `sap_privilege` VALUES ('33', '质检查询分析', '', '2', '0', null, '0', '2014-02-19 01:00:00', 'icon_sys', '');
INSERT INTO `sap_privilege` VALUES ('34', '质检评分管理', '', '3', '0', null, '0', '2014-02-19 01:00:00', 'icon_sys', null);
INSERT INTO `sap_privilege` VALUES ('35', '语音质检设置', '', '4', '0', null, '0', '2014-02-19 01:00:00', 'icon_sys', null);
INSERT INTO `sap_privilege` VALUES ('36', '用户管理', '', '5', '0', null, '0', '2014-02-19 01:00:00', 'icon_sys', '');
INSERT INTO `sap_privilege` VALUES ('39', '质检明细报表', '/report/reportDetail', '1', '0', '32', '0', '2014-02-19 01:00:00', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('42', '质检录音查询', '/voice/search', '1', '0', '33', '0', '2014-02-19 01:00:00', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('43', '评分表类别管理', '/form/formType', '3', '0', '34', '0', '2014-02-19 01:00:00', 'icon_dic', null);
INSERT INTO `sap_privilege` VALUES ('44', '质检评分表管理', '/form/manager', '4', '0', '34', '0', '2014-02-19 01:00:00', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('45', '关键词管理', '/keyword/manager', '2', '0', '34', '0', '2014-02-19 01:00:00', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('47', '抽检规则管理', '/voiceExtractRule/manager', '0', '0', '35', '0', '2014-02-19 01:00:00', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('48', '免评分用户管理', '/dataSource/manager', '1', '0', '35', '0', '2014-02-19 01:00:00', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('50', '技能组管理', '/skillGroup/manager', '2', '0', '36', '0', '2014-02-19 01:00:00', 'icon_sys', '');
INSERT INTO `sap_privilege` VALUES ('56', '质检汇总报表', '/report/reportSummary', '0', '0', '32', '0', '2014-04-29 18:15:45', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('57', '关键词类别管理', '/category/manager', '1', '0', '34', '0', '2014-04-29 18:32:21', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('58', '业务管理', '/business/manager', '4', '0', '36', '0', '2014-04-30 00:21:51', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('59', '系统操作日志', '/systemLog/manager', '2', '0', '1', '0', '2014-04-30 00:29:23', '', null);
INSERT INTO `sap_privilege` VALUES ('60', '添加', '/skillGroup/add', '0', '0', '50', '1', '2014-05-04 19:56:15', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('61', '编辑', '/skillGroup/edit', '1', '0', '50', '1', '2014-05-04 19:57:22', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('62', '删除', '/skillGroup/delete', '2', '0', '50', '1', '2014-05-04 19:58:29', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('63', '技能组列表', '/skillGroup/dataGrid', '3', '0', '50', '1', '2014-05-04 20:00:54', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('64', '添加', '/business/add', '0', '0', '58', '1', '2014-05-05 12:50:54', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('65', '编辑', '/business/edit', '1', '0', '58', '1', '2014-05-05 12:51:36', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('66', '删除', '/business/delete', '2', '0', '58', '1', '2014-05-05 12:52:14', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('67', '新建', '/form/add', '1', '0', '44', '1', '2014-05-05 13:07:50', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('68', '打开', '/form/open', '2', '0', '44', '1', '2014-05-05 13:32:14', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('69', '删除', '/form/delete', '3', '0', '44', '1', '2014-05-05 13:33:33', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('70', '修改状态', '/form/modifyState', '4', '0', '44', '1', '2014-05-05 13:34:37', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('71', '导出', '/form/export', '5', '1', '44', '1', '2014-05-05 13:36:09', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('72', '导入', '/form/import', '6', '1', '44', '1', '2014-05-05 13:36:46', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('73', '导出Excel', '/form/exportExcel', '7', '1', '44', '1', '2014-05-05 13:37:38', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('74', '重新命名', '/form/rename', '8', '1', '44', '1', '2014-05-05 13:38:18', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('75', '刷新', '/form/reload', '9', '1', '44', '1', '2014-05-05 13:39:13', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('76', '添加', '/formType/add', '1', '0', '43', '1', '2014-05-05 19:31:14', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('77', '编辑', '/formType/edit', '2', '0', '43', '1', '2014-05-05 19:31:53', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('78', '删除', '/formType/delete', '3', '0', '43', '1', '2014-05-05 19:32:27', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('81', '添加', '/voiceExtractRule/add', '0', '0', '47', '1', '2014-05-06 17:53:46', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('82', '编辑', '/voiceExtractRule/edit', '1', '0', '47', '1', '2014-05-06 17:54:19', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('83', '删除', '/voiceExtractRule/delete', '2', '0', '47', '1', '2014-05-06 17:54:51', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('84', '添加', '/dataSource/add', '0', '0', '48', '1', '2014-05-07 11:19:32', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('85', '删除', '/dataSource/delete', '1', '0', '48', '1', '2014-05-07 11:20:51', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('86', '质检评分查询', '/quality/manager', '0', '0', '33', '0', '2014-05-13 17:40:23', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('87', '添加', '/category/add', '1', '0', '57', '1', '2014-05-15 09:39:25', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('88', '编辑', '/category/edit', '2', '0', '57', '1', '2014-05-15 09:39:58', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('89', '删除', '/category/delete', '3', '0', '57', '1', '2014-05-15 09:40:29', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('90', '添加', '/keyword/add', '1', '0', '45', '1', '2014-05-15 10:15:33', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('91', '编辑', '/keyword/edit', '2', '0', '45', '1', '2014-05-15 10:17:29', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('92', '删除', '/keyword/delete', '3', '0', '45', '1', '2014-05-15 10:18:02', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('93', '录音上传', '/upload/uploadPage', '3', '0', '33', '0', '2014-05-15 10:18:02', 'icon_dic', '');
INSERT INTO `sap_privilege` VALUES ('94', '业务列表', '/business/dataGrid', '3', '0', '58', '1', '2015-11-30 14:44:48', 'icon_dic', '');

-- ----------------------------
-- Table structure for `sap_quality_result_form`
-- ----------------------------
DROP TABLE IF EXISTS `sap_quality_result_form`;
CREATE TABLE `sap_quality_result_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `voice_id` bigint(20) unsigned NOT NULL COMMENT '对应voice表中的id',
  `form_id` bigint(20) NOT NULL COMMENT '评分表id',
  `quality_time` timestamp NULL DEFAULT NULL COMMENT '根据评分表评分的开始时间',
  `quality_score` float NOT NULL COMMENT '对应此评分表的质检得分',
  `audit_score` float DEFAULT NULL COMMENT '质检员审核后得分',
  `audit_note` varchar(256) DEFAULT NULL COMMENT '质检审核后评语',
  `audit_time` timestamp NULL DEFAULT NULL COMMENT '审核时间',
  `audit_by` bigint(20) DEFAULT NULL COMMENT '审核者',
  `score` float DEFAULT NULL COMMENT '最终评分，如果是自动质检时，此值等于quality_score,如果经过质检员审核后，此值等于audit_score',
  PRIMARY KEY (`id`),
  KEY `SAP_QUALITY_FORM_INDEX` (`form_id`),
  KEY `SAP_QUALITY_VOICE_INDEX` (`voice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=631668766 DEFAULT CHARSET=utf8 COMMENT='质检评分结果表';

-- ----------------------------
-- Table structure for `sap_quality_result_node`
-- ----------------------------
DROP TABLE IF EXISTS `sap_quality_result_node`;
CREATE TABLE `sap_quality_result_node` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quality_result_form_id` bigint(20) DEFAULT NULL COMMENT '评分表节点得分表id',
  `form_node_id` bigint(20) DEFAULT NULL COMMENT '评分表节点id，可能是段落、章节、题目类型的节点',
  `score` float DEFAULT NULL COMMENT '节点的直接得分，得分规则调整前的得分',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `SAP_RESULTNODE_NODE_INDEX` (`form_node_id`) USING BTREE,
  KEY `SAP_RESULTNODE_FORM_INDEX` (`quality_result_form_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=631701654 DEFAULT CHARSET=utf8 COMMENT='质检评分表节点得分表';

-- ----------------------------
-- Table structure for `sap_quality_result_node_rule`
-- ----------------------------
DROP TABLE IF EXISTS `sap_quality_result_node_rule`;
CREATE TABLE `sap_quality_result_node_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rule_id` bigint(20) DEFAULT NULL COMMENT '规则id',
  `voice_id` bigint(20) DEFAULT NULL COMMENT '录音id',
  `adjust_score` float DEFAULT NULL COMMENT '规则的调整分',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='评分表规则适用结果详细表';

-- ----------------------------
-- Records of sap_quality_result_node_rule
-- ----------------------------

-- ----------------------------
-- Table structure for `sap_quality_result_question`
-- ----------------------------
DROP TABLE IF EXISTS `sap_quality_result_question`;
CREATE TABLE `sap_quality_result_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quality_result_node_id` bigint(20) DEFAULT NULL COMMENT '所属的质检评分表节点得分表ID',
  `actual_value` float DEFAULT NULL COMMENT '题目每个标准的实际值，对关键词标准保存频次，自定义及预定义是实际值',
  `score` float DEFAULT NULL COMMENT '此值对应的评分',
  PRIMARY KEY (`id`),
  KEY `SAP_RESULTQUESTION_NODE_INDEX` (`quality_result_node_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=631734752 DEFAULT CHARSET=utf8 COMMENT='质检评分表的题目得分情况';

-- ----------------------------
-- Table structure for `sap_role`
-- ----------------------------
DROP TABLE IF EXISTS `sap_role`;
CREATE TABLE `sap_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(128) NOT NULL COMMENT '角色名称',
  `state` int(11) DEFAULT NULL COMMENT '角色状态， 0停用，1启用',
  `is_default` int(11) DEFAULT NULL COMMENT '1系统默认初始化数据，不能编辑；0可以编辑',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(256) DEFAULT NULL COMMENT '角色描述',
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=628490242 DEFAULT CHARSET=utf8 COMMENT='系统角色表';

-- ----------------------------
-- Records of sap_role
-- ----------------------------
INSERT INTO `sap_role` VALUES ('1', '超级管理员', '1', '1', null, '2014-04-29 19:01:16', '超级管理员，拥有全部权限', null);

-- ----------------------------
-- Table structure for `sap_role_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `sap_role_privilege`;
CREATE TABLE `sap_role_privilege` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关联项id',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `privilege_id` bigint(20) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=856 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

-- ----------------------------
-- Records of sap_role_privilege
-- ----------------------------
INSERT INTO `sap_role_privilege` VALUES ('695', '1', '42');
INSERT INTO `sap_role_privilege` VALUES ('696', '1', '82');
INSERT INTO `sap_role_privilege` VALUES ('697', '1', '35');
INSERT INTO `sap_role_privilege` VALUES ('698', '1', '83');
INSERT INTO `sap_role_privilege` VALUES ('700', '1', '1');
INSERT INTO `sap_role_privilege` VALUES ('701', '1', '36');
INSERT INTO `sap_role_privilege` VALUES ('702', '1', '77');
INSERT INTO `sap_role_privilege` VALUES ('703', '1', '48');
INSERT INTO `sap_role_privilege` VALUES ('704', '1', '76');
INSERT INTO `sap_role_privilege` VALUES ('705', '1', '71');
INSERT INTO `sap_role_privilege` VALUES ('706', '1', '24');
INSERT INTO `sap_role_privilege` VALUES ('707', '1', '72');
INSERT INTO `sap_role_privilege` VALUES ('708', '1', '33');
INSERT INTO `sap_role_privilege` VALUES ('709', '1', '18');
INSERT INTO `sap_role_privilege` VALUES ('710', '1', '94');
INSERT INTO `sap_role_privilege` VALUES ('711', '1', '64');
INSERT INTO `sap_role_privilege` VALUES ('712', '1', '88');
INSERT INTO `sap_role_privilege` VALUES ('713', '1', '92');
INSERT INTO `sap_role_privilege` VALUES ('714', '1', '61');
INSERT INTO `sap_role_privilege` VALUES ('715', '1', '6');
INSERT INTO `sap_role_privilege` VALUES ('716', '1', '3');
INSERT INTO `sap_role_privilege` VALUES ('717', '1', '78');
INSERT INTO `sap_role_privilege` VALUES ('718', '1', '5');
INSERT INTO `sap_role_privilege` VALUES ('719', '1', '90');
INSERT INTO `sap_role_privilege` VALUES ('720', '1', '66');
INSERT INTO `sap_role_privilege` VALUES ('721', '1', '34');
INSERT INTO `sap_role_privilege` VALUES ('722', '1', '46');
INSERT INTO `sap_role_privilege` VALUES ('723', '1', '75');
INSERT INTO `sap_role_privilege` VALUES ('724', '1', '58');
INSERT INTO `sap_role_privilege` VALUES ('725', '1', '45');
INSERT INTO `sap_role_privilege` VALUES ('726', '1', '7');
INSERT INTO `sap_role_privilege` VALUES ('727', '1', '11');
INSERT INTO `sap_role_privilege` VALUES ('729', '1', '31');
INSERT INTO `sap_role_privilege` VALUES ('730', '1', '39');
INSERT INTO `sap_role_privilege` VALUES ('731', '1', '29');
INSERT INTO `sap_role_privilege` VALUES ('732', '1', '60');
INSERT INTO `sap_role_privilege` VALUES ('733', '1', '14');
INSERT INTO `sap_role_privilege` VALUES ('734', '1', '17');
INSERT INTO `sap_role_privilege` VALUES ('735', '1', '23');
INSERT INTO `sap_role_privilege` VALUES ('736', '1', '67');
INSERT INTO `sap_role_privilege` VALUES ('737', '1', '28');
INSERT INTO `sap_role_privilege` VALUES ('738', '1', '86');
INSERT INTO `sap_role_privilege` VALUES ('739', '1', '26');
INSERT INTO `sap_role_privilege` VALUES ('740', '1', '16');
INSERT INTO `sap_role_privilege` VALUES ('741', '1', '84');
INSERT INTO `sap_role_privilege` VALUES ('742', '1', '10');
INSERT INTO `sap_role_privilege` VALUES ('743', '1', '81');
INSERT INTO `sap_role_privilege` VALUES ('744', '1', '15');
INSERT INTO `sap_role_privilege` VALUES ('745', '1', '69');
INSERT INTO `sap_role_privilege` VALUES ('746', '1', '68');
INSERT INTO `sap_role_privilege` VALUES ('747', '1', '50');
INSERT INTO `sap_role_privilege` VALUES ('748', '1', '57');
INSERT INTO `sap_role_privilege` VALUES ('749', '1', '85');
INSERT INTO `sap_role_privilege` VALUES ('750', '1', '32');
INSERT INTO `sap_role_privilege` VALUES ('751', '1', '4');
INSERT INTO `sap_role_privilege` VALUES ('752', '1', '91');
INSERT INTO `sap_role_privilege` VALUES ('753', '1', '20');
INSERT INTO `sap_role_privilege` VALUES ('754', '1', '62');
INSERT INTO `sap_role_privilege` VALUES ('755', '1', '21');
INSERT INTO `sap_role_privilege` VALUES ('756', '1', '8');
INSERT INTO `sap_role_privilege` VALUES ('757', '1', '44');
INSERT INTO `sap_role_privilege` VALUES ('758', '1', '22');
INSERT INTO `sap_role_privilege` VALUES ('759', '1', '89');
INSERT INTO `sap_role_privilege` VALUES ('760', '1', '73');
INSERT INTO `sap_role_privilege` VALUES ('761', '1', '30');
INSERT INTO `sap_role_privilege` VALUES ('762', '1', '74');
INSERT INTO `sap_role_privilege` VALUES ('763', '1', '2');
INSERT INTO `sap_role_privilege` VALUES ('764', '1', '47');
INSERT INTO `sap_role_privilege` VALUES ('765', '1', '13');
INSERT INTO `sap_role_privilege` VALUES ('766', '1', '56');
INSERT INTO `sap_role_privilege` VALUES ('767', '1', '27');
INSERT INTO `sap_role_privilege` VALUES ('768', '1', '65');
INSERT INTO `sap_role_privilege` VALUES ('769', '1', '70');
INSERT INTO `sap_role_privilege` VALUES ('770', '1', '59');
INSERT INTO `sap_role_privilege` VALUES ('771', '1', '63');
INSERT INTO `sap_role_privilege` VALUES ('772', '1', '12');
INSERT INTO `sap_role_privilege` VALUES ('773', '1', '87');
INSERT INTO `sap_role_privilege` VALUES ('774', '1', '43');
INSERT INTO `sap_role_privilege` VALUES ('776', '1', '93');

-- ----------------------------
-- Table structure for `sap_skill_group`
-- ----------------------------
DROP TABLE IF EXISTS `sap_skill_group`;
CREATE TABLE `sap_skill_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '组id',
  `name` varchar(256) NOT NULL COMMENT '组名称',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `media_type` int(11) DEFAULT NULL COMMENT '媒体类型，1-audio、2-text、3-vidio',
  `form_id` bigint(20) DEFAULT NULL COMMENT '评分表id',
  `organization_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  `remark` varchar(256) DEFAULT NULL COMMENT '组描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=628883457 DEFAULT CHARSET=utf8 COMMENT='座席技能表';

-- ----------------------------
-- Table structure for `sap_system_log`
-- ----------------------------
DROP TABLE IF EXISTS `sap_system_log`;
CREATE TABLE `sap_system_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `log` varchar(64) NOT NULL COMMENT '操作日志',
  `action` varchar(128) DEFAULT NULL COMMENT '对应的action',
  `operate_time` timestamp NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=633864201 DEFAULT CHARSET=utf8 COMMENT='系统日志表';

-- ----------------------------
-- Table structure for `sap_user`
-- ----------------------------
DROP TABLE IF EXISTS `sap_user`;
CREATE TABLE `sap_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `name` varchar(32) DEFAULT NULL COMMENT '用户姓名',
  `login_name` varchar(128) NOT NULL COMMENT '登录名',
  `password` varchar(256) NOT NULL COMMENT '密码',
  `sex` int(11) DEFAULT NULL COMMENT '性别',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `skill_group_id` bigint(20) DEFAULT NULL COMMENT '所属技能组id',
  `business_id` bigint(20) DEFAULT NULL COMMENT '所属业务id',
  `organization_id` bigint(20) DEFAULT NULL COMMENT '所属部门id',
  `state` int(11) DEFAULT NULL COMMENT '座席状态，0启用，1禁用',
  `reset_password` int(11) DEFAULT NULL COMMENT '下次登录后，是否需要强制重置密码，0不需要，1需要',
  `is_default` int(11) DEFAULT NULL COMMENT '1系统默认初始化数据，不能编辑；0可以编辑',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `enroll_time` timestamp NULL DEFAULT NULL COMMENT '入职时间',
  `resign_time` timestamp NULL DEFAULT NULL COMMENT '离职时间',
  `leader` bigint(20) DEFAULT NULL COMMENT '主管座席',
  `remark` varchar(256) DEFAULT NULL COMMENT '描述信息',
  PRIMARY KEY (`id`),
  KEY `SAP_USER_ORG_INDEX` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=629538817 DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Records of sap_user
-- ----------------------------
INSERT INTO `sap_user` VALUES ('1', '超级管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '0', '18', null, null, '1', '1', null, '1', '2014-04-29 11:03:52', null, null, null, null, null);

-- ----------------------------
-- Table structure for `sap_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sap_user_role`;
CREATE TABLE `sap_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户角色关联id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Records of sap_user_role
-- ----------------------------
INSERT INTO `sap_user_role` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for `sap_voice`
-- ----------------------------
DROP TABLE IF EXISTS `sap_voice`;
CREATE TABLE `sap_voice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_no` varchar(256) NOT NULL COMMENT '原始的、不包含路径的文件名',
  `audio_format` varchar(64) DEFAULT NULL COMMENT '间频格式',
  `ani` varchar(32) DEFAULT NULL COMMENT '主叫号码，标识用户',
  `dnis` varchar(32) DEFAULT NULL COMMENT '被叫号码',
  `user_id` bigint(20) DEFAULT NULL COMMENT '座席员编号, 取user表中的id',
  `skill_group_id` bigint(20) DEFAULT NULL COMMENT '技能组id',
  `skill_group_name` varchar(255) DEFAULT NULL COMMENT '技能组名称',
  `business_id` bigint(20) DEFAULT NULL COMMENT '业务id',
  `business_name` varchar(255) DEFAULT NULL COMMENT '业务名称',
  `channel_type` int(4) DEFAULT '0' COMMENT '表示是否分声道:0-混合录音;1-座席员;2-客户',
  `call_time` timestamp NULL DEFAULT NULL COMMENT '通话时间',
  `call_type` int(11) DEFAULT NULL COMMENT '通话类型，1入呼叫，2出呼叫',
  `extension` varchar(64) DEFAULT NULL COMMENT '分机号码',
  `duration` int(11) DEFAULT NULL COMMENT '通话（录音）时长,单位:ms',
  `silence_duration` int(11) DEFAULT NULL COMMENT '静音总时长,单位:ms',
  `speed` float DEFAULT NULL COMMENT '坐席的平均语速,单位:字/秒',
  `emotion` int(11) DEFAULT NULL COMMENT '情绪,用掩码表示.0x01-HAPPY,0x02-ANGRY,0x04-SAD,0x08-DISGUSTED,',
  `analyse_start_time` timestamp NULL DEFAULT NULL COMMENT '质检服务开始处理的时间',
  `analyse_end_time` timestamp NULL DEFAULT NULL COMMENT '质检服务结束处理的时间',
  `index_start_time` timestamp NULL DEFAULT NULL COMMENT '索引服务建立索引的开始时间',
  `index_end_time` timestamp NULL DEFAULT NULL COMMENT '索引服务建立索引的结束时间',
  `index_docid` bigint(20) DEFAULT NULL COMMENT '此录音在索引文档中的docid',
  `custom0` varchar(64) DEFAULT NULL COMMENT '自定义字段',
  `custom1` varchar(64) DEFAULT NULL,
  `custom2` varchar(64) DEFAULT NULL,
  `custom3` varchar(64) DEFAULT NULL,
  `custom4` varchar(64) DEFAULT NULL,
  `custom5` varchar(64) DEFAULT NULL,
  `custom6` varchar(64) DEFAULT NULL,
  `custom7` varchar(64) DEFAULT NULL,
  `custom8` varchar(64) DEFAULT NULL,
  `custom9` varchar(64) DEFAULT NULL,
  `custom10` varchar(64) DEFAULT NULL,
  `custom11` varchar(64) DEFAULT NULL,
  `custom12` varchar(64) DEFAULT NULL,
  `custom13` varchar(64) DEFAULT NULL,
  `custom14` varchar(64) DEFAULT NULL,
  `custom15` varchar(64) DEFAULT NULL,
  `custom16` varchar(64) DEFAULT NULL,
  `custom17` varchar(64) DEFAULT NULL,
  `custom18` varchar(64) DEFAULT NULL,
  `custom19` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `SAP_VOICE_FILENO_INDEX` (`file_no`(255)),
  KEY `SAP_VOICE_USER_INDEX` (`user_id`) USING BTREE,
  KEY `SAP_VOICE_BUSINESS_INDEX` (`business_id`),
  KEY `SAP_VOICE_SKILL_INDEX` (`skill_group_id`),
  KEY `SAP_VOICE_CALLTIME_INDEX` (`call_time`)
) ENGINE=InnoDB AUTO_INCREMENT=631996439 DEFAULT CHARSET=utf8 COMMENT='录音文件流水表';

-- ----------------------------
-- Table structure for `sap_voice_extract_rule`
-- ----------------------------
DROP TABLE IF EXISTS `sap_voice_extract_rule`;
CREATE TABLE `sap_voice_extract_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `model_type` int(11) DEFAULT NULL COMMENT '模型规则，0样本数量，1百分比',
  `quota` float DEFAULT NULL COMMENT '限额',
  `threshold` int(11) DEFAULT NULL COMMENT '超过此样本数，才按百分比抽取',
  `lower_duration` int(11) DEFAULT NULL COMMENT '录音最小时长，毫秒数',
  `upper_duration` int(11) DEFAULT NULL COMMENT '录音最大时长，毫秒数',
  `call_type` int(11) DEFAULT NULL COMMENT '呼叫类型，0全部，1入呼叫，2出呼叫',
  `state` int(11) DEFAULT NULL COMMENT '规则状态，0禁用，1启用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '规则创建时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '规则创建者',
  `remark` varchar(256) DEFAULT NULL COMMENT '规则描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=633339905 DEFAULT CHARSET=utf8 COMMENT='质检抽检规则表';

-- ----------------------------
-- Procedure structure for `sap_form_clean`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sap_form_clean`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sap_form_clean`(
	form_id bigint(20)
    )
BEGIN
	DELETE detail FROM sap_form_question_keyword_detail detail WHERE detail.form_question_id IN(
	SELECT id FROM sap_form_question question WHERE question.form_node_id IN (
	SELECT id FROM sap_form_node node WHERE node.form_id = form_id AND node.node_type=3));
	
	DELETE detail FROM sap_form_question_custom_detail detail WHERE detail.form_question_id IN(
	SELECT id FROM sap_form_question question WHERE question.form_node_id IN (
	SELECT id FROM sap_form_node node WHERE node.form_id = form_id AND node.node_type=3));
	delete question from sap_form_question question where question.form_node_id IN (
	SELECT id FROM sap_form_node node WHERE node.form_id = form_id AND node.node_type=3);
	
	delete rule from sap_form_node_rule rule where rule.form_id = form_id;
	
	delete node from sap_form_node node where node.form_id = form_id;
    END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sap_form_state_change`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sap_form_state_change`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sap_form_state_change`(
	form_id INT,
	form_state INT,
	state_change_time TIMESTAMP
)
BEGIN
	DECLARE form_name VARCHAR(128);
	SELECT name into form_name FROM sap_form where id=form_id;
	IF state_change_time is not NULL THEN
		# 预设时间暂不修改状态。
		UPDATE sap_form
		set sap_form.state_change_time = state_change_time
		WHERE id=form_id;
	ELSE
		# 保证同一质检评分表只有一个发布
		IF form_state=2 THEN
			UPDATE sap_form
			SET state = 1
			WHERE sap_form.name = form_name and state =2;
		END IF;
		# 修改状态
		UPDATE sap_form
		SET state = form_state
		WHERE id=form_id;
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sap_shortcut_question_clean`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sap_shortcut_question_clean`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sap_shortcut_question_clean`(
	shortcut_id bigint(20)
    )
BEGIN
	DELETE detail FROM sap_form_shortcut_question_keyword_detail detail WHERE detail.form_shortcut_question_id = shortcut_id;
	DELETE detail FROM sap_form_shortcut_question_custom_detail detail WHERE detail.form_shortcut_question_id = shortcut_id;
	DELETE detail FROM sap_form_shortcut_question_query_detail detail WHERE detail.form_shortcut_question_id = shortcut_id;
	
    END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `getChildOrganization`
-- ----------------------------
DROP FUNCTION IF EXISTS `getChildOrganization`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getChildOrganization`(pId bigint) RETURNS varchar(1000) CHARSET utf8
BEGIN 
       DECLARE pTemp text;  
       DECLARE cTemp text;
  		 SET@@group_concat_max_len = 102400; 
       SET pTemp = '$';  
      
	 SELECT role_id INTO cTemp FROM sap_user_role WHERE user_id = pId LIMIT 1;
	 IF cTemp is null OR cTemp<>1 THEN
	 SELECT organization_id INTO cTemp FROM sap_user WHERE id = pId;
	 END IF;
	WHILE cTemp is not null DO  
         SET pTemp = concat(pTemp,',',cTemp); 
         SELECT group_concat(id) INTO cTemp FROM sap_organization   
         WHERE FIND_IN_SET(parent_id,cTemp)>0; 
					
	END WHILE;
	SET@@group_concat_max_len = 1024; 
      RETURN SUBSTRING(pTemp,3); 
     END
;;
DELIMITER ;
