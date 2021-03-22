#!/usr/bin/env zsh
#Enviroment Variables
SPACESHIP_CONFIGS="$(cat "${0%/*}/../../assets/spaceshp-conf.sh")"
#Execute
# Insert spaceship configuration
echo "$SPACESHIP_CONFIGS" >>"$ZSHRC_PATH" &&
echo "$SPACESHIP_CONFIGS -- insert"
