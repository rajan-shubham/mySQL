mysql -u readUser -p

SHOW GRANTS FOR 'root'@'localhost';

SELECT User, Host FROM mysql.user;

CREATE DATABASE testDB;

-- create users
CREATE USER 'adminUser'@'localhost' IDENTIFIED BY 'StrongPassword1!';
CREATE USER 'readUser'@'localhost' IDENTIFIED BY 'AnotherPassword2@';
CREATE USER 'writeUser'@'localhost' IDENTIFIED BY 'ThirdPassword3#';

GRANT ALL PRIVILEGES ON testDB.* TO 'adminUser'@'localhost';
GRANT SELECT ON testDB.* TO 'readUser'@'localhost';
GRANT INSERT, UPDATE, DELETE ON testDB.* TO 'writeUser'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'adminUser'@'localhost';
SHOW GRANTS FOR 'readUser'@'localhost';
SHOW GRANTS FOR 'writeUser'@'localhost';

INSERT INTO Branch (branchNo, street, city, postcode) VALUES ("B009", 'Jo
hn', 'Doe', 'HR');



-- Drop users
DROP USER 'adminUser'@'localhost';
DROP USER 'readUser'@'localhost';
DROP USER 'writeUser'@'localhost';
