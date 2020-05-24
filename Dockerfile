FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
ENV PROJECT_NAME=BlazorApp1
WORKDIR /src
COPY $PROJECT_NAME.csproj .
RUN dotnet restore "$PROJECT_NAME.csproj"
COPY . .
RUN dotnet publish "$PROJECT_NAME.csproj" -c Release -o /app/publish

FROM nginx:alpine AS final
WORKDIR /usr/share/nginx/html
COPY --from=build /app/publish/wwwroot .