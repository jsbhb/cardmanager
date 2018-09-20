use coopback;

drop table if exists  `deliverymanagement`;

CREATE TABLE `coopback`.`deliverymanagement` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `delivery_name` VARCHAR(50) NULL COMMENT '物流公司名称',
  `delivery_code` VARCHAR(50) NULL COMMENT '物流公司代码',
  `status` TINYINT UNSIGNED NULL DEFAULT 1 COMMENT '状态0停用，1启用',
  `remark` VARCHAR(200) NULL COMMENT '备注',
  `create_time` DATETIME NULL COMMENT '创建时间', 
  `update_time` DATETIME NULL COMMENT '更新时间',
  `opt` VARCHAR(20) NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  INDEX `idx_delivery_code` (`delivery_code`),
  INDEX `idx_status` (`status`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)) 
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 
COMMENT = '物流公司管理表';

insert into deliverymanagement (delivery_name,delivery_code,status,create_time,update_time,opt) values 
('顺丰速运','SF','1',now(),now(),'admin'),
('百世快递','HTKY','1',now(),now(),'admin'),
('中通快递','ZTO','1',now(),now(),'admin'),
('申通快递','STO','1',now(),now(),'admin'),
('圆通速递','YTO','1',now(),now(),'admin'),
('韵达速递','YD','1',now(),now(),'admin'),
('EMS','EMS','1',now(),now(),'admin'),
('全峰快递','QFKD','1',now(),now(),'admin'),
('国通快递','GTO','1',now(),now(),'admin'),
('优速快递','UC','1',now(),now(),'admin'),
('德邦','DBL','1',now(),now(),'admin'),
('源星货运','XYHY','1',now(),now(),'admin'),
('安能物流','ANE','1',now(),now(),'admin'),
('家馨物流','JXWL','1',now(),now(),'admin'),
('洋浦物流','YPFL','1',now(),now(),'admin'),
('福兴特快','FXTK','1',now(),now(),'admin'),
('盛世风行','SSFX','1',now(),now(),'admin'),
('京东物流','JD','1',now(),now(),'admin'),
('远成物流','YCWL','1',now(),now(),'admin'),
('宅急送','ZJS','1',now(),now(),'admin'),
('诚冠物流','CGWL','1',now(),now(),'admin'),
('旺成物流','WCWL','1',now(),now(),'admin')