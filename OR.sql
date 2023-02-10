/*
1.Hãy cho biết thông tin các sinh viên sinh vào tháng 6 hoặc tháng 10 sắp xếp tăng dần theo mã sinh viên.
2.Hãy cho biết thông tin các môn học có số tín chỉ > 3 hoặc có số tiết học từ 45 trở lên.
3.Hãy cho biết thông tin các sinh viên thỏa mãn điều kiện: hoặc có tên dài nhất hoặc có điểm TB cao nhất.
*/

-- 1
select
	*
from
	student
where
	month(birthdate) = 6 or month(birthdate) = 10
order by
	id ASC

-- 2
select
	*
from 
	subject
where
	credit > 3 or numoflesson >= 45

-- 3
select
	-- id, fullname, gpa
	*
from
	student
where
	gpa = (select max(gpa) from student)
	or
	len(fullname) = (select top 1 len(fullname) from student order by len(fullname) desc)
-- group by
--	id, fullname, gpa