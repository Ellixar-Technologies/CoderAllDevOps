#!/bin/bash

# Define the user's home directory
USER_HOME=/home/ian

# Update package repositories
sudo apt update

# Install essential packages
sudo apt install -y curl git unzip wget build-essential libxml2-dev libssl-dev libbz2-dev libjpeg-dev libpng-dev libwebp-dev libxpm-dev libfreetype6-dev libonig-dev libcurl4-openssl-dev libreadline-dev libzip-dev libtidy-dev libxslt1-dev libssl-dev libicu-dev libxtst6 libxrender1 libfontconfig1 libxi6 libgtk-3-0
sudo mkdir $USER_HOME/devops/
sudo chown -R $(whoami) $USER_HOME/devops

# Install Flutter
sudo mkdir $USER_HOME/devops/flutter
git clone https://github.com/flutter/flutter.git $USER_HOME/devops/flutter
export FLUTTER_HOME=$USER_HOME/devops/flutter
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version

# Install Dart
wget https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-linux-x64-release.zip
unzip dartsdk-linux-x64-release.zip -d $USER_HOME/devops/dart
export PATH="$USER_HOME/devops/dart/bin:$PATH"
dart --version

# Install FVM
dart pub global activate fvm
sudo mkdir $USER_HOME/devops/fvm/
cp -r $HOME/.pub-cache $USER_HOME/devops/
cp -r $HOME/.pub-cache $USER_HOME/devops/fvm
export FVM_HOME=$USER_HOME/devops/fvm
export PATH="$USER_HOME/devops/fvm/.pub-cache/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
fvm --version
sudo mkdir $USER_HOME/devops/fvm/versions
fvm config --cache-path $USER_HOME/devops/fvm/versions

# Change ownership of the entire 'fvm' directory and its contents
sudo chown -R $(whoami) $USER_HOME/devops/fvm

fvm install 3.3.1
git config --global --add safe.directory $USER_HOME/devops/fvm/versions/3.3.1
sudo chown -R $(whoami) $USER_HOME/devops/fvm
sudo chown -R $(whoami) $USER_HOME/devops/fvm/versions/3.3.1  # Change the ownership to the current user
sudo chown -R $(whoami) $USER_HOME/devops/fvm/versions/3.3.1/bin/cache/lockfile
sudo chown -R $(whoami) $USER_HOME/devops/fvm/versions/3.3.1/version
# dart pub global activate fvm
fvm global 3.3.1
export FLUTTER_HOME=$USER_HOME/devops/fvm/default/
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version
# dart pub global activate fvm


# Install NVM (Node Version Manager)
curl -o $USER_HOME/devops/nvm-install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh
sudo mkdir $USER_HOME/devops/nvm
export NVM_DIR="$USER_HOME/devops/nvm"  # Define the installation directory
bash $USER_HOME/devops/nvm-install.sh  # Run the NVM installation script
export NVM_DIR="$USER_HOME/devops/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion
nvm install 16.16.0
node -v

# Install Android SDK
wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
sudo mkdir $USER_HOME/devops/android-sdk/
unzip commandlinetools-linux-10406996_latest.zip -d $USER_HOME/devops/android-sdk
sudo mkdir $USER_HOME/devops/android-sdk/cmdline-tools/latest
mv $USER_HOME/devops/android-sdk/cmdline-tools/* $USER_HOME/devops/android-sdk/cmdline-tools/latest/
export ANDROID_SDK_ROOT="$USER_HOME/devops/android-sdk"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools"

# Install OpenJDK
sudo mkdir $USER_HOME/devops/openlogic-openjdk-17.0.8+7-linux-x64
wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/17.0.8+7/openlogic-openjdk-17.0.8+7-linux-x64.tar.gz
tar -xzvf openlogic-openjdk-17.0.8+7-linux-x64.tar.gz -C $USER_HOME/devops/
export JAVA_HOME=$USER_HOME/devops/openlogic-openjdk-17.0.8+7-linux-x64
export PATH="$JAVA_HOME/bin:$PATH"

# Accept SDK licenses
sdkmanager
sdkmanager "build-tools;33.0.0" "platform-tools"
sdkmanager --list | grep build-tools
sdkmanager --licenses

# Verify Java installation
javac

# Install Android Studio
sudo add-apt-repository ppa:maarten-fonville/android-studio
sudo apt update
sudo apt install -y android-studio
ln -s /opt/android-studio/bin/studio.sh /usr/local/bin/studio

echo "Installation completed."
