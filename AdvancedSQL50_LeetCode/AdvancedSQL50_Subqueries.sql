-- 1350. Students With Invalid Departments

SELECT s.id, s.name
FROM Students as s
LEFT JOIN Departments as d
ON s.department_id = d.id
WHERE d.id is Null;

-- 1303. Find the Team Size

SELECT employee_id, COUNT(*) OVER(PARTITION BY team_id) as team_size
FROM Employee;

-- 512. Game Play Analysis II

SELECT player_id, device_id
FROM
    (SELECT player_id, device_id, 
    RANK() OVER(PARTITION BY player_id ORDER BY event_date ) as rnk
    FROM Activity) as t
WHERE rnk = 1;

-- 184. Department Highest Salary
SELECT Department, Employee, Salary
FROM 
(
  SELECT d.name as Department, e.name as Employee, e.Salary,
  MAX(salary) OVER(PARTITION BY e.departmentId) as mx
  FROM Employee as e
  INNER JOIN Department as d
  ON e.departmentId = d.id
) as t
WHERE t.Salary = t.mx;

-- 1549. The Most Recent Orders for Each Product

SELECT product_name, product_id, order_id, order_date
FROM (
  SELECT p.product_name, o.product_id, o.order_id, o.order_date, 
  RANK() OVER(PARTITION BY o.product_id ORDER BY o.order_date DESC) as ord
  FROM Orders as o
  INNER JOIN Products as p
  ON o.product_id = p.product_id 
) as t
WHERE t.ord = 1
ORDER BY product_name, product_id, order_id;

-- 1532. The Most Recent Three Orders

WITH cte AS (
SELECT c.customer_id, c.name as customer_name, o.order_id, o.order_date,
 RANK() OVER(PARTITION BY c.customer_id ORDER BY order_date DESC) as rnk
FROM Customers as c
INNER JOIN Orders as o
ON c.customer_id = o.customer_id)

SELECT  customer_name, customer_id, order_id, order_date
FROM cte
WHERE rnk <= 3 
ORDER BY customer_name, customer_id, order_date DESC;

-- 1831. Maximum Transaction Each Day

SELECT transaction_id
FROM (
  SELECT transaction_id, amount, MAX(amount) OVER(PARTITION BY DATE(day)) as mx
  FROM Transactions
) as t
WHERE t.amount = t.mx
ORDER BY transaction_id;