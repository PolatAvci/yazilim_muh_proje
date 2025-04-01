using Microsoft.EntityFrameworkCore;
using TrakStoreApi.Models;  // Modellerin bulunduğu namespace

public class TrakStoreDbContext : DbContext
{
    public TrakStoreDbContext(DbContextOptions<TrakStoreDbContext> options) : base(options) { }

    public DbSet<Address> Adresler { get; set; }
    public DbSet<Category> Kategoriler { get; set; }
    public DbSet<Comment> Yorumlar { get; set; }
    public DbSet<Product> Urunler { get; set; }
    public DbSet<User> Kullanicilar { get; set; }
}
