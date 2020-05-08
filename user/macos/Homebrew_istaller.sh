#!/usr/bin/env zsh
# Variables
URL_HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/master/install"

# Install XCode or Update
# Install HomeBrew and update
xcode-select --install && /usr/bin/ruby -e "$(curl -fsSL $URL_HOMEBREW_INSTALLER)" && brew update;
