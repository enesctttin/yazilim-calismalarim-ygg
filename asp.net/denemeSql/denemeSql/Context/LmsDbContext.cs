using denemeSql.Models;
using denemeSql.Models; // Modellerimizin olduğu klasörü içeri aktarıyoruz 
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;
namespace denemeSql.Context
{
    // Sınıfımızın EF Core'un özelliklerini kazanması için DbContext'ten miras alması (inherit) ŞARTTIR.
    public class LmsDbContext : DbContext
    {
        // Constructor (Yapıcı Metot): 
        // İleride Program.cs'den göndereceğimiz veritabanı bağlantı ayarlarını (Options) içeriye almak için gereklidir.
        public LmsDbContext(DbContextOptions<LmsDbContext> options) : base(options)
        {
        }

        // Veritabanında oluşacak TABLOLARIMIZ (DbSet'ler)
        // İsimlerini çoğul (s takısı ile) yaparız çünkü içlerinde birden fazla kayıt tutacaklar.
        public DbSet<Academician> Academicians { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Student> Students { get; set; }
    }
}



//: DbContext: Bu ifade çok kritiktir. Kendi oluşturduğumuz sıradan bir C# sınıfına "Sen artık veritabanı yöneticisisin" yetkisini verdik. (Bunun çalışması için sayfanın en üstüne using Microsoft.EntityFrameworkCore; eklememiz gerekir, aksi takdirde altı kırmızı çizer).

//Constructor (Yapıcı Metot): Bir sonraki adımda yazacağımız bağlantı adresi (Connection String), işte tam bu metot sayesinde köprüden geçip DbContext'in içine girecek.

//DbSet<...>: Modellerinizi DbSet içine aldığınız anda EF Core şunu anlar: "Tamam, ben SQL'e gittiğimde Academicians, Courses ve Students adında 3 tane tablo oluşturacağım." Sınıf isimleri tekil(Student), tablo isimleri çoğul (Students) olur.



//1. public LmsDbContext(...) (Yapıcı Metot - Constructor):
//Bu, C# dilinde bir sınıftan yeni bir nesne üretildiğinde ilk çalışan metottur. Uygulamanız ayağa kalktığında, EF Core bu sınıfı çalıştıracak.

//2. DbContextOptions<LmsDbContext> options (Kargo Paketi):
//Parantez içindeki bu kısım, dışarıdan (birazdan Program.cs dosyasından) gelecek olan bir pakettir. Bu paketin (options) içinde şunlar yazar:

//"Ben bir SQL Server veritabanıyım."

//"Sunucu adım şu, şifrem bu, veritabanımın adı NinovaDB olacak."(Yani Connection String)
//Eğer bu parametre olmasaydı, LmsDbContext sınıfımız dünyadaki hangi veritabanına bağlanacağını asla bilemezdi.

//3. : base(options)(Kargoyu Asıl Patron'a İletmek):
//Burası işin sihri.Hatırlarsanız sınıfımızı tanımlarken: DbContext yazarak Microsoft'un yazdığı ana sınıftan miras almıştık (inherit etmiştik).
//İşte: base(options) diyerek şunu yapıyoruz: "Bana dışarıdan gelen bu bağlantı ayarları paketini (options), miras aldığım asıl patrona (base, yani DbContext sınıfına) aynen iletiyorum. Veritabanına bağlanma işinin ağır ameleliğini o patron halletsin."

//Özetle:
//Biz birazdan Program.cs dosyasında veritabanı şifremizi ve adresimizi yazacağız.Uygulama çalıştığında o adres bilgileri bir paket halinde(options) bu metoda gelecek ve buradan da EF Core'un derinliklerine (base) iletilerek SQL bağlantısı kurulacak.

