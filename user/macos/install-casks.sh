#!/usr/bin/env zsh
#Enviroment Variables
#Casks
CASKS=(
	4k-video-downloader
	amazon-music
	discord
	forticlient
	macvim
	postman
	signal
	vlc
	adobe-creative-cloud
	android-sdk
	docker
	google-chrome
	mysqlworkbench
	robo-3t
	twitch
	webtorrent
	adoptopenjdk8
	atom
	firefox-developer-edition
	iterm2
	phpstorm
	sequel-pro-nightly
	visual-studio-code
	zoom
)
#Exec
#Install Casks Start##
for cask in ${CASKS[*]}; do
	if (! brew list --cask $cask); then
		brew install --cask $cask &&
			echo "$cask instaled with success!"
	else
		brew upgrade --cask $cask &&
			echo "$cask upgrade with success!"
	fi
done
#Install Casks End##
