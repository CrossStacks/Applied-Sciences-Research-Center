using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.Services;
using Applied_Sciences_Research_Center_Website.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace Applied_Sciences_Research_Center_Website.Controllers
{
    [Route("api/[controller]")]
    public class AuthController : Controller
    {
        private readonly IMongoDatabase _database;
        private readonly IMongoCollection<UserModel> _usersCollection;
        private readonly AuthService authService;

        public AuthController(IOptions<DatabaseConfigModel> database, IOptions<AuthConfigModel> authConfig)
        {
            var mongoClient = new MongoClient(database.Value.ConnectionString);
            _database = mongoClient.GetDatabase(database.Value.DataBase);
            _usersCollection = _database.GetCollection<UserModel>("Users");
            authService = new AuthService(authConfig);
        }

        [AllowAnonymous]
        [HttpGet("Login")]
        public ActionResult Login(LoginViewModel loginVM)
        {
            if (loginVM.Email == null || loginVM.Password == null)
                return StatusCode(StatusCodes.Status400BadRequest);

            loginVM.Email = loginVM.Email.ToLower();

            var user = _usersCollection.Find(x => x.Email == loginVM.Email).FirstOrDefault();

            if (user == null)
                return StatusCode(StatusCodes.Status401Unauthorized, "Email is not registered");

            if (user.Password != authService.EncryptPassword(loginVM.Password))
                return StatusCode(StatusCodes.Status401Unauthorized, "Password is incorrect");

            UserViewModel loggedInUser = new()
            {
                Email = user.Email,
                Password = user.Password,
                Name = user.Name,
                Token = authService.GenerateToken(loginVM.Email, user.Role),
                Role = user.Role
            };

            return Ok(loggedInUser);
        }
    }
}
