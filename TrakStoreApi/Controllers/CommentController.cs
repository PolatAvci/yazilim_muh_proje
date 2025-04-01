using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TrakStoreApi.Models;  // Eğer Comment modeli farklı bir namespace içindeyse

namespace TrakStoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public CommentController(TrakStoreDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Comment>>> GetComments()
        {
            return await _context.Yorumlar.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<Comment>> PostComment(Comment comment)
        {
            _context.Yorumlar.Add(comment);
            await _context.SaveChangesAsync();
            
            return CreatedAtAction(nameof(GetComments), new { id = comment.Id }, comment);
        }
    }
}
