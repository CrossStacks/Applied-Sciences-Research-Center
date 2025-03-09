using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.ViewModels;
using MongoDB.Driver;

namespace Applied_Sciences_Research_Center_Website.Services
{
    public class EventService
    {
        private readonly IMongoCollection<EventsModel> _eventsCollection;

        public EventService(IMongoDatabase database, IMongoCollection<EventsModel> eventsCollection)
        {
            _eventsCollection = eventsCollection;
        }

        public async Task<EventViewModel> AddEvent(EventViewModel vm)
        {
            EventsModel eventsModels = new EventsModel
            {
                Name = vm.Name,
                Date = vm.Date,
                Description = vm.Description,
                HostName = vm.HostName,
                ImageUrl = vm.ImageUrl
            };

            await _eventsCollection.InsertOneAsync(eventsModels);

            return vm;
        }

        public async Task<List<EventViewModel>> GetAll()
        {
            var events = await _eventsCollection.Find(x => true).ToListAsync();

            List<EventViewModel> results = [];

            foreach (var item in events)
            {
                results.Insert(0, new EventViewModel
                {
                    Date = item.Date,
                    Description = item.Description,
                    HostName= item.HostName,
                    ImageUrl = item.ImageUrl,
                    Name = item.Name
                });
            }

            return results;
        }
        
        public async Task<bool> DeleteEvent(string name)
        {
            var response = await _eventsCollection.DeleteOneAsync(x => x.Name == name);

            if(response.DeletedCount == 0)
            {
                return false;
            }

            return true;
        }
    }
}
