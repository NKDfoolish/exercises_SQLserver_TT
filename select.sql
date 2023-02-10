-- bt1
SELECT
	id, fullname, birthdate
FROM
	Student

-- bt2
SELECT
	id, name, credit
FROM Subject

-- bt3
SELECT
	id, gpa
FROM
	Student

-- bt4
SELECT *
FROM 
	Student
WHERE 
	month(birthdate) % 2 = 0
-- bt5
SELECT *
FROM
	Student
WHERE
	gpa >= 3.2