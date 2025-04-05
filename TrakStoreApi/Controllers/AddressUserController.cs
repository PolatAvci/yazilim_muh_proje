using Microsoft.AspNetCore.Mvc;
using TrakStoreApi.Models;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;

namespace TrakStoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AddressUserController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public AddressUserController(TrakStoreDbContext context)
        {
            _context = context;
        }

        // GET: api/AddressUser
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AddressUser>>> GetAddressUsers()
        {
            return await _context.AddressUsers.ToListAsync();
        }

        // GET: api/AddressUser/5
        [HttpGet("{userId}")]
        public async Task<ActionResult<List<AddressUser>>> GetAddressUser(int userId)
        {
            var addressUser = await _context.AddressUsers
                .Include(au => au.User)
                .Include(au => au.Address)
                .Where(au => au.UserId == userId)
                .ToListAsync();

            if (addressUser == null)
            {
                return NotFound();
            }

            return addressUser;
        }

        // POST: api/AddressUser
        [HttpPost]
        public async Task<ActionResult<AddressUser>> PostAddressUser(AddressUser addressUser)
        {
            _context.AddressUsers.Add(addressUser);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetAddressUser), new { userId = addressUser.UserId }, addressUser);
        }

        // PUT: api/AddressUser/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAddressUser(int id, AddressUser addressUser)
        {
            if (id != addressUser.UserId)
            {
                return BadRequest();
            }

            _context.Entry(addressUser).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AddressUserExists(id))
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

        // DELETE: api/AddressUser/5/5
        [HttpDelete("{userId}/{addressId}")]
        public async Task<IActionResult> DeleteAddressUser(int userId, int addressId)
        {
             var addressUser = await _context.AddressUsers
                .FirstOrDefaultAsync(au => au.UserId == userId && au.AddressId == addressId);

            if (addressUser == null)
            {
                return NotFound();
            }

            _context.AddressUsers.Remove(addressUser);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AddressUserExists(int id)
        {
            return _context.AddressUsers.Any(e => e.UserId == id);
        }
    }
}
