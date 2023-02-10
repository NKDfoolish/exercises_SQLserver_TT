-- Khai báo biến lưu giá trị điểm Gpa thấp nhất của sinh viên trong bảng Students. Hiển thị giá trị này ra màn hình.
DECLARE @minGPA AS FLOAT = NULL;
SET @minGPA = (
SELECT MIN(GPA) 
FROM LearnSQL.dbo.Students
);
PRINT @minGPA;

-- Khai báo biến lưu trữ giá trị điểm Gpa cao nhất của sinh viên trong bảng Students. Hiển thị kết quả ra màn hình.
DECLARE @maxGPA AS FLOAT = NULL;
SET @maxGPA = (
SELECT MAX(GPA) 
FROM LearnSQL.dbo.Students
);
PRINT @maxGPA;

-- Khai báo biến lưu trữ giá trị điểm Gpa trung bình của các sinh viên trong bảng Students. Hiển thị kết quả ra màn hình.
DECLARE @averageGPA AS FLOAT = NULL;
SET @averageGPA = (
SELECT AVG(GPA)
FROM LearnSQL.dbo.Students
);
PRINT @averageGPA;

-- Khai báo biến đếm số lượng sinh viên có điểm TB từ 3.50 trở lên trong bảng Students. Hiển thị kết quả ra màn hình.
DECLARE @countStudents AS INT = NULL;
SET @countStudents = (
SELECT COUNT(1) FROM LearnSQL.dbo.Students
WHERE GPA >= 3.50
);
PRINT @countStudents;

-- Khai báo biến đếm số lượng sinh viên trong bảng Students sinh vào tháng chẵn. Hiển thị kết quả ra màn hình.
DECLARE @countStudentsEvenMonthBirth AS INT = NULL;
SET @countStudentsEvenMonthBirth = (
SELECT COUNT(1) FROM LearnSQL.dbo.Students
WHERE MONTH(BirthDate) % 2 = 0
);
PRINT @countStudentsEvenMonthBirth;

-- cach 2:
DECLARE @countStudentsEvenMonthBirth AS INT = NULL;
SELECT @countStudentsEvenMonthBirth = COUNT(1) FROM LearnSQL.dbo.Students
WHERE MONTH(BirthDate) % 2 = 0;
SELECT @countStudentsEvenMonthBirth [Result];
