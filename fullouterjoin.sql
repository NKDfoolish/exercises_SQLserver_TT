-- 1. Hãy cho biết tên, mã các môn học không có sinh viên đăng ký và tên, mã các sinh viên không đăng ký môn học.
SELECT
	s.StudentId,
	s.FirstName,
	sj.SubjectId,
	sj.Name AS SubjectName
FROM 
	Students s
	FULL OUTER JOIN Registers r 
	ON s.StudentId = r.StudentId
	FULL OUTER JOIN Subjects sj
	ON r.SubjectId = sj.SubjectId
WHERE
	r.SubjectId IS NULL

-- 2. Hãy cho biết mã, tên sinh viên, mã, tên môn học, thời gian đăng ký của các môn học sinh viên đã đăng ký.
SELECT
	s.StudentId,
	s.FirstName,
	sj.SubjectId,
	sj.Name AS SubjectName,
	r.registertime
FROM 
	Students s
	FULL OUTER JOIN Registers r 
	ON s.StudentId = r.StudentId
	FULL OUTER JOIN Subjects sj
	ON r.SubjectId = sj.SubjectId
WHERE
	r.SubjectId IS not NULL
order by 
	r.registertime ASC