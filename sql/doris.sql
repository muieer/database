
-- with 语句，查询语句职责单一，提高 SQL 可阅读、可修改、可扩展能力
with sales_dept as (select dept_id, dept_name
                    from dept_info
                    where dept_name = '销售部'
                    union all
                    select child.dept_id, child.dept_name
                    from dept_info child
                             inner join dept_info parent
                                        on child.parent_dept = parent.dept_id and parent.dept_name = '销售部')

select s.dept_name, e.*
from emp_info e
         join sales_dept s on e.dept_id = s.dept_id
order by e.emp_id;

--  union all 查询
select *
from (
    select dept_id   dept_level_1_id,
           dept_name dept_level_1_name,
           null      dept_level_2_id,
           null      dept_level_2_name,
           null      dept_level_3_id,
           null      dept_level_3_name
    from dept_info
    where dept_level = 1
    union all
    -- 将一级部门和二级部门合并
    select parent.dept_id   dept_level_1_id,
           parent.dept_name dept_level_1_name,
           child.dept_id    dept_level_2_id,
           child.dept_name  dept_level_2_name,
           null             dept_level_3_id,
           null             dept_level_3_name
    from dept_info child
             left join dept_info parent on child.parent_dept = parent.dept_id
    where child.dept_level = 2
    union all
    -- 将一级、二级、三级部门合并
    select level1.dept_id   dept_level_1_id,
           level1.dept_name dept_level_1_name,
           level2.dept_id   dept_level_2_id,
           level2.dept_name dept_level_2_name,
           level3.dept_id   dept_level_3_id,
           level3.dept_name dept_level_3_name
    from dept_info level3
             left join dept_info level2 on level3.parent_dept = level2.dept_id
             left join dept_info level1 on level2.parent_dept = level1.dept_id
    where level3.dept_level = 3
) t
order by dept_level_1_id, dept_level_2_id, dept_level_3_id;


select level1.dept_id   dept_level_1_id,
       level1.dept_name dept_level_1_name,
       level2.dept_id   dept_level_2_id,
       level2.dept_name dept_level_2_name,
       level3.dept_id   dept_level_3_id,
       level3.dept_name dept_level_3_name
from dept_info level3
         left join dept_info level2 on level3.parent_dept = level2.dept_id
         left join dept_info level1 on level2.parent_dept = level1.dept_id
where level3.dept_level = 3;

select parent.dept_id   dept_level_1_id,
       parent.dept_name dept_level_1_name,
       child.dept_id    dept_level_2_id,
       child.dept_name  dept_level_2_name,
       null             dept_level_3_id,
       null             dept_level_3_name
from dept_info child
         left join dept_info parent on child.parent_dept = parent.dept_id
where child.dept_level = 2;

select dept_id   dept_level_1_id,
       dept_name dept_level_1_name,
       null      dept_level_2_id,
       null      dept_level_2_name,
       null      dept_level_3_id,
       null      dept_level_3_name
from dept_info
where dept_level = 1;

select dept_name, avg(age) as avg_age, sum(salary) as total_salary
from dept_info
         join emp_info on dept_info.dept_id = emp_info.dept_id
group by dept_info.dept_name
order by avg_age;

insert into emp_info
values (1, '张三', 25, 1000, 10000.00),
       (2, '李四', 30, 1100, 15000.00),
       (3, '王五', 35, 1100, 20000.00),
       (4, '赵六', 40, 1100, 25000.00),
       (5, '孙七', 45, 1200, 30000.00),
       (6, '周八', 50, 1200, 35000.00),
       (7, '吴九', 55, 1110, 40000.00),
       (8, '郑十', 60, 1120, 45000.00),
       (9, '陈十一', 65, 1120, 50000.00);
insert into dept_info
values (1000, '总经办', 1, null, 1),
       (1100, '销售部', 2, 1000, 2),
       (1200, '研发部', 5, 1000, 2),
       (1110, '销售一部', 7, 1100, 3),
       (1120, '销售二部', 8, 1100, 3),
       (1300, '人力资源部', null, 1000, 2);

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

select get_json_double('{"k1":1.3}', "$.k1");

select count(*)
from user_order;

delete
from user_order
where dt >= '2024-12-27 16:09:37';

select *
from user_order
order by cost desc
limit 1,10;

describe user_order;

CREATE TABLE IF NOT EXISTS user_order
(
    uid  INT COMMENT '用户 ID',
    cost DECIMAL(10, 2) DEFAULT '0.0',
    dt   datetime       DEFAULT current_timestamp
)
    ENGINE = olap DISTRIBUTED BY HASH(uid) BUCKETS 8
PROPERTIES (
    "replication_num" = "1"
);

describe user;

show tables;

CREATE TABLE user
(
    uid int
)
    COMMENT "my first table"
    DISTRIBUTED BY HASH
(
    uid
) BUCKETS 32
    PROPERTIES
(
    "replication_num" = "1"
);

use learn;

show databases;

create database learn;