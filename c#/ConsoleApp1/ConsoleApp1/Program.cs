List<ContactInfo> contactList = new List<ContactInfo>();
Console.WriteLine("------WELLCOME------");

mainMenu();
void mainMenu()
{
    Console.WriteLine("\nSelect one of the following:");
    Console.WriteLine("1. Add a contact");
    Console.WriteLine("2. List contacts");
    Console.WriteLine("3. Search a contact");
    Console.WriteLine("4. Exit\n");
    int command = Convert.ToInt32(Console.ReadLine());

    switch (command)
    {
        case 1:
            addContact();
            break;
        case 2:
            listContacts();
            break;
        case 3:
            searchContact();
            break;
        case 4:
            Console.WriteLine("\nExiting the program");
            return;
        default:
            Console.WriteLine("\nInvalid Option! Please type 1, 2, 3 or 4.");
            break;
    }

    mainMenu();

}

void addContact()
{
    ContactInfo newContact = new ContactInfo();

    while (true)
    {
        Console.Write("\nFirst Name: ");
        newContact.fname = Console.ReadLine();

        Console.Write("Last Name: ");
        newContact.lname = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(newContact.fname) || !newContact.fname.All(char.IsLetter) || string.IsNullOrWhiteSpace(newContact.lname) || !newContact.lname.All(char.IsLetter))
        {
            Console.WriteLine("First and last names should only contain letters and cannot be empty. Please try again.");
            continue;
        }
        Console.Write("Phone Number: +");
        newContact.phone = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(newContact.phone) || !newContact.phone.All(char.IsDigit))
        {
            Console.WriteLine("Phone number should only contain digits and cannot be empty. Please try again.");
            continue;
        }
        break;
    }

    foreach (var contact in contactList)
    {
        if (contact.fname.ToLower() == newContact.fname.ToLower() && contact.lname.ToLower() == newContact.lname.ToLower())
        {
            Console.WriteLine("There already is an existing record for this person. If you want to override current information type \"yes\".");
            Console.WriteLine("If you do not want to override current information type anything other than yes.");
            var response = Console.ReadLine();
            if (response.ToLower() == "yes")
            {
                contact.phone = newContact.phone;
                Console.WriteLine("Information has been successfully updated.");
                return;
            }
            else
            {
                Console.WriteLine("The process has been terminated");
                return;
            }
        }
    }

    contactList.Add(new ContactInfo(newContact.fname, newContact.lname, newContact.phone));
    Console.WriteLine("New person has successfully been added.");
}

void listContacts()
{
    if (contactList.Count == 0)
    {
        Console.WriteLine("\nNo contacts to display.");
        return;
    }

    Console.WriteLine("\nHere is the list of all contacts in alphabetical order:");
    var sortedContacts = contactList.OrderBy(c => c.fname).ThenBy(c => c.lname).ToList();
    foreach (var contact in sortedContacts)
    {
        Console.WriteLine(contact);
    }
}
void searchContact()
{
    Console.Write("\nEnter a name or phone number: ");
    string search = Console.ReadLine().ToLower();
    Console.WriteLine("\n------Search Results------");

    List<ContactInfo> foundContacts = new List<ContactInfo>();

    if (string.IsNullOrWhiteSpace(search))
    {
        foundContacts = contactList;
    }
    else
    {
        foreach (var contact in contactList)
        {
            if (contact.fname.ToLower().Contains(search) || contact.lname.ToLower().Contains(search) || contact.phone.Contains(search))
            {
                foundContacts.Add(contact);
            }
        }
    }

    if (foundContacts.Count == 0)
    {
        Console.WriteLine("No contacts found.");
    }
    else
    {
        foreach (var contact in foundContacts)
        {
            Console.WriteLine(contact);
        }
        Console.WriteLine();
    }
}

class ContactInfo
{
    public string fname { get; set; } = string.Empty;
    public string lname { get; set; } = string.Empty;
    public string phone { get; set; } = string.Empty;

    public ContactInfo() { }

    public ContactInfo(string fname, string lname, string phone)
    {
        this.fname = fname;
        this.lname = lname;
        this.phone = phone;
    }
    public override string ToString()
    {
        return $"Name: {char.ToUpper(fname[0]) + fname.Substring(1).ToLower()} {char.ToUpper(lname[0]) + lname.Substring(1).ToLower()}\t Phone: +{phone}";
    }

}