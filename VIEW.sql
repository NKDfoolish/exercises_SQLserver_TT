Tạo view chứa thông tin các môn học trong bảng Subjects.
Tạo view chứa thông tin các cửa hàng trong bảng Stores.
Tạo view cho biết tên nhân viên quản lý và danh sách nhân viên dưới quyền của họ.
Tạo view cho biết số lượng môn học đăng ký của từng sinh viên.
Tạo view cho biết số lượng đăng ký của từng môn học.
Tạo view cho biết sinh viên nào đăng ký môn học sớm nhất.
Tạo view cho biết môn học nào được đăng ký sớm nhất.
Tạo view cho biết sinh viên nào không đăng ký môn học.
Tạo view cho biết môn học nào không có sinh viên đăng ký.
Tạo view tính hoa hồng, tổng lương cho các nhân viên có mặt trong bảng Salaries.
Tạo view cho biết tên các quận khách hàng đang ở mà không có bất cứ một cửa hàng công nghệ nào.

﻿-- Tạo view chứa thông tin các môn học trong bảng Subjects.
CREATE VIEW vw_Subjects
AS
	SELECT
		*
	FROM
		Subjects;

﻿-- Tạo view chứa thông tin các cửa hàng trong bảng Stores.
CREATE VIEW vw_Stores
AS
	SELECT
		*
	FROM
		Stores;

﻿-- Tạo view cho biết tên nhân viên quản lý và danh sách nhân viên dưới quyền của họ.
CREATE VIEW vw_ManagerStaffs
AS
	SELECT
		m.LastName + ' ' + m.FirstName AS ManagerFullName,
		s.LastName + ' ' + s.FirstName AS StaffFullName
	FROM
		Staffs s
		INNER JOIN Staffs m
		ON s.ManagerId = m.StaffId;

﻿-- Tạo view cho biết số lượng môn học đăng ký của từng sinh viên.
CREATE VIEW vw_StudentRegisters
AS
	SELECT
		s.StudentId, 
		s.LastName, 
		s.FirstName, 
		s.Major,
		COUNT(r.StudentId) AS NumberOfSubject
	FROM
		Students s
		INNER JOIN Registers r
		ON s.StudentId = r.StudentId
	GROUP BY
		s.StudentId, 
		s.LastName, 
		s.FirstName, 
		s.Major

﻿-- Tạo view cho biết số lượng đăng ký của từng môn học.
CREATE VIEW vw_SubjectRegisters
AS
	SELECT
		s.SubjectId, 
		s.Name, 
		s.Credit, 
		s.Type,
		COUNT(r.SubjectId) AS NumberOfRegister
	FROM
		Subjects s
		INNER JOIN Registers r
		ON s.SubjectId = r.SubjectId
	GROUP BY
		s.SubjectId, 
		s.Name, 
		s.Credit, 
		s.Type


﻿-- Tạo view cho biết sinh viên nào đăng ký môn học sớm nhất.
CREATE VIEW vw_EarliestRegisters
AS
	SELECT TOP 1 WITH TIES
		s.*,
		r.RegisterTime
	FROM
		Students s
		INNER JOIN Registers r
		ON r.StudentId = s.StudentId
	ORDER BY
		r.RegisterTime ASC;


﻿-- Tạo view cho biết môn học nào được đăng ký sớm nhất.
CREATE VIEW vw_EarliestRegisteredSubjects
AS
	SELECT TOP 1 WITH TIES
		s.*,
		r.RegisterTime
	FROM
		Subjects s
		INNER JOIN Registers r
		ON r.SubjectId = s.SubjectId
	ORDER BY
		r.RegisterTime ASC;

﻿-- Tạo view cho biết sinh viên nào không đăng ký môn học.
CREATE VIEW vw_NotRegistedStudents
AS
	SELECT
		s.*
	FROM
		Students s
	WHERE
		s.StudentId NOT IN(
			SELECT	
				r.StudentId
			FROM
				Registers r
		);


﻿-- Tạo view cho biết môn học nào không có sinh viên đăng ký.
CREATE VIEW vw_NotRegistedSubjects
AS
	SELECT
		s.*
	FROM
		Subjects s
	WHERE
		s.SubjectId NOT IN(
			SELECT	
				r.SubjectId
			FROM
				Registers r
		);

﻿-- Tạo view tính hoa hồng, tổng lương cho các nhân viên có mặt trong bảng Salaries.
CREATE VIEW vw_TotalSalaries
AS
	SELECT
		Commission,
		BaseSalary + Commission AS TotalSalary
	FROM
		Salaries


﻿-- Tạo view cho biết tên các quận khách hàng đang ở 
-- mà không có bất cứ một cửa hàng công nghệ nào.
CREATE VIEW vw_Districts
AS
	SELECT DISTINCT
		s.District
	FROM
		Customers s
	WHERE
		s.District NOT IN(
			SELECT 
				st.District
			FROM
				Stores st
		);