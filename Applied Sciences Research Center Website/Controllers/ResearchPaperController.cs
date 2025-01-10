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
        private readonly IMongoCollection<ResearchPaperModel> _researchPaperCollection;
        private readonly ResearchPaperService _service;

        public ResearchPaperController(IOptions<DatabaseConfigModel> database, IOptions<AuthConfigModel> authConfig)
        {
            var mongoClient = new MongoClient(database.Value.ConnectionString);
            _database = mongoClient.GetDatabase(database.Value.DataBase);
            _researchPaperCollection = _database.GetCollection<ResearchPaperModel>("ResearchPaper");
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
                return Ok(result.TakeLast(num));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        // [Authorize(Roles = "Admin")]
        [HttpDelete("Delete")]
        public async Task<IActionResult> DeletePaper(string title)
        {
            if (string.IsNullOrWhiteSpace(title))
                return BadRequest("Title cannot be null or empty.");
            try
            {
                var result = await _service.DeletePaper(title);
                if (result == "No record found")
                    return NotFound($"The research paper with title '{title}' was not found.");
                if (result is null)
                    return StatusCode(500, "An unexpected error occurred while deleting the paper.");
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
