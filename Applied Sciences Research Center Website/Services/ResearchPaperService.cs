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
        public async Task<UpdatePaperViewModel?> UpdatePaper(UpdatePaperViewModel updatePaper)
        {
            var paper = await _researchPaperCollection.Find(x => x.Title == updatePaper.OldTitle).FirstOrDefaultAsync();

            if (paper is null)
                return null;

            var updateDefinition = Builders<ResearchPaperModel>.Update
                .Set(x => x.UploaderEmail, updatePaper.NewUploaderEmail);

            if (!string.IsNullOrWhiteSpace(updatePaper.NewTitle))
                updateDefinition = updateDefinition.Set(x => x.Title, updatePaper.NewTitle);

            if (!string.IsNullOrWhiteSpace(updatePaper.NewDescription))
                updateDefinition = updateDefinition.Set(x => x.Description, updatePaper.NewDescription);

            if (!string.IsNullOrWhiteSpace(updatePaper.NewLink))
                updateDefinition = updateDefinition.Set(x => x.Link, updatePaper.NewLink);

            if (!string.IsNullOrWhiteSpace(updatePaper.NewImageUrl))
                updateDefinition = updateDefinition.Set(x => x.ImageUrl, updatePaper.NewImageUrl);

            //TODO: Use Id
            var filter = Builders<ResearchPaperModel>.Filter.Eq(x => x.Title, updatePaper.OldTitle); //Builders<ResearchPaperModel>.Filter.Eq(x => x.Id, updatePaper.Id);
            var result = await _researchPaperCollection.UpdateOneAsync(filter, updateDefinition);

            if (!result.IsAcknowledged || result.ModifiedCount == 0)
                return null;

            var updatedTitle = string.IsNullOrWhiteSpace(updatePaper.NewTitle) ? updatePaper.OldTitle : updatePaper.NewTitle;
            var updatedPaper = await _researchPaperCollection.Find(x => x.Title == updatedTitle).FirstOrDefaultAsync();

            if (updatedPaper is null)
                return null;

            return new UpdatePaperViewModel
            {
                OldTitle = updatePaper.OldTitle,
                NewTitle = updatedPaper.Title,
                NewUploaderEmail = updatedPaper.UploaderEmail,
                NewDescription = updatedPaper.Description,
                NewLink = updatedPaper.Link,
                NewImageUrl = updatedPaper.ImageUrl,
            };
        }

    }
}
