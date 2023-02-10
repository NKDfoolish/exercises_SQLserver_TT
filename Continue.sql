﻿-- Liệt kê các số nguyên chẵn trong đoạn từ a đến b với a <= b bất kì cho trước.
BEGIN
	DECLARE @a INT = 1;
	DECLARE @b INT = 15;
	-- do ta tăng giá trị của @number trước khi kiểm tra nó 
	-- nên ta bắt đầu với @a - 1
	DECLARE @number INT = @a - 1;
	WHILE @number <= @b
	BEGIN
		SET @number += 1; -- tăng giá trị biến @number trước
		IF @number % 2 != 0
			CONTINUE;
		PRINT @number;
	END
END

﻿-- Liệt kê các số chính phương trong đoạn từ a đến b với a <= b.
BEGIN
	DECLARE @a INT = 1;
	DECLARE @b INT = 15;
	-- do ta tăng giá trị của @number trước khi kiểm tra nó 
	-- nên ta bắt đầu với @a - 1
	DECLARE @number INT = @a - 1;
	WHILE @number <= @b
	BEGIN
		SET @number += 1; -- tăng giá trị biến @number trước
		-- khai báo biến để kiểm tra xem @number có phải số chính phương không
		DECLARE @x INT = SQRT(@number); -- lấy @x = phần nguyên căn bậc hai của @number
		-- nếu bình phương phần nguyên căn bậc hai của @number bằng @number
		IF @number != (@x * @x) -- nếu không bằng, @number không phải số chính phương
			CONTINUE; -- bỏ qua việc in ra
		PRINT @number; -- in ra số chính phương @number
	END
END

﻿-- Đếm các số chia hết cho k khác 0 trong đoạn từ a đến b.
BEGIN
	DECLARE @a INT = 1;
	DECLARE @b INT = 100;
	DECLARE @k INT = 7; -- giá trị k khác 0 tùy ý
	DECLARE @counter INT = 0; -- ban đầu chưa có kết quả nào nên ta gán biến đếm kết quả bằng 0
	-- do ta tăng giá trị của @number trước khi kiểm tra nó 
	-- nên ta bắt đầu với @a - 1
	DECLARE @number INT = @a - 1;
	WHILE @number <= @b
	BEGIN
		SET @number += 1; -- tăng giá trị biến @number trước
		IF @number % @k != 0 -- nếu không bằng, @number không chia het cho k
			CONTINUE; -- bỏ qua việc tăng giá trị biến đếm lên
		SET @counter += 1; -- tăng giá trị biến đếm
	END
	-- in ra số kết quả thỏa mãn đề bài
	PRINT @counter;
END

﻿-- Tìm giá trị số nguyên lớn nhất trong 3 giá trị a, b, c.
BEGIN
	DECLARE @a INT = 1;
	DECLARE @b INT = 100;
	DECLARE @c INT = 7; 
	DECLARE @max INT = @a; -- giả định giá trị max là @a

	IF @max < @b	-- nếu @b lớn hơn @max
		SET @max = @b; -- gán max là @b
	IF @max < @c	-- nếu @c lớn hơn @max
		SET @max = @c; -- gán max là @c
	-- in ra số kết quả thỏa mãn đề bài
	PRINT @max;
END

﻿-- Tìm giá trị số nguyên nhỏ nhất trong 3 giá trị a, b, c.
BEGIN
	DECLARE @a INT = 999;
	DECLARE @b INT = 100;
	DECLARE @c INT = 700; 
	DECLARE @min INT = @a; -- giả định giá trị min là @a

	IF @min > @b	-- nếu @b nhỏ hơn @min
		SET @min = @b; -- gán min là @b
	IF @min > @c	-- nếu @c nhỏ hơn @min
		SET @min = @c; -- gán min là @c
	-- in ra số kết quả thỏa mãn đề bài
	PRINT @min;
END