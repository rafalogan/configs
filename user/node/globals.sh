#!/usr/bin/env zsh
# Variables
# To use commad nvm
export NVM_DIR=$HOME/.nvm
source $NVM_DIR/nvm.sh
# indirect plugins
GULP="gulp-cli"
TYPESCRIPT="typescript"
ANGULAR="@angular/cli"
VUE="@vue/cli"
NATIVESCIRPT="nativescript"
IONIC="@ionic/cli"
# Direct Plugins npm
DIRECT_PLUGINS=(
  pm2
  knex
  http-server
  ipt
	heroku
	cordova
)
# Constants
NATIVESCIRPT_ENV="${0%/*}/nativescript_env.sh"
# Update nmp and npx
npm i - g npm npx
# Install or update Gulp
if ( ! gulp --version ); then
    echo "Instalando - $GULP" && sudo npm i -g $GULP;
else
  echo "Atualizando - $GULP" && sudo npm up -g $GULP;
fi
# Install or update Typescript
if ( ! tsc --version ); then
    echo "Instalando - $TYPESCRIPT" && sudo npm i -g $TYPESCRIPT;
else
  echo "Atualizando - $TYPESCRIPT" && sudo npm up -g $TYPESCRIPT;
fi
# Install or update Angular/cli
if ( ! ng --versino ); then
  echo "Instalando - $ANGULAR" && sudo npm i -g $ANGULAR;
else
  echo "Atualizando - $ANGULAR" && sudo npm up -g $ANGULAR;
fi
# Install vue
if ( ! vue --version ); then
  echo "Instalando - $VUE" && sudo npm i -g $VUE;
else
  echo "Atualizando - $VUE" && sudo npm up -g $VUE;
fi
# Install vue
if ( ! ionic --version ); then
  echo "Instalando - $IONIC" && sudo npm i -g $IONIC;
else
  echo "Atualizando - $IONIC" && sudo npm up -g $IONIC;
fi
# Install or update plugins
for plugin in ${DIRECT_PLUGINS[*]}; do
  if ( ! $plugin --version ); then
    echo "Instalando - $plugin" && sudo npm i -g $plugin;
  else
    echo "Atualizando - $plugin" && sudo npm up -g $plugin;
  fi
done
#Install Nativescript
if ( ! tns --version ); then
  echo "Instalando - $NATIVESCIRPT"
  if ( zsh --version ); then
      zsh "$NATIVESCIRPT_ENV";
  fi
else
  echo "Atualizando - $NATIVESCIRPT" && sudo npm up -g $NATIVESCIRPT;
fi
#ending
sudo npm up -g &&
echo "Instalação finalizada com sucesso!"
