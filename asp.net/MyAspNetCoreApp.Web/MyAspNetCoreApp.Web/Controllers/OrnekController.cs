using Microsoft.AspNetCore.Mvc;
namespace MyAspNetCoreApp.Web.Controllers
{
    // ViewModel ile büyük veriler taşınır tablo vs doldurulacaksa
    public class Product
    {
        public int Id  { get; set; }
        public string name { get; set; }
    }


    public class OrnekController : Controller
    {
        public IActionResult Index()
        {
            // View model ile veri taşıma yukarıda bir class oluşturduk product adında
            var productlist= new List<Product>()
            {
                new Product () { Id=1, name ="kalem"},
                new Product() { Id = 2, name = "silgi" },
                new Product() { Id = 3, name = "defter" }
            };
            // ViewBag den sonra .bukısımda istediğimizi kullanabilirz
            ViewBag.name = "ASp.Net Core";  // bu bir property dir burada name değişkenine "ASp.Net Core" atadık 
            ViewBag.namee = new List<string>() { "ahmet","mehmet","hasan"} ;
            //bunun index html içerisinde gösterimi
            ViewData["age"] = 30;
            ViewData["names"] = new List<string>() { "ahmet", "mehmet", "hasan " };
            // class / struct gönderme 
            ViewBag.person = new { Id = 1, name = "ahmet", age = 23 };
            //  Bir web sayfasından farklı bir web sayfasına eleman gönderme clastan classa
            ViewBag.satır = "kıtır";   // index2 ye göndericem index2.cshtml dosyasından çekicez bunu Views altında ornek alıntda index2
            // bu gönderme işlemi için tempData tanımlanır yukarıdaki haliyle gönderemeyiz
            TempData["surname"] = "yıldiz";  // bu tanımlama ile bunu farklı classlar altında da görebiliriz
            return View(productlist); // yukarıda en son yaptığımız product gidecek
        }
        //--------------------------------------------
        // parametre tanımlama index2 () parantez içine tanımlanır bu urlde gözükür
      //  public IActionResult Index2(int id)
        //{
//             return RedirectToAction("Index", "Ornek");
  //       }
        // program.cs içinde   pattern: "{controller=Home}/{action=Index}/{id?}");  burada id yerine abc kullanırsak parametreyi abc olarak tanımlamalıyız
       

        // bu sayfaya gideceğiz ardından bu sayfayla yönlendirme ile json sayfasına gidezeğiz 
        // parametreview şuan bir alt dizin oldu ornek /parametreview/100 yazınca   olarak bir web sayfayı 
        public IActionResult ParametreView(int id)
        {
            return  RedirectToAction("JsonResultParametre","Ornek",new {id=id});
        }

        public IActionResult JsonResultParametre(int id)
        {
            return Json(new { Id = id });// web sayfasında 100 yazılır yukarı son satır bos kısım 
        }






        //-----------------------------------------
        // RedirectionActionMethod
        public IActionResult Index2()
        {
            //Ornek/index2 adında bir sayfa oluşturuk 


            // return View();
            // virgül atıpp farklı bir controllera yollarız yazmayada biliriz
            return RedirectToAction("Index","Ornek");
            // bunu yazdıktan sonra oluşturulan sayfanın hiçbir anlamı yok  views altından index2 silinebilir
            // url ye index2 ye git dediğimiz zaman bizi index sayfasına gönderir 
            // bunu kullanıcıdan data aldıktan sonra kullanabiliriz veri tabanına bilgi kayıt edilier sonra yeni sayfaya yönlendiririz

            // tempdata ile index birdeki tanımlmayı buraya çektik
            var surName = TempData["surname"];

        }





        public IActionResult ContentResult()
        {
            return Content("ContentResult yazısı dönecek bu yazi");
                // bunun bir sayfası olmasına gerek yok  

            //  pattern: "{controller=Home}/{action=Index}/{id?}"); yazılır 
             //   ve http://localhost:5026/ornek/contentresult yazılunca bizi string dönen bir web sitesine götürür  sitesine gidebiliriz

        }

        public IActionResult JsonResult()
        {
            return Json(new { Id = 1, name = "Kalem", price = 100 });
            // {"id":1,"name":"Kalem","price":100} döndürecek
        }

        // empty result ise içeriği boş olan bir sayfa döndürür
        public IActionResult EmptyResult()
        {
            return new EmptyResult();
            // {"id":1,"name":"Kalem","price":100} döndürecek
        }




    }
}
