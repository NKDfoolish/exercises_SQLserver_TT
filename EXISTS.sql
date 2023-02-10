-- 1. Từ bảng Staffs, hãy cho biết tên các nhân viên làm việc tại Hà Nội.
select
	x.lastname + ' ' + x.firstname as FullName
from
	staffs x
where
	exists (
		select 
			*
		from 
			staffs s join stores st
			on s.storeid = st.storeid
		where
			st.city = N'Hà Nội'
			and
			s.staffid = x.staffid
	)


-- LoiGiai:
SELECT
	s.FirstName,
	s.LastName,
	st.City
FROM 
	Staffs s,
	Stores st
WHERE
	s.StoreId = st.StoreId
	AND
	EXISTS(
		SELECT	
			StoreId
		FROM
			Stores
		WHERE
			st.StoreId = StoreId
			AND
			City = N'Hà Nội'
	);
-- 2. Từ bảng Stores, hãy cho biết các cửa hàng có địa chỉ ở quận Cầu Giấy hoặc Nam Từ Liêm hoặc Quận 6.
select
	st.storename,
	st.district
from
	stores st
where
	exists(
		select
			s.storeid
		from
			stores s
		where
			(
			s.district = N'Cầu Giấy'
			or
			s.district = N'Nam Từ Liêm'
			or
			s.district = N'Quận 6'
			)
			and
			s.storeid = st.storeid
	)

-- 3. Từ bảng Subjects, Registers, hãy cho biết những môn học nào có số lượng sinh viên đăng ký > 2.
select
	sj.*,
	(
	select
		count(r.subjectid)
	from
		registers r
	where
		r.subjectid = sj.subjectid
	) as NumOfRegister
from
	subjects sj
where
	exists(
		select
			1
		from
			registers r
		where
			r.subjectid = sj.subjectid
		group by
			r.subjectid
		having
			count(r.subjectid) > 2
	)

-- LoiGiai:
SELECT
	s.SubjectId,
	s.Name,
	COUNT(r.SubjectId) AS NumberOfRegister
FROM 
	Subjects s
	INNER JOIN
	Registers r
	ON s.SubjectId = r.SubjectId
GROUP BY
	s.SubjectId,
	s.Name,
	r.SubjectId
HAVING
	EXISTS(
		SELECT	
			SubjectId
		FROM
			Registers
		GROUP BY
			SubjectId
		HAVING
			COUNT(SubjectId) > 2
			AND
			SubjectId = s.SubjectId
	)
ORDER BY
	NumberOfRegister DESC;
/* 4. Từ bảng Students, Registers, Subjects, hãy cho biết những sinh viên nào đăng ký từ 2 môn học trở 
lên và cho biết đó là những môn học nào? */
select
	s.studentid,
	(s.lastname + ' ' + s.firstname) as FullName,
	sj.name
from
	students s join registers r
	on s.studentid = r.studentid
	join subjects sj
	on r.subjectid = sj.subjectid
where
	exists(
		select 
		count(rg.registerid) as Quantity
		from registers rg
		where
		rg.studentid = s.studentid
		group by
		rg.studentid
		having 
		count(rg.registerid) >= 2
	)
ORDER BY
	s.StudentId
-- LoiGiai:
SELECT
	st.*,
	s.SubjectId,
	s.Name AS SubjectName
FROM 
	Subjects s
	INNER JOIN Registers r
	ON s.SubjectId = r.SubjectId
	INNER JOIN Students st
	ON r.StudentId = st.StudentId
WHERE
	EXISTS(
		SELECT	
			StudentId
		FROM
			Registers
		GROUP BY
			StudentId
		HAVING
			COUNT(StudentId) >= 2
			AND
			st.StudentId = StudentId
	)
ORDER BY
	st.StudentId
/* 5. Từ bảng Staffs và Stores hãy cho biết tên cửa hàng, tên quản lý và số lượng nhân viên dưới quyền 
của quản lý đó nếu người đó quản lý từ 3 nhân viên trở lên. */

SELECT
	st.StoreName,
	s2.FirstName,
	COUNT(s1.ManagerId) AS NumberOfStaff
FROM 
	Staffs s1 INNER JOIN Staffs s2 
	ON s1.ManagerId = s2.StaffId, 
	Stores st
WHERE
	st.StoreId = s2.StoreId
	AND
	EXISTS(
		SELECT	
			StaffId
		FROM
			Staffs
		WHERE
			StaffId = s2.StaffId
			AND
			ManagerId IS NULL
	)
GROUP BY 
	s1.ManagerId,
	st.StoreName,
	s2.FirstName
HAVING
	COUNT(s1.ManagerId) >= 3