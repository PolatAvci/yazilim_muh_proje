using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

using TrakStoreApi.Models;

namespace TrakStoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserFavItemController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public UserFavItemController(TrakStoreDbContext context)
        {
            _context = context;
        }

        // GET: api/UserFavItem
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserFavItem>>> GetUserFavItems()
        {
            var userFavItems = await _context.UserFavItems
                .Include(u => u.User)    // Kullanıcı bilgilerini dahil eder
                .Include(u => u.Product) // Ürün bilgilerini dahil eder
                .ToListAsync();

            return Ok(userFavItems);
        }

        // GET: api/UserFavItem/5
        [HttpGet("{userId}")]
        public async Task<ActionResult<List<UserFavItem>>> GetUserFavItem(int userId)
        {
            var userFavItem = await _context.UserFavItems
                .Include(u => u.User)
                .Include(u => u.Product)
                .Where(uf => uf.UserId == userId)
                .ToListAsync();

            if (userFavItem == null)
            {
                return NotFound();
            }

            return Ok(userFavItem);
        }

        // POST: api/UserFavItem
        [HttpPost]
        public async Task<IActionResult> PostUserFavItem([FromBody] UserFavItem userFavItem)
        {
            try
            {
                // Aynı kullanıcı ve ürün kombinasyonunun daha önce favorilere eklenip eklenmediğini kontrol et
                var existingFavItem = await _context.UserFavItems
                    .FirstOrDefaultAsync(uf => uf.UserId == userFavItem.UserId && uf.ProductId == userFavItem.ProductId);

                if (existingFavItem != null)
                {
                    return BadRequest("Bu ürün zaten favorilerde.");
                }

                _context.UserFavItems.Add(userFavItem);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(GetUserFavItem), new { userId = userFavItem.UserId }, userFavItem);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = ex.Message });
            }
        }


        // DELETE: api/UserFavItem/5
        [HttpDelete("{userId}/{productId}")]
        public async Task<IActionResult> DeleteUserFavItem(int userId, int productId)
        {
            var userFavItem = await _context.UserFavItems
                .FirstOrDefaultAsync(uf => uf.UserId == userId && uf.ProductId == productId);

            if (userFavItem == null)
            {
                return NotFound();
            }

            _context.UserFavItems.Remove(userFavItem);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserFavItemExists(int userId, int productId)
        {
            return _context.UserFavItems.Any(e => e.UserId == userId && e.ProductId == productId);
        }
    }
}
