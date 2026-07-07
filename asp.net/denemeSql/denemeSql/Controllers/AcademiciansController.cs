using Microsoft.AspNetCore.Mvc;
using System.Linq;
using denemeSql.Models;     // Kendi Modellerinizin olduğu klasör
using denemeSql.Context;    // Kendi DbContext klasörünüz

namespace denemeSql.Controllers
{
    public class AcademiciansController : Controller
    {
        // Veritabanı nesnemizi tutacağımız değişken
        private readonly LmsDbContext _context;

        // 1. Dependency Injection (Bağımlılık Enjeksiyonu)
        // Program.cs dosyasında hazırladığımız ayarlar buraya gelir ve _context'in içini doldurur.
        public AcademiciansController(LmsDbContext context)
        {
            _context = context;
        }

        // 2. Listeleme Sayfası (Read İşlemi)
        public IActionResult Index()
        {
            // Veritabanındaki Academicians tablosuna git, hepsini seç ve bir Listeye çevir.
            //var academicians = _context.Academicians.ToList();
            var academicians = _context.Academicians.Select(c => new AcademicianDTO
            {
                Id = c.Id,
                Name = c.Name
            });

            var sut = _context.Students.Select(c => new StudentDTO
            {
                FirstName = c.FirstName,
                LastName = c.LastName,
                Id = c.Id,
                Courses = c.Courses.Select(c =>
                {

                }).ToList()

            }
                );
            // Çektiğin bu listeyi (academicians) ön yüze (View'a) gönder.
            return View(academicians);
        }



        // 1. AŞAMA: Sadece boş formu ekranda göstermek için çalışır (GET)
        public IActionResult Create()
        {
            return View();
        }

        // 2. AŞAMA: Kullanıcı "Kaydet" butonuna bastığında çalışır (POST)
        // Formdan gelen bilgiler "academician" nesnesinin içine dolmuş halde buraya gelir.
        [HttpPost]
        public IActionResult Create(Academician academician)
        {
            // ModelState.IsValid: Modeldeki kurallara uyulmuş mu? s
            // (Hatırlarsanız Name özelliğine [Required] -zorunlu- yazmıştık. Boş mu değil mi diye bakar.)
            if (ModelState.IsValid)
            {
                _context.Academicians.Add(academician); // Veriyi hafızadaki tabloya ekle
                _context.SaveChanges(); // Fiziksel olarak SQL'e yaz (INSERT INTO komutunu çalıştırır)

                // İşlem başarıyla bitince kullanıcıyı tekrar "Index" (Liste) sayfasına yönlendir
                return RedirectToAction("Index");
            }

            // Eğer bir hata varsa (isim boş girildiyse vs.) kullanıcıyı aynı sayfada formla baş başa bırak
            return View(academician);
        }


        // 3. Silme İşlemi (Delete)
        // Arayüzden (View) buraya silinecek kişinin "id" numarası gelecek.
        public IActionResult Delete(int id)
        {
            // 1. Veritabanına git ve bu ID'ye sahip akademisyeni bul
            var academician = _context.Academicians.Find(id);

            // 2. Eğer böyle bir kayıt gerçekten varsa silme işlemine başla
            if (academician != null)
            {
                _context.Academicians.Remove(academician); // Tablodan silinmek üzere işaretle
                _context.SaveChanges(); // Değişikliği fiziksel olarak SQL'e kaydet
            }

            // 3. İşlem bitince kullanıcıyı güncel listeyi görmesi için Index sayfasına geri gönder
            return RedirectToAction("Index");
        }




        // 4. Güncelleme İşlemi (Edit) - 1. AŞAMA (GET)
        // Kullanıcı "Düzenle" butonuna bastığında çalışır. Formu dolu getirmek için veritabanından kişiyi bulur.
        public IActionResult Edit(int id)
        {
            var academician = _context.Academicians.Find(id); // ID'ye göre kişiyi bul

            if (academician == null)
            {
                return NotFound(); // Böyle biri yoksa "Sayfa Bulunamadı" hatası ver
            }

            return View(academician); // Bulunan kişiyi (eski bilgileriyle) forma gönder
        }

        // 4. Güncelleme İşlemi (Edit) - 2. AŞAMA (POST)
        // Kullanıcı formda değişiklik yapıp "Güncelle" butonuna bastığında çalışır.
        [HttpPost]
        public IActionResult Edit(int id, Academician academician)
        {
            // Güvenlik Önlemi: Adresteki ID ile formun içinden gelen ID aynı mı?
            if (id != academician.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                _context.Academicians.Update(academician); // Veriyi yeni haliyle güncelle
                _context.SaveChanges(); // SQL'e fiziksel olarak kaydet

                return RedirectToAction("Index"); // Listeye geri dön
            }

            // Eğer formu boş bırakıp kaydetmeye çalışırsa, formu hatalarla birlikte geri göster
            return View(academician);
        }







    }
}
