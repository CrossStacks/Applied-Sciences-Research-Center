namespace Applied_Sciences_Research_Center_Website.Extensions
{
    public static class RouteConfig
    {
        public static void ConfigureRoutes(this IEndpointRouteBuilder app)
        {
            app.MapGet("/", async context =>
            {
                context.Response.ContentType = "text/html";
                await context.Response.SendFileAsync("wwwroot/html/index.html");
            }); 
            
            app.MapGet("login/", async context =>
            {
                context.Response.ContentType = "text/html";
                await context.Response.SendFileAsync("wwwroot/html/login.html");
            });
        }
    }
}
