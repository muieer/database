describe salary_rank;

show tables;

select *
from salary_rank;

create view salary_rank (emp_name, salary, ranking)
as
SELECT emp_name,
       salary,
       rank() OVER (order by salary desc) AS ranking
FROM emp_info
order by ranking;