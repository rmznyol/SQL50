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

-- Ollivander's Inventory
WITH cte AS (
SELECT w.id, wp.age,w.coins_needed, w.power, MIN(w.coins_needed) OVER(PARTITION BY wp.age, w.power) as min_coin
FROM WANDS as w
INNER JOIN Wands_Property as wp
ON w.code = wp.code AND wp.is_evil = 0
)
SELECT id, age, coins_needed, power
FROM cte
WHERE coins_needed = min_coin
ORDER BY power DESC, age DESC;


-- Challenges
WITH cte as
    (SELECT DISTINCT hacker_id,
    COUNT(hacker_id) OVER(PARTITION BY hacker_id) as cnt
    FROM Challenges)
,cte2 as
    (SELECT hacker_id, cnt, 
     COUNT(cnt) OVER(PARTITION BY cnt) as count_of_cnt 
     FROM cte)

SELECT h.hacker_id, h.name, cnt 
FROM cte2
INNER JOIN Hackers as h 
ON h.hacker_id = cte2.hacker_id
AND (count_of_cnt = 1 OR cnt = (SELECT MAX(cnt) from cte2))
ORDER BY cnt DESC, h.hacker_id;


-- Contest Leaderboard
SELECT h.hacker_id, h.name, SUM(t.max_score) as total_score
FROM 
    (
    SELECT hacker_id, challenge_id, max(score) as max_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
    ) as t
INNER JOIN Hackers as h
ON t.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
HAVING total_score > 0
ORDER BY SUM(t.max_score) DESC, h.hacker_id;