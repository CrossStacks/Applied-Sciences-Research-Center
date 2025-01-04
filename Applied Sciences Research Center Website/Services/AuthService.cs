using Applied_Sciences_Research_Center_Website.Models;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace Applied_Sciences_Research_Center_Website.Services
{
    public class AuthService(IOptions<AuthConfigModel> authConfig)
    {
        private readonly string _secretKey = authConfig.Value.JwtSecretKey;
        private readonly string _jwtIssuer = authConfig.Value.JwtIssuer;
        private readonly string _jwtAudience = authConfig.Value.JwtAudience;

        private readonly string _passwordHashSalt = authConfig.Value.PasswordHashSalt;
        private readonly string _passwordHashPepper = authConfig.Value.PasswordHashPepper;

        public string GenerateToken(string email, string role)
        {
            var claims = new List<Claim>
            {
                new(ClaimTypes.Email, email),
                new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new(ClaimTypes.Role, role)
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_secretKey));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(_jwtIssuer, _jwtAudience, claims,
                                             expires: DateTime.UtcNow.AddHours(24 * 10),
                                             signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public string EncryptPassword(string password, int iteration = 3)
        {
            if (iteration <= 0) return password;

            using var sha256 = SHA256.Create();
            var passwordSaltPepper = $"{password}{_passwordHashSalt}{_passwordHashPepper}";
            var byteValue = Encoding.UTF8.GetBytes(passwordSaltPepper);
            var byteHash = sha256.ComputeHash(byteValue);
            var hash = Convert.ToBase64String(byteHash);
            return EncryptPassword(hash, iteration - 1);
        }
    }
}
