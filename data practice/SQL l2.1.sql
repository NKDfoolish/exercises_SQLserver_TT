USE master
GO
DROP DATABASE IF EXISTS LearnSQL
GO
/****** Object:  Database LearnSQL    Script Date: 07/01/2022 12:16:54 ******/
CREATE DATABASE LearnSQL
GO
ALTER DATABASE LearnSQL SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC LearnSQL.sp_fulltext_database @action = 'enable'
end
GO
ALTER DATABASE LearnSQL SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE LearnSQL SET ANSI_NULLS OFF 
GO
ALTER DATABASE LearnSQL SET ANSI_PADDING OFF 
GO
ALTER DATABASE LearnSQL SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE LearnSQL SET ARITHABORT OFF 
GO
ALTER DATABASE LearnSQL SET AUTO_CLOSE ON 
GO
ALTER DATABASE LearnSQL SET AUTO_SHRINK OFF 
GO
ALTER DATABASE LearnSQL SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE LearnSQL SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE LearnSQL SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE LearnSQL SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE LearnSQL SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE LearnSQL SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE LearnSQL SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE LearnSQL SET  ENABLE_BROKER 
GO
ALTER DATABASE LearnSQL SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE LearnSQL SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE LearnSQL SET TRUSTWORTHY OFF 
GO
ALTER DATABASE LearnSQL SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE LearnSQL SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE LearnSQL SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE LearnSQL SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE LearnSQL SET RECOVERY SIMPLE 
GO
ALTER DATABASE LearnSQL SET  MULTI_USER 
GO
ALTER DATABASE LearnSQL SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE LearnSQL SET DB_CHAINING OFF 
GO
ALTER DATABASE LearnSQL SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE LearnSQL SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE LearnSQL SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE LearnSQL SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE LearnSQL SET QUERY_STORE = OFF
GO
USE LearnSQL
GO
/****** Object:  Table Customer    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Customer(
	Id uniqueidentifier NULL,
	FullName nvarchar(40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table Discount    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Discount(
	Id int NULL,
	Name nvarchar(100) NULL,
	StartDate date NULL,
	EndDate date NULL,
	StartTime time(0) NULL,
	EndTime time(0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table DiscountEvent    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE DiscountEvent(
	Id int IDENTITY(1,1) NOT NULL,
	Name nvarchar(100) NULL,
	StartTime datetime2(3) NULL,
	EndTime datetime2(3) NULL,
	Amount float NULL,
 CONSTRAINT PK_DiscountEvent PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table Employee    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Employee(
	Id varchar(10) NULL,
	FullName nvarchar(40) NULL,
	BirthDate date NULL
) ON [PRIMARY]
GO
/****** Object:  Table LearnNvarchar    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE LearnNvarchar(
	FullName nvarchar(20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table Lesson312    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Lesson312(
	CurrentDateTime datetimeoffset(0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table MyTable    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE MyTable(
	FullName varchar(20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table Person    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Person(
	Id int IDENTITY(100,1) NOT NULL,
	FirstName nvarchar(50) NULL,
	LastName nvarchar(50) NULL,
	MidName nvarchar(50) NULL,
	Age int NULL,
	Address nvarchar(50) NULL,
	Email nvarchar(50) NULL,
PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table Register    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Register(
	Id int IDENTITY(1000,1) NOT NULL,
	StudentId varchar(50) NOT NULL,
	SubjectId varchar(50) NOT NULL,
	RegisterTime datetime NULL,
 CONSTRAINT PK_Register PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table Student    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Student(
	Id varchar(50) NOT NULL,
	FullName nvarchar(50) NULL,
	Address nvarchar(50) NULL,
	Major nvarchar(50) NULL,
	BirthDate date NULL,
	PhoneNumber varchar(50) NULL,
	Gpa float NULL,
 CONSTRAINT PK_Student PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table Student2    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Student2(
	Id varchar(20) NULL,
	FullName nvarchar(40) NULL,
	Gpa real NULL
) ON [PRIMARY]
GO
/****** Object:  Table Subject    Script Date: 07/01/2022 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE Subject(
	Id varchar(50) NOT NULL,
	Name nvarchar(50) NULL,
	Credit int NULL,
	NumOfLesson int NULL,
	Type nvarchar(50) NULL,
 CONSTRAINT PK_Subject PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT Customer (Id, FullName) VALUES (N'516a4e47-7d9a-4714-b248-e8c7c707847f', N'Nguyễn Thành Công')
INSERT Customer (Id, FullName) VALUES (N'536f2462-9add-459e-9db7-febd7ce2803f', N'Nguyễn Thành Nam')
INSERT Customer (Id, FullName) VALUES (N'9320f186-0867-4f97-ad0b-9984ad632ee2', N'Nguyễn Thành Nhân')
INSERT Customer (Id, FullName) VALUES (N'b3cb5762-c8f7-4f63-91cf-2d5f8f004502', N'Trần Xuân Vinh')
INSERT Customer (Id, FullName) VALUES (N'12aef7b4-e5d5-4ea6-80ee-7570f8fed58d', N'Trần Xuân Hà')
INSERT Customer (Id, FullName) VALUES (N'8bf5ab90-c8e8-4ea7-9f5a-838e48b5790b', N'Ngô Ngọc Linh')
GO
INSERT Discount (Id, Name, StartDate, EndDate, StartTime, EndTime) VALUES (100, N'Khuyến mãi 8/8', CAST(N'2025-08-08' AS Date), CAST(N'2025-08-08' AS Date), CAST(N'08:08:08' AS Time), CAST(N'23:59:59' AS Time))
INSERT Discount (Id, Name, StartDate, EndDate, StartTime, EndTime) VALUES (101, N'Khuyến mãi 9/9', CAST(N'2025-09-09' AS Date), CAST(N'2025-09-09' AS Date), CAST(N'09:09:09' AS Time), CAST(N'23:59:59' AS Time))
INSERT Discount (Id, Name, StartDate, EndDate, StartTime, EndTime) VALUES (102, N'Khuyến mãi Flash sale', CAST(N'2025-09-15' AS Date), CAST(N'2025-09-15' AS Date), CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT Discount (Id, Name, StartDate, EndDate, StartTime, EndTime) VALUES (105, N'Khuyến mãi Flash sale', CAST(N'2025-09-16' AS Date), CAST(N'2025-09-16' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT Discount (Id, Name, StartDate, EndDate, StartTime, EndTime) VALUES (115, N'Khuyến mãi Flash sale', CAST(N'2025-09-16' AS Date), CAST(N'2025-09-16' AS Date), CAST(N'16:05:05' AS Time), CAST(N'18:00:00' AS Time))
INSERT Discount (Id, Name, StartDate, EndDate, StartTime, EndTime) VALUES (118, N'Khuyến mãi Flash sale', CAST(N'2025-09-16' AS Date), CAST(N'2025-09-16' AS Date), CAST(N'05:05:05' AS Time), CAST(N'18:00:00' AS Time))
GO
SET IDENTITY_INSERT DiscountEvent ON 

INSERT DiscountEvent (Id, Name, StartTime, EndTime, Amount) VALUES (1, N'Khuyến mãi 8/8', CAST(N'2025-08-08T08:08:08.8880000' AS DateTime2), CAST(N'2025-08-08T23:30:00.0000000' AS DateTime2), 30)
INSERT DiscountEvent (Id, Name, StartTime, EndTime, Amount) VALUES (2, N'Khuyến mãi 15/8', CAST(N'2025-08-18T15:15:15.1500000' AS DateTime2), CAST(N'2025-08-15T16:16:16.0000000' AS DateTime2), 25)
INSERT DiscountEvent (Id, Name, StartTime, EndTime, Amount) VALUES (3, N'Khuyến mãi 28/8', CAST(N'2025-08-28T20:00:00.0000000' AS DateTime2), CAST(N'2025-08-28T23:00:00.0000000' AS DateTime2), 40)
INSERT DiscountEvent (Id, Name, StartTime, EndTime, Amount) VALUES (5, N'Khuyến mãi 09/09', CAST(N'2025-09-09T09:09:09.0000000' AS DateTime2), CAST(N'2025-09-09T23:00:00.0000000' AS DateTime2), 45)
INSERT DiscountEvent (Id, Name, StartTime, EndTime, Amount) VALUES (7, N'Khuyến mãi 09/09', CAST(N'2025-09-09T09:09:09.0000000' AS DateTime2), CAST(N'2025-09-09T23:00:00.0000000' AS DateTime2), 45)
INSERT DiscountEvent (Id, Name, StartTime, EndTime, Amount) VALUES (10, N'Khuyến mãi 09/09', CAST(N'2025-09-09T09:09:09.0000000' AS DateTime2), CAST(N'2025-09-09T23:00:00.0000000' AS DateTime2), 45)
SET IDENTITY_INSERT DiscountEvent OFF
GO
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP001', N'Trần Xuân Tuyên', CAST(N'2000-03-15' AS Date))
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP002', N'Trần Văn Vỹ', CAST(N'2004-05-16' AS Date))
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP003', N'Nguyễn Hồng Quân', CAST(N'2005-11-30' AS Date))
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP004', N'Nguyễn Thùy Linh', CAST(N'2004-10-31' AS Date))
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP005', N'Lê Công Tuấn', CAST(N'2006-09-09' AS Date))
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP006', N'Lê Công Nhật Minh', CAST(N'2000-09-09' AS Date))
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP008', N'Lê Công Nhật Chinh', CAST(N'2000-11-12' AS Date))
INSERT Employee (Id, FullName, BirthDate) VALUES (N'EMP007', N'Hoàng Trung Thông', CAST(N'2001-10-30' AS Date))
GO
INSERT LearnNvarchar (FullName) VALUES (N'Trần Tiến Thành')
INSERT LearnNvarchar (FullName) VALUES (N'Ma Văn Thắng')
INSERT LearnNvarchar (FullName) VALUES (N'Lại Thị Hạ')
GO
INSERT Lesson312 (CurrentDateTime) VALUES (CAST(N'2025-10-10T12:34:16.0000000+07:00' AS DateTimeOffset))
INSERT Lesson312 (CurrentDateTime) VALUES (CAST(N'2025-10-10T12:34:16.0000000-07:30' AS DateTimeOffset))
INSERT Lesson312 (CurrentDateTime) VALUES (CAST(N'2025-10-10T12:34:16.0000000-13:30' AS DateTimeOffset))
INSERT Lesson312 (CurrentDateTime) VALUES (CAST(N'2025-10-10T12:34:16.0000000+14:00' AS DateTimeOffset))
INSERT Lesson312 (CurrentDateTime) VALUES (CAST(N'2025-10-10T10:10:10.0000000+00:00' AS DateTimeOffset))
GO
INSERT MyTable (FullName) VALUES (N'Tony Robert Lance')
INSERT MyTable (FullName) VALUES (N'Tony Robert Martin')
INSERT MyTable (FullName) VALUES (N'Tr?n Bá Nam')
GO
SET IDENTITY_INSERT Person ON 

INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (100, N'Nam', N'Nguyễn', N'Văn', 20, N'Hà Nội', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (101, N'Mai', N'Phạm', N'Thị', 21, N'Thanh Hóa', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (102, N'Minh', N'Lê', N'Đình', 22, N'Hải Dương', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (103, N'Khánh', N'Nguyễn', N'Ngọc', 24, N'Bắc Giang', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (104, N'Hương', N'Mai', N'Thị Diệu', 20, N'Thái Nguyên', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (110, N'Nhân', N'Nguyễn', N'Thành', 20, N'Hà Nội', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (111, N'Minh', N'Nguyễn', N'Đức', 20, N'Hà Nội', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (112, N'Lành', N'Nguyễn', N'Thị', 21, N'Hà Nội', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (120, N'Long', N'Phạm', N'Đình', 20, N'Nghệ An', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (121, N'Linh', N'Trần', N'Hạo', 20, N'Hà Nam', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (122, N'Liên', N'Ngô', N'Thu', 20, N'Cà Mau', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (123, N'Hồng', N'Lê', N'Thị Minh', 21, N'Bình Dương', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (124, N'Luyến', N'Nông', N'Thị Lưu', 20, N'Tây Ninh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (125, N'Nga', N'Vũ', N'Thị Thu', 21, N'Hà Tĩnh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (130, N'Long', N'Phạm', N'Đình', 20, N'Nghệ An', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (131, N'Linh', N'Trần', N'Hạo', 20, N'Hà Nam', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (132, N'Liên', N'Ngô', N'Thu', 20, N'Cà Mau', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (133, N'Hồng', N'Lê', N'Thị Minh', 21, N'Bình Dương', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (134, N'Luyến', N'Nông', N'Thị Lưu', 20, N'Tây Ninh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (135, N'Nga', N'Vũ', N'Thị Thu', 21, N'Hà Tĩnh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (140, N'Long', N'Phạm', N'Đình', 20, N'Nghệ An', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (141, N'Linh', N'Trần', N'Hạo', 20, N'Hà Nam', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (142, N'Liên', N'Ngô', N'Thu', 20, N'Cà Mau', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (143, N'Hồng', N'Lê', N'Thị Minh', 21, N'Bình Dương', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (144, N'Luyến', N'Nông', N'Thị Lưu', 20, N'Tây Ninh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (145, N'Nga', N'Vũ', N'Thị Thu', 21, N'Hà Tĩnh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (204, N'Hoàng', N'Vũ', N'Đình', 20, N'Đà Nẵng', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (205, N'Oanh', N'Trần', N'Thị Thu', 19, N'Nam Định', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (206, N'Linh', N'Mai', N'Thùy', 20, N'Vĩnh Long', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (207, N'Hòa', N'Trịnh', N'Khánh', 21, N'Đà Nẵng', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (208, N'Bắc', N'Ngô', N'Văn', 22, N'Bình Dương', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (209, N'Hường', N'Lê', N'Thị', 20, N'Hồ Chí Minh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (210, N'Dũng', N'Trần', N'Hoàng', 21, N'Hồ Chí Minh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (211, N'Quang', N'Huỳnh', N'Văn', 20, N'Cà Mau', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (212, N'Hạnh', N'Lưu', N'Hồng', 19, N'Bến Tre', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (214, N'Anh', N'Nguyễn', N'Hoàng', 21, N'Điện Biên', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (215, N'Mạnh', N'Nông', N'Đức', 24, N'Long An', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (216, N'truong', N'viet', N'hoang', 23, N'Hồ Chí Minh', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (219, N'Pía', N'Giàng', N'Alinh', 25, N'Long An', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (220, N'Hung', N'Le', N'Nguyen Van', 21, N'Ha Nam', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (221, N'Hoang', N'Luu', N'Tran Ngo', 23, N'Nghe An', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (222, N'Lam', N'Nguyen', N'Van', NULL, N'Bac Giang', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (223, N'Khanh', N'Ngo', N'Gia', 0, N'Hai Duong', NULL)
INSERT Person (Id, FirstName, LastName, MidName, Age, Address, Email) VALUES (224, N'Truong', N'Le', N'Quang', 21, N'Phu Yen', NULL)
SET IDENTITY_INSERT Person OFF
GO
SET IDENTITY_INSERT Register ON 

INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1000, N'B25DCCN101', N'SUBJ1001', CAST(N'2022-04-19T00:00:00.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1001, N'B25DCCN102', N'SUBJ1002', CAST(N'2022-04-19T00:01:24.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1002, N'B25DCCN103', N'SUBJ1003', CAST(N'2022-04-19T00:10:20.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1003, N'B25DCDT108', N'SUBJ1004', CAST(N'2022-04-19T00:11:11.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1004, N'B25DCCN101', N'SUBJ1003', CAST(N'2022-04-19T00:01:01.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1005, N'B25DCQT109', N'SUBJ1005', CAST(N'2022-04-19T00:05:23.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1006, N'B25DCQT150', N'SUBJ1003', CAST(N'2022-04-19T00:03:45.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1007, N'B25DCCN178', N'SUBJ1007', CAST(N'2022-04-19T00:06:27.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1008, N'B25DCDT108', N'SUBJ1009', CAST(N'2022-04-19T00:07:12.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1009, N'B25DCQT150', N'SUBJ1007', CAST(N'2022-04-19T00:12:15.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1011, N'B25DCCN101', N'SUBJ1002', CAST(N'2022-04-19T01:00:01.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1012, N'B25DCCN104', N'SUBJ1005', CAST(N'2022-04-19T01:01:05.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1013, N'B25DCCN101', N'SUBJ1005', CAST(N'2022-04-19T01:02:32.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1014, N'B25DCCN102', N'SUBJ1006', CAST(N'2022-04-19T01:03:25.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1016, N'B25DCCN103', N'SUBJ1001', CAST(N'2022-04-19T01:05:36.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1017, N'B25DCCN102', N'SUBJ1001', CAST(N'2022-04-19T02:23:00.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1018, N'B25DCCN101', N'SUBJ1004', CAST(N'2022-04-19T02:21:13.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1019, N'B25DCQT150', N'SUBJ1001', CAST(N'2022-04-19T02:25:31.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1022, N'B25DCQT150', N'SUBJ1002', CAST(N'2022-04-19T02:26:20.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1023, N'B25DCQT150', N'SUBJ1004', CAST(N'2022-04-19T02:27:36.000' AS DateTime))
INSERT Register (Id, StudentId, SubjectId, RegisterTime) VALUES (1024, N'B25DCDT108', N'SUBJ1005', CAST(N'2022-04-19T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT Register OFF
GO
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN101', N'Trần Anh Dũng', N'Hà Nội', N'CNTT', CAST(N'2007-01-01' AS Date), N'0358213597', 3.05)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN102', N'Lê Quỳnh Trang', N'Thanh Hóa', N'CNTT', CAST(N'2007-10-10' AS Date), N'0362126126', 3.26)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN103', N'Hoàng Văn Hưng', N'Quảng Ngãi', N'CNTT', CAST(N'2007-01-21' AS Date), N'0978123123', 3.38)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN104', N'Mai Trường Giang', N'Thái Bình', N'CNTT', CAST(N'2006-05-23' AS Date), N'0987456456', 3.67)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN105', N'Khúc Bá Vinh', N'Cao Bằng', N'CNTT', CAST(N'2007-10-14' AS Date), N'0975123654', 3.18)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN106', N'Ma Thị Hà', N'Bắc Ninh', N'CNTT', CAST(N'2007-04-04' AS Date), N'0962123123', 3.67)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN107', N'Nguyễn Thu Nga', N'Điện Biên', N'CNTT', CAST(N'2006-05-15' AS Date), N'0362145652', 3.67)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN108', N'Trương Quỳnh Trâm', N'Hà Nội', N'CNTT', CAST(N'2006-04-27' AS Date), N'0358123698', 3.86)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN120', N'Trần Văn Vỹ', N'Điện Biên', N'CNTT', CAST(N'2007-02-23' AS Date), N'0971245632', 3.64)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN178', N'Trương Việt Hùng', N'Đồng Nai', N'CNTT', CAST(N'2007-08-09' AS Date), N'0378123654', 3.26)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCCN224', N'Nông Đức Thành', N'Hà Nội', N'CNTT', CAST(N'2006-10-19' AS Date), N'0369123654', 3.46)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCDT106', N'Lê Văn Bình', N'Trà Vinh', N'ĐTVT', CAST(N'2007-06-25' AS Date), N'0956123587', 3.36)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCDT108', N'Nguyễn Huy Hoàng', N'Nam Định', N'ĐTVT', CAST(N'2007-04-20' AS Date), N'0965125456', 3.19)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCDT115', N'Lê Văn Tuấn', N'Đà Nẵng', N'ĐTVT', CAST(N'2007-09-11' AS Date), N'0974133669', 3.64)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCHT100', N'Ngô Duy Hoàng', N'Hà Nội', N'HTTT', CAST(N'2007-10-11' AS Date), N'0351236541', 3.58)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCHT102', N'Trần Văn Vĩ', N'Hải Phòng', N'HTTT', CAST(N'2006-08-09' AS Date), N'0387125126', 3.17)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCQT109', N'Lưu Thu Thảo', N'Hải Dương', N'QTKD', CAST(N'2007-07-16' AS Date), N'0964789512', 3.64)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCQT110', N'Mai Thị Hoa', N'Nghệ An', N'QTKD', CAST(N'2007-03-30' AS Date), N'0974154145', 3.2)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCQT150', N'Trần Khắc Trung', N'Hồ Chí Minh', N'QTKD', CAST(N'2007-04-25' AS Date), N'0984157845', 3.71)
INSERT Student (Id, FullName, Address, Major, BirthDate, PhoneNumber, Gpa) VALUES (N'B25DCVT101', N'Mai Hắc Đình', N'Đà Nẵng', N'ĐTVT', CAST(N'2006-06-14' AS Date), N'0398123123', 3.14)
GO
INSERT Student2 (Id, FullName, Gpa) VALUES (N'SV001', N'Nguyễn Thành Nam', 3.25)
INSERT Student2 (Id, FullName, Gpa) VALUES (N'SV002', N'Nguyễn Thành Nhân', 3.29)
INSERT Student2 (Id, FullName, Gpa) VALUES (N'SV008', N'Nguyễn Công Vinh', 3.99)
INSERT Student2 (Id, FullName, Gpa) VALUES (N'SV007', N'Lê Công Tuấn', 3)
INSERT Student2 (Id, FullName, Gpa) VALUES (N'SV006', N'Lê Nam Tuấn', 3.34)
GO
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1001', N'C++', 3, 36, N'Cơ bản')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1002', N'C#', 4, 48, N'Nâng cao')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1003', N'Java', 4, 48, N'Nâng cao')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1004', N'SQL', 3, 36, N'Cơ sở ngành')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1005', N'Trí tuệ nhân tạo', 4, 48, N'Chuyên ngành')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1006', N'Lập trình Android', 4, 48, N'Chuyên ngành')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1007', N'Thiết kế đồ họa', 3, 36, N'Chuyên ngành')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1008', N'Cơ sở dữ liệu phân tán', 3, 36, N'Cơ sở ngành')
INSERT Subject (Id, Name, Credit, NumOfLesson, Type) VALUES (N'SUBJ1009', N'Cấu trúc dữ liệu và giải thuật', 3, 36, N'Cơ bản')
GO
ALTER TABLE Customer ADD  DEFAULT (newid()) FOR Id
GO
ALTER TABLE Person ADD  DEFAULT ((0)) FOR Age
GO
ALTER TABLE Register  WITH CHECK ADD  CONSTRAINT FK_Register_Student FOREIGN KEY(StudentId)
REFERENCES Student (Id)
GO
ALTER TABLE Register CHECK CONSTRAINT FK_Register_Student
GO
ALTER TABLE Register  WITH CHECK ADD  CONSTRAINT FK_Register_Subject FOREIGN KEY(SubjectId)
REFERENCES Subject (Id)
GO
ALTER TABLE Register CHECK CONSTRAINT FK_Register_Subject
GO
USE master
GO
ALTER DATABASE LearnSQL SET  READ_WRITE 
GO
