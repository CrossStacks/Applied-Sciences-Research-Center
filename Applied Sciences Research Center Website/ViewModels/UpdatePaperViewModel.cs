namespace Applied_Sciences_Research_Center_Website.ViewModels
{
    public class UpdatePaperViewModel
    {
        //public required string Id { get; set; }
        public required string OldTitle { get; set; }
        public required string NewUploaderEmail { get; set; }
        public string? NewTitle { get; set; }
        public string? NewDescription { get; set; }
        public string? NewLink { get; set; }
        public string? NewImageUrl { get; set; }
    }
}
