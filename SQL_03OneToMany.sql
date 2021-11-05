-- lab3, 1:M
-- name: Lucas Fazecas
-- date: November 4th, 2021


-- STEP 1: write sql statement to create new database lab3 below, delete it if exists
USE master
GO
DROP DATABASE IF EXISTS lab3;
GO
CREATE DATABASE lab3;
GO
USE lab3;
GO

CREATE TABLE team(
	teamId INT IDENTITY(1, 1),
	teamName VARCHAR(50) NOT NULL,
	teamCity VARCHAR(20) NOT NULL,
	teamState CHAR(2),
	teamCountry VARCHAR(6),
	teamManager VARCHAR(50),
	teamLeague CHAR(2) NOT NULL,
	teamStadium VARCHAR(30),
	CONSTRAINT pk_team_teamId PRIMARY KEY (teamId)
);
INSERT INTO team
VALUES
	('Toronto Blue Jays', 'Toronto', 'ON', 'Canada', 'Charlie Montoyo', 'AL', 'Rogers Centre'),
	('Chicago White Sox', 'Chicago', 'IL', 'USA', 'Rick Renteria', 'AL', 'Guaranteed Rate Field'),
	('Tampa Bay Rays', 'Tampa Bay', 'FL', 'USA', 'Kevin Cash', 'AL', 'Tropicana Field'),
	('Colorado Rockies', 'Denver', 'CO', 'USA', 'Bud Black', 'NL', 'Coors Field'),
	('Los Angeles Angels', 'Anaheim', 'CA', 'USA', 'Joe Maddon', 'AL', 'Angel Stadium of Anaheim'),
	('New York Yankees', 'New York', 'NY', 'USA', 'Aaron Boone', 'AL', 'Yankee Stadium'),
	('Pittsburgh Pirates', 'Pittsburgh', 'PA', 'USA', 'Derek Shelton', 'NL', 'PNC Park'),
	('Cincinnati Reds', 'Cincinnati', 'OH', 'USA', 'David Bell', 'NL', 'Great American Ball Park');
GO

-- STEP 2: execute ALL statements above

-- STEP 3: modify athlete CREATE TABLE statement below
CREATE TABLE athlete(
	athleteId INT IDENTITY(1, 1),
	athleteFirstName VARCHAR(50) NOT NULL,
	athleteLastName VARCHAR(50) NOT NULL,
	athleteDateOfBirth DATE,
	athleteHeight SMALLINT,
	athleteWeight TINYINT,
	athletePosition CHAR(2) NOT NULL,
	athleteBattingAvg DECIMAL(4, 3) DEFAULT 0.000,
	athleteNationality VARCHAR(50),
	teamId INT NOT NULL,
	CONSTRAINT pk_athlete_athleteId PRIMARY KEY (athleteId),
	CONSTRAINT fk_athlete_team FOREIGN KEY (teamId) REFERENCES team (teamId)
);


-- SELECT * FROM team
-- STEP 4: modify the athlete INSERT INTO statement below
INSERT INTO athlete
VALUES
	('Vladimir', 'Guererro Jr.', '1999-03-16', 188, 113, '3B', 0.272, 'Canada', 1),
	('Bo', 'Bichette', '1998-03-05', 183, 83, 'SS', 0.311, 'USA', 1),
	('Cavan', 'Biggio', '1995-04-11', 188, 90, '2B', 0.234, 'USA', 1),
	('Travis', 'Shaw', '1990-04-16', 193, 104, '1B', 0.157, 'USA', 1),
	('Danny', 'Jansen', '1995-04-15', 188, 104, 'C', 0.207, 'USA', 1),
	('Randal', 'Grichuk', '1991-08-13', 188, 96, 'OF', 0.232, 'USA', 1),
	('Teoscar', 'Hernandez', '1992-10-15', 188, 92, 'OF', 0.230, 'Dominican Republic', 1),
	('Tim', 'Anderson', '1993-06-23', 185, 83, 'SS', 0.335, 'USA', 2),
	('Jose', 'Abreu', '1987-01-29', 190, 115, '1B', 0.284, 'Cuba', 2),
	('Kevin', 'Kiermaier', '1990-04-22', 185, 95, 'OF', 0.228, 'USA', 3),
	('Nolan', 'Arenado', '1991-04-16', 188, 97, '3B', 0.315, 'USA', 4),
	('Mike', 'Trout', '1991-08-07', 188, 106, 'OF', 0.291, 'USA', 5),
	('Aaron', 'Judge', '1992-04-26', 201, 127, 'OF', 0.272, 'USA', 6),
	('Giancarlo', 'Stanton', '1989-11-08', 198, 111, 'OF', 0.288, 'USA', 6),
	('Joey', 'Votto', '1983-09-10', 188, 99, '1B', 0.261, 'Canada', 8);

-- STEP 5: execute the athlete CREATE and INSERT INTO statements, which were modified in STEPS 3 and 4.

-- STEP 6: compose sql statements to answer the following questions

/* SELECT * FROM team
SELECT * FROM athlete
SELECT * FROM team t FULL JOIN athlete a ON t.teamId = a.teamId */

--qry1.	For each team, display the team name, manager, and how
--		many athletes the team has. Order the results by team name.

SELECT teamName, teamManager, COUNT(athleteId) AS 'Number of Athletes'
FROM team t LEFT JOIN athlete a ON t.teamId = a.teamId
GROUP BY teamName, teamManager
ORDER BY teamName;
GO

--qry2.	Which teams have an average athlete age under 30?
--		Display the team name, city, and average athlete age.

SELECT teamName, teamCity, AVG(CAST(DATEDIFF(DAY, athleteDateOfBirth, GETDATE()) / 365.2422 AS INT)) AS "Avg Age"
FROM team t JOIN athlete a ON t.teamId = a.teamId
GROUP BY teamName, teamCity
HAVING AVG(CAST(DATEDIFF(DAY, athleteDateOfBirth, GETDATE()) / 365.2422 AS INT)) < 30;
GO

--qry3.	Which teams have more than one outfielder on their roster?

SELECT teamName, COUNT(*) AS "Num of Outfielders"
FROM team t JOIN athlete a ON t.teamId = a.teamId
WHERE athletePosition = 'OF'
GROUP BY teamName
HAVING COUNT(*) > 1;
GO

--qry4.	Which team has the youngest athlete, and what is that
--		athlete’s name?

SELECT teamName, athleteFirstName, athleteLastName
FROM team t JOIN athlete a ON t.teamId = a.teamId
WHERE athleteDateOfBirth = (SELECT MAX(athleteDateOfBirth)
							FROM athlete);
GO

--qry5.	What is the batting average of the athletes for each team?
--		Display each team name, and its team batting average.
--		Format the batting average to three decimal places.

SELECT teamName, CAST(AVG(athleteBattingAvg) AS DECIMAL(4, 3)) AS "Team Batting Average"
FROM team t JOIN athlete a ON t.teamId = a.teamId
GROUP BY teamName
GO

--qry6.	Display a list of athletes who were born in a different country
--		than that which their team is based.
--		(For example, a Canadian athlete who plays for a team based in USA.)
--		Put the country names in the output also.

SELECT CONCAT(athleteFirstName, ' ', athleteLastName) AS "Player Name", athleteNationality AS "Birth Country", teamCountry AS "Team Country"
FROM team t JOIN athlete a ON t.teamId = a.teamId
WHERE athleteNationality <> teamCountry;
GO

--qry7.	Who is the best batter (highest batting average) in each league?
--		Display the league, athlete’s name, and their batting average.    

SELECT teamLeague, athleteFirstName, athleteLastName, athleteBattingAvg
FROM team t1 JOIN athlete a1 ON t1.teamId = a1.teamId
WHERE athleteBattingAvg = (SELECT MAX(athleteBattingAvg)
							FROM team t2 JOIN athlete a2 ON t2.teamId = a2.teamId
							WHERE t1.teamLeague = t2.teamLeague);
GO