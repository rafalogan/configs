#!/usr/bin/env zsh
# Cosntats
BASE_DIR="$(pwd)"
DEV_SERVICES=(
	gnupg
	git
	composer
	wget
	nvm
	jq
)
APPS=(
  atom
  visual-studio-code
  phpstorm
  gitkraken
  mysqlworkbench
  docker
  postman
  google-chrome
  vlc
  adobe-creative-cloud
  amazon-music
  zoomus
)
APPS_DEV=(

)
# Install XCode or Update
if (! xcode-select -p); then
	xcode-select --install &&
		sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
else
	sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
fi
# Install XCode or Update end
# Install HomeBrew
if (! brew --version); then
	# Install HomeBrew
	/usr/bin/ruby -e "$(curl -fsSL $URL_HOMEBREW_INSTALLER)" &&
		brew update && brew upgrade && brew upgrade --casks --greedy &&
		echo "Homebrew was instaled with success!"
else
	# Update Brew
	brew update && brew upgrade && brew upgrade --casks --greedy &&
		echo "Homebrew was update with success!"
fi
# Install HomeBrew end
