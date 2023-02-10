-- Hãy cho biết mã, họ và tên các sinh viên có ngày sinh không trùng với ngày sinh của sinh viên nào. Chỉ xét ngày, không xét tháng, năm.
select *
from students
where
day(birthdate) in
(
select 
day(birthdate) as DayBirth
from students
group by day(birthdate)
having count(day(birthdate)) = 1
)
-- loigiai
SELECT
	s.StudentId [Mã SV],
	s.FirstName [Tên],
	s.MidName [Đệm],
	s.LastName [Họ],
	DAY(s.BirthDate) AS [Ngày sinh]
FROM
	Students s
WHERE
	DAY(s.BirthDate) <> ALL(
		SELECT DISTINCT
			DAY(s1.BirthDate)
		FROM
			Students s1 
			INNER JOIN Students s2
			ON s1.StudentId < s2.StudentId
		WHERE
			DAY(s1.BirthDate) = DAY(s2.BirthDate)
	)
-- Hãy cho biết mã, họ, tên các nhân viên có họ không trùng với họ của các nhân viên khác. Sắp xếp kết quả tăng dần theo tên a-z.
SELECT
	s.StaffId,
	s.FirstName,
	s.LastName
FROM
	Staffs s
WHERE
	s.LastName <> ALL(
		SELECT DISTINCT
			s1.LastName
		FROM
			Staffs s1 
			INNER JOIN Staffs s2
			ON s1.StaffId < s2.StaffId
		WHERE
			s1.LastName = s2.LastName
	)
ORDER BY
	s.FirstName ASC;

-- Hãy cho biết thông tin các cửa hàng có địa chỉ quận không trùng với địa chỉ quận của các cửa hàng khác.
SELECT
	s.StoreId [Mã cửa hàng],
	s.StoreName [Tên cửa hàng],
	s.District [Quận]
FROM
	Stores s
WHERE
	s.District <> ALL(
		SELECT DISTINCT
			s1.District
		FROM
			Stores s1 
			INNER JOIN Stores s2
			ON s1.StoreId < s2.StoreId
		WHERE
			s1.District = s2.District
	)
ORDER BY
	s.StoreName ASC;