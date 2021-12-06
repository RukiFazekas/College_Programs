-- lab5, 1:M recursive
-- name: Lucas Fazecas
-- date: December 1, 2021


-- STEP 1: write sql statement to create new database lab5 below, delete it if exists

USE master;
GO
DROP DATABASE IF EXISTS lab5;
GO
CREATE DATABASE lab5;
GO
USE lab5;
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
	CONSTRAINT fk_athlete_team FOREIGN KEY(teamId) REFERENCES team (teamId),
);
INSERT INTO athlete
	(athleteFirstName, athleteLastName, athleteDateOfBirth, athleteHeight, athleteWeight, athletePosition, athleteBattingAvg, athleteNationality, teamId)
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
	
-- create winner table using CREATE statement
CREATE TABLE winner(
	winnerId INT IDENTITY(1, 1),
	winnerYear INT NOT NULL,
	athleteId INT NOT NULL,
	awardId INT NOT NULL,
	CONSTRAINT pk_winner_winnerId PRIMARY KEY (winnerId),
	CONSTRAINT fk_winner_athlete FOREIGN KEY (athleteId) REFERENCES athlete (athleteId),
	CONSTRAINT fk_winner_award FOREIGN KEY (awardId) REFERENCES award (awardId)
);
-- populate winner table using INSERT statements
INSERT INTO winner
VALUES
	(2017, 14, 1),	--stanton, mvp
	(2014, 14, 3),	--stanton, ss
	(2017, 14, 3),	--stanton, ss
	(2017, 13, 4),	--judge, roy
	(2017, 13, 3),	--judge, ss
	(2013, 11, 2),	--arenado, gg
	(2014, 11, 2),	--arenado, gg
	(2015, 11, 2),	--arenado, gg
	(2016, 11, 2),	--arenado, gg
	(2017, 11, 2),	--arenado, gg
	(2018, 11, 2),	--arenado, gg
	(2019, 11, 2),	--arenado, gg
	(2015, 11, 3),	--arenado, ss
	(2016, 11, 3),	--arenado, ss
	(2017, 11, 3),	--arenado, ss
	(2018, 11, 3),	--arenado, ss
	(2010, 15, 1),	--votto, mvp
	(2011, 15, 2),	--votto, gg
	(2012, 12, 4),	--trout, roy
	(2014, 9, 4),	--abreu, roy
	(2014, 9, 3),	--abreu, ss
	(2018, 9, 3),	--abreu, ss
	(2014, 12, 1),	--trout, mvp
	(2016, 12, 1),	--trout, mvp
	(2019, 12, 1),	--trout, mvp
	(2015, 10, 2),	--kiermaier, gg
	(2016, 10, 2),	--kiermaier, gg
	(2019, 10, 2);	--kiermaier, gg

/*************************************************************************
-- STEP 2: execute ALL statements above BEFORE begining the lab questions
**************************************************************************/

-- STEP 3: for the athlete table, compose and execute ALTER statements below, to add votesForId column and foreign key constraint

ALTER TABLE athlete
ADD votesForId INT;
GO

ALTER TABLE athlete
ADD CONSTRAINT fk_athlete_athlete FOREIGN KEY (votesForId) REFERENCES athlete(athleteId);
GO

-- STEP 4: for the athlete table, compose and execute UPDATE statements below, to update votesForId column

UPDATE athlete SET votesForId = 15 WHERE athleteId = 5;
UPDATE athlete SET votesForId = 10 WHERE athleteId = 4;
UPDATE athlete SET votesForId = 12 WHERE athleteId = 2;
UPDATE athlete SET votesForId = 12 WHERE athleteId = 6;
UPDATE athlete SET votesForId = 12 WHERE athleteId = 8;
UPDATE athlete SET votesForId = 14 WHERE athleteId = 9;
UPDATE athlete SET votesForId = 14 WHERE athleteId = 13;
UPDATE athlete SET votesForId = 8 WHERE athleteId = 7;
UPDATE athlete SET votesForId = 2 WHERE athleteId = 1;
UPDATE athlete SET votesForId = 2 WHERE athleteId = 3;
UPDATE athlete SET votesForId = 11 WHERE athleteId = 10;
UPDATE athlete SET votesForId = 11 WHERE athleteId = 15;
GO

-- STEP 5: Compose sql statements below to answer the folloing questions

--qry1.	Display a list of athletes and the name of the person he voted for.  Order the athletes by voter's last name.

SELECT CONCAT(v.athleteFirstName, ' ', v.athleteLastName) AS "Voter", CONCAT(r.athleteFirstName, ' ', r.athleteLastName) AS "Recipient"
FROM athlete v LEFT JOIN athlete r ON v.votesForId = r.athleteId
ORDER BY v.athleteLastName;
GO

--qry2.	Which athletes did not receive any votes? Sort by athlete's first name, then last name.

SELECT CONCAT(r.athleteFirstName, ' ', r.athleteLastName) AS "Did Not Receive Votes"
FROM athlete v RIGHT JOIN athlete r ON v.votesForId = r.athleteId
WHERE v.athleteId IS NULL
ORDER BY r.athleteFirstName, r.athleteLastName;
GO

--qry3.	Show the total number of votes received per team, ordered by number of votes from most to least.

SELECT teamName AS "Team", COUNT(*) AS "Votes Received"
FROM athlete v JOIN athlete r ON v.votesForId = r.athleteId
	JOIN team ON r.teamId = team.teamId
GROUP BY teamName, r.teamId
ORDER BY COUNT(*) DESC;
GO

--qry4.	How many athletes voted for someone who plays the same position as himself?

SELECT COUNT(*) AS "Voted for Same Position"
FROM athlete v JOIN athlete r ON v.votesForId = r.athleteId
WHERE v.athletePosition = r.athletePosition;
GO

--qry5.	Repeat query 1), but when a player did not vote for anyone, it should display the message, "-Did Not Vote-".  

SELECT CONCAT(v.athleteFirstName, ' ', v.athleteLastName) AS "Voter", CONCAT(ISNULL(r.athleteFirstName, '-Did Not Vote-'), ' ', r.athleteLastName) AS "Recipient"
FROM athlete v LEFT JOIN athlete r ON v.votesForId = r.athleteId
ORDER BY v.athleteLastName;
GO
