#!/bin/bash

# Update package repositories
sudo apt update

# Install essential packages
sudo apt install -y curl git unzip wget build-essential libxml2-dev libssl-dev libbz2-dev libjpeg-dev libpng-dev libwebp-dev libxpm-dev libfreetype6-dev libonig-dev libcurl4-openssl-dev libreadline-dev libzip-dev libtidy-dev libxslt1-dev libssl-dev libicu-dev

# Get the current username
USER=$(whoami)

mkdir /home/$USER/devops
sudo chown -R $USER:$USER /home/$USER/devops

# Install Flutter
git clone https://github.com/flutter/flutter.git /devops/flutter
export FLUTTER_HOME=/home/$USER/devops/flutter
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version

# Install Dart
wget https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-linux-x64-release.zip
unzip dartsdk-linux-x64-release.zip -d /home/$USER/devops/dart
export PATH="/home/$USER/devops/dart/bin:$PATH"
dart --version

# Install FVM
dart pub global activate fvm
mkdir /home/$USER/devops/fvm/
sudo chmod -R 666 /home/$USER/devops/fvm/
cp -r $HOME/.pub-cache /home/$USER/devops/
cp -r $HOME/.pub-cache /home/$USER/devops/fvm
export FVM_HOME=/home/$USER/devops/fvm
export PATH="/home/$USER/devops/fvm/.pub-cache/bin:$PATH"
fvm --version
mkdir /home/$USER/devops/fvm/versions
fvm config --cache-path /home/$USER/devops/fvm/versions
fvm install 3.3.1
fvm global 3.3.1
export FLUTTER_HOME=/home/$USER/devops/fvm/default/
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version

# Install NVM (Node Version Manager)
curl -o /home/$USER/devops/nvm-install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh
mkdir /home/$USER/devops/nvm
export NVM_DIR="/home/$USER/devops/nvm"  # Define the installation directory
bash /home/$USER/devops/nvm-install.sh  # Run the NVM installation script
export NVM_DIR="/home/$USER/devops/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion
nvm install 16.20.0
node -v

# Install Android SDK
wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
mkdir /home/$USER/devops/android-sdk/
unzip commandlinetools-linux-10406996_latest.zip -d /home/$USER/devops/android-sdk
mkdir /home/$USER/devops/android-sdk/cmdline-tools/latest
mv /home/$USER/devops/android-sdk/cmdline-tools/* /home/$USER/devops/android-sdk/cmdline-tools/latest/
export ANDROID_SDK_ROOT="/home/$USER/devops/android-sdk"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools"

# Install OpenJDK
wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/17.0.8+7/openlogic-openjdk-17.0.8+7-linux-x64.tar.gz
tar -xzvf openlogic-openjdk-17.0.8+7-linux-x64.tar.gz -C /home/$USER/devops/
export JAVA_HOME=/home/$USER/devops/openlogic-openjdk-17.0.8+7-linux-x64
export PATH="$JAVA_HOME/bin:$PATH"

# Accept SDK licenses
sdkmanager
sdkmanager "build-tools;33.0.0" "platform-tools"
sdkmanager --list | grep build-tools
sdkmanager --licenses

# Verify Java installation
javac

echo "Installation completed."
