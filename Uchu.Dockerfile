FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine
COPY Uchu config.default.xml .env cert.pfx* ./

RUN apk update && apk add --no-cache gettext curl python3 py3-pip
RUN pip install uchu-cli

RUN set -o allexport && source .env && set +o allexport && envsubst < config.default.xml > config.xml
RUN dotnet build --configuration Release

# Adds the uchu cli as a top level command
ENV ENV="/root/.ashrc"
RUN echo "alias cli=\"python3 -m uchu-cli\"" > "$ENV"

ENTRYPOINT ["dotnet", "Uchu.Master/bin/Release/netcoreapp3.1/Uchu.Master.dll"]