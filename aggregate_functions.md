620. Not Boring Movies

SELECT *
FROM Cinema
WHERE id % 2 = 1 and description != 'boring' 
ORDER BY rating DESC

#################################################################
1251. Average Selling Price

SELECT u.product_id, ROUND(SUM(units * price) / SUM(units),2) as average_price
FROM UnitsSold as u
LEFT JOIN Prices as p
ON u.product_id = p.product_id AND u.purchase_date BETWEEN p.Start_date and p.end_date
GROUP BY u.product_id

#################################################################
1075. Project Employees I

SELECT project_id, ROUND(AVG(experience_years),2) as average_years
FROM Project as p
LEFT JOIN Employee as e
ON p.employee_id = e.employee_id
GROUP BY project_id

#################################################################
1633. Percentage of Users Attended a Contest

SELECT contest_id, ROUND(100 * COUNT(DISTINCT(user_id)) / (SELECT COUNT(DISTINCT(user_id)) FROM Users),2) as percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC

#################################################################


