# Uchu Docker

Docker setup for running the Uchu Lego Universe server

## Requirements

- Docker
- Docker Compose
- [LU unpacked client](https://docs.google.com/document/d/1XmHXWuUQqzUIOcv6SVVjaNBm4bFg9lnW4Pk1pllimEg/edit) with [LCDRs TcpUdp mod](https://github.com/lcdr/raknet_shim_dll/releases/tag/2020-09-03)

## Setup

Clone the repository recursively, so that the Uchu source is also pulled:

```bash
# If you prefer to use HTTPS (default)
git clone https://github.com/yuwui/Uchu --recursive -b master

# If you prefer to use SSH
git clone git@github.com:yuwui/Uchu.git --recursive -b master
```

Copy the `.env.sample` file to `.env`:

```bash
cp .env.sample .env
```

Set the `GAME_FOLDER` variable in the `.env` file to path to the `/res` folder in your unpacked `LU` game folder.

Next, create the `data` folder that's used to store the Postgres and Redis database files to ensure no loss of data:

```bash
mkdir data
```

Deleting this folder will result in your Postgres database being wiped, including all the progress you've made in-game, be cautious when handling this folder!

## Running

```bash
docker-compose up -d
```

This runs Uchu in the background along with Postgres, Redis and Adminer. You can attach to the `Uchu.Master` shell using:

```bash
docker attach uchudocker_uchu_1
```

This allows you to input shell commands like `/adduser <username>`. You can exit the shell using `Ctrl+C`.

## Closing

```bash
docker-compose down
```

## Adminer

Uchu Docker also automatically runs [Adminer](https://www.adminer.org), which allows you to easily modify the Uchu database in a user friendly way. After running Uchu Docker you can access Adminer through your browser at [this link](0.0.0.0:8080). Select the `PostgreSQL` database type, set the server to `db` and enter the credentials found in the `.env` file to login. More info on how to use Adminer can be found on their website.