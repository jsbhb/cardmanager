use coopback;

alter table coopback.capitalmanagement add unique index `customer_id_customer_type_UNIQUE`(`customer_id`,`customer_type`);

alter table coopback.capitalmanagement drop index `customer_id_UNIQUE`;

alter table coopback.capitalmanagement_detail add `customer_type` TINYINT UNSIGNED NULL COMMENT "客户类型0:供应商,1:区域中心";