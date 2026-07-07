use Sample

go
create table tblEmployee2(
ID int primary key,
FristName Nvarchar(50),
MiddleName Nvarchar(50),
LastName Nvarchar(50),
);

insert into tblEmployee2 (ID, FristName , MiddleName ,LastName)
values
(1,'Sam',NULL,Null),
(2,null,'Todd','Tanzan'),
(3,Null,null,'Sara'),
(4,'ben','Parker',NULL),
(5,'james','Nick','Nancy');

select * from tblEmployee2

--  COALESCE fonksiyonunun listedeki ilk NULL olmayan değeri döndürme özelliğini test etmek içindir
-- ilk firstname e bakacak null değer varsa middlename e  bakacak o da null sa lastname bakacak   null olmayan değeri döndürecek
select ID,Coalesce(FristName,MiddleName,LastName) as Name 
from tblEmployee2

    
use Sample
go
create table tblIndiaCustomers(
ID int primary key,
Name Nvarchar(50),
Email nvarchar(50),
);

create table tblUKCustomers(
ID int primary key,
Name Nvarchar(50),
Email nvarchar(50),
);

insert into tblIndiaCustomers(ID ,Name,Email) 
values 
(1,'Raj','R@R.com'),
(2,'Sam','S@S.com');


insert into tblUKCustomers(ID ,Name,Email) 
values 
(1,'Ben','B@B.com'),
(2,'Sam','S@S.com');

select * from tblUKCustomers
UNION all
select * from tblIndiaCustomers

-- union all tek tablo haline getirdi 


select * from tblUKCustomers
UNION 
select * from tblIndiaCustomers


-- sam den ikitane var sadece bir tanesini aldı her şeyi aynı olmalı   

-- ctrl + l exucation planı açar  union çalıştığı zaman  sort  çalışır arka planda


select ID, Name  from tblUKCustomers
UNION 
select ID, Name , Email from tblIndiaCustomers

-- çalışmaz yukarıdaki kod unionda  tablolardaki veriler aynı olmalı 



select ID,Email, Name  from tblUKCustomers
UNION 
select ID, Name , Email from tblIndiaCustomers

-- sıraları farklıysa order karşılaştırması yapmaz 



use Sample
go 
-- 1. Tabloyu oluşturma
CREATE TABLE tblEmployee3 (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10),
    DepartmentId INT
);

-- 2. Verileri ekleme
INSERT INTO tblEmployee3 (Id, Name, Gender, DepartmentId)
VALUES 
(1, 'Sam', 'Male', 1),
(2, 'Ram', 'Male', 1),
(3, 'Sara', 'Female', 3),
(4, 'Todd', 'Male', 2),
(5, 'John', 'Male', 3),
(6, 'Sana', 'Female', 2),
(7, 'James', 'Male', 1),
(8, 'Rob', 'Male', 2),
(9, 'Steve', 'Male', 1),
(10, 'Pam', 'Female', 2);

select * from tblEmployee3

create procedure spGetEmployee3
as
begin
select Name, Gender from tblEmployee3
end
-- bu oluşturulan  sample programmability  stored procedures kısmında gözükür
tblEmployee3   -- buna basınca hata verir

spGetEmployee3  -- sadece buna basınca tabloyu verir
use Sample

go
 create proc spGetspGetEmployee3byGenderAndDepartment
 @Gender nvarchar(20),
 @DepartmentId int 
 as

 Begin 
   select Name ,Gender,DepartmentId from tblEmployee3 where  Gender =@Gender  and DepartmentId=@DepartmentId
 end
 

 spGetspGetEmployee3byGenderAndDepartment 
 -- Procedure or function 'spGetspGetEmployee3byGenderAndDepartment' expects parameter '@Gender', which was not supplied.  Bu çalışmayacak  çalışması için hangi parametreleri alması gerektiğini söyleyeceğiz

 spGetspGetEmployee3byGenderAndDepartment 'Male' , 1 
 --  verdiğimiz parametreleri sırasıyla buna göre eklemeliyiz  @Gender nvarchar(20),  @DepartmentId int  variance order önemli 

 -- veya alternatif olarak 

    spGetspGetEmployee3byGenderAndDepartment  @DepartmentId =1, @Gender= 'Male'  -- çalışır


    sp_helptext  spGetEmployee3 --   spGetEmployee3  kodunun nasıl yazıldığını gösterir

    create procedure spGetEmployee3  
as  
begin  
select Name, Gender from tblEmployee3  order by Name
end  
-- hata verecek önceden yarattığımız için 

-- alter komutu ile güncelleme yapabiliriz
alter  procedure spGetEmployee3  
as  
begin  
select Name, Gender from tblEmployee3  order by Name
end  

drop proc spGetEmployee3  -- procedürü siler

sp_helptext  spGetspGetEmployee3byGenderAndDepartment

--  prosedürü sifreleme
-- sp_helptext ile bu prosedürün içindeki kaynak kodunu göremez
 Alter  proc spGetspGetEmployee3byGenderAndDepartment  
 @Gender nvarchar(20),  
 @DepartmentId int   
 WITH Encryption
 as  
  
 Begin   
   select Name ,Gender,DepartmentId from tblEmployee3 where  Gender =@Gender  and DepartmentId=@DepartmentId  
 end  

 ALTER TABLE tblEmployee3
ADD Email NVARCHAR(100); -- Tabloya Email sütunu ekler

ALTER TABLE tblEmployee3
DROP COLUMN Email; -- Email sütununu tablodan tamamen kaldırır

select * from tblEmployee3

CREATE PROCEDURE spGetEmployeeCountByGender
    @Gender NVARCHAR(20),          -- Giriş parametresi
    @EmployeeCount INT OUTPUT      -- Çıkış parametresi (Dışarıya değer döndürür)
AS
BEGIN
    -- SELECT ile bulunan değeri @EmployeeCount değişkenine atıyoruz
    SELECT @EmployeeCount = COUNT(*) 
    FROM tblEmployee3 
    WHERE Gender = @Gender
END

DECLARE @TotalCount INT -- Sonucu tutacak değişken

-- Prosedürü çağırırken 'OUTPUT' kelimesini mutlaka eklemelisin
EXEC spGetEmployeeCountByGender 'Male', @TotalCount OUTPUT

-- Sonucu ekranda görelim
SELECT @TotalCount AS [Erkek Çalışan Sayısı]

-- Prosedürü çalıştırırken sonucu saklamak için bir değişken tanımlamalı ve OUTPUT kelimesini mutlaka kullanmalısın. 
-- Görselde de belirtildiği gibi, eğer OUTPUT kelimesini unutursan değişkenin değeri NULL döner.

DECLARE @TotalCount INT
EXEC spGetEmployeeCountByGender 'Male', @TotalCount 
if(@TotalCount is null)
print '@TotalCount is null'
else
print '@TotalCount is not null'



DECLARE @TotalCount INT
-- Doğru kullanım (parametre ismi tanımlandığı gibi olmalı):
EXEC spGetEmployeeCountByGender @EmployeeCount = @TotalCount OUT, @Gender = 'Male'
print @TotalCount


sp_help spGetEmployeeCountByGender

sp_helptext spGetEmployeeCountByGender

sp_depends spGetEmployeeCountByGender

sp_depends tblEmployee3

/* =================================================================================
   GÖRSELLERDEKİ EĞİTİM MATERYALİNİN SQL KODU ÜZERİNDE TAM AÇIKLAMASI
   ================================================================================= */

-- Önce örneklerimizin çalışabilmesi için geçici bir tablo oluşturalım (Görsellerdeki tblEmployee)
CREATE TABLE tblEmployee (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10),
    DepartmentId INT
);

INSERT INTO tblEmployee VALUES 
(1, 'Sam', 'Male', 1), (2, 'Ram', 'Male', 1), (3, 'Sara', 'Female', 3),
(4, 'Todd', 'Male', 2), (5, 'John', 'Male', 3);
GO

/* ---------------------------------------------------------------------------------
   BÖLÜM 1: STORED PROCEDURE PARAMETRELERİ VE TEMEL BİLGİLER
   --------------------------------------------------------------------------------- */
-- 1. Parametreler ve değişkenler her zaman '@' (at) işareti ile başlar.

-- Örnek bir prosedür oluşturalım:
CREATE PROCEDURE spGetEmployeesByGenderAndDepartment
    @Gender NVARCHAR(20), 
    @DepartmentId INT
AS
BEGIN
    SELECT * FROM tblEmployee WHERE Gender = @Gender AND DepartmentId = @DepartmentId
END
GO

-- PROSEDÜRÜ ÇALIŞTIRMA (EXECUTE) YÖNTEMLERİ:
-- Yöntem A: Sıralı (Değerler prosedürdeki tanımlama sırasına göre girilir)
EXECUTE spGetEmployeesByGenderAndDepartment 'Male', 1;

-- Yöntem B: İsimlendirilmiş Parametreler (Sıranın önemi yoktur, değişken isimleri açıkça yazılır)
EXECUTE spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male';

-- PROSEDÜR METNİNİ (KODUNU) GÖRMEK:
-- Sistem prosedürü olan sp_helptext kullanılır.
EXEC sp_helptext 'spGetEmployeesByGenderAndDepartment';
-- (Veya Object Explorer'da sağ tıklayıp Script Procedure as -> Create To -> New Query Window diyebilirsin)

-- PROSEDÜRÜ DEĞİŞTİRMEK, SİLMEK VE ŞİFRELEMEK:
-- Değiştirmek için CREATE yerine ALTER yazılır.
-- Silmek için: DROP PROC 'ProsedürAdı' kullanılır.
-- Şifrelemek için WITH ENCRYPTION eklenir. Şifrelenmiş kod sp_helptext ile GÖRÜLEMEZ.
ALTER PROCEDURE spGetEmployeesByGenderAndDepartment
    @Gender NVARCHAR(20), 
    @DepartmentId INT
WITH ENCRYPTION -- Bu kod artık gizlendi
AS
BEGIN
    SELECT * FROM tblEmployee WHERE Gender = @Gender AND DepartmentId = @DepartmentId
END
GO


/* ---------------------------------------------------------------------------------
   BÖLÜM 2: OUTPUT (ÇIKIŞ) PARAMETRELERİ KULLANIMI
   --------------------------------------------------------------------------------- */
-- Çıkış parametresi oluşturmak için OUT veya OUTPUT anahtar kelimesi kullanılır.

CREATE PROCEDURE spGetEmployeeCountByGender
    @Gender NVARCHAR(20),
    @EmployeeCount INT OUTPUT -- Bu değer dışarıya aktarılacak
AS
BEGIN
    SELECT @EmployeeCount = COUNT(Id) 
    FROM tblEmployee 
    WHERE Gender = @Gender
END
GO

-- OUTPUT PROSEDÜRÜNÜ ÇALIŞTIRMA:
-- 1. Sonucu tutacak bir değişken tanımlanır (DECLARE).
DECLARE @EmployeeTotal INT;

-- 2. Prosedür çalıştırılırken de OUTPUT kelimesi MUTLAKA yazılmalıdır!
EXECUTE spGetEmployeeCountByGender 'Male', @EmployeeTotal OUTPUT;

-- 3. Değişken yazdırılır.
PRINT @EmployeeTotal;

-- DİKKAT (ÇOK ÖNEMLİ):
-- Eğer çalıştırırken OUTPUT kelimesini belirtmezsen, prosedür hata vermez ama 
-- değişkenin değeri (örnekte @EmployeeTotal) NULL olur.


/* ---------------------------------------------------------------------------------
   BÖLÜM 3: RETURN VALUES (DÖNÜŞ DEĞERLERİ)
   --------------------------------------------------------------------------------- */
-- Her çalıştırılan Stored Procedure, bir 'integer' (tamsayı) statüs değişkeni döndürür.
-- Genellikle 0 değeri 'Başarılı', 0 dışındaki değerler 'Hata' anlamına gelir.
-- Ancak basit sayma işlemleri için de (Integer olduğu sürece) kullanılabilir.

CREATE PROCEDURE spGetTotalCountOfEmployees2
AS
BEGIN
    -- Return ile doğrudan sayıyı döndürüyoruz (OUTPUT parametresine gerek yok)
    RETURN (SELECT COUNT(Id) FROM tblEmployee)
END
GO

-- RETURN DEĞERİNİ YAKALAMA VE ÇALIŞTIRMA:
DECLARE @TotalEmployees INT;
-- Çalıştırırken değeri değişkene eşitliyoruz:
EXECUTE @TotalEmployees = spGetTotalCountOfEmployees2;
SELECT @TotalEmployees AS 'Toplam Çalışan (Return İle)';


-- Görsellerdeki tabloya göre kıyaslama:
/*
| Özellik                 | Return Status Value (Return Değeri)  | Output Parameters (Output Parametresi)|
|-------------------------|--------------------------------------|---------------------------------------|
| Veri Tipi               | Sadece Integer (Tamsayı)             | Herhangi bir veri tipi (Int, Varchar) |
| Döndürülen Değer Sayısı | Sadece BİR tane değer döndürebilir   | BİRDEN FAZLA değer döndürebilir       |
| Kullanım Amacı          | Başarı/Hata durumunu bildirmek için  | İsim, sayı vb. verileri döndürmek için|
*/

-- RETURN DEĞERİNİN EKSİKLİĞİNE ÖRNEK (HATA ALINAN DURUM):
-- Eğer çalışanın "İsmini" (nvarchar) döndürmek istersek RETURN kullanamayız!

-- 1. YOL (DOĞRU): Output kullanarak ismi bulmak (BAŞARILI OLUR)
CREATE PROCEDURE spGetNameById1
    @Id INT,
    @Name NVARCHAR(20) OUTPUT
AS
BEGIN
    SELECT @Name = Name FROM tblEmployee WHERE Id = @Id
END
GO

DECLARE @EmployeeName NVARCHAR(20);
EXEC spGetNameById1 1, @EmployeeName OUT;
PRINT 'Çalışanın Adı (Output İle) = ' + @EmployeeName; -- Ekrana 'Sam' yazar.

-- 2. YOL (YANLIŞ): Return kullanarak ismi döndürmeye çalışmak (HATA VERİR)
CREATE PROCEDURE spGetNameById2
    @Id INT
AS
BEGIN
    -- HATA: Return sadece INT bekler ama biz NVARCHAR(String) veriyoruz!
    RETURN (SELECT Name FROM tblEmployee WHERE Id = @Id)
END
GO

/* EĞER YUKARIDAKİ YANLIŞ PROSEDÜRÜ ÇALIŞTIRIRSAK ŞU HATAYI ALIRIZ:
"Conversion failed when converting the nvarchar value 'Sam' to data type int."
(nvarchar 'Sam' değeri int veri tipine çevrilemedi.)

Özetle: Metin (string) dönecekse MUTLAKA Output kullanılmalıdır!
*/

USE sample
GO


-- 1. Eksik olan prosedürü oluşturuyoruz
CREATE PROCEDURE spGetNameById
    @Id INT,
    @Name NVARCHAR(20) OUTPUT
AS
BEGIN
    -- tblEmployee3 tablosundan (veya sende kayıtlı olan tblEmployee tablosundan)
    -- dışarıdan gelen @Id parametresine ait ismi bul ve @Name çıkış parametresine eşitle
    SELECT @Name = Name 
    FROM tblEmployee3 
    WHERE Id = @Id
END
GO

-- 1. DEĞİŞKEN TANIMLAMA AŞAMASI
-- Hem prosedürün genel çalışma durumunu (başarılı mı?) tutacak bir değişkene,
-- hem de veritabanından gelecek "İsim" bilgisini tutacak bir değişkene ihtiyacımız var.
DECLARE @return_value INT,       -- Return (Dönüş) değerini yakalamak için (Sadece INT alır)
        @name NVARCHAR(20)       -- Output (Çıkış) verisini yakalamak için (Metin alır)

-- 2. PROSEDÜRÜ ÇALIŞTIRMA (EXECUTE) AŞAMASI
-- Dikkat et: Normalde sadece "EXEC spGetNameById" derdik. 
-- Burada ekstra olarak dönen statü değerini @return_value değişkenine eşitliyoruz.
EXEC    @return_value = [dbo].[spGetNameById]
        @Id = 1,                 -- İçeriye gönderdiğimiz giriş (Input) parametresi. (1 Nolu ID'yi getir)
        @Name = @name OUTPUT     -- Dışarıya veri çıkaracak olan çıkış (Output) parametresi.
                                 -- (Bulduğun ismi @name değişkenime yaz ve OUTPUT kelimesini unutma!)

-- 3. SONUÇLARI GÖSTERME AŞAMASI
-- İlk SELECT: Asıl aradığımız veriyi, yani çalışanın ismini ekrana tablo olarak basar.
SELECT @Name AS N'@Name'

-- İkinci SELECT: Prosedürün statüs kodunu (Return Value) ekrana basar. 
-- Eğer prosedür sorunsuz çalıştıysa, SQL Server varsayılan olarak buraya 0 (Sıfır) değerini gönderir.
SELECT 'Return Value' = @return_value

/* =================================================================================
   STORED PROCEDURE (SAKLI YORDAM) PARAMETRE VE DÖNÜŞ TİPLERİ REHBERİ
   (Güncellenmiş Tablo: tblEmployee4 | Güncellenmiş SP: spGetEmployeeCountByGender2)
   ================================================================================= */

-- Öncelikle örneklerimizin sorunsuz çalışması için tblEmployee4 tablosunu oluşturalım:
CREATE TABLE tblEmployee4 (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10),
    DepartmentId INT
);

-- tblEmployee4 tablosuna verilerimizi ekliyoruz:
INSERT INTO tblEmployee4 VALUES 
(1, 'Sam', 'Male', 1), (2, 'Ram', 'Male', 1), (3, 'Sara', 'Female', 3),
(4, 'Todd', 'Male', 2), (5, 'John', 'Male', 3), (6, 'Sana', 'Female', 2),
(7, 'James', 'Male', 1), (8, 'Rob', 'Male', 2), (9, 'Steve', 'Male', 1),
(10, 'Pam', 'Female', 2);
GO


/* =================================================================================
   BÖLÜM 1: TEMEL PARAMETRE KURALLARI VE PROSEDÜR YÖNETİMİ
   ================================================================================= */

/* KURAL 1: Parametreler ve değişkenler isimlendirilirken her zaman başlarına 
         '@' (at) işareti konulmalıdır (Örn: @Gender, @DepartmentId).
*/

CREATE PROCEDURE spGetEmployeesByGenderAndDepartment
    @Gender NVARCHAR(20), 
    @DepartmentId INT
AS
BEGIN
    SELECT * FROM tblEmployee4 WHERE Gender = @Gender AND DepartmentId = @DepartmentId
END
GO

/* PROSEDÜR ÇALIŞTIRMA (EXECUTE) YÖNTEMLERİ: */
-- Yöntem 1 (Sıralı): 
EXECUTE spGetEmployeesByGenderAndDepartment 'Male', 1;

-- Yöntem 2 (İsimlendirilmiş):
EXECUTE spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male';
GO


/* =================================================================================
   BÖLÜM 2: OUTPUT (ÇIKIŞ) PARAMETRELERİ
   ================================================================================= */

/*
KURAL 2: Bir prosedürden dışarıya veri (isim, sayı vb.) çıkarmak istiyorsak
         parametre tanımının sonuna 'OUT' veya 'OUTPUT' yazmalıyız.
         (İstediğin gibi prosedür adı spGetEmployeeCountByGender2 olarak ayarlandı)
*/

CREATE PROCEDURE spGetEmployeeCountByGender2
    @Gender NVARCHAR(20),
    @EmployeeCount INT OUTPUT -- Dışarı aktarılacak değişken
AS
BEGIN
    SELECT @EmployeeCount = COUNT(Id) 
    FROM tblEmployee4 
    WHERE Gender = @Gender
END
GO

/* OUTPUT PROSEDÜRÜNÜ ÇALIŞTIRMA KURALLARI: */
DECLARE @EmployeeTotal INT;
-- DİKKAT: Prosedürü çağırırken OUTPUT kelimesini MUTLAKA kullanmalısın.
EXECUTE spGetEmployeeCountByGender2 'Male', @EmployeeTotal OUTPUT;
PRINT 'Erkek Çalışan Sayısı (Output ile): ' + CAST(@EmployeeTotal AS NVARCHAR(10));
GO


/* =================================================================================
   BÖLÜM 3: RETURN VALUES (DÖNÜŞ DEĞERLERİ) VE KARŞILAŞTIRMA
   ================================================================================= */

/*
KURAL 3: Her Stored Procedure çalıştığında varsayılan olarak bir Tamsayı (Integer)
         'status' (durum) değeri döndürür. Genellikle 0 başarılı, 0 dışı hatalıdır.
*/

CREATE PROCEDURE spGetTotalCount2
AS
BEGIN
    -- RETURN komutu ile doğrudan bir sayıyı dışarı fırlatıyoruz.
    RETURN (SELECT COUNT(Id) FROM tblEmployee4)
END
GO

-- RETURN DEĞERİNİ YAKALAMAK:
DECLARE @Total INT;
EXECUTE @Total = spGetTotalCount2; -- Dönüş değerini değişkene eşitliyoruz
PRINT 'Toplam Çalışan (Return ile): ' + CAST(@Total AS NVARCHAR(10));
GO


/* =================================================================================
   BÖLÜM 4: KRİTİK FARK! NEDEN HER ZAMAN RETURN KULLANAMAYIZ?
   ================================================================================= */

/*
RETURN sadece Integer döndürebilir. Bir string (NVARCHAR) değeri RETURN ile 
döndürmeye çalışırsak hata alırız.
*/

CREATE PROCEDURE spGetNameById_Hatali
    @Id INT
AS
BEGIN
    -- HATA BURADA: Name alanı NVARCHAR'dır, fakat RETURN sadece INT kabul eder!
    RETURN (SELECT Name FROM tblEmployee4 WHERE Id = @Id)
END
GO

-- Aşağıdaki kod çalıştırıldığında "Conversion failed" hatası verir:
/*
DECLARE @Isim INT;
EXEC @Isim = spGetNameById_Hatali 1;
*/


/* =================================================================================
   BÖLÜM 5: DOĞRU YÖNTEM VE İKİSİNİ BİR ARADA KULLANMAK
   ================================================================================= */

-- Metin döndüreceği için OUTPUT parametreli doğru prosedürü yazalım:
CREATE PROCEDURE spGetNameById1
    @Id INT,
    @Name NVARCHAR(20) OUTPUT
AS
BEGIN
    SELECT @Name = Name FROM tblEmployee4 WHERE Id = @Id
END
GO

-- PROFESYONEL KULLANIM (Hem Return hem Output aynı anda)
DECLARE @return_value INT,       
        @gelenIsim NVARCHAR(20)  

-- EXEC çalıştırırken hem @return_value değişkenini eşitliyoruz, 
-- hem de @gelenIsim değişkenini OUTPUT olarak veriyoruz.
EXECUTE @return_value = spGetNameById1 
        @Id = 1, 
        @Name = @gelenIsim OUTPUT

-- Sonuçları ekranda görelim:
SELECT @gelenIsim AS N'Bulunan Calisan Ismi'
SELECT @return_value AS N'Islem Durumu (Return Value)'

