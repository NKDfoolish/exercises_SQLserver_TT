/*
Xóa các môn học có số tín chỉ bằng 4 trong bảng Subjects.
Xóa toàn bộ dữ liệu trong bảng Subjects.
Xóa các sinh viên sinh vào tháng chẵn, ngày chẵn khỏi bảng Students.
Xóa các sinh viên học CNTT và có điểm TB >= 3.6 khỏi bảng Students.
*/

﻿-- Xóa các môn học có số tín chỉ bằng 4 trong bảng Subjects.
DELETE FROM 
	Subjects
WHERE
	Credit = 4;

--
DELETE FROM Subjects;

﻿-- Xóa các sinh viên sinh vào tháng chẵn, ngày chẵn khỏi bảng Students.
DELETE FROM	
	Students
WHERE
	MONTH(BirthDate) % 2 = 0
	AND
	DAY(BirthDate) % 2 = 0;

﻿-- Xóa các sinh viên học CNTT và có điểm TB >= 3.6 khỏi bảng Students.
DELETE FROM 
	Students
WHERE
	Major = N'CNTT'
	AND
	Gpa >= 3.6;