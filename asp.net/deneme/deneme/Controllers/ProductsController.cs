using deneme.Models;
using Microsoft.AspNetCore.Mvc;
// BAĞLANTI İŞTE BURADA KURULUYOR!
// Garsonumuz "Controllers" mahallesinde yaşıyor. Kilerimiz ise "Models" mahallesinde.
// Garsonun kileri bulabilmesi için ona adresi veriyoruz: "Models mahallesindeki aletleri kullan!"


/*  IActionResult -> Garsonun müşteriye vereceği cevabın türüdür. Bu bir HTML sayfası (View()) olabilir, 
 *  bir hata mesajı (NotFound()) olabilir veya bir dosya indirme işlemi bile olabilir. Şimdilik biz sadece View() yani görsel bir sayfa döndürüyoruz.

return View(masayaGidecekUrunler); -> İşte veriyi HTML sayfasına fırlattığımız o sihirli an! İçinde 3 tane ürün olan listeyi paketleyip tasarıma yolluyoruz.
*/




namespace deneme.Controllers
{
    // "Controller" sınıfından miras alıyoruz. Bu ona "Sen sıradan bir C# sınıfı değilsin, sen bir web garsonusun" yeteneklerini verir.
    public class ProductsController : Controller
    {
        // 1. KİLERİN ANAHTARINI ALIYORUZ
        // Garsonun işlem yapabilmesi için Kiler'den (Repository) bir kopya (nesne) oluşturuyoruz.
        private ProductRepository urunDeposu = new ProductRepository();

        // 2. CONSTRUCTOR (YAPICI METOT - GARSONUN İLK İŞ GÜNÜ)
        // Bu metot, biri sayfaya girdiği anda otomatik olarak 1 kere çalışır.
        // Ekranda boş bir sayfa görmemek için, kiler boşsa içine birkaç örnek ürün atıyoruz.
        public ProductsController()
        {
            // Eğer depodaki ürün sayısı 0 ise (yani depo boşsa)
            // ÇOK ÖNEMLİ KONTROL: Sayfa her yenilendiğinde garson aynı ürünleri tekrar eklemesin diye,
            // "Eğer depoda sadece 2 ürün varsa (yani sadece demirbaşlar varsa) benimkileri ekle" diyoruz.
            if (urunDeposu.TumUrunleriGetir().Count == 2)
            {
                // Depomuzun "YeniUrunEkle" metodunu kullanarak 3 tane örnek ürün fırlatıyoruz.
                urunDeposu.YeniUrunEkle(new Product { Id = 3, Name = "Laptop", Price = 25000, Stock = 10 });
                urunDeposu.YeniUrunEkle(new Product { Id = 5, Name = "Mouse", Price = 500, Stock = 50 });
                urunDeposu.YeniUrunEkle(new Product { Id = 4, Name = "Klavye", Price = 1500, Stock = 20 });
            }
        }

        // 3. INDEX METODU (ANA SAYFA - MÜŞTERİNİN SİPARİŞİ)
        // Kullanıcı tarayıcıda "localhost:xxxx/Products" yazdığında burası tetiklenir.
        public IActionResult Index()
        {
            // Adım A: Garson kile (Repository) gider ve "Bana tüm ürünleri ver" der.
            // Gelen o listeyi "masayaGidecekUrunler" adında bir tepsiye koyar.
            var masayaGidecekUrunler = urunDeposu.TumUrunleriGetir();

            // Adım B: Garson elindeki tepsiyi (veriyi), müşterinin masasına (View) götürür.
            // "Al kardeşim, istediğin veriler bunlar, şimdi bunları ekranda göster" der.
            return View(masayaGidecekUrunler);
        }

        // 4. SİLME İŞLEMİ (MÜŞTERİNİN TABAK İPTALİ)
        // Müşteri HTML sayfasındaki "Sil" butonuna tıkladığında, adres çubuğundaki o ID numarası 
        // otomatik olarak yakalanır ve bu metodun parantezinin (int id) içine düşer.
        public IActionResult Delete(int id)
        {
            // 1. Adım: Garson (Controller) aldığı bu ID numarasını kiler sorumlusuna (Repository) fırlatır ve "Bunu yokedin!" der.
            urunDeposu.UrunSil(id);

            // 2. Adım: Silme işlemi bittikten sonra garson, müşteriyi tekrar ana sayfaya (Index'e) yönlendirir.
            // Bu sayede müşteri sayfanın yenilendiğini ve o ürünün artık tabloda olmadığını kendi gözleriyle görür.
            // RedirectToAction -> "Beni başka bir metoda yönlendir" demektir.
            return RedirectToAction("Index");
        }

        /*Restoran örneğimizden düşünelim:

Müşteri garsonu çağırır ve "Bana boş bir sipariş fişi getir" der. Garson masaya boş bir kağıt bırakır. (Buna web dünyasında GET işlemi denir. Sadece sayfayı görüntüleriz).

Müşteri kalemi alır, fişe "1 adet Silgi, 10 TL" yazar ve garsona geri gönderir. Garson bu dolu fişi alıp mutfağa (Depoya) teslim eder. (Buna da POST işlemi denir. Veri göndeririz).

İşte bu yüzden, yeni ürün eklemek için Garsonumuza (Controller) aynı isimde ama farklı görevlerde İKİ TANE metot yazacağız.

        */

        // 5. YENİ ÜRÜN EKLEME SAYFASINI GÖSTERME (GET)
        // Müşteri "Yeni Ürün Ekle" butonuna tıkladığında sadece bu metot çalışır.
        // Görevi: Müşterinin önüne içi boş bir HTML formu (sipariş fişi) getirmektir.
        [HttpGet]
        public IActionResult Create()
        {
            return View(); // Sadece boş sayfayı açar.
        }


        

        // 6. DOLDURULAN FORMU KAYDETME (POST)
        // Müşteri formu doldurup "Kaydet" butonuna bastığında bu metot tetiklenir.
        // [HttpPost] etiketi: "Bu metot sayfa açmak için değil, dışarıdan gelen veriyi yakalamak içindir!" der.

        [HttpPost]
        public IActionResult Create(int Id, string Name, int Price, int Stock)
        {
            // Garson tek tek aldığı bu bilgileri mutfağa götürmeden önce 
            // kendi elleriyle bir "Ürün" (Product) tabağında birleştirir.
            Product yeniUrun = new Product();
            yeniUrun.Id = Id;
            yeniUrun.Name = Name;
            yeniUrun.Price = Price;
            yeniUrun.Stock = Stock;

            urunDeposu.YeniUrunEkle(yeniUrun);
            return RedirectToAction("Index");
        }

        // 7. GÜNCELLEME SAYFASINI GÖSTERME (GET)
        // Müşteri tablodaki mavi "Güncelle" butonuna bastığında çalışır (Örn: /Products/Edit/3).
        // Amacı: İçinde ürünün eski bilgileri (adı, fiyatı) dolu olan o formu ekrana getirmektir.
        [HttpGet]
        public IActionResult Edit(int id)
        {
            // 1. Adım: Depodaki tüm ürünleri listeye alıyoruz.
            var tumUrunler = urunDeposu.TumUrunleriGetir();

            // 2. Adım: Bize linkten gelen o ID numarasına sahip tek bir ürünü arayıp buluyoruz.
            Product guncellenecekUrun = null;
            foreach (var urun in tumUrunler)
            {
                if (urun.Id == id)
                {
                    guncellenecekUrun = urun;
                    break;
                }
            }

            // 3. Adım: Bulduğumuz bu eski ürünü, HTML formunun içine yazdırması için View'a gönderiyoruz.
            return View(guncellenecekUrun);
        }

        // 8. GÜNCELLENEN FORMU KAYDETME (POST)
        // Müşteri formdaki fiyatı veya stoku değiştirip "Değişiklikleri Kaydet" butonuna bastığında çalışır.
        [HttpPost]
        public IActionResult Edit(Product degistirilmisUrun)
        {
            // Garson, müşteriden gelen bu yeni form bilgilerini doğrudan depodaki güncelleme metoduna fırlatır.
            urunDeposu.UrunGuncelle(degistirilmisUrun);

            // İşlem bitince müşteriyi, değişimi kendi gözleriyle görsün diye ana tabloya (Index'e) geri yönlendirir.
            return RedirectToAction("Index");
        }














    }
}
