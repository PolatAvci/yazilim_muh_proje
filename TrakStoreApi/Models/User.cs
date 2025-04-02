using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace TrakStoreApi.Models
{
    public class User
    {   
        [Key]
        public int Id { get; set; }
        public required string Username { get; set; }

        public required string Password { get; set; }

        public required string Name { get; set; }
        public required string Surname { get; set; }
        public required string Email { get; set; }

        // Çoktan çoğa ilişki -> Bir kullanıcı birden fazla adrese sahip olabilir.
        [JsonIgnore]
        public ICollection<AddressUser> AddressUsers { get; set; }
        [JsonIgnore]
        public ICollection<UserProduct> UserProducts { get; set; }
        [JsonIgnore]
        public ICollection<UserFavItem> UserFavItems { get; set; }

    }
}
