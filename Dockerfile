FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY Telegram.Bot.Examples.Echo/Telegram.Bot.Examples.Echo.csproj Telegram.Bot.Examples.Echo/
RUN dotnet restore Telegram.Bot.Examples.Echo/Telegram.Bot.Examples.Echo.csproj 
COPY . .
WORKDIR /src/Telegram.Bot.Examples.Echo/
RUN dotnet build Telegram.Bot.Examples.Echo.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish Telegram.Bot.Examples.Echo.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Telegram.Bot.Examples.Echo.dll"]
