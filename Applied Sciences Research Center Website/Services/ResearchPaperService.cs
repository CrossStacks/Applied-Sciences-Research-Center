using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.ViewModels;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace Applied_Sciences_Research_Center_Website.Services
{
    public class ResearchPaperService
    {
        private readonly IMongoCollection<ResearchPaperModel> _reserachPaperCollection;

        public ResearchPaperService(IMongoDatabase database)
        {
            _reserachPaperCollection = database.GetCollection<ResearchPaperModel>("ResearchPaper");
        }

        public async Task<ResearchPaperModel> CreatePaper(ResearchPaperViewModel vm)
        {
            ResearchPaperModel model = new()
            {
                Title = vm.Title,
                Description = vm.Description,
                Link = vm.Link,
                UploaderEmail = vm.UploaderEmail,
                ImageUrl = vm.ImageUrl,
            };

            await _reserachPaperCollection.InsertOneAsync(model);

            return model;
        }

        public async Task<List<ResearchPaperViewModel>> GetAllPapers()
        {
            var papers = await _reserachPaperCollection.Find(x => true).ToListAsync();

            List<ResearchPaperViewModel> results = [];

            foreach (var paper in papers)
            {
                ResearchPaperViewModel result = new()
                {
                    Title = paper.Title,
                    Description = paper.Description,
                    Link = paper.Link,
                    UploaderEmail = paper.UploaderEmail,
                    ImageUrl = paper.ImageUrl,
                };

                results.Add(result);
            }
            return results;
        }
    }
}
