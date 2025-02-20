select dept, count(dept)
from emp
group by dept;

-- write a quarry to display all the dept names where no. of emps are less then 2.
select dept
from emp
group by dept
having count(*) < 2;
