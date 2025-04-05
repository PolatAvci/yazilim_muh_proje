using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TrakStoreApi.Migrations
{
    /// <inheritdoc />
    public partial class commentUserTableAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Yorumlar_Urunler_ProductId",
                table: "Yorumlar");

            migrationBuilder.DropIndex(
                name: "IX_Yorumlar_ProductId",
                table: "Yorumlar");

            migrationBuilder.DropColumn(
                name: "Country",
                table: "Adresler");

            migrationBuilder.DropColumn(
                name: "PostalCode",
                table: "Adresler");

            migrationBuilder.RenameColumn(
                name: "ProductId",
                table: "Yorumlar",
                newName: "Star");

            migrationBuilder.RenameColumn(
                name: "Content",
                table: "Yorumlar",
                newName: "Text");

            migrationBuilder.RenameColumn(
                name: "FullName",
                table: "Kullanicilar",
                newName: "Surname");

            migrationBuilder.RenameColumn(
                name: "Street",
                table: "Adresler",
                newName: "AddressInfo");

            migrationBuilder.AddColumn<DateTime>(
                name: "Date",
                table: "Yorumlar",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "Details",
                table: "Urunler",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "image",
                table: "Urunler",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "Kullanicilar",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Image",
                table: "Kategoriler",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "CommentUser",
                columns: table => new
                {
                    UserId = table.Column<int>(type: "int", nullable: false),
                    CommentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CommentUser", x => new { x.UserId, x.CommentId });
                    table.ForeignKey(
                        name: "FK_CommentUser_Kullanicilar_UserId",
                        column: x => x.UserId,
                        principalTable: "Kullanicilar",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CommentUser_Yorumlar_CommentId",
                        column: x => x.CommentId,
                        principalTable: "Yorumlar",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CommentUser_CommentId",
                table: "CommentUser",
                column: "CommentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CommentUser");

            migrationBuilder.DropColumn(
                name: "Date",
                table: "Yorumlar");

            migrationBuilder.DropColumn(
                name: "Details",
                table: "Urunler");

            migrationBuilder.DropColumn(
                name: "image",
                table: "Urunler");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "Kullanicilar");

            migrationBuilder.DropColumn(
                name: "Image",
                table: "Kategoriler");

            migrationBuilder.RenameColumn(
                name: "Text",
                table: "Yorumlar",
                newName: "Content");

            migrationBuilder.RenameColumn(
                name: "Star",
                table: "Yorumlar",
                newName: "ProductId");

            migrationBuilder.RenameColumn(
                name: "Surname",
                table: "Kullanicilar",
                newName: "FullName");

            migrationBuilder.RenameColumn(
                name: "AddressInfo",
                table: "Adresler",
                newName: "Street");

            migrationBuilder.AddColumn<string>(
                name: "Country",
                table: "Adresler",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PostalCode",
                table: "Adresler",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Yorumlar_ProductId",
                table: "Yorumlar",
                column: "ProductId");

            migrationBuilder.AddForeignKey(
                name: "FK_Yorumlar_Urunler_ProductId",
                table: "Yorumlar",
                column: "ProductId",
                principalTable: "Urunler",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
