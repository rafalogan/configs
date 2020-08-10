#!/usr/bin/env zsh

# Requires
export NVM_DIR=$HOME/.nvm
source $NVM_DIR/nvm.sh

# Variables

# EXEC
# Install the dependencies for iOS development
# Run the App Store and download Xcode.
# Start Xcode and you will be prompted to install Command Line Tools for Xcode.
if (! xcodebuild -version); then
  xcode-select --install &&
  Sudo xcode-select -s /Applications/Xcode.app/Contents/Developer;
else
  xcodebuild -version &&
  Sudo xcode-select -s /Applications/Xcode.app/Contents/Developer &&
  echo "Comand line já instalado, use [Software Update] para instalar atualizações"
fi

# Install Homebrew to simplify the installation process.
if ( ! brew ); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &&
  brew update
else
  # Update brew
  brew update
fi

# Install the latest Node.js or update
nvm i node

# Install the xcodeproj ruby gem with the following command.
sudo gem install xcodeproj

# Install CocoaPods
# Setup CocoaPods
sudo gem install cocoapods &&
Setup CocoaPods

# Install pip
sudo easy_install pip &&
# Install python six package
pip install six

# Install the dependencies for Android development.
# Set up JDK 8.
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8
# Set the JAVA_HOME system environment variable.
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Install the Android SDK.
# In the terminal, run the following command:
brew cask install android-sdk
# Next, run the following command to set the ANDROID_HOME system environment variable:
export ANDROID_HOME=/usr/local/share/android-sdk
# In addition, install all packages for the Android SDK Platform 28, Android SDK Build-Tools 28.0.3 or later,
# Android Support Repository, Google Repository and any other SDKs that you may need.
# You can alternatively use the following command, which will install all required packages.
$ANDROID_HOME/tools/bin/sdkmanager "tools" "emulator" "platform-tools" "platforms;android-28" "build-tools;28.0.3" "extras;android;m2repository" "extras;google;m2repository"

# Setup Android Emulators (AVD) by following the article
# 'https://docs.nativescript.org/angular/tooling/android-virtual-devices'
# Install the NativeScript CLI.
if ( ! tns --version ); then
  npm i -g nativescript;
else
  npm up -g nativescript;
fi
# Restart the command prompt.
echo "[nativescript] - configurado" && tns doctor;
