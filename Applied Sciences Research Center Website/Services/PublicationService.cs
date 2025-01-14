using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.ViewModels;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace Applied_Sciences_Research_Center_Website.Services
{
    public class PublicationService
    {
        private readonly IMongoCollection<PublicationModel> _publicationsCollection;

        public PublicationService(IMongoDatabase database)
        {
            _publicationsCollection = database.GetCollection<PublicationModel>("Publications");
        }

        public async Task<PublicationModel> CreatePublication(PublicationViewModel vm)
        {
            PublicationModel model = new()
            {
                Title = vm.Title,
                DatePubish = vm.DatePubish,
                Description = vm.Description,
                Type = vm.Type,
                Link = vm.Link,
                UploaderEmail = vm.UploaderEmail,
                ImageUrl = vm.ImageUrl,
            };

            await _publicationsCollection.InsertOneAsync(model);

            return model;
        }

        public async Task<List<PublicationViewModel>> GetAll()
        {
            var publications = await _publicationsCollection.Find(x => true).ToListAsync();

            List<PublicationViewModel> results = [];

            foreach (var publication in publications)
            {
                PublicationViewModel result = new()
                {
                    Title = publication.Title,
                    Description = publication.Description,
                    Type = publication.Type,
                    DatePubish = publication.DatePubish,
                    Link = publication.Link,
                    UploaderEmail = publication.UploaderEmail,
                    ImageUrl = publication.ImageUrl,
                };

                results.Add(result);
            }
            return results;
        }
        public async Task<string?> Delete(string title)
        {
            var result = await _publicationsCollection.DeleteOneAsync(x => x.Title == title);
            if (result.DeletedCount > 0)
                return $"'{title}' has been successfully deleted.";
            else
                return "No record found";
        }
        public async Task<UpdatePublicationViewModel?> Update(UpdatePublicationViewModel up)
        {
            var paper = await _publicationsCollection.Find(x => x.Title == up.OldTitle).FirstOrDefaultAsync();

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
            var result = await _publicationsCollection.UpdateOneAsync(filter, updateDefinition);

            if (!result.IsAcknowledged || result.ModifiedCount == 0)
                return null;

            var updatedTitle = string.IsNullOrWhiteSpace(up.NewTitle) ? up.OldTitle : up.NewTitle;
            var updatedPublication = await _publicationsCollection.Find(x => x.Title == updatedTitle).FirstOrDefaultAsync();

            if (updatedPublication is null)
                return null;

            return new UpdatePublicationViewModel
            {
                OldTitle = up.OldTitle,
                NewTitle = updatedPublication.Title,
                NewUploaderEmail = updatedPublication.UploaderEmail,
                NewDescription = updatedPublication.Description,
                NewLink = updatedPublication.Link,
                NewImageUrl = updatedPublication.ImageUrl,
            };
        }

    }
}
