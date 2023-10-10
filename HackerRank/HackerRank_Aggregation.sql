-- Revising Aggregations - The Count Function
SELECT COUNT(NAME)
FROM CITY
WHERE POPULATION > 100000;

-- Revising Aggregations - The Sum Function
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

-- Averages
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

-- Average Population
SELECT ROUND(AVG(POPULATION))
FROM CITY;

-- Japan Population
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN';

-- Population Density Difference
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY;

-- The Blunder
SELECT CEIL(AVG(SALARY - CAST(REPLACE(CAST(SALARY AS CHAR(50)),'0', '') AS UNSIGNED)))
FROM EMPLOYEES;

-- Top Earners
SELECT MAX(salary*months), COUNT(*)
FROM employee
WHERE salary*months = (
SELECT MAX(salary*months)
From employee);