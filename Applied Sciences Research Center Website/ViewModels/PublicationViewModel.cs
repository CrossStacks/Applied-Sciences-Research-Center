namespace Applied_Sciences_Research_Center_Website.ViewModels
{
    public class PublicationViewModel
    {
        public required int SR { get; set; }
        public required string Title { get; set; }
        public required string UploaderEmail { get; set; }
        public required string Link { get; set; }
        public required string Description { get; set; }
        public required string DatePubish { get; set; }
        public required string Type { get; set; } // Book, ResearchPaper, Journal, Artical
        public string? ImageUrl { get; set; }
    }
}
