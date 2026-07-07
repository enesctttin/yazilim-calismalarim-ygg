using System.ComponentModel.DataAnnotations;

namespace denemeSql.Models
{
    public class Academician
    {

        [Key] // Primary Key 
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        // Gezinme Özelliği (Navigation Property)
        // Bir akademisyenin BİRDEN FAZLA dersi olabilir (One-to-Many)
        public ICollection<Course>? Courses { get; set; }


    }
}
