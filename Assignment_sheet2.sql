CREATE DATABASE PRACTICE2;

USE PRACTICE2;

CREATE TABLE t_emp(
Emp_id int identity(1001,2) NOT NULL PRIMARY KEY,
Emp_Code NVARCHAR(50) NOT NULL,
Emp_fname varchar(255) NOT NULL,
Emp_mname varchar(255),
Emp_lname varchar(255),
Emp_DOB date,
Emp_DOJ date NOT NULL);

insert into t_emp(Emp_Code,Emp_fname,Emp_mname,Emp_lname,Emp_DOB,Emp_DOJ)
VALUES
('OPT20100915','Alfred','Joseph','Lawrence','1998-02-28','2010-05-26');

select * from t_emp;

CREATE TABLE t_activity(
Activity_id int NOT NULL PRIMARY KEY,
Activity_description varchar(255));

insert into t_activity(Activity_id,Activity_description)
VALUES
('1','Code Analysis'),
('2','Lunch'),
('3','Coding'),
('4','Knowledge Transition'),
('5','Database');

select * from t_activity;

CREATE TABLE t_atten_det(
Atten_id int identity(1001,1) NOT NULL,
Emp_id int FOREIGN KEY(Emp_id) REFERENCES t_emp(Emp_id),
Activity_id int FOREIGN KEY(Activity_id) REFERENCES t_activity(Activity_id),
Atten_start_datetime datetime,
Atten_end_hrs int);

insert into t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs)
VALUES
('1001','5','2011/02/13 10:25:33','2'),
('1001','1','2011/03/13 10:25:33','3'),
('1001','3','2011/04/13 11:25:33','5'),
('1003','5','2011/06/13 09:25:33','8'),
('1003','5','2012/07/13 10:25:33','8'),
('1003','5','2014/02/13 05:25:33','7');


select * from t_atten_det;

------------------------
--1 QUERY	

SELECT CONCAT(t_emp.Emp_fname,' ',t_emp.Emp_mname,' ', t_emp.Emp_lname ) AS NAME, t_emp.Emp_DOB AS DATE_OF_BIRTH 
from t_emp
where Datediff(dd,Emp_DOB,DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,Emp_DOB)+1,0)))=0;

SELECT CONCAT(t_emp.Emp_fname,' ',t_emp.Emp_mname,' ', t_emp.Emp_lname ) AS NAME, t_emp.Emp_DOB AS DATE_OF_BIRTH 
from t_emp
where   EOMONTH(Emp_DOB)=0;

CREATE TABLE t_salary(
Salary_id int,
Emp_id int FOREIGN KEY(Emp_id) REFERENCES t_emp(Emp_id),
Changed_date date,
New_salary int,
);

ALTER TABLE t_salary
Add previous_salary int;

insert into t_salary(Salary_id,Emp_id,Changed_date,New_salary)
VALUES
('1001','1003','2011/06/02','20000'),
('1002','1003','2011/08/01','4000'),
('1003','1001','2011/07/04','6000');


select * from t_salary;

--------------------
--2 QUERY

select DISTINCT CONCAT(t_emp.Emp_fname,' ',t_emp.Emp_mname,' ', t_emp.Emp_lname ) AS Employee_NAME,
CASE 
  WHEN t_emp.Emp_id = t_salary.Emp_id THEN 'YES'
  ELSE 'NO'
 END AS GOT_INCREMENT
 ,t_salary.previous_salary AS PREVIOUS_SALARY,t_salary.New_salary AS CURRENT_SALARY, t_atten_det.Atten_end_hrs AS TOTAL_WORKED_HOURS,CONCAT (t_activity.Activity_description,' ',t_atten_det.Atten_end_hrs,'hrs') AS LAST_WORKED_ACTIVITY
from t_emp
JOIN t_atten_det
ON t_emp.Emp_id = t_atten_det.Emp_id
JOIN t_activity
ON t_activity.Activity_id = t_atten_det.Activity_id
JOIN t_salary
ON t_salary.Emp_id = t_emp.Emp_id
ORDER BY t_salary.New_salary DESC;


