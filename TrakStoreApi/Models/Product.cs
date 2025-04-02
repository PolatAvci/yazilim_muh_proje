using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace TrakStoreApi.Models
{
    public class Product
    {
        [Key]
        public int Id { get; set; }
        public required string Name { get; set; }
        public decimal Price { get; set; }
        public string Details { get; set; }
        public string image { get; set; }

        // Çoktan çoğa ilişkiyi sağlayacak
        [JsonIgnore]
        public ICollection<ProductCategory> ProductCategories { get; set; }  // Navigation Property to ProductCategory
        [JsonIgnore]
        public ICollection<CommentProduct> CommentProducts { get; set; }  // Navigation Property to CommentProduct
        [JsonIgnore]
        public ICollection<UserProduct> UserProducts { get; set; }
        [JsonIgnore]
        public ICollection<UserFavItem> UserFavItems { get; set; }
    }
}

