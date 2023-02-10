﻿-- Hãy cho biết có bao nhiêu sinh viên có điểm Gpa >= 3.6. Nếu không có hiển thị 'Không có sinh viên nào thỏa mãn'.
BEGIN
	DECLARE @gpa FLOAT;
	DECLARE @result INT;
	SET @gpa = 3.6;

	SELECT 
		@result = COUNT(*)
	FROM
		Students
	WHERE
		Gpa >= @gpa;

	IF @result = 0
		BEGIN
			PRINT N'Không có sinh viên nào thỏa mãn';
		END
	ELSE
		BEGIN
			PRINT STR(@result, 2) + N' sinh viên có điểm Gpa >= ' + STR(@gpa, 4, 2);
		END
END

﻿-- Hãy cho biết có bao nhiêu sinh viên CNTT học giỏi(Gpa >= 3.2). Đưa ra kết luận tương ứng.
BEGIN
	DECLARE @gpa FLOAT;
	DECLARE @major NVARCHAR(50);
	DECLARE @result INT;
	SET @gpa = 3.2;
	SET @major = 'CNTT';

	SELECT 
		@result = COUNT(*)
	FROM
		Students
	WHERE
		Gpa >= @gpa
		AND
		Major = @major;

	IF @result = 0
		BEGIN
			PRINT N'Không có kết quả';
		END
	ELSE
		BEGIN
			PRINT STR(@result, 2) + N' sinh viên CNTT có điểm Gpa >= ' + STR(@gpa, 4, 2);
		END
END

﻿-- Hãy cho biết có bao nhiêu cửa hàng công nghệ tại quận Nam Từ Liêm?
BEGIN
	DECLARE @district NVARCHAR(50);
	DECLARE @result INT;
	SET @district = N'Nam Từ Liêm';

	SELECT 
		@result = COUNT(*)
	FROM
		Stores
	WHERE
		District = @district;

	IF @result = 0
		BEGIN
			PRINT N'Không có cửa hàng nào tại ' + @district;
		END
	ELSE
		BEGIN
			PRINT N'Có ' + STR(@result, 1) + N' cửa hàng công nghệ tại ' + @district;
		END
END


﻿-- Hãy cho biết có bao nhiêu nhân viên làm việc tại cửa hàng mã X?
BEGIN
	DECLARE @storeId INT;
	DECLARE @result INT;
	SET @storeId = 4;

	SELECT 
		@result = COUNT(*)
	FROM
		Staffs
	WHERE
		StoreId = @storeId;

	IF @result = 0
		BEGIN
			PRINT N'Không có nhân viên nào làm việc tại cửa hàng mã cửa hàng là ' + @storeId;
		END
	ELSE
		BEGIN
			PRINT N'Có ' + STR(@result, 1) + 
				N' nhân viên làm việc tại cửa hàng có mã cửa hàng là ' + STR(@storeId, 1);
		END
END

﻿-- Hãy cho biết nhân viên quản lý mã X đang quản lý bao nhiêu nhân viên?
BEGIN
	DECLARE @staffId INT;
	DECLARE @result INT;
	SET @staffId = 15;

	SELECT 
		@result = COUNT(*)
	FROM
		Staffs
	WHERE
		ManagerId = @staffId;

	IF @result = 0
		BEGIN
			PRINT N'Người này không quản lý nhân viên nào.';
		END
	ELSE
		BEGIN
			PRINT N'Người này quản lý ' + STR(@result, 2) + N' nhân viên.';
		END
END