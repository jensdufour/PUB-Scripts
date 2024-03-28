#!/bin/bash

# Check if the script has already run
if [ -f /var/run/aad_ubuntu_prereq.lock ]; then
    echo "Script has already run. Exiting..."
    exit 0
fi

# Create lock file to indicate that the script has run
sudo touch /var/run/aad_ubuntu_prereq.lock

# Check Ubuntu version
if [[ $(lsb_release -sr 2>/dev/null) == "23.04" || $(lsb_release -sr 2>/dev/null) == "23.10" ]]; then
    echo "Ubuntu version is supported."
else
    echo "Unsupported Ubuntu version."
    exit 1
fi

# Install the Microsoft GPG key
wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/ 
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list' 
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
sudo rm microsoft.gpg
sudo apt update

# Update Java for Microsoft Intune
sudo apt install -y openjdk-11-jre

# Install Microsoft Edge
sudo apt install -y microsoft-edge-stable

# Install Microsoft Intune
sudo apt install -y intune-portal

echo "Installation complete."
