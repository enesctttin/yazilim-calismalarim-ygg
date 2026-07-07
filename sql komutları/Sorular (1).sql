-----------------VERILER UZERINDE SELECT SORGULARI--------------------

SQL boşlukları da bir karakter sayar

use Northwind
Go
-- 1-> Kargolar(Shippers) tablosunda yer alan KargoID (ShipperID), Firma Adi (CompanyName) ve Telefon Numarasi (Phone) bilgilerini raporlayiniz.
select ShipperID , CompanyName , Phone from Shippers
-- 2-> Calisanlarimin (Employees) ID'lerini (EmployeeID), adlarini (FirstName) ve soyadlarini (LastName) raporlayiniz. Ancak adlar ve soyadlar tek bir kolonda toplansin ve kolon adi 'AdSoyad' olsun.
select   FirstName + '   -  ' + LastName as AdSoyad ,  EmployeeID   from  Employees
-- 3-> Calisanlarimin Ad ve Soyadlariyla birlikte yaslarini raporlayiniz.
-- Syntax: DATEDIFF(ZamanDilimi, EskiTarih, YeniTarih)
select FirstName , LastName , datediff(Year , BirthDate , getdate()) from Employees
-- 4-> Urunlerimin(Products) ID'lerini (ProductID), adlarini (ProductName), stok miktarlarini (UnitsInStock), fiyatlarini (UnitPrice) ve fiyatlara %18 KDV eklenmis hallerini raporlayiniz.
select  ProductID ,ProductName ,UnitsInStock , UnitPrice , UnitPrice*1.18  as kdv  from Products
-----------------VERILERIN FILTRELENDIRILMESI (WHERE)--------------------
-- 5-> Urun ucreti 30'dan yuksek olan urunleri raporlayiniz.
select  * from  Products where UnitPrice >30;
-- 6-> Londra'da yasayan(City) personellerimi listeleyiniz.
select * from Employees where City ='London'
-- 7-> CategoryID'si 5 olmayan urunlerimin adlarini ve CategoryID'lerini gosteriniz.
select ProductName, CategoryID from Products where CategoryID <> 5;
-- 8-> '01.01.1993' tarihinden sonra ise girmis personellerimin Adini, soyadini ve ise giris tarihlerini(HireDate) raporlayiniz.
select FirstName , LastName ,HireDate from Employees where HireDate > '01-01-1993';
-- 9-> 'March' ayinda alinmis olan siparislerin OrderID, OrderDate kolonundaki degerleri raporlayiniz. (Orders)
select  OrderID , OrderDate  from Orders where DATENAME(MONTH, OrderDate) ='March'
-----------------MANTIKSAL OPERATORLER (AND - OR)--------------------
-- 10-> Urunlerim arasinda stok miktari 20 - 50 olan urunlerimin listesini raporlayiniz...
select * from Products where UnitsInStock >=20 and UnitsInStock <=50;
-- 11-> Yasi 50'den buyuk, Ingiltere'de oturmayan calisanlarimin adlarini ve yaslarini raporlayiniz. Ancak isimler su formatta olmalidir: A. Fuller
-- Syntax: SUBSTRING(SutunAdi, BaslangicSirasi, KacKarakterAlinacak)
select SUBSTRING(FirstName, 1, 1) + '. ' + LastName AS IsimFormatli, 
    DATEDIFF(YEAR, BirthDate, GETDATE()) AS Yas from Employees where Country<> 'UK'and DATEDIFF(YEAR, BirthDate, GETDATE()) >50 ;
-- 12-> 1997(dahil) yilindan sonra (OrderDate) alinmis, kargo ucreti (Freight) 20'den buyuk ve Fransa'ya gonderilmemies(ShipCountry) siparislerin(Orders) OrderID, siparis tarihlerini, teslim tarihlerini(ShippedDate) ve kargo ucretlerini raporlayiniz..
select OrderID, OrderDate, ShippedDate,Freight from Orders where (OrderDate) >='1997 '  and  Freight >20 and ShipCountry<>'France' 
-----------------NULL IFADELERIN KONTROLU
-- 13-> Henuz musteriye ulasmamis siparisleri raporlayiniz...
select * from orders where ShippedDate is null;
-- 14-> Musteriye ulasmis olan siparisleri raporlayiniz...
select * from orders where ShippedDate is not null;
-- 15-> Kimseye rapor(Reportsto) vermeyen personelimin adi, soyadi ve unvani(Title) nedir?
select LastName, FirstName , Title from Employees where ReportsTo is null
-- 16-> 'DUMON' ya da 'ALFKI' CustomerID'lerine sahip olan musteriler tarafindan alinmis, 1 nolu personelin onayladigi (EmployeeID), 3 nolu kargo firmasi tarafindan tasinmis (ShipVia) ve ShipRegion'ı null olan siparisleri gosteriniz..  
select * from orders where CustomerID in ('DUMON','AlFKI') and EmployeeID=1 and ShipVia=3 and ShipRegion is null;
-----------------SIRALAMA ISLEMLERI (ORDER BY)
-- Syntax: ORDER BY SutunAdi ASC (ASC = Artan/Ascending, varsayılandır) veya ORDER BY SutunAdi DESC (DESC = Azalan/Descending - Tersten sıralama).
-- 17-> Musterilerin ID'lerini (CustomerID), Sirket adlarini (CompanyName), ulkelerini (Country) listeleyiniz. Ancak sirket Fransiz sirketi olacak ve CustomerID'lerine gore tersten siralanacak...
select CustomerID, CompanyName ,Country from Customers where Country='France' order by CustomerID DESC
-- 18-> Urlerimizin adlarini(ProductName), ucretlerini(UnitPrice), stok miktarlarini(UnitsInStock) gosteriniz. stok miktari 50'den buyuk olacak ve urun ucretine gore ucuzdan pahaliya bir siralama gerceklestirilecek...
select ProductName , UnitPrice ,UnitsInStock from Products where UnitsInStock>50 order by UnitPrice asc
-----------------KAYITLARDA BELİRLİ BİR SAYIDA VERİYİ ALMA
-- Syntax: SELECT TOP N Sutunlar FROM Tablo ORDER BY Sutun
-- 19-> En ucuz 10 urunu gosteriniz...
select top 10 UnitPrice from Products order by UnitPrice asc
-- 20-> En son teslim edilen 5 siparisn detaylarini gosteriniz..
select top 5 * from Orders order by ShippedDate desc
-- 21-> En fazla kargo ucreti odenene siparisin ID'sini ve odenen miktari gosteriniz...
select top 1 OrderID , Freight from Orders order by Freight desc
-----------------BETWEEN - AND KALIBI-----------------
-- 22-> Bas harfi C olan, stoklarda mevcut, 10 - 250 dolar arasi ucreti olan urunleri fiyatlarina gore listeleyiniz...
-- Syntax: WHERE SutunAdi LIKE 'Sablon' 'A%' : A ile başlayanlar (Sonrası ne olursa olsun).  '%A' : A ile bitenler (Öncesi ne olursa olsun). _ (Alt Tire): Sadece TEK BİR karakteri temsil eder (Karakter atlama/boşluk doldurma).
select * from Products where ProductName like 'C%' and  UnitsInStock>0 and UnitPrice between 10 and 250   order by UnitPrice desc  

-- 23-> 'Wednesday' gunu alinan, kargo ucreti 20-75 arasinda olan, teslim tarihi null olmayan siparislerin bilgilerini raporlayiniz ve OrderID'sine gore buyukten kucuge siralayiniz...
select * from  Orders  where DATENAME(WEEKDAY , OrderDate) = 'Wednesday'  and Freight between 20 and 75  and ShippedDate is not null  order by OrderID asc
-----------------ARAMA ISLEMLERI (LIKE)-----------------
-- 24-> CompanyName'leri A harfi ile baslayan musterileri listeleyelim...
select * from Customers where CompanyName like 'A%'
-- 25-> CompanyName'leri A harfi ile biten musterileri listeleyelim...
select * from Customers where CompanyName like '%A'
-- 26-> CompanyName'leri arasinda ltd gecen musterileri listeyelim...
select * from Customers where CompanyName like '%ltd%'
-- 27-> CustomerID'lerinden ilk iki harfi bilinmeyen ama son uc harfi "mon" olan musteriyi gosterelim...
select * from Customers where CustomerID like '__mon'
-- 28-> CustomerID'lerinden ilk harfi A ya da S olan musterileri listeleyiniz...
select * from Customers where CustomerID like '[AS]%'
-- 29-> CustomerID'lerinden ilk harfi A olmayan musterileri listeleyiniz...
select * from customers where CustomerID like '[^A]%'
-- 30-> Ulkesi Ingiltere olmayan, adi A ile baslayip soyadi R ile biten, dogum tarihi 1985'ten once olan calisanim kimdir?
select * from Employees  where Country !='UK'  and BirthDate <'1985-01-01' and FirstName like 'A%' and LastName like '%R'
-- 31-> Japoncayi akici konusan personel kimdir?
select * from Employees where Notes like '%Japanese%'
-----------------AGGREGATE FUNCTIONS-----------------
COUNT(*) : Tablodaki koşula uyan tüm satır sayısını verir.
COUNT(SutunAdi) : Sadece o sütunun içi DOLU (Null olmayan) olanları sayar.
COUNT(DISTINCT SutunAdi) : Tekrar edenleri saymaz, benzersiz/çeşit sayısını verir. (Örn: Kaç FARKLI ülkeden müşterim var?)
-- 32-> Stokta bulunan kac tane urunumuz vardir?
select * from orders
select count(UnitsInStock) from Products
SELECT COUNT(*) AS UrunCesidiSayisi FROM Products WHERE UnitsInStock > 0;
-- 33-> 1996 yilindan sonra alinmis kac adet siparis vardir?
select  count (*) as after1996 from orders where year(OrderDate)> '1996'
-- 34-> Kac ulkeden musterimiz bulunmaktadir?
select count(distinct Country) from Customers
-- 35-> Her bir urunden bir adet alsam ne kadar oderim?
select sum(UnitPrice ) from Products
-- 36-> Depoda ucret bazli olarak toplam ne kadarlik urunum kalmistir?
select sum(UnitPrice*UnitsInStock) as butce  from Products
-- 37-> 1997 yilinda alinmis olan siparislerim icin toplam ne kadarlik kargo odemesi yaptik?
select sum(Freight) from orders where year(orderdate)='1997'
-- 38-> Bu zaman dek odenmis ortalama kargo ucretimiz nedir? 
select avg(Freight) from orders 
-- 39-> Urunlerimin ortalama satis fiyati nedir?
select avg(UnitPrice) as ortalamafiyat from Products
-- 40-> En yuksek kargo miktari nedir?
select max(Freight)  from orders
-- 41-> MusteriID'leri A-K arasinda olanlarin vermis olduklari, siparis tarihi 01.01.1997 ile 06.06.1997 arasinda olan siparislere en az ne kadar karago ucreti odenmistir?
select min(Freight) from orders where CustomerID like '[A-K]%' and OrderDate between '1997-01-04' and '1997-06-06'
-----------------IN YAPISI-----------------
WHERE Country = 'UK' OR Country = 'USA' OR Country = 'France' yazmak yerine IN kullanırız.Syntax: WHERE SutunAdi IN (Deger1, Deger2, Deger3)
-- 42-> 2,4,5,7 nolu calisanlarin almis olduklari siparisleri gosteriniz..
select * from Orders  where EmployeeID in (2,4 , 5, 7 )
-- 43-> 1 ya da 2 nolu kargo firmasi ile tasinmis, 1996 yilinda bir Persembe gunu alinmis siparisler icin odenen azami kargo bedeli nedir?
select max(Freight) from Orders where year(OrderDate)=1996 and datename(WEEKDAY,orderdate)='Thursday' and ShipVia in (1 , 2)
-- 44-> 'CACTU', 'DUMON' ya da 'PERIC' ID'li musteriler tarafindan istenmis, 2 nolu kargo firmasiyla tasinmamis, kargo ucreti 20 - 200 dolar arasi olan siparislere toplam ne kadarlik kargo odemesi yapilmistir?
select sum(Freight) from orders where CustomerID in ('CACTU','DUMON','PERIC') and ShipVia <>2 and Freight between 20 and 200
-----------------WHEN - CASE YAPISI-----------------
SELECT Sutun1, Sutun2,
    CASE
        WHEN Sart1 THEN 'Sonuc1'
        WHEN Sart2 THEN 'Sonuc2'
        ELSE 'Hicbirine Uymuyorsa Yazilacak Varsayilan Sonuc'
    END AS YeniSutunIsmi
FROM TabloAdi;
-- 45-> Calisanlar tablosunda 'Mr.' gorulen yere 'Bay'; 'Ms.' ve 'Mrs.' gorunen yere 'Bayan'; onbilgi yoksa ya da harici herhangi bir durumsa 'On Bilgi Yok' yazdirilarak raporlansin...
select FirstName,LastName ,TitleOfCourtesy,
case 
    when TitleOfCourtesy='Mr.' then 'Bay'
    when TitleOfCourtesy in ('Ms.' , 'Mrs.') then 'Bayan'
    else 'On bilgi yok'
    end as unvan
    from Employees ;
-- 46-> Urun adlarini, ucretlerini ve stok miktarlarini raporlayiniz. Eger stok miktari 50'den kucukse 'Kritik Durum', 50 - 75 arasi ise 'Normal Stok' 75'te fazla ise 'Stok Fazlası' uyarisi veren ekstra bir kolonu rapora ekleyiniz... Raporunuz stok miktarlarina gore kucukten buyuge siralansin...
select ProductName, UnitPrice, UnitsInStock,
case
when UnitsInStock <50 then 'kritik durum'
when UnitsInStock between 50 and 75 then 'normal durum' 
when UnitsInStock >75  then 'fazla durum'
end as stokUyarsi 
from products order by  UnitsInStock
-----------------GROUP BY YAPISI-----------------
Aynı değerlere sahip satırları "sepetlere" ayırıp, o sepetlerin özetini (toplamını, ortalamasını, sayısını) almak için kullanılır. "Hangi ülkeden kaç müşterim var?", "Hangi kategoride kaç ürünüm var?" gibi soruların tek cevabıdır.
Altın Kural: SELECT ile çağırdığın ama SUM(), COUNT() gibi bir toplama fonksiyonunun içine ALMADIĞIN her normal sütunu, GROUP BY komutunun yanına yazmak ZORUNDASIN
SELECT GruplanacakSutun, COUNT(*) AS Adet
FROM TabloAdi
GROUP BY GruplanacakSutun;

-- 47-> Ulkelere gore calisan sayimiz nedir?
select  country , count(*) as adet from Employees group by Country
-- 48-> Hangi kategoride kac tane urunum var raporlayiniz?
SELECT CategoryID, COUNT(*) AS UrunSayisi 
FROM Products 
GROUP BY CategoryID;
-- 49-> Calisanlara gore almis olduklari siparis sayilarini raporlayiniz...
select  EmployeeID,count(*)  from Orders group by EmployeeID
-- 50-> Ulkelere gore siparis sayilarini raporlayiniz ve en cok siparis veren 3 ulkeyi listeleyiniz...
select top 3 ShipCountry,count(*) from Orders group by ShipCountry
-----------------JOIN-----------------
JOIN yaparken ON kısmında birbirine eşitlediğimiz o sütunlar, tablolardaki Primary Key (Birincil Anahtar) ve Foreign Key (Yabancı Anahtar) dediğimiz sütunlardır.
-- INNER JOIN Categories c ON p.CategoryID = c.CategoryID dediğinde aslında SQL Server'a tam olarak şu emri veriyorsun:
--Ürünler tablosundaki Yabancı Anahtarı (p.CategoryID) al, git Kategoriler tablosundaki o asıl Birincil Anahtarı (c.CategoryID) bul ve bu ikisinin eşleştiği satırları tıpkı bir yapboz parçası gibi birbirine kilitleyip bana getir!"
--Ana Tablo (Örn: Categories): ID'yi üretir ve benzersiz olarak saklar. (Primary Key)
--Alt Tablo (Örn: Products): O ID'yi kendi içinde tutarak Ana Tabloya referans verir. (Foreign Key)
--JOIN ... ON ... : Bu iki anahtarı birbirine takıp verileri birleştirir.

Veritabanlarındaki tablolar birbirlerine bu anahtarlar sayesinde "ilişkisel" (Relational) olarak bağlanırlar .
(Örn: Ürünler bir tabloda, Kategoriler başka tabloda). İki tablodaki verileri ortak bir anahtar (ID) üzerinden yan yana getirmek için JOIN kullanılır.
INNER JOIN: Sadece iki tabloda da karşılığı/eşleşmesi olan ortak verileri getirir.
Alias (Kısaltma) Kuralı: Tablo isimleri uzun olduğu için kod yazarken onlara p (Products için) ve c (Categories için) gibi takma adlar (alias) veririz.

SELECT T1.Sutun, T2.Sutun 
FROM Tablo1 T1
INNER JOIN Tablo2 T2 ON T1.OrtakID = T2.OrtakID;

-- 51-> Urunlerimizin adlarini ve kategorileri adlarini bir raporda gosteriniz..
select p.ProductName , c.CategoryName 
from Products p
inner join Categories c on p.CategoryID=c.CategoryID;
-- 52-> Urunleri ve alindiklari toptancilarin sirket adlarini raporlayiniz..
select p.ProductName , s.CompanyName
from Products p
inner join Suppliers s on p.SupplierID=s.SupplierID
-- 53-> Beverages kategorisine ait, stoklarda bulunan urunleri raporlayiniz.
select c.CategoryName , p.ProductName
from products p
inner join Categories c on p.CategoryID= c.CategoryID
where c.CategoryName='Beverages' and p.UnitsInStock>0
----------------------------------------------------------------------------------------
SELECT t1.Sutun, t2.Sutun, t3.Sutun
FROM Tablo1 t1
INNER JOIN Tablo2 t2 ON t1.OrtakID = t2.OrtakID
INNER JOIN Tablo3 t3 ON t2.BaskaOrtakID = t3.BaskaOrtakID;
---------------------------------------------------------
LEFT JOIN: FROM kısmında yazdığın (soldaki) tablonun TAMAMINI getirir. Sağdakiyle eşleşenleri yanına yazar, eşleşmeyenlerin yanına NULL basar.

RIGHT JOIN: JOIN kısmında yazdığın (sağdaki) tablonun TAMAMINI getirir.

FULL OUTER JOIN: Her iki tablonun da tamamını getirir, ne var ne yok dökülür.
SELECT c.CompanyName, o.OrderID 
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 54-> Federal Shipping ile tasinmis ve Nancy'nin almis oldugu siparisleri gosteriniz (OrderID, FirstName, lastName, OrderDate, CompanyName)
select  o.OrderID, e.FirstName , e.LastName , o.OrderDate, c.CompanyName 
from Orders o
inner join Employees e on o.EmployeeID=e.EmployeeID
inner join Shippers s on o.ShipVia=s.ShipperID
inner join Customers c on o.CustomerID=c.CustomerID
where s.CompanyName='Federal Shipping' and e.FirstName='Nancy'
-- 55-> CompanyName'leri arasinda a gecen musterilerin vermis oldugu, Nancy; Andrew ya da Janet tarafindan alinmis, Speedy Express ile tasinmamis siparislere toplam ne kadarlik kargo odemesi yapilmistir?
select sum(o.Freight) as toplma3kargo
from Orders o
inner join Customers c on  o.CustomerID=c.CustomerID
inner join Shippers s on o.ShipVia=s.ShipperID
inner join Employees e on o.EmployeeID=e.EmployeeID
where   c.CompanyName like '%a%'
and e.FirstName in ('Nancy', 'Andrew','Janet')
and s.CompanyName <> 'Speedy Express'
-- 56-> En cok urun aldigimiz 3 toptanciyi, almis oldugumuz urun miktarlarina gore raporlayiniz...
select top 3  count(p.ProductID) as uruncesidi, s.CompanyName
from Suppliers s
inner join Products p  on s.SupplierID= p.SupplierID
group by s.CompanyName order by count(p.ProductID) desc;
-- 57-> Her bir urunden toplam ne kadarlik satis yapilmistir ve o urunler hangi kategoriye aittir?
select  p.ProductName , c.CategoryName, Sum(od.Quantity*od.UnitPrice*(1-od.Discount)) as Toplamsatisgeliri
from Products p 
inner join Categories c on p.CategoryID=c.CategoryID
inner join  [Order Details] od on p.ProductID=od.ProductID
group by p.ProductName , c.CategoryName;
-- 58-> Urunleri ve bagli bulunduklari kategorileri listeleyiniz. Ancak urunu olmayan kategoriler de sorgu sonucuna dahil edilsin...
select p.ProductName , c.CategoryName
from Categories c
left join Products p on c.CategoryID=p.CategoryID
-- 59-> Urunleri ve bagli bulunduklari kategorileri listeleyiniz. Ancak kategorisi olmayan urunler de sorgu sonucuna dahil edilsin...
select p.ProductName , c.CategoryName
from Products p
left join   Categories c on p.CategoryID=c.CategoryID

-- 60-> Urunleri ve bagli bulunduklari kategorileri listeleyiniz. Ancak kategorisi olmayan urunler ve urunleri olmayan kategoriler de sorgu sonucuna dahil edilsin...
select p.ProductName , c.CategoryName
from Products p
full outer join Categories c on p.CategoryID= c.CategoryID

-----------------HAVING YAPISI-----------------
SELECT Sutun1, SUM(Sutun2) 
FROM Tablo 
GROUP BY Sutun1 
HAVING SUM(Sutun2) > 100;
-- 61-> Toplam siparis miktari 1200'un uzerinde olan urunlerin adlarini ve siparis miktarlarini gosteriniz...
select p.ProductName ,sum(od.Quantity) 
from Products p 
inner join [Order Details] od on p.ProductID=od.ProductID
group by p.ProductName
having sum(od.Quantity)>1200;
-- 62-> 250'den fazla siparis tasimis olan kargo firmalarinin adlarini, telefon numaralarini ve siparis miktarlarini raporlayiniz...
select s.CompanyName,s.Phone,count(o.OrderID) as siparistotal
from orders o
inner join Shippers s  on s.ShipperID=o.ShipVia
group by  s.CompanyName ,s.Phone
having count(o.OrderID)>250;
-----------------SUBQUERY YAPISI-----------------
Ne için kullanılır? Bir sorgunun sonucunu, başka bir sorgunun parametresi (WHERE şartı vb.) olarak kullanmak için yazılır. Dıştaki sorgu çalışmadan önce, parantez içindeki alt sorgu çalışır ve bir sonuç (veya liste) üretir.
Örnek (Ortalamanın üzerinde fiyata sahip ürünler): Önce ortalamayı bulmamız lazım, sonra o ortalamadan büyük olanları getirmeliyiz.
SELECT ProductName, UnitPrice 
FROM Products 
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);
-- 63-> Ortalama ucretin uzerinde yer alan urunleri gosteriniz..
select * from Products  
where   UnitPrice>(select avg(UnitPrice) from Products);
-- 64-> Nancy'nin almis oldugu siparislerin ID'lerini subquery ile raporlayiniz...
select * from Orders
where EmployeeID= (select  EmployeeID from Employees where FirstName='Nancy')
-- 65-> Nancy; Andrew ya da Janet tarafindan alinmis ve Speedy Express ile tasinmamis siparisleri listeleyiniz...
SELECT * FROM Orders
WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE FirstName IN ('Nancy', 'Andrew', 'Janet'))
AND ShipVia <> (SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express');
-----------------INSERT ISLEMLERI-----------------
INSERT INTO TabloAdi (Sutun1, Sutun2) 
VALUES ('Metin Deger', 150);

-- 66-> Kargolar tablosuna yeni bir kargo kaydi ekleyiniz...
select * from Shippers -- shipperID otamatik olarak artıyor
insert into Shippers (CompanyName,Phone )
values ('aras kargo','(212) 212-2121')
-- 67-> Kendinizi bir calisan olarak Employees tablosuna ekleyiniz...
select * from Employees
INSERT INTO Employees (LastName, FirstName, Title) VALUES ('Cetin', 'Enes', 'Ao');
select * from Employees where LastName='Cetin'
-----------------UPDATE YAPISI-----------------
UPDATE TabloAdi 
SET Sutun1 = 'Yeni Deger' 
WHERE ID = 5;
-- 68-> 4 nolu kargo firmasinin telefon numarasını (212) 888-4477 olarak guncelelyiniz.
select * from Shippers
update Shippers
set phone ='(212) 888-4477'
where ShipperID=4
-----------------DELETE YAPISI-----------------
DELETE FROM TabloAdi WHERE Kosul;
-- 70-> Kargolar tablosundaki KargoID'si 3ten buyuk butun kayitlar silinsin...
delete from Shippers where ShipperID >3
-----------------VIEW OLUŞTURMA-----------------
--Ne için kullanılır? Uzun ve karmaşık bir sorguyu (örneğin 3 tablolu bir JOIN'i) veritabanına bir "Sanal Tablo" olarak kaydetmek için kullanılır.
--Böylece her seferinde o uzun kodu yazmak yerine sadece SELECT * FROM BenimSanalTablom dersin.
--Altın Kural: CREATE VIEW komutu çalıştırılmadan önce kendinden önceki kodlardan ayrılmak için mutlaka GO komutu yazılmalıdır.
GO
CREATE VIEW ViewAdi AS
SELECT Sutun1, Sutun2 FROM Tablolar ... (Buraya normal SELECT sorgunu yazıyorsun)
-- 71-> Beverages kategorisine ait, Amerikali toptancilar tarafindan alinmis, stoklarimda mevcut urunlerin adlarini, ucretlerini, KDV'li ucretlerini gosteren bir view tasarlayiniz
GO
CREATE VIEW ViewAdi AS
select p.ProductName, p.UnitPrice, (p.UnitPrice * 1.18) AS KDVliFiyat
from Products p
inner join Categories c on c.CategoryID =p.CategoryID
inner join Suppliers s on s.SupplierID=p.SupplierID
where c.CategoryName ='Beverages' and s.Country='USA' and p.UnitsInStock>0

select * from ViewAdi

-----------------STORED PROCEDURE-----------------
Syntax: (Değişkenlerin/Parametrelerin başına daima @ işareti konur).
GO
CREATE PROCEDURE sp_ProsedurAdi 
    @DisaridanGelenDeger INT,
    @DigerDeger NVARCHAR(50)
AS
BEGIN
    -- Buraya işlemlerini yazarsın (Örn: Update, Select vb.)
    SELECT * FROM Tablo WHERE ID = @DisaridanGelenDeger;
END;
GO
Nasıl Çalıştırılır? EXEC sp_ProsedurAdi 5, 'Metin' (veya EXEC sp_ProsedurAdi @DisaridanGelenDeger = 5, @DigerDeger = 'Metin').

Ekstra Yapılar: Eğer bir şeyin var olup olmadığını kontrol etmek istersen IF EXISTS (SELECT 1 FROM Tablo WHERE Sütun = @Parametre) yapısını kullanabilirsin

-- 72-> Disaridan girilen deger kadar urunlere zam yapan bir procedure tasarlayiniz...
go 
create procedure zam
    @zam int 
as
begin

update Products set UnitPrice=UnitPrice*@zam

end
go
exec zam 0.98
select * from Products
-- 73-> Disaridan girilen kategori adina ait urunleri listeleyen bir procedure tasarlayiniz...
go 
create procedure  sp_kategoriurungetir
    @kategoriAdi nvarchar(50)
    as
    begin
    select p.ProductName , p.UnitPrice
    from Products p
    inner join Categories c on p.CategoryID=c.CategoryID
    where c.CategoryName=@kategoriAdi
    end
    go

-- 74-> Stok miktari disaridan girilen iki deger arasinda olan, urun ucreti disaridan girilen iki deger arasinda olan, toptanci firma adi disaridan girilen harfi barindiran urunlerin adlarini, fiyatlarin, toptanci sirket adlarini ve fiyatlarinin KDV eklenmis hallerini gosteren bir procedure tasarlayiniz...

go 
create procedure sp_detayliUrun
    @MinStok SMALLINT, 
    @MaxStok SMALLINT, 
    @MinFiyat MONEY, 
    @MaxFiyat MONEY, 
    @ToptanciHarf NVARCHAR(10)
as 
begin
SELECT p.ProductName, p.UnitPrice, s.CompanyName AS Toptanci, (p.UnitPrice * 1.18) AS KDVliFiyat
    FROM Products p
    INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
    WHERE p.UnitsInStock BETWEEN @MinStok AND @MaxStok 
      AND p.UnitPrice BETWEEN @MinFiyat AND @MaxFiyat 
      AND s.CompanyName LIKE '%' + @ToptanciHarf + '%';

end
go
-- 75-> Disaridan kategori adi ve urun adi alan bir procedure tasarlayiniz. Eger boyle bir kategori varsa, urun o kategoriye eklensin. Yoksa once baska bir procedure yardimiyla kategori eklesin, daha sonra o kategoriye urun eklensin...
-- Adım 1: Sadece Kategori ekleyen yardımcı prosedür
CREATE PROCEDURE sp_YardimciKategoriEkle (@KatAdi NVARCHAR(50))
AS
BEGIN
    INSERT INTO Categories (CategoryName) VALUES (@KatAdi);
END;
GO

-- Adım 2: Asıl kontrol prosedürü
CREATE PROCEDURE sp_UrunVeKategoriEkle 
    @KategoriAdi NVARCHAR(50), 
    @UrunAdi NVARCHAR(50)
AS
BEGIN
    DECLARE @KatID INT;
    -- Kategori var mı kontrol et
    SELECT @KatID = CategoryID FROM Categories WHERE CategoryName = @KategoriAdi;
    
    -- Eğer kategori yoksa yardımcı prosedürü çalıştırıp ekle
    IF @KatID IS NULL 
    BEGIN
        EXEC sp_YardimciKategoriEkle @KategoriAdi;
        -- Yeni eklenen kategorinin ID'sini al
        SELECT @KatID = CategoryID FROM Categories WHERE CategoryName = @KategoriAdi;
    END
    
    -- Ürünü o kategori ID'si ile ekle
    INSERT INTO Products (ProductName, CategoryID) VALUES (@UrunAdi, @KatID);
END;
GO
-- 76-> Bir stored procedure tasarlayiniz. Bu procedure disaridan kategori adi ve aciklamasi alsin. Eger boyle bir kategori yoksa eklesin, varsa bu kategori zaten var uyarisini kullaniciya iletsin!
CREATE PROCEDURE sp_KategoriKontrolVeEkle 
    @KategoriAdi NVARCHAR(50), 
    @Aciklama NVARCHAR(MAX)
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Categories WHERE CategoryName = @KategoriAdi)
    BEGIN
        PRINT 'Uyarı: Bu kategori zaten veritabanında mevcut!';
    END
    ELSE
    BEGIN
        INSERT INTO Categories (CategoryName, Description) VALUES (@KategoriAdi, @Aciklama);
        PRINT 'Başarılı: Kategori sisteme eklendi.';
    END
END;
GO
-----------------FUNCTION (FONKSİYONLAR)-----------------
geriye TEK BİR DEĞER (RETURN) fırlatan makinelerdir.
Prosedürlerden en büyük farkı; fonksiyonları doğrudan bir SELECT sorgusunun içinde kullanabilirsin!
Syntax: (Dışarıya fırlatacağı verinin tipini RETURNS ile belirtmek zorundayız).

GO
CREATE FUNCTION fn_FonksiyonAdi (@Sayi INT)
RETURNS INT -- Dışarıya INT çıkacak diyoruz
AS
BEGIN
    -- Hesabı yapıp sonucu fırlatıyoruz
    RETURN @Sayi * 2; 
END;
GO
-- 77-> Disaridan girilen iki degeri toplayan ve bize geri donduren bir fonksiyon yazalim...
go 
create function topla ( @sayi1 int ,@sayi2 int)
returns int  
as
begin

return @sayi1 + @sayi2;

end
go

select dbo.topla(1,  4)
-- 78-> Parametre olarak ad ve soyad bilgisini alan bir fonksiyon tasarlayiniz. Bu fonksiyon adin ilk harfini, soyadin sonuna ekleyerek @itu.edu.tr  uzantılı tamamini kucuk harf yaparak geri dondursun...
CREATE FUNCTION mail (@Ad NVARCHAR(50), @Soyad NVARCHAR(50))
RETURNS NVARCHAR(150)
AS
BEGIN
    RETURN LOWER(SUBSTRING(@Ad, 1, 1) + @Soyad + '@itu.edu.tr');
END;
GO
-- 79-> Disaridan bir tarih alan ve bu tarihe gore yas hesaplayan bir fonksiyon tasarlayiniz. Bu fonksiyonu Employees tablosunda bulunan personeller tablosuna uygulayarak personellerin yaşlarını görüntüleyiniz. (Fonksiyon personel tablosundan bağımsız olarak tekil çalıştırılabilmeli.) (FirstName, LastName, Yasi)

go
create function  dg (@dogumtarihi Datetime)
returns  int
as
begin
    return datediff(Year ,@dogumtarihi , getdate())
end
go

select FirstName ,LastName , dbo.dg(BirthDate) as yas
from Employees

