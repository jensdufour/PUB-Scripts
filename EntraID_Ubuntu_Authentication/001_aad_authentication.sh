#!/bin/bash

# Replace these two variables with your relevant Tenant ID and Client Secret Value  
tenant_id="<tenant-id>"
app_id="<app-id>"
domain="<domain>"

# Check if the script has already run
if [ -f /var/run/aad_ubuntu.lock ]; then
    echo "Script has already run. Exiting..."
    exit 0
fi

# Create lock file to indicate that the script has run
sudo touch /var/run/aad_ubuntu.lock

# Check Ubuntu version
if [[ $(lsb_release -sr 2>/dev/null) == "23.04" || $(lsb_release -sr 2>/dev/null) == "23.10" ]]; then
    echo "Ubuntu version is supported."
else
    echo "Unsupported Ubuntu version."
    exit 1
fi

# Install required packages
sudo apt-get update
sudo apt-get install -y libpam-aad libnss-aad aad-cli

# Configure Azure Active Directory Authentication
echo "auth [success=1 default=ignore] pam_aad.so" | sudo tee -a /etc/pam.d/common-auth

# Enable home directory creation on login
sudo pam-auth-update --enable mkhomedir

# Add your tenant details to the configuration file
sudo truncate -s 0 /etc/aad.conf
echo "tenant_id = $tenant_id" | sudo tee -a /etc/aad.conf
echo "app_id = $app_id" | sudo tee -a /etc/aad.conf
echo "[$domain]" | sudo tee -a /etc/aad.conf
echo "offline_credentials_expiration = 30" | sudo tee -a /etc/aad.conf
echo "homedir = /home/$domain/%u" | sudo tee -a /etc/aad.conf
echo "shell = /bin/zsh" | sudo tee -a /etc/aad.conf

# Restart services
sudo systemctl restart systemd-logind.service
echo "Entra ID Authentication setup complete."
exit 0
