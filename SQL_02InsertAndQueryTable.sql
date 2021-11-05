-- lab2, basic query
-- your name: Lucas Fazecas Bueno de Lima
-- today's date: October 4th, 2021


-- STEP 1: write sql statement to switch to database lab2

USE lab2;
GO

-- STEP 2: write sql statements to answer following questions:

--qry1.	Show the names of Canadian athletes.  Sort the result set by their last names in ascending order.

SELECT athleteFirstName, athleteLastName, athleteNationality
FROM athlete
WHERE athleteNationality = 'Canada'
ORDER BY athleteLastName
GO

--qry2.	Which athletes are older than 30 years old?  Order the output by athlete’s date of birth (oldest to youngest).
--		How to calculate age in sql server, source: https://www.wiseowl.co.uk/blog/s216/calculating_age_in_sql_server.htm

SELECT athleteFirstName, athleteLastName, athleteDateOfBirth, CAST(DATEDIFF(DD, athleteDateOfBirth, GETDATE()) / 365.25 AS INT) AS "AthleteAge"
FROM athlete
WHERE CAST(DATEDIFF(DD, athleteDateOfBirth, GETDATE()) / 365.25 AS INT) > 30
ORDER BY athleteDateOfBirth;
GO

--qry3.	Display the names and positions of athletes whose first names begin with “Jo”.

SELECT athleteFirstName, athleteLastName, athletePosition
FROM athlete
WHERE athleteFirstName LIKE 'jo%';
GO

--qry4.	How many athletes having Batting Averages between .250 and .300 do we have in the table?

SELECT COUNT(*) AS "NumOfBAs"
FROM athlete
WHERE athleteBattingAvg BETWEEN 0.250 AND 0.300;
GO

--qry5.	Show those athletes whose last names' first letters range from 't' to 'z' (inclusive).
--		Format the names with their Height and Weight as shown.
--		For example, “Trout: 188cm, 106kg”.  Order the output by athlete’s last name.

SELECT CONCAT(athleteLastName, ': ', athleteHeight, 'cm ', athleteWeight, 'kg') AS "Athlete Statistics"
FROM athlete
WHERE athleteLastName LIKE '[t-z]%'
ORDER BY athleteLastName;
GO

--qry6.	Output the Name and Position of the athlete who has the highest Batting Average.

SELECT TOP 1 athleteFirstName + ' ' + athleteLastName AS "Player Name", athletePosition
FROM athlete
ORDER BY athleteBattingAvg DESC;
GO

--qry7.	Show the highest, lowest, and average Batting Average among Outfielders. Round the average to 3 decimal places.

SELECT
	MAX(athleteBattingAvg) AS "Highest",
	MIN(athleteBattingAvg) AS "Lowest",
	CAST(ROUND(AVG(athleteBattingAvg), 3) AS DECIMAL(3, 3)) AS "Average"
FROM athlete
WHERE athletePosition LIKE 'OF';
GO

--4).	Compose INSERT statement(s) to add 3 new player records to the athlete table. 
--		You can look up some player information online (baseball-reference.com) or you can make some up.

INSERT INTO athlete
VALUES
	('Covelli', 'Crisp', '1979-11-01', 178, 83, 'CF', 0.265, 'USA'),
	('Russell', 'Kuntz', '1955-02-04', 190, 86, 'OF', 0.236, 'USA'),
	('Michael', 'Conforto', '1993-03-01', 185, 97, 'OF', 0.255, 'USA');
GO
	
--5).	Compose an UPDATE query to: change the first and last name of one of the players to your own name. 

UPDATE athlete
SET athleteFirstName = 'Lucas', athleteLastName = 'Fazecas'
WHERE athleteId = 1;
GO

--6).	Compose a DELETE query to: remove the last player, who has the highest athleteId number, in athlete table.

DELETE FROM athlete
WHERE athleteId = (SELECT MAX(athleteId) FROM athlete);
GO