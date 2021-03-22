#!/usr/bin/env zsh
#Enviroment Variables
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
#Exec
##Install FORMULAS ##
for formula in ${FORMULAS[*]}; do
	if (! $formula --version); then
		brew install $formula &&
			echo "$formula installed with success!"
	else
		brew upgrade $formula &&
			echo "$formula upgrade with success!"
	fi
done
##Install FORMULAS End ##
