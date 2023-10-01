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