namespace deneme1.Models
{
    public class ProductRepository
    {
        // listeleme tutacak list sınıfı oluşturduk   statick memory de olucak 

        // ilk yüklenmede datayı verecek
        // static yenileme yaptığı anda yeniden verecek datayı 
        private static List<Product> _products = new List<Product>()
        {
               new() { Id = 1, Name = "kalem1", Price = 100, Stock = 200 },
               new() { Id = 2, Name = "kalem2", Price = 200, Stock = 300 },
               new() { Id = 3, Name = "kalem3", Price = 300, Stock = 400 },
               };
        //asağıda tanıdığımız methodlarla dışarıdan erişim e açık olucak
        public List<Product> GetAll() => _products;
        public void Add(Product newProduct) => _products.Add(newProduct);
        public void Remove(int id)
        {
            var hasProduct = _products.FirstOrDefault(x => x.Id == id);
            if(hasProduct == null)
            {
                throw new Exception($"Bu id({id})'ye sahip ürün yok");
            }
            _products.Remove(hasProduct);
        }
        public void Update(Product updateProudct)
        {
            var hasProduct = _products.FirstOrDefault(x =>x.Id== updateProudct.Id);
            if (hasProduct == null)
            {
                throw new Exception($"Bu id({updateProudct.Id})'ye sahip ürün yok");
            }
            hasProduct.Name = updateProudct.Name;
            hasProduct.Price = updateProudct.Price;
            hasProduct.Stock = updateProudct.Stock;
            var index= _products.FindIndex(x=>x.Id==updateProudct.Id);
            _products[index]=hasProduct;
        }
    }
}
