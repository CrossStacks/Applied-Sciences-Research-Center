using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace Applied_Sciences_Research_Center_Website.Models
{
    public class ResearchPaperModel
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public ObjectId Id { get; set; }
        public required string Title { get; set; }
        public required string UploaderEmail { get; set; }
        public required string Link { get; set; }
        public required string Description { get; set; }
        public string? ImageUrl { get; set; }
    }
}
