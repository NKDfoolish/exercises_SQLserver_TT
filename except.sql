-- Hãy cho biết các môn học không có sinh viên đăng ký?
select *
from subjects
where subjectid in (
select subjectid
from subjects
except
select subjectid
from registers
)

-- Hãy cho biết sinh viên nào đã đăng ký nhưng không đăng ký môn học C++?
select *
from students s
join registers r
on s.studentid = r.studentid
where
r.subjectid in (
select subjectid
from subjects
except
select subjectid
from subjects
where name = 'C++'
)
-- loigiai:
SELECT
	*
FROM
	Students
WHERE
	StudentId IN (
		SELECT
			r.StudentId
		FROM
			Registers r
		EXCEPT
		SELECT	
			r.StudentId
		FROM
			Registers r,
			Subjects sj
		WHERE
			r.SubjectId = sj.SubjectId
			AND
			sj.Name = N'C++'
	);

-- Hãy cho biết các khách hàng nào không có cửa hàng công nghệ trong cùng quận?
select *
from customers
where district in (
select s.district
from customers s
where s.district in (
select district
from customers
except
select district
from stores
)
group by s.district
having count(s.district) > 1
)
-- loigiai:
SELECT
	cs.*
FROM
	Customers cs
WHERE
	cs.District IN (
		SELECT
			c.District
		FROM
			Customers c
		EXCEPT
		SELECT	
			s.District
		FROM
			Stores s
	);

-- Hãy cho biết những sinh viên nào không đăng ký môn học?
select *
from students
where
studentid in (
select studentid
from students
except
select studentid
from registers
)
-- Hãy cho biết những sinh viên nào đã đăng ký từ 3 môn học trở lên? Sắp xếp giảm dần theo số lượng môn học đã đăng ký?
SELECT
	s.*,
	(
		SELECT	
			COUNT(rg.StudentId)
		FROM
			Registers rg
		WHERE
			rg.StudentId = s.StudentId
	) AS NumberOfRegistedSubject
FROM
	Students s
WHERE
	StudentId IN (
		SELECT
			r.StudentId
		FROM
			Registers r
		EXCEPT
		SELECT	
			r.StudentId
		FROM
			Registers r
		GROUP BY
			r.StudentId
		HAVING
			COUNT(r.StudentId) < 3
	);
