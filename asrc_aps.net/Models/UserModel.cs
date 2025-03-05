using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace Applied_Sciences_Research_Center_Website.Models
{
    public class UserModel
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public ObjectId Id { get; set; }
        public required string Name { get; set; }
        public required string Email { get; set; }
        public required string Password { get; set; }
        public required string Role { get; set; }
        public int RequestCount { get; set; }
    }
}
