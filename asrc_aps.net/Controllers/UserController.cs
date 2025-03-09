using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.Services;
using Applied_Sciences_Research_Center_Website.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace Applied_Sciences_Research_Center_Website.Controllers
{
    [Authorize(Roles = "Admin")]
    [Route("api/[controller]")]
    public class UserController : Controller
    {
        private readonly IMongoDatabase _database;
        private readonly IMongoCollection<UserModel> _usersCollection;
        private readonly UserService _userService;

        public UserController(IOptions<DatabaseConfigModel> database, IOptions<AuthConfigModel> authConfig)
        {
            var mongoClient = new MongoClient(database.Value.ConnectionString);
            _database = mongoClient.GetDatabase(database.Value.DataBase);
            _usersCollection = _database.GetCollection<UserModel>("Users");
            _userService = new UserService(_database, authConfig);
        }

        [AllowAnonymous]
        [HttpPost("CreateUser")]
        public async Task<ActionResult> CreateUser(CreateUserViewModel createUserVM)
        {
            try
            {
                if (createUserVM.Name == null || createUserVM.Email == null || createUserVM.Password == null || createUserVM.Role == null)
                    return new BadRequestObjectResult("Complete information for creating new user is not given");

                createUserVM.Email = createUserVM.Email.ToLower();

                var usersWithSameEmail = _usersCollection.Find(x => x.Email == createUserVM.Email).FirstOrDefault();

                if (usersWithSameEmail != null)
                    return new BadRequestObjectResult("This email is already registered");

                var user = await _userService.CreateUser(createUserVM);
                return Ok(user);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [HttpPost("UpdateUser")]
        public async Task<ActionResult> UpdateUser(UpdateUserViewModel updateUserVM)
        {
            try
            {
                if (updateUserVM.Name == null || updateUserVM.Email == null || updateUserVM.Password == null || updateUserVM.Role == null)
                    return new BadRequestObjectResult("Complete information for updating new user is not given");

                updateUserVM.Email = updateUserVM.Email.ToLower();

                var userWithSameEmail = _usersCollection.Find(x => x.Email == updateUserVM.Email).FirstOrDefault();

                if (userWithSameEmail == null)
                    return new BadRequestObjectResult("Email not found");

                var updatedUser = await _userService.UpdateUser(updateUserVM);

                if (updatedUser is null)
                    return new BadRequestObjectResult("User update failed");

                return Ok(updatedUser);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [HttpGet("GetAllUsers")]
        public async Task<ActionResult> GetAllUsers()
        {
            try
            {
                var result = await _userService.GetAllUsers();
                if (result.Count == 0)
                    return BadRequest("No users found");
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [HttpGet("GetUserByEmail")]
        public async Task<ActionResult> GetUserByEmail(string email)
        {
            try
            {
                if (email is null)
                    return new BadRequestObjectResult("Email not provided");
                var user = await _userService.GetUserByEmail(email);
                return Ok(user);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [HttpDelete("DeleteUserByEmail")]
        public async Task<ActionResult> DeleteUserByEmail(string email)
        {
            try
            {
                if (email is null)
                    return new BadRequestObjectResult("Email not provided");
                var result = await _userService.DeleteUser(email);

                if (result is null)
                    return StatusCode(500, $"An error occurred on Db");

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
