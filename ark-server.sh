#!/bin/sh

# Install server / check for updates
steamcmd +login anonymous +app_update 2430930 validate +quit

# Start server with proton
cd ${STEAM_PATH}/steamapps/common/ARK\ Survival\ Ascended\ Dedicated\ Server/ShooterGame/Binaries/Win64
${STEAM_PATH}/compatibilitytools.d/GE-Proton8-21/proton run ArkAscendedServer.exe "TheIsland_WP?listen?SessionName=${SESSION_NAME}?ServerAdminPassword=${ADMIN_PASSWORD}?Port=7777?QueryPort=27015?MaxPlayers=${MAX_PLAYERS}?"
