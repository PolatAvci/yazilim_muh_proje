using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TrakStoreApi.Migrations
{
    /// <inheritdoc />
    public partial class ControllerFilesUpdated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AddressUser_Adresler_AddressId",
                table: "AddressUser");

            migrationBuilder.DropForeignKey(
                name: "FK_AddressUser_Kullanicilar_UserId",
                table: "AddressUser");

            migrationBuilder.DropForeignKey(
                name: "FK_CommentProduct_Urunler_ProductId",
                table: "CommentProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_CommentProduct_Yorumlar_CommentId",
                table: "CommentProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductCategory_Kategoriler_CategoryId",
                table: "ProductCategory");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductCategory_Urunler_ProductId",
                table: "ProductCategory");

            migrationBuilder.DropForeignKey(
                name: "FK_UserFavItem_Kullanicilar_UserId",
                table: "UserFavItem");

            migrationBuilder.DropForeignKey(
                name: "FK_UserFavItem_Urunler_ProductId",
                table: "UserFavItem");

            migrationBuilder.DropForeignKey(
                name: "FK_UserProduct_Kullanicilar_UserId",
                table: "UserProduct");

            migrationBuilder.DropForeignKey(
                name: "FK_UserProduct_Urunler_ProductId",
                table: "UserProduct");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Yorumlar",
                table: "Yorumlar");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserProduct",
                table: "UserProduct");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserFavItem",
                table: "UserFavItem");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Urunler",
                table: "Urunler");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProductCategory",
                table: "ProductCategory");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Kullanicilar",
                table: "Kullanicilar");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Kategoriler",
                table: "Kategoriler");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CommentProduct",
                table: "CommentProduct");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Adresler",
                table: "Adresler");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AddressUser",
                table: "AddressUser");

            migrationBuilder.RenameTable(
                name: "Yorumlar",
                newName: "Comments");

            migrationBuilder.RenameTable(
                name: "UserProduct",
                newName: "UserProducts");

            migrationBuilder.RenameTable(
                name: "UserFavItem",
                newName: "UserFavItems");

            migrationBuilder.RenameTable(
                name: "Urunler",
                newName: "Products");

            migrationBuilder.RenameTable(
                name: "ProductCategory",
                newName: "ProductCategories");

            migrationBuilder.RenameTable(
                name: "Kullanicilar",
                newName: "Users");

            migrationBuilder.RenameTable(
                name: "Kategoriler",
                newName: "Categories");

            migrationBuilder.RenameTable(
                name: "CommentProduct",
                newName: "CommentProducts");

            migrationBuilder.RenameTable(
                name: "Adresler",
                newName: "Addresses");

            migrationBuilder.RenameTable(
                name: "AddressUser",
                newName: "AddressUsers");

            migrationBuilder.RenameIndex(
                name: "IX_UserProduct_UserId",
                table: "UserProducts",
                newName: "IX_UserProducts_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_UserFavItem_UserId",
                table: "UserFavItems",
                newName: "IX_UserFavItems_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_ProductCategory_CategoryId",
                table: "ProductCategories",
                newName: "IX_ProductCategories_CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_CommentProduct_CommentId",
                table: "CommentProducts",
                newName: "IX_CommentProducts_CommentId");

            migrationBuilder.RenameIndex(
                name: "IX_AddressUser_AddressId",
                table: "AddressUsers",
                newName: "IX_AddressUsers_AddressId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Comments",
                table: "Comments",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserProducts",
                table: "UserProducts",
                columns: new[] { "ProductId", "UserId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserFavItems",
                table: "UserFavItems",
                columns: new[] { "ProductId", "UserId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Products",
                table: "Products",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProductCategories",
                table: "ProductCategories",
                columns: new[] { "ProductId", "CategoryId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Users",
                table: "Users",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Categories",
                table: "Categories",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CommentProducts",
                table: "CommentProducts",
                columns: new[] { "ProductId", "CommentId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Addresses",
                table: "Addresses",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AddressUsers",
                table: "AddressUsers",
                columns: new[] { "UserId", "AddressId" });

            migrationBuilder.AddForeignKey(
                name: "FK_AddressUsers_Addresses_AddressId",
                table: "AddressUsers",
                column: "AddressId",
                principalTable: "Addresses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AddressUsers_Users_UserId",
                table: "AddressUsers",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CommentProducts_Comments_CommentId",
                table: "CommentProducts",
                column: "CommentId",
                principalTable: "Comments",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CommentProducts_Products_ProductId",
                table: "CommentProducts",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductCategories_Categories_CategoryId",
                table: "ProductCategories",
                column: "CategoryId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductCategories_Products_ProductId",
                table: "ProductCategories",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserFavItems_Products_ProductId",
                table: "UserFavItems",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserFavItems_Users_UserId",
                table: "UserFavItems",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserProducts_Products_ProductId",
                table: "UserProducts",
                column: "ProductId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserProducts_Users_UserId",
                table: "UserProducts",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AddressUsers_Addresses_AddressId",
                table: "AddressUsers");

            migrationBuilder.DropForeignKey(
                name: "FK_AddressUsers_Users_UserId",
                table: "AddressUsers");

            migrationBuilder.DropForeignKey(
                name: "FK_CommentProducts_Comments_CommentId",
                table: "CommentProducts");

            migrationBuilder.DropForeignKey(
                name: "FK_CommentProducts_Products_ProductId",
                table: "CommentProducts");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductCategories_Categories_CategoryId",
                table: "ProductCategories");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductCategories_Products_ProductId",
                table: "ProductCategories");

            migrationBuilder.DropForeignKey(
                name: "FK_UserFavItems_Products_ProductId",
                table: "UserFavItems");

            migrationBuilder.DropForeignKey(
                name: "FK_UserFavItems_Users_UserId",
                table: "UserFavItems");

            migrationBuilder.DropForeignKey(
                name: "FK_UserProducts_Products_ProductId",
                table: "UserProducts");

            migrationBuilder.DropForeignKey(
                name: "FK_UserProducts_Users_UserId",
                table: "UserProducts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Users",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserProducts",
                table: "UserProducts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserFavItems",
                table: "UserFavItems");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Products",
                table: "Products");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ProductCategories",
                table: "ProductCategories");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Comments",
                table: "Comments");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CommentProducts",
                table: "CommentProducts");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Categories",
                table: "Categories");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AddressUsers",
                table: "AddressUsers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Addresses",
                table: "Addresses");

            migrationBuilder.RenameTable(
                name: "Users",
                newName: "Kullanicilar");

            migrationBuilder.RenameTable(
                name: "UserProducts",
                newName: "UserProduct");

            migrationBuilder.RenameTable(
                name: "UserFavItems",
                newName: "UserFavItem");

            migrationBuilder.RenameTable(
                name: "Products",
                newName: "Urunler");

            migrationBuilder.RenameTable(
                name: "ProductCategories",
                newName: "ProductCategory");

            migrationBuilder.RenameTable(
                name: "Comments",
                newName: "Yorumlar");

            migrationBuilder.RenameTable(
                name: "CommentProducts",
                newName: "CommentProduct");

            migrationBuilder.RenameTable(
                name: "Categories",
                newName: "Kategoriler");

            migrationBuilder.RenameTable(
                name: "AddressUsers",
                newName: "AddressUser");

            migrationBuilder.RenameTable(
                name: "Addresses",
                newName: "Adresler");

            migrationBuilder.RenameIndex(
                name: "IX_UserProducts_UserId",
                table: "UserProduct",
                newName: "IX_UserProduct_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_UserFavItems_UserId",
                table: "UserFavItem",
                newName: "IX_UserFavItem_UserId");

            migrationBuilder.RenameIndex(
                name: "IX_ProductCategories_CategoryId",
                table: "ProductCategory",
                newName: "IX_ProductCategory_CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_CommentProducts_CommentId",
                table: "CommentProduct",
                newName: "IX_CommentProduct_CommentId");

            migrationBuilder.RenameIndex(
                name: "IX_AddressUsers_AddressId",
                table: "AddressUser",
                newName: "IX_AddressUser_AddressId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Kullanicilar",
                table: "Kullanicilar",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserProduct",
                table: "UserProduct",
                columns: new[] { "ProductId", "UserId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserFavItem",
                table: "UserFavItem",
                columns: new[] { "ProductId", "UserId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Urunler",
                table: "Urunler",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ProductCategory",
                table: "ProductCategory",
                columns: new[] { "ProductId", "CategoryId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Yorumlar",
                table: "Yorumlar",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CommentProduct",
                table: "CommentProduct",
                columns: new[] { "ProductId", "CommentId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Kategoriler",
                table: "Kategoriler",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AddressUser",
                table: "AddressUser",
                columns: new[] { "UserId", "AddressId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_Adresler",
                table: "Adresler",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_AddressUser_Adresler_AddressId",
                table: "AddressUser",
                column: "AddressId",
                principalTable: "Adresler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AddressUser_Kullanicilar_UserId",
                table: "AddressUser",
                column: "UserId",
                principalTable: "Kullanicilar",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CommentProduct_Urunler_ProductId",
                table: "CommentProduct",
                column: "ProductId",
                principalTable: "Urunler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CommentProduct_Yorumlar_CommentId",
                table: "CommentProduct",
                column: "CommentId",
                principalTable: "Yorumlar",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductCategory_Kategoriler_CategoryId",
                table: "ProductCategory",
                column: "CategoryId",
                principalTable: "Kategoriler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductCategory_Urunler_ProductId",
                table: "ProductCategory",
                column: "ProductId",
                principalTable: "Urunler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserFavItem_Kullanicilar_UserId",
                table: "UserFavItem",
                column: "UserId",
                principalTable: "Kullanicilar",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserFavItem_Urunler_ProductId",
                table: "UserFavItem",
                column: "ProductId",
                principalTable: "Urunler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserProduct_Kullanicilar_UserId",
                table: "UserProduct",
                column: "UserId",
                principalTable: "Kullanicilar",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserProduct_Urunler_ProductId",
                table: "UserProduct",
                column: "ProductId",
                principalTable: "Urunler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
