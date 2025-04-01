using TrakStoreApi.Models;

namespace TrakStoreApi.Models
{
    public class Comment
    {
        public int Id { get; set; }
        public string Content { get; set; }
        public int ProductId { get; set; }
        public Product Product { get; set; }  // Navigation Property to Product
    }
}
