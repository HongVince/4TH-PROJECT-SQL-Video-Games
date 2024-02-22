-- Refer to the README file for analysis

USE PortfolioProject;

-- Functions, Sub Queries and Views


-- Part 1 Using Functions to Explore Data 
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
 

 	-- Number of games published by publisher
SELECT Publisher, COUNT("Name") AS TotalGames 
FROM Games 
GROUP BY Publisher 
ORDER BY COUNT("Name") DESC



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
SELECT  Publisher, Sales_in_Millions, dbo.ExtractYear(Release) AS Year, dbo.ExtractAlphabets(Release)
FROM Games
GROUP BY dbo.ExtractYear(Release), Sales_in_Millions, Publisher, dbo.ExtractAlphabets(Release)
ORDER BY Year ASC  
SELECT * FROM Games


-----------------------------------------------------------------------


-- Part 2 Sub Query - A Publisher's Market Share 
	

	-- 1a) Total Market Share
SELECT SUM(Sales_in_Millions) AS 'Total Sales in Millions' 
FROM Games


	-- 1b) Total Market Share by Publisher
SELECT Publisher, SUM(Sales_in_Millions) AS 'Total Sales in Millions' 
FROM Games
GROUP BY Publisher


	-- 1c)Percentage of Market Share by Publisher 
	-- Not Using the CAST() Function
SELECT Publisher, SUM(Sales_in_Millions) / (SELECT SUM(Sales_in_Millions) AS 'Market Share' FROM Games) * 100
AS 'Percentage of Market'
FROM Games
GROUP BY Publisher

-- top 10


	-- Using the CAST() Function
SELECT Publisher, CAST(SUM(Sales_in_Millions) / (SELECT SUM(Sales_in_Millions) AS 'Market Share' FROM Games) 
AS decimal(10,4)) * 100
AS 'Percentage of Market'
FROM Games
GROUP BY Publisher




SELECT Publisher, MAX(SUM(Sales_in_Millions) / (SELECT SUM(Sales_in_Millions) AS 'Market Share' FROM Games) * 100)
AS 'Percentage of Market'
FROM Games
GROUP BY Publisher
ORDER BY [Percentage of Market] DESC


-----------------------------------------------------------------------------


CREATE TABLE HighestSales
(Publisher NVARCHAR(255),
SalesInMillions NUMERIC
)
INSERT INTO HighestSales
SELECT Publisher, Sales_in_Millions AS Total
FROM Games
GROUP BY Sales_in_Millions, Publisher
ORDER BY Total ASC 

SELECT * FROM HighestSales



-----------------------------------------------------------------------


-- Part 3 Views  

-- 1) Percentage of Market Share by Publisher 
CREATE VIEW MarketShare AS 
SELECT Publisher, SUM(Sales_in_Millions) / (SELECT SUM(Sales_in_Millions) AS 'Market Share' FROM Games) * 100
AS 'Percentage of Market'
FROM Games
GROUP BY Publisher

-- 2) Number of games published 
CREATE VIEW PublisherTotal AS 
SELECT Publisher, COUNT("Name") AS TotalGames 
FROM Games 
GROUP BY Publisher 

-- 3) Number of games developed
CREATE VIEW DeveloperTotal AS
SELECT Developer, COUNT("Name") AS TotalGames 
FROM Games 
GROUP BY Developer 

-- 4) Sales by Title
CREATE VIEW SalesByTitle AS
SELECT "Name" AS Title, Sales_in_Millions, Genre 
FROM Games 

-- 5) Sales by Genre
CREATE VIEW SalesByGenre AS 
SELECT Genre, SUM(Sales_in_Millions) AS Profit
FROM Games 
GROUP BY Genre 

-- 6) Genre Produced the Most
CREATE VIEW GenreMostProduced AS
SELECT Genre, COUNT(Genre) AS Total 
FROM Games 
GROUP BY Genre 

-- 7) Profit by Publisher
CREATE VIEW PublisherProfit AS
SELECT Publisher, SUM(Sales_in_Millions) AS Profit 
FROM Games 
GROUP BY Publisher 


-- 8) TOP 10 Publishers in market Share

SELECT Publisher, TOP 10 SUM(Sales_in_Millions) / (SELECT SUM(Sales_in_Millions) AS 'Market Share' FROM Games) * 100
AS 'Percentage of Market'
FROM Games
GROUP BY Publisher