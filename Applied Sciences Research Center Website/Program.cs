using Applied_Sciences_Research_Center_Website.Extensions;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

var app = builder.Build();

app.UseStaticFiles();
app.UseRouting();
app.MapControllers();

app.ConfigureRoutes();

app.Run();
