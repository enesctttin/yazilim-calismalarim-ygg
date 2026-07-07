using Microsoft.EntityFrameworkCore;

namespace deneme1.Models
{
    public class AppDbContext :DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext>options ):base(options)  // program cs içerisinde doldurucaz
        {   
        }
        public DbSet<Product>  Products { get; set; }  // db de arar bunu
        // hangi veri tabanına bağlanacak bu program cs de yapılır
    }
}
