using System.ComponentModel.DataAnnotations;

namespace denemeSql.Models
{
    public class Course
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string Title { get; set; }

        // Bire-Çok İlişkinin diğer ucu (Foreign Key ve Navigation Property)
        // Her dersin BİR akademisyeni olur.
        public int AcademicianId { get; set; }
        public Academician? Academician { get; set; }

        // Çoka-Çok İlişki (Many-to-Many)
        // Bir derste BİRDEN FAZLA öğrenci olabilir.
        public ICollection<Student>? Students { get; set; }


    }
}
