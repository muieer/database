# 左反连接, 是 not in 和 not exist 的底层实现。
select *
from emp_info
    left anti join dept_info
on emp_info.dept_id = dept_info.dept_id
order by emp_id;

# 左半连接，介于 inner join 和 left outer join 之间，
# 结果只有左表内容，并且行数保持和左表一致。是 in 和 exist 的底层实现。
select *
from emp_info left semi join dept_info
on emp_info.dept_id = dept_info.dept_id
order by emp_id;

# 外连接，left|right|full outer join
select *
from emp_info
         left outer join dept_info on emp_info.dept_id = dept_info.dept_id
order by emp_id;

# cross join 就是做笛卡尔积
select *
from emp_info
         cross join dept_info
order by emp_id;

# inner join
select *
from emp_info
         inner join dept_info on emp_info.dept_id = dept_info.dept_id
order by emp_id;

use learn;