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
    public class EventsController : Controller
    {
        private readonly IMongoDatabase _database;
        private readonly IMongoCollection<EventsModel> _eventsCollection;
        private readonly EventService _eventService;

        public EventsController(IOptions<DatabaseConfigModel> database, IOptions<AuthConfigModel> authConfig)
        {
            var mongoClient = new MongoClient(database.Value.ConnectionString);
            _database = mongoClient.GetDatabase(database.Value.DataBase);
            _eventsCollection = _database.GetCollection<EventsModel>("Events");
            _eventService = new EventService(_database, _eventsCollection);
        }

        [HttpPost("Add")]
        public async Task<ActionResult> Add(EventViewModel vm)
        {
            try
            {
                if (vm.Name == null || vm.Date == null || vm.Description == null || vm.HostName == null)
                    return new BadRequestObjectResult("Complete information for creation is not given");

                var eventWithSameName = _eventsCollection.Find(x => x.Name == vm.Name).FirstOrDefault();

                if (eventWithSameName != null)
                    return new BadRequestObjectResult("This named Event is already present");

                var eventCreated = await _eventService.AddEvent(vm);
                return Ok(eventCreated);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [AllowAnonymous]
        [HttpPost("GetAll")]
        public async Task<ActionResult> GetAll()
        {
            try
            {
                var allEvents = await _eventService.GetAll();
                return Ok(allEvents);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

        [HttpPost("Delete")]
        public async Task<ActionResult> Delete(string name)
        {
            try
            {
                if (name == null)
                    return new BadRequestObjectResult("Complete information not given");

                var response = await _eventService.DeleteEvent(name);

                if(response)
                {
                    return Ok("Event Deleted");
                }

                return Ok("Event not found");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
