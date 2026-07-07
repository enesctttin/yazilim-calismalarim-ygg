create database sample2

select ascii('BC') 

select char(65)  -- asci değeri 65 olan char karakteri getirir

declare @start int 
set @start =65

while(@start<=90)
begin

select char(@start)
set @start=@start+1

end

declare @start int 
set @start =65
while(@start<=90)
begin

print char(@start)
set @start=@start+1

end

select lower('A')


select reverse('Enes')

select len('Enes_Cetin')

select FirstName Len(Firstname) as (Total Characters) from  tblEmployee
--  Total Characters   tblEmployee tablosunda ki bir sütun  o sütündaki elemanların toplam karakterlerini toplar    



use sample2
go

CREATE TABLE tblEmployee5 (
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100)
);

INSERT INTO tblEmployee5 VALUES 
('Sam', 'Sony', 'Sam@aaa.com'),
('Ram', 'Barber', 'Ram@aaa.com'),
('Sara', 'Sanosky', 'Sara@ccc.com'),
('Todd', 'Gartner', 'Todd@bbb.com'),
('John', 'Grover', 'John@aaa.com');
GO

--  REPLICATE  Belirttiğin bir metni, belirttiğin sayı kadar yan yana yazar.
-- SELECT REPLICATE('*', 5) sorgusu sana ***** sonucunu verir.
SELECT REPLICATE('*', 5) 

SELECT 
    FirstName, 
    LastName,
    
    -- E-POSTA MASKELEME İŞLEMİ (3 PARÇADAN OLUŞUR)
    
    -- PARÇA 1: E-postanın sadece ilk 2 harfini alıyoruz.
    -- SUBSTRING(kolon, baslangic_sirasi, alinacak_karakter_sayisi)
    SUBSTRING(Email, 1, 2) 
    
    + -- Artı (+) işareti ile metinleri birleştiriyoruz
    
    -- PARÇA 2: Araya 5 adet yıldız (*) işareti ekliyoruz.
    REPLICATE('*', 5) 
    
    + 
    
    -- PARÇA 3: '@' işaretinden başlayıp e-postanın sonuna kadar olan kısmı alıyoruz.
    -- CHARINDEX('@', Email) -> '@' işaretinin kaçıncı sırada olduğunu bulur (Örn: Sam@aaa.com için 4 döner)
    -- LEN(Email) -> E-postanın toplam uzunluğunu bulur
    -- LEN - CHARINDEX + 1 -> '@' işaretinden sonra kaç karakter kaldığını hesaplar
    SUBSTRING(Email, CHARINDEX('@', Email), LEN(Email) - CHARINDEX('@', Email) + 1) 
    
    AS MaskedEmail -- Oluşan yeni sütuna bir isim veriyoruz

FROM tblEmployee5

select Firstname + space(20) + LastName as FullName
from tblEmployee5

-- Sadece sonu '@aaa.com' olan e-postaları ve bu şablonun başlama sırasını bulalım
SELECT 
    Email, 
    -- PATINDEX('%Pattern%', KolonAdi)
    -- '%' işareti: Başında ne yazarsa yazsın, sonu '@aaa.com' ile bitenleri ara demektir.
    PATINDEX('%@aaa.com', Email) AS FirstOccurence

FROM tblEmployee5

-- Ekranda sadece bu deseni içerenleri (yani PATINDEX sonucu 0'dan büyük olanları) göster
WHERE PATINDEX('%@aaa.com', Email) > 0;

select Email , Replace(Email,'.com','.net') as ConvertedEmail from tblEmployee5

-- STUFF(AnaMetin, BaslangicSirasi, SilinecekKarakterSayisi, YeniEklenecekMetin)

SELECT 
    FirstName, 
    LastName, Email,    
    -- STUFF KULLANIMI:
    -- 1. Parametre: Hangi metin üzerinde işlem yapacağız? (Email sütunu)
    -- 2. Parametre: Kaçıncı karakterden itibaren kesmeye başlayalım? (2. karakterden başla)
    -- 3. Parametre: Başladığımız noktadan itibaren kaç karakteri silelim? (3 karakter sil)
    -- 4. Parametre: Sildiğimiz o boşluğa ne yazalım? ('*****' yani 5 adet yıldız koy)
    
    STUFF(Email, 2, 3, '*****') AS StuffedEmail

FROM tblEmployee5;

select getdate() -- zaman

select isdate('pragim') -- return 0

select isdate('2026-03-01 19:35:37.040') -- return 1
 
 select Day(Getdate())-- ayın gününü döndürür

 select month(getdate())   select year (getdate())
 
-- datename iki parametre alır
 select Datename(day,(getdate()))
 select Datename(weekday,(getdate())) -- sunday 
  select Datename(month,(getdate()))


  /* =================================================================================
   TAM YAŞ HESAPLAMA (YIL, AY, GÜN OLARAK)
   ================================================================================= */

-- 1. DEĞİŞKENLERİ TANIMLAMA AŞAMASI
DECLARE @DOB datetime,      -- Dogum Tarihi (Date of Birth)
        @tmpdate datetime,  -- Hesaplama yaparken kullanacağımız "Geçici Tarih"
        @years int,         -- Bulunan Yıl
        @months int,        -- Bulunan Ay
        @days int;          -- Bulunan Gün

-- Test etmek için bir doğum tarihi atıyoruz (Örn: 10 Ağustos 1982)
-- Not: SQL server formatına göre YYYY-MM-DD vermek her zaman daha güvenlidir.
SET @DOB = '1982-08-10'; 

-- Başlangıç olarak geçici tarihimizi doğum tarihine eşitliyoruz.
SELECT @tmpdate = @DOB;


-- ==========================================
-- ADIM 1: TAM YILI HESAPLAMA
-- ==========================================
SELECT @years = DATEDIFF(YEAR, @tmpdate, GETDATE()) - 
                CASE 
                    -- EĞER henüz bu yılki doğum günümüz gelmediyse (Ay olarak gerideysek 
                    -- VEYA aynı aydaysak ama Gün olarak gerideysek), DATEDIFF'in bulduğu 
                    -- sonuçtan 1 Yıl çıkar (Çünkü o yaşı henüz tam doldurmadık).
                    WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR 
                         (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) 
                    THEN 1 
                    ELSE 0 
                END;

-- GEÇİCİ TARİHİ İLERİ SAR:
-- Doğum tarihinin üzerine bulduğumuz "Tam Yılı" ekleyerek tarihi günümüze yaklaştırıyoruz.
SELECT @tmpdate = DATEADD(YEAR, @years, @tmpdate);


-- ==========================================
-- ADIM 2: TAM AYI HESAPLAMA
-- ==========================================
SELECT @months = DATEDIFF(MONTH, @tmpdate, GETDATE()) - 
                 CASE 
                    -- EĞER bulunduğumuz ayın içinde henüz doğum günümüzün "Gününe" 
                    -- ulaşmadıysak, DATEDIFF'in bulduğu aydan 1 Ay çıkar.
                    WHEN DAY(@DOB) > DAY(GETDATE()) 
                    THEN 1 
                    ELSE 0 
                 END;

-- GEÇİCİ TARİHİ İLERİ SAR:
-- Az önce yılı eklemiştik, şimdi bulduğumuz "Tam Ayı" da geçici tarihe ekliyoruz.
SELECT @tmpdate = DATEADD(MONTH, @months, @tmpdate);


-- ==========================================
-- ADIM 3: KALAN GÜNLERİ HESAPLAMA
-- ==========================================
-- Geçici tarihimizi önce yıl, sonra ay olarak günümüze kadar getirdik. 
-- Geriye sadece aradaki artık günleri bulmak kaldı. Burada CASE (şart) yazmaya gerek yoktur.
SELECT @days = DATEDIFF(DAY, @tmpdate, GETDATE());


-- ==========================================
-- SONUCU EKRANA YAZDIRMA
-- ==========================================
SELECT @years AS Years, @months AS Months, @days AS [Days];

-- İstersen görseldeki gibi hepsini tek bir metinde birleştirebiliriz:
SELECT CAST(@years AS NVARCHAR(4)) + ' Years ' + 
       CAST(@months AS NVARCHAR(2)) + ' Months ' + 
       CAST(@days AS NVARCHAR(2)) + ' Days old' AS TamYas;





CREATE FUNCTION FonksiyonunAdi 
(
    -- 1. GİRDİLER (Parametreler): Dışarıdan hangi malzemeler gelecek?
    @Girdi1 VeriTipi,
    @Girdi2 VeriTipi
)
RETURNS CikisVeriTipi -- 2. ÇIKIŞ TİPİ: Makineden dışarı ne çıkacak? (Metin mi, Sayı mı?)
AS
BEGIN
    -- 3. İŞLEM ALANI: Malzemeleri işleyeceğin yer.
    DECLARE @Sonuc CikisVeriTipi; 

    -- Hesaplamalar, kurallar, IF'ler, CASE'ler buraya yazılır...
    -- SET @Sonuc = ...

    -- 4. TESLİMAT: Bulunan sonucu dışarı fırlat.
    RETURN @Sonuc;
END


CREATE FUNCTION fn_KdvEkle 
(
    @HamFiyat DECIMAL(10,2) -- Dışarıdan ham fiyatı alıyoruz
)
RETURNS DECIMAL(10,2) -- Geriye küsüratlı bir sayı döndüreceğimizi söylüyoruz
AS
BEGIN
    DECLARE @KdvliFiyat DECIMAL(10,2);
    
    -- İşlemi yapıyoruz (%20 KDV ekliyoruz)
    SET @KdvliFiyat = @HamFiyat + (@HamFiyat * 0.20);
    
    -- Sonucu fırlatıyoruz
    RETURN @KdvliFiyat;
END

SELECT dbo.fn_KdvEkle(100) AS KdvDahilFiyat; -- Sonuç 120 döner


Stored Procedure (SP): Bir iş yapar (Kayıt ekler, siler, günceller). Geriye bir şey döndürmek zorunda değildir. SELECT sorgusunun içinde kullanılamaz, EXEC ile tek başına çalıştırılır.

Fonksiyon (Function): Sadece hesaplama ve okuma yapar. Veritabanını değiştiremez (İçinde INSERT, UPDATE, DELETE kullanamazsın). Mutlaka geriye bir değer döndürmek zorundadır ve en güzel yanı, SELECT sorgularının tam kalbinde kullanılabilir.

-- Veri Tipi Dönüştürme (CAST ve CONVERT)   CAST(@years AS NVARCHAR) diyerek sayıları metne çevirmiştik

-- Test için tablomuzu hazırlayalım
CREATE TABLE tblEmployees_DateTest (
    Id INT,
    Name NVARCHAR(50),
    DateOfBirth DATETIME
);

INSERT INTO tblEmployees_DateTest VALUES 
(1, 'Sam', '1980-12-30 00:00:00.000'),
(2, 'Pam', '1982-09-01 12:02:36.260');


-- 1. ADIM: STANDART DÖNÜŞTÜRME (Stil olmadan)
-- Hem CAST hem de CONVERT, tarihi varsayılan bir metne çevirir (Örn: 'Dec 30 1980 12:00AM')
SELECT 
    Name,
    DateOfBirth,
    CAST(DateOfBirth AS NVARCHAR) AS CastIleDonusen,
    CONVERT(NVARCHAR, DateOfBirth) AS ConvertIleDonusen
FROM tblEmployees_DateTest;


-- 2. ADIM: CONVERT İLE TARİHİ FORMATLAMA (Görseldeki Asıl Olay)
-- Sadece CONVERT kullanarak ve sonuna bir "Stil Kodu" ekleyerek tarihi şekillendirebiliriz.
-- Stil 103: İngiltere/Türkiye standardıdır -> dd/mm/yyyy (Gün/Ay/Yıl)
SELECT 
    Name,
    DateOfBirth,
    CONVERT(NVARCHAR, DateOfBirth, 103) AS [Format_103_GunAyYil], -- Sonuç: 30/12/1980
    CONVERT(NVARCHAR, DateOfBirth, 101) AS [Format_101_AyGunYil], -- Sonuç: 12/30/1980 (ABD)
    CONVERT(NVARCHAR, DateOfBirth, 104) AS [Format_104_Noktali]   -- Sonuç: 30.12.1980 (Almanya)
FROM tblEmployees_DateTest;

/* GÖRSELDEKİ ÇOK ÖNEMLİ NOT (DİKKAT!):
   Eğer veriyi DATE veri tipine CONVERT ediyorsan, sonuna ekleyeceğin stil (style) 
   parametresi (örn: 101, 103 vb.) SQL tarafından GÖRMEZDEN GELİNİR (Yok sayılır).
   Çünkü DATE tipinin veritabanındaki kayıt formatı sabittir (YYYY-MM-DD).
   Eğer formatı değiştirmek istiyorsan (Örn: DD/MM/YYYY), veriyi DATE'e değil 
   mutlaka NVARCHAR/VARCHAR tipine dönüştürmelisin!
*/


CREATE TABLE tblRegistrations (
    Id INT,
    Name NVARCHAR(50),
    Email NVARCHAR(50),
    RegisteredDate DATETIME
);

INSERT INTO tblRegistrations VALUES 
(1, 'John', 'j@j.com', '2012-08-24 11:04:30.230'),
(2, 'Sam', 's@s.com', '2012-08-25 14:04:29.780'),
(3, 'Todd', 't@t.com', '2012-08-25 15:04:29.780'),
(4, 'Mary', 'm@m.com', '2012-08-24 15:04:30.730'),
(5, 'Sunil', 'sunil@s.com','2012-08-24 15:05:30.330'),
(6, 'Mike', 'mike@m.com', '2012-08-26 15:05:30.330');


/* ---------------------------------------------------------------------------------
   HATALI YÖNTEM (Sadece Tarihe Göre Gruplamak)
   --------------------------------------------------------------------------------- */
-- Eğer saatleri atmazsak, her saniye eşsiz (unique) olduğu için kimse gruplanamaz.
-- Sonuç olarak herkesin karşısında 1 yazar.

SELECT 
    RegisteredDate AS RegistrationDate, 
    COUNT(Id) AS TotalRegistrations
FROM tblRegistrations
GROUP BY RegisteredDate; -- HATA BURADA: Saatleri de gruplamaya dahil ediyoruz.


/* ---------------------------------------------------------------------------------
   DOĞRU YÖNTEM (CAST ile Saatleri Silip Gruplamak)
   --------------------------------------------------------------------------------- */
-- CAST kullanarak RegisteredDate içindeki saati siliyoruz ve DATE (Sadece gün) tipine çeviriyoruz.
-- DİKKAT: SELECT içinde CAST yapıyorsak, GROUP BY içinde de aynı CAST işlemini uygulamak ZORUNDAYIZ!

SELECT 
    CAST(RegisteredDate AS DATE) AS RegistrationDate, 
    COUNT(Id) AS TotalRegistrations
FROM tblRegistrations
GROUP BY CAST(RegisteredDate AS DATE); -- Sadece "Gün" kısmını baz alarak grupla diyoruz.

--  skaler func  geriye tek değer döner

-- 1. FONKSİYONU OLUŞTURMA AŞAMASI
CREATE FUNCTION fn_KdvHesapla 
(
    -- İçeri girecek malzeme (Parametre)
    @HamFiyat DECIMAL(10,2) 
)
RETURNS DECIMAL(10,2) -- Makineden dışarı ÇIKACAK sonucun veri tipini söylüyoruz (Zorunlu)
AS
BEGIN
    -- İçerideki işlemleri yapacağımız alan
    DECLARE @KdvliFiyat DECIMAL(10,2); -- Sonucu tutacağımız geçici değişken
    
    -- Matematiği yapıyoruz (Ham fiyata %20 ekliyoruz)
    SET @KdvliFiyat = @HamFiyat + (@HamFiyat * 0.20);
    
    -- VE FİNAL: Bulduğumuz o TEK DEĞERİ makineden dışarı fırlatıyoruz
    RETURN @KdvliFiyat; 
END
GO

SELECT dbo.fn_KdvHesapla(100) AS SatisFiyati; 
-- Sonuç olarak sana tek bir hücrede "120.00" döndürür.

SELECT 
    UrunAdi, 
    Fiyat AS HamFiyat, 
    dbo.fn_KdvHesapla(Fiyat) AS KdvDahilFiyat -- Fonksiyonu buraya yerleştiriyoruz
FROM tblUrunler;




----------------------------------------------------------------------
Geçici Tablolar diyoruz.

Bu tablolar senin kendi veritabanında değil, SQL Server'ın arka plandaki tempdb isimli sistem veritabanında tutulur ve işleri bitince (sen silmesen bile) otomatik olarak yok olurlar!

Yerel Geçici Tablolar (Local Temporary Tables)
Sadece tabloyu oluşturan oturum (o anki sorgu penceresi) tarafından görülebilirler. Başka bir sekme açıp bu tabloya SELECT atmaya çalışırsan SQL hata verir. Tablo adının başına tek bir # (Diyez/Hash) işareti konularak oluşturulurlar.


Küresel Geçici Tablolar (Global Temporary Tables)
Oluşturulduktan sonra SQL Server'a bağlı olan herkes (tüm sorgu pencereleri) tarafından görülebilir ve kullanılabilirler. Tablo adının başına iki adet ## işareti konularak oluşturulurlar.




/* =================================================================================
   TEMPORARY TABLES (GEÇİCİ TABLOLAR) KULLANIM REHBERİ
   ================================================================================= */

/* ---------------------------------------------------------------------------------
   YÖNTEM 1: KLASİK "CREATE TABLE" İLE YEREL GEÇİCİ TABLO OLUŞTURMA
   --------------------------------------------------------------------------------- */
-- Başındaki '#' işareti bunun sadece bu sayfaya özel geçici bir tablo olduğunu söyler.
CREATE TABLE #LocalTempPersonel (
    Id INT,
    Name NVARCHAR(50)
);

-- Tıpkı gerçek bir tablo gibi içine veri ekleyebiliriz:
INSERT INTO #LocalTempPersonel VALUES (1, 'Ahmet'), (2, 'Ayşe');

-- Tıpkı gerçek bir tablo gibi verileri okuyabiliriz:
SELECT * FROM #LocalTempPersonel;

-- TEST: SQL Server'da yeni bir "New Query" sekmesi açıp 
-- SELECT * FROM #LocalTempPersonel yazarsan "Invalid object name" hatası alırsın. 
-- Çünkü bu tablo sadece onu oluşturan pencereye özeldir!


/* ---------------------------------------------------------------------------------
   YÖNTEM 2: "SELECT INTO" İLE HIZLI GEÇİCİ TABLO OLUŞTURMA (Gerçek Hayat Kullanımı)
   --------------------------------------------------------------------------------- */
-- Gerçek projelerde genellikle CREATE TABLE ile uzun uzun tablo yapısını yazmayız.
-- "Şu tablodaki şu verileri al, benim için otomatik bir geçici tabloya doldur" deriz.
-- (Bir önceki adımda oluşturduğumuz tblEmployees7 tablosunu baz alıyoruz)

SELECT Id, Name 
INTO #HizliTempTablom -- Bu komut #HizliTempTablom adında yeni bir geçici tablo yaratır ve içini doldurur.
FROM tblEmployees7
WHERE Id = 1;

SELECT * FROM #HizliTempTablom;


/* ---------------------------------------------------------------------------------
   GLOBAL GEÇİCİ TABLO OLUŞTURMA (Çift ## işareti ile)
   --------------------------------------------------------------------------------- */
CREATE TABLE ##GlobalTempPersonel (
    Id INT,
    Name NVARCHAR(50)
);

INSERT INTO ##GlobalTempPersonel VALUES (99, 'Global Patron');

SELECT * FROM ##GlobalTempPersonel;

-- TEST: Şimdi "New Query" ile yepyeni bir sekme aç.
-- SELECT * FROM ##GlobalTempPersonel sorgusunu çalıştır. 
-- Gördüğün gibi, tabloya diğer pencerelerden de rahatça ulaşılabiliyor!



--Bir View, kaydedilmiş bir SQL sorgusundan başka bir şey değildir. Aynı zamanda sanal bir tablo olarak da düşünülebilir."

/* =================================================================================
   VIEWS (GÖRÜNÜMLER / SANAL TABLOLAR) KULLANIMI
   ================================================================================= */

-- 1. DEPARTMAN TABLOSUNU OLUŞTURALIM VE DOLDURALIM
CREATE TABLE tblDepartment (
    DeptId INT PRIMARY KEY,
    DeptName NVARCHAR(50)
);

INSERT INTO tblDepartment VALUES 
(1, 'IT'), (2, 'Payroll'), (3, 'HR'), (4, 'Admin');


-- 2. PERSONEL TABLOSUNU OLUŞTURALIM VE DOLDURALIM
CREATE TABLE tblEmployee_ViewTest (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Salary INT,
    Gender NVARCHAR(10),
    DepartmentId INT
);

INSERT INTO tblEmployee_ViewTest VALUES 
(1, 'John', 5000, 'Male', 3),
(2, 'Mike', 3400, 'Male', 2),
(3, 'Pam', 6000, 'Female', 1),
(4, 'Todd', 4800, 'Male', 4),
(5, 'Sara', 3200, 'Female', 1),
(6, 'Ben', 4800, 'Male', 3);


/* ---------------------------------------------------------------------------------
   VİEW OLUŞTURMA AŞAMASI (Sihrin Gerçekleştiği Yer)
   --------------------------------------------------------------------------------- */
-- DİKKAT: Normalde bir CREATE VIEW komutundan önce mutlaka "GO" yazmalısın.
GO

-- CREATE VIEW GörünümAdi AS [Sorgun] formatıyla yazılır.
CREATE VIEW vWEmployeesByDepartment
AS
SELECT 
    Id, Name, Salary, Gender, DeptName
FROM tblEmployee_ViewTest
JOIN tblDepartment
ON tblEmployee_ViewTest.DepartmentId = tblDepartment.DeptId;
GO


/* ---------------------------------------------------------------------------------
   VİEW NASIL KULLANILIR?
   --------------------------------------------------------------------------------- */
-- Artık arkadaki o uzun JOIN sorgusunu düşünmene hiç gerek yok!
-- Yeni oluşturduğumuz bu sanal tabloyu, tıpkı normal bir tabloymuş gibi doğrudan SELECT ile çağırabilirsin:

SELECT * FROM vWEmployeesByDepartment;