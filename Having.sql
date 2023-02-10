-- 1. Hãy cho biết điểm TB cộng của các sinh viên tổng hợp theo các tháng sinh từ 6-12 của sinh viên trong danh sách.
select 
	month(birthdate) as Month,
	avg(gpa) as AVG_GPA
from
	students
group by
	month(birthdate)
having
	month(birthdate) >= 6
order by
	Month ASC

-- 2. Hãy cho biết số lượng môn học ở mỗi giá trị tín chỉ >= 3 là bao nhiêu?
select
	credit,
	count(subjectid) as quantity
from
	subjects
group by
	credit
having
	credit >= 3
order by
	quantity DESC

-- 3. Hãy cho biết số lượng sinh viên đăng ký theo từng môn học. Trong đó tên môn học phải có độ dài từ 5 kí tự trở lên.
SELECT
	sj.SubjectId,
	sj.Name,
	COUNT(r.StudentId) NumberOfRegister
FROM
	Subjects sj,
	Registers r
WHERE
	sj.SubjectId = r.SubjectId
GROUP BY
	sj.SubjectId,
	sj.Name
HAVING
	LEN(Name) >= 5

-- 4. Hãy cho biết số lượng môn học mà mỗi sinh viên đăng ký. Chỉ xét các sinh viên đăng ký từ 3 môn học trở lên.
SELECT
	st.StudentId,
	st.FirstName,
	st.LastName,
	st.Major,
	COUNT(r.SubjectId) AS NumberOfRegistered
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
HAVING
	COUNT(r.SubjectId) >= 3

-- 5. Hãy cho biết thông tin các môn học trong bảng Subjects có sinh viên đăng ký. Không xét trạng thái đăng ký.
SELECT DISTINCT
	sj.*
FROM
	Subjects sj
	INNER JOIN Registers r
	ON sj.SubjectId = r.SubjectId
ORDER BY
	sj.SubjectId

-- 6. Hãy cho biết thông tin các môn học trong bảng Subjects không có bất kỳ sinh viên nào đăng ký.
SELECT
	sj.*
FROM
	Subjects sj
WHERE
	sj.SubjectId NOT IN (
		SELECT 
			s.SubjectId
		FROM
			Subjects s
			INNER JOIN Registers r
			ON s.SubjectId = r.SubjectId
	)
ORDER BY
	sj.SubjectId

-- 7. Hãy cho biết thông tin những sinh viên đăng ký môn học C++. Không xét trạng thái đăng ký.
SELECT
	s.*,
	sj.Name AS SubjectName
FROM
	Subjects sj
	INNER JOIN Registers r
	ON sj.SubjectId = r.SubjectId
	INNER JOIN Students s
	ON r.StudentId = s.StudentId
WHERE
	sj.Name = 'C++'
ORDER BY
	s.StudentId;

-- 8. Hãy cho biết mỗi sinh viên đăng ký bao nhiêu môn học. Không xét trạng thái đăng ký.
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
ORDER BY
	NumberOfRegistered DESC;

-- 9. Hãy cho biết mỗi môn học có bao nhiêu sinh viên đăng ký. Không xét trạng thái đăng ký.
SELECT
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
ORDER BY
	NumberOfRegistered DESC;

-- 10. Hãy cho biết thông tin các sinh viên trong bảng Students đăng ký nhiều môn học nhất. Không xét trạng thái đăng ký.
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

-- 11. Hãy cho biết thông tin các môn học trong bảng Subjects được đăng ký nhiều nhất. Không xét trạng thái đăng ký.
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

-- 12. Hãy cho biết thông tin các sinh viên đăng ký môn học nhiều thứ hai. Không xét trạng thái đăng ký**.
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

