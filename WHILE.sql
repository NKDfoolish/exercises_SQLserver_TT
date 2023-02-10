﻿-- Liệt kê các số nguyên tố nằm trong đoạn từ 1 đến 99.
BEGIN
	DECLARE @number INT;
	DECLARE @start INT = 1;
	DECLARE @end INT = 99;
	DECLARE @counter INT = 0;
	DECLARE @k INT = 7;
	SET @number = @start;

	-- thực hiện vòng lặp
	WHILE @number <= @end
	BEGIN
		DECLARE @squareRoot INT = SQRT(@number);
		DECLARE @iterator INT = 2;
		DECLARE @isPrime BIT = 1; -- giả sử ban đầu n là số ng.tố
		IF @number < 2 -- nếu n < 2 thì n không phải số nguyên tố
		BEGIN
			SET @isPrime = 0;
		END
		ELSE -- ngược lại, xét tiếp
		BEGIN
			WHILE @iterator <= @squareRoot
			BEGIN
				IF (@number % @iterator = 0) -- nếu n có ước từ 2 đến phần nguyên căn bậc hai của nó
				BEGIN
					SET @isPrime = 0; -- n không phải số ng.tố
					BREAK;
				END
				SET @iterator = @iterator + 1;
			END
			IF @isPrime = 1 -- nếu n là số nguyên tố
			BEGIN
				PRINT @number; -- thì in ra
			END
		END
		SET @number = @number + 1;
	END
END

﻿-- Đếm số lượng các số nguyên trong đoạn [1, 199] chia hết cho k = 7.
BEGIN
	DECLARE @number INT;
	DECLARE @start INT = 1;
	DECLARE @end INT = 99;
	DECLARE @counter INT = 0;
	DECLARE @k INT = 7;
	SET @number = @start;

	-- thực hiện vòng lặp
	WHILE @number <= @end
	BEGIN
		IF (@number % @k = 0)
		BEGIN
			SET @counter = @counter + 1;
		END
		SET @number = @number + 1;
	END
	-- hiển thị kết quả
	PRINT @counter;
END

﻿-- Tìm các số chính phương trong đoạn [1, 99].
BEGIN
	DECLARE @number INT;
	DECLARE @start INT = 1;
	DECLARE @end INT = 99;
	DECLARE @counter INT = 0;
	DECLARE @k INT = 7;
	SET @number = @start;

	-- thực hiện vòng lặp
	WHILE @number <= @end
	BEGIN
		DECLARE @squareRoot INT;
		SET @squareRoot = SQRT(@number);
		IF (@squareRoot * @squareRoot = @number)
		BEGIN
			PRINT @number;
		END
		SET @number = @number + 1;
	END
END

﻿/* 
vẽ hình tam giác vuông góc trái dưới
 * 
 *  * 
 *  *  * 
 *  *  *  * 
 *  *  *  *  *

 */

DECLARE @iter INT = 1;
DECLARE @height INT = 5;
-- bắt đầu vẽ
WHILE @iter <= @height
BEGIN
	DECLARE @line VARCHAR(100) = ''; -- khai báo biến lưu dòng kết quả
	DECLARE @pos INT = 1; -- biến lặp để vẽ các dấu * trên từng hàng
	WHILE @pos <= @iter -- vẽ dấu * từng hàng
	BEGIN
		SET @line = CONCAT(@line, ' * ');
		SET @pos += 1;
	END;
	PRINT(@line);
	SET @iter += 1;
END

﻿/* 
vẽ hình chữ nhật đặc bằng các dấu * cấp mxn. Ví dụ m = n = 5
 *  *  *  *  *
 *  *  *  *  *
 *  *  *  *  *
 *  *  *  *  *
 *  *  *  *  *

 */

DECLARE @iter INT = 1;
DECLARE @height INT = 5;
DECLARE @width INT = 5;
-- bắt đầu vẽ
WHILE @iter <= @width
BEGIN
	DECLARE @line VARCHAR(100) = ''; -- khai báo biến lưu dòng kết quả
	DECLARE @pos INT = 1; -- biến lặp để vẽ các dấu * trên từng hàng
	WHILE @pos <= @height -- vẽ dấu * từng hàng
	BEGIN
		SET @line = CONCAT(@line, ' * ');
		SET @pos += 1;
	END;
	PRINT(@line);
	SET @iter += 1;
END

﻿/* 
vẽ hình chữ nhật rỗng cấp mxn. Ví dụ m = n = 5
 *  *  *  *  *
 *           *
 *           *
 *           *
 *  *  *  *  *

 */

DECLARE @iter INT = 1;
DECLARE @height INT = 5;
DECLARE @width INT = 5;
-- bắt đầu vẽ
WHILE @iter <= @width
BEGIN
	DECLARE @line VARCHAR(100) = ''; -- khai báo biến lưu dòng kết quả
	DECLARE @pos INT = 1; -- biến lặp để vẽ các dấu * trên từng hàng
	WHILE @pos <= @height -- vẽ dấu * từng hàng
	BEGIN
		IF @iter = 1 OR @iter = @width OR @pos = 1 OR @pos = @height
			SET @line = CONCAT(@line, ' * ');
		ELSE
			SET @line = CONCAT(@line, '   ');
		SET @pos += 1;
	END;
	PRINT(@line);
	SET @iter += 1;
END