using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Applied_Sciences_Research_Center_Website.Controllers
{
    [Route("api/[controller]")]
    public class AuthController : Controller
    {
        [AllowAnonymous]
        [HttpGet("check")]
        public ActionResult check()
        {
            return Ok("All working alhamdililah");
        }
    }
}
