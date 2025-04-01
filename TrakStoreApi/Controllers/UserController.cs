using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TrakStoreApi.Models;  // Eğer User modeli farklı bir namespace içindeyse

namespace TrakStoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public UserController(TrakStoreDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            return await _context.Kullanicilar.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<User>> PostUser(User user)
        {
            _context.Kullanicilar.Add(user);
            await _context.SaveChangesAsync();
            
            return CreatedAtAction(nameof(GetUsers), new { id = user.Id }, user);
        }
    }
}
