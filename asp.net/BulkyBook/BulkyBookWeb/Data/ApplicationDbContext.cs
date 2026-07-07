using BulkyBookWeb.Models;
using Microsoft.EntityFrameworkCore;

namespace BulkyBookWeb.Data
{
    public class ApplicationDbContext : DbContext
    {
        //ctor
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext>options) : base (options)
        {
            

        }

        public DbSet<Category> Categories { get; set; }  // table name  Category modeldeki dosyamızın adı 

    }
}
