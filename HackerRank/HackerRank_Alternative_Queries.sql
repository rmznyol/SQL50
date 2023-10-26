-- Draw The Triangle

WITH RECURSIVE cte  AS
(
SELECT 1 as cnt, CAST('*' AS CHAR(50)) as res
union all
SELECT cnt+1, concat(res,' ','*') from cte where cnt < 20
)
SELECT res FROM cte
ORDER BY cnt DESC;  

-- This is listed as an easy problem 
-- However, in my opinion it is a hard problem
-- Limiting the recursion on length of the string
-- prompts an error: 'ERROR 1406 (22001): Data too long for column 'str' at row 1'
-- See documentation for help: https://dev.mysql.com/doc/refman/8.0/en/with.html

-- Draw The Triangle 2
WITH RECURSIVE cte AS (
    SELECT 1 as n, CAST('*' AS CHAR(50)) as print
    UNION ALL
    SELECT n + 1, CONCAT(print, ' *')
    FROM cte
    WHERE n < 20
)
SELECT print
FROM cte;