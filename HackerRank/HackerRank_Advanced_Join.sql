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