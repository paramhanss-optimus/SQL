use [TutorialDB]

Create table product(
    id int not null primary key,
	name varchar(50) unique,
	cost_price int);
go

Insert into product values
   (1, 'Roti', 50),
   (2, 'Burger', 150),
   (3, 'Pizza', 140);
go 

Alter table product 
  Add type varchar(50);
go 

Update product set type = 'Fast food' where id ='3';

Update product set type = 'food' where id ='1' and name='Roti';

select * from product;
go 

-- use of order by 

select * from product 
   order by cost_price;
go 


select * from product 
  order by cost_price desc;
go 


-- use of group by and having clause 

select count(*) as [No of Types], type from product 
   group by type; 
go 

-- alias doesn't work in the aggregate function && only aggregate function conditions are there in having 
select type, AVG(cost_price) from product 
   group by type 
   having AVG(cost_price) > 40;
go 


select name from product 
   where name like 'r%';
go 

-- wildcards pattern 

-- 1. %	Represents zero or more characters
-- 2. _	Represents a single character
-- 3. []	Represents any single character within the brackets 
-- 4. ^	Represents any character not in the brackets 
-- 5. -	Represents any single character within the specified range 
-- 6. {}	Represents any escaped character



--- Joins types : Inner + Right +  Left + Cross + Self - Join +  Full Outer -  Union 
--- Join vs Union ( Set Operator) : Join works over columns but union works over rows.
-- join combines tables and union combines two or more select commands.


Create table product (
     ID int,
	 name varchar(50),
	 order_id int
	 );

Create table order (
     ID int,
	 cust_id int 
	 price int
	 );

Insert into product values 
    ( 1, 'burger', 50)
	(2, 'pizza', 102);

Insert into order values 
    ( 101,2, 5000),
	(102, 1, 6000);

Go 



ALTER TABLE person
    ADD CONSTRAINT PK_Person PRIMARY KEY (ID,lastname);

Go 


-- the all will give any of the records when the all values in quantity is 10

SELECT name 
FROM product
WHERE id = ALL (SELECT id FROM Order WHERE price = 10);
go 


-- the any will give all the records when any of the value in the quantity is 10
SELECT name
FROM product
WHERE ProductID = ANY (SELECT id from order WHERE price=1000);

go 


-- use of between and and 

SELECT * FROM product
WHERE price between 1000 and 2000;
go 


-- check constraint 
CREATE TABLE Persons (
    Age int,
    CHECK (Age>=18)
);


-- exists constraint don't take id = like any or all  it checks for the paticular condidtion only 
SELECT name
FROM product
WHERE EXISTS (SELECT id from order WHERE id = product.id  AND price>2000);


-- like constraint 
SELECT * FROM product
WHERE name like '%a';


-- into to copy the table structure give the where cond as 1 = 2
SELECT * INTO CustomersBackup2017
FROM Customers;

-- this will select top 3 rows from the table 
SELECT TOP 3 * FROM Customers;


-- used in oracle 
SELECT * FROM Customers
WHERE ROWNUM <= 3;



-- sql server functions 1. ascii 2. char(opposite of each other ) 
SELECT CHAR(65) AS CodeToCharacter;


-- concat of string 
SELECT CONCAT('SQL', ' is', ' fun!');

-- length of a string 
SELECT DATALENGTH('W3Schools.com');
-- len function counts leading zeroes but not trailing while datalength counts for both 

-- gives string from left first 3 
SELECT LEFT('SQL Tutorial', 3) AS ExtractString;

go 


-- left leading zeroes-revome 
SELECT LTRIM('     SQL Tutorial') AS LeftTrimmedString;

-- replace t to m 
SELECT REPLACE('SQL Tutorial', 'T', 'M');

-- soundex function vowels +  w y h are ignored rest all characters have unique value first letter is capital of both 
SELECT SOUNDEX('Smith'), SOUNDEX('Smythe'); 

-- substring values 
SELECT SUBSTRING('SQL Tutorial', 1, 3) AS ExtractString;

go 


--- stored procedures in sql  default syntax 

CREATE PROCEDURE procedure_name
AS
--sql_statement
GO;


--- execution of stored procedure 
EXEC procedure_name;

go 

CREATE PROCEDURE SelectAllCustomers @City nvarchar(30), @PostalCode nvarchar(10)
AS
SELECT * FROM Customers WHERE City = @City AND PostalCode = @PostalCode
GO;



-- Predefined stored procedures in SQL Server are pre-compiled SQL code that can be saved and reused12. 
--They are used for rules and policies, and can accept input parameters and return output parameters.

