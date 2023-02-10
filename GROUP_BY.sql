-- 1. Hãy cho biết điểm TB cộng của các sinh viên tổng hợp theo các tháng sinh của sinh viên trong danh sách.
select 
	month(birthdate) as Month,
	avg(gpa) as AVG_GPA
from
	students
group by 
	month(birthdate)
order by
	AVG_GPA DESC

-- 2. Hãy cho biết số lượng môn học ở mỗi giá trị tín chỉ là bao nhiêu?
select 
	credit,
	count(subjectid) as Quantity
from
	subjects
group by
	credit
order by
	Quantity DESC
-- 3. Hãy cho biết số lượng sinh viên đăng ký theo từng môn học.
SELECT
	sj.SubjectId,
	sj.Name,
	COUNT(sj.SubjectId) as Quantity
FROM
	Subjects sj,
	Registers r
WHERE
	sj.SubjectId = r.SubjectId
GROUP BY
	sj.SubjectId,
	sj.Name

-- 4. Hãy cho biết số lượng môn học mà mỗi sinh viên đăng ký.
SELECT
	st.StudentId,
	st.FirstName,
	st.LastName,
	st.Major,
	COUNT(st.StudentId) AS NumberOfRegistered
FROM
	Students st,
	Registers r
WHERE
	st.StudentId = r.StudentId
GROUP BY
	st.StudentId,
	st.FirstName,
	st.LastName,
	st.Major