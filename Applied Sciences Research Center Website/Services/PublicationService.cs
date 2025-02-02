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

        public async Task<PublicationModel> CreatePublication(CreatePublicationViewModel vm)
        {
            var allPublications = await _publicationsCollection.Find(x => true).ToListAsync();

            int sr;

            if (allPublications.Count == 0)
            {
                sr = 0;
            }
            else
            {
                sr = allPublications.LastOrDefault()!.SR + 1;
            }

            PublicationModel model = new()
            {
                SR = sr,
                Title = vm.Title,
                DatePublish = vm.DatePublish,
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
                    SR = publication.SR,
                    Title = publication.Title,
                    Description = publication.Description,
                    Type = publication.Type,
                    DatePublish = publication.DatePublish,
                    Link = publication.Link,
                    UploaderEmail = publication.UploaderEmail,
                    ImageUrl = publication.ImageUrl,
                };

                results.Add(result);
            }
            return results;
        }

        public async Task<PublicationViewModel> GetBySr(int sr)
        {
            var publication = await _publicationsCollection.Find(x => x.SR == sr).FirstOrDefaultAsync();

            PublicationViewModel result = new()
            {
                SR = publication.SR,
                Title = publication.Title,
                Description = publication.Description,
                Type = publication.Type,
                DatePublish = publication.DatePublish,
                Link = publication.Link,
                UploaderEmail = publication.UploaderEmail,
                ImageUrl = publication.ImageUrl,
            };

            return result;
        }

        public async Task<string?> Delete(int sr)
        {
            var result = await _publicationsCollection.DeleteOneAsync(x => x.SR == sr);
            if (result.DeletedCount > 0)
                return $"'{sr}' has been successfully deleted.";
            else
                return "No record found";
        }
        public async Task<UpdatePublicationViewModel?> Update(UpdatePublicationViewModel up)
        {
            var paper = await _publicationsCollection.Find(x => x.SR == up.SR).FirstOrDefaultAsync();

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

            if (!string.IsNullOrWhiteSpace(up.NewTitle))
                updateDefinition = updateDefinition.Set(x => x.Title, up.NewTitle);

            var filter = Builders<PublicationModel>.Filter.Eq(x => x.SR, up.SR);
            var result = await _publicationsCollection.UpdateOneAsync(filter, updateDefinition);

            if (!result.IsAcknowledged || result.ModifiedCount == 0)
                return null;

            var updatedPublication = await _publicationsCollection.Find(x => x.SR == up.SR).FirstOrDefaultAsync();

            if (updatedPublication is null)
                return null;

            return new UpdatePublicationViewModel
            {
                SR = updatedPublication.SR,
                NewTitle = updatedPublication.Title,
                NewUploaderEmail = updatedPublication.UploaderEmail,
                NewDescription = updatedPublication.Description,
                NewLink = updatedPublication.Link,
                NewImageUrl = updatedPublication.ImageUrl,
            };
        }

    }
}
