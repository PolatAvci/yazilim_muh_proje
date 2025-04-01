using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TrakStoreApi.Models;


namespace TrakStoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public ProductController(TrakStoreDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Product>>> GetProducts()
        {
            return await _context.Urunler.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<Product>> PostProduct(Product product)
        {
            _context.Urunler.Add(product);
            await _context.SaveChangesAsync();
            
            return CreatedAtAction(nameof(GetProducts), new { id = product.Id }, product);
        }
    }
}
