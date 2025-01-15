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
    public class PublicationController : Controller
    {
        private readonly IMongoDatabase _database;
        private readonly IMongoCollection<PublicationModel> _publicationCollection;
        private readonly PublicationService _service;

        public PublicationController(IOptions<DatabaseConfigModel> database, IOptions<AuthConfigModel> authConfig)
        {
            var mongoClient = new MongoClient(database.Value.ConnectionString);
            _database = mongoClient.GetDatabase(database.Value.DataBase);
            _publicationCollection = _database.GetCollection<PublicationModel>("Publications");
            _service = new PublicationService(_database);
        }

        [Authorize(Roles = "Admin,Moderator")]
        [HttpPost("Create")]
        public async Task<ActionResult> Create(CreatePublicationViewModel vm)
        {
            try
            {
                if (vm == null || vm.Title == null || vm.Link == null || vm.Description == null || vm.UploaderEmail == null)
                    return new BadRequestObjectResult("Complete information for creation is not given");

                var result = await _service.CreatePublication(vm);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpPost("Update")]
        public async Task<ActionResult> UpdatePaper(UpdatePublicationViewModel updatePaper)
        {
            try
            {
                if (updatePaper.SR == 0)
                    return BadRequest("SR and New Uploader Email are required.");

                if (string.IsNullOrWhiteSpace(updatePaper.NewUploaderEmail) && string.IsNullOrWhiteSpace(updatePaper.NewTitle) && string.IsNullOrWhiteSpace(updatePaper.NewDescription) && string.IsNullOrWhiteSpace(updatePaper.NewLink) && string.IsNullOrWhiteSpace(updatePaper.NewImageUrl))
                {
                    return BadRequest("At least one field to update must be provided.");
                }

                var updatedPaper = await _service.Update(updatePaper);

                if (updatedPaper is null)
                    return NotFound($"The paper with SR '{updatePaper.SR}' was not found or update failed.");

                return Ok("Updated successfully");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [AllowAnonymous]
        [HttpGet("GetAll")]
        public async Task<ActionResult> GetAll()
        {
            try
            {
                var result = await _service.GetAll();
                if (result.Count == 0)
                    return BadRequest("No data added");
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [AllowAnonymous]
        [HttpGet("Get")]
        public async Task<ActionResult> Get(int num)
        {
            try
            {
                var result = await _service.GetAll();
                if (result.Count == 0)
                    return BadRequest("Nothing found");
                return Ok(result.TakeLast(num));
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("Delete")]
        public async Task<IActionResult> Delete(int sr)
        {
            if (sr == 0)
                return BadRequest("Sr cannot be null or empty.");
            try
            {
                var result = await _service.Delete(sr);
                if (result == "No record found")
                    return NotFound($"No record found");
                if (result is null)
                    return StatusCode(500, "An unexpected error occurred while deleting.");
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
