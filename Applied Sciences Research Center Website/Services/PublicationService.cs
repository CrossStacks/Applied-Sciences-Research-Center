using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.ViewModels;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace Applied_Sciences_Research_Center_Website.Services
{
    public class PublicationService
    {
        private readonly IMongoCollection<PublicationModel> _researchPaperCollection;

        public PublicationService(IMongoDatabase database)
        {
            _researchPaperCollection = database.GetCollection<PublicationModel>("ResearchPaper");
        }

        public async Task<PublicationModel> CreatePublication(PublicationViewModel vm)
        {
            PublicationModel model = new()
            {
                Title = vm.Title,
                DatePubish = 
                Description = vm.Description,
                Link = vm.Link,
                UploaderEmail = vm.UploaderEmail,
                ImageUrl = vm.ImageUrl,
            };

            await _researchPaperCollection.InsertOneAsync(model);

            return model;
        }

        public async Task<List<PublicationViewModel>> GetAll()
        {
            var papers = await _researchPaperCollection.Find(x => true).ToListAsync();

            List<PublicationViewModel> results = [];

            foreach (var paper in papers)
            {
                PublicationViewModel result = new()
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
        public async Task<string?> Delete(string title)
        {
            var result = await _researchPaperCollection.DeleteOneAsync(x => x.Title == title);
            if (result.DeletedCount > 0)
                return $"The research paper '{title}' has been successfully deleted.";
            else
                return "No record found";
        }
        public async Task<UpdatePublicationViewModel?> Update(UpdatePublicationViewModel up)
        {
            var paper = await _researchPaperCollection.Find(x => x.Title == up.OldTitle).FirstOrDefaultAsync();

            if (paper is null)
                return null;

            var updateDefinition = Builders<PublicationModel>.Update
                .Set(x => x.UploaderEmail, up.NewUploaderEmail);

            if (!string.IsNullOrWhiteSpace(up.NewTitle))
                updateDefinition = updateDefinition.Set(x => x.Title, up.NewTitle);

            if (!string.IsNullOrWhiteSpace(up.NewDescription))
                updateDefinition = updateDefinition.Set(x => x.Description, up.NewDescription);

            if (!string.IsNullOrWhiteSpace(up.NewLink))
                updateDefinition = updateDefinition.Set(x => x.Link, up.NewLink);

            if (!string.IsNullOrWhiteSpace(up.NewImageUrl))
                updateDefinition = updateDefinition.Set(x => x.ImageUrl, up.NewImageUrl);

            //TODO: Use Id
            var filter = Builders<PublicationModel>.Filter.Eq(x => x.Title, up.OldTitle); //Builders<ResearchPaperModel>.Filter.Eq(x => x.Id, updatePaper.Id);
            var result = await _researchPaperCollection.UpdateOneAsync(filter, updateDefinition);

            if (!result.IsAcknowledged || result.ModifiedCount == 0)
                return null;

            var updatedTitle = string.IsNullOrWhiteSpace(up.NewTitle) ? up.OldTitle : up.NewTitle;
            var updatedPaper = await _researchPaperCollection.Find(x => x.Title == updatedTitle).FirstOrDefaultAsync();

            if (updatedPaper is null)
                return null;

            return new UpdatePublicationViewModel
            {
                OldTitle = up.OldTitle,
                NewTitle = updatedPaper.Title,
                NewUploaderEmail = updatedPaper.UploaderEmail,
                NewDescription = updatedPaper.Description,
                NewLink = updatedPaper.Link,
                NewImageUrl = updatedPaper.ImageUrl,
            };
        }

    }
}
