-- Refer to the README file for analysis

USE PortfolioProject;


-- Section 1 - Exploratory Data
SELECT * FROM Games


	-- Dropping irrelevant column
ALTER TABLE Games
DROP COLUMN Series;


	-- Viewing sales numbers by title
SELECT "Name" AS Title, Sales_in_Millions, Genre 
FROM Games 
ORDER BY Genre


	-- Most popular genre
SELECT Genre, COUNT(Genre) AS Total 
FROM Games 
GROUP BY Genre 
ORDER BY Total DESC


	-- Most profit by genre 
SELECT Genre, SUM(Sales_in_Millions) AS Profit
FROM Games 
GROUP BY Genre 
ORDER BY Profit DESC


-- Most profit by game
SELECT  Name, Sales_in_Millions, Release
FROM Games
ORDER BY Sales_in_Millions DESC 


	-- Most popular genre 
SELECT Genre, COUNT(Genre) AS Total 
FROM Games 
GROUP BY Genre 
ORDER BY COUNT(Genre) DESC


	-- Profit by developer
SELECT Developer, SUM(Sales_in_Millions) AS Profit 
FROM Games 
GROUP BY Developer 
ORDER BY Profit DESC


	-- Number of games developed by developer
SELECT Developer, COUNT("Name") AS TotalGames 
FROM Games 
GROUP BY Developer 
ORDER BY COUNT("Name") DESC


	-- Number of games published by publisher
SELECT Publisher, COUNT("Name") AS TotalGames 
FROM Games 
GROUP BY Publisher 
ORDER BY COUNT("Name") DESC




-----------------------------------------------------------------------
-- Part 2 Using Functions to Explore Data 


-- Function to extract year
CREATE FUNCTION ExtractYear
(
	@input varchar(255)
)
RETURNS varchar(255)
AS 
BEGIN
	DECLARE @alphabetIndex INT = Patindex('%[^0-9]%', @input)
	BEGIN
		WHILE @alphabetIndex > 0
		BEGIN
			SET @input = Stuff(@input, @alphabetIndex, 1, '')
			SET @alphabetIndex = PATINDEX('%[^0-9]%', @input)
		END
	END
	RETURN @input
END


-- Function to extract alphabets
CREATE FUNCTION ExtractAlphabets
(
	@input varchar(255)
)
RETURNS varchar(255)
AS 
BEGIN
	DECLARE @alphabetIndex INT = Patindex('%[^a-zA-Z]%', @input)
	BEGIN
		WHILE @alphabetIndex > 0
		BEGIN
			SET @input = Stuff(@input, @alphabetIndex, 1, '')
			SET @alphabetIndex = PATINDEX('%[^a-zA-Z]%', @input)
		END
	END
	RETURN @input
END
 

 --Top 10 Genres 
SELECT TOP 10 COUNT(Genre) AS Total, Genre
FROM Games 
GROUP BY Genre 
ORDER BY Total DESC


	-- Real-Time Strategy Game Releases per Year
SELECT dbo.ExtractYear(Release) AS Year, COUNT(Genre) AS 'Real-Time Strategy Releases'
FROM Games
WHERE Genre = 'Real-time strategy'
GROUP BY dbo.ExtractYear(Release)
ORDER BY 'Real-Time Strategy Releases' DESC


	-- First-person shooter Game Releases per Year
SELECT dbo.ExtractYear(Release) AS Year, COUNT(Genre) AS 'First-person Shooter Releases'
FROM Games
WHERE Genre = 'First-person shooter'
GROUP BY dbo.ExtractYear(Release)
ORDER BY 'First-person Shooter Releases' DESC


	-- Action role-playing Game Releases per Year
SELECT dbo.ExtractYear(Release) AS Year, COUNT(Genre) AS 'Action role-playing Releases'
FROM Games
WHERE Genre = 'Action role-playing'
GROUP BY dbo.ExtractYear(Release)
ORDER BY 'Action role-playing Releases' DESC


	-- Construction and management simulation Game Releases per Year
SELECT dbo.ExtractYear(Release) AS Year, COUNT(Genre) AS 'Construction and management simulation Releases'
FROM Games
WHERE Genre = 'Construction and management simulation'
GROUP BY dbo.ExtractYear(Release)
ORDER BY 'Construction and management simulation Releases' DESC


	-- Role-playing game Releases per Year
SELECT dbo.ExtractYear(Release) AS Year, COUNT(Genre) AS 'Role-playing game Releases'
FROM Games
WHERE Genre = 'Role-playing game'
GROUP BY dbo.ExtractYear(Release)
ORDER BY 'Role-playing game Releases' DESC


-- Year with most Games Released
SELECT dbo.ExtractYear(Release) AS Year, COUNT(*) AS 'Games Released'
FROM Games
GROUP BY dbo.ExtractYear(Release)
ORDER BY 'Games Released' DESC


-- Publisher Profits by Year
-- Year Column Reference
	--7 = 2007, 
	--10 = 2010, 
	--88 = 1988 etc
SELECT  Publisher, Sales_in_Millions, dbo.ExtractYear(Release) AS Year
FROM Games
GROUP BY dbo.ExtractYear(Release), Sales_in_Millions, Publisher
ORDER BY Publisher ASC 