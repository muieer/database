--  union all 查询
with level1_dept as (select dept_id   as dept_level_1_id,
                            dept_name as dept_level_1_name,
                            null      as dept_level_2_id,
                            null      as dept_level_2_name,
                            null      as dept_level_3_id,
                            null      as dept_level_3_name
                     from dept_info
                     where dept_level = 1),
     level2_dept as (select level1.dept_id   as dept_level_1_id,
                            level1.dept_name as dept_level_1_name,
                            level2.dept_id   as dept_level_2_id,
                            level2.dept_name as dept_level_2_name,
                            null             as dept_level_3_id,
                            null             as dept_level_3_name
                     from dept_info level2
                              left join dept_info level1 on level2.parent_dept = level1.dept_id
                     where level2.dept_level = 2),
     level3_dept as (select level1.dept_id   as dept_level_1_id,
                            level1.dept_name as dept_level_1_name,
                            level2.dept_id   as dept_level_2_id,
                            level2.dept_name as dept_level_2_name,
                            level3.dept_id   as dept_level_3_id,
                            level3.dept_name as dept_level_3_name
                     from dept_info level3
                              left join dept_info level2 on level3.parent_dept = level2.dept_id
                              left join dept_info level1 on level2.parent_dept = level1.dept_id
                     where level3.dept_level = 3)
select *
from level1_dept
union all
select *
from level2_dept
union all
select *
from level3_dept
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

select level1.dept_id   as dept_level_1_id,
       level1.dept_name as dept_level_1_name,
       level2.dept_id   as dept_level_2_id,
       level2.dept_name as dept_level_2_name,
       null             as dept_level_3_id,
       null             as dept_level_3_name
from dept_info level2
         left join dept_info level1 on level2.parent_dept = level1.dept_id
where level2.dept_level = 2;

select dept_id   dept_level_1_id,
       dept_name dept_level_1_name,
       null      dept_level_2_id,
       null      dept_level_2_name,
       null      dept_level_3_id,
       null      dept_level_3_name
from dept_info
where dept_level = 1;

use learn;