-- databse commands 

Create database param;

Drop database param;

go 


-- Database is stoered with extension .bak
BACKUP DATABASE testDB
TO DISK = 'D:\backups\testDB.bak'
WITH DIFFERENTIAL;
Go 

-- differential is to store only the changed files form last update
Go 



--Use of DDL commands in the SQL - Create + alter + drop + truncate + rename 
Create table customers ( 
    id Int Not null Primary key,
	name varchar(50),
	product_id int,
	);
Go 

--in alter we have modify +  add +  drop 
Alter table customers
  Add product_name varchar(50);

go 

  -- modify  ----> alter in the Sql server 
ALTER TABLE customers
    Alter COLUMN name char(100); 

go 

Alter table customers 
    drop column name;
go 


Drop Table customers;

Truncate Table customers;


-- rename ---> as stored procedure in the sql server 

EXEC sp_rename 'customers.name',  'employee_name', 'COLUMN';

go 





--Use of DML commands in SQL  -  Update +  Delete +  Insert 
Insert Into customers values 
      (1, 'Param', 50),
	  (2, 'Vaibhav', 55),
	  (3, 'Vishal', 120),
	  (4, 'Ansh', 40);
Go 

Update customers 
 set product_id = 150 
 where id = 3; 
go 

Delete from customers where id = 2; 
Go 


-- Use of DQL command  
Select * from customers;

Select name from customers;

--Use of spaces in the column name 
Select name as [Employee Name] from customers;

-- use of where clause in the SQL select command 
Select * from customers 
  where id > 2;
Go 


-- Intigrity constraints: Referential + Domain + Entity + Key : NOT NULL + PRIMARY KEY + UNIQUE + FOREIGN KEY + CHECK  + DEFAULT + CREATE INDEX


ALTER TABLE customers
  ADD UNIQUE (id);

  Go 

  --  Or Second Way 

ALTER TABLE customers
  ADD CONSTRAINT UC_Person UNIQUE (id);

go 


ALTER TABLE customers
    DROP CONSTRAINT UC_Person;
Go 


-- Foreign Key constraints 

CREATE TABLE CustOrder (
    OrderID int NOT NULL PRIMARY KEY,
    OrderNumber int NOT NULL,
    CONSTRAINT FK_PersonOrder FOREIGN KEY (OrderID)
    REFERENCES customers(id)
);
go

Alter table CustOrder
   ADD Constraint FK_Order Foreign Key (OrderID) References customers(id);
 Go 


ALTER TABLE CustOrder
   DROP CONSTRAINT FK_PersonOrder;
go 



