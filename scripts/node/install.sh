#!/bin/bash

# Update package repositories
apt update

# Install essential packages
apt install -y curl git unzip wget build-essential libxml2-dev libssl-dev libbz2-dev libjpeg-dev libpng-dev libwebp-dev libxpm-dev libfreetype6-dev libonig-dev libcurl4-openssl-dev libreadline-dev libzip-dev libtidy-dev libxslt1-dev libssl-dev libicu-dev
mkdir /devops/

# Install NVM (Node Version Manager)
curl -o /devops/nvm-install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh
mkdir /devops/nvm
export NVM_DIR="/devops/nvm"  # Define the installation directory
bash /devops/nvm-install.sh  # Run the NVM installation script
export NVM_DIR="/devops/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion
nvm install 16.16.0
node -v

echo "Installation completed."