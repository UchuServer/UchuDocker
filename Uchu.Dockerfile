FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine

RUN apk update && apk add --no-cache gettext curl python3 py3-pip

# Adds the uchu cli as a top level command
ENV ENV="/root/.ashrc"
RUN pip install uchu-cli
RUN echo "alias cli=\"python3 -m uchu-cli\"" > "$ENV"

COPY Uchu .
RUN dotnet build --configuration Release

# Dynamically build the config file
COPY config.default.xml .env cert.pfx* ./
RUN set -o allexport && source .env && set +o allexport && envsubst < config.default.xml > config.xml

ENTRYPOINT ["dotnet", "Uchu.Master/bin/Release/netcoreapp3.1/Uchu.Master.dll"]
