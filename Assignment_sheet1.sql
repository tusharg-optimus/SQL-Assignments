CREATE DATABASE PRACTICE1;
use PRACTICE1;


CREATE TABLE t_product_master(
Product_ID NVARCHAR(50) not null PRIMARY KEY,
Product_Name varchar(255),
Cost_Per_Item int);

insert into t_product_master(Product_ID, Product_Name, Cost_Per_Item)
Values
('P1','Pen','10'),
('P2','Scale','15'),
('P3','Note book','25');

select * from t_product_master;

CREATE TABLE t_user_master(
User_ID NVARCHAR(50) not null PRIMARY KEY,
User_Name varchar(255)
);

insert into t_user_master(User_ID, User_Name)
Values
('U1','Alfred Lawrence'),
('U2','William Paul'),
('U3','Edward Fillip');

CREATE TABLE t_transaction(
User_ID NVARCHAR(50) FOREIGN KEY(User_ID) REFERENCES t_user_master(User_ID), 
Product_ID NVARCHAR(50) FOREIGN KEY(Product_ID) REFERENCES t_product_master(Product_ID),
Transaction_Date date,
Transaction_Type varchar(255),
Transaction_Amount INT,
);

insert into t_transaction(User_ID, Product_ID,Transaction_Date,Transaction_Type,Transaction_Amount)
Values
('U1','P1','2010/10/25','Order','150'),
('U1','P1','2010/11/20','Payment','750'),
('U1','P1','2010/11/20','Order','200'),
('U1','P3','2010/11/25','Order','50'),
('U3','P2','2010/11/26','Order','100'),
('U2','P1','2010/12/15','Order','75'),
('U3','P2','2011/11/15','Payment','250');

--select CONVERT(Transaction_Date,101) from t_transaction;

select * from t_transaction;

--------------------------------------------------
--FINAL QUERY
select t_user_master.User_Name, t_product_master.Product_Name,
CASE
  WHEN t_transaction.Transaction_Type = 'Order' THEN t_transaction.Transaction_Amount/t_product_master.Cost_Per_Item
  ELSE NULL
END AS Order_Quantity,
t_transaction.Transaction_Amount AS Amount_paid,t_transaction.Transaction_Date AS Last_Transaction_Date,
CASE 
   WHEN t_transaction.Transaction_Type = 'Order' THEN t_transaction.Transaction_Amount
   ELSE 0
   END AS BALANCE
from t_product_master
JOIN t_transaction
ON t_product_master.Product_ID = t_transaction.Product_ID
JOIN t_user_master
ON t_user_master.User_ID = t_transaction.User_ID
ORDER BY t_transaction.Transaction_Date DESC;









  






