using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using NorthwindLinq.Models;
using System.Diagnostics.Metrics;

namespace NorthwindController.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NorthwindController : ControllerBase
    {
        // SQL Server ile konuşmamızı sağlayacak olan köprümüz (Context)
        private readonly NorthwindContext _context;

        // Dependency Injection (Bağımlılık Enjeksiyonu): API ayağa kalkarken köprüyü hazırla.
        public NorthwindController(NorthwindContext context)
        {
            _context = context;
        }



        //        Tabloya Bağlan: _context.Products

        //Filtrele(Gereksizleri Çöpe At): .Where(x => x.Kategori == 1)

        //Sırala(İsteniyorsa) : .OrderBy(x => x.Fiyat)

        //Sayfalama(İsteniyorsa) : .Take(10)

        //Şekillendir / Sütun Seç(Sadece Lazım Olanları Al): .Select(x => new { x.Ad, x.Fiyat })

        //Sorguyu Ateşle ve Veriyi Çek: .ToList(), .Sum(), .Count() vb.





        //    var sonuc = _context.TabloAdi
        //.Select(satir => new
        //{
        //    YeniIsim = satir.GercekSutunAdi, // İstersen sütunun adını değiştirebilirsin
        //    satir.BaskaSutunAdi              // İstersen doğrudan kendi adıyla alabilirsin
        //}).ToList();




        [HttpGet("sql-nasil-olmus-testi")]
        public IActionResult GetSqlTest()
        {
            // 1. ADIM: Sadece sorguyu hazırla (Sonuna ToList YAZMA!)
            var benimSorgum = _context.Products.Where(p => p.UnitPrice > 50 && p.UnitsInStock > 0);

            // ---> 🔴 BREAKPOINT'İ TAM BU SATIRA KOY <---
            // EF Core 5.0 ile gelen efsanevi komut: .ToQueryString()
            string uretilenSqlKodu = benimSorgum.ToQueryString();

            // 2. ADIM: Şimdi veritabanına git ve veriyi çek
            var sonuc = benimSorgum.ToList();

            return Ok(sonuc);
        }







        [HttpGet("kargolari-getir-1")]
        public IActionResult GetShippers1()
        {
            var sonuc = _context.Shippers.
                Select(s => new
                {
                    s.ShipperId,
                    s.CompanyName,
                    s.Phone

                }).ToList();
            return Ok(sonuc);
        }

        [HttpGet("kargolari-getir-2")]
        public IActionResult GetShippers2()
        {
            var sonuc = _context.Employees.Select(s => new
            {
                s.EmployeeId,
                AdSoyad= s.FirstName +"-"+s.LastName 


            }).ToList();
            return Ok(sonuc);
        }


        [HttpGet("kargolari-getir-3")]
        public IActionResult GetShippers3()
        {

            var sonnuc = _context.Employees.Select(s => new
            {

                s.FirstName,
                s.LastName,
                dogumTarihi = DateTime.Now.Year - s.BirthDate.Value.Year

            }).ToList();


            return Ok(sonnuc);
        }

        [HttpGet("kargolari-getir-4")]
        public IActionResult GetShippers4 ()
        {
            var sonuc = _context.Products.Select(e => new
            {
                e.ProductId,
                e.ProductName,
                e.UnitsInStock,
                e.UnitPrice,
                kdv=  e.UnitPrice* Convert.ToDecimal(1.18)



            }).ToList();


            return Ok(sonuc);
        }


        //        LINQ'te filtreleme yapmak için .Where() metodu kullanılır. İçerisine bir lambda ifadesi (örn: x => x.SutunAdi == deger) yazılır. Eğer filtreden sonra sadece belirli sütunları almak istersen, .Where()'in peşine hemen.Select() takabilirsin!

        //Kullanacağımız Operatörler:

        //Eşittir: ==

        //Eşit Değildir: !=

        //Büyüktür / Küçüktür: > / <


        //    var sonuc = _context.TabloAdi
        //.Where(t => t.Fiyat < 100) // Önce 100'den küçükleri filtrele
        //.Select(t => new { t.Ad }) // Sonra sadece Ad sütununu seç
        //.ToList();                 // Ve veritabanından çek!

        // =========================================================
        // BÖLÜM 2: VERİLERİN FİLTRELENDİRİLMESİ (WHERE)
        // =========================================================
        [HttpGet("bolum2-filtreleme-where")]
        public IActionResult GetBolum2WhereSorgulari()
        {
            // 5 -> Ücreti 30'dan yüksek olanlar
            var sonuc5 = _context.Products.Where(i => i.UnitPrice > 30).ToList();


            var sonuc6 = _context.Employees.Where(i => i.City == "London").ToList();

            var sonuc7 = _context.Products.Where(i => i.CategoryId != 5).Select(e => new
            {
                e.ProductName,
                e.CategoryId
            }).ToList();

            var sonuc8 = _context.Employees.Where(i => i.HireDate > new DateTime(1993, 1, 1)).Select(o => new
            {
                o.FirstName,
                o.LastName,
                o.HireDate
            }).ToList();

            var sonuc9 = _context.Orders.Where(i => i.OrderDate.Value.Month == 3).Select(i=> new
            {
                i.OrderId,
                i.OrderDate
               

            }).ToList();


            // Hepsini tek JSON paketinde gönderiyoruz!
            return Ok(new
            {
                Soru5 = sonuc5,
                Soru6 = sonuc6,
                Soru7 = sonuc7,
                Soru8 = sonuc8,
                Soru9 = sonuc9
            });
        }

        //.Where(x => x.Fiyat > 10 && x.Kategori == "A") // Fiyatı 10'dan büyük VE Kategorisi A olanlar

        [HttpGet("bolum3")]
        public IActionResult Getand_or ()
        {

            var sonuc10 = _context.Products.Where(i => i.UnitsInStock >= 20 && i.UnitsInStock <= 50).ToList();

            var sonuc11 = _context.Employees.Where(i => (DateTime.Now.Year - i.BirthDate.Value.Year) > 50 && i.Country != "UK").Select(o => new
            {
                 
                AdSyoad= o.FirstName.Substring(0,1)+" "+  o.LastName,
                dogum= DateTime.Now.Year -  o.BirthDate.Value.Year 

            }).ToList();


            var sonuc12 = _context.Orders.Where(h => h.OrderDate.Value.Year >= 1997 && h.Freight > 20 && h.ShipCountry != "France").ToList();


            return Ok(new
            {
                sonuc10,
                sonuc11,
                sonuc12
            });
        }


        //.Where(x => x.SutunAdi == null) // Bu sütunu boş olanları getir

        //.Where(x => x.SutunAdi != null) // Bu sütunu boş olmayanları (dolu olanları) getir

        [HttpGet("bolum_null")]
        public IActionResult GetBolum4NullSorgulari()
        {

            var sonuc13 = _context.Orders.Where(i => i.ShippedDate == null).ToList();

            var hedef14 = _context.Orders.Where(i => i.ShippedDate != null).ToList();

            var biz15 = _context.Employees.Where(i => i.Title != null).ToList();

            var sonuc16 = _context.Orders.Where(p => p.EmployeeId == 1 && p.ShipVia == 3 && p.ShipRegion == null && (p.CustomerId == "DUMON" || p.CustomerId == "ALFKI")).ToList();

            return Ok(new
            {
                sonuc13,
                hedef14,
                biz15,
                sonuc16

            });
        }


        // Küçükten Büyüğe (A-Z, Ucuzdan Pahalıya): .OrderBy(x => x.SutunAdi) kullanılır.
        // Büyükten Küçüğe (Z-A, Pahalıdan Ucuza): .OrderByDescending(x => x.SutunAdi) kullanılır.


        //SQL'deki TOP 5 komutunun LINQ karşılığı .Take(5) metodudur.
        // Altın Kural: .Take() komutunu her zaman sıralama (OrderBy) işleminden sonra ve .ToList() komutundan önce yazmalısın. Önce sıraya dizeceksin ki, en üstteki 5 kişiyi alasın!

        //    var sonuc = _context.Urunler
        //.Where(u => u.Stok > 0)          // 1. Önce Filtrele
        //.OrderByDescending(u => u.Fiyat) // 2. Sonra Pahalıdan Ucuza Sırala
        //.Take(5)                         // 3. En üstteki (en pahalı) 5 tanesini al
        //.Select(u => new { u.Ad })       // 4. Sadece Adını seç
        //.ToList();                       // 5. Veritabanından çek!

        [HttpGet("select-17den")]
        public IActionResult getselect17 ()
        {


            var sonuc17=_context.Customers.Where(p=> p.Country=="France").OrderByDescending(u=>u.CustomerId).Select(u=>u.Country).ToList();

            var sonuc18 = _context.Products.Where(p => p.UnitsInStock > 50).OrderBy(u => u.UnitPrice).Select(f => new
            {
                f.ProductName, f.UnitPrice, f.UnitsInStock
            }).ToList();

            var sonyc19 = _context.Products.OrderBy(o => o.UnitPrice).Take(10).ToList();

            var soonuc20=_context.Orders.Where(k=>k.ShippedDate!=null).OrderByDescending(k=>k.ShippedDate).Take(5).ToList();

            var sonuc21 = _context.Orders.OrderBy(l => l.Freight).Take(1).Select(o => o.OrderId).ToList();


            return Ok(new
            {
 
                sonuc17,
                sonuc18,
                sonyc19,
                soonuc20,
                sonuc21,

            });
        }

//        SQL'deki % işaretlerinin yerine, C#'ın o meşhur 3 string (metin) metodunu kullanırız:

//SQL: LIKE 'A%' (A ile başlayanlar) ➡️ C#: .StartsWith("A")

//SQL: LIKE '%A' (A ile bitenler) ➡️ C#: .EndsWith("A")

//SQL: LIKE '%A%' (İçinde A geçenler) ➡️ C#: .Contains("A")

//Pro İpucu: Değil(Olmayan) durumlar için başa ünlem !konur.Örn: !x.Ad.StartsWith("A") (A ile başlamayanlar).




        [HttpGet("select-22den")]
        public IActionResult get22_bass()
        {

            var sonuc22 = _context.Products.Where(p => p.ProductName.StartsWith("C") && p.UnitsInStock > 0 && (p.UnitPrice > 10 && p.UnitPrice < 250)).OrderBy(p=>p.UnitPrice).ToList();

            var sonuc23 =_context.Orders.Where(o=>o.OrderDate.Value.DayOfWeek==DayOfWeek.Wednesday && o.Freight>20 &&o.Freight<75 && o.ShippedDate!=null   ).OrderByDescending(o=>o.OrderId).ToList();

            var sonuc24 = _context.Customers
                            .Where(c => c.CompanyName.StartsWith("A"))
                            .ToList();


            var sonuc25 = _context.Customers
                .Where(c => c.CompanyName.EndsWith("A"))
                .ToList();

            var sonuc26= _context.Customers.Where(c=>c.CompanyName.Contains("ltd")).ToList();
            
            var sonuc27 = _context.Customers
                            .Where(c => c.CustomerId.EndsWith("mon"))
                            .ToList();


            var sonuc28 = _context.Customers
                .Where(c => c.CustomerId.StartsWith("A") || c.CustomerId.StartsWith("S"))
                .ToList();

            // Başa konan ünlem ! işareti 'DEĞİL' demek
            var sonuc29 = _context.Customers
                .Where(c => !c.CustomerId.StartsWith("A"))
                .ToList();

            var sonuc30 = _context.Employees.Where(p => p.Country != "UK" && p.FirstName.StartsWith("A") && p.LastName.EndsWith("R") && p.BirthDate.Value.Year < 1985).ToList();

            var sonuc31= _context.Employees.Where(p=>p.Notes.Contains(" Japanese")  ).ToList();

            return Ok(new
            {
                sonuc22, sonuc23, sonuc24, sonuc25, sonuc26, sonuc27, sonuc28, sonuc29, sonuc30, sonuc31,


            });

        }

        // Burada çok önemli bir kural değişikliği var: Artık .ToList() kullanmayacağız! Çünkü bizden bir "liste" değil, tek bir "sonuç" (bir sayı, bir toplam, bir ortalama) isteniyor.

        //        .Count() : Satırları sayar. (Kaç tane?)

        //.Sum(x => x.Kolon) : Belirtilen kolonun toplamını alır.

        //.Average(x => x.Kolon): Belirtilen kolonun ortalamasını alır.

        //.Max(x => x.Kolon): Belirtilen kolonun en büyük(maksimum) değerini bulur.

        //.Min(x => x.Kolon): Belirtilen kolonun en küçük(minimum) değerini bulur.

        //.Distinct(): Tekrar eden kayıtları eler, benzersiz (farklı) olanları bırakır.

        // Fiyatı 50'den büyük KAÇ TANE ürün var? (Liste dönmez, int döner: Örn: 15)
        //  int urunSayisi = _context.Products.Where(p => p.UnitPrice > 50).Count();



        [HttpGet("select32_denbasliyor")]
        public IActionResult gettselect32 ()
        {

            var sonuc32 = _context.Products.Where(i => i.UnitsInStock > 0).Count();

            var sonuc33= _context.Orders.Where(i=>i.OrderDate.Value.Year>1996).Count();

            var sonuc34=_context.Customers.Select(i=>i.Country).Distinct().Count();

            var sonuc35 = _context.Products.Select(i => i.UnitPrice).Sum();

            var sonuc36 = _context.Products.Sum(i=>i.UnitPrice*i.UnitsInStock);

            var sonuc37 = _context.Orders.Where(i => i.OrderDate.Value.Year == 1996).Sum(i => i.Freight);

            var sonuc38 = _context.Orders.Average(i => i.Freight);

            var sonuc39 = _context.Products.Average(i => i.UnitPrice);

            var sonuc40= _context.Orders.Max(i => i.Freight);


            // (CompareTo("L") < 0 demek, alfabetik olarak L'den önce gelenler yani A-K arası demektir)
            var sonuc41 = _context.Orders
                .Where(o => o.CustomerId.CompareTo("L") < 0
                         && o.OrderDate >= new DateTime(1997, 1, 1)
                         && o.OrderDate <= new DateTime(1997, 6, 6))
                .Min(o => o.Freight);
            return Ok(new
            {
                sonuc32, sonuc33, sonuc34,sonuc35, sonuc36, sonuc37, sonuc38,  sonuc39, sonuc40, sonuc41,   




            });
        }


        //City == "London" || City == "Paris" || City == "Berlin" ... diye yazmak tam bir işkencedir.İşte burada imdadımıza diziler(Array) ve.Contains() metodu yetişiyor.


        //// 1, 3 ve 5 nolu kategorilerdeki ürünleri getir:
        //var sonuc = _context.Products
        //    .Where(p => new[] { 1, 3, 5 }.Contains(p.CategoryId))
        //    .ToList();

        //// Şehri London veya Paris olanlar:
        //var sonuc2 = _context.Employees
        //    .Where(e => new[] { "London", "Paris" }.Contains(e.City))
        //    .ToList();


        // contains kullanırken stringlerde boşluk koyma

        [HttpGet("select42den")]
        public IActionResult gtttiing42()
        {

            var sonuc42 = _context.Orders.Where(e => new[] { 2, 4, 5, 7 }.Contains(e.EmployeeId.Value)).ToList();

            var sonuc43 = _context.Orders.Where(i => i.OrderDate.Value.Year == 1996 && i.OrderDate.Value.DayOfWeek == DayOfWeek.Thursday && new[] { 1, 2 }.Contains(i.ShipVia.Value)).Max(o => o.Freight);

            var sonuc44 = _context.Orders.Where(i => i.ShipVia.Value != 2 && i.Freight <= 200 && i.Freight >= 20 && new[] { "CACTU", "DUMON", "PERIC" }.Contains(i.CustomerId)).Select(i => i.Freight).Sum();

            return Ok(new
            {
                sonuc42,
                sonuc43,
                sonuc44

            });

        }

        //        //(Şart) ? "Doğruysa Bu" : "Yanlışsa Bu"


        //        Tek Şartlı):

        //C#
        //var sonuc = _context.Urunler.Select(u => new
        //{
        //            u.Ad,
        //    // Eğer stok sıfırsa "Bitti" yaz, değilse "Var" yaz
        //    Durum = (u.Stok == 0) ? "Bitti" : "Var" 
        //}).ToList();


        //        Eğer 3-4 farklı durum varsa, : (değilse) kısmından sonra yeni bir şart daha açabilirsin.Görev 46 tam olarak bunu istiyor!

        //C#
        //Durum = (u.Stok < 10) ? "Kritik" :
        //        (u.Stok < 50) ? "Normal" :
        //        "Fazla" // Hiçbirine uymuyorsa en son bu



        [HttpGet("bolum10-when-case")]
        public IActionResult GetBolum10SartliSorgular()
        {

            var sonuc45 = _context.Employees.Select(i => new
            {
                i.LastName,
                i.FirstName,
                CinsiyetDurumu = i.TitleOfCourtesy == "Mr." ? "Bay" :
                                     (i.TitleOfCourtesy == "Ms." || i.TitleOfCourtesy == "Mrs.") ? "Bayan" :
                                     "Ön Bilgi Yok"

            }).ToList();



            var sonuc46 = _context.Products.Select(i => new
            {
                i.ProductName,
                i.UnitsInStock,
                i.UnitPrice,
                druum = i.UnitsInStock < 50 ? "az" :
                            (i.UnitsInStock >= 50 && i.UnitsInStock < 75) ? "normal" :
                            "fazla"

            }).ToList();

            return Ok(new
            {
                sonuc45,sonuc46
            });
        }


        //        Kural 1: Önce neye göre gruplayacağını seçersin. .GroupBy(x => x.Kolon)
        //Kural 2: Sonra.Select() içine girersin.Burada kullandığın harf(genelde g deriz) artık bir satırı değil, o Grubu temsil eder.
        //Kural 3: g.Key kelimesi, grupladığın kolonun adıdır(Örn: Ülke adı, Kategori ID'si). g.Count(), g.Sum() gibi komutlar ise o grubun içindeki verileri hesaplar.



        //// Hangi Şehirde Kaç Çalışanım Var?
        //var sonuc = _context.Employees
        //    .GroupBy(e => e.City) // Önce Şehre göre grupla
        //    .Select(g => new
        //    {
        //        SehirAdi = g.Key,        // g.Key -> Şehrin adını verir (London, Seattle vs.)
        //        CalisanSayisi = g.Count() // g.Count() -> O şehrin içindeki çalışanları sayar
        //    })
        //    .ToList();


        [HttpGet("bolum11-group-by")]
        public IActionResult GetBolum11GroupBySorgulari()
        {
            var sonuc47 = _context.Employees
                .GroupBy(e => e.Country) // Ülkeye göre grupla
                .Select(g => new
                {
                    Ulke = g.Key,          // Hangi ülke?
                    Adet = g.Count()       // O ülkede kaç kişi var?
                })
                .ToList();

            var sonuc48 = _context.Products.GroupBy(e => e.CategoryId).Select(g => new
            {
                urun = g.Key,
                adet = g.Count()
            }).ToList();

            var sonuc49 = _context.Orders.GroupBy(i => i.EmployeeId).Select(g => new
            {
                siparissayisi =g.Key,    //g.Key grupladığımız kolonu (EmployeeId) verir
                adet =g.Count()         // g.Count() o grubun içindeki adedi verir


            }).ToList();

            var sonuc50 = _context.Orders.GroupBy(i => i.ShipCountry).Select(g => new
            {
                siparissayisi=g.Key,
                adet=g.Count()

            }).OrderByDescending(i=>i.adet).Take(3).ToList();

            return Ok(new
            {
                Soru47_KategoriUrunSayisi = sonuc47,
                Soru48_UlkeKargoToplami = sonuc48,
                Soru49_MusteriSiparisSayisi = sonuc49,
                Soru50_KategoriToplamStok = sonuc50
            });
        }

        // tabloları (modelleri) kurarken aralarındaki Foreign Key (Yabancı Anahtar) ilişkisini tanımladıysan, EF Core JOIN işlemini kendi kendine yapar! Senin tek yapman gereken noktaya (.) basıp diğer tabloya geçmektir. Buna Navigation Property (Gezinme Özelliği) denir.


        //// Ürünün Adını ve O ürünün Kategori Adını getir:
        //var sonuc = _context.Products.Select(p => new
        //{
        //    UrunAdi = p.ProductName,
        //    KategoriAdi = p.Category.CategoryName // Noktaya bastık ve Kategori tablosuna geçtik! (Oto-JOIN)
        //}).ToList();


        [HttpGet("bolum12-join-islemleri")]
        public IActionResult GetBolum12JoinSorgulari()
        {
            var sonuc51 = _context.Products.Select(p => new
            {
                urunadi=p.ProductName,
                kategoriadi=p.Category.CategoryName



            }).ToList();


            var sonuc52 = _context.Products.Select(p => new
            {
                p.ProductName,
                p.Supplier.CompanyName

            }).ToList();



            var sonuc53 = _context.Products
                   .Where(p => p.Category.CategoryName == "Beverages" && p.UnitsInStock > 0)
                   .Select(p => new
                   {
                       p.ProductName,
                       p.Category.CategoryName
                   }).ToList();


            var sonuc54 = _context.Orders
                            .Where(i => i.ShipViaNavigation.CompanyName == "Federal Shipping" && i.Employee.FirstName == "Nancy")
                            .Select(p => new
                            {
                                p.OrderId,
                                p.Employee.FirstName,
                                p.Employee.LastName,
                                p.OrderDate,
                                MusteriSirketi = p.Customer.CompanyName // Müşteri şirketi sadece listeleme için seçildi
                            }).ToList();

            var sonuc55 = _context.Orders
                            .Where(o => o.Customer.CompanyName.Contains("a")
                                     && new[] { "Nancy", "Andrew", "Janet" }.Contains(o.Employee.FirstName)
                                     && o.ShipViaNavigation.CompanyName != "Speedy Express")
                            .Sum(o => o.Freight);



            return Ok(new
            {
             
                sonuc51,sonuc52,sonuc53,sonuc54,sonuc55

            });
        }


    //"olmayan verileri de getir" dediğimizde imdadımıza .DefaultIfEmpty() metod yetişir. "Eğer karşılığı boşsa, patlama, bana boş (null) olarak getir" demektir.
    //LEFT JOIN'dir.  Bunu yaparken.SelectMany() ve.DefaultIfEmpty() kullanırız
    //Standart JOIN(INNER JOIN): Sadece her iki tabloda da eşleşenleri getirir(Şu ana kadar noktaya basarak p.Category.CategoryName diyerek yaptıklarımız).
    //LEFT / RIGHT JOIN: EF Core'da "Hangi tablodan başladığına" göre değişir.
    //Eğer Kategoriler'den başlarsan ve "Ürünü olmayan kategorileri de getir" dersen, bu Kategoriler tablosunu baz alan bir LEFT JOIN'dir.
    //Bunu yaparken.SelectMany() ve.DefaultIfEmpty() kullanırız.


        //        _context.Categories.SelectMany(
        //    c => c.Products.DefaultIfEmpty(), // Ürünü yoksa boş (null) geç
        //    (c, p) => new
        //    {
        //        KategoriAdi = c.CategoryName,
        //        UrunAdi = p != null ? p.ProductName : "Bu Kategoride Ürün Yok" // Eğer p null ise hata vermemesi için
        //    }
        //)

        [HttpGet("bolum13-left-right-join")]
        public IActionResult getleft_rigth_join()
        {
            var sonuc56 = _context.Products.GroupBy(p => p.Supplier.CompanyName).Select(g => new
            {
                uruncesidi = g.Count(),
                companyname = g.Key

            }).OrderByDescending(x=>x.uruncesidi).Take(3).ToList();



            var sonuc57 = _context.OrderDetails
                            .GroupBy(od => new { od.Product.ProductName, od.Product.Category.CategoryName })
                            .Select(g => new
                            {
                                ProductName = g.Key.ProductName,
                                CategoryName = g.Key.CategoryName,
                                Toplamsatisgeliri = g.Sum(od => (decimal)od.Quantity * od.UnitPrice * (1 - (decimal)od.Discount))
                            })
                            .ToList();



            var sonuc58 = (from c in _context.Categories 

               join p in _context.Products on c.CategoryId equals p.CategoryId into urunler

               from p in urunler.DefaultIfEmpty()

               select new
               {
                   CategoryName = c.CategoryName,
                   ProductName = p != null ? p.ProductName : "Ürün Yok"
               }).ToList();


            var sonuc59 = _context.Products
                .Select(p => new
                {
                    ProductName = p.ProductName,
                    CategoryName = p.Category != null ? p.Category.CategoryName : null // Kategori yoksa null dön
                }).ToList();



            var sonuc60 = _context.Products.Select(x=> new
            {
                x.ProductName,
                x.Category.CategoryId
            });

            return Ok(new
            {
                sonuc56,sonuc57,sonuc58,sonuc59,sonuc60

            });
        }


        //   HAVING diye özel bir kelime yoktur!Sadece.GroupBy() metodundan sonra yazdığın bir.Where() metodu, otomatik olarak HAVING görevi görür


        [HttpGet("bolum14-having-subquery")]
        public IActionResult getbolum14advanced()
        {

            var sonuc61 = _context.OrderDetails
                        .GroupBy(od => od.Product.ProductName) // 1. Önce ürüne göre grupla
                        .Where(g => g.Sum(x => x.Quantity) > 1200) // 2. İŞTE HAVING BURASI! (Grupladıktan sonra Where kullandık)
                        .Select(g => new
                        {
                            UrunAdi = g.Key,
                            ToplamSiparisMiktari = g.Sum(x => x.Quantity)
                        })
                        .ToList();


            var sonuc62 = _context.Orders.GroupBy(x=> new { x.ShipViaNavigation.CompanyName, x.ShipViaNavigation.Phone}).Where(g=>g.Count()>250)
                            .Select(g=> new
                            {
                                kargofirmasi=g.Key.CompanyName,
                                telefon=g.Key.Phone,
                                siparsiadi=g.Count()



                            }).ToList();




            return Ok(new
            {





            });
        }










    }
}