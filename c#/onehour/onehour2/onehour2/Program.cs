
ornek o = new ornek();
o.x = "asd"; 
Console.WriteLine(o.x);

ooornek oooo = new ooornek();
oooo.Adi = "asdsadsas"; 
// Property'nin set bloğunda yazdığın ToUpper() sayesinde veri "ASDSADSAS" olarak kaydedildi.
// get bloğu da bize bu büyük harfli versiyonu döndürecek:
Console.WriteLine(oooo.Adi);


// 2. SINIF TANIMLAMALARI EN ALTTA OLMALI
class ornek
{
    // Bu bir Field (Alan). Kontrolsüzdür, herkes istediği gibi veri atayabilir.
    public string x;
}

class ooornek
{
    // Dışarıdan doğrudan erişime kapalı olan Field (varsayılan olarak private'tır)
    string adi;

    // Sınıf içerisindeki field'ları dışarı kontrollü bir şekilde açmamızı sağlayan Property
    public string Adi
    {
        get
        {
            // Hangi veri gönderilecek?
            return adi;
        }
        set
        {
            // Dışarıdan gönderilen veri "value" anahtar sözcüğü ile yakalanır.
            // Burada veriyi alıp tamamen büyük harfe çevirerek field'a (adi) atıyoruz.
            adi = value.ToUpper();
        }
    }
}



// Constructur
// public yeniornek kısmı metodu çağırır
yeniornek yen = new yeniornek();


class yeniornek 
{
    // Constructor metod public olmalı 
    // constructor metod geri dönüş değeri olmaz
    // Constructor methoddun ismi sınıf ismi ile aynı olmak zorundadır,
   
    // method oluşturma 

    public int x { get;set; }

    public yeniornek()
    {
        x = 15;

    }
    // constructor overload edilebilir.
}
