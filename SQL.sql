use optimus;

CREATE TABLE employee (
e_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
e_name varchar(255),
designation varchar(255),
salary int not null);

insert into employee(e_name,designation,salary) Values ('TUSHAR', 'SET','20000');
insert into employee(e_name,designation,salary) Values ('RAHUL', 'TRAINEE ','30000');
insert into employee(e_name,designation,salary) Values ('NITIN', 'SOFTWARE ENGINEER','30000');

select * from employee;

CREATE TABLE department (
d_id int not null identity(1,1) PRIMARY KEY,
d_name varchar(255),
dm_id int,
FOREIGN KEY(dm_id) REFERENCES employee(e_id)); 

insert into department(d_name,dm_id) Values ('IT', '1');
select * from department;
insert into department(d_name,dm_id) Values ('IT', '2');
insert into department(d_name,dm_id) Values ('ACCOUNTS', '1');
insert into department(d_name,dm_id) Values ('HR', '3');
insert into department(d_name,dm_id) Values ('HR', '4');

select * from employee;
select * from department;

select employee.e_name,employee.designation,department.d_name
from employee
JOIN department
ON employee.e_id = department.dm_id
GROUP BY e_name;

select e_name, MAX(salary) AS SALARY
from employee
GROUP BY e_name;
