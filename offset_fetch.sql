-- bt1
SELECT * 
FROM Subject
ORDER BY credit DESC
OFFSET 0 ROWS
FETCH FIRST 4 ROWS ONLY

-- bt2
SELECT * 
FROM Subject
ORDER BY numoflesson DESC
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY

-- bt3
SELECT *
FROM Subject
ORDER BY len(name) ASC
OFFSET 3 ROWS
FETCH NEXT 5 ROWS ONLY