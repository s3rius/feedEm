#!/usr/bin/env bash
function cleanup {
    echo "Received stop signal. Removing containers."
    docker-compose down
}
docker-compose build
docker-compose run web rails db:reset
docker-compose run web rails yarn:install
docker-compose run web rails webpacker:compile
docker-compose down
docker-compose up

trap cleanup EXIT
