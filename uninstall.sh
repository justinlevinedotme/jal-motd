#!/bin/bash

# Function to modify sshd_config back to default
reset_sshd_config() {
  local config_file="/etc/ssh/sshd_config"
  if grep -q "^PrintLastLog no" $config_file; then
    sudo sed -i 's/^PrintLastLog no/PrintLastLog yes/' $config_file
  fi
}

# Remove the custom MOTD scripts
sudo rm -rf /etc/update-motd.d/*

# Remove the MOTD static directory if it exists
if [ -d "/etc/update-motd-static.d" ]; then
  sudo rm -rf /etc/update-motd-static.d
fi

# Remove the systemd timer and service files if they exist
if [ -f "/etc/systemd/system/motd-update.timer" ]; then
  sudo systemctl disable motd-update.timer
  sudo rm /etc/systemd/system/motd-update.timer
fi

if [ -f "/etc/systemd/system/motd-update.service" ]; then
  sudo rm /etc/systemd/system/motd-update.service
fi

# Restart sshd to apply changes
reset_sshd_config
sudo systemctl restart sshd

# Log it as complete
echo "Uninstallation complete. The MOTD setup and automation have been removed."
