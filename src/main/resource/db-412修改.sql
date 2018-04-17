alter table auth_func add sort int comment "排序";
alter table coopback.auth_operator add grade_type tinyint(3) unsigned NOT NULL comment "客户类型";

alter table auth_role add parentId int comment "角色父类";

--2018-0-09
LOCK TABLES `t_sequence` WRITE;
INSERT INTO `t_sequence` VALUES ('base',701);
UNLOCK TABLES;


DROP TABLE IF EXISTS `auth_gradeType_role`;
CREATE TABLE `auth_gradeType_role` (
  `gradeTypeId` int(11) DEFAULT NULL COMMENT '分级编号',
  `roleId` int(11) DEFAULT NULL COMMENT '角色id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP FUNCTION IF EXISTS `getFirstGradeId`;
DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `getFirstGradeId`(rootId INT) RETURNS varchar(2000) CHARSET utf8
BEGIN
       DECLARE sTemp VARCHAR(2000);
       DECLARE sTempGradeId VARCHAR(2000);
       DECLARE sTempParentGradeId VARCHAR(2000);
  
       SET sTemp = '$';
       SET sTempGradeId =cast(rootId as CHAR);
       SET sTempParentGradeId = '-1';
       SELECT parentGradeId INTO sTempParentGradeId FROM auth_operator WHERE gradeid = sTempGradeId limit 1;
    
       WHILE sTempParentGradeId <> 0 DO
		 SET sTempGradeId = sTempParentGradeId;
         SELECT parentGradeId INTO sTempParentGradeId FROM auth_operator WHERE gradeid = sTempGradeId limit 1;
       END WHILE;
       SET sTemp = sTempGradeId;
       RETURN sTemp;
     END$$
DELIMITER ;