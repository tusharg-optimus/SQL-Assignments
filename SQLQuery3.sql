use optimus;

-----------------------------
--one to one relationship

select * from employee;

select * from department;

CREATE TABLE OFFICE
(
 o_id int NOT NULL identity(1,1) PRIMARY KEY,
 o_name varchar(255),
 o_salary int not null
 );

 CREATE TABLE officedepartment
(
 d_id int NOT NULL identity(1,1) PRIMARY KEY,
 d_name varchar(255),
 depart_id int
 FOREIGN KEY(depart_id) REFERENCES OFFICE(o_id) unique
 )

 insert into OFFICE
 (o_name,o_salary)
 VALUES
 ('TUSHAR','20000'),
 ('RAHUL','40000'),
 ('DEEPAK','10000');

 select * from OFFICE;

  insert into officedepartment
 (d_name,depart_id)
 VALUES
 ('TUSHAR','1'),
 ('RAHUL','2'),
 ('DEEPAK','3');

 select * from officedepartment;

 select o_name,depart_id
 from OFFICE
 JOIN officedepartment
 ON OFFICE.o_id = officedepartment.depart_id;

 ----------------------------------------------
 --ONE to Many Relationship

 CREATE TABLE father
(
 f_id int NOT NULL identity(1,1) PRIMARY KEY,
 f_name varchar(255),
 f_age int not null
 );

 insert into father
 (f_name,f_age)
 VALUES 
 ('RAJENDER','50'),
 ('RAHUL','60'),
 ('TUSHAR','40');

 select * from father;

 CREATE TABLE kid
(
 k_id int NOT NULL identity(1,1) PRIMARY KEY,
 k_name varchar(255),
 ki_id int FOREIGN KEY(ki_id) REFERENCES father(f_id)
 );

 

insert into kid
 (k_name,ki_id)
 VALUES 
 ('NITIN','1'),
 ('BHARAT','2'),
 ('SUPRIYA','3');

 select * from father;

 select * from kid;

 SELECT f_name AS FATHER, k_name AS SON
 from father
 JOIN kid
 ON father.f_id = kid.ki_id;


 ------------------------------------------

 --MANY TO MANY RELATIONSHIP

 CREATE TABLE STUDENT
 (
 s_id int not null identity(1,1) PRIMARY KEY,
 s_name varchar(255),
 s_age int not null
 );

 CREATE TABLE BOOKS
 (
 b_id int not null identity(1,1) PRIMARY KEY,
 b_name varchar(255),
 b_credit int not null
 );

 CREATE TABLE STUDY
 (
 s_id int FOREIGN KEY(s_id) REFERENCES STUDENT(s_id),
 b_id int FOREIGN KEY(b_id) REFERENCES BOOKS(b_id)
 PRIMARY KEY(s_id,b_id)  ---COMPOSITE KEY
 );

 insert into STUDENT
 (s_name,s_age)
 Values 
 ('A','20'),
 ('B','30'),
 ('C','22'),
 ('A','25');

  insert into BOOKS
 (b_name,b_credit)
 Values 
 ('HINDI','20'),
 ('MATHS','30'),
 ('PHYSICS','22'),
 ('ENGLISH','25');

  insert into STUDY
 (s_id,b_id)
 Values 
 ('1','2'),
 ('2','3'),
 ('1','1'),
 ('2','4');

 select * from STUDENT;
 select * from BOOKS;
 select * from STUDY;

 select * from STUDENT;


 -----------------------------------------
 --INDEXING

execute sp_helpindex employee;  ---To see all index in a table
-------------------------------------
---CLUSTERED INDEX

create table college
(
c_id int NOT NULL PRIMARY KEY,
c_name varchar(255)
);

execute sp_helpindex college;

insert into college
(c_id,c_name)
values 
('6','TUSHAR'),
('2','Rahul'),
('1','NITIN'),
('3','PRIYA');

select * from college;

CREATE NONCLUSTERED INDEX index_name
 ON college (c_name DESC);

-----------------------------------
---STORED PROCEDURE
-------------------------------
--creation of stored procedure

CREATE PROCEDURE [dbo].[first_pro]
as
begin
select * from college
end 
go

exec [dbo].[first_pro] --To see the result of procedure

---Using one parameter

alter PROCEDURE [dbo].[first_pro]
@c_name varchar(255)
as
begin
select c_name from college where c_id=@c_name
end 
go

exec [dbo].[first_pro] 'Tushar'  ---giving the respective value at runtime
----------------------------------
--adding an another attribute to college table using stored procedure
alter PROCEDURE [dbo].[first_pro]
as
begin
alter table college add l_age int
end 
go

exec [dbo].[first_pro]

select * from college;

-----------------------------------
--update age attribute in college table using stored procedure
alter PROCEDURE [dbo].[first_pro]
@c_id int
as
begin
update college set l_age= '46' from college where c_id=@c_id
end 
go
exec [dbo].[first_pro] '2'

select * from college;
-----------------------------------
--Example of two parameters
alter procedure [dbo].[first_pro]
@c_id int,
@l_age int
as
begin
select * from college where c_id=@c_id AND l_age=@l_age
end
go

exec [dbo].[first_pro] '2','46';

---------------------------------------------------
--TRIGGERS
select * from employee;

CREATE TRIGGER total_salary
before INSERT
ON employee
FOR EACH ROW
set new.salary = new.salary+1000;

---------------------------------
---CASE STATEMENTS
select * from employee;

SELECT *,
CASE 
 WHEN salary>20000 THEN 'The salary is greater the 20000'
 WHEN salary<20000 THEN 'The salary is equal then 20000'
 ELSE 'The salary is less then 20000'
END AS salarytext
FROM employee;

--------------------------
--NESTED CASE STATEMENT

SELECT * ,
CASE 
   WHEN salary<30000 THEN 
     CASE 
	    WHEN designation = 'SET' THEN 'YES'
    end
   ELSE 'NO'
END AS "e_m"
FROM employee;
--------------------------------------------
--USING CAST()
select CAST(25.6 AS int);
select CAST(e_id AS varchar(10) ) AS temp FROM employee;

select * from employee;

-------------------------------------
--EXCEPTION HANDLING
CREATE PROCEDURE PRO 
@ID int
AS 
BEGIN
    BEGIN TRY
     select @ID/0;
     END TRY
      BEGIN CATCH
        SELECT @@ERROR AS 'ERROR'
        SELECT ERROR_LINE() AS 'ERROR LINE'
	    SELECT ERROR_NUMBER() AS 'ERROR NUMBER'
	    SELECT ERROR_MESSAGE() AS 'ERROR MESSAGE'
	    SELECT ERROR_PROCEDURE() AS 'ERROR PRO'
	    SELECT ERROR_STATE() AS  'ERROR STATE'
END CATCH
END 
GO
EXEC PRO;

CREATE PROCEDURE PRO1 
@ID int
AS 
BEGIN
    BEGIN TRY
     select @ID/0;
     END TRY
      BEGIN CATCH
        SELECT @@ERROR AS 'ERROR'
        SELECT ERROR_LINE() AS 'ERROR LINE'
	    SELECT ERROR_NUMBER() AS 'ERROR NUMBER'
	    SELECT ERROR_MESSAGE() AS 'ERROR MESSAGE'
	    SELECT ERROR_PROCEDURE() AS 'ERROR PRO'
	    SELECT ERROR_STATE() AS  'ERROR STATE'
END CATCH
END 
GO
EXEC PRO1 5;
---------------------------------------------
--USER DEFINED FUNTIONS

CREATE FUNCTION optimus.fun (@VAL INT)
RETURNS INT
AS
BEGIN 
 RETURN @VAL+100
END

SELECT optimus.fun(1000);
