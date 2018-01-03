/**
 * 功能表
 */
drop table if exists auth_func;
CREATE TABLE `auth_func` (
  `funcid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '功能名称',
  `url` varchar(200) DEFAULT NULL COMMENT '链接',
  `funcgroupID` int(11) DEFAULT NULL COMMENT '功能组',
  `parentid` int(11) DEFAULT NULL COMMENT '父级ID',
  `tag` varchar(20) DEFAULT NULL COMMENT '小标签',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人',
  `description` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`funcid`),
  UNIQUE KEY `funcid` (`funcid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/**
 * 角色表
 */
drop table if exists auth_role;
CREATE TABLE `auth_role` (
  `roleid` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `roleState` varchar(2) DEFAULT NULL COMMENT '是否可用1=可用；0=不可用',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人',
  `type` int(11) NOT NULL,
  PRIMARY KEY (`roleid`),
  UNIQUE KEY `funcid` (`roleid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/**
 * 角色功能表
 */
drop table if exists auth_rolefunc;
CREATE TABLE `auth_rolefunc` (
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  `funcid` int(11) DEFAULT NULL COMMENT '功能编号',
  `privilege` varchar(2) DEFAULT '1' COMMENT '权限',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**
 * 操作者表
 */
drop table if exists auth_operator;
CREATE TABLE `auth_operator` (
  `optid` int(11) NOT NULL AUTO_INCREMENT,
  `badge` varchar(11) DEFAULT NULL COMMENT '工号',
  `optName` varchar(200) DEFAULT NULL COMMENT '登录显示名称',
  `password` varchar(50) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL COMMENT '状态',
  `lastLogin` varchar(20) DEFAULT NULL COMMENT '最后登录时间',
  `errCount` datetime DEFAULT NULL COMMENT '错误次数',
  `ipAddress` datetime DEFAULT NULL COMMENT 'ip地址',
  `partId` varchar(11) DEFAULT NULL COMMENT '兼职id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人',
  `needChangePwd` varchar(2) DEFAULT NULL COMMENT '是否需要修改密码',
  `locked` varchar(2) DEFAULT NULL COMMENT '是否锁定',
  `platid` int(11) DEFAULT NULL,
  `gradeid` int(11) DEFAULT NULL,
  `userCenterId` int(11) DEFAULT NULL,
  `gradeName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`optid`),
  UNIQUE KEY `optid` (`optid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/**
 * 操作者权限
 */
drop table if exists auth_operatorrole;
CREATE TABLE `auth_operatorrole` (
  `operatorid` int(11) DEFAULT NULL COMMENT '操作员id',
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  `isLose` varchar(2) DEFAULT NULL COMMENT '是否兼职，1=兼职；0=不兼职',
  `partId` varchar(11) DEFAULT NULL COMMENT '兼职编号',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `nextval_safe`(sequence_name varchar(64)) RETURNS int(11)
BEGIN
 declare current integer;
    set current = 0;
    
    select t.value into current from t_sequence t where t.sequence_name = sequence_name for update;
    update t_sequence t set t.value = t.value + 1 where t.sequence_name = sequence_name;
    set current = current + 1;

    return current;
END$$
DELIMITER ;

INSERT INTO `t_sequence` VALUES ('1',1),('10',1),('11',1),('12',1),('13',1),('14',1),('15',1),('16',1),('17',1),('4',1),('5',1),('6',1),('8',1),('brand',1),('first',1),('goods',1),('goodsItem',1),('second',1),('third',1);

--
-- Dumping data for table `auth_func`
--
LOCK TABLES `auth_func` WRITE;
INSERT INTO `auth_func` VALUES (1,'系统管理','',NULL,NULL,'fa-desktop','2016-07-26 13:36:41',NULL,'1600001'),(2,'人员管理','/admin/system/staffMng/mng.shtml',NULL,1,NULL,'2016-07-26 13:40:42',NULL,NULL),(3,'角色管理','/admin/system/roleMng/mng.shtml',NULL,1,NULL,'2016-07-26 13:40:42',NULL,NULL),(4,'功能管理','/admin/system/funcMng/list.shtml',NULL,1,NULL,'2016-07-26 13:40:42',NULL,NULL),(6,'分级管理','/admin/system/gradeMng/mng.shtml',NULL,1,'window-restore','2017-09-17 14:43:06','2017-09-17 14:43:06',NULL);
UNLOCK TABLES;

--
-- Dumping data for table `auth_operator`
--
LOCK TABLES `auth_operator` WRITE;
INSERT INTO `coopback`.`auth_operator` (`badge`, `optName`, `password`, `status`, `platid`, `gradeid`, `userCenterId`, `gradeName`, `gradelevel`) VALUES ('100001', 'admin', '670B14728AD9902AECBA32E22FA4F6BD', '1', '21', '1', '8001', '鑫海总公司', '1');
UNLOCK TABLES;

--
-- Dumping data for table `auth_operatorrole`
--
LOCK TABLES `auth_operatorrole` WRITE;
INSERT INTO `auth_operatorrole` VALUES (1,1,'1',NULL,'2016-07-26 14:11:33','2016-07-26 14:11:33','1600001'),(2,1,'1',NULL,'2016-07-30 15:40:17','2016-07-30 15:40:17','1600001');
UNLOCK TABLES;

--
-- Dumping data for table `auth_role`
--
LOCK TABLES `auth_role` WRITE;
INSERT INTO `auth_role` VALUES (1,'超级管理员','1','2016-07-26 13:31:50',NULL,NULL,0);
UNLOCK TABLES;

--
-- Dumping data for table `auth_rolefunc`
--
LOCK TABLES `auth_rolefunc` WRITE;
INSERT INTO `auth_rolefunc` VALUES (1,1,'3','2016-07-26 14:00:41','2016-07-26 14:00:41','1600001'),(1,2,'3','2016-07-26 14:09:20','2016-07-26 14:09:20','1600001'),(1,3,'3','2016-07-26 14:09:20','2016-07-26 14:09:20','1600001'),(1,4,'3','2016-07-26 14:09:20','2016-07-26 14:09:20','1600001'),(1,6,'3','2017-09-17 14:44:38','2017-09-17 14:44:38','1600001');
UNLOCK TABLES;