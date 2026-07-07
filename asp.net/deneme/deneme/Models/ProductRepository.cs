namespace deneme.Models
{
    public class ProductRepository
    {
        // 1. LİSTEYİ OLUŞTURMA VE HAFIZAYA KAZIMA (STATIC MANTIĞI)
        // --------------------------------------------------------------------------------------
        // Normalde ASP.NET web sitelerinde sayfa her yenilendiğinde bu sınıf baştan yaratılır ve içindekiler silinir.
        // Başına 'static' yazdığımızda bilgisayara şu emri veririz: 
        // "Bu listeyi uygulamanın genel hafızasına (RAM'e) çivile! Sayfa yenilense bile içindeki verileri asla silme."
        //
        // 'new List<Product>()' kısmı çok önemlidir. Eğer bunu yazmazsak sadece "böyle bir listem olacak" demiş oluruz ama
        // hafızada o liste için fiziksel bir kutu üretilmez (null kalır). 'new' diyerek o boş kutuyu fiziksel olarak yaratıyoruz.
        private static List<Product> DepodakiUrunlerListesi = new List<Product>()
        {
    // Bunlar depo ilk kurulduğu an içeride olan asıl verilerimiz (Repository'nin kendi verileri)
    new Product { Id = 1, Name = "Kalem", Price = 50, Stock = 100 },
    
    new Product { Id = 2, Name = "Defter", Price = 100, Stock = 50 }
    
   };


    // 2. VERİLERİ OKUMA / GETİRME METODU (GET ALL MANTIĞI)
    // -------------------------------------------------------------------------------------------
    // Dışarıdaki bir dosya (örneğin Controller/Garson) "Bana ürünleri ver" dediğinde bu metot çalışır.
    // 'public List<Product>': Bu metodun işini bitirdiğinde geriye bir Ürünler Listesi fırlatacağını belirtir.
    public List<Product> TumUrunleriGetir()
        {
            // Yukarıda hafızada tuttuğumuz o çivili listeyi alıp, isteyen kişiye gönderiyoruz.
            return DepodakiUrunlerListesi;
        }



        // 3. YENİ VERİ EKLEME METODU (ADD MANTIĞI)
        // -------------------------------------------------------------------
        // Bu metot, dışarıdan gelen YENİ bir ürünü alıp bizim ana depomuza eklemekle görevlidir.
        // Parantez içindeki '(Product disaridanGelenYeniUrun)': Bir kuraldır, bir kapıdır.
        // "Beni kullanmak istiyorsan, bana mutlaka Product (Ürün) kalıbında üretilmiş bir veri vermek zorundasın" demektir.
        // Biz o gelen veriye içeride 'disaridanGelenYeniUrun' adıyla sesleneceğiz.
        public void YeniUrunEkle(Product disaridanGelenYeniUrun)
        {
            // Ana listemizin '.Add()' özelliğini kullanarak, parantez içinden giren o yeni ürünü listemize dahil ediyoruz.
            DepodakiUrunlerListesi.Add(disaridanGelenYeniUrun);
        }

        // foreach döngüsü ile bir listeyi okurken, aynı anda o listenin eleman sayısını değiştiremezsin (ekleme veya silme yapamazsın)



        // 4. SİLME (DELETE) - Foreach ile
        public void UrunSil(int silinecekUrununIdNumarasi)
        {
            // Önce aradığımız ürünü bulduğumuzda içine koyacağımız boş bir kutu hazırlıyoruz.
            Product silinecekUrun = null;

            // Depodaki tüm ürünleri baştan sona tek tek dolaşıyoruz.
            foreach (var urun in DepodakiUrunlerListesi)
            {
                // Eğer o an baktığımız ürünün Id'si, bizim aradığımız Id'ye eşitse...
                if (urun.Id == silinecekUrununIdNumarasi)
                {
                    silinecekUrun = urun; // Ürünü bulduk! Hemen yukarıdaki boş kutumuza kopyalıyoruz.
                    break; // Ürünü bulduğumuz için diğerlerine bakmaya gerek yok, döngüyü kırıp çıkıyoruz.
                }
            }

            // Döngü bittikten sonra bakıyoruz; eğer kutumuz boş değilse (yani ürünü gerçekten bulduysak)
            if (silinecekUrun != null)
            {
                DepodakiUrunlerListesi.Remove(silinecekUrun); // Ürünü ana listemizden siliyoruz.
            }
        }

        // 5. GÜNCELLEME (UPDATE) - Foreach ile
        public void UrunGuncelle(Product guncelBilgileriTasiyanUrun)
        {
            Product guncellenecekEskiUrun = null;

            // Yine depodaki tüm ürünleri tek tek dolaşıyoruz.
            foreach (var urun in DepodakiUrunlerListesi)
            {
                // Dışarıdan gelen güncel ürünün Id'si ile içerideki ürünün Id'si eşleşiyorsa...
                if (urun.Id == guncelBilgileriTasiyanUrun.Id)
                {
                    guncellenecekEskiUrun = urun; // Eski ürünü bulduk, kutuya koyduk.
                    break; // Aramayı bitir.
                }
            }

            // Eğer eski ürünü depoda bulabildiysek, bilgilerini yenileriyle değiştiriyoruz.
            if (guncellenecekEskiUrun != null)
            {
                guncellenecekEskiUrun.Name = guncelBilgileriTasiyanUrun.Name;
                guncellenecekEskiUrun.Price = guncelBilgileriTasiyanUrun.Price;
                guncellenecekEskiUrun.Stock = guncelBilgileriTasiyanUrun.Stock;
            }
        }
    }
}
