using BulkyBookWeb.Data;
using BulkyBookWeb.Models;
using Microsoft.AspNetCore.Mvc;

namespace BulkyBookWeb.Controllers
{
    public class CategoryController : Controller
    {


        private readonly ApplicationDbContext _db;   // database eriştiğimiz class tan  obje ürettik

        public CategoryController(ApplicationDbContext db)
        {
            _db=db;
        }

        public IActionResult Index()
        {
            IEnumerable<Category> objCategoryList =_db.Categories;   
            return View(objCategoryList);
        }

        //get
        public IActionResult Create()
        {
            return View();
        }

        //post
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Category obj)   // neyin hatalı olduğunu göstermek için cshtml dosyasına ekleme yaptık
        {

            if (obj.Name == obj.DisplayOrder.ToString())  // kendimiz bir hata kısmı ekledik isim ile DisplayOrder aynı olursa aşağıdaki hatayı dönücek view
            {
                ModelState.AddModelError("name", "The DisplayOrder cannot exactly match the Name.");

            }

            if (ModelState.IsValid)  // model de oluşturduğumuz property e göre uygun mu int int mi girili 
            {
                _db.Categories.Add(obj);
                _db.SaveChanges();
                TempData["success"] = "Category created successfully";
                return RedirectToAction("Index");
            }
            return View(obj);
        }

        //get
        public IActionResult Edit(int ? id)
        {
            if(id==null || id == null)
            {
                return NotFound();
            }

            var categoryFromDb = _db.Categories.Find(id);
            // var categoryFromDbFirst = _db.Categories.FirstOrDefault(u => u.Id == id);
            // var categoryFromDbSingle = _db.Categories.SingleOrDefault(u => u.Id == id);


            if (categoryFromDb == null)
            {
                return NotFound();
            }

            return View(categoryFromDb);
        }

        //post
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(Category obj)   // neyin hatalı olduğunu göstermek için cshtml dosyasına ekleme yaptık
        {

            if (obj.Name == obj.DisplayOrder.ToString())  // kendimiz bir hata kısmı ekledik isim ile DisplayOrder aynı olursa aşağıdaki hatayı dönücek view
            {
                ModelState.AddModelError("name", "The DisplayOrder cannot exactly match the Name.");

            }

            if (ModelState.IsValid)  // model de oluşturduğumuz property e göre uygun mu int int mi girili 
            {
                _db.Categories.Update(obj);
                _db.SaveChanges();
                TempData["success"] = "Category updated successfully";
                return RedirectToAction("Index");
            }
            return View(obj);
        }


        //get
        public IActionResult Delete(int? id)
        {
            if (id == null || id == null)
            {
                return NotFound();
            }
            var categoryFromDb = _db.Categories.Find(id);
            // var categoryFromDbFirst = _db.Categories.FirstOrDefault(u => u.Id == id);
            // var categoryFromDbSingle = _db.Categories.SingleOrDefault(u => u.Id == id);


            if (categoryFromDb == null)
            {
                return NotFound();
            }
            return View(categoryFromDb);
        }

        //post
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult DeletePOST(int ? id)   // neyin hatalı olduğunu göstermek için cshtml dosyasına ekleme yaptık
        {

            var obj = _db.Categories.Find(id);
            if (obj == null)
            {
                return NotFound();
            }
                _db.Categories.Remove(obj);
                _db.SaveChanges();
            TempData["success"] = "Category deleted successfully";

            return RedirectToAction("Index");
        }
    }
}
