-- Author: Lucas Fazecas
-- Date: December 8, 2021

-- Create a new database named finalProj. Delete the database if exists
USE master;
GO
DROP DATABASE IF EXISTS finalProj;
GO
CREATE DATABASE finalProj;
GO
USE finalProj;
GO

-- create trainer table using CREATE and INSERT statements
CREATE TABLE trainer(
	trainerId INT IDENTITY(1, 1),
	trainerName VARCHAR(50) NOT NULL,
	CONSTRAINT pk_trainer_trainerId PRIMARY KEY (trainerId)
);
INSERT INTO trainer
VALUES
	('Ash'),
	('Brock'),
	('Misty'),
	('Erika'),
	('Alain');

-- create pokemon table using CREATE and INSERT statements
CREATE TABLE pokemon(
	pokemonId INT IDENTITY(1, 1),
	pokemonDexNumber CHAR(3) NOT NULL,
	pokemonName VARCHAR(50) NOT NULL,
	pokemonHeight SMALLINT CHECK(pokemonHeight >= 0 AND pokemonHeight <= 1000),
	pokemonWeight DECIMAL(6,2) CHECK(pokemonWeight >= 0.00 AND pokemonWeight <= 1000.00),
	pokemonColor VARCHAR(20),
	pokemonType VARCHAR(15) DEFAULT 'Grass',
	trainerId INT NOT NULL,
	evolvedFrom INT,
	CONSTRAINT pk_pokemon_pokemonId PRIMARY KEY (pokemonId),
	CONSTRAINT fk_pokemon_trainer FOREIGN KEY(trainerId) REFERENCES trainer (trainerId),
	CONSTRAINT fk_pokemon_pokemon FOREIGN KEY(evolvedFrom) REFERENCES pokemon (pokemonId),
);

INSERT INTO pokemon
VALUES
	('025', 'Pikachu', 53, 9.00, 'Yellow', 'Electric', 1, NULL),
	('722', 'Rowlet', 42, 4.00, 'Brown', 'Grass', 1, NULL),
	('745', 'Lycanroc', 91, 27.50, 'Gray', 'Rock', 1, 4),
	('744', 'Rockruff', 63, 11.70, 'Brown', 'Rock', 1, NULL),
	('726', 'Torracat', 83, 27.50, 'Red', 'Fire', 1, NULL),
	('470', 'Leafeon', 111, 28.00, 'Green', 'Grass', 1, 14),
	('074', 'Geodude', 53, 22.50, 'Gray', 'Rock', 2, NULL),
	('095', 'Onix', 891, 212.50, 'Gray', 'Rock', 2, NULL),
	('111', 'Rhyhorn', 111, 117.50, 'Gray', 'Ground', 2, NULL),
	('044', 'Gloom', 91, 11.10, 'Brown', 'Grass', 2, NULL),
	('182', 'Bellossom', 53, 8.30, 'Green', 'Grass', 2, 10),
	('196',  'Espeon', 101, 29.00, 'Purple', 'Psychic', 2, 14),
	('197', 'Umbreon', 111, 29.50, 'Black', 'Dark', 2, 14),
	('133', 'Eevee', 42, 9.00, 'Brown', 'Normal', 3, NULL),
	('135', 'Jolteon', 96, 27.00, 'Yellow', 'Electric', 3, 14),
	('136', 'Flareon', 96, 27.50, 'Orange', 'Fire', 3, 14),
	('120', 'Staryu', 91, 37.00, 'Brown', 'Water', 3, NULL),
	('121', 'Starmie', 121, 82.50, 'Silver', 'Water', 3, 17),
	('134', 'Vaporeon', 111, 31.50, 'Blue', 'Water', 3, 14),
	('114', 'Tangela', 111, 37.50, 'Blue', 'Grass', 4, NULL),
	('045', 'Vileplume', 131, 21.10, 'Pink', 'Grass', 4, 10),
	('189', 'Jumpluff', 91, 5.50, 'Purple', 'Grass', 4, NULL),
	('005', 'Charmeleon', 121, 21.50, 'Red', 'Fire', 5, NULL),
	('006', 'Charizard', 182, 93.00, 'Orange', 'Fire', 5, 23),
	('376', 'Metagross', 172, 552.50, 'Gray', 'Steel', 5, NULL),
	('248', 'Tyranitar', 213, 204.50, 'Green', 'Rock', 5, NULL),
	('461', 'Weavile', 121, 36.50, 'Purple', 'Dark', 5, NULL);

-- create battle table using CREATE and INSERT statements
CREATE TABLE battle(
	battleId INT IDENTITY(1, 1),
	battleName VARCHAR(50) NOT NULL,
	CONSTRAINT pk_battle_battleId PRIMARY KEY (battleId)
);

INSERT INTO battle
VALUES
	('Team Battle'),
	('Full Battle'),
	('Rotation Battle'),
	('Sky Battle'),
	('Battle Royal'),
	('Double Battle');

-- create battleLocation table using CREATE and INSERT statements
CREATE TABLE battleLocation(
	battleLocationId INT IDENTITY(1, 1),
	battleLocationName VARCHAR(50) NOT NULL,
	CONSTRAINT pk_battleLocation_battleLocationId PRIMARY KEY (battleLocationId)
);

INSERT INTO battleLocation
VALUES
	('Summer Camp'),
	('Mt. Silver'),
	('Driftveil City'),
	('Azure Bay'),
	('Battle Royal Dome'),
	('Pokemon Colosseum');

-- create record table using CREATE and INSERT statements
CREATE TABLE record(
	recordId INT IDENTITY(1, 1),
	pokemonId INT NOT NULL,
	battleId INT NOT NULL,
	battleLocationId INT NOT NULL,
	recordExpPoint INT CHECK(recordExpPoint >= 0 AND recordExpPoint <= 1000000000)
	CONSTRAINT pk_record_recordId PRIMARY KEY (recordId),
	CONSTRAINT fk_record_pokemon FOREIGN KEY(pokemonId) REFERENCES pokemon (pokemonId),
	CONSTRAINT fk_record_battle FOREIGN KEY(battleId) REFERENCES battle (battleId),
	CONSTRAINT fk_record_battleLocation FOREIGN KEY(battleLocationId) REFERENCES battleLocation (battleLocationId),
	CONSTRAINT uq_record UNIQUE (pokemonId, battleId, battleLocationId)
);

INSERT INTO record
VALUES
	(1, 1, 1, 66),
	(1, 2, 2, 91),
	(1, 3, 3, 51),
	(2, 4, 4, 81),
	(3, 1, 1, 111),
	(3, 5, 5, 96),
	(5, 5, 5, 51),
	(5, 2, 2, 116),
	(5, 5, 6, 96),
	(7, 1, 1, 91),
	(7, 5, 5, 51),
	(8, 3, 3, 96),
	(8, 1, 1, 66),
	(8, 5, 6, 96),
	(9, 5, 6, 61),
	(9, 1, 1, 81),
	(17, 3, 3, 81),
	(18, 5, 6, 46),
	(18, 1, 1, 91),
	(20, 2, 2, 46),
	(20, 3, 3, 71),
	(20, 1, 1, 61),
	(21, 1, 1, 61),
	(22, 4, 4, 56),
	(22, 5, 6, 71),
	(22, 5, 5, 56),
	(24, 2, 2, 71),
	(24, 5, 5, 51),
	(24, 1, 1, 86),
	(24, 4, 4, 86),
	(25, 1, 1, 101),
	(25, 5, 5, 96),
	(25, 5, 6, 76),
	(26, 2, 2, 116),
	(26, 5, 5, 86),
	(27, 2, 2, 106),
	(27, 1, 1, 96);

/* 1) Output all green pokemon and its type, and the names and locations of the battles in which it has participated.
	  Order the output by pokemon name, then by battle name. Include pokemon who haven't battled in your output - display 'None' when there is no battle data. */


SELECT pokemonName AS "Pokemon Name", pokemonType AS "Pokemon Type", ISNULL(battleName, 'None') AS "Battle Name", ISNULL(battleLocationName, 'None') AS "Battle Location"
FROM pokemon p FULL JOIN record r ON p.pokemonId =r.pokemonId
	FULL JOIN battle b ON r.battleId = b.battleId
	FULL JOIN battleLocation bL ON r.battleLocationId = bL.battleLocationId
GROUP BY pokemonName, pokemonColor, pokemonType, battleName, battleLocationName
HAVING pokemonColor = 'Green'
ORDER BY pokemonName, battleName;
GO


/* 2) For each original pokemon, show all the pokemon that evolve from it. Order the output by original name, and then by evolved name. */


SELECT CONCAT(o.pokemonName, ':', ' ', o.pokemonWeight, 'kg') AS "Base Pokemon", CONCAT(e.pokemonName, ':', ' ', e.pokemonWeight, 'kg') AS "Evolved into ..."
FROM pokemon o JOIN pokemon e ON o.pokemonId = e.evolvedFrom
ORDER BY o.pokemonName, e.pokemonName;
GO


/* 3) How many evolved pokemon does each trainer own? Display the trainer's name, along with their number of evolved pokemon. Order the output by trainer's name. */


SELECT trainerName, COUNT(*) AS "Number of Evolved Pokemon Owned"
FROM pokemon o JOIN pokemon e ON o.pokemonId = e.evolvedFrom
	JOIN trainer t ON e.trainerId = t.trainerId
GROUP BY trainerName
ORDER BY trainerName;
GO


/* 4) Which pokemon evolve into another pokemon with the same type? Concatenate the pokemon names and colors in the output as shown and display their type too.
	  Order the result by the evolved pokemon type. */


SELECT CONCAT(o1.pokemonName, ' ', '(', o1.pokemonColor, ')') AS "Base Pokemon", CONCAT(e1.pokemonName, ' ', '(', e1.pokemonColor, ')') AS "Evolved into", e1.pokemonType AS "Pokemon Type"
FROM pokemon o1 JOIN pokemon e1 ON o1.pokemonId = e1.evolvedFrom
WHERE o1.pokemonType = (SELECT e2.pokemonType
						FROM pokemon o2 JOIN pokemon e2 ON o2.pokemonId = e2.evolvedFrom
						GROUP BY e2.pokemonType
						HAVING e1.pokemontype = e2.pokemonType)
ORDER BY e1.pokemonType;
GO


/* 5) Who is the tallest evolved pokemon for each type, what is its height, and from which pokemon does it evolve?
	  Display the result by evolved pokemon height from the highest to shortest. */


SELECT e1.pokemonName AS "Pokemon Name", CONCAT(e1.pokemonHeight, ' ', 'cm') AS "Height", e1.pokemonType AS "Type", o1.pokemonName AS "Evolved From"
FROM pokemon o1 JOIN pokemon e1 ON o1.pokemonId = e1.evolvedFrom
WHERE e1.pokemonHeight = (SELECT MAX(e2.pokemonHeight)
							FROM pokemon o2 JOIN pokemon e2 ON o2.pokemonId = e2.evolvedFrom
							GROUP BY e2.pokemonType
							HAVING e1.pokemonType = e2.pokemonType)
ORDER BY e1.pokemonHeight DESC;
GO