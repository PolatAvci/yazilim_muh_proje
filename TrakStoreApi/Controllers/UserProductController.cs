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
    public class UserProductController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public UserProductController(TrakStoreDbContext context)
        {
            _context = context;
        }

        // GET: api/UserProduct
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserProduct>>> GetUserProducts()
        {
            var userProducts = await _context.UserProducts
                .Include(u => u.User)     // Kullanıcı bilgilerini dahil eder
                .Include(p => p.Product)  // Ürün bilgilerini dahil eder
                .ToListAsync();

            return Ok(userProducts);
        }

        // GET: api/UserProduct/user/{userId}
    [HttpGet("{userId}")]
    public async Task<ActionResult<IEnumerable<UserProduct>>> GetUserProductsByUserId(int userId)
    {
        var userProducts = await _context.UserProducts
            .Include(u => u.User)     // Kullanıcı bilgilerini dahil eder
            .Include(p => p.Product)  // Ürün bilgilerini dahil eder
            .Where(up => up.UserId == userId) // Belirli bir kullanıcıya ait ürünleri filtreler
            .ToListAsync();

        if (userProducts == null || !userProducts.Any())
        {
            return NotFound($"Kullanıcı ID {userId} için ürün bulunamadı.");
        }

        return Ok(userProducts);
}

        // GET: api/UserProduct/5
        [HttpGet("{userId}/{productId}")]
        public async Task<ActionResult<UserProduct>> GetUserProduct(int userId, int productId)
        {
            var userProduct = await _context.UserProducts
                .Include(u => u.User)
                .Include(p => p.Product)
                .FirstOrDefaultAsync(up => up.UserId == userId && up.ProductId == productId);

            if (userProduct == null)
            {
                return NotFound();
            }

            return Ok(userProduct);
        }

        // POST: api/UserProduct
        [HttpPost]
        public async Task<ActionResult<UserProduct>> PostUserProduct(UserProduct userProduct)
        {
            /*
            // Aynı kullanıcı ve ürün kombinasyonunun daha önce kaydedilip edilmediğini kontrol et
            var existingUserProduct = await _context.UserProducts
                .FirstOrDefaultAsync(up => up.UserId == userProduct.UserId && up.ProductId == userProduct.ProductId);

            if (existingUserProduct != null)
            {
                return BadRequest("Bu ürün zaten kullanıcıyla ilişkilendirilmiş.");
            }
*/
            _context.UserProducts.Add(userProduct);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUserProduct", new { userId = userProduct.UserId, productId = userProduct.ProductId }, userProduct);
        }

        // PUT: api/UserProduct/5
        [HttpPut("{userId}/{productId}")]
        public async Task<IActionResult> PutUserProduct(int userId, int productId, UserProduct userProduct)
        {
            if (userId != userProduct.UserId || productId != userProduct.ProductId)
            {
                return BadRequest();
            }

            _context.Entry(userProduct).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserProductExists(userId, productId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/UserProduct/5
        [HttpDelete("{userId}/{productId}")]
        public async Task<IActionResult> DeleteUserProduct(int userId, int productId)
        {
            var userProduct = await _context.UserProducts
                .FirstOrDefaultAsync(up => up.UserId == userId && up.ProductId == productId);

            if (userProduct == null)
            {
                return NotFound();
            }

            _context.UserProducts.Remove(userProduct);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserProductExists(int userId, int productId)
        {
            return _context.UserProducts.Any(e => e.UserId == userId && e.ProductId == productId);
        }
    }
}
