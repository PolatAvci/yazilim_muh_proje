using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TrakStoreApi.Migrations
{
    /// <inheritdoc />
    public partial class tablesupdated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Id",
                table: "CommentProduct");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Id",
                table: "CommentProduct",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
