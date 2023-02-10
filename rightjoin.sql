-- 1. Hãy cho biết những sinh viên nào không đăng ký môn học.
select s.*
from
	registers r right join students s
	on r.studentid = s.studentid
where
	r.registerid is null

-- 2. Hãy cho biết những sinh viên nào đăng ký từ 2 môn học trở lên.
select *
from students
where
	studentid in (
		select
		rs.studentid
		from (
		select s.studentid, count(s.studentid) as NumOfRegister
		from
			registers r right join students s
			on r.studentid = s.studentid
		where
			r.registerid is not null
		group by
			s.studentid
		) rs
		where
		rs.NumOfRegister >= 2
	)

-- cach 2:
SELECT
	s.*,
	COUNT(r.StudentId) AS NumberOfRegistered
FROM 
	Registers r 
	RIGHT JOIN Students s
	ON s.StudentId = r.StudentId 
GROUP BY
	s.StudentId,
	s.FirstName,
	s.MidName,
	s.LastName,
	s.BirthDate,
	s.Address,
	s.PhoneNumber,
	s.Major,
	s.Gpa,
	r.StudentId
HAVING
	r.StudentId IS NOT NULL
	AND
	COUNT(r.StudentId) > 1
ORDER BY
	NumberOfRegistered DESC;

-- 3. Hãy cho biết các môn học nào có từ 2 sinh viên đăng ký trở lên.
select *
from subjects
where
	subjectid in (
		select
		rs.subjectid
		from (
			select s.subjectid, count(s.subjectid) as NumOfRegister
			from
				registers r right join subjects s
				on r.subjectid = s.subjectid
			where
				r.registerid is not null
			group by
				s.subjectid
		) rs
		where
		rs.NumOfRegister >= 2
	)

-- 4. Hãy cho biết sinh viên nào đăng ký môn học sớm nhất?
select top 1 with ties s.*
from
	registers r right join students s
	on r.studentid = s.studentid
where
	r.registerid is not null
order by
	r.registertime ASC

-- 5. Hãy cho biết môn học nào được đăng ký sớm nhất?
select top 1 with ties s.*
from
	registers r right join subjects s
	on r.subjectid = s.subjectid
where
	r.registerid is not null
order by
	r.registertime ASC

