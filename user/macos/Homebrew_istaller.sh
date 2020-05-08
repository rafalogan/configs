#!/usr/bin/env zsh
# Variables
URL_HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/master/install"

# Install XCode or Update
# Install HomeBrew and update
if (! xcode-select -p ); then
  xcode-select --install && /usr/bin/ruby -e "$(curl -fsSL $URL_HOMEBREW_INSTALLER)";
else
  /usr/bin/ruby -e "$(curl -fsSL $URL_HOMEBREW_INSTALLER)";
fi
# Ending
echo "Homebrew foi instalado ou atualizado, \n
para que as modificações entrem em figor feche e abra o terminal novamente!"
