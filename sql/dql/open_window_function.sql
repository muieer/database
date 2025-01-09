select *
from (select *
           , max(salary) over (order by dept_id) as avg_salary
      from emp_info) t
order by dept_id
;

SELECT *
FROM (SELECT *,
             DENSE_RANK() OVER (ORDER BY salary DESC) AS ranking
      FROM emp_info) AS ranked_emp
WHERE ranking <= 2
LIMIT 10;

SELECT *,
       rank() OVER (order by salary desc) AS ranking
FROM emp_info
order by ranking;

select *
FROM emp_info
order by salary desc;