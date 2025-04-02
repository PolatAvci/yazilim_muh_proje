using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TrakStoreApi.Migrations
{
    /// <inheritdoc />
    public partial class passwordtypeChanged : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PasswordHash",
                table: "Kullanicilar");

            migrationBuilder.DropColumn(
                name: "PasswordSalt",
                table: "Kullanicilar");

            migrationBuilder.AddColumn<string>(
                name: "Password",
                table: "Kullanicilar",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
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
        }
    }
}
