using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering; // Açılır liste (SelectList) için gerekli
using Microsoft.EntityFrameworkCore; // Include metodu için ŞART
using denemeSql.Context;
using denemeSql.Models;

namespace denemeSql.Controllers
{
    public class CoursesController : Controller
    {
        private readonly LmsDbContext _context;

        public CoursesController(LmsDbContext context)
        {
            _context = context;
        }

        // 1. DERS LİSTESİ (READ) - Include Kullanımı
        public IActionResult Index()
        {
            // Veritabanından dersleri çekerken, o dersin "Academician" bilgisini de JOIN yaparak (Include ile) yanına ekle!
            var courses = _context.Courses.Include(c => c.Academician).ToList();
            return View(courses);
        }

        // 2. YENİ DERS EKLEME EKRANI (GET) - Açılır Liste Hazırlığı
        public IActionResult Create()
        {
            // Veritabanındaki akademisyenleri çekip, formdaki açılır menü (dropdown) için ViewBag içine atıyoruz.
            // "Id" arka planda kaydedilecek değer, "Name" ise kullanıcının ekranda göreceği yazıdır.
            ViewBag.AcademiciansList = new SelectList(_context.Academicians, "Id", "Name");
            return View();
        }

        // 3. YENİ DERSİ VERİTABANINA KAYDETME (POST)
        [HttpPost]
        public IActionResult Create(Course course)
        {
            if (ModelState.IsValid)
            {
                _context.Courses.Add(course);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }

            // Hata olursa açılır listeyi tekrar doldurmak zorundayız, yoksa sayfa çöker.
            ViewBag.AcademiciansList = new SelectList(_context.Academicians, "Id", "Name", course.AcademicianId);
            return View(course);
        }
    }
}