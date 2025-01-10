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

        //[Authorize(Roles = "Admin")]
        [HttpPost("Update")]
        public async Task<ActionResult> UpdatePaper(UpdatePaperViewModel updatePaper)
        {
            try
            {   if (string.IsNullOrWhiteSpace(updatePaper.OldTitle) || string.IsNullOrWhiteSpace(updatePaper.NewUploaderEmail))
                    return BadRequest("OldTitle and NewUploaderEmail are required.");
                
                if (string.IsNullOrWhiteSpace(updatePaper.NewTitle) &&
                    string.IsNullOrWhiteSpace(updatePaper.NewDescription) &&
                    string.IsNullOrWhiteSpace(updatePaper.NewLink) &&
                    string.IsNullOrWhiteSpace(updatePaper.NewImageUrl))
                {
                    return BadRequest("At least one field to update must be provided.");
                }
                
                var updatedPaper = await _service.UpdatePaper(updatePaper);

                if (updatedPaper is null)
                    return NotFound($"The paper with title '{updatePaper.OldTitle}' was not found or update failed.");

                return Ok(updatedPaper);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }


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
