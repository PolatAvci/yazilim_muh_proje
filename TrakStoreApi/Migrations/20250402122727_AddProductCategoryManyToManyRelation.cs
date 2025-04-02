using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TrakStoreApi.Migrations
{
    /// <inheritdoc />
    public partial class AddProductCategoryManyToManyRelation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Urunler_Kategoriler_CategoryId",
                table: "Urunler");

            migrationBuilder.DropIndex(
                name: "IX_Urunler_CategoryId",
                table: "Urunler");

            migrationBuilder.DropColumn(
                name: "CategoryId",
                table: "Urunler");

            migrationBuilder.DropColumn(
                name: "Password",
                table: "Kullanicilar");

            migrationBuilder.AddColumn<byte[]>(
                name: "PasswordHash",
                table: "Kullanicilar",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.AddColumn<byte[]>(
                name: "PasswordSalt",
                table: "Kullanicilar",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "ProductCategory",
                columns: table => new
                {
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    CategoryId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductCategory", x => new { x.ProductId, x.CategoryId });
                    table.ForeignKey(
                        name: "FK_ProductCategory_Kategoriler_CategoryId",
                        column: x => x.CategoryId,
                        principalTable: "Kategoriler",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProductCategory_Urunler_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Urunler",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductCategory_CategoryId",
                table: "ProductCategory",
                column: "CategoryId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ProductCategory");

            migrationBuilder.DropColumn(
                name: "PasswordHash",
                table: "Kullanicilar");

            migrationBuilder.DropColumn(
                name: "PasswordSalt",
                table: "Kullanicilar");

            migrationBuilder.AddColumn<int>(
                name: "CategoryId",
                table: "Urunler",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Password",
                table: "Kullanicilar",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Urunler_CategoryId",
                table: "Urunler",
                column: "CategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_Urunler_Kategoriler_CategoryId",
                table: "Urunler",
                column: "CategoryId",
                principalTable: "Kategoriler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
