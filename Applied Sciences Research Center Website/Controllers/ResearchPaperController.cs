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
    public class ResearchPaperController : Controller
    {
        private readonly IMongoDatabase _database;
        private readonly IMongoCollection<ResearchPaperModel> _reserachPaperCollection;
        private readonly ResearchPaperService _service;

        public ResearchPaperController(IOptions<DatabaseConfigModel> database, IOptions<AuthConfigModel> authConfig)
        {
            var mongoClient = new MongoClient(database.Value.ConnectionString);
            _database = mongoClient.GetDatabase(database.Value.DataBase);
            _reserachPaperCollection = _database.GetCollection<ResearchPaperModel>("ResearchPaper");
            _service = new ResearchPaperService(_database);
        }

        [Authorize(Roles = "Admin,Moderator")]
        [HttpPost("Create")]
        public async Task<ActionResult> Create(ResearchPaperViewModel createPaperVM)
        {
            try
            {
                if (createPaperVM.Title == null || createPaperVM.Link == null || createPaperVM.Description == null || createPaperVM.UploaderEmail == null)
                    return new BadRequestObjectResult("Complete information for creating new research paper is not given");

                var user = await _service.CreatePaper(createPaperVM);
                return Ok(user);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        //[HttpPost("Update")]
        //public async Task<ActionResult> UpdateUser(UpdateUserViewModel updateUserVM)
        //{
        //    try
        //    {
        //        if (updateUserVM.Name == null || updateUserVM.Email == null || updateUserVM.Password == null || updateUserVM.Role == null)
        //            return new BadRequestObjectResult("Complete information for updating new user is not given");

        //        updateUserVM.Email = updateUserVM.Email.ToLower();

        //        var userWithSameEmail = _usersCollection.Find(x => x.Email == updateUserVM.Email).FirstOrDefault();

        //        if (userWithSameEmail == null)
        //            return new BadRequestObjectResult("Email not found");

        //        var updatedUser = await _userService.UpdateUser(updateUserVM);

        //        if (updatedUser is null)
        //            return new BadRequestObjectResult("User update failed");

        //        return Ok(updatedUser);
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, $"An error occurred: {ex.Message}");
        //    }
        //}

        [HttpGet("GetAll")]
        public async Task<ActionResult> GetAll()
        {
            try
            {
                var result = await _service.GetAllPapers();
                if (result.Count == 0)
                    return BadRequest("No research paper found");
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
        
        [HttpGet("Get")]
        public async Task<ActionResult> GetAll(int num)
        {
            try
            {
                var result = await _service.GetAllPapers();
                if (result.Count == 0)
                    return BadRequest("No research paper found");
                return Ok(result.Take(num));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        //[HttpDelete("Delete")]
        //public async Task<ActionResult> Delete(string title)
        //{
        //    try
        //    {
        //        if (email is null)
        //            return new BadRequestObjectResult("Email not provided");
        //        var result = await _userService.DeleteUser(email);

        //        if (result is null)
        //            return StatusCode(500, $"An error occurred on Db");

        //        return Ok(result);
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, $"An error occurred: {ex.Message}");
        //    }
        //}
    }
}
