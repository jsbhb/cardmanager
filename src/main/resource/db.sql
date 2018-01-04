
--
-- Table structure for table `auth_func`
--
DROP TABLE IF EXISTS `auth_func`;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auth_func`
--

LOCK TABLES `auth_func` WRITE;
INSERT INTO `auth_func` VALUES (1,'首页','/admin/index/index.shtml',NULL,NULL,'fa-home','2017-10-18 17:11:54','2017-10-18 17:11:54',NULL,'首页界面'),(3,'角色管理','/admin/system/roleMng/list.shtml',NULL,23,NULL,'2016-07-26 13:40:42',NULL,NULL,NULL),(4,'功能管理','/admin/system/funcMng/list.shtml',NULL,23,NULL,'2016-07-26 13:40:42',NULL,NULL,NULL),(6,'分级管理','/admin/system/gradeMng/list.shtml',NULL,23,'window-restore','2017-09-17 14:43:06','2017-09-17 14:43:06',NULL,NULL),(21,'员工管理','/admin/system/staffMng/list.shtml',NULL,23,NULL,'2017-10-17 16:19:46','2017-10-17 16:19:46',NULL,'员工管理界面'),(23,'系统管理','',NULL,NULL,'fa-desktop','2016-07-26 13:36:41','2017-10-24 10:37:50','1600001','1231'),(24,'商品管理',NULL,NULL,NULL,'fa-shopping-bag','2017-11-06 09:20:52','2017-11-06 09:20:52',NULL,NULL),(25,'基础商品','/admin/goods/baseMng/list.shtml',NULL,24,NULL,'2017-11-06 09:22:16','2017-11-06 09:22:16',NULL,'基础信息维护'),(26,'商品明细管理','/admin/goods/itemMng/mng.shtml',NULL,24,NULL,'2017-11-06 09:23:11','2017-11-06 09:23:11',NULL,NULL),(27,'供应商管理',NULL,NULL,NULL,'fa-car','2017-11-06 09:28:43','2017-11-06 09:28:43',NULL,NULL),(28,'供应商管理','/admin/supplier/supplierMng/list.shtml',NULL,27,NULL,'2017-11-06 09:29:42','2017-11-06 09:29:42',NULL,NULL),(29,'品牌管理','/admin/goods/brandMng/list.shtml',NULL,24,NULL,'2017-11-06 09:31:20','2017-11-06 09:31:20',NULL,NULL),(30,'分类管理','/admin/goods/catalogMng/list.shtml',NULL,24,NULL,'2017-11-06 09:31:57','2017-11-06 09:31:57',NULL,NULL),(31,'规格管理','/admin/goods/specsMng/mng.shtml',NULL,24,NULL,'2017-11-06 09:33:03','2017-11-06 09:33:03',NULL,NULL),(32,'商城管理',NULL,NULL,NULL,'fa-building','2017-11-15 01:48:40','2017-11-15 01:48:40',NULL,NULL),(33,'首页设置','/admin/mall/indexMng/mng.shtml',NULL,32,'fa-laptop','2017-11-15 01:49:46','2017-11-15 01:49:46',NULL,NULL),(34,'采购管理',NULL,NULL,NULL,'fa-shopping-bag ','2017-11-15 01:51:00','2017-11-15 01:51:00',NULL,NULL),(35,'采购合同','/admin/purchase/contract/list.shtml',NULL,34,NULL,'2017-11-15 01:52:17','2017-11-15 01:52:17',NULL,NULL),(36,'订单管理',NULL,NULL,NULL,'fa-newspaper-o','2017-11-15 01:53:32','2017-11-15 01:53:32',NULL,NULL),(37,'财务管理',NULL,NULL,NULL,'fa-money','2017-11-15 01:54:11','2017-11-15 01:54:11',NULL,NULL),(38,'报表','/admin/report/reportMng/list.shtml',NULL,1,NULL,'2017-11-15 01:55:44','2017-11-15 01:55:44',NULL,NULL),(39,'订单管理','/admin/order/stockOutMng/list.shtml',NULL,36,NULL,'2017-11-15 01:56:18','2018-01-01 15:02:25',NULL,NULL),(40,'商品管理','/admin/goods/goodsMng/mng.shtml',NULL,24,NULL,'2017-12-22 13:57:44','2017-12-22 13:58:54',NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `auth_operator`
--

DROP TABLE IF EXISTS `auth_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `parentGradeId` int(11) DEFAULT NULL,
  `gradelevel` int(11) DEFAULT NULL,
  `shopid` int(11) DEFAULT NULL,
  PRIMARY KEY (`optid`),
  UNIQUE KEY `optid` (`optid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `auth_operator` WRITE;
INSERT INTO `coopback`.`auth_operator` (`badge`, `optName`, `password`, `status`, `platid`, `gradeid`, `userCenterId`, `gradeName`, `gradelevel`) VALUES ('100001', 'admin', '670B14728AD9902AECBA32E22FA4F6BD', '1', '21', '1', '8001', '鑫海总公司', '1');
UNLOCK TABLES;

--
-- Table structure for table `auth_operatorrole`
--

DROP TABLE IF EXISTS `auth_operatorrole`;
CREATE TABLE `auth_operatorrole` (
  `operatorid` int(11) DEFAULT NULL COMMENT '操作员id',
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  `isLose` varchar(2) DEFAULT NULL COMMENT '是否兼职，1=兼职；0=不兼职',
  `partId` varchar(11) DEFAULT NULL COMMENT '兼职编号',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `coopback`.`auth_operatorrole`(`operatorid`,`roleid`,`isLose`,`partId`,`createTime`,`updateTime`,`opt`)VALUES(24,1,1,1,now(),now(),1);



DROP TABLE IF EXISTS `auth_role`;
CREATE TABLE `auth_role` (
  `roleid` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `roleState` int(11) NOT NULL,
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人',
  `type` int(11) NOT NULL,
  PRIMARY KEY (`roleid`),
  UNIQUE KEY `funcid` (`roleid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;


INSERT INTO `coopback`.`auth_role` (`roleid`, `roleName`, `roleState`, `createTime`, `updateTime`, `type`) VALUES (1, '超级管理员', '1', now(), now(), '1'),(2, '区域中心管理员', '1', now(), now(), '1');


DROP TABLE IF EXISTS `auth_rolefunc`;
CREATE TABLE `auth_rolefunc` (
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  `funcid` int(11) DEFAULT NULL COMMENT '功能编号',
  `privilege` varchar(2) DEFAULT '1' COMMENT '权限',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `auth_rolefunc` VALUES (1,1,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,3,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,4,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,6,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,21,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,23,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,24,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,25,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,26,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,27,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,28,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,29,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,30,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,31,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,32,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,33,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,34,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,35,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,36,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,37,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,38,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,39,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1')
,(1,40,'1','2017-12-22 13:57:59','2017-12-22 13:57:59','1');


--
-- Table structure for table `t_sequence`
--
DROP TABLE IF EXISTS `t_sequence`;
CREATE TABLE `t_sequence` (
  `sequence_name` varchar(64) NOT NULL COMMENT '序列名称',
  `value` int(11) DEFAULT NULL COMMENT '当前值',
  PRIMARY KEY (`sequence_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


drop function nextval_safe;
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


LOCK TABLES `t_sequence` WRITE;
INSERT INTO `t_sequence` VALUES ('1',1),('10',1),('11',1),('12',1),('13',1),('14',1),('15',1),('16',4),('17',1),('4',1),('5',1),('6',1),('8',1),('brand',1),('first',1),('goods',1),('goodsItem',1),('second',1),('third',1);
UNLOCK TABLES;