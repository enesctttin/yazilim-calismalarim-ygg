using Microsoft.AspNetCore.Mvc;

namespace MyAspNetCoreApp.Web.Controllers
{
    public class ExampleController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }



        public IActionResult NoLayout()
        {
            // bunu ise sağ tık add view  seçeneklerden use a layout kaldırılır  veya onun alt satırındaki 3 noktaya basılarak istediğimiz layout u kullanırız
            // eğer  layout hiç kullanılmayacaksa html kodunun istinde @{         }  açılan kısıma Layout=null; yapılır 
            return View();
        }




    }
}
