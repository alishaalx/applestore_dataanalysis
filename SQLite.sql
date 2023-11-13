CREATE TABLE applestore_description_combined AS

SELECT * FROM appleStore_description1

UNION ALL

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL 

SELECT * FROM appleStore_description4

--Exploratory Data Analysis
-- Checking the number of unique apps in both tables ApplesstoreAppleStore

Select COUNT(DISTINCT id) AS UniqueAppids
FROM AppleStore

Select COUNT(DISTINCT id) AS UniqueAppids
FROM applestore_description_combined

-- there are 7197 ids in bothe the tables and no data are missingAppleStore

-- Checking for missing values in key fields
-- Table : AppleStore
SELECT COUNT(*) AS missing_values
FROM AppleStore WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL
-- output:0, no missing values in Applestore table fields track_name, user_rating and prime_genre

-- Table: Applestore_description_combined
SELECT COUNT(*) AS missing_values
FROM applestore_description_combined WHERE app_desc IS NULL
-- Output: 0, no missing values in applestore_description_combined field app_descAppleStore

-- Finding domintant genre, finding the number of apps per genre

SELECT prime_genre, COUNT(*) AS totalnum_apps
FROM AppleStore
GROUP BY prime_genre ORDER BY totalnum_apps DESC

-- The Genre Games tops the chart followed by entertainment and education, surprisingly Photo&Video comes 4thAppleStore


-- An overview of apps ratings, taking min average nad maximum  rating from applestore tableAppleStore

SELECT MIN(user_rating) AS minimum_rating,
MAX(user_rating) AS maximum_rating,
AVG(user_rating) AS Average_rating FROM AppleStore

-- Output: minimum rating is 0, maximum rating is 5 and have an average rating of 3.52



-- Data Analysis

-- check wheather paid apps have higher rating than free apps

SELECT CASE
WHEN price>0 THEN 'PAID'
ELSE 'FREE'
END AS app_type,
AVG(user_rating) AS average_rating FROM AppleStore
GROUP BY app_type

--The free apps have an average rating of 3.37 where as paid apps have 3.72. so paid apps have slightly higher ratings.AppleStore

-- Determine if the apps supported more languages have higher ratings

SELECT CASE WHEN lang_num<10 THEN 'Less than 10 Languages'
when lang_num BETWEEN 10 AND 40 THEN '10-40 Languages'
ELSE 'Greater than 40 Langauges'
END AS language_number,
AVG(user_rating) AS Average_rating FROM AppleStore
GROUP BY language_number ORDER BY Average_Rating DESC

--Output: 10-40 langs have highest rating that 4.1 then greater than 40 has 3.78 less than 10 have 3.36
-- Hence less than 10 lang has lower ratings.

-- Check genres with low and high ratings 

SELECT prime_genre, AVG(user_rating) as average_rating
From AppleStore GROUP BY prime_genre 
ORDER BY average_rating ASC
LIMIT 5
-- Catalogues have the lowest rating oof 2.1 followed by finance and then book.
--Users are ot satisfied,Hence these areas need to be considered


SELECT prime_genre, AVG(user_rating) as average_rating
From AppleStore GROUP BY prime_genre 
ORDER BY average_rating DESC
LIMIT 5

-- Prductivity, Music , photo&video have highest ratings respectively.
-- Hence bringing more int this will be a better idea

-- Finding top rated apps for each genre

SELECT prime_genre,track_name,user_rating FROM
( SELECT prime_genre,track_name,user_rating,RANK()
 OVER (PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
 FROM AppleStore) AS temp_1 WHERE temp_1.rank=1

-- Hre we found top apps for each genre.
