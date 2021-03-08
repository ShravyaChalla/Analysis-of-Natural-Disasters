CREATE DATABASE Disaster;

USE Disaster;

CREATE TABLE dbo.Student (StuID VARCHAR (5) PRIMARY KEY
						,Name VARCHAR (20)	
						,Age INT	
						,SAddress VARCHAR (200)
						,GPA DECIMAL (2,1)
);

CREATE TABLE dbo.DisasterData (
	DeclarationNumber VARCHAR (15)
	,DeclarationType VARCHAR (10)
	,DeclarationDate DATE
	,State CHAR(2)
	,County VARCHAR(50)
	,DisasterType VARCHAR(50)
	,DisasterTitle VARCHAR(255)
	,StartDate DATE
	,EndDate DATE
	,ClosDate DATE
	,IndividualAssistanceProgram VARCHAR(3)
	,IndividualsAndHouseholdsProgram VARCHAR(3)
	,PublicAssistanceProgram VARCHAR(3)
	,HazardMitigationProgram VARCHAR(3));

ALTER TABLE dbo.DisasterData ALTER COLUMN County VARCHAR(255);

INSERT INTO dbo.DisasterData SELECT * FROM dbo.Import_Disaster;

SELECT TOP (200) * FROM dbo.DisasterData;

SELECT * FROM dbo.DisasterData WHERE HazardMitigationProgram is NULL;

SELECT * FROM dbo.DisasterData;
SELECT DISTINCT DeclarationNumber FROM dbo.DisasterData;

/*
A few statistics
*/

/*
Total number of rows
*/
SELECT COUNT(*) FROM dbo.DisasterData;

/*
Unique declaration types
*/
SELECT DISTINCT DeclarationType FROM dbo.DisasterData;

/*
States in which declarations were issued
*/
SELECT DISTINCT State FROM dbo.DisasterData;

/*
Statistics on Duration of the disaster
*/
SELECT DATEDIFF(DAY, EndDate, StartDate) AS Duration FROM dbo.DisasterData;

SELECT MIN(DATEDIFF(DAY, EndDate, startDate)) AS MinDuration,
	MAX(DATEDIFF(DAY, EndDate, StartDate)) AS MaxDuration, AVG(DATEDIFF(DAY, EndDate, StartDate)) AS AvgDuration FROM dbo.DisasterData;


/*
Select number of declaration entries each year
*/
SELECT DATEPART(YEAR, DeclarationDate) AS year, COUNT(*) AS NumRecords FROM dbo.DisasterData 
	GROUP BY DATEPART(YEAR, DeclarationDate)
	ORDER BY NumRecords DESC;

/*
select number of records where Individual assistance is provided for each disaster type
*/
SELECT DisasterType, COUNT(*) AS NumRecords FROM dbo.DisasterData
	WHERE IndividualAssistanceProgram = 'Yes' 
	GROUP BY DisasterType
	ORDER BY NumRecords DESC;

