using System;
using System.Collections;

class Program
{
    static ArrayList tel_book_arr = new ArrayList();

    static void Main(string[] args)
    {
        int sel = 0;

        while (sel != 6)
        {
            Console.Clear();
            Console.WriteLine("1 : enter information");
            Console.WriteLine("2 : display information");
            Console.WriteLine("3 : search information");
            Console.WriteLine("4 : edit information");
            Console.WriteLine("5 : delete information");
            Console.WriteLine("6 : exit");

            Console.Write("\nenter your choice : ");
            sel = Convert.ToInt32(Console.ReadLine());

            switch (sel)
            {
                case 1:
                    enter_info();
                    break;
                case 2:
                    show_info();
                    break;
                case 3:
                    search_ifo();
                    break;
                case 4:
                    edit_info();
                    break;
                case 5:
                    delet_ifo();
                    break;
            }
        }
    }

    static void enter_info()
    {
        Console.Clear();

        telephone t = new telephone();

        Console.Write("enter name : ");
        t.name = Console.ReadLine();

        Console.Write("enter family : ");
        t.family = Console.ReadLine();

        Console.Write("enter tel : ");
        t.tel = Console.ReadLine();

        tel_book_arr.Add(t);

        Console.WriteLine("\nSaved!");
        Console.ReadKey();
    }

    static void show_info()
    {
        Console.Clear();

        if (tel_book_arr.Count == 0)
        {
            Console.WriteLine("Phone book is empty.");
        }
        else
        {
            foreach (object obj in tel_book_arr)
            {
                telephone temp = (telephone)obj;   // CAST

                Console.WriteLine("name : " + temp.name);
                Console.WriteLine("family : " + temp.family);
                Console.WriteLine("tel : " + temp.tel);
                Console.WriteLine("-----------------------");
            }
        }

        Console.ReadKey();
    }

    static void search_ifo()
    {
        Console.Clear();

        Console.Write("enter name to search : ");
        string name = Console.ReadLine();

        foreach (object obj in tel_book_arr)
        {
            telephone temp = (telephone)obj;   // CAST

            if (temp.name == name)
            {
                Console.WriteLine("\nFound!");
                Console.WriteLine("name : " + temp.name);
                Console.WriteLine("family : " + temp.family);
                Console.WriteLine("tel : " + temp.tel);
                Console.ReadKey();
                return;
            }
        }

        Console.WriteLine("\nNot found!");
        Console.ReadKey();
    }

    static void edit_info()
    {
        Console.Clear();

        Console.Write("enter name to edit : ");
        string name = Console.ReadLine();

        foreach (object obj in tel_book_arr)
        {
            telephone temp = (telephone)obj;   // CAST

            if (temp.name == name)
            {
                Console.Write("new name : ");
                temp.name = Console.ReadLine();

                Console.Write("new family : ");
                temp.family = Console.ReadLine();

                Console.Write("new tel : ");
                temp.tel = Console.ReadLine();

                Console.WriteLine("\nUpdated!");
                Console.ReadKey();
                return;
            }
        }

        Console.WriteLine("\nNot found!");
        Console.ReadKey();
    }

    static void delet_ifo()
    {
        Console.Clear();

        Console.Write("enter name to delete : ");
        string name = Console.ReadLine();

        for (int i = 0; i < tel_book_arr.Count; i++)
        {
            telephone temp = (telephone)tel_book_arr[i];   // CAST

            if (temp.name == name)
            {
                tel_book_arr.RemoveAt(i);
                Console.WriteLine("\nDeleted!");
                Console.ReadKey();
                return;
            }
        }

        Console.WriteLine("\nNot found!");
        Console.ReadKey();
    }
}

class telephone
{
    public string name;
    public string family;
    public string tel;
}






using System;
using System.Collections;

class Program
{
    static ArrayList tel_book_arr = new ArrayList();

    static void Main(string[] args)
    {
        int sel = 0;

        while (sel != 5)
        {
            Console.Clear();
            Console.WriteLine("1- Add Contact");
            Console.WriteLine("2- List All (Alphabetic)");
            Console.WriteLine("3- Search (Name/Family Contains)");
            Console.WriteLine("4- Search By Phone");
            Console.WriteLine("5- Exit");

            Console.Write("Choice: ");
            int.TryParse(Console.ReadLine(), out sel);

            switch (sel)
            {
                case 1: Add(); break;
                case 2: ListAll(); break;
                case 3: Search(); break;
                case 4: SearchByPhone(); break;
            }
        }
    }

    static void Add()
    {
        Console.Clear();

        Console.Write("Name: ");
        string name = Console.ReadLine();
        if (!IsOnlyLetters(name)) { Error("Name must contain only letters"); return; }

        Console.Write("Family: ");
        string family = Console.ReadLine();
        if (!IsOnlyLetters(family)) { Error("Family must contain only letters"); return; }

        Console.Write("Phone: ");
        string tel = Console.ReadLine();
        if (!IsOnlyDigits(tel)) { Error("Phone must contain only digits"); return; }

        foreach (object obj in tel_book_arr)
        {
            telephone t = (telephone)obj;

            if (t.name == name && t.family == family)
            {
                Console.Write("Person exists. Overwrite? (y/n): ");
                if (Console.ReadLine().ToLower() == "y")
                    t.tel = tel;

                return;
            }
        }

        telephone newTel = new telephone();
        newTel.name = name;
        newTel.family = family;
        newTel.tel = tel;

        tel_book_arr.Add(newTel);
    }

    static void ListAll()
    {
        Console.Clear();

        tel_book_arr.Sort();

        if (tel_book_arr.Count == 0)
        {
            Console.WriteLine("No contacts.");
        }
        else
        {
            foreach (object obj in tel_book_arr)
            {
                telephone t = (telephone)obj;
                Console.WriteLine(t.name + " " + t.family + " - " + t.tel);
            }
        }

        Console.ReadKey();
    }

    static void Search()
    {
        Console.Clear();
        Console.Write("Search text: ");
        string text = Console.ReadLine().ToLower();
        bool found = false;

        foreach (object obj in tel_book_arr)
        {
            telephone t = (telephone)obj;

            if (t.name.ToLower().Contains(text) ||
                t.family.ToLower().Contains(text))
            {
                Console.WriteLine(t.name + " " + t.family + " - " + t.tel);
                found = true;
            }
        }

        if (!found)
            Console.WriteLine("No result found.");

        Console.ReadKey();
    }

    static void SearchByPhone()
    {
        Console.Clear();
        Console.Write("Phone search: ");
        string tel = Console.ReadLine();
        bool found = false;

        foreach (object obj in tel_book_arr)
        {
            telephone t = (telephone)obj;

            if (t.tel.Contains(tel))
            {
                Console.WriteLine(t.name + " " + t.family + " - " + t.tel);
                found = true;
            }
        }

        if (!found)
            Console.WriteLine("No result found.");

        Console.ReadKey();
    }

    static bool IsOnlyLetters(string input)
    {
        foreach (char c in input)
            if (!char.IsLetter(c))
                return false;
        return true;
    }

    static bool IsOnlyDigits(string input)
    {
        foreach (char c in input)
            if (!char.IsDigit(c))
                return false;
        return true;
    }

    static void Error(string msg)
    {
        Console.WriteLine(msg);
        Console.ReadKey();
    }
}

class telephone : IComparable
{
    public string name;
    public string family;
    public string tel;

    public int CompareTo(object obj)
    {
        telephone other = (telephone)obj;
        return (this.name + this.family)
            .CompareTo(other.name + other.family);
    }
} 
*/