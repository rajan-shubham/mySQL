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

-- Branch Table
CREATE TABLE Branch (
    branchNo CHAR(4) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50),
    postcode CHAR(8)
);

INSERT INTO Branch (branchNo, street, city, postcode) VALUES 
('B005', '22 Deer Rd', 'London', 'SW1 4EH'),
('B007', '16 Argyll St', 'Aberdeen', 'AB2 3SU'),
('B003', '163 Main St', 'Glasgow', 'G11 9QX'),
('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ'),
('B002', '56 Clover Dr', 'London', 'NW10 6EU');

-- Staff Table
CREATE TABLE Staff (
    staffNo VARCHAR(5) PRIMARY KEY,
    fName VARCHAR(20),
    lName VARCHAR(20),
    position VARCHAR(20),
    sex CHAR(1) CHECK (sex IN ('M', 'F')),
    DOB DATE,
    salary INT,
    branchNo CHAR(4),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

INSERT INTO Staff (staffNo, fName, lName, position, sex, DOB, salary, branchNo) VALUES 
('SL21', 'John', 'White', 'Manager', 'M', '1945-10-01', 30000, 'B005'), 
('SG37', 'Ann', 'Beech', 'Assistant', 'F', '1960-11-10', 12000, 'B003'),
('SG14', 'David', 'Ford', 'Supervisor', 'M', '1958-03-24', 18000, 'B003'), 
('SA9', 'Mary', 'Howe', 'Assistant', 'F', '1970-02-19', 9000, 'B007'),
('SG5', 'Susan', 'Brand', 'Manager', 'F', '1940-06-03', 24000, 'B003'), 
('SL41', 'Julie', 'Lee', 'Assistant', 'F', '1965-06-13', 9000, 'B005');

-- Registration Table
CREATE TABLE Registration (
    clientNo VARCHAR(5),
    branchNo CHAR(4),
    staffNo VARCHAR(5),
    dateJoined DATE,
    PRIMARY KEY (clientNo, branchNo),
    FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo),
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo)
);

INSERT INTO Registration VALUES 
('CR76', 'B005', 'SL41', '2004-01-02'), 
('CR56', 'B003', 'SG37', '2003-04-11'), 
('CR74', 'B003', 'SG37', '2002-11-16'), 
('CR62', 'B007', 'SA9', '2003-03-07');

-- PropertyForRent Table
CREATE TABLE PropertyForRent (
    propertyNo VARCHAR(5) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(20),
    postcode VARCHAR(10),
    type VARCHAR(10),
    rooms INT,
    rent DECIMAL(6, 2),
    ownerNo VARCHAR(5),
    staffNo VARCHAR(5),
    branchNo CHAR(4),
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

INSERT INTO PropertyForRent (propertyNo, street, city, postcode, type, rooms, rent, ownerNo, staffNo, branchNo) VALUES
('PA14', '16 Holhead', 'Aberdeen', 'AB7 5SU', 'House', 6, 650, 'CO46', 'SA9', 'B007'),
('PL94', '6 Argyll St', 'London', 'NW2', 'Flat', 3, 400, 'CO87', 'SL41', 'B005'),
('PG4', '6 Lawrence St', 'Glasgow', 'G11 9QX', 'Flat', 3, 350, 'CO40', 'SG37', 'B003'),
('PG36', '2 Manor Rd', 'Glasgow', 'G32 4QX', 'Flat', 3, 375, 'CO40', 'SG37', 'B003'),
('PG21', '18 Dale Rd', 'Glasgow', 'G12', 'House', 5, 600, 'CO87', 'SG37', 'B003'),
('PG16', '5 Novar Dr', 'Glasgow', 'G12 9AX', 'Flat', 4, 450, 'CO93', 'SG14', 'B003');

-- Client Table
CREATE TABLE Client (
    clientNo VARCHAR(5) PRIMARY KEY,
    fName VARCHAR(20),
    lName VARCHAR(20),
    telNo VARCHAR(15),
    prefType VARCHAR(10),
    maxRent DECIMAL(6, 2)
);

INSERT INTO Client (clientNo, fName, lName, telNo, prefType, maxRent) VALUES
('CR76', 'John', 'Kay', '0207-774-5632', 'Flat', 425),
('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat', 350),
('CR74', 'Mike', 'Ritchie', '01475-392178', 'House', 750),
('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600);

-- PrivateOwner Table
CREATE TABLE PrivateOwner (
    ownerNo VARCHAR(5) PRIMARY KEY,
    fName VARCHAR(20),
    lName VARCHAR(20),
    address VARCHAR(50),
    telNo VARCHAR(15)
);

INSERT INTO PrivateOwner (ownerNo, fName, lName, address, telNo) VALUES
('CO46', 'Joe', 'Keogh', '2 Fergus Dr, Aberdeen AB2 7SX', '01224-861212'),
('CO87', 'Carol', 'Farrel', '6 Achray St, Glasgow G32 9DX', '0141-357-7419'),
('CO40', 'Tina', 'Murphy', '63 Well St, Glasgow G42', '0141-943-1728'),
('CO93', 'Tony', 'Shaw', '12 Park Pl, Glasgow G4 0QR', '0141-225-7025');

-- Viewing Table
CREATE TABLE Viewing (
    viewingID INT PRIMARY KEY AUTO_INCREMENT,
    clientNo VARCHAR(5),
    propertyNo VARCHAR(5),
    viewDate DATE,
    comment VARCHAR(50),
    FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo)
);

INSERT INTO Viewing (clientNo, propertyNo, viewDate, comment) VALUES
('CR56', 'PA14', '2004-05-24', 'too small'),
('CR76', 'PG4', '2004-04-20', 'too remote'),
('CR56', 'PG4', '2004-05-26', NULL),
('CR62', 'PA14', '2004-05-14', 'no dining room'),
('CR56', 'PG36', '2004-04-28', NULL);

-- 31
SELECT Branch.city, Branch.branchNo, Staff.staffNo, Staff.fName, Staff.Iname, PropertyForRent.propertyNo FROM PropertyForRent JOIN Staff ON PropertyForRent.staffNo = Staff.staffNo JOIN Branch ON Branch.branchNo = Staff.branchNo;

-- 32
SELECT Staff.staffNo, Staff.fName, Staff.Iname, COUNT(PropertyForRent.propertyNo) AS num_properties  FROM PropertyForRent  JOIN Staff ON PropertyForRent.staffNo = Staff.staffNo  GROUP BY Staff.staffNo, Staff.fName, Staff.Iname;

-- 33
SELECT Branch.city, Branch.branchNo, Branch.street, PropertyForRent.propertyNo, PropertyForRent.type FROM Branch LEFT JOIN PropertyForRent ON Branch.city = PropertyForRent.city;

-- 34
SELECT      Branch.city AS branch_city,      Branch.branchNo,      Branch.street,      PropertyForRent.city AS property_city,      PropertyForRent.propertyNo,      PropertyForRent.type  FROM      Branch  LEFT JOIN      PropertyForRent ON Branch.city = PropertyForRent.city  UNION ALL  SELECT      Branch.city AS branch_city,      Branch.branchNo,
  Branch.street,      PropertyForRent.city AS property_city,      PropertyForRent.propertyNo,      PropertyForRent.type  FROM      Branch  RIGHT JOIN      PropertyForRent ON Branch.city = PropertyForRent.city WHERE      Branch.city IS NULL;

-- 35
CREATE TABLE OwnersPropertyCount AS
    -> SELECT 
    ->     PrivateOwner.ownerNo, 
    ->     PrivateOwner.fName, 
    ->     PrivateOwner.lName, 
    ->     COUNT(PropertyForRent.propertyNo) AS noOfProperty
    -> FROM 
    ->     PrivateOwner
    -> JOIN 
    ->     PropertyForRent ON PrivateOwner.ownerNo = PropertyForRent.ownerNo
    -> GROUP BY 
    ->     PrivateOwner.ownerNo, 
    ->     PrivateOwner.fName, 
    ->     PrivateOwner.lName;

mysql> desc OwnersPropertyCount ;

-- 36
UPDATE Staff SET salary = salary * 1.03;

-- 37
UPDATE Staff SET salary = salary * 1.05 WHERE position = 'Manager';

-- 38
 UPDATE Staff SET position = 'Manager', salary = 18000 WHERE staffNo = 'SG14';

-- 39
DELETE FROM Viewing WHERE propertyNo = 'PG4';

-- 40. Delete all rows from the Viewing table.
DELETE FROM Viewing;