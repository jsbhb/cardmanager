alter table auth_func add sort int comment "排序";
alter table coopback.auth_operator add grade_type tinyint(3) unsigned NOT NULL comment "客户类型";


DROP TABLE IF EXISTS `auth_gradeType_role`;
CREATE TABLE `auth_gradeType_role` (
  `gradeTypeId` int(11) DEFAULT NULL COMMENT '分级编号',
  `roleId` int(11) DEFAULT NULL COMMENT '角色id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `opt` varchar(20) DEFAULT NULL COMMENT '操作人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;