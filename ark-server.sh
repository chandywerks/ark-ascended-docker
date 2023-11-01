#!/bin/sh

# Install server / check for updates
steamcmd +login anonymous +app_update 2430930 validate +quit

# Start server with proton in the background
$PROTON run "${ARK_PATH}/Binaries/Win64/ArkAscendedServer.exe" \
  "TheIsland_WP?listen?SessionName=${SESSION_NAME}?ServerAdminPassword=${ADMIN_PASSWORD}?Port=7777?QueryPort=27015?MaxPlayers=${MAX_PLAYERS}?" &
SERVER_PID=$!

# Tail server logs to stdout
tail -f "${ARK_PATH}/Saved/Logs/ShooterGame.log" &
TAIL_PID=$!

# If the server process ends capture the exit code and end the container process
wait $SERVER_PID
exit $?
