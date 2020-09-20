# Uchu Docker

Docker setup for running the Uchu Lego Universe server

## Requirements

- Docker
- Docker Compose (a version that supports at least docker-compose v3.3 files)
- [LU unpacked client](https://docs.google.com/document/d/1XmHXWuUQqzUIOcv6SVVjaNBm4bFg9lnW4Pk1pllimEg/edit) with [LCDRs TcpUdp mod](https://github.com/lcdr/raknet_shim_dll/releases/tag/2020-09-03)

## Setup

#### Downloading the source

Clone the repository recursively, so that the Uchu source is also pulled:

```bash
# If you prefer to use HTTPS (default)
git clone https://github.com/MickVermeulen/UchuDocker.git --recursive -b master

# If you prefer to use SSH
git clone git@github.com:MickVermeulen/UchuDocker.git --recursive -b master
```

#### Setting up your environment

Copy the `.env.sample` file to `.env`:

```bash
# On Linux, MacOS and Powershell
cp .env.sample .env

# On Windows CMD
copy .env.sample .env
```

Set the `GAME_FOLDER` variable in the `.env` file to the absolute path to the `/res` folder in your unpacked `LU` game folder using a text editor of your choice.

#### Setting up data storage

Create a data folder which will store your database files to ensure no loss of data:

```bash
mkdir data
```

This can also be done by creating a new folder named `data` manually, without the terminal.

## Running

```bash
docker-compose up -d
```

This runs Uchu in the background along with Postgres and Redis. You can attach to the `Uchu.Master` shell using:

```bash
docker attach uchudocker_uchu_1
```

This allows you to input shell commands like `/adduser <username>`. You can exit the shell using `Ctrl+P + Ctrl+Q` (`Ctrl+C` closes the container, not just your attach session).

## Closing

```bash
docker-compose down
```

## Applying changes to .env

When applying any changes to the `.env` file after your initial `docker-compose up -d`, the changes aren't built into the container. First run `docker-compose build --no-cache` to apply your `.env` file changes after which `docker-compose up -d` can be used again to start up Uchu. Note that this is not required if you only changed the LU resource location before running your first `docker-compose up -d`, but is required for any subsequent changes.

## Adminer

Uchu Docker can also run [Adminer](https://www.adminer.org), which allows you to easily modify the Uchu database in a user friendly way. You can activate this by uncommenting the lines after `# Uncomment this if you wish to use adminer` in `docker-compose.yaml`, note that you probably don't need this by default but can assist with more user friendly database management. Select the `PostgreSQL` database type, set the server to `db` and enter the credentials found in the `.env` file to login. More info on how to use Adminer can be found on their website.

## Hosting (Advanced)

This Docker setup can be used to host Uchu as long as all ports are exposed (see the .env.sample file for all ports that need to be exposed). Do note that hosting Uchu on anything other than `localhost` requires a valid PFX certificate from a trusted CA like Let's Encrypt and therefore also a valid domain name. You *cannot* use a self signed certificate even if you first generate your own root certificate, as the TcpUdp mod does not look at the OS certificate store for valid root certificates. You can add a certificate to the container by adding it to this directory under the name `cert.pfx`. Finally set the `HOSTNAME` variable in the `.env` file to the hostname for the certificate.