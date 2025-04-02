using Microsoft.EntityFrameworkCore;
using TrakStoreApi;
using TrakStoreApi.Models;  // Modellerin bulunduğu namespace

public class TrakStoreDbContext : DbContext
{
    public TrakStoreDbContext(DbContextOptions<TrakStoreDbContext> options) : base(options) { }

    public DbSet<Address> Addresses { get; set; }
    public DbSet<Category> Categories { get; set; }
    public DbSet<Comment> Comments { get; set; }
    public DbSet<Product> Products { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<AddressUser> AddressUsers { get; set; }
    public DbSet<CommentProduct> CommentProducts { get; set; }
    public DbSet<ProductCategory> ProductCategories { get; set; }
    public DbSet<UserFavItem> UserFavItems { get; set; }
    public DbSet<UserProduct> UserProducts { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder){
        // ProductCategory için çoktan çoğa ilişkiyi tanımla
            modelBuilder.Entity<ProductCategory>()
                .HasKey(pc => new { pc.ProductId, pc.CategoryId }); // Composite Key

            modelBuilder.Entity<ProductCategory>()
                .HasOne(pc => pc.Product)
                .WithMany(p => p.ProductCategories)
                .HasForeignKey(pc => pc.ProductId);

            modelBuilder.Entity<ProductCategory>()
                .HasOne(pc => pc.Category)
                .WithMany(c => c.ProductCategories)
                .HasForeignKey(pc => pc.CategoryId);

         // CommentProduct için çoktan çoğa ilişkiyi tanımla
                modelBuilder.Entity<CommentProduct>()
                .HasKey(cu => new { cu.ProductId, cu.CommentId }); // Composite Key

                modelBuilder.Entity<CommentProduct>()
                .HasOne(cp => cp.Comment)
                .WithMany(c => c.CommentProducts)
                .HasForeignKey(cp => cp.CommentId);

                modelBuilder.Entity<CommentProduct>()
                .HasOne(cp => cp.Product)
                .WithMany(p => p.CommentProducts)
                .HasForeignKey(cp => cp.ProductId);
        // AddressUser için çoktan çoğa ilişkiyi tanımla
            modelBuilder.Entity<AddressUser>()
                .HasKey(au => new { au.UserId, au.AddressId }); // Composite Key

            modelBuilder.Entity<AddressUser>()
                .HasOne(au => au.User)
                .WithMany(u => u.AddressUsers)
                .HasForeignKey(au => au.UserId);

            modelBuilder.Entity<AddressUser>()
                .HasOne(au => au.Address)
                .WithMany(a => a.AddressUsers)
                .HasForeignKey(au => au.AddressId);

        // UserProduct için çoktan çoğa ilişkiyi tanımla
                modelBuilder.Entity<UserProduct>()
                        .HasKey(up => new { up.ProductId, up.UserId }); // Composite Key
                        
                modelBuilder.Entity<UserProduct>()
                .HasOne(up => up.User)
                .WithMany(u => u.UserProducts)
                .HasForeignKey(up => up.UserId);

                modelBuilder.Entity<UserProduct>()
                .HasOne(up => up.Product)
                .WithMany(p => p.UserProducts)
                .HasForeignKey(up => up.ProductId);

        // UserFavItem ilişkisini tanımla
                modelBuilder.Entity<UserFavItem>()
                                .HasKey(ufi => new { ufi.ProductId, ufi.UserId }); // Composite Key
                        
                modelBuilder.Entity<UserFavItem>()
                .HasOne(ufi => ufi.User)
                .WithMany(u => u.UserFavItems)
                .HasForeignKey(ufi => ufi.UserId);

                modelBuilder.Entity<UserFavItem>()
                .HasOne(ufi => ufi.Product)
                .WithMany(p => p.UserFavItems)
                .HasForeignKey(ufi => ufi.ProductId);
        }
}
