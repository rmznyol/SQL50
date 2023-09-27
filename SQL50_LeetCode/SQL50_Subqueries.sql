-- 1978. Employees Whose Manager Left the Company

SELECT employee_id
FROM Employees
WHERE salary < 30000 and manager_id NOT IN (
    SELECT employee_id
    FROM Employees
)
ORDER BY employee_id;

-- 626. Exchange Seats

SELECT (CASE 
    WHEN id = (SELECT CASE WHEN MAX(id) % 2 = 1 THEN MAX(id) ELSE null END FROM Seat) THEN id
    WHEN id % 2 = 1 THEN id + 1 
    ELSE id - 1 END) AS id, student 
FROM Seat
ORDER BY id;

-- 1341. Movie Rating

(SELECT name as results
FROM MovieRating as mr
INNER JOIN Users as u
ON mr.user_id = u.user_id
GROUP BY mr.user_id
ORDER by COUNT(*) DESC, u.name
LIMIT 1 )

UNION ALL

(SELECT title as results
FROM MovieRating as mr
INNER JOIN Movies as m
ON mr.movie_id = m.movie_id
WHERE YEAR(mr.created_at) = 2020 AND MONTH(mr.created_at) = 2
GROUP BY mr.movie_id
ORDER BY AVG(mr.rating) DESC, m.title
LIMIT 1);

-- 1321. Restaurant Growth

SELECT c.visited_on,(
    SELECT SUM(amount)
    FROM Customer
    WHERE visited_on BETWEEN DATE_ADD(c.visited_on, INTERVAL -6 DAY) AND c.visited_on 
    ) as amount,
    (
    SELECT round(SUM(amount)/7,2)
    FROM Customer
    WHERE visited_on BETWEEN DATE_ADD(c.visited_on, INTERVAL -6 DAY) AND c.visited_on 
    ) as average_amount
FROM Customer as c
WHERE c.visited_on >= DATE_ADD((SELECT MIN(visited_on) FROM Customer), INTERVAL 6 DAY)
GROUP BY c.visited_on;
-- ORDER BY visited_on ASC;

-- 602. Friend Requests II: Who Has the Most Friends

SELECT requester_id as id, COUNT(*) as num
FROM (
  SELECT requester_id
  FROM RequestAccepted
  UNION ALL 
  SELECT accepter_id
  FROM RequestAccepted
  ) as t 
GROUP BY requester_id
ORDER BY num DESC
LIMIT 1;

-- 585. Investments in 2016

WITH cte AS 
(SELECT *,
 COUNT(*) OVER(PARTITION BY tiv_2015) as cnt
FROM Insurance)

SELECT ROUND(SUM(cte.tiv_2016),2) as tiv_2016
FROM cte as cte 
LEFT JOIN Insurance as i
ON i.lat = cte.lat and cte.lon = i.lon and cte.pid != i.pid
WHERE i.pid is null and cnt > 1;



-- HARD QUESTION 
-- 185. Department Top Three Salaries

WITH ordered AS (
SELECT d.name as Department, e.name as Employee ,e.salary as Salary,
DENSE_RANK() OVER(PARTITION BY departmentID ORDER BY salary DESC) as highest_in_dept
FROM Employee as e 
LEFT JOIN Department as d
on e.departmentId = d.id
)

SELECT Department, Employee, Salary
FROM Ordered
WHERE highest_in_dept <= 3;
