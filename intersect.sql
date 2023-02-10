-- Xét bảng Students và bảng Customers. Hãy cho biết họ và tên những người ở cùng thành phố? Đó là thành phố nào?
SELECT 
	s.LastName,
	s.FirstName,
	s.Address
FROM
	Students s
WHERE
	s.Address IN (
		SELECT
			Address
		FROM
			Students
		INTERSECT
		SELECT
			City
		FROM
			Customers
	)
UNION ALL
SELECT 
	c.LastName,
	c.FirstName,
	c.City
FROM
	Customers c
WHERE
	c.City IN (
		SELECT
			Address
		FROM
			Students
		INTERSECT
		SELECT
			City
		FROM
			Customers
	)


-- Xét bảng Customers và Stores. Hãy cho biết tên các cửa hàng cùng quận với khách hàng, cho biết đó là quận nào?
select storename, district
from stores
where district in (
select district
from stores
intersect
select district
from customers
)

-- Xét bảng Customers và Stores. Hãy cho biết tên các khách hàng cùng quận với quận có cửa hàng công nghệ đang mở, 
-- cho biết đó là quận nào?
select lastname, firstname, district
from customers
where district in (
select district
from stores
intersect
select district
from customers
)

