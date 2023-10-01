-- Type of Triangle
SELECT
CASE 
WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
WHEN A = B AND B = C THEN 'Equilateral'
WHEN A <> B AND A <> C AND B <> C THEN 'Scalene'
ELSE 'Isosceles'
END
FROM TRIANGLES

-- The PADS
SELECT CONCAT(Name,'(',LEFT(Occupation,1),')')
FROM OCCUPATIONS
ORDER BY Name;
SELECT CONCAT('There are a total of ', COUNT(Occupation), ' ', LOWER(Occupation),'s.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Occupation), Occupation;

-- Occupations
SELECT MIN(CASE Occupation WHEN 'Doctor' THEN name END) as Doctor,
MIN(CASE Occupation WHEN 'Professor' THEN name END) as Professor,
MIN(CASE Occupation WHEN 'Singer' THEN name END) as Singer,
MIN(CASE Occupation WHEN 'Actor' THEN name END) as  Actor 
FROM (SELECT  Name, Occupation, ROW_NUMBER() OVER 
     (PARTITION BY Occupation ORDER BY Name) 
      AS rnk
      FROM OCCUPATIONS) AS T
GROUP BY rnk;

-- Binary Tree Nodes
SELECT DISTINCT b1.N, CASE WHEN b2.P is NULL THEN 'Leaf'
WHEN  b1.P is NULL THEN 'Root'
ELSE 'Inner' END
FROM BST as b1
LEFT JOIN BST as b2
ON b1.N = b2.P
ORDER BY b1.N

-- New Companies
SELECT c.company_code, c.founder, 
COUNT(DISTINCT e.lead_manager_code),
COUNT(DISTINCT e.senior_manager_code), 
COUNT(DISTINCT e.manager_code),
COUNT(DISTINCT e.employee_code)
FROM Company as c
INNER JOIN Employee as e 
ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;