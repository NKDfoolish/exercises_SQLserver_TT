-- Hãy cho biết tên, số điện thoại của tất cả các sinh viên, nhân viên và khách hàng không tính các bản ghi trùng lặp.
select firstname, lastname, phonenumber
from
students
union
select firstname, lastname, phonenumber
from 
staffs
union
select firstname, lastname, phonenumber
from
customers

-- tuong tu nhu tren nhung giu lai cac ket qua trung lap
select firstname, lastname, phonenumber
from
students
union all
select firstname, lastname, phonenumber
from 
staffs
union all
select firstname, lastname, phonenumber
from
customers
