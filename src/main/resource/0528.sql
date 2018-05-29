use coopback;

drop table if exists  `capitalmanagement`;

CREATE TABLE `coopback`.`capitalmanagement` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_id` INT NULL COMMENT '客户ID',
  `customer_name` VARCHAR(50) NULL COMMENT '客户名称',
  `customer_type` TINYINT UNSIGNED NULL COMMENT '客户类型0:供应商,1:区域中心',
  `money` DECIMAL(12,2) DEFAULT 0 COMMENT '可用金额',
  `use_money` DECIMAL(12,2) DEFAULT 0 COMMENT '使用金额',
  `count_money` DECIMAL(12,2) DEFAULT 0 COMMENT '累计金额',
  `status` TINYINT UNSIGNED NULL DEFAULT 1 COMMENT '状态0停用，1启用',
  `remark` VARCHAR(200) NULL COMMENT '备注',
  `create_time` DATETIME NULL COMMENT '注册时间', 
  `update_time` DATETIME NULL COMMENT '更新时间',
  `opt` VARCHAR(20) NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  INDEX `idx_customer_id` (`customer_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC)) 
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 
COMMENT = '资金管理主表';

drop table if exists  `capitalmanagement_detail`;

CREATE TABLE `coopback`.`capitalmanagement_detail` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_id` INT NULL COMMENT '客户ID',
  `pay_type` TINYINT UNSIGNED NULL COMMENT '支付类型0:收入,1:支出',
  `money` DECIMAL(12,2) NULL COMMENT '金额',
  `pay_no` VARCHAR(50) NULL COMMENT '支付流水号',
  `business_no` VARCHAR(50) NULL COMMENT '业务流水号',
  `remark` VARCHAR(200) NULL COMMENT '备注',
  `create_time` DATETIME NULL COMMENT '注册时间', 
  `opt` VARCHAR(20) NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  INDEX `idx_customer_id` (`customer_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)) 
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 
COMMENT = '资金管理记录表';

drop table if exists  `capitalmanagement_business_item`;

CREATE TABLE `coopback`.`capitalmanagement_business_item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_no` VARCHAR(50) NOT NULL COMMENT '业务流水号',
  `order_id` VARCHAR(50) NULL COMMENT '订单号',
  `item_id` VARCHAR(50) NULL COMMENT '商品编号',
  `item_code` VARCHAR(50) NULL COMMENT '商家编码',
  `item_quantity` INT UNSIGNED NULL COMMENT '商品数量',
  `item_price` DECIMAL(10,2) NULL COMMENT '商品价格',
  `item_encode` VARCHAR(50) NULL COMMENT '商品条形码',
  `create_time` DATETIME NULL COMMENT '注册时间', 
  `opt` VARCHAR(20) NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  INDEX `idx_business_no` (`business_no`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)) 
  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 
COMMENT = '业务明细记录表';