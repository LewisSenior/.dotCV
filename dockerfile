FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env
WORKDIR /src
COPY ./ .
RUN ls -lah
RUN dotnet restore "./.dotCV.csproj"
RUN dotnet publish -c Release -o /app
WORKDIR /app
run ls -lah

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app ./
EXPOSE 80
ENTRYPOINT ["dotnet", ".dotCV.dll"]
