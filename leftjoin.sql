
-- 1. Hãy cho biết thông tin các môn học không có sinh viên nào đăng ký.
select 
	s.*
from 
	subjects s left join registers r
	on s.subjectid = r.subjectid
where
	r.registerid is null

-- 2. Hãy cho biết các môn học có ít nhất 1 sinh viên đăng ký.
select 
	s.*
from 
	subjects s left join registers r
	on s.subjectid = r.subjectid
where
	r.registerid is not null

-- 3. Hãy cho biết số lượng sinh viên đăng ký của từng môn học. Kết quả sắp xếp giảm dần theo số lượng sinh viên đăng ký.
select 
	sj.name, 
	count(r.studentid) as QuantityOfStudent
from
	students s left join registers r
	on s.studentid = r.studentid
	left join subjects sj
	on r.subjectid = sj.subjectid
where
	r.registerid is not null
group by
	sj.name
order by
	QuantityOfStudent DESC

-- 4. Hãy cho biết danh sách các sinh viên đăng ký môn học SUBJ1001.
select s.*
from 
	students s left join registers r
	on s.studentid = r.studentid
	left join subjects sj
	on sj.subjectid = r.subjectid
where
	sj.subjectid = 'SUBJ1001'

-- 5. Hãy cho biết mỗi sinh viên đăng ký bao nhiêu môn học. Sắp xếp giảm dần theo số lượng đăng ký.
select s.studentid, s.lastname, s.firstname, s.major, count(r.subjectid) as NumOfRegistered
from 
	students s left join registers r
	on s.studentid = r.studentid
	left join subjects sj
	on sj.subjectid = r.subjectid
where
	r.registerid is not null
group by
	s.studentid, s.lastname, s.firstname, s.major
order by
	NumOfRegistered DESC