-- 1. Từ bảng Subjects, hãy cho biết tên các môn học cùng số tín chỉ
SELECT
	s1.Name AS Subject1,
	s2.Name AS Subject2,
	s1.Credit
FROM 
	Subjects s1
	INNER JOIN Subjects s2 
	ON s1.SubjectId < s2.SubjectId
	AND
	s1.Credit = s2.Credit
ORDER BY
	s1.Credit

-- 2. Từ bảng Students hãy cho biết tên các sinh viên có cùng tháng sinh.
select 
	s1.firstname as student1,
	s2.firstname as student2,
	month(s1.birthdate) as BirthMonth
from 
	students s1 join students s2
	on s1.studentid < s2.studentid
	and month(s1.birthdate) = month(s2.birthdate)
order by
	s1.birthdate ASC

-- 3. Từ bảng Students hãy cho biết tên các sinh viên có cùng điểm TB.
SELECT
	s1.firstname AS Subject1,
	s2.firstname AS Subject2,
	s1.gpa
FROM 
	students s1
	INNER JOIN students s2 
	ON s1.studentid < s2.studentid
	AND
	s1.gpa = s2.gpa
ORDER BY
	s1.gpa

-- 4. Từ bảng Stores hãy cho biết các cửa hàng ở cùng thành phố.
SELECT
	s1.storename as store1,
	s2.storename as store2,
	s1.city
FROM 
	stores s1
	INNER JOIN stores s2 
	ON s1.storeid < s2.storeid
	AND
	s1.city = s2.city
ORDER BY
	s1.city

-- 5. Từ bảng Staffs và Stores hãy cho biết tên các nhân viên làm cùng cửa hàng.
SELECT
	s1.firstname as [staff 1],
	s2.firstname as [staff 2],
	st.storename
FROM 
	staffs s1
	INNER JOIN staffs s2 
	ON s1.staffid < s2.staffid
	AND
	s1.storeid = s2.storeid
	join stores st
	on s1.storeid = st.storeid
ORDER BY
	st.storename
