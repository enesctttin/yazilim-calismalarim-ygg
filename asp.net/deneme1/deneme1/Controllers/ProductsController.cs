using deneme1.Models;
using Microsoft.AspNetCore.Mvc;

namespace deneme1.Controllers
{
    public class ProductsController : Controller
    {
        // veri tabanı için oluşturulmuş bir  class
        // alt enter ile ProductRepository ye link verdik model clasörüne git dedik
        private readonly ProductRepository _productRepository;
        private readonly AppDbContext _context;
        //ctor
        public ProductsController(AppDbContext context , ProductRepository productRepository)
        {   //  AppDbContext context bu nesneyi oluşturmak için böyle yazdık new kullanmadan
            //DI Container
            //dependency injection pattern var 
            _productRepository =  productRepository;

            // veri tabanına veri kayıt etme id kısmını eklemedik çünkü oto artıcak

            // veri tabanı için oluşturulmuş bir  class

            _context = context;


            if (!_context.Products.Any())
            {
                _context.Products.Add(new Product() { Name = "kalem1", Price = 200, Stock = 200 });
                _context.Products.Add(new Product() { Name = "kalem2", Price = 150, Stock = 10 });
                _context.Products.Add(new Product() { Name = "kalem3", Price = 200, Stock = 100 });
                // uygulama her ayağa kalktığında 3 tane veriyi veri tabanına üretecek bunu önlemek için if açtık

                //veri tabanına işlemesi için
                _context.SaveChanges(); // eklenen productlar ram den sql e gider db ye

            }





            // eğer web sayfasınıda silme işlemi yapılırsa veri kalmazsa durmadan bunu tekrar yazıcak  o yüzden bunu repositoye aktardık
            // eğer içi bossa data yoksa bu çalışacak

            /*
            if (!_productRepository.GetAll().Any())
            {
                _productRepository.Add(new() { Id = 1, Name = "kalem1", Price = 100, Stock = 200 });

                _productRepository.Add(new() { Id = 2, Name = "kalem2", Price = 200, Stock = 300 });

                _productRepository.Add(new() { Id = 3, Name = "kalem3", Price = 300, Stock = 400 });

            }
            */
        }
        public IActionResult Index()
        {
            // ram kullanıcaksak veri için bu 
            //var products = _productRepository.GetAll();


            // veri tabanı sql kullanacaksak bu
            var products = _context.Products.ToList();


            return View(products);

        }

        public IActionResult Remove(int id)
        {
            var product = _context.Products.Find(id);
            _context.Products.Remove(product);
            _context.SaveChanges();
            // ram için bu  _productRepository.Remove(id);
            return RedirectToAction("Index"); // yukarıdaki index e geri dön diyoruz burada 
        }



        // bunlar gizli https istekleridir
        public IActionResult Add()
        {
            return View();
        }



        // program cs içerisinde id?  kısmı var o yuzden açılan sayfada kaçıncı id ye göre açılacağını söyleyecek
        public IActionResult Update(int id)
        {
            return View();
        }
    }
}
