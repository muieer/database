
show tables;

CREATE TABLE IF NOT EXISTS dept_info
(
    dept_id     BIGINT       NOT NULL COMMENT '部门 ID',
    dept_name   VARCHAR(255) NOT NULL COMMENT '部门名称',
    dept_leader INT COMMENT '部门领导 ID',
    parent_dept INT COMMENT '上级部门 ID',
    dept_level  INT COMMENT '部门级别'
) DUPLICATE KEY(dept_id)
COMMENT '部门信息表'
DISTRIBUTED BY HASH(dept_id) BUCKETS 2
PROPERTIES (
    "replication_num" = "1"
);

CREATE TABLE IF NOT EXISTS emp_info
(
    emp_id   BIGINT       NOT NULL COMMENT '员工 ID',
    emp_name VARCHAR(255) NOT NULL COMMENT '员工姓名',
    age      INT COMMENT '员工年龄',
    dept_id  INT COMMENT '部门 ID',
    salary   DECIMAL(22, 4) COMMENT '员工工资'
) DUPLICATE KEY(emp_id)
COMMENT '员工信息表'
DISTRIBUTED BY HASH(emp_id) BUCKETS 2
PROPERTIES (
    "replication_num" = "1"
);

use learn;
show databases;
create database if not exists learn;