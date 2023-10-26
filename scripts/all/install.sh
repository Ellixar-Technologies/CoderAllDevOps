#!/bin/bash

# Update package repositories
sudo apt update

# Install essential packages
sudo apt install -y curl git unzip wget build-essential libxml2-dev libssl-dev libbz2-dev libjpeg-dev libpng-dev libwebp-dev libxpm-dev libfreetype6-dev libonig-dev libcurl4-openssl-dev libreadline-dev libzip-dev libtidy-dev libxslt1-dev libssl-dev libicu-dev
sudo mkdir /devops/

# Install Flutter
git clone https://github.com/flutter/flutter.git /devops/flutter
export FLUTTER_HOME=/devops/flutter
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version

# Install Dart
wget https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-linux-x64-release.zip
unzip dartsdk-linux-x64-release.zip -d /devops/dart
export PATH="/devops/dart/bin:$PATH"
dart --version

# Install FVM
dart pub global activate fvm
sudo mkdir /devops/fvm/
cp -r $HOME/.pub-cache /devops/
cp -r $HOME/.pub-cache /devops/fvm
export FVM_HOME=/devops/fvm
export PATH="/devops/fvm/.pub-cache/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
fvm --version
sudo mkdir /devops/fvm/versions
fvm config --cache-path /devops/fvm/versions
fvm install 3.3.1
git config --global --add safe.directory /devops/fvm/versions/3.3.1
sudo chown -R $(whoami) /devops/
sudo chown -R $(whoami) /devops/fvm/versions/3.3.1/bin/cache/lockfile
dart pub global activate fvm
fvm global 3.3.1
export FLUTTER_HOME=/devops/fvm/default/
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version
dart pub global activate fvm


# Install NVM (Node Version Manager)
curl -o /devops/nvm-install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh
sudo mkdir /devops/nvm
export NVM_DIR="/devops/nvm"  # Define the installation directory
bash /devops/nvm-install.sh  # Run the NVM installation script
export NVM_DIR="/devops/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion
nvm install 16.16.0
node -v

# Install Android SDK
wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
sudo mkdir /devops/android-sdk/
unzip commandlinetools-linux-10406996_latest.zip -d /devops/android-sdk
sudo mkdir /devops/android-sdk/cmdline-tools/latest
mv /devops/android-sdk/cmdline-tools/* /devops/android-sdk/cmdline-tools/latest/
export ANDROID_SDK_ROOT="/devops/android-sdk"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools"

# Install OpenJDK
wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/17.0.8+7/openlogic-openjdk-17.0.8+7-linux-x64.tar.gz
tar -xzvf openlogic-openjdk-17.0.8+7-linux-x64.tar.gz -C /devops/
export JAVA_HOME=/devops/openlogic-openjdk-17.0.8+7-linux-x64
export PATH="$JAVA_HOME/bin:$PATH"

# Accept SDK licenses
sdkmanager
sdkmanager "build-tools;33.0.0" "platform-tools"
sdkmanager --list | grep build-tools
sdkmanager --licenses

# Verify Java installation
javac

echo "Installation completed."
