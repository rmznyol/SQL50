-- 262. Trips and Users (HARD)

SELECT t.request_at as Day, ROUND((SUM(t.status = 'cancelled_by_driver') + SUM(t.status = 'cancelled_by_client'))/COUNT(t.status),2) as 'Cancellation Rate'
FROM Trips as t
INNER JOIN Users as u1
ON t.client_id = u1.users_id
INNER JOIN Users as u2
ON t.driver_id = u2.users_id
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
AND u1.banned = 'No' AND u2.banned = 'No'
GROUP BY t.request_at;

-- 569. Median Employee Salary (HARD)

SELECT id, company, salary
FROM (
  SELECT *, COUNT(salary) OVER(PARTITION BY company) as cnt,
  RANK() OVER(PARTITION BY company ORDER   BY Salary,id) as rnk
  FROM Employee
) as t
WHERE rnk BETWEEN cnt / 2 AND cnt/2 + 1; 
