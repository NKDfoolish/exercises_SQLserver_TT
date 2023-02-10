CREATE TABLE TableChangeLogs(
	ChangeLogId INT IDENTITY PRIMARY KEY,
	[Event Data] XML NOT NULL,
	[Change By] SYSNAME NOT NULL
);


﻿-- Cú pháp của DDL trigger giám sát thay đổi của bảng:
CREATE TRIGGER TR_Table_ChangeLogs
ON DATABASE
FOR 
	CREATE_TABLE,
	DROP_TABLE,
	ALTER_TABLE
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO TableChangeLogs(
		[Event Data],
		[Change By]
	)
	VALUES (EVENTDATA(), USER);
END


﻿-- test kết quả
DROP TABLE IF EXISTS Test;
DROP TABLE IF EXISTS TestTable1;
DROP TABLE IF EXISTS TestTable1;
CREATE TABLE TestTable1(Id INT PRIMARY KEY IDENTITY);
CREATE TABLE TestTable2(Id INT PRIMARY KEY IDENTITY);
CREATE TABLE Test(Id INT PRIMARY KEY IDENTITY);
-- drop
DROP TABLE TestTable1;
DROP TABLE TestTable2;
--alter table
ALTER TABLE
	Test
ADD FullName NVARCHAR(200);






﻿-- tạo bảng lưu thay đổi của view
CREATE TABLE ViewChangeLogs(
	ChangeLogId INT IDENTITY PRIMARY KEY,
	[Event Data] XML NOT NULL,
	[Change By] SYSNAME NOT NULL
);

﻿-- Cú pháp của DDL trigger giám sát thay đổi của view:
CREATE TRIGGER TR_View_ChangeLogs
ON DATABASE
FOR 
	CREATE_VIEW,
	DROP_VIEW,
	ALTER_VIEW
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO ViewChangeLogs(
		[Event Data],
		[Change By]
	)
	VALUES (EVENTDATA(), USER);
END

CREATE OR ALTER VIEW vw_StudentsInfo1
AS
SELECT * FROM Students;

SELECT * FROM ViewChangeLogs;







﻿-- tạo bảng lưu thay đổi của view
CREATE TABLE IndexChangeLogs(
	ChangeLogId INT IDENTITY PRIMARY KEY,
	[Event Data] XML NOT NULL,
	[Change By] SYSNAME NOT NULL
);

﻿-- Cú pháp của DDL trigger giám sát thay đổi của view:
CREATE OR ALTER TRIGGER TR_Index_ChangeLogs
ON DATABASE
FOR 
	CREATE_INDEX,
	DROP_INDEX,
	ALTER_INDEX
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO IndexChangeLogs(
		[Event Data],
		[Change By]
	)
	VALUES (EVENTDATA(), USER);
END


CREATE INDEX IX_Teachers_FullName
ON Teachers(FirstName, LastName);

﻿-- kiểm tra xem có dữ liệu ghi vào bảng IndexChangeLogs không
select * from indexchangelogs;