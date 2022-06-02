use ApartmentManagement

--drop table Users
create table Users(
userId int primary key identity(1,1),
userAccount nvarchar(50) not null,
userPassword nvarchar(2000) not null,
userEmail nvarchar(50),
userPhone varchar(20),
userCreateDate date, 
userRole nvarchar(10),
code varchar(255),
userName nvarchar(50),
resetCode varchar(30)
);

--預設管理員帳號 帳號: admin 密碼: admin
insert into Users(userAccount,userPassword,userEmail,userPhone,userCreateDate,userRole)
values ('admin','$2a$10$ahRN42BeTDV67TNeF8.ocOQjlrfutkhcRRfpSI9H.ukyBJfoVGzAC','admin@gmail.com','0987654321', GETDATE() ,'admin')
--delete from Users where userId = 7

select *from Users

create table GymReserve(
	gymId int primary key identity(1,1) not null,
	userId int references users(userId) not null,
	reservePresent date ,
	reservePeriod date,
	reserveScope nvarchar(20),
	checkin smalldatetime,
	checkout smalldatetime,
	employees int ,
	state nvarchar(10)
)

create table KtvReserve(
	ktvId int primary key identity(1,1) not null,
	userId int references users(userId) not null,
	reservePresent date ,
	reservePeriod date,
	reserveScope nvarchar(20),
	checkin smalldatetime,
	checkout smalldatetime,
	state nvarchar(10)
)

--餐點
create table Meal(
mealId int primary key identity(1,1),
mealName nvarchar(20),
mealPrice int,
mealType nvarchar(10),
mealImage nvarchar(500),
saleCount int DEFAULT ('0'),
mealStock int DEFAULT ('1'),
mealStatus int DEFAULT ('1')
);

create table Package(
packageId int primary key identity(1000,1),
userId int references Users(userId),
adminAccount nvarchar(50),--管理員帳號
adminAccountReceive　nvarchar(50),
userAccount nvarchar(50),
packageImage nvarchar(500),
packageSigntime date,
packagePicktime date,
packageBarcode nvarchar(30),
packageContent nvarchar(30),
packageNote nvarchar(30),
state nvarchar(10) not null
);
select * from Package

create table Deposit(
depositId int primary key identity(1000,1),
userId int references Users(userId),
adminAccount nvarchar(50),--管理員帳號
adminAccountReceive　nvarchar(50),
userAccount nvarchar(50),
depositSigntime date,
depositPicktime date,
depositContent nvarchar(30),
depositNote nvarchar(30),
state nvarchar(10) not null
);
select * from Deposit
create table Forum(
bbId int primary key identity(1,1),
userId int references Users(userId),
bbType nvarchar(20) DEFAULT null,
bbTitle nvarchar(50) not null ,
bbContent text not null,
bbDatetime date,
bbfile nvarchar(50),
)

create table Firm(
firmId int primary key identity(1,1),
firmName nvarchar(60),
firmType nvarchar(30),
firmPhone nvarchar(30),
firmUrl nvarchar(1500),
firmAddress nvarchar(100),
firmService nvarchar(100),
firmHours nvarchar(100)
);



--訂單表頭
create table Orders(
orderId int primary key identity(1,1),
orderNo varchar(200),
userId int references users(userId),
orderMoney int,
orderDatetime datetime,
finishDatetime datetime,
orderStatus int
);

--訂單明細
create table OrderDetail(
odId int primary key identity(1,1),
orderNo varchar(200),
mealId int,
amount int,
foreign key (mealId) references meal(mealId)
);


--購物車
create table Cart(
cartId int primary key identity(1,1),
mealId int,
amount int,
userId int,
foreign key (userId) references users(userId)
);

