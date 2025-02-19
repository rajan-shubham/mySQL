use company;

create table student (
    id INT PRIMARY KEY,
    name VARCHAR(15),
    age INT
    );
    
SHOW TABLES;

insert into student values (101, 'shubham', 15), (102, 'ankur', 16), (103, 'anurag', 17);

select * from student;

alter table student add address varchar(30);

select * from student;

UPDATE student SET address = 'Patna' WHERE id = 101;
UPDATE student SET address = 'Delhi' WHERE id = 102;
UPDATE student SET address = 'Mumbai' WHERE id = 103;

select * from student;

alter table student add email varchar(50);

alter table student drop column email;

alter table student modify name varchar(20);

alter table student rename column id to sid;

update student set age = age + 2;