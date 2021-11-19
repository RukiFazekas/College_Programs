-- lab4, M:M
-- name: Lucas Fazecas
-- date: November 19, 2021


-- STEP 1: write sql statement to create new database lab4 below, delete it if exists

USE master;
GO
DROP DATABASE IF EXISTS lab4;
GO
CREATE DATABASE lab4;
GO

-- create team table using CREATE and INSERT statements
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

-- create athlete table using CREATE and INSERT statements
CREATE TABLE athlete(
	athleteId INT IDENTITY(1, 1),
	athleteFirstName VARCHAR(20) NOT NULL,
	athleteLastName VARCHAR(30) NOT NULL,
	athleteDateOfBirth DATE,
	athleteHeight SMALLINT,
	athleteWeight TINYINT,
	athletePosition CHAR(2) NOT NULL,
	athleteBattingAvg DECIMAL(4, 3) DEFAULT 0.000,
	athleteNationality VARCHAR(30),
	teamId INT NOT NULL,
	CONSTRAINT pk_athlete_athleteId PRIMARY KEY (athleteId),
	CONSTRAINT fk_athlete_team FOREIGN KEY (teamId) REFERENCES team (teamId)
);
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

-- create award table using CREATE and INSERT statements
CREATE TABLE award(
	awardId INT IDENTITY(1, 1),
	awardName VARCHAR(30) NOT NULL,
	awardSponsor VARCHAR(100),
	CONSTRAINT pk_award_awardId PRIMARY KEY (awardId)
);
INSERT INTO award
VALUES
	('Most Valuable Player', 'Baseball Writers Association of America'),
	('Gold Glove', 'Rawlings'),
	('Silver Slugger', 'Hillerich & Bradsby'),
	('Rookie of the Year', 'Baseball Writers Association of America');


-- STEP 2: execute ALL statements above


-- STEP 3: create winner table using CREATE statement below

CREATE TABLE winner(
	winnerId INT IDENTITY(1, 1),
	winnerYear SMALLINT NOT NULL,
	athleteId INT NOT NULL,
	awardId INT NOT NULL,
	CONSTRAINT pk_winner_winnerId PRIMARY KEY (winnerId),
	CONSTRAINT fk_winner_athlete FOREIGN KEY (athleteId) REFERENCES athlete (athleteId),
	CONSTRAINT fk_winner_award FOREIGN KEY (awardId) REFERENCES award (awardId)
);

-- STEP 4: populate winner table using INSERT INTO statements below

/* SELECT * FROM athlete
SELECT * FROM award */

INSERT INTO winner
VALUES             --count (should be 28)
	(2017, 14, 1), --1
	(2014, 14, 3), --2
	(2017, 14, 3), --3
	(2017, 13, 4), --4
	(2017, 13, 3), --5
	(2013, 11, 2), --6
	(2014, 11, 2), --7
	(2015, 11, 2), --8
	(2016, 11, 2), --9
	(2017, 11, 2), --10
	(2018, 11, 2), --11
	(2019, 11, 2), --12
	(2015, 11, 3), --13
	(2016, 11, 3), --14
	(2017, 11, 3), --15
	(2018, 11, 3), --16
	(2010, 15, 1), --17
	(2011, 15, 2), --18
	(2012, 12, 4), --19
	(2014, 9, 4), --20
	(2014, 9, 3), --21
	(2018, 9, 3), --22
	(2014, 12, 1), --23
	(2016, 12, 1), --24
	(2019, 12, 1), --25
	(2015, 10, 2), --26
	(2016, 10, 2), --27
	(2019, 10, 2); --28

-- STEP 5: execute the winner CREATE and INSERT INTO statements, which were created in STEPS 3 and 4.



-- STEP 6: compose SELECT statements below to answer the questions
-- preparation: create erd to familiarize with db tables

SELECT * FROM team;
SELECT * FROM athlete;
SELECT * FROM award;
SELECT * FROM winner;
SELECT *	-- 2 table joins
FROM team
	FULL OUTER JOIN athlete ON team.teamId = athlete.teamId;
SELECT *	-- 3 table joins
FROM team
	FULL OUTER JOIN athlete ON team.teamId = athlete.teamId
		FULL OUTER JOIN winner ON winner.athleteId = athlete.athleteId;
SELECT *	-- 4 table joins
FROM team
	FULL OUTER JOIN athlete ON team.teamId = athlete.teamId
		FULL OUTER JOIN winner ON winner.athleteId = athlete.athleteId
			FULL OUTER JOIN award ON winner.awardId = award.awardId;

--qry1.	For each award, show a list of award winners' names and the year in which they won.
--		Order the output by year from newest to oldest, and then by award name.

SELECT awardName, athleteFirstName, athleteLastName, winnerYear
FROM athlete a JOIN winner w ON a.athleteId = w.athleteId
	RIGHT JOIN award aw ON w.awardId = aw.awardId
ORDER BY winnerYear DESC, awardName;
GO

--qry2. How many times has an outfielder won the Silver Slugger award?

SELECT COUNT(*) AS "Number of OF Wins"
FROM athlete a JOIN winner w ON a.athleteId = w.athleteId
	JOIN award aw ON w.awardId = aw.awardId
WHERE athletePosition = 'OF' AND aw.awardId = 3;
GO

--qry3.	For each athlete, show how many awards he has won.  Include athletes who have not won any awards,
--		and ensure their total displays as zero (0).  Show each athlete's first and last name concatenated
--		with their position, as shown in the sample output.
--		Order the output by number of awards won, from most to least, and then by athlete's last name.

SELECT CONCAT(athleteLastName, ', ', athleteFirstName, ' (', athletePosition, ')') AS "Athlete", ISNULL(COUNT(awardName), 0) AS "Number of Awards Won"
FROM athlete a FULL JOIN winner w ON a.athleteId = w.athleteId
	FULL JOIN award aw ON w.awardId = aw.awardId
GROUP BY athleteFirstName, athleteLastName, athletePosition
ORDER BY ISNULL(COUNT(awardName), 0) DESC, athleteLastName;
GO

--qry4.	How many years has it been since Mike Trout won Rookie of the Year last time?

SELECT TOP 1 DATEDIFF(DAY, winnerYear, YEAR(GETDATE())) AS "Number of Years"
FROM athlete a1 JOIN winner w1 ON a1.athleteId = w1.athleteId
	JOIN award aw1 ON w1.awardId = aw1.awardId
WHERE winnerYear = (SELECT MAX(winnerYear)
					FROM athlete a2 JOIN winner w2 ON a2.athleteId = w2.athleteId
						JOIN award aw2 ON w2.awardId = aw2.awardId
						WHERE athleteFirstName = 'Mike' AND athleteLastName = 'Trout' AND awardName = 'Rookie of the Year');
GO

--qry5.	Which teams have won 4 or more awards among all its listed athletes?
--		Show the team's name, city, and manager, along with its total number of awards won.

SELECT teamName, teamCity, teamManager, ISNULL(COUNT(awardName), 0) AS "Number of Awards Won"
FROM team t
	FULL OUTER JOIN athlete a ON t.teamId = a.teamId
		FULL OUTER JOIN winner w ON w.athleteId = a.athleteId
			FULL OUTER JOIN award aw ON w.awardId = aw.awardId
GROUP BY teamName, teamCity, teamManager
HAVING ISNULL(COUNT(awardName), 0) >= 4;
GO