#!/bin/bash

# Function to modify sshd_config
modify_sshd_config() {
  local config_file="/etc/ssh/sshd_config"
  if grep -q "^PrintLastLog" $config_file; then
    sudo sed -i 's/^PrintLastLog.*/PrintLastLog no/' $config_file
  else
    echo "PrintLastLog no" | sudo tee -a $config_file
  fi
}

# Remove default MOTD
sudo rm /etc/motd

# Clear all files in /etc/update-motd.d/
sudo rm -rf /etc/update-motd.d/*
sudo mkdir -p /etc/update-motd.d

# Modify sshd_config
modify_sshd_config

# Restart sshd
sudo systemctl restart sshd

# Copy files to /etc/update-motd.d
wget -O /etc/update-motd.d/10-welcome "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/update-motd.d/10-welcome"
wget -O /etc/update-motd.d/15-filesystem "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/update-motd.d/15-system"
wget -O /etc/update-motd.d/20-update "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/update-motd.d/20-update"

# Change owner of these files
sudo chown root:root /etc/update-motd.d/*

# Make them executable
sudo chmod +x /etc/update-motd.d/*

# Prompt the user for automating update counts
read -p "Would you like to automate adding update counts to the bottom of the motd? (yes/no): " automate

if [ "$automate" == "yes" ]; then
  # Create /etc/update-motd-static.d/
  sudo mkdir -p /etc/update-motd-static.d/

  # Copy file to /etc/update-motd-static.d
  wget -O /etc/update-motd-static.d/20-update "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/update-motd-static.d/20-update"

  # Change owner of files
  sudo chown root:root /etc/update-motd-static.d/*

  # Make them executable
  sudo chmod +x /etc/update-motd-static.d/*

  # Run the script silently to make sure it works
  sudo run-parts /etc/update-motd-static.d

  # Copy systemd files to /etc/systemd/system
  wget -O /etc/systemd/system/motd-update.timer "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/systemd-timer/motd-update.timer"
  wget -O /etc/systemd/system/motd-update.service "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/systemd-timer/motd-update.service"

  # Change ownership of the files to root
  sudo chown root:root /etc/systemd/system/motd-update.timer
  sudo chown root:root /etc/systemd/system/motd-update.service

  # Enable the timer
  sudo systemctl enable motd-update.timer

  # Start the timer
  sudo systemctl start motd-update.timer

  echo "Automation setup complete. The update count will check every day at 8pm."
else
  echo "Automation not set up. Update counts will not be added to the MOTD automatically."
fi

# Log it as complete
echo "Setup complete. Please test it using 'sudo run-parts /etc/update-motd.d'."
