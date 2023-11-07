#!/bin/sh

# Install server / check for updates
steamcmd +login anonymous +app_update 2430930 validate +quit

# Start server with proton
SERVER_CMD="$PROTON run \"${ARK_PATH}/Binaries/Win64/ArkAscendedServer.exe\" \
  \"TheIsland_WP?listen?SessionName=\\\"${SESSION_NAME}\\\"?ServerAdminPassword=\\\"${ADMIN_PASSWORD}\\\"?Port=${GAME_PORT}?QueryPort=${QUERY_PORT}?MaxPlayers=${MAX_PLAYERS}?\""

# Install mods
if [ -n "$MODS" ]; then
  SERVER_CMD="$SERVER_CMD -automanagedmods -mods=$MODS"
fi

# Additional command line arguments
if [ -n "$CMD_ARGS" ]; then
  SERVER_CMD="$SERVER_CMD $CMD_ARGS"
fi

# Start the server
eval $SERVER_CMD > /dev/null 2>&1 &
SERVER_PID=$!

# Capture logs
tail -f --retry "${ARK_PATH}/Saved/Logs/ShooterGame.log" &

# Monitor server process
wait $SERVER_PID
exit $?
