-- 1821. Find Customers With Positive Revenue this Year

SELECT customer_id
FROM Customers 
WHERE year = 2021 and revenue > 0;

-- 183. Customers Who Never Order

SELECT c.name as Customers FROM Customers as c 
LEFT JOIN Orders as o
ON c.id = o.customerId
WHERE o.id is null;

-- 1873. Calculate Special Bonus
SELECT employee_id,
CASE
    WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary
    ELSE 0
END as bonus
FROM Employees
ORDER BY employee_id;

-- 1398. Customers Who Bought Products A and B but Not C

SELECT DISTINCT o1.customer_id, c.customer_name
FROM Orders as o1
INNER JOIN Orders as o2
on o1.customer_id  = o2.customer_id
INNER JOIN Customers as c
on o1.customer_id = c.customer_id 
WHERE o1.product_name = 'A' and o2.product_name = 'B' and o1.customer_id not in (
  SELECT customer_id
  FROM orders
  WHERE product_name = 'C'
);

-- 1112. Highest Grade For Each Student

WITH cte as (SELECT *, MAX(grade) OVER(PARTITION BY student_id) as mx
FROM Enrollments
)

SELECT student_id, min(course_id) as course_id, grade
FROM cte
WHERE grade = mx 
GROUP BY student_id, grade;
