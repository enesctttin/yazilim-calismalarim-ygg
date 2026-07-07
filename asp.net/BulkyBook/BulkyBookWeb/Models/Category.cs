using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BulkyBookWeb.Models
{
    public class Category
    {

        [Key]  //primary key sql table dan hatırla
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }
        [DisplayName("DisplayOrder")]
        [Range(1,100,ErrorMessage = "Display Order mut be between 1 and 100 only !!")]
        public int DisplayOrder { get; set; }

        public DateTime CreatedDate { get; set; }   = DateTime.Now;



    }

}
