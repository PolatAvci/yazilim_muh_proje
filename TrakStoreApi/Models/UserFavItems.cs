using System.ComponentModel.DataAnnotations;

namespace TrakStoreApi.Models
{
    public class UserFavItem
    {
        // Kullanıcı ID (Foreign Key)
        public int UserId { get; set; }
        public User User { get; set; }

        // Ürün ID (Foreign Key)
        public int ProductId { get; set; }
        public Product Product { get; set; }
    }
}
