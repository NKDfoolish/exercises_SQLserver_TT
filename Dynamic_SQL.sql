﻿-- lệnh thực thi thủ tục chạy ok:
EXEC usp_CountResult
	'Students',
	'Gpa',
	'>=',
	'3.5';
-- 
EXEC usp_CountResult
	'Subjects',
	'Credit',
	'>=',
	'4';
-- lệnh tấn công SQL injection:
-- xóa bỏ đi để xem các kết quả bên trên
EXEC usp_CountResult
	'Students',
	'Gpa',
	'>=',
	'3.5; DROP TABLE Students;';


﻿-- Viết lệnh SQL động cho phép đếm số bản ghi trong bảng 
-- được chỉ định thỏa mãn tiêu chí của cột nào đó.
CREATE OR ALTER PROC usp_CountResult( 
	@tableName NVARCHAR(200),
	@colName NVARCHAR(200),
	@expression NVARCHAR(2),
	@value NVARCHAR(100)
) AS 
BEGIN 
	IF CHARINDEX(';', @value) = 0
	BEGIN
		DECLARE @sql NVARCHAR(MAX); 
		SET @sql = N'SELECT COUNT(*) AS Result FROM ' + QUOTENAME(@tableName) + 
			' WHERE ' + QUOTENAME(@colName) + ' ' + @expression + @value;
		-- thực thi lệnh SQL
		EXEC sp_executesql @sql;
	END
	ELSE
		RAISERROR('Định chơi xỏ anh à thím?', 16, 1);
END



-- lệnh thực thi thủ tục chạy ok:
EXEC usp_SelectTopN
	'Students',
	5,
	'Gpa';

-- lệnh thứ 2:
EXEC usp_SelectTopN
	'Stores',
	3,
	'StoreName';

-- lệnh thực thi có tấn công SQL injection
EXEC usp_SelectTopN
	'Stores',
	3,
	'StoreName; DROP TABLE Registers;';


-- Viết lệnh SQL động cho phép select ra top n dòng và các dòng 
-- cùng giá trị sắp xếp giảm dần theo tiêu chí nào đó.
CREATE OR ALTER PROC usp_SelectTopN( 
	@tableName NVARCHAR(200),
	@topN INT,
	@colName NVARCHAR(200)
) AS 
BEGIN 
	DECLARE @topNStr NVARCHAR(20) = CAST(@topN AS VARCHAR(20));
	DECLARE @sql NVARCHAR(MAX); 
	SET @sql = N'SELECT TOP ' + @topNStr + ' WITH TIES * FROM ' + 
		QUOTENAME(@tableName) + 
		' ORDER BY ' + QUOTENAME(@colName) + ' DESC';
	-- thực thi lệnh SQL
	EXEC sp_executesql @sql;
END


﻿-- lệnh thực thi thủ tục chạy ok:
EXEC usp_RemoveRecord
	'Subjects',
	'SubjectId',
	'=',
	'Something';

-- lệnh SQL injection nếu được thực thi sẽ xóa toàn bộ dữ liệu trong bảng
EXEC usp_RemoveRecord
	'Test',
	'1 LIKE 1 OR Id',
	'=',
	'0';

-- lệnh SQL injection nếu được thực thi sẽ xóa toàn bộ dữ liệu trong bảng
EXEC usp_RemoveRecord
	'Subjects',
	'1 = 1 OR Subject',
	'=',
	'0';

-- lệnh SQL injection nếu được thực thi sẽ xóa toàn bộ dữ liệu trong bảng và bảng khác
EXEC usp_RemoveRecord
	'Subjects',
	'1 = 1 OR Subject',
	'=',
	'0; DELETE FROM Subjects;';


﻿-- Viết lệnh SQL động xóa dữ liệu của một bảng nào đó theo tiêu chí cho trước.
CREATE OR ALTER PROC usp_RemoveRecord( 
	@tableName NVARCHAR(200),
	@col NVARCHAR(200),
	@operator VARCHAR(5),
	@value NVARCHAR(200)
) AS 
BEGIN 
	IF CHARINDEX(';', @value) = 0 AND
		(@col NOT LIKE '%[^a-z0-9 ]%' ) -- không được chứa các biểu thức như =, >=, <=

	BEGIN
		DECLARE @sql NVARCHAR(MAX); 
		SET @sql = N'DELETE FROM ' + QUOTENAME(@tableName) +
			' WHERE ' + QUOTENAME(@col) + @operator + '@value';
		-- thực thi lệnh SQL. Sử dụng tham số hóa để tránh lỗi Invalid column name 'xyz' 
		-- với xyz là giá trị trong biến @value
		EXEC sp_executesql @sql, N'@value NVARCHAR(200)', @value = @value;
	END
	ELSE
		RAISERROR('Định chơi xỏ anh à thím?', 16, 1);
END


-- lệnh thực thi bình thường:
EXEC usp_UpdateRecords
	'Subjects',
	'SubjectId',
	'SUBJ1206',
	'NumOfLesson',
	'38';

-- lệnh thực thi có SQL injection
EXEC usp_UpdateRecords
	'Subjects',
	'SubjectId',
	'SUBJ1206',
	'1 = 1 OR NumOfLesson',
	'38';

-- lệnh thực thi có SQL injection
EXEC usp_UpdateRecords
	'Subjects',
	'SubjectId',
	'SUBJ1206',
	'NumOfLesson',
	'38; DROP TABLE Stores;';


-- Viết lệnh SQL động sửa dữ liệu của một bản ghi nào đó theo tiêu chí cho trước.
CREATE OR ALTER PROC usp_UpdateRecords( 
	@tableName NVARCHAR(200),
	@idColName NVARCHAR(200),
	@idValue NVARCHAR(200),
	@colName NVARCHAR(200),
	@value NVARCHAR(200)
) AS 
BEGIN 
	IF CHARINDEX(';', @value) = 0 AND
		(@colName NOT LIKE '%[^a-z0-9 ]%' ) -- không được chứa các biểu thức như =, >=, <=

	BEGIN
		DECLARE @sql NVARCHAR(MAX); 
		SET @sql = N'UPDATE ' + QUOTENAME(@tableName) +
			' SET ' + QUOTENAME(@colName) + ' = @value' +
			' WHERE ' + @idColName + ' = @idValue';
		-- thực thi lệnh SQL. Sử dụng tham số hóa để tránh lỗi Invalid column name 'xyz' 
		-- với xyz là giá trị trong biến @value
		EXEC sp_executesql 
			@sql, 
			N'@value NVARCHAR(200), @idValue NVARCHAR(200)', 
			@value = @value,
			@idValue = @idValue;
	END
	ELSE
		RAISERROR('Định chơi xỏ anh à thím?', 16, 1);
END


-- Lấy thông tin các môn học có 4 tín chỉ và trong tên có chữ C.
EXEC usp_GetRecords
	'Subjects',
	'Name',
	'LIKE',
	'%c%',
	'AND',
	'Credit',
	'=',
	'4';

-- Lấy thông tin sinh viên học CNTT sinh vào các tháng chẵn
EXEC usp_GetRecords
	'Students',
	'Major',
	'=',
	'CNTT',
	'AND',
	'MONTH(BirthDate)',
	'% 2 =',
	'0';

-- Lấy thông tin các cửa hàng có địa chỉ ở quận Cầu Giấy hoặc Nam Từ Liêm
EXEC usp_GetRecords
	'Stores',
	'District',
	'=',
	N'Cầu Giấy',
	'OR',
	'District',
	'=',
	N'Nam Từ Liêm';

-- Lệnh thực thi chứa SQL injection
EXEC usp_GetRecords
	'Stores',
	'District',
	'=',
	N'Cầu Giấy',
	'OR',
	'District',
	'=',
	N'Nam Từ Liêm; DROP TABLE Stores;';



-- Viết lệnh SQL động cho phép chọn ra tất cả các dòng 
-- trong bảng nào đó thỏa mãn các tiêu chí cho trước.
CREATE OR ALTER PROC usp_GetRecords( 
	@tableName NVARCHAR(200),
	@col1 NVARCHAR(200),
	@operator1 NVARCHAR(10),
	@value1 NVARCHAR(200),
	@connection NVARCHAR(10),
	@col2 NVARCHAR(200),
	@operator2 NVARCHAR(10),
	@value2 NVARCHAR(200)
) AS 
BEGIN 
	IF CHARINDEX(';', @value2) = 0
	BEGIN
		DECLARE @sql NVARCHAR(MAX); 
		SET @sql = 'SELECT * FROM ' + QUOTENAME(@tableName) +
			' WHERE ' + QUOTENAME(@col1) + @operator1 + '@value1' +
			@connection + ' ' + @col2 + '=@value2';
		-- thực thi lệnh SQL. Sử dụng tham số hóa để tránh lỗi Invalid column name 'xyz' 
		-- với xyz là giá trị trong biến @value
		EXEC sp_executesql 
			@sql, 
			N'@value1 NVARCHAR(200), @value2 NVARCHAR(200)', 
			@value1 = @value1,
			@value2 = @value2;
	END
	ELSE
		RAISERROR('Định chơi xỏ anh à thím?', 16, 1);
END