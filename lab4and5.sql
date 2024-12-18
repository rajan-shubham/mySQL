-- #1.Find Out staff Details who work for Same Branch which Have more than 1 Employee.
SELECT *FROM Staff WHERE branchNo IN (
SELECT branchNo FROM Staff GROUP BY branchNo
HAVING COUNT(staffNo) > 1);


-- #2.Create a View Which Display BranchNo,StaffNo.Position & ClientNo
CREATE VIEW custom AS
Select s.branchNo,s.staffNo,s.position,c.clientNo
From Staff s
JOIN Registration c ON s.staffNo = c.staffNo;

Select * FROM custom;

--  Another ans 
CREATE VIEW BranchStaffClientView AS
SELECT Staff.branchNo,Staff.staffNo,Staff.position,Registration.clientNo
FROM Staff JOIN Registration ON Staff.staffNo = Registration.staffNo;
SELECT * FROM BranchStaffClientView;

-- #3.SHOW all details from Cross Product of Staff,Registration
SELECT *
FROM Staff,Registration;

-- #4.Find the Street & city of the Branch for ALL Clients whose Max Rent > 400
SELECT c.clientNo,c.fName,c.lName,b.branchNo, b.street,b.city
FROM Client c
JOIN Registration r ON c.clientNo = r.clientNo AND maxRent > 400
JOIN Branch b ON r.branchNo = b.branchNo;


SELECT Client.clientNo,Client.fName,Client.lName,Branch.street,Branch.city
FROM Client JOIN Registration ON Client.clientNo = Registration.clientNo
JOIN Branch ON Registration.branchNo = Branch.branchNo WHERE Client.maxRent > 400;

-- 5 Find the max salary for each BranchNo
SELECT branchNo, MAX(salary)FROM  Staff
GROUP BY branchNo;





-- 1. Find Second high Salary each BranchNo with Designation
SELECT branchNo, position, salary FROM (
SELECT branchNo, position, salary,ROW_NUMBER() OVER (PARTITION BY branchNo ORDER BY salary DESC) 
AS salary_rankFROM Staff) 
AS RankedSalaries WHERE salary_rank = 2
ORDER BY branchNo, position;

-- 2. Find the Date of Join for High Salary Holder Staff
SELECT r.dateJoined
FROM Staff s JOIN Registration r ON s.staffNo = r.staffNo
WHERE s.salary = (SELECT MAX(salary) FROM Staff);

-- 3. Find the PropertyNo,StaffNo,branchNo,comment from the Appropiate Tables.
SELECT P.propertyNo, P.staffNo, P.branchNo, V.comment
FROM PropertyForRent P
JOIN Viewing V ON P.propertyNo = V.propertyNo;

-- 4. Find the Staff works in Each Branch with position 
SELECT branchNo,staffNo,fName,lName,position
FROM Staff ORDER BY branchNo, staffNo;

-- 5.Alter table Staff and add location attribute with values 
ALTER TABLE Staff
ADD Location VARCHAR(50);
UPDATE Staff
SET Location = CASE staffNo
    WHEN 'SL21' THEN 'Paris'
    WHEN 'SG37' THEN 'Glasgow'
    WHEN 'SG14' THEN 'London'
    WHEN 'SA9'  THEN 'Paris'
    WHEN 'SG5'  THEN 'Glasgow'
    WHEN 'SL41' THEN 'London'
    ELSE Location 
END;
SELECT * FROM Staff;

-- 6.Find The Staff details where location and branchNo city is same
SELECT s.staffNo, s.fName, s.lName, s.position, s.salary, s.branchNo
FROM Staff s
JOIN Branch b ON s.branchNo = b.branchNo
WHERE b.city = (
    SELECT b2.city
    FROM Branch b2
    WHERE b2.branchNo = s.branchNo
);
-- 7.Find room,type,rent,propertyno ,city,branchno, where postcode is same fro branchno & proprtyno
SELECT pfr.propertyNo, pfr.city, pfr.branchNo, pfr.type, pfr.rooms, pfr.rent
FROM PropertyForRent pfr
JOIN Branch b ON pfr.postcode = b.postcode
WHERE pfr.branchNo = b.branchNo;

-- 8.Find the details of owners who have maximum number of property
SELECT DISTINCT po.ownerNo, po.fName, po.lName, po.address, po.telNo
FROM PrivateOwner po
WHERE po.ownerNo = (
    SELECT pfr.ownerNo
    FROM PropertyForRent pfr
    GROUP BY pfr.ownerNo
    ORDER BY COUNT(pfr.propertyNo) DESC
    LIMIT 1
);

-- 9 Find the details of client where fNname starts with 'M'
SELECT clientNo, fName, lName, telNo, prefType, maxRent
FROM Client
WHERE fName LIKE 'M%';

-- 10 Find the owner details where fNname has 3 charecter
SELECT ownerNo, fName, lName, address, telNo
FROM PrivateOwner
WHERE LENGTH(fName) = 3;