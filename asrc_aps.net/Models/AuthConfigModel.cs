namespace Applied_Sciences_Research_Center_Website.Models
{
    public class AuthConfigModel
    {
        public string JwtSecretKey { get; set; } = null!;
        public string JwtIssuer { get; set; } = null!;
        public string JwtAudience { get; set; } = null!;
        public string PasswordHashSalt { get; set; } = null!;
        public string PasswordHashPepper { get; set; } = null!;
    }
}
