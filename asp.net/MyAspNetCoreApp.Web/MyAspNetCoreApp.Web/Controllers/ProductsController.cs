using Microsoft.AspNetCore.Mvc;
using MyAspNetCoreApp.Web.Models;
using System.Linq;

namespace MyAspNetCoreApp.Web.Controllers
{
    // Route sınıfın en üstünde olmalı!
    [Route("Products")]
    public class ProductsController : Controller
    {
        private readonly ProducttRepository producttRepository;

        // Constructor üzerine [Route] gelmez!
        public ProductsController()
        {
            producttRepository = new ProducttRepository();

            if (!producttRepository.GetAll().Any())
            {
                producttRepository.Add(new() { Id = 1, Name = "kalem 1", Price = 100, Stock = 200 });
                producttRepository.Add(new() { Id = 2, Name = "kalem 2", Price = 200, Stock = 100 });
                producttRepository.Add(new() { Id = 3, Name = "kalem 3", Price = 300, Stock = 400 });
            }
        }

        // Buradaki Route, "Products/Index" adresini oluşturur
        [Route("Index")]
        public IActionResult Index()
        {
            var products = producttRepository.GetAll();

            // Eğer hala bulamazsa yolu açıkça gösteriyoruz:
            return View("~/Views/Products/Index.cshtml", products);
        }
    }
}