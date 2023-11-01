#!/bin/sh

# Install server / check for updates
steamcmd +login anonymous +app_update 2430930 validate +quit

# Start server with proton
SERVER_CMD="$PROTON run \"${ARK_PATH}/Binaries/Win64/ArkAscendedServer.exe\" \
  \"TheIsland_WP?listen?SessionName=${SESSION_NAME}?ServerAdminPassword=${ADMIN_PASSWORD}?Port=${GAME_PORT}?QueryPort=${QUERY_PORT}?MaxPlayers=${MAX_PLAYERS}?\""

# Enable logs
SERVER_CMD="$SERVER_CMD -servergamelog -servergamelogincludetribelogs"

# Configure mods
if [ -n "$MODS" ]; then
  SERVER_CMD="$SERVER_CMD -automanagedmods -mods=$MODS"
fi

# Additional command line arguments
if [ -n "$CMD_ARGS" ]; then
  SERVER_CMD="$SERVER_CMD $CMD_ARGS"
fi

eval $SERVER_CMD
exit $?
