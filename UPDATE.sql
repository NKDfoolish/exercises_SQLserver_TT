-- Cộng 0.2 điểm cho các sinh viên sinh vào tháng chẵn.
update
	students
set
	gpa += 0.2
where
	gpa <= 3.8
	and
	month(birthdate) % 2 = 0

-- Cộng 0.3 điểm cho các sinh viên sinh vào ngày chia hết cho 3.
update
	students
set
	gpa += 0.3
where
	gpa <= 3.7
	and
	day(birthdate) % 3 = 0

-- Đổi địa chỉ các sinh viên ở ‘Đà Nẵng’ thành ‘Bình Định’.
update
	students
set
	address = N'Bình Định'
where
	address = N'Đà Nẵng'