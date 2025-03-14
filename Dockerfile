# Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY ["DockerizedMvcApp.csproj", "./"]
RUN dotnet restore "DockerizedMvcApp.csproj"
COPY . .
RUN dotnet publish "DockerizedMvcApp.csproj" -c Release -o /app/publish

# Use .NET 8 runtime to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DockerizedMcvApp.dll"]

