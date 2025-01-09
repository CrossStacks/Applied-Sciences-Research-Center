namespace Applied_Sciences_Research_Center_Website.ViewModels
{
    public class ResearchPaperViewModel
    {
        public required string Title { get; set; }
        public required string UploaderEmail { get; set; }
        public required string Link { get; set; }
        public required string Description { get; set; }
        public string? ImageUrl { get; set; }
    }
}
