using TrakStoreApi.Models;

namespace TrakStoreApi.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int CategoryId { get; set; }
        public Category Category { get; set; }  // Navigation Property to Category
    }
}
