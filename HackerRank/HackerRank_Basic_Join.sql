-- Population Census
SELECT SUM(CITY.POPULATION)
FROM CITY
INNER JOIN COUNTRY
ON CITY.CountryCode = COUNTRY.Code
WHERE COUNTRY.CONTINENT = 'Asia';

-- African Cities
SELECT CITY.NAME
FROM CITY
INNER JOIN COUNTRY
ON CITY.CountryCode = COUNTRY.code
WHERE COUNTRY.CONTINENT = 'Africa';

-- Average Population of Each Continent
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population))
FROM CITY 
INNER JOIN COUNTRY
ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent; 

-- The Report
SELECT CASE WHEN Students.marks < 70 THEN NULL ELSE Students.Name END as name, Grades.grade, Students.Marks
FROM Students
INNER JOIN Grades
ON Grades.Min_Mark <= Students.Marks AND Students.Marks <= Grades.Max_Mark
ORDER BY Grades.grade DESC, Students.Name, Students.Marks;