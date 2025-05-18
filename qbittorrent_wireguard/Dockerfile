FROM tenseiken/qbittorrent-wireguard:5.1.0

# Install Bashio 0.17.0
RUN mkdir -p /tmp/bashio
RUN curl -f -L -s -S "https://github.com/hassio-addons/bashio/archive/v0.17.0.tar.gz" | tar -xzf - --strip 1 -C /tmp/bashio
RUN mv /tmp/bashio/lib /usr/lib/bashio
RUN ln -s /usr/lib/bashio/bashio /usr/bin/bashio
RUN rm -rf /tmp/bashio

# Print External IP on startup
RUN sed -i '1s|^#!.*$|&\n echo [INFO] External IP: $(curl -s icanhazip.com)|' /etc/qbittorrent/start.sh

# Edit Default QBitTorrent Config
RUN echo ''                                      >> /etc/qbittorrent/qBittorrent.conf
RUN echo 'WebUI\RootFolder="/etc/vuetorrent"'    >> /etc/qbittorrent/qBittorrent.conf
RUN echo 'WebUI\AlternativeUIEnabled=true'       >> /etc/qbittorrent/qBittorrent.conf
RUN echo 'WebUI\AuthSubnetWhitelistEnabled=true' >> /etc/qbittorrent/qBittorrent.conf
RUN echo 'WebUI\AuthSubnetWhitelist=localhost, 127.0.0.1, 172.30.0.0/16, 192.168.0.0/16'   >> /etc/qbittorrent/qBittorrent.conf
RUN sed -i 's|/downloads|/share/qBittorrent|g' /etc/qbittorrent/qBittorrent.conf

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT [ "/run.sh" ]

HEALTHCHECK \
    --interval=5s \
    --retries=5 \
    --start-period=30s \
    --timeout=25s \
    CMD pgrep qbittorrent || exit 1
