/*
1.Cho biết thông tin môn học có số tín chỉ là 3.
2.Cho biết thông tin các môn học được đăng ký bởi sinh viên mã X và thời gian đăng ký tương ứng.
3.Cho biết thông tin các sinh viên đăng ký các môn học có 3 tín chỉ.
4.Cho biết thông tin các sinh viên có điểm TB >= 3.2 và đăng ký các môn học có số tín chỉ >= 3.
5.Cho biết thông tin các sinh viên không đăng ký bất kỳ môn học nào.
6.Cho biết thông tin các môn học không có sinh viên nào đăng ký.
*/

-- 1
select *
from subject
where
	id in (select id
		   from subject
	       where credit = 3)

-- 2
select * 
from subject
where
	id in (
		select
			subject.id
		from 
			register, student, subject
		where
			student.id = 'B25DCCN101'
			and
			student.id = register.studentid
			and
			subject.id = register.subjectid
			)

-- 3
select *
from student
where
	id in (
		select 
			student.id
		from student, subject, register
		where
			student.id = register.studentid
			and
			subject.id = register.subjectid
			and
			subject.credit = 3
			)

-- 4
select *
from student
where
	id in (
		select 
			student.id
		from student, subject, register
		where
			student.id = register.studentid
			and
			subject.id = register.subjectid
			and
			subject.credit = 3
			and
			student.gpa >= 3
			)

-- 5
select *
from student
where
	id not in (
		select 
			student.id
		from student, subject, register
		where
			student.id = register.studentid
			and
			subject.id = register.subjectid
			)

-- 6
select *
from subject
where
	id not in (
		select 
			subject.id
		from student, subject, register
		where
			student.id = register.studentid
			and
			subject.id = register.subjectid
			
			)