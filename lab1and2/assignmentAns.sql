------------------ALL ANSWERS------------------------

--1.list full details of Staff
SELECT * FROM staff;

--2.Produce a list of salaries for all staff, showing only the staff number, the first and last names, and the salary details.
SELECT staffNo, FName, LName, salary FROM staff;

--3.Produce a list of monthly salaries for all staff, showing the staff number, the first and last names, and the salary details.
SELECT StaffNo, FName, LName, salary / 12 AS monthly_salary FROM Staff;

--4.List all staff with a salary greater than £10,000.
SELECT * FROM Staff WHERE salary > 10000;

--5.List all staff with a salary between £20,000 and £30,000.
SELECT * FROM Staff WHERE salary BETWEEN 20000 AND 30000;

--6.Produce a list of salaries for all staff, showing only the staff number, name, and salary details.
SELECT StaffNo, CONCAT(fName, ' ', lName) AS Name, salary FROM Staff;

--7.List all managers and supervisors.
SELECT * FROM Staff WHERE position IN ('Manager', 'Supervisor');

--8.List all cities where there is either a branch office or a property for rent.
SELECT DISTINCT city FROM Branch
UNION
SELECT DISTINCT city FROM PropertyForRent;

--9.List all cities where there is a branch office but no properties for rent.
SELECT city FROM Branch
WHERE city NOT IN (SELECT city FROM PropertyForRent);

--10.List all cities where there is both a branch office and at least one property for rent.
SELECT city FROM Branch
WHERE city IN (SELECT city FROM PropertyForRent);

--11,List the names and comments of all clients who have viewed a property for rent.
SELECT Client.fName, Client.lName, Viewing.comment
FROM Viewing
JOIN Client ON Viewing.clientNo = Client.clientNo;

--12.Produce a status report on property Viewings.
SELECT propertyNo, COUNT(clientNo) AS num_viewings, COUNT(comment) AS num_comments
FROM Viewing
GROUP BY propertyNo;

--13.List complete details of all staff who work at the branch in Glasgow.
SELECT Staff.* FROM Staff
JOIN Branch ON Staff.branchNo = Branch.branchNo
WHERE Branch.city = 'Glasgow';

--14.Find all owners with the string 'Glasgow' in their address.
SELECT * FROM Owner WHERE address LIKE '%Glasgow%';

--15,How many properties cost more than £350 per month to rent?
SELECT COUNT(*) FROM property WHERE rent > 350;

--16.Find the minimum, maximum, and average staff salary.
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary, AVG(salary) AS avg_salary FROM staff;

--17.Find the number of staff working in each branch and the sum of their salaries.
SELECT branchNo, COUNT(staffNo) AS num_staff, SUM(salary) AS total_salary
FROM staff
GROUP BY branchNo;

--18.List the details of all viewings on property PG4 where a comment has not been supplied.
SELECT * FROM viewing WHERE propertyNo = 'PG4' AND comment IS NULL;

--19.Produce a list of salaries for all staff, arranged in descending order of salary.
SELECT staffNo, FName, LName, salary FROM staff ORDER BY salary DESC;

--20.Produce a list of properties arranged in order of property type.
SELECT * FROM property ORDER BY type;

--21.How many different properties were viewed in May 2004?
SELECT COUNT(DISTINCT propertyNo) AS properties_viewed
FROM viewing
WHERE MONTH(date) = 5 AND YEAR(date) = 2004;

--22.Find the total number of Managers and the sum of their salaries.
SELECT COUNT(*) AS num_managers, SUM(salary) AS total_salary
FROM staff
WHERE position = 'Manager';

--23.For each branch office with more than one member of staff, find the number of staff working in each branch and the sum of their salaries.
SELECT branchNo, COUNT(staffNo) AS num_staff, SUM(salary) AS total_salary
FROM staff
GROUP BY branchNo
HAVING COUNT(staffNo) > 1;

--24.List the staff who work in the branch at '163 Main St'.
SELECT staff.* FROM staff
JOIN branch ON staff.branchNo = branch.branchNo
WHERE branch.address = '163 Main St';

--25.List all staff whose salary is greater than the average salary, and show by how much their salary is greater than the average.
SELECT staffNo, FName, LName, salary, salary - (SELECT AVG(salary) FROM staff) AS above_average
FROM staff
WHERE salary > (SELECT AVG(salary) FROM staff);

--26.List the properties that are handled by staff who work in the branch at '163 Main St'.
SELECT property.*
FROM property
JOIN staff ON property.branchNo = staff.branchNo
JOIN branch ON staff.branchNo = branch.branchNo
WHERE branch.address = '163 Main St';

Find all staff whose salary is larger than the salary of at least one member of staff at branch B003.
--27.SELECT * FROM staff
WHERE salary > (SELECT MIN(salary) FROM staff WHERE branchNo = 'B003');

--28.Find all staff whose salary is larger than the salary of every member of staff at branch B003.
SELECT * FROM staff
WHERE salary > (SELECT MAX(salary) FROM staff WHERE branchNo = 'B003');

--29.List the names of all clients who have viewed a property along with any comment supplied.
SELECT client.FName, client.LName, viewing.comment
FROM viewing
JOIN client ON viewing.clientNo = client.clientNo
WHERE viewing.comment IS NOT NULL;

--30.For each branch office, list the numbers and names of staff who manage properties and the properties that they manage.
SELECT branch.branchNo, branch.address, staff.staffNo, staff.FName, staff.LName, property.propertyNo
FROM property
JOIN staff ON property.branchNo = staff.branchNo
JOIN branch ON branch.branchNo = staff.branchNo;

--31.For each branch, list the numbers and names of staff who manage properties, including the city in which the branch is located and the properties that the staff manage.

SELECT branch.city, branch.branchNo, staff.staffNo, staff.FName, staff.LName, property.propertyNo
FROM property
JOIN staff ON property.branchNo = staff.branchNo
JOIN branch ON branch.branchNo = staff.branchNo;

--32.Find the number of properties handled by each staff member.
SELECT staff.staffNo, staff.FName, staff.LName, COUNT(property.propertyNo) AS num_properties
FROM property
JOIN staff ON property.branchNo = staff.branchNo
GROUP BY staff.staffNo;

--33.List all branch offices and any properties that are in the same city.
SELECT branch.city, branch.branchNo, branch.address, property.propertyNo, property.type
FROM branch
LEFT JOIN property ON branch.city = property.city;

--34.List the branch offices and properties that are in the same city along with any unmatched branches or properties.
SELECT branch.city AS branch_city, branch.branchNo, branch.address, property.city AS property_city, property.propertyNo, property.type
FROM branch
FULL OUTER JOIN property ON branch.city = property.city;

--35.Write query to create a table OwnersPropertyCount (ownerNo, FName, LName, noOfProperty) and populate it from the existing tables.
CREATE TABLE OwnersPropertyCount AS
SELECT owner.ownerNo, owner.FName, owner.LName, COUNT(property.propertyNo) AS noOfProperty
FROM owner
JOIN property ON owner.ownerNo = property.ownerNo
GROUP BY owner.ownerNo;

--36.Give all staff a 3% pay increase.
UPDATE staff
SET salary = salary * 1.03;

--37.Give all Managers a 5% pay increase.
UPDATE staff
SET salary = salary * 1.05
WHERE position = 'Manager';

--39.Promote David Ford (staffNo = 'SG14') to Manager and change his salary to £18,000.
UPDATE staff
SET position = 'Manager', salary = 18000
WHERE staffNo = 'SG14';

--40.Delete all viewings that relate to property PG4.

DELETE FROM viewing
WHERE propertyNo = 'PG4';
Delete all rows from the Viewing table.

DELETE FROM viewing;