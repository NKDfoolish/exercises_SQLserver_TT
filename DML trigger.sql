﻿-- tạo bảng giám sát thay đổi của bảng Students

CREATE TABLE StudentAudits( 
	StudentAuditId INT IDENTITY PRIMARY KEY, 
	StudentId VARCHAR(50) NOT NULL, 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	MidName NVARCHAR(50), 
	Address NVARCHAR(50), 
	Major NVARCHAR(50), 
	BirthDate DATETIME NOT NULL,
	PhoneNumber VARCHAR(50),
	Gpa FLOAT, 
	UpdateAt DATETIME NOT NULL, 
	Operation CHAR(3) NOT NULL, 
	CHECK(Operation = 'INS' OR Operation = 'DEL' OR Operation = 'UPD') 
);


-- tạo trigger giám sát thay đổi của dữ liệu trong bảng Students

CREATE OR ALTER TRIGGER TR_StudentAudits_AfterIUD 
ON dbo.Students 
AFTER INSERT, DELETE, UPDATE 
AS BEGIN 
	SET NOCOUNT ON; -- không hiển thị thông báo đã chèn bản ghi thành công vào 
	-- bảng giám sát khi trigger được kích hoạt 
	INSERT INTO StudentAudits( 
		StudentId,
		FirstName,
		LastName,
		MidName,
		Address,
		Major,
		BirthDate,
		PhoneNumber,
		Gpa, 
		UpdateAt, 
		Operation 
	) 
	SELECT 
		ins.StudentId,
		ins.FirstName,
		ins.LastName,
		ins.MidName,
		ins.Address,
		ins.Major,
		ins.BirthDate,
		ins.PhoneNumber,
		ins.Gpa, 
		GETDATE(), 
		'INS' 
	FROM 
		INSERTED ins
	WHERE
		ins.StudentId NOT IN( -- chỉ xét các bản ghi mới chèn vào
			SELECT 
				StudentId
			FROM
				deleted
		)
	UNION ALL 
	SELECT 
		ins.StudentId,
		ins.FirstName,
		ins.LastName,
		ins.MidName,
		ins.Address,
		ins.Major,
		ins.BirthDate,
		ins.PhoneNumber,
		ins.Gpa, 
		GETDATE(), 
		'UPD' 
	FROM 
		INSERTED ins
	WHERE
		ins.StudentId IN( -- chỉ xét các bản ghi được update
			SELECT 
				StudentId
			FROM
				deleted
		)
	UNION ALL
	SELECT 
		del.StudentId,
		del.FirstName,
		del.LastName,
		del.MidName,
		del.Address,
		del.Major,
		del.BirthDate,
		del.PhoneNumber,
		del.Gpa, 
		GETDATE(), 
		'DEL' 
	FROM 
		DELETED del
	WHERE
		del.StudentId NOT IN( -- chỉ xét các bản ghi bị xóa bỏ
			SELECT 
				StudentId
			FROM
				inserted
		)
END


-- chèn, sửa, xóa dữ liệu trong bảng Students và kiểm tra kết quả trong bảng StudentAudits
-- chèn
INSERT INTO Students( 
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
	('B25DCCN109', N'Trung', N'Mai', N'Đức', N'Hà Nam', N'CNTT', '2007-09-08', '0359553314', 3.39),
	('B25DCCN111', N'Ánh', N'Lưu', N'Ngọc', N'Kiên Giang', N'CNTT', '2007-05-09', '0359553319', 3.49);

-- sửa
UPDATE Students
SET
	Gpa = 3.55
WHERE
	StudentId = 'B25DCCN109';

-- xóa
DELETE FROM	
	Students
WHERE
	StudentId = 'B25DCCN109';

-- kiểm tra dữ liệu
SELECT 
	* 
FROM 
	StudentAudits;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- tạo bảng giám sát thay đổi của bảng Subjects

CREATE TABLE SubjectAudits( 
	SubjectAuditId INT IDENTITY PRIMARY KEY, 
	SubjectId VARCHAR(50) NOT NULL, 
	Name NVARCHAR(50), 
	Credit INT,
	NumOfLesson INT, 
	Type NVARCHAR(50), 
	UpdateAt DATETIME NOT NULL, 
	Operation CHAR(3) NOT NULL, 
	CHECK(Operation = 'INS' OR Operation = 'DEL' OR Operation = 'UPD') 
);

-- tạo trigger giám sát thay đổi của dữ liệu trong bảng Subjects

CREATE OR ALTER TRIGGER TR_SubjectAudits_AfterIUD 
ON dbo.Subjects 
AFTER INSERT, DELETE, UPDATE 
AS BEGIN 
	SET NOCOUNT ON;
	INSERT INTO SubjectAudits( 
		SubjectId,
		Name,
		Credit,
		NumOfLesson,
		Type,
		UpdateAt, 
		Operation 
	) 
	SELECT 
		ins.SubjectId,
		ins.Name,
		ins.Credit,
		ins.NumOfLesson,
		ins.Type,
		GETDATE(), 
		'INS' 
	FROM 
		INSERTED ins
	WHERE
		ins.SubjectId NOT IN( -- chỉ xét các bản ghi mới chèn vào
			SELECT 
				SubjectId
			FROM
				deleted
		)
	UNION ALL 
	SELECT 
		ins.SubjectId,
		ins.Name,
		ins.Credit,
		ins.NumOfLesson,
		ins.Type,
		GETDATE(), 
		'UPD' 
	FROM 
		INSERTED ins
	WHERE
		ins.SubjectId IN( -- chỉ xét các bản ghi được update
			SELECT 
				SubjectId
			FROM
				deleted
		)
	UNION ALL
	SELECT 
		del.SubjectId,
		del.Name,
		del.Credit,
		del.NumOfLesson,
		del.Type,
		GETDATE(), 
		'DEL' 
	FROM 
		DELETED del
	WHERE
		del.SubjectId NOT IN( -- chỉ xét các bản ghi bị xóa bỏ
			SELECT 
				SubjectId
			FROM
				inserted
		)
END

﻿-- chèn, sửa, xóa dữ liệu trong bảng Subjects và kiểm tra kết quả trong bảng SubjectAudits
-- chèn
INSERT INTO Subjects( 
	SubjectId,
	Name,
	Credit,
	NumOfLesson,
	Type
) 
VALUES
	('SUBJ901', N'Nhập môn công nghệ phần mềm', 4, 48, N'Chuyên ngành'),
	('SUBJ902', N'Lập trình mạng', 3, 36, N'Chuyên ngành');

-- sửa
UPDATE Subjects
SET
	Credit = 3,
	NumOfLesson = 36
WHERE
	SubjectId = 'SUBJ901';

-- xóa
DELETE FROM	
	Subjects
WHERE
	SubjectId = 'SUBJ902';

-- kiểm tra dữ liệu
SELECT 
	* 
FROM 
	SubjectAudits;


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
﻿-- tạo bảng giám sát thay đổi của bảng Staffs

CREATE TABLE StaffAudits( 
	StaffAuditId INT IDENTITY PRIMARY KEY, 
	StaffId VARCHAR(50) NOT NULL, 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	Email NVARCHAR(100), 
	PhoneNumber NVARCHAR(20),
	Active BIT, 
	StoreId INT, 
	ManagerId INT,
	UpdateAt DATETIME NOT NULL, 
	Operation CHAR(3) NOT NULL, 
	CHECK(Operation = 'INS' OR Operation = 'DEL' OR Operation = 'UPD') 
);


﻿-- tạo trigger giám sát thay đổi của dữ liệu trong bảng Staffs

CREATE OR ALTER TRIGGER TR_StaffAudits_AfterIUD 
ON dbo.Staffs 
AFTER INSERT, DELETE, UPDATE 
AS BEGIN 
	SET NOCOUNT ON;
	INSERT INTO StaffAudits( 
		StaffId,
		FirstName,
		LastName,
		Email,
		PhoneNumber,
		Active,
		StoreId,
		ManagerId,
		UpdateAt, 
		Operation 
	) 
	SELECT 
		ins.StaffId,
		ins.FirstName,
		ins.LastName,
		ins.Email,
		ins.PhoneNumber,
		ins.Active,
		ins.StoreId,
		ins.ManagerId,
		GETDATE(), 
		'INS' 
	FROM 
		INSERTED ins
	WHERE
		ins.StaffId NOT IN( -- chỉ xét các bản ghi mới chèn vào
			SELECT 
				StaffId
			FROM
				deleted
		)
	UNION ALL 
	SELECT 
		ins.StaffId,
		ins.FirstName,
		ins.LastName,
		ins.Email,
		ins.PhoneNumber,
		ins.Active,
		ins.StoreId,
		ins.ManagerId,
		GETDATE(), 
		'UPD' 
	FROM 
		INSERTED ins
	WHERE
		ins.StaffId IN( -- chỉ xét các bản ghi được update
			SELECT 
				StaffId
			FROM
				deleted
		)
	UNION ALL
	SELECT 
		del.StaffId,
		del.FirstName,
		del.LastName,
		del.Email,
		del.PhoneNumber,
		del.Active,
		del.StoreId,
		del.ManagerId,
		GETDATE(), 
		'DEL' 
	FROM 
		DELETED del
	WHERE
		del.StaffId NOT IN( -- chỉ xét các bản ghi bị xóa bỏ
			SELECT 
				StaffId
			FROM
				inserted
		)
END

﻿-- chèn, sửa, xóa dữ liệu trong bảng Staffs và kiểm tra kết quả trong bảng StaffAudits
-- chèn
INSERT INTO Staffs( 
	FirstName,
	LastName,
	Email,
	PhoneNumber,
	Active,
	StoreId,
	ManagerId
) 
VALUES
	(N'Quân', N'Đinh', 'dinhquan@xmail.com', '0936445774', 1, 3, 1),
	(N'Quyên', N'Mạc', 'macquyen@xmail.com', '0936445771', 1, 3, 1);

-- sửa
UPDATE Staffs
SET
	Email = 'trinhdinhquang@xmail.com'
WHERE
	StaffId = 27;

-- xóa
DELETE FROM	
	Staffs
WHERE
	StaffId = '27';

-- kiểm tra dữ liệu
SELECT 
	* 
FROM 
	StaffAudits;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


﻿-- tạo bảng giám sát thay đổi của bảng Registers

CREATE TABLE RegisterAudits( 
	RegisterAuditId INT IDENTITY PRIMARY KEY, 
	RegisterId INT NOT NULL, 
	StudentId NVARCHAR(50), 
	SubjectId NVARCHAR(50), 
	RegisterTime DATETIME, 
	RegisterStatus NVARCHAR(50),
	UpdateAt DATETIME NOT NULL, 
	Operation CHAR(3) NOT NULL, 
	CHECK(Operation = 'INS' OR Operation = 'DEL' OR Operation = 'UPD') 
);



﻿-- tạo trigger giám sát thay đổi của dữ liệu trong bảng Registers

CREATE OR ALTER TRIGGER TR_RegisterAudits_AfterIUD 
ON dbo.Registers 
AFTER INSERT, DELETE, UPDATE 
AS BEGIN 
	SET NOCOUNT ON;
	INSERT INTO RegisterAudits( 
		RegisterId,
		StudentId,
		SubjectId,
		RegisterTime,
		RegisterStatus,
		UpdateAt, 
		Operation 
	) 
	SELECT 
		ins.RegisterId,
		ins.StudentId,
		ins.SubjectId,
		ins.RegisterTime,
		ins.RegisterStatus,
		GETDATE(), 
		'INS' 
	FROM 
		INSERTED ins
	WHERE
		ins.RegisterId NOT IN( -- chỉ xét các bản ghi mới chèn vào
			SELECT 
				RegisterId
			FROM
				deleted
		)
	UNION ALL 
	SELECT 
		ins.RegisterId,
		ins.StudentId,
		ins.SubjectId,
		ins.RegisterTime,
		ins.RegisterStatus,
		GETDATE(), 
		'UPD' 
	FROM 
		INSERTED ins
	WHERE
		ins.RegisterId IN( -- chỉ xét các bản ghi được update
			SELECT 
				RegisterId
			FROM
				deleted
		)
	UNION ALL
	SELECT 
		del.RegisterId,
		del.StudentId,
		del.SubjectId,
		del.RegisterTime,
		del.RegisterStatus,
		GETDATE(), 
		'DEL' 
	FROM 
		DELETED del
	WHERE
		del.RegisterId NOT IN( -- chỉ xét các bản ghi bị xóa bỏ
			SELECT 
				RegisterId
			FROM
				inserted
		)
END


﻿-- chèn, sửa, xóa dữ liệu trong bảng Registers và kiểm tra kết quả trong bảng RegisterAudits
-- chèn
INSERT INTO Registers( 
	StudentId,
	SubjectId,
	RegisterStatus
) 
VALUES
	('B25DCCN111', 'SUBJ1204', N'Thành công'),
	('B25DCCN111', 'SUBJ1205', N'Thành công'),
	('B25DCCN111', 'SUBJ1206', N'Thành công');

-- sửa
UPDATE Registers
SET
	SubjectId = 'SUBJ1011'
WHERE
	RegisterId = (SELECT MAX(RegisterId) FROM Registers);

-- xóa
DELETE FROM	
	Registers
WHERE
	RegisterId = (SELECT MAX(RegisterId) FROM Registers);

-- kiểm tra dữ liệu
SELECT 
	* 
FROM 
	RegisterAudits;