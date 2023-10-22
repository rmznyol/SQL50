-- SQL Project Planning (SOLVED IN ORACLE)
WITH cte AS (
    SELECT Start_Date, End_Date, (Start_Date - (SELECT MIN(Start_Date) FROM Projects)) 
    - ROW_NUMBER() OVER(ORDER BY Start_Date) as gps
    FROM Projects
    )
SELECT MIN(Start_Date), MAX(End_Date)
FROM cte
GROUP BY gps
ORDER BY COUNT(Start_Date), MIN(Start_Date);

-- Placements

-- SELECT pl.Salary ,sl.name, sl.id,f.id,f.Friend_ID, sr.id, sr.name, pr.Salary,
SELECT sl.name
FROM Students as sl
INNER JOIN Friends as f 
ON f.id = sl.id
INNER JOIN packages as pl
ON f.id =pl.id
INNER JOIN Students as sr
ON f.Friend_ID = sr.id
INNER JOIN packages as pr
ON f.Friend_ID = pr.id
WHERE pr.salary > pl.salary
ORDER BY pr.salary;