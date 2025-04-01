using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TrakStoreApi.Models;  // Eğer Category modeli farklı bir namespace içindeyse ekle

namespace TrakStoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public CategoryController(TrakStoreDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Category>>> GetCategories()
        {
            return await _context.Kategoriler.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<Category>> PostCategory(Category category)
        {
            _context.Kategoriler.Add(category);
            await _context.SaveChangesAsync();
            
            return CreatedAtAction(nameof(GetCategories), new { id = category.Id }, category);
        }
    }
}
