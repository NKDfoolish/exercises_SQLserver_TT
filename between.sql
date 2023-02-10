/*
1.Cho biết các sinh viên đăng ký môn học trong khoảng thời gian từ 00:00 đến  00:59.
2.Cho biết các môn học được đăng ký trong thời gian từ 01:00 đến 01:59.
3.Cho biết các sinh viên không đăng ký môn học trong thời gian từ 00:00 đến 01:59.
4.Cho biết các môn học không được sinh viên nào đăng ký trong khoảng thời gian từ 01:00 đến 01:59.
*/

--1
select distinct
	s.*
from
	student s, register r
where
	datepart(hour, r.registertime) = 0
	and
	datepart(minute, r.registertime) between 0 and 59
	and
	r.studentid = s.id

--2
select distinct
	sj.*
from 
	subject sj, register r
where
	datepart(hour, r.registertime) = 1
	and
	datepart(minute, r.registertime) between 0 and 59
	and
	r.subjectid = sj.id

--3
select *
from student
where id not in (
	select distinct
		s.id
	from
		student s, register r
	where
		datepart(hour, r.registertime) between 0 and 1
		and
		datepart(minute, r.registertime) between 0 and 59
		and
		r.studentid = s.id
	)

--4
select *
from subject
where id not in (
	select distinct
		sj.id
	from 
		subject sj, register r
	where
		datepart(hour, r.registertime) = 1
		and
		datepart(minute, r.registertime) between 0 and 59
		and
		r.subjectid = sj.id
)