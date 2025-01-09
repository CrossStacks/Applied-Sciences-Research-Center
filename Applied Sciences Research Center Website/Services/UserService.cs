using Applied_Sciences_Research_Center_Website.Models;
using Applied_Sciences_Research_Center_Website.ViewModels;
using Microsoft.Extensions.Options;
using MongoDB.Driver;
using System.Net.Mail;
using System.Security.Claims;

namespace Applied_Sciences_Research_Center_Website.Services
{
    public class UserService
    {
        private readonly IMongoCollection<UserModel> _usersCollection;
        private readonly AuthService authService;

        public UserService(IMongoDatabase database, IOptions<AuthConfigModel> authConfig)
        {
            _usersCollection = database.GetCollection<UserModel>("Users");
            authService = new AuthService(authConfig);
        }

        public async Task<UserModel> CreateUser(CreateUserViewModel createUserVM)
        {
            createUserVM.Password = authService.EncryptPassword(createUserVM.Password);
            UserModel user = new()
            {
                Email = createUserVM.Email,
                Password = createUserVM.Password,
                Name = createUserVM.Name,
                Role = createUserVM.Role
            };

            await _usersCollection.InsertOneAsync(user);

            return user;
        }

        public async Task<UpdateUserViewModel?> UpdateUser(UpdateUserViewModel updateUserVM)
        {
            var filter = Builders<UserModel>.Filter.Eq("Email", updateUserVM.Email);

            var update = Builders<UserModel>.Update
                .Set("Name", updateUserVM.Name)
                .Set("Password", authService.EncryptPassword(updateUserVM.Password))
                .Set("Role", updateUserVM.Role);

            var result = _usersCollection.UpdateOne(filter, update);

            if (!result.IsAcknowledged || result.ModifiedCount == 0)
                return null;

            var newDbUser = await _usersCollection.Find(x => x.Email == updateUserVM.Email).FirstOrDefaultAsync();

            UpdateUserViewModel newUser = new()
            {
                Email = newDbUser.Email,
                Password = newDbUser.Password,
                Name = newDbUser.Name,
                Role = newDbUser.Role
            };
            return newUser;
        }

        public async Task<List<UserViewModel>> GetAllUsers()
        {
            List<UserModel> users = await _usersCollection.Find(x => true).ToListAsync();

            List<UserViewModel> result = [];

            foreach (var user in users)
            {
                UserViewModel userVM = new()
                {
                    Name = user.Name,
                    Email = user.Email,
                    Password = user.Password,
                    Role = user.Role
                };

                result.Add(userVM);
            }
            return result;
        }

        public async Task<UserViewModel?> GetUserByEmail(string email)
        {
            email = email.ToLower();
            UserModel user = await _usersCollection.Find(x => x.Email == email).FirstOrDefaultAsync();
            if (user is null)
                return null;
            UserViewModel userView = new()
            {
                Name = user.Name,
                Email = user.Email,
                Password = user.Password,
                Role = user.Role,
                id = user.Id
            };

            return userView;
        }

        public async Task<String?> DeleteUser(string email)
        {
            UserModel user = await _usersCollection.Find(x => x.Email == email).FirstOrDefaultAsync();
            if (user is null)
                return "No record found";

            var filter = Builders<UserModel>.Filter.Eq("Email", email);

            var result = _usersCollection.DeleteOne(filter);

            if (result.DeletedCount > 0)
                return $"The account linked to {email} has been successfully deleted.";

            return null;
        }


        public void UpdateUsersRequestCount(IMongoCollection<UserModel> usersCollection, HttpContext httpContext)
        {
            var UserEmail = httpContext.User.FindFirstValue(ClaimTypes.Email);
            var updateRequestCount = Builders<UserModel>.Update.Inc("RequestCount", 1);
            var updateDefinition = Builders<UserModel>.Update.Combine(updateRequestCount);
            var updateResult = usersCollection.UpdateOne(x => x.Email == UserEmail, updateDefinition);
        }
    }
}
