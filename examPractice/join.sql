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