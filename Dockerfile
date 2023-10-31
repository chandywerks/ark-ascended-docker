FROM steamcmd/steamcmd:latest

RUN apt-get update && apt-get install -y wget python3

ENV STEAM_PATH=$HOME/.steam/steam
RUN mkdir -p $STEAM_PATH
WORKDIR $STEAM_PATH

# Install Proton build from Glorious Eggroll
ARG PROTON_VERSION=GE-Proton8-21
RUN wget https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${PROTON_VERSION}/${PROTON_VERSION}.tar.gz
RUN mkdir compatibilitytools.d/
RUN tar -xf ${PROTON_VERSION}.tar.gz -C compatibilitytools.d/
RUN mkdir -p steamapps/compatdata/2430930
RUN cp -r compatibilitytools.d/${PROTON_VERSION}/files/share/default_pfx steamapps/compatdata/2430930
RUN ln -s ${STEAM_PATH}/compatibilitytools.d/${PROTON_VERSION}/proton /usr/local/bin
ENV STEAM_COMPAT_CLIENT_INSTALL_PATH=$STEAM_PATH
ENV STEAM_COMPAT_DATA_PATH=${STEAM_COMPAT_CLIENT_INSTALL_PATH}/steamapps/compatdata/2430930

# Server start script
COPY ark-server.sh /usr/local/bin/ark-server
RUN chmod +x /usr/local/bin/ark-server

WORKDIR $HOME 
ENTRYPOINT ["ark-server"]
