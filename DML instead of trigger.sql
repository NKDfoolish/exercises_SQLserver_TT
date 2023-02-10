﻿-- tạo bảng chứa thông tin sinh viên cần kiểm duyệt

CREATE TABLE StudentApprovals( 
	StudentApprovalId INT IDENTITY(1, 1) PRIMARY KEY, 
	StudentId VARCHAR(50), 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	MidName NVARCHAR(50), 
	Address NVARCHAR(50),
	Major NVARCHAR(50),
	BirthDate DATE, 
	PhoneNumber VARCHAR(50), 
	Gpa FLOAT 
);

﻿-- tạo view vw_StudentApprovalInfo

CREATE VIEW vw_StudentApprovalInfo 
AS 
	SELECT 
		s.StudentId,
		s.FirstName,
		s.LastName,
		s.MidName,
		s.Address,
		s.Major,
		s.BirthDate,
		s.PhoneNumber,
		s.Gpa, 
		'Approved' [Approval Status] 
	FROM 
		Students s
	UNION 
	SELECT 
		sa.StudentId,
		sa.FirstName,
		sa.LastName,
		sa.MidName,
		sa.Address,
		sa.Major,
		sa.BirthDate,
		sa.PhoneNumber,
		sa.Gpa, 
		'Pending Approval' [Approval Status] 
	FROM 
		StudentApprovals sa


﻿-- tạo trigger cho chức năng thêm mới sinh viên vào view

CREATE OR ALTER TRIGGER TR_StudentApprovalInfo_Insert 
ON vw_StudentApprovalInfo 
INSTEAD OF INSERT 
AS 
BEGIN
	INSERT INTO StudentApprovals(
		StudentId,
		FirstName,
		LastName,
		MidName,
		Address,
		Major,
		BirthDate,
		PhoneNumber,
		Gpa
	)
	SELECT
		s.StudentId,
		s.FirstName,
		s.LastName,
		s.MidName,
		s.Address,
		s.Major,
		s.BirthDate,
		s.PhoneNumber,
		s.Gpa
	FROM
		inserted s
	WHERE
		s.StudentId NOT IN(
			SELECT	
				StudentId
			FROM
				Students
		);
END;



﻿-- chèn dữ liệu vào view và truy vấn dữ liệu trong view 

/*
INSERT INTO vw_StudentApprovalInfo( 
	StudentId,
	FirstName,
	LastName,
	MidName,
	Address,
	Major,
	BirthDate,
	PhoneNumber,
	Gpa
) 
VALUES
	('B25DCCN112', N'Phú', N'Mai', N'Đức', N'Hải Phòng', N'CNTT', '2007-04-08', '0359553318', 3.29),
	('B25DCCN113', N'Anh', N'Đàm', N'Ngọc', N'Bình Dương', N'CNTT', '2007-05-24', '0359553317', 3.69);
*/

SELECT * FROM vw_StudentApprovalInfo;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

﻿-- tạo bảng chứa thông tin sinh viên cần kiểm duyệt trước khi update

CREATE TABLE StudentUpdateApprovals( 
	StudentApprovalId INT IDENTITY(1, 1) PRIMARY KEY, 
	StudentId VARCHAR(50), 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	MidName NVARCHAR(50), 
	Address NVARCHAR(50),
	Major NVARCHAR(50),
	BirthDate DATE, 
	PhoneNumber VARCHAR(50), 
	Gpa FLOAT 
);


﻿-- tạo view vw_StudentApprovalInfo

CREATE OR ALTER VIEW vw_StudentApprovalInfo 
AS 
	SELECT 
		s.StudentId,
		s.FirstName,
		s.LastName,
		s.MidName,
		s.Address,
		s.Major,
		s.BirthDate,
		s.PhoneNumber,
		s.Gpa, 
		'Not Approved' [Approval Status] 
	FROM 
		Students s
	WHERE
		s.StudentId NOT IN(
			SELECT 
				StudentId
			FROM 
				StudentUpdateApprovals
		)
	UNION 
	SELECT 
		sa.StudentId,
		sa.FirstName,
		sa.LastName,
		sa.MidName,
		sa.Address,
		sa.Major,
		sa.BirthDate,
		sa.PhoneNumber,
		sa.Gpa, 
		'Pending Approval' [Approval Status] 
	FROM 
		StudentUpdateApprovals sa


﻿-- tạo trigger cho chức năng cập nhật thông tin sinh viên vào bảng Students

CREATE OR ALTER TRIGGER TR_StudentApprovalInfo_Update 
ON Students
INSTEAD OF UPDATE 
AS 
BEGIN
	INSERT INTO StudentUpdateApprovals(
		StudentId,
		FirstName,
		LastName,
		MidName,
		Address,
		Major,
		BirthDate,
		PhoneNumber,
		Gpa
	)
	SELECT
		s.StudentId,
		s.FirstName,
		s.LastName,
		s.MidName,
		s.Address,
		s.Major,
		s.BirthDate,
		s.PhoneNumber,
		s.Gpa
	FROM
		inserted s
	WHERE
		s.StudentId IN(
			SELECT	
				StudentId
			FROM
				deleted
		);
END;



﻿-- cập nhật dữ liệu trong bảng Students
UPDATE Students
SET
	Gpa = 3.58
WHERE
	StudentId = 'B25DCCN111';

-- kiểm tra view
SELECT * FROM vw_StudentApprovalInfo;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

﻿-- tạo bảng chứa thông tin sinh viên cần kiểm duyệt

CREATE TABLE StudentRemoveApprovals( 
	StudentApprovalId INT IDENTITY(1, 1) PRIMARY KEY, 
	StudentId VARCHAR(50), 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	MidName NVARCHAR(50), 
	Address NVARCHAR(50),
	Major NVARCHAR(50),
	BirthDate DATE, 
	PhoneNumber VARCHAR(50), 
	Gpa FLOAT 
);


﻿-- tạo view vw_StudentApprovalInfo

CREATE OR ALTER VIEW vw_StudentApprovalInfo 
AS 
	SELECT 
		s.StudentId,
		s.FirstName,
		s.LastName,
		s.MidName,
		s.Address,
		s.Major,
		s.BirthDate,
		s.PhoneNumber,
		s.Gpa, 
		'Not Approved' [Approval Status] 
	FROM 
		Students s
	WHERE
		s.StudentId NOT IN(
			SELECT
				StudentId
			FROM 
				StudentRemoveApprovals
		)
	UNION 
	SELECT 
		sa.StudentId,
		sa.FirstName,
		sa.LastName,
		sa.MidName,
		sa.Address,
		sa.Major,
		sa.BirthDate,
		sa.PhoneNumber,
		sa.Gpa, 
		'Pending Approval' [Approval Status] 
	FROM 
		StudentRemoveApprovals sa


﻿-- tạo trigger cho chức năng thêm xóa sinh viên khỏi bảng Students

CREATE OR ALTER TRIGGER TR_StudentApprovalInfo_Remove
ON Students 
INSTEAD OF DELETE 
AS 
BEGIN
	INSERT INTO StudentRemoveApprovals(
		StudentId,
		FirstName,
		LastName,
		MidName,
		Address,
		Major,
		BirthDate,
		PhoneNumber,
		Gpa
	)
	SELECT
		s.StudentId,
		s.FirstName,
		s.LastName,
		s.MidName,
		s.Address,
		s.Major,
		s.BirthDate,
		s.PhoneNumber,
		s.Gpa
	FROM
		deleted s
	WHERE
		s.StudentId NOT IN(
			SELECT	
				StudentId
			FROM
				inserted
		);
END;


﻿-- cập nhật dữ liệu trong bảng Students
DELETE FROM Students
WHERE
	StudentId = 'B25DCCN111';

-- kiểm tra view
SELECT * FROM vw_StudentApprovalInfo;