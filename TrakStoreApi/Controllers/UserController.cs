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
    public class UserController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public UserController(TrakStoreDbContext context)
        {
            _context = context;
        }

        // GET: api/User
        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            var users = await _context.Users
                .Include(u => u.AddressUsers)  // İlişkili adresleri yükler
                .Include(u => u.UserProducts) // İlişkili ürünleri yükler
                .Include(u => u.UserFavItems) // İlişkili favori ürünleri yükler
                .ToListAsync();

            return Ok(users);
        }

        // GET: api/User/5
        [HttpGet("{id}")]
        public async Task<ActionResult<User>> GetUser(int id)
        {
            var user = await _context.Users
                .Include(u => u.AddressUsers)
                .Include(u => u.UserProducts)
                .Include(u => u.UserFavItems)
                .FirstOrDefaultAsync(u => u.Id == id);

            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        // POST: api/User/login
        [HttpPost("Login")]
        public async Task<ActionResult<User>> Login(LoginRequest loginRequest)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == loginRequest.Email && u.Password == loginRequest.Password);

            if (user == null)
            {
                return Unauthorized(new { message = "Email veya şifre hatalı." });
            }

            // Token üretimi yapılacaksa burada eklenebilir

            return Ok(user);
        }


        // POST: api/User
        [HttpPost]
        public async Task<ActionResult<User>> PostUser(User user)
        {
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUser", new { id = user.Id }, user);
        }

        // PUT: api/User/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUser(int id, User user)
        {
            if (id != user.Id)
            {
                return BadRequest();
            }

            _context.Entry(user).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(id))
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

        // DELETE: api/User/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.Id == id);
        }
    }
}
