/*
1. Cho biết thông tin các môn học trong tên có chữ ‘c’.
2. Cho biết mã, tên các sinh viên đăng ký môn C++ mà trong tên sinh viên có chữ ‘n’.
3. Cho biết mã, họ, tên, điểm TB các sinh viên trong danh sách có họ không bắt đầu với chữ ‘h’, ‘n’ hoặc ‘t’.
4. Cho biết thông tin các sinh viên đăng ký môn SQL mà trong tên có chữ ‘n’ và có điểm TB dạng 3.x.
*/

--1
select
	*
from
	subjects
where
	name like '%c%'

--2
select 
	s.studentid, 
	s.firstname
from 
	students s,
	subjects sj, 
	registers r
where
	s.firstname like '%n%'
	and
	sj.name = 'C++'
	and
	r.subjectid = sj.subjectid
	and
	r.studentid = s.studentid

--3
select
	studentid, 
	lastname, 
	firstname, 
	gpa
from
	students
where
	lastname not like 'H%'
	and 
	lastname not like 'N%'
	and 
	lastname not like 'T%'

--4
select 
	s.*
from 
	students s, 
	subjects sj, 
	registers r
where
	s.firstname like '%n%'
	and
	sj.name = 'SQL'
	and
	r.subjectid = sj.subjectid
	and
	r.studentid = s.studentid
	and
	str(s.gpa, 4, 2) like '3.%'
