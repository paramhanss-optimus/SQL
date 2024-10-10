-- 4 tables created as per the schema

use [TutorialDB]

Create Table Species (
       SpeciesID int primary key,
	   CommonName varchar(50),
	   ScientificName varchar(50),
	   Habitat char(10),
	   Venomous bit);

go 

Create table Snakes(
      SnakeID int primary key,
	  SpeciesID int,
	  Lenth float,
	  Age int,
	  Color char(10),
	  Foreign key (SpeciesID) references Species(SpeciesID),
	  );

go 

Create table Sightings(
     SightingID int primary key,
	 SnakeID int,
	 Loction varchar(50),
	 SightingDate date,
	 Observer char(10),
	 Foreign key (SnakeID) references Snakes(SnakeID),
	);
Go 

Create table ConservationStatus(
   StatusID int primary key,
   SpeciesID int,
   Staus varchar(50),
   LastUpdated date
   );

 go 


Insert Into Species values
      (1, 'King Cobra', 'Ophiophagus hannah', 'Forest', 1),
	  (2, 'Bald Eagle', 'Haliaeetus', 'Mountains', 0),
	  (3, 'Great White Shark', 'Carcharodon', 'Ocean', 0),
	  (4, 'Komodo Dragon', 'Varanus', 'Island', 0);
go 


Insert Into Snakes values 
      (1, 1, 5.5, 2, 'Green'),
      (2, 1, 4.2, 3, 'Brown'),
	  (3, 2, 1.8, 1, 'White'),
	  (4, 3, 6.0, 5, 'Grey'),
	  (5, 4, 2.5, 4, 'Black');      

go 


Insert Into Sightings values
		(1, 1, 'Amazon Rainforest', '2024-01-15', 'Alice'),
		(2, 2, 'Sahara Desert', '2024-02-20', 'Bob'),
		(3, 3, 'Great Barrier Reef', '2024-03-10', 'Charlie'),
		(4, 4, 'Komodo Island', '2024-04-05', 'Dave'),
		(5, 5, 'Urban Park', '2024-05-25', 'Eve')  

go 


Insert Into ConservationStatus values
		(1, 1, 'Endangered', '2024-01-01'),
		(2, 2, 'Least Concern', '2024-02-01'),
		(3, 3, 'Vulnerable', '2024-03-01'),
		(4, 4, 'Near Threatened', '2024-04-01'),
		(5, 5, 'Critically Endangered', '2024-05-01');

go 


Insert Into ConservationStatus values
		(6, 1, 'Least Concern', '1970-01-01'),
		(7, 2, 'Least Concern', '1980-02-01'),
		(8, 3, 'Least Concern', '1990-03-01'),
		(9, 4, 'Vulnerable', '1970-04-01'),
		(10, 5, 'Endangered', '1985-05-01');

go 


Insert Into Snakes values 
	  (6, 1, 4.8, 3, 'Brown'),
	  (7, 1, 4.6, 3, 'Brown'),
	  (8, 1, 5.1, 3, 'Brown'),
	  (9, 2, 4.2, 3, 'Brown'),
	  (10, 2, 3.2, 3, 'Brown'),
	  (11, 2, 4.8, 3, 'Brown'),
	  (12, 2, 5.2, 3, 'Brown'),
	  (13, 3, 4.2, 3, 'Brown'),
	  (14, 3, 4, 3, 'Brown'),
	  (15, 3, 5.2, 3, 'Brown'),
	  (16, 3, 3.2, 3, 'Brown'),
	  (17, 4, 4.2, 3, 'Brown'),
	  (18, 4, 4, 3, 'Brown'),
	  (19, 4, 5.2, 3, 'Brown'),
	  (20, 4, 3.2, 3, 'Brown');
go 
          

-- test run the select commands 

Select * from Species;
Select * from Snakes;
Select * from ConservationStatus;
Select * from Sightings;

go 


-- 1st ques 

SELECT s.SightingID, s.Loction, s.SightingDate, s.Observer
FROM Sightings s
JOIN Snakes as sk ON s.SnakeID = sk.SnakeID
JOIN Species as sp ON sk.SpeciesID = sp.SpeciesID
WHERE sp.CommonName = 'King Cobra';

go


-- 2nd ques

Select SpeciesID, AVG(Lenth) as [Average Length] from Snakes
       Group By SpeciesID;

go 


-- 3rd Ques 

WITH RankedSnakes AS (
    SELECT 
        sn.SnakeID,
        sn.SpeciesID,
        sn.Lenth,
     
        ROW_NUMBER() OVER (PARTITION BY sn.SpeciesID ORDER BY sn.Lenth DESC) AS Rank
    FROM 
        Snakes sn
    )

SELECT 
    SpeciesID,
    SnakeID,
    Lenth
FROM 
    RankedSnakes
WHERE 
    Rank <= 5
ORDER BY 
    SpeciesID, Rank;
go 


-- 4th ques 

Insert Into Sightings values
		(6, 1, 'Amazon', '2024-02-15', 'Alice'),
		(7, 1, 'Rainforest', '2024-03-15', 'Alice'),
		(8, 2, 'Desert', '2024-02-25', 'Bob');
go 

Select Top 1 Observer, SpeciesID, Count(Observer) as  [Highest Visited] from  Sightings as si
      Join Snakes as sn On si.SnakeID = sn.SnakeID
      Group By Observer, SpeciesID
	  Order by [Highest Visited] Desc;

go


-- 5th ques 

--- Trigger Function 


--CREATE TRIGGER update_status
--ON ConservationStatus
--AFTER UPDATE
--AS
--BEGIN
--    DECLARE @CurrentDate DATE;
--    SET @CurrentDate = GETDATE();

--    UPDATE ConservationStatus
--    SET LastUpdated = @CurrentDate
--    WHERE StatusID IN (SELECT StatusID FROM inserted);
--END;
--GO

--Update ConservationStatus Set Staus = 'Endangered' where StatusID = 2;

Select sp.CommonName, cs.SpeciesID, cs.LastUpdated, cs.staus from  ConservationStatus as cs 
    join Species as sp on sp.SpeciesID = cs.SpeciesID
    Order By cs.SpeciesID, cs.LastUpdated;
go



-- 6th question 

Select sn.SpeciesID from Snakes as sn
    Join Sightings as si On sn.SnakeID = si.SnakeID
	Join ConservationStatus as cs On cs.SpeciesID = sn.SpeciesID
	where cs.Staus = 'Endangered' and sn.SnakeID in (select snakeID from Snakes where (select count (SnakeID) from Sightings) > 10) ;
go 
