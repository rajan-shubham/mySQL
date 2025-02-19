select user ,host from mysql.user;

show processlist;

create database company;

use company;

create table employee (
    eno INT PRIMARY KEY,
    ename VARCHAR(50) NOT NULL,
    address TEXT
    );

insert into employee values (1, 'ram', 'delhi'), (2, 'varun', 'chd'), (3, 'ravi', 'chd'), (4, 'amrit',
 'delhi');

select * from employee;

CREATE TABLE department (
    deptno VARCHAR(10) PRIMARY KEY,  -- Department number (Primary Key)
    dname VARCHAR(100) NOT NULL,  -- Department name
    eno INT,  -- Employee number (Foreign Key)
    FOREIGN KEY (eno) REFERENCES employee(eno)  -- Establishing foreign key relationship with employee table
    );

insert into department values ('d1', 'HR',1), ('d2', 'IT', 2), ('d3', 'MRKT', 4);

select * from department;

-- NATURAL JOIN
-- find the emp names who is working in a department
select ename from employee, department where employee.eno = department.eno;
select * from employee, department where employee.eno = department.eno;
select ename from employee natural join department;
select * from employee natural join department;

-- SELF JOIN
-- find student id who is enrolled in at least two courses
-- study table below
-- sId  cId  since
-- s1   c1   2016
-- s2   c2   2017
-- s1   c2   2017
select t1.sId from study as t1, study as t2 where t1.sId = t2.sId and t1.cId <> t2.cId


-- EQUI JOIN
-- find the emp name who worked in a department having location same as their address ?
-- emp table, dept table
-- eno ename address     deptno location eno
-- 1   ram   delhi       d1     delhi    1
-- 2   varun chd         d2     Pune     2
-- 3   ravi  chd         d3     patna    4
-- 4   amrit delhi       
select ename from emp, dept where emp.eno = dept.eno and emp.address = dept.location


-- LEFT OUTER JOIN
-- it gives the matching rows and the rows which are in left table but not in right table
-- emp table, dept table
select eno, ename, dname, location from emp LEFT OUTER JOIN dept ON (emp.deptno = dept.deptno);


-- RIGHT OUTER JOIN
-- it gives the matching rows and the rows which are in right table but not in the left table
-- emp table, dept table
select eno, ename, dname, location from emp RIGHT OUTER JOIN dept ON (emp.deptno = dept.deptno);