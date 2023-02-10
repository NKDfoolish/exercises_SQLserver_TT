/*
1.Hãy cho biết các sinh viên học CNTT và sống tại Hà Nội?
2.Hãy cho biết các sinh viên học CNTT và có điểm TB không vượt quá 3.50?
3.Hãy cho biết những sinh viên nào đăng ký khóa học C++?
4.Hãy cho biết top 3 sinh viên đầu tiên đăng ký môn học C#?
5.Hãy cho bết top 3 môn học đầu tiên mà sinh viên mã X đăng ký?
*/

-- 1
select 
	fullname, address
from
	student
where
	major = 'CNTT' and address = N'Hà Nội'

-- 2
select 
	fullname, gpa
from
	student
where
	major = 'CNTT' and gpa <= 3.5

-- 3
select 
	student.fullname
from
	student, subject, register
where
	subject.name = 'C++' and register.subjectid = subject.id and register.studentid = student.id

-- 4
select top 3 with ties
	student.fullname, register.registertime
from
	student, subject, register
where
	subject.name = 'C#' and register.subjectid = subject.id and register.studentid = student.id
order by
	register.registertime ASC

-- 5
select top 3
	subject.name, register.registertime
from
	student, register, subject
where
	student.id = 'B25DCCN101' and register.studentid = student.id and register.subjectid = subject.id
order by
	register.registertime ASC
