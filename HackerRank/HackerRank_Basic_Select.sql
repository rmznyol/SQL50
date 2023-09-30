-- Revising the Select Query I
SELECT *
FROM CITY
WHERE POPULATION > 100000
AND COUNTRYCODE = 'USA'

-- Revising the Select Query II
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000

-- Select by ID
SELECT *
FROM CITY
WHERE ID = 1661

-- Japanese Cities' Attributes
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN'

-- Japanese Cities' Names
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'JPN'

-- Weather Observation Station 1
SELECT CITY, STATE
FROM STATION

-- Weather Observation Station 3
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0

-- Weather Observation Station 4
SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION

-- Weather Observation Station 5
(SELECT CITY, LENGTH(CITY) as len
FROM STATION
ORDER BY len DESC, CITY ASC
LIMIT 1)
UNION 
(SELECT CITY, LENGTH(CITY) as len
FROM STATION
ORDER BY len ASC, CITY ASC
LIMIT 1)

-- Weather Observation Station 6
SELECT CITY
FROM STATION
WHERE LEFT(CITY,1) in ('a','e','i','o','u')

-- Weather Observation Station 7
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY,1) in ('a','e','i','o','u')

-- Weather Observation Station 8
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) in ('a','e','i','o','u') 
AND RIGHT(CITY,1) in ('a','e','i','o','u')

-- Weather Observation Station 9
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT IN ('a','e','i','o','u')

-- Weather Observation Station 10
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY,1) NOT IN ('a','e','i','o','u')

-- Weather Observation Station 11
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT in ('a','e','i','o','u') 
OR RIGHT(CITY,1) NOT in ('a','e','i','o','u')

-- Weather Observation Station 12
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT in ('a','e','i','o','u') 
AND RIGHT(CITY,1) NOT in ('a','e','i','o','u')

-- Higher Than 75 Marks
SELECT NAME 
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3), ID