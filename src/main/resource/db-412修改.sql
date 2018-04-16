alter table auth_func add sort int comment "排序";
alter table coopback.auth_operator add grade_type tinyint(3) unsigned NOT NULL comment "客户类型";