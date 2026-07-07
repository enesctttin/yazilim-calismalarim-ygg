using System;
using System.Collections.Generic;
using System.Linq;

namespace MyAspNetCoreApp.Web.Models
{
    public class ProducttRepository
    {
        // 1. STATIK yaptık: Böylece veriler sayfa yenilendiğinde silinmez.
        private static List<Productt> _products = new List<Productt>();

        // 2. İsmi 'GetAll' yapalım ki standart olsun (veya Controller'da GetAl kullanmalısın)
        public List<Productt> GetAll() => _products;

        public void Add(Productt newProductt) => _products.Add(newProductt);

        public void Remove(int id)
        {
            var hasProduct = _products.FirstOrDefault(x => x.Id == id);

            if (hasProduct == null)
            {
                throw new Exception($"bu id({id})'ye sahip ürün bulunmamaktadır");
            }

            _products.Remove(hasProduct);
        }

        public void Update(Productt updateProduct)
        {
            var hasProduct = _products.FirstOrDefault(x => x.Id == updateProduct.Id);

            if (hasProduct == null)
            {
                throw new Exception($"bu id({updateProduct.Id})'ye sahip ürün bulunmamaktadır");
            }

            // Listedeki nesneyi güncelle
            hasProduct.Name = updateProduct.Name;
            hasProduct.Price = updateProduct.Price;
            hasProduct.Stock = updateProduct.Stock;

            var index = _products.FindIndex(x => x.Id == updateProduct.Id);
            _products[index] = hasProduct;
        }
    }
}