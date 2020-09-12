FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine
ENV PATH $PATH:/root/.dotnet/tools

COPY Uchu .
COPY config.xml .

RUN dotnet build
ENTRYPOINT ["dotnet", "Uchu.Master/bin/Debug/netcoreapp3.1/Uchu.Master.dll"]