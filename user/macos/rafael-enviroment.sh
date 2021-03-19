#!/usr/bin/env zsh
#Enviroment Variables
export NVM_DIR=$HOME/.nvm
source $NVM_DIR/nvm.sh
#Constats
URL_HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
URL_RVMIO="https://get.rvm.io"
URL_OH_MY_ZSH="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
URL_ZINIT="https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh"
URL_SPACESHIP_REPOSITORY="https://github.com/denysdovhan/spaceship-prompt.git"
CUSTOM_SPACESHIP_FOLDERS="$ZSH_CUSTOM/themes/spaceship-prompt"
KYES_RVMIO="409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
SPACESHIP_CONFIGS="$(cat "${0%/*}/../../assets/spaceshp-conf.sh")"
ZINIT_CONFIGS="$(cat "${0%/*}/../../assets/zint-conf.sh")"
AUTOLOAD_NVMRC="$(cat "${0%/*}/../../assets/autoload-nvmrc.sh")"
RVM_CONFIGS="$(cat "${0%/*}/../../assets/rvmrc-confi.sh")"
ZSHRC_PATH="$HOME/.zshrc"
GLOBAL_NODE_PLUGINS="${0%/*}/../node/globals.sh"
#formulas
FORMULAS=(
	awscli
	ffmpeg
	composer
	git
	gnupg
	jq
	nvm
	tree
	wget
)
#Casks
CASKS=(
	twitch
	robo-3t
	4k-video-downloader
	android-sdk
	firefox-developer-edition
	macvim
	sequel-pro-nightly
	webtorrent
	adobe-creative-cloud
	atom
	forticlient
	mysqlworkbench
	signal
	zoom
	adoptopenjdk8
	discord
	google-chrome
	phpstorm
	visual-studio-code
	amazon-music
	docker
	iterm2
	postman
	vlc
)
#Install XCode or Update
if (! xcode-select -p); then
	xcode-select --install &&
		sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
else
	sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
fi
# Install XCode or Update end
# Install HomeBrew
/bin/bash -c "$(curl -fsSL $URL_HOMEBREW_INSTALLER)"
if (! brew --version); then
	# Install HomeBrew
	/bin/bash -c "$(curl -fsSL $URL_HOMEBREW_INSTALLER)" &&
		brew update && brew upgrade && brew upgrade --casks --greedy &&
		echo "Homebrew was instaled with success!"
else
	# Update Brew
	brew update && brew upgrade && brew upgrade --casks --greedy &&
		echo "Homebrew was update with success!"
fi
# Install HomeBrew end
# Install FORMULAS
for formula in ${FORMULAS[*]}; do
	if (! $formula --version); then
		brew install $formula &&
			echo "$formula installed with success!"
	else
		brew upgrade $formula &&
			echo "$formula upgrade with success!"
	fi
done
# Install Casks
for cask in ${CASKS[*]}; do
	if (! brew list --cask $cask); then
		brew install --cask $cask &&
			echo "$cask instaled with success!"
	else
		brew upgrade --cask $cask &&
			echo "$cask upgrade with success!"
	fi
done
# Update Homebrew and clear trash
brew update && brew upgrade && brew upgrade --casks
# Zsh is installed
zsh --version
# Istall Oh My Zsh
sh -c "$(curl -fsSL $URL_OH_MY_ZSH)" &&
	## Clone the repository of Spaceship
	git clone "$URL_SPACESHIP_REPOSITORY" "$CUSTOM_SPACESHIP_FOLDERS" &&
	## Create sybolic links
	ln -s "$CUSTOM_SPACESHIP_FOLDERS/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" &&
	## Insert Spaceship Theme on .zshrc
	echo 'ZSH_THEME="spaceship"' >>"$ZSHRC_PATH" &&
	# Insert spaceship configuration
	echo "$SPACESHIP_CONFIGS" >>"$ZSHRC_PATH" &&
	## Install ZInit Plugin
	sh -c "$(curl -fsSL $URL_ZINIT)"
## Insert ZInit configuration
echo "$ZINIT_CONFIGS" >>"$ZSHRC_PATH"
# Inset nvmrc autlload
echo "$AUTOLOAD_NVMRC" >>"$ZSHRC_PATH"
# Install RVM
# Install keys
gpg2 --recv-keys "$KYES_RVMIO"
# Install RVM
\curl -sSL "$URL_RVMIO" | bash -s stable
# Insert Configs RVM
echo "$RVM_CONFIGS" >>"$ZSHRC_PATH"
# Install default Node
nvm install node
# Install Global plugins node
zsh "$GLOBAL_NODE_PLUGINS"
