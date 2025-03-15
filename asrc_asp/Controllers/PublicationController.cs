using Dapper;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;

namespace asrc_asp.Controllers
{
    [Route("api/[controller]")]
    public class PublicationController : Controller
    {
        private readonly string _connectionString;

        public PublicationController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnectionString")!;
        }

        [HttpGet("GetPublications")]
        public async Task<IActionResult> GetPublications()
        {
            using IDbConnection db = new MySqlConnection(_connectionString);
            var data = await db.QueryAsync("SELECT j.journal_id, j.path, js.setting_value AS description, s.submission_id, s.date_submitted, s.status, sf.submission_file_id, sf.file_id FROM journals j LEFT JOIN journal_settings js ON j.journal_id = js.journal_id AND js.setting_name = 'description' LEFT JOIN submissions s ON j.journal_id = s.context_id LEFT JOIN submission_files sf ON s.submission_id = sf.submission_id WHERE j.enabled = 1; ");
            return Ok(data);
        }
    }
}
