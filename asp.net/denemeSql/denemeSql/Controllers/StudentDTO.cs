using denemeSql.Models;

namespace denemeSql.Controllers
{
    internal class StudentDTO
    {
        public int Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public List<CourseDTO>? Courses { get; set; }
    }

    public class CourseDTO
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public int AcademicianId { get; set; }
    }
}