using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace TrakStoreApi.Models
{
    public class Comment
    {   
        [Key]
        public int Id { get; set; }
        public required DateTime Date { get; set; }
        public required string Text { get; set; }
        public required int Star { get; set; } 

        // Çoktan çoğa ilişki -> Bir yorum birden fazla ürünle ilişkilendirilebilir.
        [JsonIgnore]
        public ICollection<CommentProduct> CommentProducts { get; set; }
    }
}
