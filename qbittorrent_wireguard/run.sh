#!/usr/bin/bashio

bashio::log.info "Starting Addon run.sh"

# Create required directories
mkdir -p /config/wireguard
mkdir -p /share/qBittorrent

export ENABLEPROTONVPNPORTFWD=$([ "$(bashio::config 'enable_protonvpn_port_forwarding')" = "true" ] && echo 1 || echo 0)
export LAN_NETWORK=$(bashio::config 'lan_network')
export NAME_SERVERS=$(bashio::config 'name_servers')
export ENABLE_SSL="no"

export PUID=0
export PGID=0

# start the base image entrypoint
bashio::log.info "Starting base image entrypoint"
/start.sh
