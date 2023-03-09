CREATE database myhome_db;

USE myhome_db;

-- PART A
-- creating table for supervisor
CREATE table supervisor(supe_id int,
 supe_name varchar(50) NOT NULL, 
 supe_email varchar(50) NOT NULL,
 CONSTRAINT PK_supervisor PRIMARY KEY(supe_id));

-- creating table for employees
CREATE table employee(emp_id int,
emp_name varchar(50) NOT NULL,
emp_email varchar(50) NOT NULL,
emp_role varchar(50) NOT NULL,
supe_id int NOT NULL
area_id int NOT NULL,
CONSTRAINT PK_employee PRIMARY KEY(emp_id),
CONSTRAINT FK_employee FOREIGN KEY(supe_id)
REFERENCES supervisor(supe_id)); -- linking employees to supervisor

-- creating table for geolocation areas
CREATE table area(area_id int,
location varchar(50) NOT NULL,
emp_id int NOT NULL,
CONSTRAINT PK_area PRIMARY KEY(area_id),
CONSTRAINT FK_area FOREIGN KEY(emp_id)
REFERENCES employee(emp_id)); -- linking area to chief employees

-- creating table for properties
CREATE table property(prop_id int,
prop_type varchar(50) NOT NULL,
area_id int NOT NULL,
CONSTRAINT PK_property PRIMARY KEY(prop_id),
CONSTRAINT FK_property FOREIGN KEY(area_id)
REFERENCES area(area_id)); -- linking property to area

-- creating table for customer
CREATE table customer(cust_id int,
cust_name varchar(50) NOT NULL,
cust_email varchar(50) NOT NULL,
emp_id int NOT NULL,
area_id int NOT NULL,
CONSTRAINT PK_customer PRIMARY KEY(cust_id),
CONSTRAINT FK_customer FOREIGN KEY(emp_id)
REFERENCES employee(emp_id),
CONSTRAINT FK_customerArea FOREIGN KEY(area_id)
REFERENCES area(area_id)); 

-- PART B
-- inserting data into supervisor
INSERT into supervisor VALUES(1, 'Tatyenna Wijdan', 'twijdan@gmail.com'),
(2, 'Iosac Nelson', 'inelson@gmail.com'),
(3, 'Eren Jaegar', 'ejaegar@gmail.com');

-- inserting data into employee
INSERT into employee VALUES(101, 'Hello Kitty', 'hkitty@gmail.com', 'Chief Representative', 1, 901),
(102, 'Misa Amane', 'mamane@gmail.com', 'Sales Representative', 1, 901),
(103, 'Lana Del Rey', 'ldelrey@gmail.com', 'Sales Representative', 1, 901),
(104, 'Levi Ackerman', 'lackerman@gmail.com', 'Chief Representative', 2, 902),
(105, 'Reiner Braun', 'rbraun@gmail.com', 'Sales Representative', 2, 902),
(106, 'Armin Artlet', 'aartlet@gmail.com', 'Sales Representative', 2, 902),
(107, 'Gojo Satoru', 'gsatoru@gmail.com', 'Chief Representative', 3, 903),
(108, 'Yuji Itadori', 'yitadori@gmail.com', 'Sales Representative', 3, 903),
(109, 'J Lo', 'jlo@gmail.com', 'Chief Representative', 1, 904),
(110, 'Vivienne Westwood', 'vwestwood@gmail.com','Chief Representative', 3, 905);

-- inserting data into areas
INSERT into area VALUES(901, 'Malaysia', 101),
(902, 'Thailand', 104),
(903, 'Vietnam', 107),
(904, 'Cambodia', 109),
(905, 'Indonesia', 110);

ALTER table employee ADD CONSTRAINT FK_employeeArea FOREIGN KEY(area_id)
REFERENCES area(area_id); -- adding area column to employee table to link employee and the areas that they cover

--inserting data into property
INSERT into property VALUES(801, 'Houses', 901),
(802, 'Apartments', 902),
(803, 'Bungalows', 903),
(804, 'Land', 904),
(805, 'Commercial Property', 905);

-- inserting data into customer
INSERT into customer VALUES(201, 'Brad Pitt', 'bpitt@gmail.com', 103, 901),
(202, 'Light Yagami', 'lyagami@gmail.com', 102, 901),
(203, 'Evan Peters', 'epeters@gmail.com', 103, 901),
(204, 'Ryuk', 'ryuk@gmail.com', 102, 901),
(205, 'Britney Spears', 'bspears@gmail.com', 104, 902),
(206, 'Panda Panda', 'ppanda@gmail.com', 108, 903),
(207, 'Makima San', 'msan@gmail.com', 107, 903);

-- PART B i)
SELECT e.emp_name, e.emp_email, s.supe_name, s.supe_email, p.prop_type
FROM employee e INNER JOIN supervisor s ON s.supe_id = e.supe_id\
INNER JOIN property p ON e.area_id = p.area_id;

-- PART B ii)
SELECT c.cust_name, c.cust_email, a.location, e.emp_name, e.emp_email
FROM customer c INNER JOIN area a ON
c.area_id = a.area_id
INNER JOIN employee e ON e.emp_id = a.emp_id;