-- Revising Aggregations - The Count Function
SELECT COUNT(NAME)
FROM CITY
WHERE POPULATION > 100000

-- Revising Aggregations - The Sum Function
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California'

-- Averages
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California'

-- Average Population
SELECT ROUND(AVG(POPULATION))
FROM CITY