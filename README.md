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

Set the `GAME_FOLDER` variable in the `.env` file to the absolute path to the `/res` folder in your unpacked `LU` game folder.

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

Uchu Docker also automatically runs [Adminer](https://www.adminer.org), which allows you to easily modify the Uchu database in a user friendly way. After running Uchu Docker you can access Adminer through your browser at 0.0.0.0:8080 (or at 0.0.0.0:$ADMINER_PORT if you changed this in the `.env` file). Select the `PostgreSQL` database type, set the server to `db` and enter the credentials found in the `.env` file to login. More info on how to use Adminer can be found on their website.

## World ports (Advanced)

If you wish to change the world ports, you can change the exposed ports in the `.env` file easily. The internal ports are locked by default to `2002` for the charater port and `10000-10100` for the api and world ports. If you wish to change these internal ports update the internal port values in the `.env` file. Ensure that `INTERNAL_API_PORT_RANGE` is updated to match your updated `INTERNAL_API_PORT` and `INTERNAL_MAX_WORLDS`.