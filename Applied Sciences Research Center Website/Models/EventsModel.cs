using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace Applied_Sciences_Research_Center_Website.Models
{
    public class EventsModel
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public ObjectId Id { get; set; }
        public string? ImageUrl { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? Date { get; set; }
        public string? HostName { get; set; }
    }
}
