
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace TrakStoreApi.Models
{
    public class Category
    {   
        [Key]
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string Image { get; set; }

        // Çoktan çoğa ilişkiyi sağlayacak
        [JsonIgnore]
        public ICollection<ProductCategory> ProductCategories { get; set; }  // Navigation Property to ProductCategory
    }
}
