// See https://aka.ms/new-console-template for more information
/*
Console.WriteLine("Hello, World!");
Console.WriteLine("enes");  

int x = 5;

double y = 18.76;

string s = "ahmet"; 

bool u=true;

const double pi= 3.14;  // const veri tipi değiştirilemez   C#’ta const tanımlarken veri tipi yazmak zorundasın.

x = 10;  // x 5 idi 10 ile güncellendi

Console.WriteLine(" adim " + s);


// kullanıcıdan veri alma
Console.Write("İsminizi giriniz: ");
string isim = Console.ReadLine();

Console.WriteLine("Merhaba " + isim);

Console.WriteLine("en sevdigin renk");

string renk;

renk=Console.ReadLine();
Console.WriteLine(isim + " " + "  en sevdigi renk" + renk);

int yas;

Console.WriteLine("yasını gir");

// console.ReadLine sadece string deger döner alınan veriyi string olarak kayıt eder
// bu yüzden tür dönüştürücü convert kullanırız
// yas int tanımlandığı için  convert.----   --ksıımı int olmalı double double
yas =Convert.ToInt32(Console.ReadLine());

Console.WriteLine(isim + " yası bu " + yas);

int sayi = 48;

string yenisayi = Convert.ToString(sayi);


// mat işlemleri
// c dilindekiler ile aynı

int l = 7;
int o = 3;
Console.WriteLine(x+y);


*/

/*
Console.WriteLine("ilk sayi girin");
int sayi1 = Convert.ToInt32(Console.ReadLine());



Console.WriteLine("ikinci sayi girin");
int sayi2 = Convert.ToInt32(Console.ReadLine());

Console.WriteLine("kalan = " +sayi1%sayi2 );


// math kutuphanei

Console.Write(Math.Pow(2, 4));

*/
/*
// C dili ile aynı !=  && ||
bool resit_mi=true;

if (resit_mi==true)
{
    Console.WriteLine("siteye hos geldin");

}
else if
{

    Console.WriteLine("gule gule");
}
else
{


}  

for(int i = 0; i < 10; i++) {
    Console.WriteLine("merhaba" +i);   

}


*/

using System.Collections;

int k = 5;
// bool veri tipi döner "
Console.WriteLine(typeof(int).IsPrimitive);

// @ region değişken isimlerini @ operatörüyle tanımlama   math kutuphane mesela  @ işsareti ile math ezilir  @math  bu değişkene atama yapılabilir
// assign atama operatörüdür     =   sağ tarafta verilen  değeri soldaki değişkene, field ,property vs. atar

//  "string"  ,  'char'  tanımlamada kullanılan tırnak işsaretleri



//  const degisken_tipi  degisken adi  ;       const    sabittir değiştirilemez

const double pi = 3.14;
const double pi2 = Math.PI;

// Bir değişken class scope ( {   } )   içerisinde tanımlanıyorsa buna global değişken diyoruz 

// diziler 


// type[] isim=new type[ adet]

// int[] yaslar = new int[5]


int[] yaslar =new int[3];  // eleman sayısı zorunlu girilmeli

for(int i = 0; i < 3; i++)
{

    yaslar[i] = i * i;

}
Console.WriteLine(yaslar[2]);

string[]personeller = new string[3];

personeller[0] = "ali";
personeller[1] = "mehmet";  
Console.WriteLine(personeller[0]);

// alternatif dizi tanımlama 

int[] dizi22 = {1, 2, 3,4};

var sayilarrrr= new[] {3 , 5 ,8 ,7  ,9 ,10};


// 1. Dizi Tanımlama
Array diziii = new int[3];

// 2. Değer Atama (Değer, İndeks) -> Dikkat: 30.0 değil, 30 yazdık.
diziii.SetValue(30, 0); // 0. kutuya 30 koy
diziii.SetValue(30, 1); // 1. kutuya 30 koy
diziii.SetValue(30, 2); // 2. kutuya 30 koy

// 3. Değer Okuma (İsim düzeltildi: dizi22 -> diziii)
object value = diziii.GetValue(1);

// 4. Ekrana Yazdırma (Console büyük harf)
Console.WriteLine(value);

// Daha temiz ve standart kullanım:
int[] sayilar = new int[3]; // int dizisi

// Değer Atama
sayilar[0] = 30;
sayilar[1] = 30;
sayilar[2] = 30;

// Değer Okuma
int deger = sayilar[1];

Console.WriteLine(deger);

// string ifadeleri birleştirme

string a = "merhaba", b = "dünya";

Console.WriteLine (a+b);




//  for each


// foreach( type variable  in  collection  ) {           }

ArrayList sayiiilar =new ArrayList {123 ,123 ,324,5,844,964 };

foreach(object item in sayiiilar)
{

  //  sayiiilar.Add(123123);  bu collection bozduğu için iterasyon patlar çalışmaz

    Console.WriteLine(item);


}

// Math sınıfı

int l = Math.Abs(-5);

double yy= Math.Ceiling(3.14);

Console.WriteLine(DateTime.Now);

// Random 

Random random = new Random();

Console.WriteLine(random.Next(50, 100));

// random.NextDouble() ile rastgele  0 - 1 aralığında değer oluşturur
Console.WriteLine(random.NextDouble());

// method fonksiyondur 

// [erişim belirleyici] [geri dönüş değeri] [method adi]( parametreler       ) {                      }

 

private void method1()
{
    Console.WriteLine("hello world");
}

public char method2()
{

    return 'A';
    // return tetiklendiği yerde  fonksiyondan/ methoddan o satırda çıkılır 
}
Topla(3,5);

// main içinde tanımlanan methodların  çalışabilmesi için static tanımlanmalıdır 
static public int Topla(int a, int b)
{
    Console.WriteLine (a+b);
    return   a+b;
}  



