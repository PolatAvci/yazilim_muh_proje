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
    public class CommentProductController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public CommentProductController(TrakStoreDbContext context)
        {
            _context = context;
        }

        // GET: api/CommentProduct
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CommentProduct>>> GetCommentProducts()
        {
            return await _context.CommentProducts.ToListAsync();
        }

        // GET: api/CommentProduct/5
        [HttpGet("{productId}")]
        public async Task<ActionResult<IEnumerable<CommentProduct>>> GetCommentProductsByUserId(int productId)
        {
            // UserId'ye göre yorumları ve ilişkili ürünleri çekiyoruz
            var commentProducts = await _context.CommentProducts
                .Include(cp => cp.Comment)  // Comment bilgilerini dahil et
                .Include(cp => cp.Product)  // Product bilgilerini dahil et
                .Where(cp => cp.ProductId == productId)  // Yalnızca bu userId'ye ait yorumları filtrele
                .ToListAsync();

            if (commentProducts == null || commentProducts.Count == 0)
            {
                return NotFound("Ürüne ait yorum bulunamadı.");
            }

            return Ok(commentProducts);
        }

        // POST: api/CommentProduct
        [HttpPost]
        public async Task<ActionResult<CommentProduct>> PostCommentProduct(CommentProduct commentProduct)
        {
            _context.CommentProducts.Add(commentProduct);
            await _context.SaveChangesAsync();

            // Return the created comment-product relationship
            return CreatedAtAction("GetCommentProduct", new { id = commentProduct.CommentId }, commentProduct);
        }

        // DELETE: api/CommentProduct/5
        [HttpDelete("{commentId}/{productId}")]
        public async Task<IActionResult> DeleteCommentProduct(int commentId, int productId)
        {
            var commentProduct = await _context.CommentProducts
                .FirstOrDefaultAsync(cp => cp.CommentId == commentId && cp.ProductId == productId);

            if (commentProduct == null)
            {
                return NotFound();
            }

            _context.CommentProducts.Remove(commentProduct);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
