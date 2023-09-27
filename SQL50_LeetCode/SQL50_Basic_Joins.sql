-- 1378. Replace Employee ID With The Unique Identifier

SELECT euni.unique_id, e.name
FROM Employees AS e
LEFT JOIN  EmployeeUNI AS euni
ON e.id = euni.id;

-- 1068. Product Sales Analysis I

SELECT p.product_name, s.year, s.price
FROM Sales AS s
LEFT JOIN Product AS p
ON s.product_id = p.product_id;

-- 1581. Customer Who Visited but Did Not Make Any Transactions

SELECT v.customer_id, COUNT(v.customer_id) AS count_no_trans 
FROM Visits as v
LEFT JOIN Transactions as t
ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL 
GROUP BY v.customer_id;

-- 197. Rising Temperature

SELECT w1.id
FROM Weather w1
INNER JOIN Weather w2 ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;

-- 1661. Average Time of Process per Machine

SELECT a1.machine_id, ROUND(AVG(a2.timestamp - a1.timestamp),3)  AS processing_time
FROM Activity AS a1
INNER JOIN Activity AS a2
ON a1.machine_id = a2.machine_id AND a1.process_id = a2.process_id 
WHERE a1.activity_type = 'start' and a2.activity_type = 'end'
GROUP BY a1.machine_id;

-- 577. Employee Bonus

SELECT e.name, b.bonus
FROM Employee AS e
LEFT JOIN Bonus AS b
ON e.empId = b.empID
WHERE b.bonus IS NULL or b.bonus < 1000;

-- 1280. Students and Examinations

SELECT s.student_id, s.student_name, su.subject_name, COUNT(e.student_id) AS attended_exams
FROM Students AS s
CROSS JOIN Subjects AS su
LEFT JOIN Examinations AS e
ON s.student_id = e.student_id and su.subject_name = e.subject_name
GROUP BY s.student_name, su.subject_name
ORDER BY s.student_id, su.subject_name;

-- 570. Managers with at Least 5 Direct Reports

SELECT e1.name
FROM Employee as e1
INNER JOIN Employee as e2
ON e1.id = e2.managerId
GROUP BY e1.id
HAVING COUNT(*) > 4;

-- 1934. Confirmation Rate

SELECT s.user_id, 
ROUND(SUM(CASE c.action
  WHEN 'confirmed' THEN 1
  ELSE 0
END)/ Count(*),2) as confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c
ON s.user_id = c.user_id
GROUP BY s.user_id;
