﻿-- Viết hàm tìm điểm thấp nhất của các sinh viên theo từng chuyên ngành trong bảng Students.

CREATE OR ALTER FUNCTION fn_FindStudentHaveMinGpa(
	@major NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
	SELECT
		MIN(Gpa) MinGpa
	FROM
		Students
	WHERE
		Major = @major
GO -- tìm điểm GPA min của từng chuyên ngành
SELECT
	*
FROM
	fn_FindStudentHaveMinGpa('CNTT');



﻿-- Viết hàm tìm khách hàng tên dài nhất trong bảng Customers.

CREATE OR ALTER FUNCTION fn_FindCustomerWithLogestName()
RETURNS TABLE
AS
RETURN
	SELECT
		*
	FROM
		Customers
	WHERE
		LEN(FirstName) = (
			SELECT 
				MAX(LEN(c.FirstName))
			FROM
				Customers c
		)
GO -- tìm khách hàng tên dài nhất
SELECT
	*
FROM
	fn_FindCustomerWithLogestName();



﻿-- Viết hàm phân loại học lực cho từng sinh viên trong bảng Students.

CREATE OR ALTER FUNCTION fn_QueryTask3(
	@gpa FLOAT
)
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @capacity NVARCHAR(20);
	IF @gpa >= 3.6
		SET @capacity = N'Xuất Sắc';
	ELSE IF @gpa >= 3.2
		SET @capacity = N'Giỏi';
	ELSE IF @gpa >= 2.8
		SET @capacity = N'Khá';
	ELSE IF @gpa >= 2.4
		SET @capacity = N'Trung bình';
	ELSE IF @gpa >= 2.0
		SET @capacity = N'TB Yếu';
	ELSE
		SET @capacity = N'Yếu';
	RETURN @capacity;
END;
GO -- tìm điểm GPA min của từng chuyên ngành
SELECT
	StudentId,
	FirstName,
	Major,
	Gpa,
	dbo.fn_QueryTask3(Gpa) Capacity
FROM
	Students
GROUP BY
	StudentId,
	FirstName,
	Major,
	Gpa;



﻿-- Viết hàm tìm sinh viên đăng ký nhiều môn học nhất.

CREATE OR ALTER FUNCTION fn_QueryTask4()
RETURNS TABLE
AS
RETURN
SELECT TOP 1 WITH TIES
	st.StudentId,
	st.FirstName,
	st.LastName,
	st.PhoneNumber,
	st.Major,
	st.Gpa,
	COUNT(r.StudentId) NumOfRegistered 
FROM
	Students st
	INNER JOIN Registers r
	ON st.StudentId = r.StudentId
	INNER JOIN Subjects sj
	ON sj.SubjectId = r.SubjectId
GROUP BY
	r.StudentId,
	st.StudentId,
	st.FirstName,
	st.LastName,
	st.PhoneNumber,
	st.Major,
	st.Gpa
ORDER BY
	NumOfRegistered DESC;
GO
SELECT
	* 
FROM 
	fn_QueryTask4();




query1.sql
Người có quyền truy cập

Thuộc tính hệ thống
Loại
SQL
Kích thước
406 byte
Bộ nhớ đã dùng
406 byte
Vị trí
Lesson 17.3
Chủ sở hữu
thân triệu
Lần sửa đổi gần đây nhất
30 thg 8, 2022 do thân triệu thực hiện
Đã mở
17:22 do tôi thực hiện
Người tạo
30 thg 8, 2022
Không có mô tả nào
Người xem có thể tải xuống
﻿-- Viết hàm tìm sinh viên đăng ký nhiều môn học nhất.

CREATE OR ALTER FUNCTION fn_QueryTask5()
RETURNS TABLE
AS
RETURN
SELECT TOP 1 WITH TIES
	sj.SubjectId,
	sj.Name,
	sj.Credit,
	sj.NumOfLesson,
	sj.Type,
	COUNT(r.SubjectId) NumOfRegister 
FROM
	Students st
	INNER JOIN Registers r
	ON st.StudentId = r.StudentId
	INNER JOIN Subjects sj
	ON sj.SubjectId = r.SubjectId
GROUP BY
	r.SubjectId,
	sj.SubjectId,
	sj.Name,
	sj.Credit,
	sj.NumOfLesson,
	sj.Type
ORDER BY
	NumOfRegister DESC;
GO
SELECT
	* 
FROM 
	fn_QueryTask5();



query1.sql
Người có quyền truy cập

Thuộc tính hệ thống
Loại
SQL
Kích thước
406 byte
Bộ nhớ đã dùng
406 byte
Vị trí
Lesson 17.3
Chủ sở hữu
thân triệu
Lần sửa đổi gần đây nhất
30 thg 8, 2022 do thân triệu thực hiện
Đã mở
17:22 do tôi thực hiện
Người tạo
30 thg 8, 2022
Không có mô tả nào
Người xem có thể tải xuống
﻿-- Viết hàm tìm sinh viên đăng ký môn học sớm nhất.

CREATE OR ALTER FUNCTION fn_QueryTask6()
RETURNS TABLE
AS
RETURN
SELECT TOP 1 WITH TIES
	st.StudentId,
	st.FirstName,
	st.LastName,
	st.PhoneNumber,
	st.Major,
	st.Gpa,
	MIN(r.RegisterTime) RegisterTime 
FROM
	Students st
	INNER JOIN Registers r
	ON st.StudentId = r.StudentId
	INNER JOIN Subjects sj
	ON sj.SubjectId = r.SubjectId
GROUP BY
	r.StudentId,
	st.StudentId,
	st.FirstName,
	st.LastName,
	st.PhoneNumber,
	st.Major,
	st.Gpa
ORDER BY
	RegisterTime ASC;
GO
SELECT
	* 
FROM 
	fn_QueryTask6();



﻿-- Viết hàm tìm môn học được đăng ký sớm nhất.

CREATE OR ALTER FUNCTION fn_QueryTask7()
RETURNS TABLE
AS
RETURN
SELECT TOP 1 WITH TIES
	sj.SubjectId,
	sj.Name,
	sj.Credit,
	sj.NumOfLesson,
	sj.Type,
	MIN(r.RegisterTime) RegisterTime 
FROM
	Students st
	INNER JOIN Registers r
	ON st.StudentId = r.StudentId
	INNER JOIN Subjects sj
	ON sj.SubjectId = r.SubjectId
GROUP BY
	r.SubjectId,
	sj.SubjectId,
	sj.Name,
	sj.Credit,
	sj.NumOfLesson,
	sj.Type
ORDER BY
	RegisterTime ASC;
GO
SELECT
	* 
FROM 
	fn_QueryTask7();



﻿-- Viết hàm tìm số lượng nhân viên mà mỗi quản lý đang nắm giữ.

CREATE OR ALTER FUNCTION fn_QueryTask8()
RETURNS TABLE
AS
RETURN
SELECT
	m.StaffId,
	m.FirstName,
	m.LastName,
	m.PhoneNumber,
	m.Email,
	st.StoreName,
	COUNT(s.ManagerId) NumOfStaffs 
FROM
	Staffs s
	INNER JOIN Staffs m
	ON s.ManagerId = m.StaffId
	INNER JOIN Stores st
	ON st.StoreId = s.StoreId
GROUP BY
	s.ManagerId,
	m.StaffId,
	m.FirstName,
	m.LastName,
	m.PhoneNumber,
	m.Email,
	st.StoreName;
GO
SELECT
	*
FROM
	fn_QueryTask8()
ORDER BY
	NumOfStaffs DESC;




﻿-- Viết hàm tìm sinh viên đăng ký môn học nhiều thứ hai.
-- B1: đếm số lần đăng ký của từng SV, lấy 2 giá trị không trùng nhau cao nhất
-- B2: tìm giá trị min của kết quả ở B1
-- B3: tìm SV có số lần đăng ký bằng giá trị min ở B2
-- áp dụng tương tự cho các yêu cầu tìm giá trị lớn thứ 2: 
-- điểm cao thứ hai, lương cao thứ hai, ...

CREATE OR ALTER FUNCTION fn_QueryTask9()
RETURNS TABLE
AS
RETURN
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
	);
GO
SELECT
	* 
FROM 
	fn_QueryTask9();




﻿-- Viết hàm tìm môn học được sinh viên đăng ký nhiều thứ hai.
-- B1: đếm số lần đăng ký của từng môn, lấy 2 giá trị không trùng nhau cao nhất
-- B2: tìm giá trị min của kết quả ở B1
-- B3: tìm môn học có số lần đăng ký bằng giá trị min ở B2

CREATE OR ALTER FUNCTION fn_QueryTask10()
RETURNS TABLE
AS
RETURN
SELECT
	s.SubjectId,
	s.Name,
	s.Credit,
	s.NumOfLesson,
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
	s.NumOfLesson,
	s.Type
HAVING
	-- B3:
	COUNT(r.SubjectId) = (
		-- B2
		SELECT MIN(result.Registered)
		FROM
			(
				-- B1:
				SELECT DISTINCT TOP 2	
					COUNT(rg.SubjectId) AS Registered
				FROM
					Subjects s
					INNER JOIN Registers rg
					ON s.SubjectId = rg.SubjectId
				GROUP BY
					s.SubjectId
				ORDER BY
					Registered DESC
			) result
	);
GO
SELECT
	* 
FROM 
	fn_QueryTask10();