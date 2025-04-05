using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Http;
using System;

var builder = WebApplication.CreateBuilder(args);

// appsettings.json'dan bağlantı dizesini al
var configuration = builder.Configuration;
var connectionString = configuration.GetConnectionString("DefaultConnection");

if (string.IsNullOrEmpty(connectionString))
{
    throw new InvalidOperationException("Bağlantı dizesi (DefaultConnection) bulunamadı. Lütfen appsettings.json dosyanızı kontrol edin.");
}

// DbContext ve diğer servisler
builder.Services.AddDbContext<TrakStoreDbContext>(options =>
    options.UseSqlServer(connectionString));

// CORS yapılandırması
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()  // Bütün origin'lere izin verir
               .AllowAnyMethod()  // Bütün HTTP metodlarına izin verir
               .AllowAnyHeader(); // Bütün header'lara izin verir
    });
});

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Middleware yapılandırması
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// CORS'u kullanmaya başla
app.UseCors("AllowAll");

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

// Varsayılan root endpoint
app.MapGet("/", async context =>
{
    await context.Response.WriteAsync("TrakStore API Çalışıyor...");
});

app.Run();
