/*
Xóa và tạo lại các bảng Salaries, Targets.
Chèn dữ liệu vào 2 bảng trên.
Tính tiền hoa hồng cho các nhân viên có trong bảng Salaries.
Thêm mới nhân viên vào bảng Salaries và chưa chỉ định target cụ thể.
Tính tiền hoa hồng cho các nhân viên trong bảng Salaries.
Cho biết thông tin các nhân viên, doanh thu, tiền hoa hồng, mức lương và tổng lương của những người có trong bảng Salaries.
*/

CREATE TABLE Targets(
	TargetId INT PRIMARY KEY,
	Percentage DECIMAL(4, 2) NOT NULL DEFAULT 0
);

CREATE TABLE Salaries(
	SalaryId INT PRIMARY KEY IDENTITY(100, 1),
	StaffId INT,
	TargetId INT,
	BaseAmount DECIMAL(10, 2) NOT NULL DEFAULT 0,
	BaseSalary DECIMAL(10, 2) NOT NULL DEFAULT 0,
	Commission DECIMAL(10, 2) NOT NULL DEFAULT 0,
	FOREIGN KEY(TargetId) REFERENCES Targets(TargetId),
	FOREIGN KEY(StaffId) REFERENCES Staffs(StaffId),
);

--

INSERT INTO 
	Targets(TargetId, Percentage) 
VALUES 
	(1, 0.1), 
	(2, 0.2), 
	(3, 0.3), 
	(4, 0.4), 
	(5, 0.5), 
	(6, 0.6), 
	(7, 0.7), 
	(8, 0.8), 
	(9, 0.9);

INSERT INTO
	Salaries(StaffId, TargetId, BaseAmount, BaseSalary)
VALUES
	(1, 2, 21400000, 4500000), 
	(6, 3, 39500000, 5500000), 
	(7, 4, 48500000, 6500000), 
	(9, 5, 57100000, 7500000), 
	(8, 1, 11500000, 4500000), 
	(10, 2, 27500000, 4500000), 
	(11, 3, 36500000, 5500000), 
	(18, 5, 56800000, 8500000);

--

UPDATE 
	Salaries
SET
	Salaries.Commission = s.BaseAmount * t.Percentage
FROM
	Salaries s
	INNER JOIN Targets t
	ON s.TargetId = t.TargetId;

--

INSERT INTO	
	Salaries(StaffId, BaseAmount, BaseSalary)
VALUES
	(18, 7100000, 4500000),
	(19, 11400000, 4500000), 
	(20, 9500000, 4500000), 
	(21, 8500000, 4500000), 
	(22, 7100000, 4500000), 
	(23, 61500000, 4500000);

--

UPDATE 
	Salaries
SET
	Salaries.Commission = s.BaseAmount * COALESCE(t.Percentage, 0.1)
FROM
	Salaries s
	LEFT JOIN Targets t
	ON s.TargetId = t.TargetId;

--

SELECT
	st.*,
	s.BaseAmount,
	s.Commission,
	s.BaseSalary,
	s.BaseSalary + s.Commission AS TotalSalary
FROM
	Staffs st
	INNER JOIN Salaries s
	ON st.StaffId = s.StaffId;