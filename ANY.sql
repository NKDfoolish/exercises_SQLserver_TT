-- Hãy cho biết các tháng sinh có từ 2 sinh viên trở lên. Kết quả sắp xếp giảm dần theo số lượng sinh viên
select
	month(s.birthdate) as MonthOfBirthdate,
	count(s.studentid) as NumberOfStudent
from
	students s
where
	month(birthdate) = any
	(
		select month(x.birthdate) as Month
		from students x
		group by month(x.birthdate)
		having count(x.studentid) >= 2
	)
group by 
	month(s.birthdate)
order by
	NumberOfStudent DESC

-- Hãy cho biết thông tin các sinh viên đăng ký từ 2 môn học trở lên. Kết quả sắp xếp giảm dần theo số lượng môn học đã đăng ký.
select 
	s.studentid,
	s.lastname,
	s.firstname,
	count(r.registerid) as NumOfRegister
from
	students s join registers r
	on s.studentid = r.studentid
group by
	s.studentid,
	s.lastname,
	s.firstname
having
	count(r.registerid) = any (
		SELECT 
			COUNT(StudentId)
		FROM
			Registers
		GROUP BY
			StudentId
		HAVING
			COUNT(StudentId) > 1
	)
order by
	NumOfRegister DESC

-- Hãy cho biết thông tin các sinh viên chỉ đăng ký 1 môn học.
select 
	s.studentid,
	s.lastname,
	s.firstname,
	count(r.registerid) as NumOfRegister
from
	students s join registers r
	on s.studentid = r.studentid
group by
	s.studentid,
	s.lastname,
	s.firstname
having
	count(r.registerid) = any (
		SELECT 
			COUNT(StudentId)
		FROM
			Registers
		GROUP BY
			StudentId
		HAVING
			COUNT(StudentId) = 1
	)
order by
	NumOfRegister DESC

-- Hãy cho biết thông tin các sinh viên không đăng ký môn học.
SELECT
	s.*
FROM	
	Students s
WHERE
	s.StudentId NOT IN(
		SELECT 
			StudentId
		FROM
			Registers
	);

-- Hãy cho biết thông tin các nhân viên làm cùng cửa hàng có mã cửa hàng là 5.
select s.*
from staffs s 
where s.storeid = 5

-- loigiai:
SELECT
	s.*
FROM	
	Staffs s
WHERE
	s.StaffId IN(
		SELECT 
			StaffId
		FROM
			Staffs
		WHERE
			StoreId = 5
	);

-- Hãy cho biết mã, họ, tên các nhân viên quản lý, tên cửa hàng họ làm việc?
select s.*, st.storename
from staffs s join stores st
on s.storeid = st.storeid
where s.managerid is null

-- loi giai:
SELECT
	s.StaffId,
	s.LastName,
	s.FirstName,
	st.StoreName
FROM	
	Staffs s
	INNER JOIN Stores st
	ON s.StoreId = st.StoreId
WHERE
	s.StaffId IN(
		SELECT
			StaffId
		FROM
			Staffs
		WHERE
			ManagerId IS NULL
	);


/*Hãy cho biết mã, họ, tên các nhân viên quản lý, tên cửa hàng họ làm việc, số lượng nhân viên họ đang quản lý? Sắp xếp kết 
quả theo số lượng nhân viên người đó quản lý giảm dần.*/
select
s2.staffid,
(s2.lastname + ' ' + s2.firstname) as FullName,
st.storename,
count(s1.managerid) as NumOfStaff
from
staffs s1 join staffs s2 on s1.managerid = s2.staffid
join stores st on s2.storeid = st.storeid
where
s2.managerid is null
group by
s2.staffid,
s2.lastname,
s2.firstname,
st.Storename
order by
NumOfStaff DESC

-- loi giai:
SELECT
	m.StaffId,
	m.LastName,
	m.FirstName,
	st.StoreName,
	COUNT(s.ManagerId) AS NumberOfStaff
FROM	
	Staffs m
	INNER JOIN Staffs s
	ON m.StaffId = s.ManagerId
	INNER JOIN Stores st
	ON s.StoreId = st.StoreId
WHERE
	m.StaffId IN(
		SELECT
			StaffId
		FROM
			Staffs
		WHERE
			ManagerId IS NULL
	)
GROUP BY
	m.StaffId,
	m.LastName,
	m.FirstName,
	st.StoreName,
	s.ManagerId
ORDER BY
	NumberOfStaff DESC;



