using System;

namespace sabah
{
    class Program
    {
        static void Main(string[] args)
        {/*
            Console.WriteLine("Hello, World!");

            // Kullanıcıdan sayı alma işlemi
            Console.Write("Bir sayı giriniz: ");
            int i = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Girdiğiniz sayı: " + i);

            // B sınıfından nesne üretme
            B b = new B();
            b.X(); // A sınıfından miras alınan metodu çağırabiliriz

            C c = new C();

            erkek e = new erkek();
            kadin k = new kadin();

            e.Adi = "ahmet";
            e.sakal = "kirli";

            k.Adi = "ayse";
            k.makyaj = "var";

            Console.WriteLine($"{e.Adi} adlı kişinin sakal tipi: {e.sakal}");
            Console.WriteLine($"{k.Adi} adlı kisi nin makyaji {k.makyaj}");

              */

            Myclass myclass = new Myclass();

            // get bloğu tetiklenir
            Console.WriteLine(myclass.Yasi);

            // set kısmı tetiklenir
            myclass.Yasi = 56;

            // set ile değer değişir 
            Console.WriteLine(myclass.Yasi);

            // constructor 
            // class içindeki constructor direkt çalışacak
            new consttttructor();
            // constructor içindekiler çalışır 

            // U bir metot  Parantez koyman gerekiyor

            new consttttructor().U();

            new consttttructor();

        }
    }
    /*
    class A
    {
        // Özellikler ve alanlar (fields) sınıf seviyesinde tanımlanır
        public int y { get; set; }
        public bool z;

        public void X()
        {
            Console.WriteLine("A sınıfındaki X metodu çalıştı.");
        }
    }

    // B sınıfı A sınıfından kalıtım aldı
    class B : A
    {
        // B sınıfı şu an A'nın sahip olduğu y, z ve X() üyelerine sahip.l
    }
    class C : B
    {

    }

    class Insan
    {
        public string Adi { get; set; }

        public string SoyAdi { get; set; }

        public string Meslegi { get; set; }
    }

    class erkek : Insan
    {
        public string sakal { get; set; }


    }

    class kadin :Insan
    {
        public string makyaj { get; set; }
    }

    */


    class Myclass
    {


        int yasi;
        string b;

        //property 

        public int Yasi
        {

            get
            {
                return yasi;
            }
            // return ün döndürdüğü  value değerine yazar 
            set { yasi = value; }


        }

    }

    class consttttructor
    {

        public consttttructor ()
        {
            Console.WriteLine("bir adet consttttructor nesnesi oluşturulmuştur ");

        }

        public void U()
        {

        }

        

    }



}