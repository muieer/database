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


