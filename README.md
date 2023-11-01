# ARK: Survival Ascended Docker Server

Ark server in a docker container using GloriousEggroll's custom [proton build](https://github.com/GloriousEggroll/proton-ge-custom)

1) Install [docker](https://docs.docker.com/engine/install/) and the [docker compose](https://docs.docker.com/compose/install/) plugin
2) Copy `.env.example` to `.env` and configure
3) Run `docker compose up --build`

*Forward ports `27015` and `7777` to your docker host machine*

Your server files will be avilable under the docker volume directory `/var/lib/docker/volumes/ark-data/_data/ShooterGame/`
