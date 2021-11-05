-- midterm exam v1
-- name: Lucas Fazecas
-- date: October 20th, 2021


--4	Compose CREATE statement to create a database below

USE master;
GO
DROP DATABASE IF EXISTS mExam;
GO
CREATE DATABASE mExam;
GO
USE mExam;
GO

--5	Write the CREATE statement to create the Pokémon table below

CREATE TABLE pokemon (
	pokemonId				INT IDENTITY (1, 1),
	pokemonDexNum			SMALLINT NOT NULL,
	pokemonName				VARCHAR(50) NOT NULL,
	pokemonType				VARCHAR(15) NOT NULL,
	pokemonHeightCm			SMALLINT,
	pokemonWeightKg			DECIMAL(6, 2),
	pokemonColour			VARCHAR(20),
	CONSTRAINT pk_pokemon_pokemonId PRIMARY KEY (pokemonId)
);
GO

-- SELECT * FROM pokemon

--6	Compose INSERT statement to populate the Pokémon table below

INSERT INTO pokemon
	(pokemonDexNum, pokemonName, pokemonType, pokemonHeightCm, pokemonWeightKg, pokemonColour)
VALUES
	(005, 'Charmeleon', 'Fire', 111, 21.00, 'Red'),
	(133, 'Eevee', 'Normal', 32, 8.50, 'Brown'),
	(025, 'Pikachu', 'Electric', 43, 8.50, 'Yellow'),
	(135, 'Jolteon', 'Electric', 86, 26.50, 'Yellow'),
	(136, 'Flareon', 'Fire', 86, 27.00, 'Orange');
GO

--7	Compose UPDATE statement below
--	UPDATE Charmeleon's weight information.
--	He has gained 0.25 kilograms since his last weigh-in.

UPDATE pokemon
SET pokemonWeightKg += 0.25
WHERE pokemonId = 1;
GO

--8	Compose SELECT statements to answer the following questions:
--qry1.	Display the names, dex numbers, and colors of Pokémon who DO NOT have the
--		pattern 'eon' anywhere in their name.  Concatenate the name and dex number
--		into one field along with the # symbol, as shown in the sample output.

SELECT CONCAT(pokemonName, ' #', FORMAT(pokemonDexNum, '000')) AS "Name and Number", pokemonColour
FROM pokemon
WHERE pokemonName NOT LIKE '%eon%';
GO

--qry2.	What is the name and Pokémon’s dex number of the tallest yellow Pokémon?

SELECT TOP 1 pokemonName, pokemonDexNum
FROM pokemon
WHERE pokemonHeightCm = (SELECT MAX(pokemonHeightCm) 
						 FROM pokemon
						 WHERE pokemonColour LIKE 'Yellow');
GO

--qry3.	What is the total weight of all electric Pokémon?

SELECT SUM(pokemonWeightKg) AS "Total Electric Weight"
FROM pokemon
WHERE pokemonType LIKE 'Electric';
GO

--qry4.	Display all details about Pokémon who are heavier than the average weight.
--		Order the output by weight from heaviest to lightest.

SELECT pokemonId, pokemonDexNum, pokemonName, pokemonType, pokemonHeightCm, pokemonWeightKg, pokemonColour
FROM pokemon
WHERE pokemonWeightKg > (SELECT AVG(pokemonWeightKg) 
						 FROM pokemon)
ORDER BY pokemonWeightKg DESC;
GO
