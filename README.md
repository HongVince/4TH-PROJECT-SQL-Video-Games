# 4TH-PROJECT-SQL-Video-Games

    Dataset: https://www.kaggle.com/datasets/ulrikthygepedersen/video-games-sales/data?select=video_games_sales.csv 
    Years Covered: 1984-2021
    
## About

This project explores video game sales data to understand the market share for the different game publishers. Additionally, identifying the factors that make a game title successful will shed light onto the modern day gaming industry landscape. The two most influential factors in higher sales number are genre and developer. Like the retail industry, a brand's name has a big infulence on consumer mindset. The name of a developer can be compared to brand name.

## Key Points Mentioned Above

- The sales number by game title
- The most popular genre
- The highest profit by genre
- The highest profit by game series (GTA, the Elder Scrolls etc.)
- The profit by developer
- The number of games developed by a developer
- The number of games published by a publisher

## Purpose of This Project

## About Data

| Column Name  | Description | Data Type |
| ---------   | --------- | --------- |
| Name | Game title | NVARCHAR(50) |
| Sales_in_millions | The sales number in USD | FLOAT |
| Release | The release year of a title | NVARCHAR(50) |
| Genre | The genre of a particular title | NVARCHAR(50) |
| Developer | As the name suggests | NVARCHAR(50) |
| Publisher | As the name suggests | NVARCHAR(50) |

## Analysis List

### 1) Genre and Game Titles

Conducting analysis on the dataset of different genres and titles to gauge the trendiest genre, and which publisher produces the most.

### 2) Publishers and their Developers

Identifying the various developers associated with each publisher will shed light into the market share a particular publisher owns.

### 3) The Release Year

The release year of a title provides important insights such as when a genre gained popularity.

## Approaches Used

1) **Data Cleaning:** Involves the inspection of the dataset to ensure the data IS NOT NULL, or missing values.

       a) Developing a database
       b) Creating tables to import data ihto
   
2) **Engineering New Features:**

       a) Creating functions to extract the year and month of each title - since the date is not in a DATETIME format
       b) Creating Sub Queries to illustrate the total market share by publisher
       c) Creating various views to implement into Tableau for visualization and analysis

## Questions Answered

1) What are the most popular genres?

2) Which publisher owns the majority of the market share?

    2a) What is the market share of each publisher

3) What is the number of genres released each year?

4) What year has the most titles released?

5) How many games did each publisher release?

6) How many games were developed by each development team?

7) What is the profit of each publisher?

8) Which game title has the highest profit?

9) What is the profit for each genre?

## Observations

