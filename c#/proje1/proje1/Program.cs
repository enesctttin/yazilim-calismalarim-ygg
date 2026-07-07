namespace proje1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("1, World!");
            Console.WriteLine("2, World!");
            Console.WriteLine("3, World!");
            Console.WriteLine("4, World!");
            
            giris i = new giris();

            i.Deger=Convert.ToInt32(Console.ReadLine());


            Console.WriteLine("sonuc :" + i.Sonuc);


            giris e = new giris();

            int k;
            k=e.X(5);

            Console.WriteLine(k);
        }
    }




    class giris
    {

        int deger;

        public int Deger
        {
            get { return deger; } set { deger = value; }

        }

        public int Sonuc
        {
            get {
                switch (deger)
                {
                    case 1: return 1;
                        case 2: return 2;
                        case 3: return 3;
                        case 4: return 4;
                    default:
                        Console.WriteLine("gerecsiz secim");
                        return 0;
                }
                   
            }
        }

        public int X(int a)
        {


            return a*a;
        }



    }
}
 