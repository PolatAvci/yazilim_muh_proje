using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace TrakStoreApi.Models
{
    public class Address
    {   
        [Key]
        public int Id { get; set; }
        public required string AddressInfo { get; set; }
        public required string City { get; set; }

        // Çoktan çoğa ilişki -> Bir adres birden fazla kullanıcıya ait olabilir.
        [JsonIgnore] //Döngüyü engellemek için
        public ICollection<AddressUser> AddressUsers { get; set; }
    }
}
