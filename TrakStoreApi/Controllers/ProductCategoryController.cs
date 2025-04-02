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
    public class ProductCategoryController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public ProductCategoryController(TrakStoreDbContext context)
        {
            _context = context;
        }

        // GET: api/ProductCategory
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductCategory>>> GetProductCategories()
        {
            var productCategories = await _context.ProductCategories
                .Include(pc => pc.Product)    // İlişkili ürünleri yükler
                .Include(pc => pc.Category)   // İlişkili kategorileri yükler
                .ToListAsync();

            return Ok(productCategories);
        }

        // GET: api/ProductCategory/5
        [HttpGet("{categoryId}")]
        public async Task<ActionResult<IEnumerable<ProductCategory>>> GetProductCategoriesByCategoryId(int categoryId)
        {
            var productCategories = await _context.ProductCategories
                .Include(pc => pc.Product)
                .Include(pc => pc.Category)
                .Where(pc => pc.CategoryId == categoryId) // CategoryId'ye göre filtreleme
                .ToListAsync();

            if (productCategories == null || productCategories.Count == 0)
            {
                return NotFound();
            }

            return Ok(productCategories); // Kategorinin tüm ürünleri döndürülür
        }

        // POST: api/ProductCategory
        [HttpPost]
        public async Task<ActionResult<ProductCategory>> PostProductCategory(ProductCategory productCategory)
        {
            _context.ProductCategories.Add(productCategory);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProductCategory", new { productId = productCategory.ProductId, categoryId = productCategory.CategoryId }, productCategory);
        }

        // DELETE: api/ProductCategory/5
        [HttpDelete("{productId}/{categoryId}")]
        public async Task<IActionResult> DeleteProductCategory(int productId, int categoryId)
        {
            var productCategory = await _context.ProductCategories
                .FirstOrDefaultAsync(pc => pc.ProductId == productId && pc.CategoryId == categoryId);

            if (productCategory == null)
            {
                return NotFound();
            }

            _context.ProductCategories.Remove(productCategory);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
