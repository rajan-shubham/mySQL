-- newStudent
-- +--------+---------+-------+-------+--------+
-- | rollno | name    | marks | grade | city   |
-- +--------+---------+-------+-------+--------+
-- |    101 | anil    |    78 | C     | Pune   |
-- |    102 | bhumika |    93 | A     | Mumbai |
-- |    103 | chetan  |    85 | B     | Mumbai |
-- |    104 | dhruv   |    96 | A     | Delhi  |
-- |    105 | emanuel |    12 | F     | Delhi  |
-- |    106 | farah   |    82 | B     | Delhi  |
-- +--------+---------+-------+-------+--------+

create table course ( courseId VARCHAR(10), courseName VARCHAR(20), RollNo int references newStudent(rollno) );

insert into course values ('c1', 'DBMS', 101), ('c2', 'Networks', 102), ('c3', 'OOPs', 103);
insert into course values ('c4', 'FLAT', 103), ('c4', 'FLAT', 102);

-- give rollno of that student who has enrolled in two courses
SELECT RollNo FROM course GROUP BY RollNo HAVING COUNT(RollNo) = 2;
-- +--------+
-- | RollNo |
-- +--------+
-- |    102 |
-- |    103 |
-- +--------+

-- give all name of college from newStudent table
select name from newStudent;
-- +---------+
-- | name    |
-- +---------+
-- | anil    |
-- | bhumika |
-- | chetan  |
-- | dhruv   |
-- | emanuel |
-- | farah   |
-- +---------+

-- give name of student who has taken atleast one course
select name from newStudent, course where newStudent.rollno = course.RollNo;
-- +---------+
-- | name    |
-- +---------+
-- | anil    |
-- | bhumika |
-- | bhumika |
-- | chetan  |
-- | chetan  |
-- +---------+

-- give name of student/s who has taken 2 course
select name from newStudent where rollno in (SELECT RollNo FROM course GROUP BY RollNo HAVING COUNT(RollNo) = 2);
-- +---------+
-- | name    |
-- +---------+
-- | bhumika |
-- | chetan  |
-- +---------+