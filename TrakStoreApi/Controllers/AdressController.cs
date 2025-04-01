using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TrakStoreApi.Models;  // Address sınıfının bulunduğu namespace
using System.Collections.Generic;
using System.Threading.Tasks;

namespace TrakStoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AddressController : ControllerBase
    {
        private readonly TrakStoreDbContext _context;

        public AddressController(TrakStoreDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Address>>> GetAddresses()
        {
            return await _context.Adresler.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<Address>> PostAddress(Address address)
        {
            _context.Adresler.Add(address);
            await _context.SaveChangesAsync();
            
            return CreatedAtAction(nameof(GetAddresses), new { id = address.Id }, address);
        }
    }
}
