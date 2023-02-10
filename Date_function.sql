SELECT
CURRENT_TIMESTAMP [CURRENT TIME STAMP],
GETDATE() [GET DATE],
GETUTCDATE() [GET UTC DATE],
CONVERT(DATE, GETDATE()) AS [DATE],
CONVERT(TIME, GETDATE()) AS [TIME];

SELECT SYSDATETIME() [SYSDATETIME];

/*
author: Mr.D
created date: 2022-10-21
note: Test SYSUTCDATETIME()
*/
DECLARE @currentUTCDATE DATE;
DECLARE @currentUTCTime TIME;
DECLARE @currentUTCDATETIME DATETIME2 = SYSUTCDATETIME();

SELECT
@currentUTCDATE = CONVERT(DATE, @currentUTCDATETIME),
@currentUTCTIME = CONVERT(TIME, @currentUTCDATETIME);

SELECT 
@currentUTCDATE AS [DATE],
@currentUTCTIME AS [TIME];

/*
Test SYSDATETIMEOFFSET()
*/
DECLARE @currentDateTime DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();
DECLARE @zz VARCHAR(2) = 'zz';
DECLARE @zzz VARCHAR(3) = 'zzz';

SELECT 
    @currentDateTime AS 'Current Date Time Offset',
    FORMAT(@currentDateTime, @zz) AS 'zz',
    FORMAT(@currentDateTime, @zzz) AS 'zzz';

SELECT DATEPART(tz, SYSDATETIMEOFFSET()) TimeZone; -- trả ra múi giờ theo phút

/*Test DATENAME()*/
DECLARE @now AS DATETIME;
SET @now = GETDATE();

SELECT 
    DATENAME(year, @now) AS CurrentYear,
    DATENAME(month, @now) AS CurrentMonth,
    DATENAME(day, @now) AS CurrentDay,
    DATENAME(weekday, @now) AS CurrentWeekDay

--
DECLARE @input VARCHAR(20) = '2022/10/21';
DECLARE @myDate DATE = CONVERT(DATE, @input, 111); -- chuyển từ varchar sang date
SELECT 
	DATENAME(month, @myDate) AS 'Month', -- lấy tên tháng
	DATENAME(weekday, @myDate) AS 'Day Of Week'; -- lấy tên ngày của tuần


--
SELECT DAY('2025-12-24') AS given_day



--


SELECT
    ISDATE('2025-12-12 12:34:45') AS IsValidDateTime
