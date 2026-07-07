select * from tblGender
select * from tblPerson

insert into tblPerson (ID, [Name],Email ,GenderId) values (10 ,'sdich ' , 'rsd@r.com', Null )

alter table tblPerson 
add constraint DF_tblPerson_GenderId
Default 3 for GENDERID  --  GENDERID değeri verilmezse [default] olarak 3 atar [null] olmaz artık [foreign  key]den ötürü 1 2 3 değerlerinden birini alabilir

-- alter table ve drop constraint birlikte çalışmalı
alter table tblPerson
drop constraint DF_tblPerson_GenderId

Delete from tblPerson Where ID = 7 -- foreign kry olduğu için silinemiyor 

-- insert and update specificial delete rule  -- update rule  foreign key relationships  key kısmından gittik  set default yaptık artık silebiliriz

--adding a check constraint

-- Mevcut bir tabloya yeni kolon eklemek için
-- Database → Sample Tablo → tblPerson Eklenecek kolon → Age

use Sample
go
alter table tblPerson
add Age int

-- kısıtlama koymak istersen


select * from tblPerson  -- press alt F1  ile değişkenler görüntülenebilir

-- Eğer Age için kısıtlama koymak istersen
ALTER TABLE tblPerson
ADD CONSTRAINT CK_tblPerson_Age
CHECK (Age BETWEEN 0 AND 120);

alter table tblPerson
drop constraint DF_tblPerson_Age



insert into tblPerson (ID, [Name],Email ,GenderId, Age) values (7 ,'sara ' , 'sasd@r.com', Null,150 )


-- identity column

select * from dbo.tblPerson

insert into dbo.tblPerson values (7,'todd','t@t.com',1,26)

-- tables oluşturulan table columns variable properties identity value  

-- tablo oluştururken  nasıl oluşturacağını başlangıçta tanımlayabilirsin index değerini ve artış değerini belirleyebilirsin

-- identify oluşturulan bir şey silinrse o değer boş kalır doldurulmaya kalkarsa error verir

-- SET IDENTITY_INSERT komutu, IDENTITY (otomatik artan) kolona manuel değer eklemek için kullanılır 

-- identity özelliğni açıp kapatırız

SET IDENTITY_INSERT tblPerson1 ON

SET IDENTITY_INSERT tblPerson1 OFF

Delete from tblPerson -- herşeyi siler

-- her şeyi sildikten sonra indexi 0 lamak için

DBCC CHECKIDENT ('tblPerson1', RESEED, 0);

--------------------------------------

create table test1
(
ID int identity(1,1),
Value nvarchar(20)
)

create table test2
(
ID int identity(1,1),
Value nvarchar(20)
)
-- ıd otomatik arıcak ona değer girmemiz gerkmiyor
insert into test1 values('X')
insert into test1 values('Y')

select * from test1

-- indexin kaçta olduğunu görmek için
select SCOPE_IDENTITY()
-- veya
select @@IDENTITY

Create Trigger trForInsert on test1 for Insert
as
begin 
	insert into test1 values('yyyy')
end

--unique key     table sag click design  indexes/keys add  en üstte çıkan   
-- veya
alter table tblPerson
add constraint UQ_tblPerson_Email Unique(Email)--  ad  ve hangi değişken 

insert into tblPerson values(8,'abc','a@a.com',1,20)

select * from tblPerson

-- constraint kaldırma
alter table tblPerson
drop Constraint UQ_tblPerson_Email

-- primary key veya unique key eşşisdir aynı değerde 2 tane oluşturulamaz

-- select statetment
-- tablo sağ tık script table as select to new query editor window 

-- select from yerine 

USE [Sample]
GO

SELECT [ID]
      ,[Name]
      ,[Email]
      ,[GenderId]
      ,[Age]
  FROM [dbo].[tblPerson]

GO
-- tek değişken içini görme
select distinct Email,[Name] from tblPerson

select * from tblPerson where Age=20
-- <> bu  not equal demek
select * from tblPerson where Age<> 20

select * from tblPerson where Age= 20 or Age=26
-- ikisi aynı şey
select * from tblPerson where Age IN(20 , 26)

select * from tblPerson where Age Between 23 and 65

-- Email i s ile başlayanlar
select * from tblPerson where Email like 's%'

select * from tblPerson where Email not like 's%'


-- Email nde içinde @ işareti bulunanlar 
select * from tblPerson where Email like '%@%'

select * from tblPerson where Email like '%@_.com'
--  _ bu işaret çoğul alır  sonrasına .com ise bununla bitsin

select * from tblPerson where Name like '[aj]%' 
-- Name değişkenşnede ilk harfinde a veya j bulunanlar
select * from tblPerson where Name like '[^aj]%' 
-- Name değişkenşnede ilk harfinde a veya j bulunanmayanlar

select * from tblPerson where (City ='Landon' or City = 'Mumabi' ) and Age >25

-- sıralama
select * from tblPerson order by Age  DESC

-- ikili sıralama
select * from tblPerson order by Name , Age

select top 2 * from tblPerson

select top 50 percent * from tblPerson

-- filter grups


-- Tablo oluşturma
CREATE TABLE grupfilter (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    Salary INT,
    City VARCHAR(50)
);

-- Veri ekleme
INSERT INTO grupfilter VALUES (1, 'Tom', 'Male', 4000, 'London');
INSERT INTO grupfilter VALUES (2, 'Pam', 'Female', 3000, 'New York');
INSERT INTO grupfilter VALUES (3, 'John', 'Male', 3500, 'London');
INSERT INTO grupfilter VALUES (4, 'Sam', 'Male', 4500, 'London');
INSERT INTO grupfilter VALUES (5, 'Todd', 'Male', 2800, 'Sydney');
INSERT INTO grupfilter VALUES (6, 'Ben', 'Male', 7000, 'New York');
INSERT INTO grupfilter VALUES (7, 'Sara', 'Female', 4800, 'Sydney');
INSERT INTO grupfilter VALUES (8, 'Valarie', 'Female', 5500, 'New York');
INSERT INTO grupfilter VALUES (9, 'James', 'Male', 6500, 'London');
INSERT INTO grupfilter VALUES (10, 'Russell', 'Male', 8800, 'London');

-- GROUP BY sorgusu


select Sum(Salary) from grupfilter

select min(Salary) from grupfilter 


SELECT City, SUM(Salary) AS TotalSalary
FROM grupfilter 
group by city

select City, Gender, sum(Salary) as TotalSalary
from grupfilter
group by City,gender
order by City
-- select yanına değişken adı gelirse  as kullanılır 
select city from grupfilter group by city

select count(ID) from grupfilter

-- Total_Employesss   adında değişken oluştur   ve toplam çalışanı bulur 
select City, Gender, sum(Salary) as TotalSalary, count(ID) as Total_Employees
from grupfilter
group by City,gender

select City, Gender, sum(Salary) as TotalSalary, count(ID) as Total_Employees
from grupfilter
where Gender ='Male'
group by City,gender

-- fark var yapay zeka sor farkı 
select City, Gender, sum(Salary) as TotalSalary, count(ID) as Total_Employees
from grupfilter
group by City,gender
Having Gender ='Male'


select * from  grupfilter where sum(Salary) > 4000 -- bu çalışmaz hata verir


select City, Gender, sum(Salary) as TotalSalary, count(ID) as Total_Employees
from grupfilter
group by City,gender
Having sum(Salary) > 4000

-------------------  joins 

-- 1. TABLO: tblEmployee
CREATE TABLE tblEmployee (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    Salary INT,
    DepartmentId INT
);

INSERT INTO tblEmployee VALUES (1, 'Tom', 'Male', 4000, 1);
INSERT INTO tblEmployee VALUES (2, 'Pam', 'Female', 3000, 3);
INSERT INTO tblEmployee VALUES (3, 'John', 'Male', 3500, 1);
INSERT INTO tblEmployee VALUES (4, 'Sam', 'Male', 4500, 2);
INSERT INTO tblEmployee VALUES (5, 'Todd', 'Male', 2800, 2);
INSERT INTO tblEmployee VALUES (6, 'Ben', 'Male', 7000, 1);
INSERT INTO tblEmployee VALUES (7, 'Sara', 'Female', 4800, 3);
INSERT INTO tblEmployee VALUES (8, 'Valarie', 'Female', 5500, 1);
INSERT INTO tblEmployee VALUES (9, 'James', 'Male', 6500, NULL);
INSERT INTO tblEmployee VALUES (10, 'Russell', 'Male', 8800, NULL);

-- 2. TABLO: tblDepartment
CREATE TABLE tblDepartment (
    Id INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50),
    DepartmentHead VARCHAR(50)
);

INSERT INTO tblDepartment VALUES (1, 'IT', 'London', 'Rick');
INSERT INTO tblDepartment VALUES (2, 'Payroll', 'Delhi', 'Ron');
INSERT INTO tblDepartment VALUES (3, 'HR', 'New York', 'Christie');
INSERT INTO tblDepartment VALUES (4, 'Other Department', 'Sydney', 'Cinderella');

-- INNER JOIN Sorgusu
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.Id;

select * from tblEmployee
select * from tblDepartment
--  from ilk tablo join ikinci tablo on kısmına neleri eşitleyeceksen
select Name, Gender , Salary , DepartmentName  from tblEmployee
left join tblDepartment  
on tblEmployee.DepartmentId=tblDepartment.Id
-- left join yerine left outer join de yazılabilir
-- right join de var


SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
full JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.Id;

/*
Cross Join — İki tablonun kartezyen çarpımını döndürür (tüm kombinasyonlar).
Inner Join — Sadece eşleşen satırları döndürür, eşleşmeyenler elenir.
Left Join — Sol tablonun tüm satırları + sağ tablodan eşleşenler gelir.
Right Join — Sağ tablonun tüm satırları + sol tablodan eşleşenler gelir.
Full Join — Her iki tablodan da tüm satırlar gelir, eşleşmeyenler NULL olarak görünür.
*/


select Name ,Gender,Salary,DepartmentName
from tblEmployee
left join tblDepartment
on         tblEmployee.DepartmentId=tblDepartment.Id
where  tblEmployee.DepartmentId is null

---------------------------- tek tablodan  düzenleme yapma

CREATE TABLE tblEmployee1 (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    ManagerID INT
);

INSERT INTO tblEmployee1 (EmployeeID, Name, ManagerID)
VALUES 
(1, 'Mike', 3),
(2, 'Rob', 1),
(3, 'Todd', NULL),
(4, 'Ben', 1),
(5, 'Sam', 1);

SELECT 
    E.Name AS Employee1, 
    M.Name AS Manager
FROM tblEmployee1 E
LEFT JOIN tblEmployee1 M
ON E.ManagerID = M.EmployeeID;


----------  differnt ways to replace null values



select      E.Name as Employee , M.name as mannager
from        tblEmployee1 E
left join   tblEmployee1 M
on          E.ManagerID=M.EmployeeID

SELECT 
    E.Name AS Employee, 
    ISNULL(M.Name, 'No Manager') AS Manager_ISNULL,
    COALESCE(M.Name, 'No Manager') AS Manager_COALESCE
FROM tblEmployee1 E
LEFT JOIN tblEmployee1 M 
ON E.ManagerID = M.EmployeeID;

SELECT 
    E.Name AS Employee, 
    COALESCE(M.Name, 'Yönetici Atanmadı') AS [Yonetici Durumu]
FROM tblEmployee1 E
LEFT JOIN tblEmployee1 M ON E.ManagerID = M.EmployeeID;

/*ISNULL ve COALESCE fonksiyonlarının kullanım farkları ve parametre sayılarından kaynaklanıyor. 
Bu fonksiyonlar SQL'de NULL (boş/bilinmeyen) değerleri yönetmek ve "Eğer bu değer boşsa yerine şunu yaz" demek için kullanılır.

ISNULL fonksiyonu SQL Server'da sadece 2 parametre kabul eder: ISNULL(kontrol_edilecek_değer, boşsa_yazılacak_değer).
COALESCE fonksiyonu ISNULL'a göre daha gelişmiştir ve sınırsız sayıda parametre alabilir. Listeyi soldan sağa doğru kontrol eder ve bulduğu ilk NULL olmayan değeri döndürür.
*/

-- CASE WHEN
-- programlama dillerindeki "If-Else" mantığının SQL karşılığıdır. Bir sütundaki değere bakıp, o değer belirli bir şarta uyuyorsa başka bir sonuç yazdırmak için kullanılır.


SELECT Name, Salary,
CASE 
    WHEN Salary >= 5000 THEN 'Yüksek Maaş'
    WHEN Salary BETWEEN 3000 AND 4999 THEN 'Orta Maaş'
    ELSE 'Düşük Maaş'
END AS Maat_Durumu
FROM tblEmployee;

SELECT 
    E.Name AS Employee, 
    CASE 
        WHEN M.Name IS NULL THEN 'Yönetici Atanmadı' 
        ELSE M.Name 
    END AS Manager
FROM tblEmployee1 E
LEFT JOIN tblEmployee1 M 
ON E.ManagerID = M.EmployeeID;













