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

-- Top Competitors
SELECT s.hacker_id, h.name
FROM Submissions as s
    INNER JOIN Challenges as c
        ON s.challenge_id = c.challenge_id
    INNER JOIN Difficulty as d
        ON d.difficulty_level = c.difficulty_level
    INNER JOIN Hackers as h
        ON s.hacker_id = h.hacker_id
WHERE s.score = d.score
GROUP BY s.hacker_id, h.name
HAVING COUNT(DISTINCT(s.challenge_id)) > 1
ORDER BY COUNT(DISTINCT(s.challenge_id)) DESC, s.hacker_id;