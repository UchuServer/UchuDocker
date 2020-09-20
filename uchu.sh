#!/usr/bin/env bash
# WIP Install script

if ! [ -f ".env" ]; then
    echo "Environment file does not exist yet, setting it up for you."
    echo "Please specify a valid absolute path to the /res folder inside your LU client (make sure to escape spaces):"

    while ! [ -d "$GAME_FOLDER" ]; do
        read GAME_FOLDER
        if ! [ -d "$GAME_FOLDER" ]; then
            echo "$GAME_FOLDER is not a valid directory, retry:"
        fi
    done

    if ! [ -d "$GAME_FOLDER/../mods" ]; then
        echo "It seems like you don't have the TcpUdp mod installed in your client, you won't be able to connect with Uchu until you install this mod. More information can be found in the README."
    else
        echo "$GAME_FOLDER seems like a valid location, continuing."
    fi

    sed "s|/res|$GAME_FOLDER|g" .env.sample > .env

    echo "Finished setting up environment file."
fi

if ! [ -d "data" ]; then
    echo "Database folder not found, adding \"data\" folder."
    mkdir data
fi

if [ -x "$(command -v docker)" ] && [ -x "$(command -v docker-compose)" ]; then
    echo "Starting Uchu"
    docker-compose up --build
else
    echo "You don't have docker or docker-compose installed, refer to the README for installation instructions."
fi