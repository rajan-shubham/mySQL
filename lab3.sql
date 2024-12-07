-- q21
SELECT COUNT(propertyNo) AS propertiew_viewed  FROM Viewing  WHERE viewDate BETWEEN '2004-05-01' AND '2004-05-31';

-- q22
SELECT COUNT(*) AS num_managers, SUM(salary) AS total_salary FROM Staff WHERE position = 'Manager';

-- q23
SELECT branchNo, COUNT(StaffNo) AS num_staff, SUM(salary) AS total_salary FROM Staff GROUP BY branchNo HAVING COUNT(StaffNo) > 1;

-- q24
select * from Staff where branchNo = (select branchNo from Branch where street = '163 Main St');

-- q25
select staffNo, fName, Iname, salary, salary - (select AVG(salary) from Staff) as salary_above_avg from Staff where salary > (select AVG(salary) from Staff);

-- q26
select * from PropertyForRent where staffNo in( select staffNO from Staff where branchNo = ( select branchNo from Branch where street = '163 Main St'));

-- q27
select * from Staff where salary > (select MIN(salary) from Staff Where branchNo = 'B003');

-- q28
select Client.fName, Client.lName, Viewing.comment from Client join Viewing ON Client.clientNo = Viewing.clientNo;

-- q29
select branchNo, count(*) as staff_count, SUM(salary) as total_salary from Staff group by branchNo;

-- q30
select Staff.branchNO, Staff.StaffNo, fName, Iname, propertyNo from Staff join PropertyForRent on Staff.StaffNo = PropertyForRent.staffNO;