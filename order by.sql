-- bt1
SELECT *
FROM Subject
ORDER BY len(name) ASC

-- bt2
SELECT 
	*
FROM 
	Subject
ORDER BY 
	credit DESC, name ASC

-- bt3
SELECT 
	id, name
FROM 
	Subject
ORDER BY 
	numoflesson ASC

--bt4
SELECT 
	id, name, credit
FROM 
	Subject
ORDER BY 
	type ASC