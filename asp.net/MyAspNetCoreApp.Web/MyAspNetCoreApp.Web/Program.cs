namespace MyAspNetCoreApp.Web
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddControllersWithViews();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}"); // soru işareti olsada olur olmasa da olur demek soru işsareti parametre alıp almamak gibi  soru işareti olmazsa mecbur olacak
            // default olarak id parametresi alabiliriz  bu parametreyi  ıd adı altında oluşturabiliriz 
            // herhangi bir action belirtmezsek bize ilk sayfaya yönlendirir
            // baseUrl/home/index sayfanın görüntülenmesi sağlanır
            // baseUrl/home/privacy sayfanın görüntülenmesi sağlanır
            // sayfa ayağa kalktığında local host base url imiz   bu normalde alan adı www.mysite.com gibi bir şey dns devreye girer
            // ana sayfadan farklı bir sayfaya gitmek için
            // herhangi bir şey girilmezse default olarak index e gider   

            app.Run();
        }
    }
}
