using MongoDB.Bson;

namespace Applied_Sciences_Research_Center_Website.ViewModels
{
    public class UserViewModel
    {
        public required string Name { get; set; }
        public required string Email { get; set; }
        public required string Password { get; set; }
        public required string Role { get; set; }
        public string? Token { get; set; }
        public ObjectId id { get; set; }
    }
}
