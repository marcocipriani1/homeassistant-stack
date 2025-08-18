#!/bin/bash
# Setup script for homeassistant stack on docker
# Run this script with root privileges
set -e

echo " Starting home assistant stack setup..."
echo ""

# Creating base dir

mkdir -p "/opt/stacks/hass"

# Creating mosquitto dir

mkdir -p "/opt/stacks/hass/mosquitto/config"

# Creating Node Red dir

mkdir -p "/opt/stacks/hass/nodered"

# Creating zigbee2mqtt dir

mkdir /opt/stacks/hass/zigbee2mqtt/data

# Creating matter dir

mkdir /opt/stacks/hass/home-assistant-matter-hub

# Creating mosquitto config file

cat > /opt/stacks/hass/mosquitto/config/mosquitto.conf <<EOF
persistence true
persistence_location /mosquitto/data/
log_dest file /mosquitto/log/mosquitto.log
listener 1883
listener 9001
allow_anonymous false
password_file /mosquitto/config/passwd
EOF

# Creating mosquitto user

groupadd -g 1883 mosquitto

useradd -u 1883 -g 1883 mosquitto

# Set proper dir ownership

chown -R mosquitto: /opt/stacks/hass/mosquitto

chown 1000:1000 /opt/stacks/hass/nodered

echo ""
echo " The installation process for the home assistant stack is finished"
echo " Start the stack with docker compose up -d"