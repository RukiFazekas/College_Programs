/*********************************************************************************************************
Author:      Lucas Fazecas
Title:       Lab1: Design and create a table
Purpose:     1. To exam and analyze the real-world data;
             2. To create a data model;
             3. To create a table design chart;
             4. To create a single table using CREATE statement in SQL Server.
Date:  September 18, 2021
*********************************************************************************************************/

-- Use master db, delete database named 'lab1' if it exists, then create a new database of same name and use it

USE master;
GO
DROP DATABASE IF EXISTS lab1;
GO
CREATE DATABASE lab1;
GO

-- use 'lab1' db

USE lab1;
GO

-- create table 'athlete' according to table design chart

CREATE TABLE athlete(
	athleteId			INT IDENTITY (1, 1),
	athleteFirstName		VARCHAR(50) NOT NULL,
	athleteLastName			VARCHAR(50) NOT NULL,
	athleteBirthdate		DATE,
	athleteBirthCity		VARCHAR(50),
	athleteBirthState		VARCHAR(50),
	athleteBirthCountry		VARCHAR(50),
	athleteHeight			DECIMAL(3, 0) CHECK(athleteHeight > 0),
	athleteWeight			DECIMAL(3, 0) CHECK(athleteWeight > 0),
	athletePosition			CHAR(2) NOT NULL,
	athleteBattingAvg		DECIMAL(4, 3) CHECK(athleteBattingAvg >= 0.000 AND athleteBattingAvg <= 1.000),
	athleteIsActive			BIT NOT NULL DEFAULT 1,
	CONSTRAINT pk_athlete_athleteId PRIMARY KEY (athleteId)
);
GO
