using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.ViewModels;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace Applied_Sciences_Research_Center_Website.Services
{
    public class ResearchPaperService
    {
        private readonly IMongoCollection<ResearchPaperModel> _researchPaperCollection;

        public ResearchPaperService(IMongoDatabase database)
        {
            _researchPaperCollection = database.GetCollection<ResearchPaperModel>("ResearchPaper");
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

            await _researchPaperCollection.InsertOneAsync(model);

            return model;
        }

        public async Task<List<ResearchPaperViewModel>> GetAllPapers()
        {
            var papers = await _researchPaperCollection.Find(x => true).ToListAsync();

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
        public async Task<string?> DeletePaper(string title)
        {
            var result = await _researchPaperCollection.DeleteOneAsync(x => x.Title == title);
            if (result.DeletedCount > 0)
                return $"The research paper '{title}' has been successfully deleted.";
            else
                return "No record found";
        }

    }
}
