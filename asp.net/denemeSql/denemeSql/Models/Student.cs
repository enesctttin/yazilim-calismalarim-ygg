using System.ComponentModel.DataAnnotations;

namespace denemeSql.Models
{
    public class Student
    {
        [Key]
        public int Id { get; set; }

        [Required]  // null değer alamaz
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        // Çoka-Çok İlişki (Many-to-Many)
        // Bir öğrenci BİRDEN FAZLA ders alabilir.
        public ICollection<Course>? Courses { get; set; }
        //public IEnumerable<Course>? Courses2 { get; set; }
        //public List<Course>? Courses3 { get; set; }




    }
}
