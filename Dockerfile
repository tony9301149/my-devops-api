FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# 複製專案檔並還原套件
COPY *.csproj ./
RUN dotnet restore

# 複製其餘程式碼並發佈
COPY . ./
RUN dotnet publish -c Release -o out

# 建立執行環境
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "DemoApi.dll"]
