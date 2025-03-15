using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace asrc_asp.Controllers
{
    public class HomeController : Controller
    {
        [AllowAnonymous]
        [HttpGet("isWorking")]
        public ActionResult isWorking()
        {
            return Ok();
        }
    }
}
