using Microsoft.EntityFrameworkCore;
using TrakStoreApi.Models; // Model sınıfınızı eklemeniz gerekebilir

namespace TrakStoreApi.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options) { }

        // Burada veritabanı tablolarınızın DbSet'lerini tanımlayacaksınız
        public DbSet<Product> Products { get; set; }
        // Diğer modellerinizin DbSet'lerini ekleyin
    }
}
