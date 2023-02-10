-- 1. Hãy cho biết thông tin các môn học trong bảng Subjects có sinh viên đăng ký. Không xét trạng thái đăng ký.
select s.*
from Subjects s join Registers r
on s.subjectid = r.subjectid

-- 2. Hãy cho biết thông tin các môn học trong bảng Subjects không có bất kỳ sinh viên nào đăng ký.
select *
from Subjects
where
	subjectid not in (
				select s.subjectid
				from Subjects s join Registers r
				on s.subjectid = r.subjectid	
				)

-- 3. Hãy cho biết thông tin những sinh viên đăng ký môn học C++. Không xét trạng thái đăng ký.
select s.*
from Subjects sj 
join Registers r
on sj.subjectid = r.subjectid
join Students s
on s.studentid = r.studentid
where
sj.name = 'C++'

-- 4. Hãy cho biết mỗi sinh viên đăng ký bao nhiêu môn học. Không xét trạng thái đăng ký.
select s.studentid, s.lastname, s.midname, s.firstname, count(1) as NumberOfRegister
from
	students s join registers r on s.studentid = r.studentid
group by
	s.studentid, s.lastname, s.midname, s.firstname
order by
	NumberOfRegister DESC

-- 5. Hãy cho biết mỗi môn học có bao nhiêu sinh viên đăng ký. Không xét trạng thái đăng ký.
select sj.name, count(1) as NumberOfRegister
from
	registers r join subjects sj 
	on sj.subjectid = r.subjectid
group by
	sj.name
order by
	NumberOfRegister DESC

-- 6. Hãy cho biết thông tin các sinh viên trong bảng Students đăng ký nhiều môn học nhất. Không xét trạng thái đăng ký.
select *
from students 
where
	studentid in (
	select top 1 with ties rs.studentid
	from (
	select s.studentid, s.lastname, s.midname, s.firstname, count(1) as NumberOfRegister
	from
		students s join registers r on s.studentid = r.studentid
				   join subjects sj on sj.subjectid = r.subjectid
	group by
		s.studentid, s.lastname, s.midname, s.firstname
	) as rs
	order by
	rs.NumberOfRegister DESC
	)
-- 6 : cach 2
SELECT
	s.StudentId,
	s.FirstName,
	s.LastName,
	s.Major,
	COUNT(r.StudentId) AS NumberOfRegistered
FROM
	Registers r
	INNER JOIN Students s
	ON r.StudentId = s.StudentId
GROUP BY
	s.StudentId,
	s.LastName,
	s.FirstName,
	s.Major
HAVING
	-- B3:
	COUNT(r.StudentId) = (
		-- B2
		SELECT MAX(rs.Registered)
		FROM
			(
				-- B1:
				SELECT	
					COUNT(rg.StudentId) AS Registered
				FROM
					Students st
					INNER JOIN Registers rg
					ON st.StudentId = rg.StudentId
				GROUP BY
					st.StudentId
			) rs
		)

-- 7. Hãy cho biết thông tin các môn học trong bảng Subjects được đăng ký nhiều nhất. Không xét trạng thái đăng ký.
select *
from subjects 
where
	subjectid in (
	select top 1 with ties rs.subjectid, rs.NumberOfRegister
	from (
	select sj.subjectid, count(1) as NumberOfRegister
	from
		registers r join subjects sj on sj.subjectid = r.subjectid
	group by
		sj.subjectid
	) as rs
	order by
	rs.NumberOfRegister DESC
	)

-- 7: cach 2
SELECT DISTINCT
	s.SubjectId,
	s.Name,
	s.Credit,
	s.Type,
	COUNT(r.SubjectId) AS NumberOfRegistered
FROM
	Registers r
	INNER JOIN Subjects s
	ON r.SubjectId = s.SubjectId
GROUP BY
	s.SubjectId,
	s.Name,
	s.Credit,
	s.Type
HAVING
	-- B3:
	COUNT(r.SubjectId) = (
		-- B2:
		SELECT 
			MAX(rs.Registered) AS MaxRegisterd
		FROM
			(
				-- B1:
				SELECT
					COUNT(rg.SubjectId) AS Registered
				FROM
					Subjects sj
					INNER JOIN Registers rg
					ON rg.SubjectId = sj.SubjectId
				GROUP BY
					sj.SubjectId
			) rs
	)

-- 8. Hãy cho biết thông tin các sinh viên đăng ký môn học nhiều thứ hai. Không xét trạng thái đăng ký**.
select *
from students 
where
	studentid in (
	select rs.studentid
	from (
	select s.studentid, s.lastname, s.midname, s.firstname, count(1) as NumberOfRegister
	from
		students s join registers r on s.studentid = r.studentid
				   join subjects sj on sj.subjectid = r.subjectid
	group by
		s.studentid, s.lastname, s.midname, s.firstname
	) as rs
	order by
	rs.NumberOfRegister DESC
	offset 3 rows
	fetch next 2 rows only
	)
-- 8: cach dung voi moi bai
SELECT
	s.StudentId,
	s.FirstName,
	s.LastName,
	s.Major,
	COUNT(r.StudentId) AS NumberOfRegistered
FROM
	Registers r
	INNER JOIN Students s
	ON r.StudentId = s.StudentId
GROUP BY
	s.StudentId,
	s.LastName,
	s.FirstName,
	s.Major
HAVING
	-- B3:
	COUNT(r.StudentId) = (
		-- B2
		SELECT MIN(rs.Registered)
		FROM
			(
				-- B1:
				SELECT DISTINCT TOP 2	
					COUNT(rg.StudentId) AS Registered
				FROM
					Students st
					INNER JOIN Registers rg
					ON st.StudentId = rg.StudentId
				GROUP BY
					st.StudentId
				ORDER BY
					Registered DESC
			) rs
	)
