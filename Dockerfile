FROM steamcmd/steamcmd:latest

RUN apt-get update && apt-get install -y wget python3 libfreetype6

ENV STEAM_PATH=$HOME/.steam/steam
RUN mkdir -p $STEAM_PATH
WORKDIR $STEAM_PATH

# Install Proton build from Glorious Eggroll
ENV PROTON_VERSION=GE-Proton8-26
RUN mkdir -p compatibilitytools.d/
RUN wget -O - \
  https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${PROTON_VERSION}/${PROTON_VERSION}.tar.gz \
  | tar -xz -C compatibilitytools.d/
RUN mkdir -p steamapps/compatdata/2430930
RUN cp -r compatibilitytools.d/${PROTON_VERSION}/files/share/default_pfx steamapps/compatdata/2430930

# Export Proton paths
ENV STEAM_COMPAT_CLIENT_INSTALL_PATH=$STEAM_PATH
ENV STEAM_COMPAT_DATA_PATH=${STEAM_PATH}/steamapps/compatdata/2430930
ENV PROTON=${STEAM_PATH}/compatibilitytools.d/${PROTON_VERSION}/proton

# Server Ark start script
ENV ARK_PATH="${STEAM_PATH}/steamapps/common/ARK Survival Ascended Dedicated Server/ShooterGame"
COPY ark-server.sh /usr/local/bin/ark-server
RUN chmod +x /usr/local/bin/ark-server

WORKDIR $HOME
ENTRYPOINT ["ark-server"]
