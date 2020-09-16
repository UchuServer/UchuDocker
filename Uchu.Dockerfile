FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine
COPY Uchu config.default.xml .env ./

RUN apk update && apk add --no-cache gettext && apk add --no-cache openssl

RUN set -o allexport && source .env && set +o allexport && envsubst < config.default.xml > config.xml
RUN dotnet build

ENTRYPOINT ["dotnet", "Uchu.Master/bin/Debug/netcoreapp3.1/Uchu.Master.dll"]