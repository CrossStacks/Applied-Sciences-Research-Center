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
            var data = await db.QueryAsync("SELECT j.journal_id, j.path, js_description.setting_value AS description, js_contactName.setting_value AS contact_name, js_contactEmail.setting_value AS contact_email, \r\n       s.submission_id, s.date_submitted, s.status, \r\n       sf.submission_file_id, sf.file_id, \r\n       f.path AS file_path\r\nFROM journals j\r\nLEFT JOIN journal_settings js_description ON j.journal_id = js_description.journal_id AND js_description.setting_name = 'description'\r\nLEFT JOIN journal_settings js_contactName ON j.journal_id = js_contactName.journal_id AND js_contactName.setting_name = 'contactName'\r\nLEFT JOIN journal_settings js_contactEmail ON j.journal_id = js_contactEmail.journal_id AND js_contactEmail.setting_name = 'contactEmail'\r\nLEFT JOIN submissions s ON j.journal_id = s.context_id\r\nLEFT JOIN submission_files sf ON s.submission_id = sf.submission_id\r\nLEFT JOIN files f ON sf.file_id = f.file_id  \r\nWHERE j.enabled = 1;");
            return Ok(data);
        }
    }
}
