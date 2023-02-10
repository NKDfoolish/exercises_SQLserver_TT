﻿-- Viết hàm tìm điểm thấp nhất của các sinh viên theo từng chuyên ngành trong bảng Students.

CREATE OR ALTER FUNCTION fn_FindStudentWithMinGpa(
	@major NVARCHAR(100)
)
RETURNS @tbl TABLE(
	Major NVARCHAR(50),
	MinGpa FLOAT
)
AS
BEGIN
	INSERT INTO @tbl
	SELECT
		Major,
		MIN(Gpa) MinGpa
	FROM
		Students
	GROUP BY
		Major
	HAVING
		Major = @major;
	RETURN;
END;
GO -- tìm điểm GPA min của từng chuyên ngành
SELECT
	*
FROM
	fn_FindStudentWithMinGpa('QTKD');




﻿-- Viết hàm tìm khách hàng tên dài nhất trong bảng Customers.

CREATE OR ALTER FUNCTION fn_FindLongestName()
RETURNS @tbl TABLE(
	CustomerId INT PRIMARY KEY,
	FirstName NVARCHAR(255),
	LastName NVARCHAR(255),
	PhoneNumber VARCHAR(25),
	Email VARCHAR(255),
	Street NVARCHAR(255),
	District NVARCHAR(255),
	City NVARCHAR(255)
)
AS
BEGIN
	INSERT INTO @tbl
	SELECT
		CustomerId,
		FirstName,
		LastName, 
		PhoneNumber,
		Email,
		Street,
		District,
		City
	FROM
		Customers
	WHERE
		LEN(FirstName) = (
			SELECT 
				MAX(LEN(c.FirstName))
			FROM
				Customers c
		);
	RETURN;
END;
GO -- tìm khách hàng tên dài nhất
SELECT
	*
FROM
	fn_FindLongestName();



-- Viết hàm phân loại học lực cho từng sinh viên trong bảng Students.

CREATE OR ALTER FUNCTION fn_Task3()
RETURNS @tbl TABLE(
	StudentId VARCHAR(50) PRIMARY KEY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	MidName NVARCHAR(50),
	Major NVARCHAR(150),
	Gpa FLOAT,
	Capacity NVARCHAR(100)
)
AS
BEGIN
	INSERT INTO @tbl
	SELECT
		StudentId,
		FirstName,
		LastName,
		MidName,
		Major,
		Gpa,
		CASE
			WHEN Gpa >= 3.6 AND Gpa <= 4.0 THEN N'Xuất Sắc'
			WHEN Gpa >= 3.2 THEN N'Giỏi'
			WHEN Gpa >= 2.8 THEN N'Khá'
			WHEN Gpa >= 2.4 THEN N'Trung bình'
			WHEN Gpa >= 2.0 THEN N'TB Yếu'
			ELSE N'Yếu'
		END Capacity
	FROM	
		Students;
	RETURN;
END;
GO -- tìm điểm GPA min của từng chuyên ngành
SELECT
	*
FROM
	fn_Task3()
ORDER BY
	Gpa DESC;



﻿-- Viết hàm tìm sinh viên đăng ký nhiều môn học nhất.

CREATE OR ALTER FUNCTION fn_Task4()
RETURNS @tbl TABLE(
	StudentId VARCHAR(50) PRIMARY KEY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	PhoneNumber NVARCHAR(50),
	Major NVARCHAR(50),
	Gpa FLOAT,
	NumOfRegistered INT
)
AS
BEGIN
	INSERT INTO @tbl
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
	RETURN;
END;
GO
SELECT
	* 
FROM 
	fn_Task4();



﻿-- Viết hàm tìm môn học được đăng kí nhiều nhất.

CREATE OR ALTER FUNCTION fn_Task5()
RETURNS @tbl TABLE(
	SubjectId VARCHAR(50) PRIMARY KEY,
	SubjectName NVARCHAR(100),
	Credit INT,
	NumOfLesson INT,
	Type NVARCHAR(100),
	NumOfRegister INT
)
AS
BEGIN
	INSERT INTO @tbl
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
	RETURN;
END;
GO
SELECT
	* 
FROM 
	fn_Task5();




﻿-- Viết hàm tìm sinh viên đăng ký môn học sớm nhất.

CREATE OR ALTER FUNCTION fn_Task6()
RETURNS @tbl TABLE(
	StudentId VARCHAR(50) PRIMARY KEY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	PhoneNumber VARCHAR(20),
	Major NVARCHAR(100),
	Gpa FLOAT,
	RegisterTime DATETIME
)
AS
BEGIN
	INSERT INTO @tbl
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
	RETURN;
END;
GO
SELECT
	* 
FROM 
	fn_Task6();



﻿-- Viết hàm tìm môn học được đăng ký sớm nhất.

CREATE OR ALTER FUNCTION fn_Task7()
RETURNS @tbl TABLE(
	SubjectId VARCHAR(50) PRIMARY KEY,
	Name NVARCHAR(50),
	Credit INT,
	NumOfLesson INT,
	Type NVARCHAR(100),
	RegisterTime DATETIME
)
AS
BEGIN
	INSERT INTO @tbl
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
	RETURN;
END;
GO
SELECT
	* 
FROM 
	fn_Task7();



﻿-- Viết hàm tìm số lượng nhân viên mà mỗi quản lý đang nắm giữ.

CREATE OR ALTER FUNCTION fn_Task8()
RETURNS @tbl TABLE(
	StaffId INT PRIMARY KEY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	PhoneNumber VARCHAR(20),
	Email VARCHAR(100),
	StoreName NVARCHAR(50),
	NumOfStaffs INT
)
AS
BEGIN
	INSERT INTO @tbl
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
	RETURN;
END;
GO
SELECT
	*
FROM
	fn_Task8()
ORDER BY
	NumOfStaffs DESC;



﻿-- Viết hàm tìm sinh viên đăng ký môn học nhiều thứ hai.
-- B1: đếm số lần đăng ký của từng SV, lấy 2 giá trị không trùng nhau cao nhất
-- B2: tìm giá trị min của kết quả ở B1
-- B3: tìm SV có số lần đăng ký bằng giá trị min ở B2
-- áp dụng tương tự cho các yêu cầu tìm giá trị lớn thứ 2: 
-- điểm cao thứ hai, lương cao thứ hai, ...

CREATE OR ALTER FUNCTION fn_Task9()
RETURNS @tbl TABLE(
	StudentId VARCHAR(50) PRIMARY KEY,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Major NVARCHAR(50),
	NumberOfRegistered INT
)
AS
BEGIN
	INSERT INTO @tbl
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
	RETURN;
END;
GO
SELECT
	* 
FROM 
	fn_Task9();


﻿-- Viết hàm tìm môn học được sinh viên đăng ký nhiều thứ hai.
-- B1: đếm số lần đăng ký của từng môn, lấy 2 giá trị không trùng nhau cao nhất
-- B2: tìm giá trị min của kết quả ở B1
-- B3: tìm môn học có số lần đăng ký bằng giá trị min ở B2

CREATE OR ALTER FUNCTION fn_Task10()
RETURNS @tbl TABLE(
	SubjectId NVARCHAR(50) PRIMARY KEY,
	SubjectName NVARCHAR(50),
	Credit INT,
	NumOfLesson INT,
	Type NVARCHAR(100),
	NumberOfRegistered INT
)
AS
BEGIN
	INSERT INTO @tbl
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
	RETURN;
END;
GO
SELECT
	* 
FROM 
	fn_Task10();
