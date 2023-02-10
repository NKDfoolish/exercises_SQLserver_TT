-- Hãy cho biết sinh viên nào có điểm cao nhất học ngành CNTT.
CREATE OR ALTER PROCEDURE usp_Find_Max_Grade_Of_Students(
	@major NVARCHAR(100),
	@maxGPA FLOAT OUT
)
AS
BEGIN
	SELECT
		@maxGPA = MAX(GPA)
	FROM
		dbo.Students
	WHERE
		Major = @major;
	-- print Students
	SELECT
		*
	FROM
		Students
	WHERE
		GPA = @maxGPA
END;

DECLARE @maxStudentsGPA FLOAT;
DECLARE @majorOfStudents NVARCHAR(100);
SET @majorOfStudents = 'CNTT'

EXEC usp_Find_Max_Grade_Of_Students 
	@major = @majorOfStudents,
	@maxGPA = @maxStudentsGPA OUTPUT;

PRINT @maxStudentsGPA;


-- cach 2:
CREATE OR ALTER PROC usp_FindMaxGpaStudent(
	@maxGpa FLOAT OUT
)
AS
BEGIN
	SELECT
		@maxGpa = MAX(Gpa)
	FROM
		Students;
	--
	SELECT 
		*
	FROM
		Students
	WHERE
		Gpa = @maxGpa;
END;

DECLARE @maxGpaOfStudents FLOAT;
EXEC usp_FindMaxGpaStudent @maxGpa = @maxGpaOfStudents OUT;
PRINT @maxGpaOfStudents;


-- Hãy cho biết tên, ngày sinh, điểm TB của các sinh viên trong bảng Student. Chỉ rõ thông tin sinh viên có điểm thấp nhất?
create or alter proc usp_test
(
@minGpa float out
)
as
begin
select @minGpa = min(Gpa)
from
students;
select
firstname,
birthdate,
gpa
from
students
where
gpa = @minGpa;
end;

declare @minGpaStudents float;
exec usp_test @minGpa = @minGpaStudents output;


-- Hãy cho biết tên người quản lý và cửa hàng nơi làm việc của nhân viên mã X cho trước.
CREATE OR ALTER PROC usp_FindStaffInfo(
	@staffId INT,
	@managerName NVARCHAR(50) OUT,
	@storeName NVARCHAR(255) OUT
)
AS
BEGIN
	SELECT 
		@managerName = m.FirstName + ' ' + m.LastName,
		@storeName = st.StoreName
	FROM
		Stores st INNER JOIN Staffs s
		ON st.StoreId = s.StoreId
		INNER JOIN Staffs m
		ON s.ManagerId = m.StaffId
	WHERE
		s.StaffId = @staffId;
END;

﻿-- khai báo biến
DECLARE @managerName NVARCHAR(50);
DECLARE @storeName NVARCHAR(50);
DECLARE @staffId INT;

-- gán giá trị mã nhân viên
SET @staffId = 6;

EXEC usp_FindStaffInfo 
	@staffId,
	@managerName = @managerName OUT,
	@storeName = @storeName OUT;

-- hiển thị giá trị lấy đc
SELECT 
	@staffId 'Mã nhân viên',
	@managerName 'Tên người quản lý',
	@storeName 'Tên cửa hàng đang làm việc';

-- Hãy cho biết số lượng nhân viên dưới quyền mà quản lý X đang quản lý.
CREATE OR ALTER PROC usp_CountManagedStaffs(
	@staffId INT,
	@numberOfStaff INT OUT
)
AS
BEGIN
	SELECT 
		@numberOfStaff = COUNT(s.ManagerId)
	FROM
		Staffs s INNER JOIN Staffs m
		ON s.ManagerId = m.StaffId
	WHERE
		m.StaffId = @staffId;
END;

﻿-- khai báo biến
DECLARE @staffId INT;
DECLARE @numberOfStaff INT;

-- gán giá trị mã nhân viên
SET @staffId = 15;

EXEC usp_CountManagedStaffs 
	@staffId = @staffId,
	@numberOfStaff = @numberOfStaff OUT;

-- hiển thị giá trị min gpa lấy đc
SELECT 
	@staffId 'Mã nhân viên quản lý',
	@numberOfStaff 'Số lượng nhân viên dưới quyền'

-- cho biết họ và tên, cửa hàng đang làm việc, số lượng nhân viên họ đang quản lý của người quản lý có nhiều nhân viên dưới quyền nhất?

CREATE OR ALTER PROC usp_FindBestManager(
	@fullName NVARCHAR(50) OUT,
	@storeName NVARCHAR(50) OUT,
	@numberOfStaff INT OUT
)
AS
BEGIN
	SELECT TOP 1
		@fullName = m.LastName + ' ' + m.FirstName,
		@storeName = st.StoreName,
		@numberOfStaff = COUNT(s.ManagerId)
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
		COUNT(s.ManagerId) DESC;
END;


﻿-- khai báo biến
DECLARE @fullName NVARCHAR(50),
	@storeName NVARCHAR(50),
	@numberOfStaff INT;

EXEC usp_FindBestManager 
	@fullName = @fullName OUT,
	@storeName = @storeName OUT,
	@numberOfStaff = @numberOfStaff OUT;

-- hiển thị giá trị lấy đc
SELECT 
	@fullName 'Tên người quản lý',
	@numberOfStaff 'Số lượng nhân viên dưới quyền',
	@storeName 'Tên cửa hàng đang làm việc';